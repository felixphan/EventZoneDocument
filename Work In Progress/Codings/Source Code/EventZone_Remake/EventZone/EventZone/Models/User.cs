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
    
    public partial class User
    {
        public User()
        {
            this.CategoryFollows = new HashSet<CategoryFollow>();
            this.Comments = new HashSet<Comment>();
            this.Channels = new HashSet<Channel>();
            this.EventFollows = new HashSet<EventFollow>();
            this.Images = new HashSet<Image>();
            this.LikeDislikes = new HashSet<LikeDislike>();
            this.PeopleFollows = new HashSet<PeopleFollow>();
            this.PeopleFollows1 = new HashSet<PeopleFollow>();
            this.Reports = new HashSet<Report>();
            this.Shares = new HashSet<Share>();
            this.TrackingActions = new HashSet<TrackingAction>();
            this.TrackingActions1 = new HashSet<TrackingAction>();
        }
    
        public long UserID { get; set; }
        public string UserName { get; set; }
        public string UserPassword { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
        public string UserEmail { get; set; }
        public System.DateTime UserDOB { get; set; }
        public string IDCard { get; set; }
        public int UserRoles { get; set; }
        public string Phone { get; set; }
        public string Place { get; set; }
        public bool AccountStatus { get; set; }
        public int Gender { get; set; }
        public Nullable<long> Avartar { get; set; }
        public System.DateTime DataJoin { get; set; }
    
        public virtual ICollection<CategoryFollow> CategoryFollows { get; set; }
        public virtual ICollection<Comment> Comments { get; set; }
        public virtual ICollection<Channel> Channels { get; set; }
        public virtual ICollection<EventFollow> EventFollows { get; set; }
        public virtual ICollection<Image> Images { get; set; }
        public virtual Image Image { get; set; }
        public virtual ICollection<LikeDislike> LikeDislikes { get; set; }
        public virtual ICollection<PeopleFollow> PeopleFollows { get; set; }
        public virtual ICollection<PeopleFollow> PeopleFollows1 { get; set; }
        public virtual ICollection<Report> Reports { get; set; }
        public virtual ICollection<Share> Shares { get; set; }
        public virtual ICollection<TrackingAction> TrackingActions { get; set; }
        public virtual ICollection<TrackingAction> TrackingActions1 { get; set; }
    }
}
