using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using EventZone.Helpers;
using EventZone.Models;
using Microsoft.Owin.BuilderProperties;
using Newtonsoft.Json.Linq;

namespace EventZone.Controllers
{
    public class AccountController : Controller
    {
        private EventZoneEntities db = new EventZoneEntities();

        private DatabaseHelpers dbhelp = new DatabaseHelpers();
        // GET: Account
        public ActionResult SignIn()
        {
            return PartialView();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult SignInPost(SignInViewModel model)
        {
            if (!ModelState.IsValid)
                return Json(new
                {
                    state = 0,
                    message = "Invalid model"
                });

            var dbhelp = new DatabaseHelpers();
            if (dbhelp.ValidateUser(model.UserName, model.Password))
            {
                if (dbhelp.isLookedUser(model.UserName))
                {
                    ModelState.AddModelError("", "Your account is locked! Please contact with our support");
                    return Json(new
                    {
                        state = 0,
                        message = "Your account is locked! Please contact with our support"
                    });
                }

                var user = dbhelp.GetUserByUserName(model.UserName);
                ViewData["User"] = user;
                Session["authenticated"] = true;
                Session["userName"] = user.UserName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

            }
            else
            {
                ModelState.AddModelError("", "UserName or password is invalid.");
                return Json(new
                {
                    state = 0,
                    message = "Invalid account, password"
                });
            }


            // If we got this far, something failed, redisplay form
            return Json(new
            {
                state = 1,
                message = "Signin Successfully"
            });
            ;
        }

        // GET: Account/Details/5
        public ActionResult SignUp()
        {
            return PartialView();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> SignUpPost(SignUpViewModel model)
        {
            if (ModelState.IsValid)
            {
                User user = new User();
                List<User> listUser = new List<User>();
                listUser = db.Users.ToList();
                var newUser = listUser.FindAll(a => a.UserName.Equals(model.UserName));
                if (newUser.Count != 0)
                {
                    //ModelState.AddModelError("", "UserName is already exist. Please choose another.");
                    return Json(new
                    {
                        state = 0,
                        message = "UserName is already exist. Please choose another."
                    });
                }
                newUser = listUser.FindAll(a => a.UserEmail.Equals(model.Email));
                if (newUser.Count != 0)
                {
                    //ModelState.AddModelError("", "Email is already registered. Please choose another.");
                    return Json(new
                    {
                        state = 0,
                        message = "Email is already registered. Please choose another."
                    });
                }
                else
                {
                    user.UserEmail = model.Email;
                    user.UserName = model.UserName;
                    user.UserPassword = model.Password;
                    user.UserDOB = model.UserDOB;
                    user.UserFirstName = model.UserFirstName;
                    if (model.UserLastName != null && model.UserLastName != "")
                    {
                        user.UserLastName = model.UserLastName;
                    }
                    user.AccountStatus = EventZoneConstants.IsUserActive; //set Active account
                    if (string.IsNullOrWhiteSpace(user.AvatarLink)) //set default avatar
                    {
                        user.AvatarLink = "/img/default-avatar.jpg";
                    }
                    user.UserRoles = EventZoneConstants.IsUser; //set UserRole
                    // insert user to Database
                    db.Users.Add(user);
                    db.SaveChanges();
                    Session["registerMessageError"] = "";
                }
                //set all session for 
                ViewData["User"] = user;
                Session["authenticated"] = true;
                Session["userName"] = user.UserName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Create Channel
                dbhelp.CreateUserChannel(user);
                //Send email confirm
                MailHelpers.Instance.SendMailWelcome(user.UserEmail, user.UserFirstName, user.UserLastName);
                //return RedirectToAction("RegisterSuccess", "Account");
                return Json(new
                {
                    state = 1,
                    message = "Registered Successfully"
                });
            }

            // If we got this far, something failed, redisplay form
            return Json(new
            {
                state = 0,
                message = "Something Wrong"
            });
        }

    public ActionResult Signout()
        {
            User user = UserHelpers.GetCurrentUser(Session);
            /*try
            /{
                GoogleConnect.Clear();
            }
            catch (Exception e)
            {

            }*/

            Session["authenticated"] = "";
            Session["userName"] = "";
            Session["userAva"] = "";
            Session["UserId"] = "";
            ViewData["User"] = "";
            Session["loginMessageError"] = "";
            UserHelpers.SetCurrentUser(Session, null);

            return RedirectToAction("Index", "Home");
        }

    }
}
