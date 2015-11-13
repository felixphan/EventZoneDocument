using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.YouTube.v3;
using Google.Apis.YouTube.v3.Data;
using Microsoft.Ajax.Utilities;
using Video = EventZone.Models.Video;
using Amazon.S3;
using Newtonsoft.Json;

namespace EventZone.Controllers
{
    public class EventController : Controller
    {
        private readonly EventZoneEntities db = new EventZoneEntities();
        //
        // GET: /Event
        // GET: Event
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryId", "CategoryName");
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateEvent(CreateEventModel model)
        {
            if (ModelState.IsValid)
            {

                List<Location> locationList = model.Location;
                bool recursiveCheck = false;
                while (recursiveCheck == false)
                {
                    int lastRemove = 0;
                    for (int i = 0; i < locationList.Count; i++)
                    {
                        if (locationList[i].LocationName.Equals("Remove Location"))
                            lastRemove = i;
                    }
                    if (lastRemove != 0)
                    {
                        locationList.RemoveAt(lastRemove);
                    }
                    else
                        break;
                }
                var locationId = LocationHelpers.Instance.GetLocationIdOfEvent(locationList);

                //Adding new event to database
                var newEvent = EventDatabaseHelper.Instance.AddNewEvent(model, UserHelpers.GetCurrentUser(Session).UserID.ToString());

                //Adding Rank to Database -- 

                //Insert to Event Place
                var listEventPlaces = EventDatabaseHelper.Instance.AddEventPlace(locationId, newEvent);

                // Create Video if it is live event
                if (model.IsLive)
                {
                    var viewDataResult = EventDatabaseHelper.Instance.AddLiveVideo(model, locationList, listEventPlaces);
                    if (viewDataResult.Length != 1)
                    {
                        ViewData["StreamName"] = viewDataResult[0];
                        ViewData["PrimaryServerURL"] = viewDataResult[1];
                        ViewData["BackupServerURL"] = viewDataResult[2];
                        ViewData["YoutubeURL"] = viewDataResult[3];
                    }
                    else
                    {
                        return View("FailedCreateEvent");
                    }
                }
                return RedirectToAction("Details", "Event", new { id = newEvent.EventID });
            }
            // If we got this far, something failed, redisplay form
            return View("FailedCreateEvent");
        }

