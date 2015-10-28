using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;

namespace EventZone.Controllers
{
    public class SearchController : Controller
    {
        DatabaseHelpers dbHelp = new DatabaseHelpers();
        //
        // GET: /Search/
        
        public ActionResult Search(string keyword="")
        {
            keyword= keyword.Trim();
            ViewData["listEvent"] = dbHelp.GetThumbEventListByListEvent(dbHelp.SearchEventByKeyword(keyword));
            ViewData["listLiveStream"] = dbHelp.GetThumbEventListByListEvent(dbHelp.SearchLiveStreamByKeyword(keyword));
            ViewData["listUser"] = dbHelp.GetUserThumbByList(dbHelp.SearchUserByKeyword(keyword));
            return View();
        }

        //
        // GET: /Search/Details/5
        public ActionResult SearchAdvance()
        {

            return View("SearchAdvance", new SearchModel());
        }
        [HttpPost]
        public ActionResult AdvanceSearch(SearchModel model, int datepick)
        {
            List<Event> listEvent = new List<Event>();
            SearchModel myModel = model;
            List<Event> listLiveStream = new List<Event>();
            if (model.keyword != null)
            { model.keyword = model.keyword.Trim(); }
            listEvent = dbHelp.SearchEventByKeyword(model.keyword);
            listLiveStream = dbHelp.SearchLiveStreamByKeyword(model.keyword);
            if (model.selectedCategory != null && model.selectedCategory.Length != 0)
            {
                listEvent = dbHelp.SearchByCategory(listEvent, model.selectedCategory);
                listLiveStream = dbHelp.SearchByCategory(listLiveStream, model.selectedCategory);
            }

            if (model.location != null && model.location.LocationName != null && !(model.location.Longitude == 0 && model.location.Latitude == 0))
            {
                listEvent = dbHelp.GetEventAroundLocation(model.location, 20, listEvent);
                listLiveStream = dbHelp.GetEventAroundLocation(model.location, 20, listLiveStream);
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
                startTime = model.startDateRange;
                endTime = model.finishDateRange.AddDays(1);
            }

            listEvent = dbHelp.GetEventInDateRange(startTime, endTime, listEvent);
            listLiveStream = dbHelp.GetEventInDateRange(startTime, endTime, listLiveStream);
            ViewData["listEvent"] = dbHelp.GetThumbEventListByListEvent(listEvent);
            ViewData["listLiveStream"] = dbHelp.GetThumbEventListByListEvent(listLiveStream);
            ViewData["listUser"] = new List<ViewThumbUserModel>();
            return View("Search");
        }
       
    }
}
