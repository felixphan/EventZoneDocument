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
    
    public partial class NotificationChange
    {
        public long ID { get; set; }
        public Nullable<long> NotificationID { get; set; }
        public Nullable<long> EventID { get; set; }
        public Nullable<long> ActorID { get; set; }
        public Nullable<System.DateTime> AddDate { get; set; }
        public bool IsRead { get; set; }
        public Nullable<int> Type { get; set; }
        public Nullable<long> ReveiverID { get; set; }
    
        public virtual Event Event { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
    }
}