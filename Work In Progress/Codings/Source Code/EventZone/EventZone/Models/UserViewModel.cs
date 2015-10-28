using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.Models
{
    public class ViewThumbUserModel
    {
        public long UserID { get; set; }
        public string Avatar { get; set; }
        public string Name { get; set; }
        public int NumberOwnedEvent { get; set; }
        public int NumberFollower { get; set; }

    }
}