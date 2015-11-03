using System.Linq;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;

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
    }
}