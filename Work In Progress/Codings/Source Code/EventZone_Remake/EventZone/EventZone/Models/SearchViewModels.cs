using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using EventZone.Helpers;
using EventZone.Models;

namespace EventZone.Models
{
    public class BasicSearch
    {
        [Required]
        public String Keyword { get; set; }
    }

    public class AdvanceSearch
    {
            public string Keyword { get; set; }
            public long[] SelectedCategory { get; set; }
            public Location Location { get; set; }
            public DateTime StartDateRange { get; set; }
            public DateTime FinishDateRange { get; set; }

            public IEnumerable<Category> Categories
            {
                get
                {
                    DatabaseHelpers dbhelp = new DatabaseHelpers();
                    var list = dbhelp.GetAllCategory();
                    return list;
                }
            }
    }
}