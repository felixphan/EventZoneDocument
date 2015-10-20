using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace EventZoneC.Models
{
    public class UsersController : Controller
    {
        private EventZoneEntities3 db = new EventZoneEntities3();

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
        public ActionResult SetMod(int UserID)
        {
    

            List<User> listUser = new List<User>();
           var userChange = db.Users.Include(u=>u.EventFollows);
             userChange = userChange.Where(u => u.UserID == UserID);
             listUser = userChange.ToList();

            if (userChange != null)
            {
                if (listUser[0].UserRoles ==0){
                    listUser[0].UserRoles = 1;
                }
                
                else
                {
                    listUser[0].UserRoles = 0;
                }
               // db.Entry(userChange).State = EntityState.Modified;
                db.SaveChanges();


            }
            userChange = db.Users.Include(u => u.EventFollows);
            return View("ManageUsers", userChange);
        }
        public ActionResult Lock(int UserID)
        {



            List<User> listUser = new List<User>();
            var userChange = db.Users.Include(u => u.EventFollows);
            userChange = userChange.Where(u => u.UserID == UserID);
            listUser = userChange.ToList();

            if (userChange != null)
            {
                if (listUser[0].AccountStatus == true)
                {
                    listUser[0].AccountStatus = false;
                }

                else
                {
                    listUser[0].AccountStatus = true;
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
        public ActionResult Edit([Bind(Include = "UserID,UserName,TypeID,UserPassword,UserFirstName,UserLastName,UserEmail,UserDOB,IDCard,UserRoles,Phone,Place,AccountStatus,Gender,AvatarLink")] User user)
        {
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