        private async Task<string[]> Run(String broadcastTitle, DateTime startTime, DateTime endTime, String quality, int privacyYoutube)
        {

            UserCredential credential = null;

            String path = Path.Combine(HttpRuntime.AppDomainAppPath, "Controllers/client_secrets_for_YoutubeAPI.json");
            using (var stream = new FileStream(path, FileMode.Open, FileAccess.Read))
            {
                credential = await GoogleWebAuthorizationBroker.AuthorizeAsync(
                    GoogleClientSecrets.Load(stream).Secrets,
                    // This OAuth 2.0 access scope allows an application to upload files to the
                    // authenticated user's YouTube channel, but doesn't allow other types of access.
                    new[] { YouTubeService.Scope.Youtube },
                    Environment.UserName,
                    CancellationToken.None
                    );

            }

            var youtubeService = new YouTubeService(new BaseClientService.Initializer()
            {
                HttpClientInitializer = credential,
                ApplicationName = Assembly.GetExecutingAssembly().GetName().Name
            });

            //Set Snippet
            LiveBroadcastSnippet broadcastSnippet = new LiveBroadcastSnippet();
            broadcastSnippet.Title = broadcastTitle;
            if (startTime.CompareTo(DateTime.Now) < 0)
            {
                startTime = DateTime.Now;
            }
            broadcastSnippet.ScheduledStartTime = startTime;
            broadcastSnippet.ScheduledEndTime = endTime;

            // Set the broadcast's privacy status to "private". See:
            // https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#status.privacyStatus
            LiveBroadcastStatus status = new LiveBroadcastStatus();
            if (privacyYoutube == 0)
            {
                status.PrivacyStatus = "public";
            }
            else if (privacyYoutube == 1)
            {
                status.PrivacyStatus = "unlisted";
            }
            else
            {
                status.PrivacyStatus = "private";
            }

            //Set LiveBroadcast
            LiveBroadcast broadcast = new LiveBroadcast();
            broadcast.Kind = "youtube#liveBroadcast";
            broadcast.Snippet = broadcastSnippet;
            broadcast.Status = status;
            LiveBroadcastsResource.InsertRequest liveBroadcastInsert = youtubeService.LiveBroadcasts.Insert(broadcast, "snippet,status");
            LiveBroadcast returnBroadcast = liveBroadcastInsert.Execute();

            //Set LiveStream Snippet
            LiveStreamSnippet streamSnippet = new LiveStreamSnippet();
            streamSnippet.Title = broadcastTitle + "Stream Title";
            CdnSettings cdnSettings = new CdnSettings();
            cdnSettings.Format = quality;
            cdnSettings.IngestionType = "rtmp";

            //Set LiveStream
            LiveStream streamLive = new LiveStream();
            streamLive.Kind = "youtube#liveStream";
            streamLive.Snippet = streamSnippet;
            streamLive.Cdn = cdnSettings;
            LiveStream returnLiveStream = youtubeService.LiveStreams.Insert(streamLive, "snippet,cdn").Execute();
            LiveBroadcastsResource.BindRequest liveBroadcastBind = youtubeService.LiveBroadcasts.Bind(
                returnBroadcast.Id, "id,contentDetails");
            liveBroadcastBind.StreamId = returnLiveStream.Id;
            returnBroadcast = liveBroadcastBind.Execute();
            //Return Value
            String streamName = returnLiveStream.Cdn.IngestionInfo.StreamName;
            String primaryServerUrl = returnLiveStream.Cdn.IngestionInfo.IngestionAddress;
            String backupServerUrl = returnLiveStream.Cdn.IngestionInfo.BackupIngestionAddress;
            String youtubeUrl = "https://www.youtube.com/watch?v=" + returnBroadcast.Id;
            string[] result = new string[] { streamName, primaryServerUrl, backupServerUrl, youtubeUrl };

            return result;
        }
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                TempData["errorTitle"] = "Failed to load event";
                TempData["errorMessage"] = "Failed to load event";
                return RedirectToAction("Index", "Home");

            }
            User user = UserHelpers.GetCurrentUser(Session);
            if (user == null)
            {
                if (Request.Cookies["userName"] != null && Request.Cookies["password"] != null)
                {
                    string userName = Request.Cookies["userName"].Value;
                    string password = Request.Cookies["password"].Value;
                    if (UserDatabaseHelper.Instance.ValidateUser(userName, password))
                    {
                        user = UserDatabaseHelper.Instance.GetUserByUserName(userName);
                        if (UserDatabaseHelper.Instance.isLookedUser(user.UserName))
                        {
                            TempData["errorTitle"] = "Locked User";
                            TempData["errorMessage"] = "Your account is locked! Please contact with our support";

                            return RedirectToAction("Index", "Home");
                        }
                        UserHelpers.SetCurrentUser(Session, user);
                    }
                }
            }

            Event evt = EventDatabaseHelper.Instance.GetEventByID(id);
            if (evt == null)
            {
                return View("FailedLoadEvent");
            }
            ViewDetailEventModel viewDetail = new ViewDetailEventModel();

            viewDetail.eventId = evt.EventID;
            viewDetail.eventName = evt.EventName;

