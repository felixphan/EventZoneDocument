using EventZone.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventZone.Models
{
    public class SearchModel
    {
        public string keyword { get; set; }
        public long[] selectedCategory { get; set; }
        public Location location { get; set; }
        public DateTime startDateRange { get; set; }
        public DateTime finishDateRange { get; set; }

        public IEnumerable<Category> Categories
        {
            get
            {
                DatabaseHelpers dbhelp= new DatabaseHelpers();
                var list = dbhelp.GetAllCategory();
                return list;
            }
        }
    }
}