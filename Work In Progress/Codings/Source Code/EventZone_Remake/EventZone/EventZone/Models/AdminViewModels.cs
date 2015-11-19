using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EventZone.Models
{
    public class ChangeUserEmail
    {
        [Required(ErrorMessage = "Enter your email address.")]
        [EmailAddress(ErrorMessage = "The email format is incorrect.")]
        [Display(Name = "Email")]
        public string Email { get; set; }
        public long UserID { get; set; }
    }
}