using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using EventZone.Models;

namespace EventZone.Helpers
{
    /// <summary>
    ///     All functions related to User
    /// </summary>
    public class UserDatabaseHelper : SingletonBase<UserDatabaseHelper>
    {
        private readonly EventZoneEntities db;

        private UserDatabaseHelper()
        {
            db = new EventZoneEntities();
        }

        /// <summary>
        ///     Check is user exists in database or not. If yes return true, else return false.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool ValidateUser(string userName, string password)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count == 0)
            {
                return false;
            }
            if (user[0].UserPassword != password)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        ///     Check is user's status locked or not. If user's status is locked, return true else return false
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public bool isLookedUser(string userName)
        {
            var listUser = db.Users.ToList();
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

        /// <summary>
        ///     Create a default channel for user when they signup first time. return true if success, else return false
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public bool CreateUserChannel(User user)
        {
            try
            {
                var channel = new Channel();
                channel.UserID = user.UserID;
                channel.ChannelName = user.UserFirstName +
                                      (user.UserLastName == "" || user.UserLastName == null
                                          ? ""
                                          : " " + user.UserLastName);
                channel.ChannelDescription = "";
                db.Channels.Add(channel);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     get all channel in DB
        /// </summary>
        /// <returns></returns>
        public List<Channel> GetAllChannel()
        {
            return db.Channels.ToList();
        }

        /// <summary>
        ///     get Channel by userID
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public Channel GetUserChannel(long userID)
        {
            var channel = new Channel();
            channel = GetAllChannel().FindAll(i => i.UserID == userID)[0];
            return channel;
        }

        /// <summary>
        ///     count numbers event of user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public int CountOwnedEvent(long userID)
        {
            try
            {
                var channelID = GetUserChannel(userID).ChannelID;
                var k = (from a in db.Events where a.ChannelID == channelID select a).Count();
                return k;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        ///     get thumb list user from list user for viewing
        /// </summary>
        /// <param name="listUser"></param>
        /// <returns></returns>
        public List<ViewThumbUserModel> GetUserThumbByList(List<User> listUser)
        {
            var listView = new List<ViewThumbUserModel>();
            if (listUser == null)
            {
                return null;
            }
            foreach (var item in listUser)
            {
                var view = new ViewThumbUserModel();
                view.UserID = item.UserID;
                view.Avatar = item.AvatarLink;
                view.Name = item.UserFirstName +
                            (item.UserLastName == null || item.UserLastName == "" ? "" : item.UserLastName);
                view.NumberFollower = NumberFollower(item.UserID);
                view.NumberOwnedEvent = Instance.CountOwnedEvent(item.UserID);
                listView.Add(view);
            }
            return listView;
        }

        /// <summary>
        ///     Check is user following another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool IsFollowingUser(long FollowerID, long FollowingID)
        {
            var people =
                (from a in db.PeopleFollows
                 where a.FollowerUserID == FollowerID && a.FollowingUserID == FollowingID
                 select a).ToList()[0];
            if (people != null)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        ///     User Follows another user
        /// </summary>
        /// <param name="FollowerID"></param>
        /// <param name="FollowingID"></param>
        /// <returns></returns>
        public bool FollowingPeople(long FollowerID, long FollowingID)
        {
            try
            {
                var ppfollow = new PeopleFollow();
                ppfollow.FollowerUserID = FollowerID;
                ppfollow.FollowingUserID = FollowingID;
                db.PeopleFollows.Add(ppfollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     Check is user following a event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool IsFollowingEvent(long userID, long eventID)
        {
            try
            {
                var evtFollow =
                    (from a in db.EventFollows where a.FollowerID == userID && a.EventID == eventID select a).ToList()[0
                        ];
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
        ///     User follows event
        /// </summary>
        /// <param name="useID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool FollowEvent(long useID, long eventID)
        {
            try
            {
                if (IsFollowingEvent(useID, eventID))
                {
                    UnFollowEvent(useID, eventID);
                    return true;
                }
                var evtFollow = new EventFollow();
                evtFollow.EventID = eventID;
                evtFollow.FollowerID = useID;
                db.EventFollows.Add(evtFollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool UnFollowEvent(long userId, long eventId)
        {
            try
            {
                var follow =
                    (from a in db.EventFollows where a.FollowerID == userId && a.EventID == eventId select a).ToList()[0
                        ];
                db.EventFollows.Remove(follow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     Check xem user like or dislike event. Nếu chưa like hoặc dislike trả lại 0;
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public LikeDislike FindLike(long userId, long eventID)
        {
            try
            {
                var like =
                    (from a in db.LikeDislikes where a.UserID == userId && a.EventID == eventID select a).ToList()[0];
                if (like != null)
                {
                    return like;
                }
                return null;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Like event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertLike(long userID, long eventID)
        {
            try
            {
                //Check user liked this event or not		
                var findLike = FindLike(userID, eventID);
                //Check user liked this event or not		
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Like;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    return true;
                }
                //If user dont like or dislike this event before		
                var like = new LikeDislike();
                like.Type = EventZoneConstants.Like;
                like.UserID = userID;
                like.EventID = eventID;
                db.LikeDislikes.Add(like);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     dislike event
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool InsertDislike(long userID, long eventID)
        {
            try
            {
                //Check user liked this event or not		
                var findLike = FindLike(userID, eventID);
                //Check user liked this event or not		
                if (findLike != null)
                {
                    findLike.Type = EventZoneConstants.Dislike;
                    db.Entry(findLike).State = EntityState.Modified;
                    db.SaveChanges();
                    return true;
                }
                //If user dont like or dislike this event before		
                var like = new LikeDislike();
                like.Type = EventZoneConstants.Dislike;
                like.UserID = userID;
                like.EventID = eventID;
                db.LikeDislikes.Add(like);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     count number follower of user
        /// </summary>
        /// <param name="UserID"></param>
        /// <returns></returns>
        public int NumberFollower(long UserID)
        {
            try
            {
                var k = (from a in db.PeopleFollows where a.FollowingUserID == UserID select a).Count();
                return k;
            }
            catch
            {
                return 0;
            }
        }

        /// <summary>
        ///     Check is user following a category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool IsFollowingCategory(long userID, long categoryID)
        {
            try
            {
                var carFollow =
                    (from a in db.CategoryFollows where a.FollowerID == userID && a.CategoryID == categoryID select a).ToList()[0];
                if (carFollow != null)
                {
                    return true;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        /// <summary>
        ///    Follow category if user doest now follow it, unfollow category if user is following this category
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public bool FollowCategory(long userID, long categoryID)
        {
            try
            {
                var catFollow = new CategoryFollow();
                if (IsFollowingCategory(userID, categoryID))
                {
                    catFollow = (from a in db.CategoryFollows where a.CategoryID == categoryID && a.FollowerID == userID select a).ToList()[0];
                    db.CategoryFollows.Remove(catFollow);
                    db.SaveChanges();
                    return true;
                }
                catFollow.FollowerID = userID;
                catFollow.CategoryID = categoryID;
                db.CategoryFollows.Add(catFollow);
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     find user by email, return null if not found
        /// </summary>
        /// <param name="email"></param>
        /// <returns></returns>
        public User GetUserByEmail(string email)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserEmail == email);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }

        /// <summary>
        ///     get user by user name, return null if not found
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public User GetUserByUserName(string userName)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserName == userName);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }

        /// <summary>
        ///     Get user by userId, return null if not found
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public User GetUserByID(long? userID)
        {
            var listUser = db.Users.ToList();
            var user = listUser.FindAll(i => i.UserID == userID);
            if (user.Count != 0)
            {
                return user[0];
            }
            return null;
        }

        /// <summary>
        ///     Update User to database
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public bool UpdateUser(User user)
        {
            try
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        ///     Change user password
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public bool ResetPassword(string email, string password)
        {
            var user = GetUserByEmail(email);
            if (user != null)
            {
                user.UserPassword = password;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            return false;
        }

        /// <summary>
        ///     Search user By keyword
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<User> SearchUserByKeyword(string keyword)
        {
            if (keyword == "" || keyword == null)
            {
                return db.Users.ToList();
            }
            keyword = keyword.ToLower();

            var listResult = new List<User>();

            var retrievedResult = (from x in listResult
                                   where x.UserFirstName.ToLower().Contains(keyword) || x.UserLastName.ToLower().Contains(keyword)
                                   select x).ToList();
            return retrievedResult;
        }
    }

    /// <summary>
    ///     All function related to Event
    /// </summary>
    public class EventDatabaseHelper : SingletonBase<EventDatabaseHelper>
    {
        private readonly EventZoneEntities db;

        private EventDatabaseHelper()
        {
            db = new EventZoneEntities();
        }
        /// <summary>
        ///     get all event of an user
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public List<Event> GetEventsByUser(long? userID)
        {
            var listChannel = db.Channels.ToList();
            if (listChannel.FindAll(i => i.UserID == userID).Count == 0)
            {
                return null;
            }
            var mychannel = listChannel.FindAll(i => i.UserID == userID)[0];
            var listEvent = db.Events.ToList();
            var myEvent = listEvent.FindAll(i => i.ChannelID == mychannel.ChannelID);
            return myEvent;
        }

        /// <summary>
        ///     get all locations of an event
        /// </summary>
        public List<Location> GetEventLocation(long EventID)
        {
            var listEventPlace = db.EventPlaces.ToList(); //load all event place
            var listEventLocation = listEventPlace.FindAll(i => i.EventID == EventID);
            //select current event places
            var listLocation = db.Locations.ToList();
            var result = new List<Location>();
            foreach (var item in listEventLocation)
            {
                var loc = listLocation.FindAll(i => i.LocationID == item.LocationID)[0];
                result.Add(loc);
            }
            return result;
        }

        /// <summary>
        ///     Get event by eventID
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Event GetEventByID(long? id)
        {
            try
            {
                return db.Events.Find(id);
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Inscrease number view of event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public bool AddViewEvent(long eventID)
        {
            var evt = Instance.GetEventByID(eventID);
            if (evt != null)
            {
                evt.View += 1;
                db.Entry(evt).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            return false;
        }

        /// <summary>
        ///     Get all image of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<Image> GetEventImage(long? id)
        {
            var eventImage = new List<Image>();
            var allImage = db.Images.ToList();
            if (allImage.Count != 0)
            {
                eventImage = allImage.FindAll(i => i.EventID == id);
                return eventImage;
            }
            return null;
        }

        /// <summary>
        ///     Get all video of an event
        /// </summary>
        /// <param name="id"></param>
        /// <returns> </returns>
        public List<Video> GetEventVideo(long? id)
        {
            var eventVideo = new List<Video>();
            var allEventPlace = db.EventPlaces.ToList(); //retrieve data from table EventPlace
            //find all video of event;
            var listPlace = allEventPlace.FindAll(i => i.EventID == id);
            var allVideo = db.Videos.ToList(); // retrieve data from talble Video
            if (listPlace.Count != 0)
            {
                foreach (var item in listPlace)
                {
                    var listVideo = allVideo.FindAll(i => i.EventPlaceID == item.EventPlaceID);
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
        ///     Get all comment of an event
        /// </summary>
        /// <returns></returns>
        public List<Comment> GetEventComment(long? id)
        {
            var eventComment = new List<Comment>();
            var allComment = db.Comments.ToList();

            if (allComment.Count != 0)
            {
                eventComment = allComment.FindAll(i => i.EventID == id);
                return eventComment;
            }

            return null;
        }

        /// <summary>
        ///     Lay thong tin nguoi dang event
        /// </summary>
        /// <param name="eventId"></param>
        /// <returns></returns>
        public User GetAuthorEvent(long? eventId)
        {
            var evt = db.Events.Find(eventId);
            var listChannel = db.Channels.ToList(); // retrieve all Channel fromm table Channel
            var authorChannel = listChannel.FindAll(i => i.ChannelID == evt.ChannelID)[0];
            if (evt != null)
            {
                var listUser = db.Users.ToList(); //retrieve all user from table user
                var user = listUser.FindAll(i => i.UserID == authorChannel.UserID)[0];
                if (user != null) return user;
                return null;
            }
            return null;
        }

        //Check is event owned by user or not
        public bool IsEventOwnedByUser(long eventID, long UserID)
        {
            try
            {
                var channel = UserDatabaseHelper.Instance.GetUserChannel(UserID);
                if (channel != null)
                {
                    var evt = db.Events.Find(eventID);
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
        ///     trả lại event có tên, địa điểm hoặc description trùng với keyword
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchEventByKeyword(string keyword)
        {
            if (keyword == "" || keyword == null)
            {
                return db.Events.ToList();
            }
            keyword = keyword.ToLower();
            var listResult = new List<Event>();
            var retrievedResult = (from x in listResult
                                   where x.EventName.ToLower().Contains(keyword) || x.EventDescription.ToLower().Contains(keyword)
                                   select x).ToList();
            return retrievedResult;
        }

        /// <summary>
        ///     trả lại live event
        /// </summary>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public List<Event> SearchLiveStreamByKeyword(string keyword)
        {
            var listEvent = SearchEventByKeyword(keyword);
            var currentStream = new List<Event>();
            foreach (var item in listEvent)
            {
                if (isLive(item.EventID))
                {
                    currentStream.Add(item);
                }
            }
            return currentStream;
        }

        /// <summary>
        ///     Check does event Live or not
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool isLive(long? eventID)
        {
            var listEventPlace = db.EventPlaces.ToList(); //load all eventPlace
            var myEvenPlace = listEventPlace.FindAll(i => i.EventID == eventID);
            // load event place of this event
            var video = db.Videos.ToList();
            foreach (var item in myEvenPlace)
            {
                var videoInPlace = video.FindAll(i => i.EventPlaceID == item.EventPlaceID).ToList();
                var currTime = DateTime.Now;
                foreach (var item1 in videoInPlace)
                {
                    var start = item1.StartTime;
                    var end = item1.EndTime;
                    if (end != null && start.CompareTo(currTime) <= 0 && currTime.CompareTo(end) < 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public List<ViewThumbEventModel> GetThumbEventListByListEvent(List<Event> listEvent)
        {
            var listThumbEvent = new List<ViewThumbEventModel>();
            if (listEvent == null) return listThumbEvent;
            foreach (var item in listEvent)
            {
                var thumbEventModel = new ViewThumbEventModel();
                thumbEventModel.eventId = item.EventID;
                try
                {
                    thumbEventModel.avatar = GetImageByID(item.Avatar).ImageLink;
                }
                catch
                {
                    thumbEventModel.avatar = null;
                }
                thumbEventModel.numberView = item.View;
                thumbEventModel.eventName = item.EventName;
                thumbEventModel.StartTime = item.EventStartDate;
                thumbEventModel.EndTime = item.EventEndDate;
                thumbEventModel.location = Instance.GetEventLocation(item.EventID);
                listThumbEvent.Add(thumbEventModel);
            }
            return listThumbEvent;
        }

        /// <summary>
        ///     get Image by ID
        /// </summary>
        /// <param name="imageID"></param>
        /// <returns></returns>
        public Image GetImageByID(long? imageID)
        {
            return db.Images.Find(imageID);
        }

        /// <summary>
        ///     Lọc event theo nhóm category từ list event
        /// </summary>
        /// <param name="listEvent"></param>
        /// <param name="listCategory"></param>
        /// <returns></returns>
        public List<Event> SearchByCategory(List<Event> listEvent, long[] listCategory)
        {
            if (listCategory.Length == 0)
            {
                return listEvent;
            }
            if (listEvent.Count == 0)
            {
                return null;
            }

            var result = new List<Event>();
            for (var i = 0; i < listCategory.Length; i++)
            {
                var item = listEvent.FindAll(m => m.CategoryID == listCategory[i]);
                foreach (var evt in item)
                {
                    result.Add(evt);
                }
            }
            return result;
        }

        /// <summary>
        ///     dem so like cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountLike(long eventID)
        {
            var countLike =
                (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Like select a)
                    .Count();
            return countLike;
        }

        /// <summary>
        ///     dem so dislike cua event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountDisLike(long eventID)
        {
            var disLike =
                (from a in db.LikeDislikes where a.EventID == eventID && a.Type == EventZoneConstants.Dislike select a)
                    .Count();
            return disLike;
        }

        /// <summary>
        ///     Count number followers of an event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public int CountFollowerOfEvent(long eventID)
        {
            var NumberFollower = (from a in db.EventFollows where a.EventID == eventID select a).ToList().Count;
            return NumberFollower;
        }

        /// <summary>
        ///     Tim kiem Su kien xung quanh 1 dia diem, default ban kinh = 20km
        /// </summary>
        /// <param name="location"></param>
        /// <param name="distance"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventAroundLocation(Location seachlocation, double distance = 20,
            List<Event> listEvent = null)
        {
            if (listEvent == null)
            {
                return null;
            }
            var result = new List<Event>();
            foreach (var item in listEvent)
            {
                var eventLocation = Instance.GetEventLocation(item.EventID);
                foreach (var location in eventLocation)
                {
                    if (LocationHelpers.Instance.CalculateDistance(location, seachlocation) <= distance)
                    {
                        if (!result.Contains(item))
                            result.Add(item);
                    }
                }
            }
            return result;
        }

        /// <summary>
        ///     get list comment of event
        /// </summary>
        /// <param name="eventID"></param>
        /// <returns></returns>
        public List<Comment> GetListComment(long eventID)
        {
            try
            {
                var listComment = (from a in db.Comments where a.EventID == eventID select a).ToList();
                return listComment;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     get event in date range from event list
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="listEvent"></param>
        /// <returns></returns>
        public List<Event> GetEventInDateRange(DateTime startDate, DateTime endDate, List<Event> listEvent = null)
        {
            if (listEvent == null)
            {
                return null;
            }
            var result = new List<Event>();

            foreach (var item in listEvent)
            {
                if (item.EventStartDate.CompareTo(endDate) <= 0 && item.EventStartDate.CompareTo(startDate) >= 0)
                    result.Add(item);
            }

            return result;
        }

    }

    /// <summary>
    ///     All function related to Location
    /// </summary>
    public class LocationHelpers : SingletonBase<LocationHelpers>
    {
        private readonly EventZoneEntities db;

        private LocationHelpers()
        {
            db = new EventZoneEntities();
        }
        /// <summary>
        ///     get all location in db
        /// </summary>
        /// <returns></returns>
        public List<Location> GetAllLocation()
        {
            return db.Locations.ToList();
        }

        /// <summary>
        ///     get Location by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Location GetLocationById(long id)
        {
            try
            {
                return db.Locations.Find(id);
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        ///     Find Location by longtitude, latitude and Location name
        /// </summary>
        /// <param name="longitude"></param>
        /// <param name="latitude"></param>
        /// <param name="locationName"></param>
        /// <returns></returns>
        public long FindLocationByAllData(double longitude, double latitude, string locationName)
        {
            var listLocation = (from a in db.Locations
                                where
                                    a.Latitude.Equals(latitude) && a.Longitude.Equals(longitude) && a.LocationName.Equals(locationName)
                                select a).ToList();
            if (listLocation.Count == 0)
                return -1;
            return listLocation[0].LocationID;
        }

        /// <summary>
        ///     Tinh khoang cach giua 2 location
        /// </summary>
        /// <param name="p1"></param>
        /// <param name="p2"></param>
        /// <returns></returns>
        public double CalculateDistance(Location p1, Location p2)
        {
            // using formula in http://www.movable-type.co.uk/scripts/latlong.html
            double R = 6371; // distance of the earth in km
            var dLatitude = Radians(p1.Latitude - p2.Latitude); // different in Rad of latitude
            var dLongitude = Radians(p1.Longitude - p2.Longitude); // different in Rad of longitude

            var a = Math.Sin(dLatitude / 2) * Math.Sin(dLatitude / 2) +
                    Math.Cos(Radians(p1.Latitude)) * Math.Cos(Radians(p2.Latitude))
                    * Math.Sin(dLongitude / 2) * Math.Sin(dLongitude / 2);
            var c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1.0 - a));
            return R * c;
        }

        private double Radians(double x)
        {
            return x * Math.PI / 180.0;
        }

        public List<EventPlace> GetAllEventPlace()
        {
            return db.EventPlaces.ToList();
        }
    }

    public class CommonDataHelpers : SingletonBase<CommonDataHelpers>
    {
        private readonly EventZoneEntities db;

        private CommonDataHelpers()
        {
            db = new EventZoneEntities();
        }
        /// <summary>
        /// get all category in database
        /// </summary>
        /// <returns></returns>
        public List<Category> GetAllCategory()
        {
            return db.Categories.ToList();
        }

        /// <summary>
        /// count new event by category(new event is event that be defined as event is created in recent 7 days)
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public int CountNewEventByCategory(long categoryID)
        {
            int count = 0;
            DateTime floorDateTime = DateTime.Today.Date - TimeSpan.FromDays(7);
            count = (from a in db.Events where a.CategoryID == categoryID && (floorDateTime <= a.EventRegisterDate) select a).Count();
            return count;
        }
        /// <summary>
        ///  count live event by category(which event has streaming)
        /// </summary>
        /// <param name="categoryID"></param>
        /// <returns></returns>
        public int CountLiveEventByCategory(long categoryID)
        {
            int count = 0;
            var listEvent = (from a in db.Events where a.CategoryID == categoryID select a).ToList();
            try
            {
                foreach (var item in listEvent)
                {
                    if (EventDatabaseHelper.Instance.isLive(item.EventID))
                    {
                        count = count + 1;
                    }
                }
            }
            catch (Exception)
            {
                return count;
            }
            return count;
        }

        public int CountFollowerByCategory(long categoryID)
        {
            var numberFollower = (from a in db.CategoryFollows where a.CategoryID == categoryID select a).ToList().Count;
            return numberFollower;
        }
    }
}