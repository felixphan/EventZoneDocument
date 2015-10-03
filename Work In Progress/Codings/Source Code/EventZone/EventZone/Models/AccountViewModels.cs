﻿using System;
using System.ComponentModel.DataAnnotations;

namespace EventZone.Models
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }
    }

    public class ManageUserViewModel
    {
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Current password")]
        public string OldPassword { get; set; }

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "New password")]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm new password")]
        [Compare("NewPassword", ErrorMessage = "The new password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }

    public class LoginViewModel
    {
        [Required(ErrorMessage = "Please enter your user name")]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Please enter your password")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

    }
    public class GooleAccountModel 
    {
        [Required(ErrorMessage = "Please enter your user name")]
        [StringLength(100, ErrorMessage = "The {0} must more than {2} characters.", MinimumLength = 8)]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Please enter your password")]
        [StringLength(100, ErrorMessage = "The {0} must more than {2} characters.", MinimumLength = 8)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "ConfirmPassword")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [DataType(DataType.DateTime)]
        [Display(Name = "Date of birth")]
        public Nullable<System.DateTime> UserDOB { get; set; }


        [Display(Name = "Email")]
        public string Email { get; set; }
        public string Place { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }

        [Required(ErrorMessage = "Please select gender")]
        public int Gender { get; set; }
    
    }
    public class RegisterViewModel
    {
        [Required(ErrorMessage = "Please enter your user name")]
        [StringLength(100, ErrorMessage = "The {0} must more than {2} characters.", MinimumLength = 8)]
        [Display(Name = "User name")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Please enter your password")]
        [StringLength(100, ErrorMessage = "The {0} must more than {2} characters.", MinimumLength = 8)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "ConfirmPassword")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Please enter your email")]
        [EmailAddress(ErrorMessage = "The email format is incorrect")]
        [Display(Name = "Email")]
        public string Email { get; set; }

        [DataType(DataType.DateTime)]
        [Display(Name = "Date of birth")]
        public Nullable<System.DateTime> UserDOB { get; set; }


        [Required(ErrorMessage="Please select gender")]
        public int Gender { get; set; }

        [Required(ErrorMessage="Please enter your first name!")]
        [Display(Name="First name")]
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }
    }

    public class ForgotViewModel
    {
        [Required(ErrorMessage = "Please enter your email address!")]
        [EmailAddress(ErrorMessage = "The email format is incorrect!")]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }
}
