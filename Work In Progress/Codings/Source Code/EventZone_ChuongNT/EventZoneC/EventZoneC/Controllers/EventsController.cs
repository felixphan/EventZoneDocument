using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using EventZoneC.Models;

namespace EventZoneC.Controllers
{
    public class EventsController : Controller
    {
        private EventZoneEntities4 db = new EventZoneEntities4();

        // GET: Events
        public ActionResult ManageEvents()
        {
            var events = db.Events.Include(e => e.Category).Include(e => e.Channel);
            return View(events.ToList());
        }
        public ActionResult Lock(int EventID, long AdminID)
        {



            List<Event> listEvent = new List<Event>();
            var eventChange = db.Events.Include(u => u.EventFollows);
            eventChange = eventChange.Where(u => u.EventID == EventID);
            listEvent = eventChange.ToList();
            TrackingEvent track = new TrackingEvent();
            track.ActorID = AdminID;
            track.ReceiverID = EventID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3

            track.ActionTime = DateTime.Now;

            if (eventChange != null)
            {
                if (listEvent[0].Status == true)
                {
                    listEvent[0].Status = false;
                    track.ActionID = 1;
                    db.TrackingEvents.Add(track);
                }

                else
                {
                    listEvent[0].Status = true;
                    track.ActionID = 1;
                    db.TrackingEvents.Add(track);
                }
                // db.Entry(userChange).State = EntityState.Modified;
                db.SaveChanges();


            }
            eventChange = db.Events.Include(e=>e.Reports);

            return View("ManageEvents", eventChange);
        }
        
        public ActionResult SearchEvent(string searchString, string userName, string categoryName)
        {
            var events = db.Events.Include(e => e.Category).Include(e => e.Channel);
          
            if (String.IsNullOrEmpty(searchString)==false&&String.IsNullOrEmpty(userName)==false)
            {
               
                 events = events.Where(e =>e.EventName.Contains(searchString)&& e.Channel.User.UserName.Equals(userName));
                     //)&& e.Category.CategoryName.Equals(categoryName));
             
            }else
            {
                if (String.IsNullOrEmpty(searchString) == true && String.IsNullOrEmpty(userName) == false)
                {
                    events = events.Where(e => e.Channel.User.UserName.Equals(userName));
                }
                else
                {
                    if (String.IsNullOrEmpty(searchString) == false && String.IsNullOrEmpty(userName) == true)
                        events = events.Where(e => e.EventName.Contains(searchString));
                    else
                        events = events.Where(e => e.Category.CategoryName.Equals(categoryName));
                }
                  
            }
            return View("ManageEvents",events.ToList());
        }
        // GET: Events/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // GET: Events/Create
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ViewBag.ChannelID = new SelectList(db.Channels, "ChannelID", "ChannelName");
            return View();
        }

        // POST: Events/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EventID,ChannelID,EventName,EventStartDate,EventEndDate,EventDescription,EventRegisterDate,Views,CategoryID,Privacy,AvatarLink,EditBy,EditTime,EditContent")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Events.Add(@event);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", @event.CategoryID);
            ViewBag.ChannelID = new SelectList(db.Channels, "ChannelID", "ChannelName", @event.ChannelID);
            return View(@event);
        }

        // GET: Events/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", @event.CategoryID);
            ViewBag.ChannelID = new SelectList(db.Channels, "ChannelID", "ChannelName", @event.ChannelID);
            return View(@event);
        }

        // POST: Events/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EventID,ChannelID,EventName,EventStartDate,EventEndDate,EventDescription,EventRegisterDate,Views,CategoryID,Privacy,AvatarLink,EditBy,EditTime,EditContent")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", @event.CategoryID);
            ViewBag.ChannelID = new SelectList(db.Channels, "ChannelID", "ChannelName", @event.ChannelID);
            return View(@event);
        }

        // GET: Events/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // POST: Events/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Event @event = db.Events.Find(id);
            db.Events.Remove(@event);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
