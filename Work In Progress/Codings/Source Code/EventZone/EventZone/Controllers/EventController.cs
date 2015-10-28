using EventZone.Helpers;
using EventZone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventZone.Controllers
{
    public class EventController : Controller
    {
        //
        // GET: /Event/
        private DatabaseHelpers dbhelp = new DatabaseHelpers();
        
        public ActionResult Index()
        {
            return View();
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
            User user= UserHelpers.GetCurrentUser(Session);
            Event evt = dbhelp.GetEventByID(id);
            if (evt == null)
            {
                return View("FailedLoadEvent");
            }
            ViewDetailEventModel viewDetail = new ViewDetailEventModel();
            
            viewDetail.eventId = evt.EventID;
            viewDetail.eventName = evt.EventName;
            viewDetail.eventAvatar = dbhelp.GetImageByID(evt.Avatar).ImageLink;
            viewDetail.eventDescription = evt.EventDescription;
            viewDetail.StartTime = evt.EventStartDate;
            viewDetail.EndTime = evt.EventEndDate;
            viewDetail.isOwningEvent = false;
            viewDetail.NumberLike = dbhelp.CountLike(evt.EventID);
            viewDetail.NumberDisLike = dbhelp.CountDisLike(evt.EventID);
            viewDetail.NumberFowllower = dbhelp.CountFollowerOfEvent(evt.EventID);
            viewDetail.eventLocation = dbhelp.GetEventLocation(evt.EventID);
            viewDetail.eventImage = dbhelp.GetEventImage(evt.EventID);
            viewDetail.eventVideo = dbhelp.GetEventVideo(evt.EventID);
            viewDetail.eventComment = dbhelp.GetListComment(evt.EventID);
            viewDetail.FindLike = new LikeDislike();
            viewDetail.FindLike.Type = EventZoneConstants.NotRate;
            viewDetail.FindLike.EventID = evt.EventID;
               if(user!=null){
                   viewDetail.isOwningEvent = dbhelp.IsEventOwnedByUser(evt.EventID, user.UserID);
                   viewDetail.FindLike = dbhelp.FindLike(user.UserID,evt.EventID);
                   if (viewDetail.FindLike == null) {
                       viewDetail.FindLike = new LikeDislike();
                       viewDetail.FindLike.Type = EventZoneConstants.NotRate;
                   }
                   viewDetail.isFollowing = dbhelp.IsFollowingEvent(user.UserID, evt.EventID);
               }
            viewDetail.Privacy= evt.Privacy;
            if (TempData["EventDetailTask"] == null) {
                ViewData["EventDetailTask"] = "EventDetail";
                if (user == null  || dbhelp.GetAuthorEvent(evt.EventID).UserID != user.UserID)
                {
                    dbhelp.AddView(evt.EventID);
                }
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
        public ActionResult Comment(long EventId,long CommentContent) {
            

            return PartialView("_CommentPartial");
        }                                                                                                                                                                                                  
    }
}
