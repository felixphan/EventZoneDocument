using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Models;
using System.Threading.Tasks;

namespace EventZone.Controllers
{
    public class EventCreateController : Controller
    {
        private EventZoneEntities db = new EventZoneEntities();
        // GET: EventCreate
        public ActionResult Index()
        {
            return View();
        }

        // GET: EventCreate/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: EventCreate/Create
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            return View();
        }

        // POST: EventCreate/Create
        [HttpPost]
        public async Task<ActionResult> Create(EventCreateViewModels model)
        {

                // TODO: Add insert logic here
                Event NewEvent = new Event();
                NewEvent.EventName = model.EventName;
                NewEvent.ChannelID = 1;
                NewEvent.EventStartDate = (System.DateTime) model.StartDate;
                NewEvent.EventEndDate = (System.DateTime) model.EndDate;
                NewEvent.EventDescription = model.Description;
                NewEvent.EventRegisterDate = DateTime.Now;
                NewEvent.Views = 0;
                NewEvent.CategoryID = long.Parse(model.CategoryID);
                NewEvent.Privacy = model.Privacy;
                NewEvent.AvatarLink = null;
                NewEvent.EditBy = null;
                NewEvent.EditTime = null;
                NewEvent.EditContent = null;
                db.Events.Add(NewEvent);
                db.SaveChanges();
                return RedirectToAction("Index", "Events");

        }

        // GET: EventCreate/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: EventCreate/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: EventCreate/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: EventCreate/Delete/5
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
