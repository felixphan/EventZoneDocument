//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EventZoneC.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class TrackingEvent
    {
        public long TrackingEventID { get; set; }
        public long ActorID { get; set; }
        public long ReceiverID { get; set; }
        public int ActionID { get; set; }
        public System.DateTime ActionTime { get; set; }
    
        public virtual Action Action { get; set; }
        public virtual Event Event { get; set; }
        public virtual User User { get; set; }
    }
}
