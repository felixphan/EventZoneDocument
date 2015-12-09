//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EventZone.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Event
    {
        public Event()
        {
            this.Appeals = new HashSet<Appeal>();
            this.Comments = new HashSet<Comment>();
            this.EventFollows = new HashSet<EventFollow>();
            this.EventImages = new HashSet<EventImage>();
            this.EventPlaces = new HashSet<EventPlace>();
            this.LikeDislikes = new HashSet<LikeDislike>();
            this.NotificationChanges = new HashSet<NotificationChange>();
            this.Reports = new HashSet<Report>();
            this.Shares = new HashSet<Share>();
        }
    
        public long EventID { get; set; }
        public long ChannelID { get; set; }
        public string EventName { get; set; }
        public System.DateTime EventStartDate { get; set; }
        public System.DateTime EventEndDate { get; set; }
        public string EventDescription { get; set; }
        public System.DateTime EventRegisterDate { get; set; }
        public long View { get; set; }
        public long CategoryID { get; set; }
        public int Privacy { get; set; }
        public Nullable<long> Avatar { get; set; }
        public Nullable<long> EditBy { get; set; }
        public Nullable<System.DateTime> EditTime { get; set; }
        public string EditContent { get; set; }
        public bool Status { get; set; }
        public bool IsVerified { get; set; }
        public string LockedReason { get; set; }
    
        public virtual ICollection<Appeal> Appeals { get; set; }
        public virtual Category Category { get; set; }
        public virtual Channel Channel { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<EventFollow> EventFollows { get; set; }
        public virtual ICollection<EventImage> EventImages { get; set; }
        public virtual ICollection<EventPlace> EventPlaces { get; set; }
        public virtual ICollection<LikeDislike> LikeDislikes { get; set; }
        public virtual ICollection<NotificationChange> NotificationChanges { get; set; }
        public virtual ICollection<Report> Reports { get; set; }
        public virtual ICollection<Share> Shares { get; set; }
    }
}
