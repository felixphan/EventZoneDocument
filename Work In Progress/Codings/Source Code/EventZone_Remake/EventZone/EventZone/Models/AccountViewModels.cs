using System;
using System.ComponentModel.DataAnnotations;

namespace EventZone.Models
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [Display(Name = "User name")]
        public string UserName { get; set; }
    }

    public class EditUserModel
    {
        public long UserID { get; set; }
        public string IDCard { get; set; }
        public string Phone { get; set; }
        public string Place { get; set; }
        public string AvatarLink { get; set; }

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
        public DateTime? UserDOB { get; set; }

        [Required(ErrorMessage = "Please select gender")]
        public int Gender { get; set; }

        [Required(ErrorMessage = "Please enter your first name!")]
        [Display(Name = "First name")]
        public string UserFirstName { get; set; }

        public string UserLastName { get; set; }
    }

    public class SignInViewModel
    {
        [Required(ErrorMessage = "Please enter your user name")]
        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Please enter your password")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }
    }

    public class GoogleAccountModel
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
        public DateTime? UserDOB { get; set; }

        [Display(Name = "Email")]
        public string Email { get; set; }

        public string Place { get; set; }
        public string UserFirstName { get; set; }
        public string UserLastName { get; set; }

        [Required(ErrorMessage = "Please select gender")]
        public int Gender { get; set; }
    }

    public class SignUpViewModel
    {
        [Required(ErrorMessage = "Please enter your user name")]
        [StringLength(100, ErrorMessage = "The {0} must more than {2} characters.", MinimumLength = 8)]
        [Display(Name = "User Name")]
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
        public DateTime? UserDOB { get; set; }

        [Required(ErrorMessage = "Please select gender")]
        public int Gender { get; set; }

        [Required(ErrorMessage = "Please enter your first name!")]
        [Display(Name = "First name")]
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