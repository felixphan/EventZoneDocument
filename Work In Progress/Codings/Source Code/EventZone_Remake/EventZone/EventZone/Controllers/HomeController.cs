using System.Linq;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using System.Collections.Generic;

namespace EventZone.Controllers
{
    public class HomeController : Controller
    {
        private readonly EventZoneEntities db = new EventZoneEntities();
        public ActionResult Index()
        {
            return View(db.Categories.ToList());
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Policy()
        {
            return View();
        }
        public ActionResult Help()
        {
            return View();
        }
        /// <summary>
        /// return new event to new event column Home page
        /// </summary>
        /// <returns></returns>
        public ActionResult NewEvent() {
            List<ThumbEventHomePage> listThumb = new List<ThumbEventHomePage>();
            List<Event> listEvent = new List<Event>();
            listEvent= EventDatabaseHelper.Instance.GetListNewEvent();
            listEvent = EventDatabaseHelper.Instance.RemoveLockedEventInList(listEvent);
            User user= UserHelpers.GetCurrentUser(Session);
            if (user != null) {
                listEvent = EventDatabaseHelper.Instance.GetListNewEventByUser(user.UserID);
            }
            listThumb = EventDatabaseHelper.Instance.GetThumbEventHomepage(listEvent);
            return PartialView("_ThumbEventHomepage", listThumb);
        }
        public ActionResult HotEvent()
        {
            List<ThumbEventHomePage> listThumb = new List<ThumbEventHomePage>();
            List<Event> listEvent = new List<Event>();

            listEvent = EventDatabaseHelper.Instance.GetHotEvent();
            listEvent = EventDatabaseHelper.Instance.RemoveLockedEventInList(listEvent);
            listThumb = EventDatabaseHelper.Instance.GetThumbEventHomepage(listEvent);
            return PartialView("_ThumbEventHomepage",listThumb);
        }
        public ActionResult LiveEvent()
        {
            List<ThumbEventHomePage> listThumb = new List<ThumbEventHomePage>();
            List<Event> listEvent = new List<Event>();

            listEvent = EventDatabaseHelper.Instance.SearchLiveStreamByKeyword("");
            listEvent = EventDatabaseHelper.Instance.RemoveLockedEventInList(listEvent);
            listThumb = EventDatabaseHelper.Instance.GetThumbEventHomepage(listEvent);
            return PartialView("_ThumbEventHomepage");
        }
    }
}