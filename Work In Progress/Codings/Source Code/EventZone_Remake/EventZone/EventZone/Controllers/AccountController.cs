using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using ASPSnippets.GoogleAPI;
using EventZone.Helpers;
using EventZone.Models;
using Newtonsoft.Json.Linq;

namespace EventZone.Controllers
{
    public class AccountController : Controller
    {
        private readonly EventZoneEntities db = new EventZoneEntities();

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

            if (UserDatabaseHelper.Instance.ValidateUser(model.UserName, model.Password))
            {
                if (UserDatabaseHelper.Instance.isLookedUser(model.UserName))
                {
                    ModelState.AddModelError("", "Your account is locked! Please contact with our support");
                    return Json(new
                    {
                        state = 0,
                        message = "Your account is locked! Please contact with our support"
                    });
                }

                var user = UserDatabaseHelper.Instance.GetUserByUserName(model.UserName);
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
                var user = new User();
                var listUser = new List<User>();
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
                user.UserEmail = model.Email;
                user.UserName = model.UserName;
                user.UserPassword = model.Password;
                user.UserDOB = model.UserDOB;
                user.UserFirstName = model.UserFirstName;
                user.DataJoin = DateTime.Today;
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
                //set all session for 
                Session["authenticated"] = true;
                Session["userName"] = user.UserName;
                Session["userAva"] = user.AvatarLink;
                Session["UserId"] = user.UserID;
                UserHelpers.SetCurrentUser(Session, user);

                //Create Channel
                UserDatabaseHelper.Instance.CreateUserChannel(user);
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

        public ActionResult AuthenGoogle()
        {
            GoogleConnect.ClientId = "753316382181-58p94cof0aum06tigijhq3e1vlkqlgi8.apps.googleusercontent.com";
            GoogleConnect.ClientSecret = "1WmJi7FEw7rxs71B5EH2aH1f";
            GoogleConnect.RedirectUri = RedirectUriGoogle.AbsoluteUri.Split('?')[0];
            GoogleConnect.Authorize("profile", "email");
            return null;
        }

        public ActionResult GoogleCallback()
        {
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["code"]))
                {
                    var code = Request.QueryString["code"];
                    dynamic google = JObject.Parse(GoogleConnect.Fetch("me", code));
                    var emailList = new JArray(google.emails);
                    var email = "";
                    foreach (var x in emailList)
                    {
                        var e = x.ToObject<Email>();
                        if (e.Type.Equals("account"))
                        {
                            email = e.Value;
                        }
                    }
                    string avatar = google.image.url.Value;
                    avatar = avatar.Substring(0, avatar.LastIndexOf("?sz=") + 4) + "200";
                    var addressList = new JArray();
                    if (google.placesLived != null)
                    {
                        addressList = new JArray(google.placesLived);
                    }
                    var address = "";
                    foreach (var x in addressList)
                    {
                        var a = x.ToObject<Address>();
                        if (a.Primary)
                        {
                            address = a.Value;
                        }
                    }
                    // select from DB
                    var newUser = UserDatabaseHelper.Instance.GetUserByEmail(email);


                    //if this is first time login
                    if (newUser == null)
                    {
                        var ggModel = new GoogleAccountModel
                        {
                            Email = email,
                            Place = address,
                            UserFirstName = google.name.familyName.Value,
                            UserLastName = google.name.givenName.Value
                            //Gender = google.gender == null ? 0 : google.gender.Value   
                        };
                        return View("ConfirmRegisterGoogle", ggModel);
                    }
                    if (UserDatabaseHelper.Instance.isLookedUser(newUser.UserName))
                    {
                        // user is Locked
                        GoogleConnect.Clear();
                        ModelState.AddModelError("",
                            "Your account has been locked! Please contact us follow email: EventZone.system@gmail.com");
                        return RedirectToAction("SignIn", "Account");
                    }

                    // Set the auth cookie
                    Session["authenticated"] = true;
                    Session["userName"] = newUser.UserName;
                    Session["userAva"] = newUser.AvatarLink;
                    Session["UserId"] = newUser.UserID;
                    Session["loginMessageError"] = "";
                    UserHelpers.SetCurrentUser(Session, newUser);
                }

                return RedirectToAction("Index", "Home");
            }
            catch
            {
                return View("ErrorLoginGoogle");
            }
        }

        public ActionResult ConfirmRegisterGoogle(GoogleAccountModel model)
        {
            return View(model);
        }

        public ActionResult ExternalLoginConfirmation(GoogleAccountModel model)
        {
            if (ModelState.IsValid)
            {
                var user = new User();
                var listUser = new List<User>();
                listUser = db.Users.ToList();
                var newUser = listUser.FindAll(a => a.UserName.Equals(model.UserName));
                if (newUser.Count != 0)
                {
                    ModelState.AddModelError("", "UserName is already exist. Please choose another.");
                    return View("ConfirmRegisterGoogle", model);
                }
                user.UserEmail = model.Email;
                user.UserName = model.UserName;
                user.UserPassword = model.Password;
                user.UserDOB = model.UserDOB;
                user.Place = model.Place;
                user.UserFirstName = model.UserFirstName;
                user.DataJoin = DateTime.Today;
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
                //set all session for 
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

        public ActionResult Signout()
        {
            var user = UserHelpers.GetCurrentUser(Session);
            try
            {
                GoogleConnect.Clear();
            }
            catch (Exception e)
            {
            }

            Session["authenticated"] = "";
            Session["userName"] = "";
            Session["userAva"] = "";
            Session["UserId"] = "";
            Session["loginMessageError"] = "";
            UserHelpers.SetCurrentUser(Session, null);

            return RedirectToAction("Index", "Home");
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

        public ActionResult ForgotPassword()
        {
            return PartialView();
        }

        public ActionResult HandleForgotPass(ForgotViewModel model)
        {
            if (ModelState.IsValid)
            {
                var user = UserDatabaseHelper.Instance.GetUserByEmail(model.Email);
                if (user != null)
                {
                    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
                    var random = new Random();
                    var newPassword = new string(
                        Enumerable.Repeat(chars, 8)
                            .Select(s => s[random.Next(s.Length)])
                            .ToArray());

                    var isUpdated = UserDatabaseHelper.Instance.ResetPassword(model.Email, newPassword);
                    if (isUpdated)
                    {
                        MailHelpers.Instance.SendMailResetPassword(model.Email, newPassword);
                        return Json(new
                        {
                            state = 1,
                            message = "Reset Password Successfully"
                        });
                    }
                    return Json(new
                    {
                        state = 0,
                        message = "Something Wrong! Please Try Again Later"
                    });
                }

                return Json(new
                {
                    state = 0,
                    message = "We Couldn't Find Your Email in Our Database"
                });
            }
            return Json(new
            {
                state = 0,
                message = "Something Wrong! Please Try Again Later"
            });
        }
    }
}