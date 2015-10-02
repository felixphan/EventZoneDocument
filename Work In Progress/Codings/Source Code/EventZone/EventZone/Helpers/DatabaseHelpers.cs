﻿using EventZone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.Helpers
{
    public class DatabaseHelpers
    {
        private EventZoneEntities db = new EventZoneEntities();
        public bool ValidateUser(string email, string password)
        {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserEmail == email);
            if (user.Count == 0)
            {
                return false;
            }
            if (user[0].UserPassword.Trim()!= password)
            {
                return false;
            }
            return true;
        }
        public bool isLookedUser(string email) {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserEmail == email);
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
            if (user.Count == 0)
            {
                return user[0];
            }
            return null;
        
        }
    }
}