using EventZone.Helpers;
using EventZone.Models;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using ASPSnippets.GoogleAPI;
using Newtonsoft.Json.Linq;

namespace EventZone.Controllers
{
     [RequireHttps]
    public class AccountController : Controller
    {
         private DatabaseHelpers dbhelp = new DatabaseHelpers();
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
                var newUser = listUser.FindAll(a => a.UserName.Equals(model.UserName));
                if (newUser.Count != 0)
                {
                    ModelState.AddModelError("", "UserName is already exist. Please choose another.");
                    return View();
                }
                newUser = listUser.FindAll(a => a.UserEmail.Equals(model.Email));
                if (newUser.Count != 0)
                {
                    ModelState.AddModelError("", "Email is already registered. Please choose another.");
                    return View();
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
                    user.AccountStatus = EventZoneConstants.IsUserActive;//set Active account
                    if (string.IsNullOrWhiteSpace(user.AvatarLink))//set default avatar
                    {
                        user.AvatarLink = "/img/default-avatar.jpg";
                    }
                    user.UserRoles = EventZoneConstants.IsUser;//set UserRole
                    // insert user to Database
                    dbhelp.data().Users.Add(user);
                    dbhelp.data().SaveChanges();
                    Session["registerMessageError"] = "";
                }
                //set all session for 
                ViewData["User"] = user;
                Session["authenticated"] = true;
                Session["userName"] = user.UserName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Send email confirm
                MailHelpers.Instance.SendMailWelcome(user.UserEmail, user.UserFirstName, user.UserLastName);
                    
