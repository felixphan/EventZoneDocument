using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.AdminHelpers;
using System.Data.Entity;
using System.Data;

using EventZone.Models;


namespace EventZone.Controllers
{
    public class StatiticAdminController : Controller
    {
        private EventZoneEntities db = new EventZoneEntities();
        // GET: Statitic
        public ActionResult ViewStatitic()
        {
            //var user = from b in db.PeopleFollows.AsEnumerable()
            //           group b by b.FollowingUserID into g
            //           // group b by b.Field<int>("FollowingUserID") into g
            //           let count = g.Count()
            //           select new
            //           {
            //               FollowingUserID = g.Key,
            //               Count = count,
            //           };
            //return View(user.ToList());
            return View(DataHelper.TopTenUser());
        }
        public ActionResult StatiticEventView()
        {
            return View(DataHelper.TopTenEvent());
        }
        public ActionResult UserRegisterMonth()
        {
            return View();
        }
        public ActionResult EventRegisterMonth()
        {
            return View();
        }
    }
}