            viewDetail.eventAvatar = EventDatabaseHelper.Instance.GetImageByID(evt.Avatar).ImageLink;
             viewDetail.numberView = evt.View;
            
            
            viewDetail.eventDescription = evt.EventDescription;
            viewDetail.StartTime = evt.EventStartDate;
            viewDetail.EndTime = evt.EventEndDate;
            viewDetail.isOwningEvent = false;
            viewDetail.NumberLike = EventDatabaseHelper.Instance.CountLike(evt.EventID);
            viewDetail.NumberDisLike = EventDatabaseHelper.Instance.CountDisLike(evt.EventID);
            viewDetail.NumberFowllower = EventDatabaseHelper.Instance.CountFollowerOfEvent(evt.EventID);
            viewDetail.eventLocation = EventDatabaseHelper.Instance.GetEventLocation(evt.EventID);
            viewDetail.eventImage = EventDatabaseHelper.Instance.GetEventImage(evt.EventID);
            viewDetail.eventVideo = EventDatabaseHelper.Instance.GetEventVideo(evt.EventID);
            viewDetail.eventComment = EventDatabaseHelper.Instance.GetListComment(evt.EventID);
            viewDetail.Category = EventDatabaseHelper.Instance.GetEventCategory(evt.EventID);
            viewDetail.FindLike = new LikeDislike();
            viewDetail.FindLike.Type = EventZoneConstants.NotRate;
            viewDetail.FindLike.EventID = evt.EventID;
            if (user != null)
            {
                viewDetail.isOwningEvent = EventDatabaseHelper.Instance.IsEventOwnedByUser(evt.EventID, user.UserID);
                viewDetail.FindLike = UserDatabaseHelper.Instance.FindLike(user.UserID, evt.EventID);
                if (viewDetail.FindLike == null)
                {
                    viewDetail.FindLike = new LikeDislike();
                    viewDetail.FindLike.Type = EventZoneConstants.NotRate;
                }
                viewDetail.isFollowing = UserDatabaseHelper.Instance.IsFollowingEvent(user.UserID, evt.EventID);
            }
            viewDetail.Privacy = evt.Privacy;
            if (TempData["EventDetailTask"] == null)
            {
                ViewData["EventDetailTask"] = "EventDetail";
                if (user == null || EventDatabaseHelper.Instance.GetAuthorEvent(evt.EventID).UserID != user.UserID)
                {
                    EventDatabaseHelper.Instance.AddViewEvent(evt.EventID);
                    viewDetail.numberView = evt.View;
                }
                return View(viewDetail);
            }
            else
            {
                ViewData["EventDetailTask"] = "EditEvent";
                return View(viewDetail);
            }
        }

        public ActionResult ImageUpload(HttpPostedFileBase file, long eventID)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            if (user == null)
            {
                if (Request.Cookies["userName"] != null && Request.Cookies["password"] != null)
                {
                    string userName = Request.Cookies["userName"].Value;
                    string password = Request.Cookies["password"].Value;
                    if (UserDatabaseHelper.Instance.ValidateUser(userName, password))
                    {
                        user = UserDatabaseHelper.Instance.GetUserByUserName(userName);
                        if (UserDatabaseHelper.Instance.isLookedUser(user.UserName))
                        {
                            TempData["errorTitle"] = "Locked User";
                            TempData["errorMessage"] = "Your account is locked! Please contact with our support";

                            return RedirectToAction("Index", "Home");
                        }
                        UserHelpers.SetCurrentUser(Session, user);
                    }
                    TempData["errorTitle"] = "Require Signin";
                    TempData["errorMessage"] = "Ops.. It's look like you are current is not signed in system! Please sign in first!";
                    return RedirectToAction("Details", "Event", new { id = eventID });
                }
            }

            if (user == null) {
                TempData["ImageUploadError"] = "You have to log in to use this feature..";
                
            }
            Image photo = new Image();
            if (file != null)
            {
                string[] whiteListedExt = { ".jpg", ".gif", ".png", ".tiff" };
                Stream stream = file.InputStream;
                string extension = Path.GetExtension(file.FileName);
                if (whiteListedExt.Contains(extension))
                {
                    string pic = Guid.NewGuid()+ eventID.ToString() + extension;
                    using (AmazonS3Client s3Client = new AmazonS3Client(Amazon.RegionEndpoint.USWest2))
                        EventZoneUtility.FileUploadToS3("eventzone", pic, stream, true, s3Client);
                    Image image = new Image();
                    image.ImageLink = "https://s3-us-west-2.amazonaws.com/eventzone/"+pic;
                    image.UserID = user.UserID;
                    image.UploadDate = DateTime.Today;
                  
                    if (EventDatabaseHelper.Instance.AddImageToEvent(image,eventID))
                    {
                        TempData["ImageUploadError"] = null; // success
                    }
                    TempData["ImageUploadError"] = "Something wrong.."; // success 
                }
                else
                {
                    TempData["ImageUploadError"] = "File is not supported! Please select an image file";
                }
            }
            else
            {
                TempData["ImageUploadError"] = "Your must select a file to upload";
            }
            return RedirectToAction("Details", "Event",new {id=eventID});
        }
         public ActionResult Comment(int eventID, string commentContent)
        {
            List<EventZone.Models.Comment> listComment = EventDatabaseHelper.Instance.GetListComment(eventID);
            CommentViewModel comment = new CommentViewModel { eventID = eventID, listComment = listComment };
            User user = UserHelpers.GetCurrentUser(Session);
            if (user == null)
            {
                if (Request.Cookies["userName"] != null && Request.Cookies["password"] != null)
                {
                    string userName = Request.Cookies["userName"].Value;
                    string password = Request.Cookies["password"].Value;
                    if (UserDatabaseHelper.Instance.ValidateUser(userName, password))
                    {
                        user = UserDatabaseHelper.Instance.GetUserByUserName(userName);
                        if (UserDatabaseHelper.Instance.isLookedUser(user.UserName))
                        {
                            return Json(new
                            {
                                state=0,
                                title="Locked User",
                                message = "Your account is locked! Please contact with our support",
                            });
                        }
                        UserHelpers.SetCurrentUser(Session, user);
                    }
                }
            }
            else if (user != null)
            {
               EventZone.Models.Comment newcmt= EventDatabaseHelper.Instance.AddCommentToEvent(eventID, user.UserID, commentContent);
                if (newcmt != null)
                {
                    string dataAppend = " <div class='d_each_event'>"
                        + "<div class='d_ee_ava_user'>"
                         + "   <div class='d_ee_ava'>"
                           + "    <img src=" + EventDatabaseHelper.Instance.GetImageByID(UserDatabaseHelper.Instance.GetUserByID(newcmt.UserID).Avartar).ImageLink + ">"
                            + "</div>"
                            + "<div class='d_ee_user'>"
                              + "<i>" + UserDatabaseHelper.Instance.GetUserDisplayName(newcmt.UserID) + "</i>"
                           + " </div>"
                           + " <div class='d_ee_time'>"
                           + " <i>" + newcmt.DateIssue + "</i>"
                           + " </div>"
                        + "</div>"
                        + "<div class='d_ee_content'>"
                        + newcmt.CommentContent
                        + "</div>"
                   + " </div>";

                    return Json(new
                    {
                        state = 1,
                        dataAppend = dataAppend
                    });
                };
            }
            return Json(new
            {
                state = 0,
                title = "Failed!",
                message = "Ops.. Somthing went wrong. Please try again later",
            });

        }
         public ActionResult EventImage(long? id) {
             List<Image> listImage = EventDatabaseHelper.Instance.GetEventImage(id);
             return PartialView("_EventImage", listImage);
         }
         public ActionResult UploadImageEvent(HttpPostedFileBase eventImage, string eventId) {
             long eventID = long.Parse(eventId);
             User user = UserHelpers.GetCurrentUser(Session);
             if (user == null)
             {
                 TempData["errorTitle"] = "Require Signin";
                 TempData["errorMessage"] = "Ops.. It's look like you are current is not signed in system! Please sign in first!";
                 return RedirectToAction("Index", "Home");
             }
             else
             {
                 List<Image> listImage = EventDatabaseHelper.Instance.GetEventImage(eventID);
                 Image photo = new Image();
                 try
                 {
                     if (eventImage != null)
                     {
                         string[] whiteListedExt = { ".jpg", ".gif", ".png", ".tiff" };
                         Stream stream = eventImage.InputStream;
                         string extension = Path.GetExtension(eventImage.FileName);
                         if (whiteListedExt.Contains(extension))
                         {
                             string pic = Guid.NewGuid() + user.UserID.ToString() + extension;
                             using (AmazonS3Client s3Client = new AmazonS3Client(Amazon.RegionEndpoint.USWest2))
                                 EventZoneUtility.FileUploadToS3("eventzone", pic, stream, true, s3Client);
                             Image image = new Image();
                             image.ImageLink = "https://s3-us-west-2.amazonaws.com/eventzone/" + pic;
                             image.UserID = user.UserID;
                             image.UploadDate = DateTime.Today;
                             if (EventDatabaseHelper.Instance.AddImageToEvent(image,eventID))
                             {
                                 TempData["errorTitle"] = null;
                                 TempData["errorMessage"] = null;
                                 listImage = EventDatabaseHelper.Instance.GetEventImage(eventID);
                                 return PartialView("_ImagePartial",listImage);
                             }
                             else
                             {
                                 TempData["errorTitle"] = "Database Error";
                                 TempData["errorMessage"] = "Ops... Some error is ocurred while we save to database! Please try again later!";
                                 
                                 return PartialView("_ImagePartial", listImage);
                             }

                         }
                         else
                         {
                             TempData["errorTitle"] = "Database Error";
                             TempData["errorMessage"] = "Ops... Some error is ocurred while we save to database! Please try again later!";
                             
                             return PartialView("_ImagePartial", listImage);
                         }
                     }
                     else
                     {
                         TempData["errorTitle"] = "Not select file";
                         TempData["errorMessage"] = "It's look like you fogot select an image! Are you getting old?";
                  
                         return PartialView("_ImagePartial", listImage);
                     }
                 }
                 catch
                 {
                     TempData["errorTitle"] = "Unknow Error";
                     TempData["errorMessage"] = "Oops..Something wrong is happened! Please try again later...";
                     
                     return PartialView("_ImagePartial", listImage);
                 }
             }
         }
    }
}