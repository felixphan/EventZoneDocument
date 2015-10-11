using System;
using System.ComponentModel.DataAnnotations;
namespace EventZone.Models
{
    public class EventCreateViewModels
    {
        [Required(ErrorMessage = "Please Input Event Name")]
        [Display(Name = "Event Name")]
        [Key]
        public String EventName { get; set; }
        [Required(ErrorMessage = "Please Input Start Date")]
        [DataType(DataType.DateTime)]
        [Display(Name = "Start Date")]
        public Nullable<System.DateTime> StartDate { get; set; }
        [Required(ErrorMessage = "Please Input End Date")]
        [DataType(DataType.DateTime)]
        [Display(Name = "End Date")]
        public Nullable<System.DateTime> EndDate { get; set; }
        [Required(ErrorMessage = "Please Input Location")]
        [Display(Name = "Location")]
        public String Location { get; set; }
        [Required(ErrorMessage = "Please Select Resolution")]
        [Display(Name = "Resolution")]
        public int Resolution { get; set; }
        [Required]
        [Display(Name = "Privacy")]
        public String Privacy { get; set; }
        [Display(Name = "Request Urgent")]
        public bool RequestUrgent { get; set; }
        [Required]
        [Display(Name="Category")]
        public String CategoryID { get; set; }
        [Display(Name = "Description")]
        public String Description { get; set; }
    }
}