using System;
using System.Collections.Generic;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using Microsoft.Ajax.Utilities;

namespace EventZone.Controllers
{
    public class SearchController : Controller
    {
        public ActionResult Search()
        {
            return PartialView();
        }

        public ActionResult SearchAdvance()
        {
            return PartialView(new AdvanceSearch());
        }

        public ActionResult CategorySearch(long[] categoryid)
        {
            List<Event> listEvent = new List<Event>();
            listEvent = EventDatabaseHelper.Instance.SearchByCategory(listEvent, categoryid);
            ViewData["listEvent"] = EventDatabaseHelper.Instance.GetThumbEventListByListEvent(listEvent);
            return View("SearchResult");
        }

        [HttpPost]
        public ActionResult BasicSearch(BasicSearch model)
        {
            string keyword;
            if (model.Keyword.IsNullOrWhiteSpace())
            {
                keyword = "";
            }
            else
            {
                keyword = model.Keyword;
            }
            keyword = keyword.Trim();
            ViewData["listEvent"] =
                EventDatabaseHelper.Instance.GetThumbEventListByListEvent(
                    EventDatabaseHelper.Instance.SearchEventByKeyword(keyword));
            ViewData["listLiveStream"] =
                EventDatabaseHelper.Instance.GetThumbEventListByListEvent(
                    EventDatabaseHelper.Instance.SearchLiveStreamByKeyword(keyword));
            ViewData["listUser"] = UserDatabaseHelper.Instance.SearchUserByKeyword(keyword);
            return View("SearchResult");
        }

        // GET: Search/Details/5
        public ActionResult AdvanceSearch(AdvanceSearch model, int datepick)
        {
            List<Event> listEvent = new List<Event>();
            AdvanceSearch myModel = model;
            List<Event> listLiveStream = new List<Event>();
            if (model.Keyword != null)
            {
                model.Keyword = model.Keyword.Trim();
            }
            listEvent = EventDatabaseHelper.Instance.SearchEventByKeyword(model.Keyword);
            listLiveStream = EventDatabaseHelper.Instance.SearchLiveStreamByKeyword(model.Keyword);
            if (model.SelectedCategory != null && model.SelectedCategory.Length != 0)
            {
                listEvent = EventDatabaseHelper.Instance.SearchByCategory(listEvent, model.SelectedCategory);
                listLiveStream = EventDatabaseHelper.Instance.SearchByCategory(listLiveStream, model.SelectedCategory);
            }

            if (model.Location != null && model.Location.LocationName != null &&
                !(model.Location.Longitude == 0 && model.Location.Latitude == 0))
            {
                listEvent = EventDatabaseHelper.Instance.GetEventAroundLocation(model.Location, 20, listEvent);
                listLiveStream = EventDatabaseHelper.Instance.GetEventAroundLocation(model.Location, 20, listLiveStream);
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

            listEvent = EventDatabaseHelper.Instance.GetEventInDateRange(startTime, endTime, listEvent);
            listLiveStream = EventDatabaseHelper.Instance.GetEventInDateRange(startTime, endTime, listLiveStream);
            ViewData["listEvent"] = EventDatabaseHelper.Instance.GetThumbEventListByListEvent(listEvent);
            ViewData["listLiveStream"] = EventDatabaseHelper.Instance.GetThumbEventListByListEvent(listLiveStream);
            ViewData["listUser"] = new List<ViewThumbUserModel>();
            return View("SearchResult");
        }
    }
}