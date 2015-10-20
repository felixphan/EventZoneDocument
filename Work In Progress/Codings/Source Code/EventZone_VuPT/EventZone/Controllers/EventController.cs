using EventZone.Helpers;
using EventZone.Models;
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
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.YouTube.v3;
using Google.Apis.YouTube.v3.Data;
using Channel = EventZone.Models.Channel;

namespace EventZone.Controllers
{
    public class EventController : Controller
    {
        private EventZoneEntities db = new EventZoneEntities();
        //
        // GET: /Event/
        private DatabaseHelpers dbhelp = new DatabaseHelpers();
        
        public ActionResult Index()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            return View();
        }
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> CreateEvent(CreateEventModel model)
        {
            if (ModelState.IsValid)
            {
                String LocationName = model.LocationName;
                String Langitude = model.Langitude;
                String Longitude = model.Longitude;
                String[] locationList = Regex.Split(LocationName, ";");
                String[] langitudeList = Regex.Split(Langitude, ";");
                String[] longitudeList = Regex.Split(Longitude, ";");
                List<double> locationID = new List<double>();
                for (int i = 0; i < locationList.Length-1; i++)
                {
                    double tmp = dbhelp.FindLocationByAllData(double.Parse(longitudeList[i]),
                        double.Parse(langitudeList[i]),
                        locationList[i]);
                    if (
                        tmp == -1)
                    {
                        Location newLocation = new Location();
                        newLocation.LocationName = locationList[i];
                        newLocation.Latitude = double.Parse(langitudeList[i]);
                        newLocation.Longitude = double.Parse(longitudeList[i]);
                        db.Locations.Add(newLocation);
                        db.SaveChanges();
                        tmp = dbhelp.FindLocationByAllData(double.Parse(longitudeList[i]),
                        double.Parse(langitudeList[i]),
                        locationList[i]);
                    }
                    locationID.Add(tmp);
                }
                Event newEvent = new Event();
                newEvent.EventName = model.Title;
                Channel userChannel = db.Channels.ToList().Find(c=>c.UserID.Equals(long.Parse(Session["UserId"].ToString())));
                newEvent.ChannelID = userChannel.ChannelID;
                newEvent.EventStartDate = model.StartTime;
                newEvent.EventEndDate = model.EndTime;
                newEvent.EventDescription = model.Description;
                newEvent.EventRegisterDate = DateTime.Now;
                newEvent.View = 0;
                newEvent.CategoryID = model.CategoryID;
                newEvent.Privacy = model.Privacy;
                newEvent.AvatarLink = null;
                newEvent.EditBy = long.Parse(Session["UserId"].ToString());
                newEvent.EditTime = DateTime.Now;
                newEvent.EditContent = null;
                newEvent.Status = true;
                 // insert Event to Database
                 db.Events.Add(newEvent);
                 db.SaveChanges();

                //Insert to Event Place
                 for (int i = 0; i < locationID.Count; i++)
                 {
                     EventPlace newEventPlace = new EventPlace();
                     newEventPlace.LocationID = (long)locationID[i];
                     newEventPlace.EventID = newEvent.EventID;
                     db.EventPlaces.Add(newEventPlace);
                     db.SaveChanges();
                 }

                if (model.IsLive)
                {
                    string[] ViewDataResult = new EventController().Run(model.Title,model.StartTime,model.EndTime,model.Resolution,model.PrivacyYoutube).Result;
                    ViewData["StreamName"] = ViewDataResult[0];
                    ViewData["PrimaryServerURL"] = ViewDataResult[1];
                    ViewData["BackupServerURL"] = ViewDataResult[2];
                    ViewData["YoutubeURL"] = ViewDataResult[3];
                }
                return RedirectToAction("Details", "Event", newEvent.EventID);

            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("Create","Event");
        }
        private async Task<string[]> Run(String broadcastTitle, DateTime startTime, DateTime endTime, String resolution, String privacyYoutube)
        {
            UserCredential credential;
            String path = Path.Combine(HttpRuntime.AppDomainAppPath, "Controllers/client_secrets.json");
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

            LiveBroadcastSnippet broadcastSnippet = new LiveBroadcastSnippet();
            broadcastSnippet.Title = broadcastTitle;
            broadcastSnippet.ScheduledStartTime = startTime;
            broadcastSnippet.ScheduledEndTime = endTime;
            // Set the broadcast's privacy status to "private". See:
            // https://developers.google.com/youtube/v3/live/docs/liveBroadcasts#status.privacyStatus
            LiveBroadcastStatus status = new LiveBroadcastStatus();
            status.PrivacyStatus = privacyYoutube.ToLower();
            LiveBroadcast broadcast = new LiveBroadcast();
            broadcast.Kind = "youtube#liveBroadcast";
            broadcast.Snippet = broadcastSnippet;
            broadcast.Status = status;
            LiveBroadcastsResource.InsertRequest liveBroadcastInsert = youtubeService.LiveBroadcasts.Insert(broadcast, "snippet,status");
            LiveBroadcast returnBroadcast = liveBroadcastInsert.Execute();

            LiveStreamSnippet streamSnippet = new LiveStreamSnippet();
            streamSnippet.Title = broadcastTitle + "Stream Title";
            CdnSettings cdnSettings = new CdnSettings();
            cdnSettings.Format = resolution.Trim();
            cdnSettings.IngestionType = "rtmp";

            LiveStream streamLive = new LiveStream();
            streamLive.Kind = "youtube#liveStream";
            streamLive.Snippet = streamSnippet;
            streamLive.Cdn = cdnSettings;

            LiveStream returnLiveStream = youtubeService.LiveStreams.Insert(streamLive, "snippet,cdn").Execute();


            LiveBroadcastsResource.BindRequest liveBroadcastBind = youtubeService.LiveBroadcasts.Bind(
                returnBroadcast.Id, "id,contentDetails");
            liveBroadcastBind.StreamId = returnLiveStream.Id;
            returnBroadcast = liveBroadcastBind.Execute();

            String StreamName = returnLiveStream.Cdn.IngestionInfo.StreamName;
            String PrimaryServerURL = returnLiveStream.Cdn.IngestionInfo.IngestionAddress;
            String BackupServerURL = returnLiveStream.Cdn.IngestionInfo.BackupIngestionAddress;
            String YoutubeURL = "http://youtube.com/embed/" + returnBroadcast.Id + "@output=embed";
            string[] result = new string[] { StreamName, PrimaryServerURL, BackupServerURL, YoutubeURL };
            return result;
        }
        public ActionResult Edit(long? id) {
            User currUser= UserHelpers.GetCurrentUser(Session);
            if (currUser == null) {
                return View("_PermissionDeny");
            }
            User eventAuthor = dbhelp.GetAuthorEvent(id);
            if (eventAuthor == null || currUser.UserID != eventAuthor.UserID) {
                return View("_PermissionDeny");
            }
            TempData["EventDetailTask"] = "EditEvent";
            return RedirectToAction("Details", "Event", new {id});
        }
        //
        // GET: /Event/Details/5
        public ActionResult Details(long? id)
        {
            Event evt = dbhelp.GetEventByID(id);
            if (evt == null)
            {
                return View("FailedLoadEvent");
            }
            ViewDetailEventModel viewDetail = new ViewDetailEventModel();
            
            viewDetail.eventId = evt.EventID;
            viewDetail.eventName = evt.EventName;
            viewDetail.eventAvatar = evt.AvatarLink;
            viewDetail.eventDescription = evt.EventDescription;
            viewDetail.StartTime = evt.EventStartDate;
            viewDetail.EndTime = evt.EventEndDate;
            viewDetail.eventLocation = dbhelp.GetEventLocation(evt.EventID);
            viewDetail.eventImage = dbhelp.GetEventImage(evt.EventID);
            viewDetail.eventVideo = dbhelp.GetEventVideo(evt.EventID);
            viewDetail.Privacy= evt.Privacy;



            if (TempData["EventDetailTask"] == null) {
                ViewData["EventDetailTask"] = "EventDetail";
                return View(viewDetail);
            }
            else 
            { 
                ViewData["EventDetailTask"] = "EditEvent";
                return View(viewDetail);
            }
        }

        //
        // GET: /Event/Create
        public ActionResult EditEvent(ViewDetailEventModel viewEvent)
        {
            TempData["EventDetailTask"] = "EditEvent";
            return RedirectToAction("Details", new { id=viewEvent.eventId });
        }

        //
        // POST: /Event/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
        //
        // GET: /Event/Delete/5
        public ActionResult Delete(long? id)
        {
            
            return View();
        }

        //
        // POST: /Event/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
