using EventZone.Helpers;
using EventZone.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace EventZone.Controllers
{
    public class AccountController : Controller
    {
        EventZoneEntities db = new EventZoneEntities();
        // GET: /Account/Register
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        //
        // POST: /Account/Register
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                User user = new User();
                List<User> listUser = new List<User>();
                listUser = db.Users.ToList();
                var newUser = listUser.FindAll(a => a.UserEmail.Equals(model.UserName));

                if (newUser.Count == 0)
                {
                    user.TypeID = 0;// eventzone account
                    //Set all parameters for user from registerViewModel
                    user.UserEmail = model.UserName;
                    user.UserPassword = model.Password;
                    user.UserDOB = model.UserDOB;
                    user.UserFirstName = model.UserFirstName;
                    if (model.UserLastName != null && model.UserLastName != "")
                    {
                        user.UserLastName = model.UserLastName;
                    }
                    user.AccountStatus = EventZoneConstants.IsUserActive;//set Active account
                    if (string.IsNullOrWhiteSpace(user.AvatarLink))//set default avatar
                    {
                        user.AvatarLink = "/img/default-avatar.jpg";
                    }
                    user.UserRoles = EventZoneConstants.IsUser;//set UserRole
                    // insert user to Database
                    db.Users.Add(user);
                    db.SaveChanges();
                    Session["registerMessageError"] = "";
                }
                else {
                    ModelState.AddModelError("", "User with the email you provided is already exist.");
                    return View();
                }
                //set all session for 
                Session["authenticated"] = true;
                Session["userName"] = user.UserFirstName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Send email confirm
                MailHelpers.Instance.SendMailWelcome(user.UserEmail, user.UserFirstName, user.UserLastName);
            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("RegisterSuccess", "Account");
        }
        public ActionResult RegisterSuccess()
        {
            return View();
        }

        // GET: /Account/Login
        [AllowAnonymous]
        public ActionResult Signin(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        //
        // POST: /Account/Login
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Signin(LoginViewModel model, string returnUrl)
        {
            if (ModelState.IsValid)
            {
                DatabaseHelpers dbhelp= new DatabaseHelpers();
                if (dbhelp.ValidateUser(model.UserName, model.Password)) {
                    if (dbhelp.isLookedUser(model.UserName))
                    {
                        ModelState.AddModelError("", "Your account is locked! Please contact with our support");
                    }
                    else {
                        var user = dbhelp.GetUserByEmail(model.UserName);
                        Session["authenticated"] = true;
                        Session["userName"] = user.UserFirstName;
                        Session["userAva"] = user.AvatarLink;
                        Session["UserId"] = user.UserID;
                        UserHelpers.SetCurrentUser(Session, user);
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Email or password is invalid.");
                }
            }

            // If we got this far, something failed, redisplay form
            return View(returnUrl);
        }



    }
}
