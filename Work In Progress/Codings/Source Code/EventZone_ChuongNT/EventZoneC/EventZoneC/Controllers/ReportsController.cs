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
    public class ReportsController : Controller
    {
        private EventZoneEntities4 db = new EventZoneEntities4();

        // GET: Reports
        public ActionResult ManageReports()
        {
            var reports = db.Reports.Include(r => r.Event).Include(r => r.User);
            return View(reports.ToList());
        }
        public ActionResult SearchEvent(string searchString)
        {
            var report = db.Reports.Include(a => a.Event);

            if (String.IsNullOrEmpty(searchString) == false)
            {

                report = report.Where(e => e.Event.EventName.Contains(searchString));


            }

            return View("ManageReports", report.ToList());
        }
        public ActionResult Approve(int ReportID, int AdminID)
        {



            List<Report> listReport = new List<Report>();
            var reportChange = db.Reports.Include(r => r.User);
            reportChange = reportChange.Where(u => u.ReportID == ReportID);
            listReport = reportChange.ToList();

            TrackingReport track = new TrackingReport();
            track.ActorID = AdminID;
            track.ReceiverID = ReportID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3

            track.ActionTime = DateTime.Now;

            if (reportChange != null)
            {
                listReport[0].ReportStatus = 1;
                // db.Entry(userChange).State = EntityState.Modified;
                
                track.ActionID = 3;
                db.TrackingReports.Add(track);
                db.SaveChanges();

            }
            reportChange = db.Reports.Include(r => r.User);

            return View("ManageReports", reportChange);
        }
        public ActionResult Reject(int ReportID, int AdminID)
        {



            List<Report> listReport = new List<Report>();
            var reportChange = db.Reports.Include(r => r.User);
            reportChange = reportChange.Where(u => u.ReportID == ReportID);
            listReport = reportChange.ToList();
            TrackingReport track = new TrackingReport();
            track.ActorID = AdminID;
            track.ReceiverID = ReportID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3

            track.ActionTime = DateTime.Now;

            if (reportChange != null)
            {
                listReport[0].ReportStatus = 2;
                // db.Entry(userChange).State = EntityState.Modified;
               
                track.ActionID = 4;
                db.TrackingReports.Add(track);
                db.SaveChanges();

            }
            reportChange = db.Reports.Include(r => r.User);

            return View("ManageReports", reportChange);
        }

        // GET: Reports/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Report report = db.Reports.Find(id);
            if (report == null)
            {
                return HttpNotFound();
            }
            return View(report);
        }

        // GET: Reports/Create
        public ActionResult Create()
        {
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName");
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "UserName");
            return View();
        }

        // POST: Reports/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ReportID,EventID,SenderID,ReportType,ReportContent,ReportStatus,ReportDate,ResultDate")] Report report)
        {
            if (ModelState.IsValid)
            {
                db.Reports.Add(report);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", report.EventID);
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "UserName", report.SenderID);
            return View(report);
        }

        // GET: Reports/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Report report = db.Reports.Find(id);
            if (report == null)
            {
                return HttpNotFound();
            }
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", report.EventID);
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "UserName", report.SenderID);
            return View(report);
        }

        // POST: Reports/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ReportID,EventID,SenderID,ReportType,ReportContent,ReportStatus,ReportDate,ResultDate")] Report report)
        {
            if (ModelState.IsValid)
            {
                db.Entry(report).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EventID = new SelectList(db.Events, "EventID", "EventName", report.EventID);
            ViewBag.SenderID = new SelectList(db.Users, "UserID", "UserName", report.SenderID);
            return View(report);
        }

        // GET: Reports/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Report report = db.Reports.Find(id);
            if (report == null)
            {
                return HttpNotFound();
            }
            return View(report);
        }

        // POST: Reports/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            Report report = db.Reports.Find(id);
            db.Reports.Remove(report);
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
