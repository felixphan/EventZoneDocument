using System;
using System.Collections.Generic;
using EventZone.Models;

namespace EventZone.Models
{
    public class CreateEventModel
    {
        public String Title { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public String LocationName { get; set; }
        public String Longitude { get; set; }
        public String Resolution { get; set; }
        public String PrivacyYoutube { get; set; }
        public String Langitude { get; set; }
        public bool Privacy { get; set; }

        public bool IsLive { get; set; }
        public long CategoryID { get; set; }

        public bool RequestUrgent { get; set; }
        public String Description { get; set; }
    }
    public class ViewThumbEventModel
    {
        public long eventId { get; set; }
        public string avatar { get; set; }
        public long numberView { get; set; }
        public string eventName { get; set; }
        public Nullable<System.DateTime> StartTime { get; set; }
        public Nullable<System.DateTime> EndTime { get; set; }
        public List<Location> location { get; set; }
    }

    public class ViewDetailEventModel
    {
        public long eventId { get; set; }
        public string eventAvatar { get; set; }
        public string eventName { get; set; }
        public int NumberLike { get; set; }
        public int NumberDisLike { get; set; }
        public LikeDislike FindLike { get; set; }
        public int NumberFowllower { get; set; }
        public string eventDescription { get; set; }
        public bool isFollowing { get; set; }
        public bool isOwningEvent { get; set; }
        public Nullable<System.DateTime> StartTime { get; set; }
        public Nullable<System.DateTime> EndTime { get; set; }
        public List<Location> eventLocation { get; set; }
        public List<Image> eventImage { get; set; }
        public List<Video> eventVideo { get; set; }
        public List<Comment> eventComment { get; set; }
        public bool Privacy { get; set; }
    }
}