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
    
    public partial class Category
    {
        public Category()
        {
            this.CategoryFollows = new HashSet<CategoryFollow>();
            this.Events = new HashSet<Event>();
        }
    
        public long CategoryID { get; set; }
        public string CategoryName { get; set; }
    
        public virtual ICollection<CategoryFollow> CategoryFollows { get; set; }
        public virtual ICollection<Event> Events { get; set; }
    }
}
