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
