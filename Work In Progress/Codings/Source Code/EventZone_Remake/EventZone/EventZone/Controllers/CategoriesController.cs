﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using EventZone.Models;

namespace EventZone.Controllers
{
    public class CategoriesController : Controller
    {
        private EventZoneEntities db = new EventZoneEntities();

        // GET: Categories
        public ActionResult Index()
        {
            return PartialView(db.Categories.ToList());
        }
    }
}
