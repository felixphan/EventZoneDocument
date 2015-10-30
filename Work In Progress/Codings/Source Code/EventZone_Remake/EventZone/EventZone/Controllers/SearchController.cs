using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using EventZone.Models;
using Microsoft.Ajax.Utilities;

namespace EventZone.Controllers
{
    public class SearchController : Controller
    {
        DatabaseHelpers dbHelp = new DatabaseHelpers();
        // GET: Search
        public ActionResult Search()
        {
            return PartialView();
        }

        public ActionResult SearchAdvance()
        {
            return PartialView(new AdvanceSearch());
        }
        [HttpPost]
        public ActionResult BasicSearch(BasicSearch model)
        {
            string keyword;
            if (model.Keyword.IsNullOrWhiteSpace())
            {
                keyword = "";
            }
            else { 
            keyword = model.Keyword;
                }
            keyword = keyword.Trim();
            ViewData["listEvent"] = dbHelp.GetThumbEventListByListEvent(dbHelp.SearchEventByKeyword(keyword));
            ViewData["listLiveStream"] = dbHelp.GetThumbEventListByListEvent(dbHelp.SearchLiveStreamByKeyword(keyword));
            ViewData["listUser"] = dbHelp.SearchUserByKeyword(keyword);
            return View("SearchResult");
        }
        // GET: Search/Details/5
        public ActionResult AdvanceSearch(AdvanceSearch model, int datepick)
        {
            List<Event> listEvent = new List<Event>();
            AdvanceSearch myModel = model;
            List<Event> listLiveStream = new List<Event>();
            if (model.Keyword != null)
            { model.Keyword = model.Keyword.Trim(); }
            listEvent = dbHelp.SearchEventByKeyword(model.Keyword);
            listLiveStream = dbHelp.SearchLiveStreamByKeyword(model.Keyword);
            if (model.SelectedCategory != null && model.SelectedCategory.Length != 0)
            {
                listEvent = dbHelp.SearchByCategory(listEvent, model.SelectedCategory);
                listLiveStream = dbHelp.SearchByCategory(listLiveStream, model.SelectedCategory);
            }

            if (model.Location != null && model.Location.LocationName != null && !(model.Location.Longitude == 0 && model.Location.Latitude == 0))
            {
                listEvent = dbHelp.GetEventAroundLocation(model.Location, 20, listEvent);
                listLiveStream = dbHelp.GetEventAroundLocation(model.Location, 20, listLiveStream);
            }
            DateTime startTime = new DateTime();
            DateTime endTime = new DateTime();
            if (datepick == 0)
            {
                startTime = new DateTime(0001, 1, 1, 0, 0, 0);
                endTime = new DateTime(5000, 12, 30, 0, 0, 0);
            }
            else if (datepick == 1)
            {
                startTime = DateTime.Today;
                endTime = DateTime.Today.AddDays(1);
            }
            else if (datepick == 2)
            {
                startTime = DateTime.Today;
                endTime = startTime.AddDays(3);
            }
            else if (datepick == 3)
            {
                startTime = DateTime.Today;
                endTime = startTime.AddDays(7);
            }
            else if (datepick == 4)
            {
                startTime = model.StartDateRange;
                endTime = model.FinishDateRange.AddDays(1);
            }

            listEvent = dbHelp.GetEventInDateRange(startTime, endTime, listEvent);
            listLiveStream = dbHelp.GetEventInDateRange(startTime, endTime, listLiveStream);
            ViewData["listEvent"] = dbHelp.GetThumbEventListByListEvent(listEvent);
            ViewData["listLiveStream"] = dbHelp.GetThumbEventListByListEvent(listLiveStream);
            ViewData["listUser"] = new List<ViewThumbUserModel>();
            return View("SearchResult");
        }

        // GET: Search/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Search/Create
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

        // GET: Search/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Search/Edit/5
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

        // GET: Search/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Search/Delete/5
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
