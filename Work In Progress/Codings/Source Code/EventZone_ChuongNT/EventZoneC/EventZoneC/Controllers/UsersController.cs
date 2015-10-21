using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using EventZoneC.Helpers;
using EventZoneC.Models;


namespace EventZoneC.Models
{
    public class UsersController : Controller
    {
        private EventZoneEntities4 db = new EventZoneEntities4();
        
        // GET: Users
        public ActionResult ManageUsers()
        {
            var user = db.Users.Include(u => u.Images);
            

            return View("ManageUsers",user.ToList());
        }
        //public ActionResult Search()
        //{
        //    return View();
        //}
        public ActionResult SearchUser(string userName)
        {
          
            var user = db.Users.Include(u => u.PeopleFollows);
             user= user.Where(u => u.UserName.Contains(userName));

            //TempData["alerMessage"] = " Create account successful";
            //if (userChange != null)
            //{
            //    userChange.UserRoles = 1;
            //    db.Entry(userChange).State = EntityState.Modified;
            //    db.SaveChanges();


            //}
             return View("ManageUsers", user.ToList());
        }
        //public ActionResult SetMod(long? id)
        //{
        //    if (id == null)
        //    {
        //        return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
        //    }
        //    User user = db.Users.Find(id);
        //    if (user == null)
        //    {
        //        return HttpNotFound();
        //    }
        //    return View(user);
        //}
        public ActionResult SetMod(int UserID, int AdminID)
        {
    

            List<User> listUser = new List<User>();
           var userChange = db.Users.Include(u=>u.EventFollows);
             userChange = userChange.Where(u => u.UserID == UserID);
             listUser = userChange.ToList();
             TrackingUser track = new TrackingUser();
             track.ActorID = AdminID;
             track.ReceiverID = UserID;
            //senderType, receiverType:
            //user, mod, admin: 0
            // event: 1, report: 2, appeal: 3
           
             track.ActionTime = DateTime.Now;
            if (userChange != null)
            {
                if (listUser[0].UserRoles ==0){
                    listUser[0].UserRoles = 1;
                    track.ActionID = 5;
                    db.TrackingUsers.Add(track);
                }
                
                else
                {
                    listUser[0].UserRoles = 0;
                    track.ActionID = 6;
                    db.TrackingUsers.Add(track);
                }
               // db.Entry(userChange).State = EntityState.Modified;
                db.SaveChanges();


            }
            userChange = db.Users.Include(u => u.EventFollows);
            return View("ManageUsers", userChange);
        }
        public ActionResult Lock(int UserID, int AdminID)
        {



            List<User> listUser = new List<User>();
            var userChange = db.Users.Include(u => u.EventFollows);
            userChange = userChange.Where(u => u.UserID == UserID);
            listUser = userChange.ToList();
            TrackingUser track = new TrackingUser();
            track.ActorID = AdminID;
            track.ReceiverID = UserID;
            
           
            track.ActionTime = DateTime.Now;
            if (userChange != null)
            {
                if (listUser[0].AccountStatus == true)
                {
                    listUser[0].AccountStatus = false;
                    track.ActionID = 1;
                    db.TrackingUsers.Add(track);
                }

                else
                {
                    listUser[0].AccountStatus = true;
                    track.ActionID = 2;
                    db.TrackingUsers.Add(track);
                }
                // db.Entry(userChange).State = EntityState.Modified;
                db.SaveChanges();


            }
            userChange = db.Users.Include(u => u.EventFollows);
            
            return View("ManageUsers", userChange);
        }
        
        // GET: Users/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: Users/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Users/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "UserID,UserName,TypeID,UserPassword,UserFirstName,UserLastName,UserEmail,UserDOB,IDCard,0,Phone,Place,1,Gender,AvatarLink")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("ManageUsers");
            }

            return View(user);
        }

        // GET: Users/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "UserID,UserName,EditBy,UserPassword,UserFirstName,UserLastName,UserEmail,UserDOB,IDCard,UserRoles,Phone,Place,AccountStatus,Gender,AvatarLink,EditTime")] User user, long AdminID)
        {
            user.EditTime = DateTime.Now;
            user.EditBy = AdminID;
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("ManageUsers");
            }
            return View(user);
        }

        // GET: Users/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("ManageUser");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