                return RedirectToAction("RegisterSuccess", "Account");
            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("Index", "Home");
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
                        var user = dbhelp.GetUserByUserName(model.UserName);
                        ViewData["User"] = user;
                        Session["authenticated"] = true;
                        Session["userName"] = user.UserName;
                        Session["userAva"] = user.AvatarLink;
                        Session["UserId"] = user.UserID;
                        UserHelpers.SetCurrentUser(Session, user);
                        
                    }
                }
                else
                {
                    ModelState.AddModelError("", "UserName or password is invalid.");
                    return View();
                }
            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("Index","Home");
        }
        public ActionResult Signout()
        {
            User user = UserHelpers.GetCurrentUser(Session);
            try
            {
                GoogleConnect.Clear();
            }
            catch (Exception e) { 
            
            }
            
            Session["authenticated"] = "";
            Session["userName"] = "";
            Session["userAva"] = "";
            Session["UserId"] = "";
            ViewData["User"] = "";
            Session["loginMessageError"] = "";
            UserHelpers.SetCurrentUser(Session, null);

            return RedirectToAction("Index", "Home");
        }

        public ActionResult AuthenGoogle()
        {
            GoogleConnect.ClientId = "753316382181-58p94cof0aum06tigijhq3e1vlkqlgi8.apps.googleusercontent.com";
            GoogleConnect.ClientSecret = "1WmJi7FEw7rxs71B5EH2aH1f";
            GoogleConnect.RedirectUri = RedirectUriGoogle.AbsoluteUri.Split('?')[0];
            GoogleConnect.Authorize("profile", "email");
            return null;
        }

        private class Email
        {
            public string Value { get; set; }
            public string Type { get; set; }
        }

        private class Address
        {
            public string Value { get; set; }
            public bool Primary { get; set; }
        }
        public ActionResult GoogleCallback()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                string code = Request.QueryString["code"];
                dynamic google = JObject.Parse(GoogleConnect.Fetch("me", code));
                JArray emailList = new JArray(google.emails);
                string email = "";
                foreach (JToken x in emailList)
                {
                    Email e = x.ToObject<Email>();
                    if (e.Type.Equals("account"))
                    {
                        email = e.Value;
                    }

                }
                string avatar = google.image.url.Value;
                avatar = avatar.Substring(0, avatar.LastIndexOf("?sz=") + 4) + "200";
                JArray addressList = new JArray();
                if (google.placesLived != null)
                {
                    addressList = new JArray(google.placesLived);
                }
                string address = "";
                foreach (JToken x in addressList)
                {
                    Address a = x.ToObject<Address>();
                    if (a.Primary)
                    {
                        address = a.Value;
                    }
                }
                DatabaseHelpers dbhelp= new DatabaseHelpers();
                // select from DB
                User newUser = dbhelp.GetUserByEmail(email);
                

                //if this is first time login
                if (newUser == null)
                {
                    GooleAccountModel ggModel = new GooleAccountModel { 
                    Email= email,
                    Place=address,
                    UserFirstName = google.name.familyName.Value,
                    UserLastName= google.name.givenName.Value,
                    //Gender = google.gender == null ? 0 : google.gender.Value   
                    };
                    return View("ConfirmRegisterGoogle", ggModel);
                }
                else if (dbhelp.isLookedUser(newUser.UserName))
                {
                    // user is Locked
                    GoogleConnect.Clear();

                    ModelState.AddModelError("","Your account has been locked! Please contact us follow email: ËventZone.system@gmail.com");
                    return RedirectToAction("SignIn", "Account");
                }

                // Set the auth cookie
                Session["authenticated"] = true;
                ViewData["User"] = newUser;
                Session["userName"] = newUser.UserName;
                Session["userAva"] = newUser.AvatarLink;
                Session["UserId"] = newUser.UserID;
                Session["loginMessageError"] = "";
                UserHelpers.SetCurrentUser(Session, newUser);
            }

            return RedirectToAction("Index", "Home");
        }
        private Uri RedirectUriGoogle
        {
            get
            {
                var uriBuilder = new UriBuilder(Request.Url)
                {
                    Query = null,
                    Fragment = null,
                    Path = Url.Action("GoogleCallback")
                };
                return uriBuilder.Uri;
            }
        }

        public ActionResult ConfirmRegisterGoogle(GooleAccountModel model) {
            return View(model);
        }
        public ActionResult ExternalLoginConfirmation(GooleAccountModel model)
        {
            if (ModelState.IsValid)
            {
                User user = new User();
                List<User> listUser = new List<User>();
                listUser = db.Users.ToList();
                var newUser = listUser.FindAll(a => a.UserName.Equals(model.UserName));
                if (newUser.Count != 0)
                {
                    ModelState.AddModelError("", "UserName is already exist. Please choose another.");
                    return View("ConfirmRegisterGoogle", model);
                }
                else
                {
                   
                    user.UserEmail = model.Email;
                    user.UserName = model.UserName;
                    user.UserPassword = model.Password;
                    user.UserDOB = model.UserDOB;
                    user.Place = model.Place;
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
                //set all session for 
                Session["authenticated"] = true;
                Session["userName"] = user.UserName;
                Session["userAva"] = user.AvatarLink;
                ViewData["User"] = user;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Send email confirm
                MailHelpers.Instance.SendMailWelcome(user.UserEmail, user.UserFirstName, user.UserLastName);
                return RedirectToAction("RegisterSuccess", "Account");
            }

            // If we got this far, something failed, redisplay form
            return RedirectToAction("Index", "Home");
        }
        public ActionResult ForgotAccount() {

            return View();
        }
        public ActionResult HandleForgotPass(ForgotViewModel model)
        {
            if (ModelState.IsValid)
            {
                DatabaseHelpers dbhelper = new DatabaseHelpers();
                User user = dbhelper.GetUserByEmail(model.Email);
                if (user != null)
                {
                    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    var random = new Random();
                    var newPassword = new string(
                        Enumerable.Repeat(chars, 8)
                                  .Select(s => s[random.Next(s.Length)])
                                  .ToArray());

                    bool isUpdated = dbhelper.ResetPassword(model.Email, newPassword);
                    if (isUpdated)
                    {
                        MailHelpers.Instance.SendMailResetPassword(model.Email, newPassword);
                        return RedirectToAction("ResetPasswordSuccess", "Account");
                    }
                    else
                    {
                        ModelState.AddModelError("", "There is something wrong, please try again later!");
                    }
                }

                ModelState.AddModelError("", "Sorry we did not find your email in our database! Please try again!");

            } 
            return View("ForgotAccount", model);
        }
        public ActionResult RequireSignin()
        {
            return View();
        }
        public ActionResult ResetPasswordSuccess() {
            return View();
        }
         

    }
}
