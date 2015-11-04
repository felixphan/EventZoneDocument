using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using System.Web;
using System.IO;
using Amazon.S3;

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
                var LocationName = model.LocationName;
                var lattitude = model.Lattitude;
                var Longitude = model.Longitude;
                var locationList = Regex.Split(LocationName, ";");
                var lattitudeList = Regex.Split(lattitude, ";");
                var longitudeList = Regex.Split(Longitude, ";");
                var locationID = new List<double>();
                for (var i = 0; i < locationList.Length - 1; i++)
                {
                    double tmp = LocationHelpers.Instance.FindLocationByAllData(double.Parse(longitudeList[i]),
                        double.Parse(lattitudeList[i]),
                        locationList[i]);
                    if (
                        tmp == -1)
                    {
                        var newLocation = new Location();
                        newLocation.LocationName = locationList[i];
                        newLocation.Latitude = double.Parse(lattitudeList[i]);
                        newLocation.Longitude = double.Parse(longitudeList[i]);
                        db.Locations.Add(newLocation);
                        db.SaveChanges();
                        tmp = LocationHelpers.Instance.FindLocationByAllData(double.Parse(longitudeList[i]),
                            double.Parse(lattitudeList[i]),
                            locationList[i]);
                    }
                    locationID.Add(tmp);
                }
                var newEvent = new Event();
                newEvent.EventName = model.Title;
                var userChannel =
                    db.Channels.ToList().Find(c => c.UserID.Equals(long.Parse(Session["UserId"].ToString())));
                newEvent.ChannelID = userChannel.ChannelID;
                newEvent.EventStartDate = model.StartTime;
                newEvent.EventEndDate = model.EndTime;
                newEvent.EventDescription = model.Description;
                newEvent.EventRegisterDate = DateTime.Now;
                newEvent.View = 0;
                newEvent.CategoryID = model.CategoryID;
                newEvent.Privacy = model.Privacy;
                newEvent.Avatar = null;
                newEvent.EditBy = long.Parse(Session["UserId"].ToString());
                newEvent.EditTime = DateTime.Now;
                newEvent.EditContent = null;
                newEvent.Status = true;
                // insert Event to Database
                db.Events.Add(newEvent);
                db.SaveChanges();

                //Insert to Event Place
                for (var i = 0; i < locationID.Count; i++)
                {
                    var newEventPlace = new EventPlace();
                    newEventPlace.LocationID = (long) locationID[i];
                    newEventPlace.EventID = newEvent.EventID;
                    db.EventPlaces.Add(newEventPlace);
                    db.SaveChanges();
                }

                /*if (model.IsLive)
                {
                    string[] ViewDataResult =
                        new EventController().Run(model.Title, model.StartTime, model.EndTime, model.Resolution,
                            model.PrivacyYoutube).Result;
                    ViewData["StreamName"] = ViewDataResult[0];
                    ViewData["PrimaryServerURL"] = ViewDataResult[1];
                    ViewData["BackupServerURL"] = ViewDataResult[2];
                    ViewData["YoutubeURL"] = ViewDataResult[3];
                }*/
                return RedirectToAction("Details", "Event", new {id = newEvent.EventID});
                //return RedirectToAction("Index", "Home");
            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("Create", "Event");
        }

        public ActionResult Details(long? id)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Event evt = EventDatabaseHelper.Instance.GetEventByID(id);
            if (evt == null)
            {
                return View("FailedLoadEvent");
            }
            ViewDetailEventModel viewDetail = new ViewDetailEventModel();

            viewDetail.eventId = evt.EventID;
            viewDetail.eventName = evt.EventName;
            if (viewDetail.eventAvatar != null)
            {
                viewDetail.eventAvatar = EventDatabaseHelper.Instance.GetImageByID(evt.Avatar).ImageLink;
            }
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
                    image.EventID = eventID;
                    image.ImageLink = pic;




                    TempData["ImageUploadError"] = null; // success
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
            return RedirectToAction("Details", "Event",db.Events.Find(eventID));
        }
    }
}