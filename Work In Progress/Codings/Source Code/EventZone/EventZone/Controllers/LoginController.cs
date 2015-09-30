using EventZone.Helpers;
using EventZone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventZone.Controllers
{
    public class LoginController : Controller
    {
        //
        private EventZoneEntities db = new EventZoneEntities();
        [ChildActionOnly]
        // GET: /Login/
        public ActionResult LoginPartial()
        {
            var model = new User();
            return PartialView("~/Views/Shared/_LoginPartial.cshtml", model);
        }

        //
        // GET: /Login/Details/5
        public ActionResult Register(User user)
        {
            //if (!ModelState.IsValid)
            {
                Session["loginMessageError"] = "";
                user.TypeID = 0; // Fap Account
                user.AvatarLink = "";

                // select from DB
                var newUser = db.Users.Where(i => i.UserEmail.Equals(user.UserEmail));

                /*
                 *  Insert into Graph DB 
                 */
                if (newUser == null)
                {
                    user.TypeID = 0; // Fap account
                    user.UserRoles = EventZoneConstants.IsUser;

                    user.AccountStatus = EventZoneConstants.IsUserActive;
                    if (string.IsNullOrWhiteSpace(user.AvatarLink))
                    {
                        user.AvatarLink = "~/img/default-avatar.jpg";
                    }
                    Session["registerMessageError"] = "";
                    // insert user to Database
                    db.Users.Add(user);
                }
                else
                {
                    Session["registerMessageError"] = "User with the email you provided is already exist.";
                    return RedirectToAction("Index", "Home");
                }

                // Set the auth cookie
                Session["authenicated"] = true;
                Session["username"] = user.UserFirstName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Send email confirm
                MailHelpers.Instance.SendMailWelcome(user.Email, user.FirstName, user.LastName);
            }

            //FormsAuthentication.SetAuthCookie(email, false);
            //SessionHelper.RenewCurrentUser();

            return RedirectToAction("Index", "Home");
        }

        //
        // GET: /Login/Create
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Login/Create
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

        //
        // GET: /Login/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Login/Edit/5
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

        //
        // GET: /Login/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Login/Delete/5
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
