using EventZone.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Models;

namespace EventZone.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Index()
        {
            if (Request.Cookies["Admin_userName"] != null && Request.Cookies["Admin_password"] != null)
            {
                string userName = Request.Cookies["Admin_userName"].Value;
                string password = Request.Cookies["Admin_password"].Value;
                var admin = AdminDataHelpers.Instance.FindAdmin(userName, password);
                if (admin != null)
                {
                    if (admin.AccountStatus != EventZoneConstants.LockedUser)
                    {
                        UserHelpers.SetCurrentAdmin(Session, admin);
                    }
                }
            }
            return View();
        }
        public ActionResult SignIn()
        {
            User admin = UserHelpers.GetCurrentAdmin(Session);
            if (admin != null)
            {
                TempData["errorTittle"] = "Bad request";
                TempData["errorMessage"] = "You are already signed in the system";
                return RedirectToAction("Index", "Admin");
            }
            TempData["errorTitle"] = null;
            TempData["errorMessage"] = null;
            return PartialView();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult SignInPost(SignInViewModel model)
        {
            if (!ModelState.IsValid)
            {
                TempData["errorTitle"] = "Invalid Input";
                TempData["errorMessage"] = "Invalid Input";
            }
            if (UserDatabaseHelper.Instance.isLookedUser(model.UserName))
            {
                ModelState.AddModelError("", "Your account is locked! Please contact with our support");
            }
            var admin = AdminDataHelpers.Instance.FindAdmin(model.UserName, model.Password);
            if (admin!=null&&admin.UserRoles==EventZoneConstants.Admin)
            {
                if (model.Remember)
                {
                    HttpCookie userName = new HttpCookie("Admin_userName");
                    userName.Expires = DateTime.Now.AddDays(7);
                    userName.Value = model.UserName;
                    Response.Cookies.Add(userName);

                    HttpCookie password = new HttpCookie("Admin_password");
                    password.Expires = DateTime.Now.AddDays(7);
                    password.Value = model.Password;
                    Response.Cookies.Add(password);
                }
                UserHelpers.SetCurrentAdmin(Session, admin);
                return RedirectToAction("Index", "Admin");
            }
            else
            {
                ModelState.AddModelError("", "UserName or password is invalid.");
            }

            return RedirectToAction("Index", "Admin");

            // If we got this far, something failed, redisplay form
            
            
        }

        public ActionResult SignOut()
        {

            if (Request.Cookies["Admin_userName"] != null)
            {
                HttpCookie userName = new HttpCookie("Admin_userName");
                userName.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(userName);
            }
            //remove cookie password
            if (Request.Cookies["Admin_password"] != null)
            {
                HttpCookie password = new HttpCookie("Admin_password");
                password.Expires = DateTime.Now.AddDays(-1);
                Request.Cookies.Add(password);
            }
            UserHelpers.SetCurrentAdmin(Session, null);
            TempData["errorTitle"] = null;
            TempData["errorMessage"] = null;
            return RedirectToAction("Index", "Admin");
        }
        public ActionResult CheckCookie() {
            if (Request.Cookies["Admin_userName"] != null && Request.Cookies["Admin_password"] != null)
            {
                string userName = Request.Cookies["Admin_userName"].Value;
                string password = Request.Cookies["Admin_password"].Value;
                var admin = AdminDataHelpers.Instance.FindAdmin(userName,password);
                if(admin!=null){
                if (admin.AccountStatus==EventZoneConstants.LockedUser)
                {
                    return Json(new
                    {
                        success = 0,
                        message = "Your account have been locked! Please contact with admin to active it!"
                    });
                }
                UserHelpers.SetCurrentAdmin(Session, admin);
                return Json(new
                {
                    success = 1,
                    message = ""
                });
                }
                else
                {
                    return Json(new
                    {
                        success = 0,
                        message = "Your account have been changed password! Please try to sign in with a new password!"
                    });
                }
            }
            return Json(new
            {
                success = 0,
                message = "Cookie is empty!"
            });
        }
        public ActionResult ManageEvent()
        {
            if (Request.Cookies["Admin_userName"] != null && Request.Cookies["Admin_password"] != null)
            {
                string userName = Request.Cookies["Admin_userName"].Value;
                string password = Request.Cookies["Admin_password"].Value;
                var admin = AdminDataHelpers.Instance.FindAdmin(userName, password);
                if (admin != null)
                {
                    if (admin.AccountStatus != EventZoneConstants.LockedUser)
                    {
                        UserHelpers.SetCurrentAdmin(Session, admin);
                    }
                }
            }
            List<Event> listEvent = EventDatabaseHelper.Instance.GetAllEvent();
            return View(listEvent);
        }
        public JsonResult LockEvent(long eventID, string reason) {
            User admin = UserHelpers.GetCurrentAdmin(Session);
            if (admin == null)
            {
                return Json(new
                {
                    state = 0,
                    error = "Require Signin",
                    message = "You are not signed in..."
                });
            }
            else {
                if (admin.AccountStatus != EventZoneConstants.LockedUser)
                {

                    if (AdminDataHelpers.Instance.LockEvent(admin.UserID, eventID, reason)) {
                        return Json(new
                        {
                            state = 1,
                            error = "",
                            message = ""
                        });
                    }
                }
            }
            return Json(new
            {
                state = 0,
                error = "Error",
                message = "Ops... Somthing went wrong! Please try again!",
            });
        }
        public JsonResult UnlockEvent(long eventID)
        {
            User admin = UserHelpers.GetCurrentAdmin(Session);
            if (admin == null)
            {
                return Json(new
                {
                    state = 0,
                    error = "Require Signin",
                    message = "You are not signed in..."
                });
            }
            else
            {
                if (admin.AccountStatus != EventZoneConstants.LockedUser)
                {

                    if (AdminDataHelpers.Instance.UnlockEvent(admin.UserID, eventID))
                    {
                        return Json(new
                        {
                            state = 1,
                            error = "",
                            message = ""
                        });
                    }
                }
            }
            return Json(new
            {
                state = 0,
                error = "Error",
                message = "Ops... Somthing went wrong! Please try again!",
            });
        }
        public ActionResult ManageUser()
        {
            if (Request.Cookies["Admin_userName"] != null && Request.Cookies["Admin_password"] != null)
            {
                string userName = Request.Cookies["Admin_userName"].Value;
                string password = Request.Cookies["Admin_password"].Value;
                var admin = AdminDataHelpers.Instance.FindAdmin(userName, password);
                if (admin != null)
                {
                    if (admin.AccountStatus != EventZoneConstants.LockedUser)
                    {
                        UserHelpers.SetCurrentAdmin(Session, admin);
                    }
                }
            }
            List<User> listUser = UserDatabaseHelper.Instance.GetAllUser();
            return View(listUser);
        }
        public JsonResult LockUser(long userID)
        {
            User admin = UserHelpers.GetCurrentAdmin(Session);
            if (admin == null)
            {
                return Json(new
                {
                    state = 0,
                    error = "Require Signin",
                    message = "You are not signed in..."
                });
            }
            else
            {
                if (admin.AccountStatus != EventZoneConstants.LockedUser)
                {
                    if (AdminDataHelpers.Instance.LockUser(admin.UserID, userID))
                    {
                        return Json(new
                        {
                            state = 1,
                            error = "",
                            message = ""
                        });
                    }
                }
            }
            return Json(new
            {
                state = 0,
                error = "Error",
                message = "Ops... Somthing went wrong! Please try again!",
            });
        }
        public JsonResult UnlockUser(long userID)
        {
            User admin = UserHelpers.GetCurrentAdmin(Session);
            if (admin == null)
            {
                return Json(new
                {
                    state = 0,
                    error = "Require Signin",
                    message = "You are not signed in..."
                });
            }
            else
            {
                if (admin.AccountStatus != EventZoneConstants.LockedUser)
                {
                    if (AdminDataHelpers.Instance.UnlockUser(admin.UserID, userID))
                    {
                        return Json(new
                        {
                            state = 1,
                            error = "",
                            message = ""
                        });
                    }
                }
            }
            return Json(new
            {
                state = 0,
                error = "Error",
                message = "Ops... Somthing went wrong! Please try again!",
            });
        }
        public ActionResult ChangeUserEmail(ChangeUserEmail model)
        {
            return PartialView("_ChangeUserEmail",model);

        }
        public JsonResult ChangeUserEmailPost(ChangeUserEmail model) {

            if (ModelState.IsValid)
            {
                User admin = UserHelpers.GetCurrentAdmin(Session);
                if (admin == null)
                {
                    return Json(new
                    {
                        state = 0,
                        message = "You are not signed in..."
                    });
                }
                if (admin.AccountStatus != EventZoneConstants.LockedUser)
                {
                    if (AdminDataHelpers.Instance.ChangeUserEmail(admin.UserID, model.UserID,model.Email))
                    {
                        return Json(new
                        {
                            state = 1,
                            userID = model.UserID,
                            newEmail = model.Email
                        });
                    }
                }
                return Json(new
                {
                    state = 0,
                    message = "somthing wrong!..."
                });
            }
            else {
                return Json(new
                {
                    state=0,
                    message="somthing wrong!..."
                });
            }
        }
    }
}