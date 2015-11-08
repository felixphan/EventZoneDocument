using EventZone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.AdminHelpers
{
    public class UserAdminHelpers
    {
        private EventZoneEntities db = new EventZoneEntities();


        private const string User = "user";
        public static User GetCurrentUser(HttpSessionStateBase session)
        {

            var userSession = session[User];

            if (userSession == null || userSession.ToString().Length == 0)
            {
                return null;
            }
            var user = (User)userSession;

            return user;
        }
        public static void SetCurrentUser(HttpSessionStateBase session, User user)
        {
            session[User] = user;
        }
        public  User getUser(string userName)
        {
            var user = db.Users.ToList();
            user = user.FindAll(u => u.UserName.Contains(userName));
            return (User)user[0];
        }

    }
}