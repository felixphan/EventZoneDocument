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

        public EventZoneEntities data() {
            return db;
        }
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
        ///<summary>
        ///get all locations of an event
        ///</summary>
        public List<Location> GetEventLocation(long EventID) {
            List<EventPlace> listEventPlace = db.EventPlaces.ToList();//load all event place
            List<EventPlace> listEventLocation = listEventPlace.FindAll(i => i.EventID == EventID);//select current event places
            List<Location> listLocation= db.Locations.ToList();
            List<Location> result = new List<Location>();
            foreach (var item in listEventLocation) {
                var loc = listLocation.FindAll(i => i.LocationID == item.LocationID)[0];
                result.Add(loc);
            }
            return result;
        }
        /// <summary>
        /// Get event by eventID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Event GetEventByID(long? id) {
            try
            {
                return db.Events.Find(id);
            }
            catch {
                return null;
            }
        }
        /// <summary>
        /// Get all image of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<Image> GetEventImage(long? id) {
            List<Image> eventImage= new List<Image>();
            List<Image> allImage= db.Images.ToList();
            if(allImage.Count!=0){    
            eventImage = allImage.FindAll(i=>i.EventID==id);
            return eventImage;
            }
            return null;
        }
        /// <summary>
        /// Get all video of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns> </returns>
        public List<Video> GetEventVideo(long? id)
        {
            List<Video> eventVideo= new List<Video>();
            List<EventPlace> allEventPlace = db.EventPlaces.ToList();//retrieve data from table EventPlace
            //find all video of event;
            List<EventPlace> listPlace=allEventPlace.FindAll(i=>i.EventID==id);
            List<Video> allVideo= db.Videos.ToList();// retrieve data from talble Video
            if(listPlace.Count!=0){
                foreach (var item in listPlace) {
                    List<Video> listVideo = allVideo.FindAll(i => i.EventPlaceID == item.EventPlaceID);
                    foreach (var video in listVideo)
                    {
                        eventVideo.Add(video);
                    }
                }

                return eventVideo;
            }
            return null;
        }
        /// <summary>
        /// Get all comment of an event
        /// </summary>
        /// <returns></returns>
        public List<Comment> GetEventComment(long ?id) {
            List<Comment> eventComment= new List<Comment>();
            List<Comment> allComment = db.Comments.ToList();

            if (allComment.Count != 0) {
                eventComment = allComment.FindAll(i => i.EventID == id);
                return eventComment;
            }
            
            return null;
        }
        /// <summary>
        /// Lay thong tin nguoi dang event
        /// </summary>
        /// <param name="eventId"></param>
        /// <returns></returns>
        public User GetAuthorEvent(long? eventId) {
            Event evt = db.Events.Find(eventId);
            List<Channel> listChannel = db.Channels.ToList();// retrieve all Channel fromm table Channel
            Channel authorChannel = listChannel.FindAll(i => i.ChannelID == evt.ChannelID)[0];
            if (evt != null) {
                List<User> listUser = db.Users.ToList();//retrieve all user from table user
                User user = listUser.FindAll(i => i.UserID == authorChannel.UserID)[0];
                if (user != null) return user;
                return null;
            }
            return null;
        }
        /// <summary>
        /// trả lại event có tên, địa điểm hoặc description trùng với keyword 
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchEventByKeyword(string keyword) {
            if (keyword == ""||keyword==null) {
                return db.Events.ToList();
            }
            keyword= keyword.ToLower();
            List<Event> listResult = new List<Event>();
            listResult = (from a in db.Events.AsEnumerable() where a.EventName.ToLower().Contains(keyword) || a.EventPlaces.ToArray().ToString().ToLower().Contains(keyword) || a.EventDescription.ToLower().Contains(keyword) select a).ToList();
            return listResult;
        }
        /// <summary>
        /// trả lại live event
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchLiveStreamByKeyword(string keyword) {
            List<Event> listEvent = SearchEventByKeyword(keyword);
            List<Event> currentStream = new List<Event>();
            foreach (var item in listEvent)
            {
                if(isLive(item.EventID)){
                    currentStream.Add(item);
                }
            }
            return currentStream;
        }
        public bool isLive(long? id) {
            List<EventPlace> listEventPlace = db.EventPlaces.ToList();//load all eventPlace
            List<EventPlace> myEvenPlace = listEventPlace.FindAll(i => i.EventID == id);// load event place of this event
            List<Video> video = db.Videos.ToList();
            foreach (var item in myEvenPlace) { 
                List<Video> videoInPlace= video.FindAll(i=>i.EventPlaceID==item.EventPlaceID).ToList();
                DateTime currTime= DateTime.Now;
                foreach(var item1 in videoInPlace){
                    DateTime start= item1.StartTime;
                    DateTime? end= item1.EndTime;
                    if(end!=null&&start.CompareTo(currTime)<=0&&currTime.CompareTo(end)<0){
                    return true;
                    }
                }
            }
            return false;
        }
        /// <summary>
        /// Search user By keyword
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<User> SearchUserByKeyword(string keyword) {
            if (keyword == ""||keyword==null)
            {
                return db.Users.ToList();
            }
            keyword= keyword.ToLower();
            
            List<User> listUser = (from a in db.Users where a.UserFirstName.ToLower().Contains(keyword) || a.UserLastName.ToLower().Contains(keyword) select a).ToList();
            return listUser;
        }
        public List<ViewThumbEventModel> GetThumbEventListByListEvent(List<Event> listEvent)
        {
            
            List<ViewThumbEventModel> listThumbEvent = new List<ViewThumbEventModel>();
            if (listEvent == null) return listThumbEvent;
            foreach (var item in listEvent)
            {
                ViewThumbEventModel thumbEventModel = new ViewThumbEventModel();
                thumbEventModel.eventId = item.EventID;
                thumbEventModel.avartarLink = item.AvatarLink;
                thumbEventModel.eventName = item.EventName;
                thumbEventModel.StartTime = item.EventStartDate;
                thumbEventModel.EndTime = item.EventEndDate;
                thumbEventModel.location = GetEventLocation(item.EventID);
                listThumbEvent.Add(thumbEventModel);
            }
            return listThumbEvent;
        }
        /// <summary>
        /// get all category
        /// </summary>
        /// <returns></returns>
        public List<Category> GetAllCategory() {
            return db.Categories.ToList();
        }
        /// <summary>
        /// Lọc event theo nhóm category từ list event
        /// </summary>
        /// <param name="listEvent"></param>
        /// <param name="listCategory"></param>
        /// <returns></returns>
        public List<Event> SearchByCategory(List<Event> listEvent, long[] listCategory){
            if (listCategory.Length == 0) { return listEvent; }
            if (listEvent.Count==0) { return null; }

            List<Event> result = new List<Event>();
            for (int i = 0; i < listCategory.Length; i++) {
                List<Event> item = listEvent.FindAll(m => m.CategoryID == listCategory[i]);
                foreach (var evt in item) {
                    result.Add(evt);
                }
            }
                return result;
        }
        /// <summary>
        /// Tinh khoang cach giua 2 location
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public double CalculateDistance(Location p1, Location p2)
        {
            // using formula in http://www.movable-type.co.uk/scripts/latlong.html
            double R = 6371; // distance of the earth in km
            double dLatitude = Radians(p1.Latitude - p2.Latitude);      // different in Rad of latitude
            double dLongitude = Radians(p1.Longitude - p2.Longitude);   // different in Rad of longitude

            double a = Math.Sin(dLatitude / 2) * Math.Sin(dLatitude / 2) + Math.Cos(Radians(p1.Latitude)) * Math.Cos(Radians(p2.Latitude))
                        * Math.Sin(dLongitude / 2) * Math.Sin(dLongitude / 2);
            double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1.0 - a));
            return R * c;
        }
        private double Radians(double x)
        {
            return x * Math.PI / 180.0;
        }
        /// <summary>
        /// Tim kiem Su kien xung quanh 1 dia diem, default ban kinh = 20km
        /// </summary>
        /// <param name="location"></param>
        /// <param name="distance"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventAroundLocation(Location seachlocation, double distance = 20, List<Event> listEvent = null) {
            if (listEvent == null) {
                return null;
            }
            List<Event> result= new List<Event>();
            foreach(var item in listEvent){
                List<Location> eventLocation = GetEventLocation(item.EventID);
                foreach (var location in eventLocation) {
                    if (CalculateDistance(location, seachlocation) <= distance) {
                        if(!result.Contains(item))
                        result.Add(item);
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// get event in date range from event list
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventInDateRange(DateTime startDate, DateTime endDate, List<Event> listEvent= null) {
            if (listEvent == null)
            {
                return null;
            }
            List<Event> result= new List<Event>();

            foreach (var item in listEvent) {
                if (item.EventStartDate.CompareTo(endDate) <= 0 && item.EventStartDate.CompareTo(startDate) >= 0)
                    result.Add(item);
            }
           
            return result;

        }
        /// <summary>
        /// get all location in db
        /// </summary>
        /// <returns></returns>
        public List<Location> GetAllLocation() {
            return db.Locations.ToList();
        }
        public List<EventPlace> GetAllEventPlace() {
            return db.EventPlaces.ToList();
        }
        public Location GetLocationById(long id) {
            return db.Locations.Find(id);
        }
    }

}