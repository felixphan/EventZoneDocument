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

        public bool CreateUserChannel(User user) {
            try
            {
                Channel channel = new Channel();
                channel.UserID = user.UserID;
                channel.ChannelName = user.UserFirstName + (user.UserLastName == "" || user.UserLastName == null ? "" : " " + user.UserLastName);
                channel.ChannelDescription = "";
                db.Channels.Add(channel);
                db.SaveChanges();
                return true;
            }
            catch {

                return false;
            }
           
            
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
                try
                {
                    thumbEventModel.avatar = GetImageByID(item.Avatar).ImageLink;
                }
                catch {
                    thumbEventModel.avatar = null;
                }
                thumbEventModel.numberView = item.View;
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
        /// <summary>
        /// get all EventPlace
        /// </summary>
        /// <returns></returns>
        public List<EventPlace> GetAllEventPlace() {
            return db.EventPlaces.ToList();
        }

        /// <summary>
        /// get location by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Location GetLocationById(long id) {
            return db.Locations.Find(id);
        }
        /// <summary>
        /// get all channel in DB
        /// </summary>
        /// <returns></returns>
        public List<Channel> GetAllChannel() { 
            return db.Channels.ToList();
        }
        /// <summary>
        /// get Channel by userID
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public Channel GetUserChannel(long userID) {
            Channel channel = new Channel();
            channel = GetAllChannel().FindAll(i => i.UserID == userID)[0];
            return channel;
        }
        /// <summary>
        /// Check a event is owned by user or not
        /// </summary>
        /// <param name="eventID"></param>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public bool IsEventOwnedByUser(long eventID, long UserID) {
            try
            {
                Channel channel = GetUserChannel(UserID);
                if (channel != null)
                {
                    Event evt = db.Events.Find(eventID);
                    if (channel.ChannelID == evt.ChannelID) return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// Check xem user like or dislike event. Nếu chưa like hoặc dislike trả lại 0;
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public LikeDislike FindLike(long userId, long eventID) {
            try
            {
                
                LikeDislike like = (from a in db.LikeDislikes where a.UserID == userId && a.EventID == eventID select a).ToList()[0];
                if (like != null)
                {
                    return like;
                }
                return null;
                
            }
            catch {
                return null;
            }
        }
        /// <summary>
        /// Like event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertLike(long userID, long eventID) {
            try
            {
                //Check user liked this event or not
                LikeDislike findLike = FindLike(userID, eventID);
               //Check user liked this event or not
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Like;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    return true;
                }
                //If user dont like or dislike this event before
                else {
                    LikeDislike like = new LikeDislike();
                    like.Type = EventZoneConstants.Like;
                    like.UserID = userID;
                    like.EventID = eventID;
                    db.LikeDislikes.Add(like);
                    db.SaveChanges();
                    return true;
                }
            }
            catch {
                return false;
            }
        }
        /// <summary>
        /// dislike event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertDislike(long userID, long eventID) {
            try
            {
                //Check user liked this event or not
                LikeDislike findLike = FindLike(userID, eventID);
                //Check user liked this event or not
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Dislike;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    return true;
                }
                //If user dont like or dislike this event before
                else
                {
                    LikeDislike like = new LikeDislike();
                    like.Type = EventZoneConstants.Dislike;
                    like.UserID = userID;
                    like.EventID = eventID;
                    db.LikeDislikes.Add(like);
                    db.SaveChanges();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// dem so like cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountLike(long eventID) {
            int countLike = (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Like select a).Count();
            return countLike;
        }

        /// <summary>
        /// dem so dislike cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountDisLike(long eventID) {
            int disLike = (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Dislike select a).Count();
            return disLike;
        }
        /// <summary>
        /// Count number followers of an event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountFollowerOfEvent(long eventID) {
            int NumberFollower = (from a in db.EventFollows where a.EventID == eventID select a).ToList().Count;
            return NumberFollower;
        }        
        /// <summary>
        /// add view for event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool AddView(long eventID) {
            Event evt= GetEventByID(eventID);
            if (evt != null) {
                evt.View += 1;
                db.Entry(evt).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            return false;
        }
        /// <summary>
        /// get Image by ID
        /// </summary>
        /// <param name="imageID"></param>
        /// <returns></returns>
        public Image GetImageByID(long? imageID)
        {
            return db.Images.Find(imageID);

        }
        /// <summary>
        /// Check is user following a category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool IsFollowingCategory(long userID, long categoryID) { 
        CategoryFollow carFollow= (from a in db.CategoryFollows where a.FollowerID==userID&&a.CategoryID==categoryID select a).ToList()[0];
        if(carFollow!=null){
            return true;
        }
            return false;
        }

        /// <summary>
        /// User Follow a new category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool FollowCategory(long userID, long categoryID) {
            try
            {
                CategoryFollow carFollow = new CategoryFollow();
                carFollow.FollowerID = userID;
                carFollow.CategoryID = categoryID;
                db.CategoryFollows.Add(carFollow);
                db.SaveChanges();
                return true;
            }
            catch {
                return false;
            }
        }
        /// <summary>
        /// Check is user following another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool IsFollowingUser(long FollowerID, long FollowingID)
        {
            PeopleFollow people = (from a in db.PeopleFollows where a.FollowerUserID == FollowerID && a.FollowingUserID == FollowingID select a).ToList()[0];
            if (people != null)
            {
                return true;
            }
            return false;
        }
        /// <summary>
        /// User Follows another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool FollowingPeople(long FollowerID, long FollowingID) {
            try
            {
                PeopleFollow ppfollow = new PeopleFollow();
                ppfollow.FollowerUserID = FollowerID;
                ppfollow.FollowingUserID = FollowingID;
                db.PeopleFollows.Add(ppfollow);
                db.SaveChanges();
                return true;
            }
            catch {
                return false;
            }
        }
        /// <summary>
        /// Check is user following a event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool IsFollowingEvent(long userID, long eventID) {
            try
            {
                EventFollow evtFollow = (from a in db.EventFollows where a.FollowerID == userID && a.EventID == eventID select a).ToList()[0];
                if (evtFollow != null)
                {
                    return true;
                }
                return false;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// User follows event
        /// </summary>
        /// <param name="useID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool FollowEvent(long useID, long eventID) {
            try
            {
                if (IsFollowingEvent(useID, eventID)) {
                    UnFollowEvent(useID, eventID);
                    return true;
                }
                EventFollow evtFollow = new EventFollow();
                evtFollow.EventID = eventID;
                evtFollow.FollowerID = useID;
                db.EventFollows.Add(evtFollow);
                db.SaveChanges();
                return true;
            }
            catch {
                return false;
            }
        }
        public bool UnFollowEvent(long userId, long eventId) {
            try
            {
                EventFollow follow = (from a in db.EventFollows where a.FollowerID == userId && a.EventID == eventId select a).ToList()[0];
                db.EventFollows.Remove(follow);
                db.SaveChanges();
                return true;
            }
            catch {
                return false;
            }
        }
        /// <summary>
        /// count numbers event of user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public int CountOwnedEvent(long userID) {
            try
            {
                long channelID = GetUserChannel(userID).ChannelID;
                int k = (from a in db.Events where a.ChannelID == channelID select a).Count();
                return k;
            }
            catch {
                return 0;
            }
        }
        /// <summary>
        /// count number follower
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public int NumberFollower(long UserID) {
            try
            {
                int k = (from a in db.PeopleFollows where a.FollowingUserID == UserID select a).Count();
                return k;
            }
            catch {
                return 0;
            }
        }
        /// <summary>
        /// get thumb list user from list user for viewing
        /// </summary>
        /// <param name="listUser"></param>
        /// <returns></returns>
        public List<ViewThumbUserModel> GetUserThumbByList(List<User> listUser) {
            List<ViewThumbUserModel> listView = new List<ViewThumbUserModel>();
            if (listUser == null) { return null; }
            foreach (var item in listUser) {
                ViewThumbUserModel view = new ViewThumbUserModel();
                view.UserID = item.UserID;
                view.Avatar = item.AvatarLink;
                view.Name = item.UserFirstName + (item.UserLastName == null || item.UserLastName == "" ? "" : item.UserLastName);
                view.NumberFollower = NumberFollower(item.UserID);
                view.NumberOwnedEvent = CountOwnedEvent(item.UserID);
                listView.Add(view);
            }
            return listView;
        }
        public List<Comment> GetListComment(long eventID)
        {
            try
            {
                List<Comment> listComment = (from a in db.Comments where a.EventID == eventID select a).ToList();
                return listComment;
            }
            catch {
                return null;
            }
        }

    }
}