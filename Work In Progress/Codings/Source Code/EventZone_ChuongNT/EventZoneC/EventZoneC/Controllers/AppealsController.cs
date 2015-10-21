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
    public class AppealsController : Controller
    {
        private EventZoneEntities4 db = new EventZoneEntities4();

        // GET: Appeals
        public ActionResult ManageAppeals()
        {
            var appeals = db.Appeals.Include(a => a.Event);
            return View(appeals.ToList());
        }
        public ActionResult SearchEvent(string searchString)
        {
            var appeal = db.Appeals.Include(a=> a.Event);

            if (String.IsNullOrEmpty(searchString) == false)
            {

                appeal = appeal.Where(e => e.Event.EventName.Contains(searchString) );
                

            }
            
            return View("ManageAppeals", appeal.ToList());
        }
        // GET: Events/Details/5
        public ActionResult Approve(int AppealID, int AdminID)
        {



            List<Appeal> listAppeal = new List<Appeal>();
            var appealChange = db.Appeals.Include(a=>a.Event);
            appealChange = appealChange.Where(u => u.AppealID == AppealID);
            listAppeal = appealChange.ToList();

            TrackingAppeal track = new TrackingAppeal();
            track.ActorID = AdminID;
            track.ReceiverID = AppealID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3

            track.ActionTime = DateTime.Now;
            if (appealChange != null)
            {
                listAppeal[0].AppealStatus = 1;
                // db.Entry(userChange).State = EntityState.Modified;
                track.ActionID = 3;
                db.TrackingAppeals.Add(track);
                db.SaveChanges();



            }
            appealChange = db.Appeals.Include(a => a.Event);

            return View("ManageAppeals", appealChange);
        }
        public ActionResult Reject(int AppealID, int AdminID)
        {



            List<Appeal> listAppeal = new List<Appeal>();
            var appealChange = db.Appeals.Include(a => a.Event);
            appealChange = appealChange.Where(u => u.AppealID == AppealID);
            listAppeal = appealChange.ToList();
            TrackingAppeal track = new TrackingAppeal();
            track.ActorID = AdminID;
            track.ReceiverID = AppealID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3

            track.ActionTime = DateTime.Now;

            if (appealChange != null)
            {
                listAppeal[0].AppealStatus = 2;
                // db.Entry(userChange).State = EntityState.Modified;
                track.ActionID = 4;
                db.TrackingAppeals.Add(track);
                db.SaveChanges();



            }
            appealChange = db.Appeals.Include(a => a.Event);

            return View("ManageAppeals", appealChange);
        }
        // GET: Appeals/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appeal appeal = db.Appeals.Find(id);
            if (appeal == null)
            {
                return HttpNotFound();
            }
            return View(appeal);
        }

        // GET: Appeals/Create
        public ActionResult Create()
        {
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName");
            return View();
        }

        // POST: Appeals/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "AppealID,EventID,AppealContent,AppealStatus,SendDate,ResultDate")] Appeal appeal)
        {
            if (ModelState.IsValid)
            {
                db.Appeals.Add(appeal);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", appeal.EventID);
            return View(appeal);
        }

        // GET: Appeals/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appeal appeal = db.Appeals.Find(id);
            if (appeal == null)
            {
                return HttpNotFound();
            }
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", appeal.EventID);
            return View(appeal);
        }

        // POST: Appeals/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "AppealID,EventID,AppealContent,AppealStatus,SendDate,ResultDate")] Appeal appeal)
        {
            if (ModelState.IsValid)
            {
                db.Entry(appeal).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", appeal.EventID);
            return View(appeal);
        }

        // GET: Appeals/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Appeal appeal = db.Appeals.Find(id);
            if (appeal == null)
            {
                return HttpNotFound();
            }
            return View(appeal);
        }

        // POST: Appeals/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Appeal appeal = db.Appeals.Find(id);
            db.Appeals.Remove(appeal);
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
