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
        public User GetUserByID(long? userID) {
            List<User> listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserID == userID);
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

        public bool UpdateUser(User user) {
            try
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch {
                return false;
            }
        }
        public List<Event> GetEventsByUser(long? userID)
        {
            List<Channel> listChannel= db.Channels.ToList();
            if (listChannel.FindAll(i => i.UserID == userID).Count==0) { return null; }
            Channel mychannel= listChannel.FindAll(i=>i.UserID==userID)[0];
            List<Event> listEvent = db.Events.ToList();
            List<Event> myEvent = listEvent.FindAll(i => i.ChannelID == mychannel.ChannelID);
            return myEvent;
        }
        public List<Location> GetEventLocation(long EventID) {//get all locations of an event
            List<EventPlace> listEventPlace = db.EventPlaces.ToList();//load all event place
            List<EventPlace> listEventLocation = listEventPlace.FindAll(i => i.EventID == EventID);//select current event places
            List<Location> listLocation= new List<Location>();
            List<Location> result = new List<Location>();
            foreach (var item in listEventLocation) {
                var loc = listLocation.FindAll(i => i.LocationID == item.LocationID)[0];
                result.Add(loc);
            }
            return result;
        }
    }
}