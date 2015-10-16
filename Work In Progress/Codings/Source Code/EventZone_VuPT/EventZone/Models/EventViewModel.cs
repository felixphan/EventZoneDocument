using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.Models
{
    public class ViewThumbEventModel
    {
            public long eventId{get;set;}
            public string avartarLink{get;set;}
            public string eventName{get;set;}
            public Nullable<System.DateTime> StartTime { get; set; }
            public Nullable<System.DateTime> EndTime { get; set; }
            public List<Location> location { get; set; }

 

    }
}