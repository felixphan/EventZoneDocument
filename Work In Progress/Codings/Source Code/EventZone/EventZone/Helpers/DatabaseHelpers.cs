using EventZone.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace EventZone.Helpers
{
    public class DatabaseHelpers : SingletonBase<DatabaseHelpers>
    {
        private EventZoneEntities db = new EventZoneEntities();
        public bool ValidateUser(string userName, string password)
        {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count == 0)
            {
                return false;
            }
            if (user[0].UserPassword!= password)
            {
                return false;
            }
            return true;
        }
        public bool isLookedUser(string userName) {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count == 0)
            {
                return false;
            }
            if (user[0].AccountStatus == EventZoneConstants.IsUserLock)
            {
                return true;
            }
            return false;
        }
        public User GetUserByEmail(string email) {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserEmail == email);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        
        }

        public User GetUserByUserName(string userName)
        {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;

        }
        public bool ResetPassword(string email, string password) {
            User user = GetUserByEmail(email);
            if (user != null) {
                user.UserPassword = password;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            return false;
        }
    }
}