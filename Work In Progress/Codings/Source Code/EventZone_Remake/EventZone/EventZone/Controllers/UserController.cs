using EventZone.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Models;
using System.Net;
using System.Data.Entity;
using System.Web.Helpers;

namespace EventZone.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        public ActionResult ManageProfile()
        {
            if (UserHelpers.GetCurrentUser(Session) == null)
            {
                return RedirectToAction("RequireSignin", "Account");
            }
            ViewData["UserSession"] = UserHelpers.GetCurrentUser(Session);
            if (TempData["ManageProfileTask"] == null)
            {
                TempData["ManageProfileTask"] = "UserInfo";
            }
            if (TempData["editUserModel"] != null)
            {
                EditUserModel editUserModel = TempData["editUserModel"] as EditUserModel;
                return View(editUserModel);
            }
            return View();
        }

        /// <summary>
        /// view detail user info
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult UserInfo(long? id = 0)
        {
            User userSession = UserHelpers.GetCurrentUser(Session);
            User user;

            if (userSession.UserID == id || id == 0)
            {
                user = userSession;
            }
            else
            {
                user = UserDatabaseHelper.Instance.GetUserByID(id);
                if (user == null)
                {
                    return RedirectToAction("Index", "Home");
                }
            }

            ViewData["UserSession"] = user;
            TempData["ManageProfileTask"] = "UserInfo";
            return RedirectToAction("ManageProfile");
        }

        //
        // GET: /User/Edit/5
        public ActionResult EditProfile()
        {
            User userSession = UserHelpers.GetCurrentUser(Session);

            if (userSession == null)
            {
                return RedirectToAction("RequireSignin", "Account");
            }
            EditUserModel editUserModel = new EditUserModel();
            editUserModel.UserID = userSession.UserID;
            editUserModel.Password = userSession.UserPassword;
            editUserModel.UserDOB = userSession.UserDOB;
            editUserModel.UserFirstName = userSession.UserFirstName;
            editUserModel.UserLastName = userSession.UserLastName;
            editUserModel.AvatarLink = userSession.AvatarLink;
            editUserModel.Phone = userSession.Phone;
            editUserModel.Place = userSession.Place;
            editUserModel.IDCard = userSession.IDCard;
            TempData["ManageProfileTask"] = "EditProfile";
            TempData["editUserModel"] = editUserModel;
            return RedirectToAction("ManageProfile");
        }

        //
        // POST: /User/Edit/5
        [HttpPost]
        public ActionResult EditProfile(EditUserModel editUserModel)
        {
            try
            {
                // TODO: Add update logic here
                if (ModelState.IsValid)
                {

                    User user = UserDatabaseHelper.Instance.GetUserByID(editUserModel.UserID);
                    if (user == null)
                    {
                        ModelState.AddModelError("", "You are signed out!");
                        return RedirectToAction("SignIn", "Account");
                    }
                    user.UserPassword = editUserModel.Password;
                    user.UserFirstName = editUserModel.UserFirstName;
                    user.UserLastName = editUserModel.UserLastName;
                    user.UserDOB = editUserModel.UserDOB;
                    user.IDCard = editUserModel.IDCard;
                    user.Gender = editUserModel.Gender;
                    user.AvatarLink = editUserModel.AvatarLink;
                    user.Phone = editUserModel.Phone;
                    user.Place = editUserModel.Place;

                    if (UserDatabaseHelper.Instance.UpdateUser(user))
                    {
                        UserHelpers.SetCurrentUser(Session, user);
                        TempData["ManageProfileTask"] = "UserInfo";
                        return RedirectToAction("ManageProfile");
                    }
                    else
                    {
                        TempData["ManageProfileTask"] = "EditProfile";
                        ModelState.AddModelError("", "Something went wrong! Please try again!");
                        return RedirectToAction("EditProfile");
                    }
                }
                TempData["ManageProfileTask"] = "EditProfile";
                ModelState.AddModelError("", "Something went wrong! Please try again!");
                return RedirectToAction("EditProfile");
            }
            catch (Exception ex)
            {
                TempData["ManageProfileTask"] = "EditProfile";
                ModelState.AddModelError("", "Something went wrong! Please try again!");
                return RedirectToAction("EditProfile");
            }

        }
        /// <summary>
        /// manage event
        /// </summary>
        /// <returns></returns>
        public ActionResult ManageEvent()
        {
            if (UserHelpers.GetCurrentUser(Session) == null)
            {
                return RedirectToAction("RequireSignin", "Account");
            }
            User currentUser = UserHelpers.GetCurrentUser(Session);
            List<Event> myEvent = EventDatabaseHelper.Instance.GetEventsByUser(currentUser.UserID);
            if (myEvent == null)
            {
                return View("SuggestCreateEvent");
            }

            List<ViewThumbEventModel> listThumbEvent = EventDatabaseHelper.Instance.GetThumbEventListByListEvent(myEvent);

            if (ViewData["ManageEventTask"] == null)
            {
                ViewData["ManageEventTask"] = "MyEvent";
            }
            ViewData["ListThumbEvent"] = listThumbEvent;//chứa thông tin cần thiết để show 1 event
            ViewData["MyEvent"] = myEvent;//event cua người dùng
            return View();

        }
        /// <summary>
        /// view all my event thumb
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult MyEvent(long? id = -1)
        {
            if (id == -1)
            {
                return RedirectToAction("ManageEvent");
            }
            User user = UserDatabaseHelper.Instance.GetUserByID(id);
            List<Event> myEvent = EventDatabaseHelper.Instance.GetEventsByUser(id);
            if (myEvent == null)
            {
                return RedirectToAction("ManageEvent");
            }

            List<ViewThumbEventModel> listThumbEvent = new List<ViewThumbEventModel>();
            foreach (var item in myEvent)
            {
                ViewThumbEventModel thumbEventModel = new ViewThumbEventModel();
                thumbEventModel.eventId = item.EventID;
                thumbEventModel.avatar = EventDatabaseHelper.Instance.GetImageByID(item.Avatar).ImageLink;
                thumbEventModel.eventName = item.EventName;
                thumbEventModel.StartTime = item.EventStartDate;
                thumbEventModel.EndTime = item.EventEndDate;
                thumbEventModel.location = EventDatabaseHelper.Instance.GetEventLocation(item.EventID);
                listThumbEvent.Add(thumbEventModel);
            }
            ViewData["ListThumbEvent"] = listThumbEvent;
            ViewData["MyEvent"] = myEvent;
            return RedirectToAction("ManageEvent");
        }
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Like(long eventId)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Boolean success = false;
            int state = EventZoneConstants.NotRate;

            if (user != null)
            {
                LikeDislike findlike = UserDatabaseHelper.Instance.FindLike(user.UserID, eventId);
                if (findlike != null)
                {
                    state = findlike.Type;
                }
                success = UserDatabaseHelper.Instance.InsertLike(user.UserID, eventId);
            }

            return Json(new
            {
                success = success,
                state = state
            });
        }

        public JsonResult DisLike(long eventId)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Boolean success = false;
            int state = EventZoneConstants.NotRate;
            if (user != null)
            {
                LikeDislike findlike = UserDatabaseHelper.Instance.FindLike(user.UserID, eventId);
                if (findlike != null)
                {
                    state = findlike.Type;
                }
                success = UserDatabaseHelper.Instance.InsertDislike(user.UserID, eventId);
            }
            return Json(new
            {
                success = success,
                state = state
            });
        }
        public JsonResult FollowEvent(long eventId)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Boolean success = false;
            int followState = 0;
            if (user != null)
            {
                success = UserDatabaseHelper.Instance.FollowEvent(user.UserID, eventId);
                if (UserDatabaseHelper.Instance.IsFollowingEvent(user.UserID, eventId))
                {
                    followState = 1;
                }
            }
            return Json(new
            {
                success = success,
                state = followState
            }

           );
        }

        public JsonResult FollowCategory(long categoryId)
        {
            User user = UserHelpers.GetCurrentUser(Session);
            Boolean success = false;
            int followState = 0;
            if (user != null)
            {
                success = UserDatabaseHelper.Instance.FollowCategory(user.UserID, categoryId);
                if (UserDatabaseHelper.Instance.IsFollowingCategory(user.UserID, categoryId))
                {
                    followState = 1;
                }
            }
            return Json(new
            {
                success = success,
                state = followState
            }

           );
        }


    }
}

