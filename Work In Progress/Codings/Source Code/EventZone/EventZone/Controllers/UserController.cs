﻿using EventZone.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventZone.Models;
using System.Net;
using System.Data.Entity;

namespace EventZone.Controllers
{
    public class UserController : Controller
    {
        //
        // GET: /User/
        private DatabaseHelpers datahelp = new DatabaseHelpers();
        private EventZoneEntities db = new EventZoneEntities();
        public ActionResult ManageProfile()
        {
            if (UserHelpers.GetCurrentUser(Session) == null) {
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
        public ActionResult UserInfo(long? id=0)
        {
            User userSession = UserHelpers.GetCurrentUser(Session);
            User user;
        
            if (userSession.UserID == id || id == 0)
            {
                user = userSession;
            }
            else
            {
                user = datahelp.GetUserByID(id);
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

                    User user = datahelp.GetUserByID(editUserModel.UserID);
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
                
                    if (datahelp.UpdateUser(user))
                    {
                        UserHelpers.SetCurrentUser(Session, user);
                        TempData["ManageProfileTask"] = "UserInfo";
                        return RedirectToAction("ManageProfile");
                    }
                    else {
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

        public ActionResult ManageEvent() {
            if (UserHelpers.GetCurrentUser(Session) == null)
            {
                return RedirectToAction("RequireSignin", "Account");
            }
            User currentUser = UserHelpers.GetCurrentUser(Session);
            List<Event> myEvent = datahelp.GetEventsByUser(currentUser.UserID);
            if (myEvent == null)
            {
                return RedirectToAction("ManageEvent");
            }

            List<ViewThumbEventModel> listThumbEvent = datahelp.GetThumbEventListByListEvent(myEvent);

            if (ViewData["ManageEventTask"] == null)
            {
                ViewData["ManageEventTask"] = "MyEvent";
            }
            ViewData["ListThumbEvent"] = listThumbEvent;//chứa thông tin cần thiết để show 1 event
            ViewData["MyEvent"] = myEvent;//event cua người dùng
            return View();
        
        }

        public ActionResult MyEvent(long?id=-1) {
            if (id == -1)
            {
                return RedirectToAction("ManageEvent");
            }
            User user = datahelp.GetUserByID(id);
            List<Event> myEvent = datahelp.GetEventsByUser(id);
            if (myEvent == null) {
                return RedirectToAction("ManageEvent");
            }
           
            List<ViewThumbEventModel> listThumbEvent= new List<ViewThumbEventModel>();
            foreach (var item in myEvent) {
                ViewThumbEventModel thumbEventModel = new ViewThumbEventModel();
                thumbEventModel.eventId = item.EventID;
                thumbEventModel.avartarLink = item.AvatarLink;
                thumbEventModel.eventName = item.EventName;
                thumbEventModel.StartTime = item.EventStartDate;
                thumbEventModel.EndTime = item.EventEndDate;
                thumbEventModel.location = datahelp.GetEventLocation(item.EventID);
                listThumbEvent.Add(thumbEventModel);
            }
            ViewData["ListThumbEvent"] = listThumbEvent;
            ViewData["MyEvent"] = myEvent;
            return RedirectToAction("ManageEvent");
        }
        public ActionResult Index() {
            return View();
        }
        public List<Event> List() { return null; }
    }
}
