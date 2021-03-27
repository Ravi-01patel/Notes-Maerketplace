using PagedList;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class ChangePassword
    {
        [Required(ErrorMessage = " Password field required")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{6,24}$", ErrorMessage = "Password")]
        public string OldPasswords { get; set; }

        [Required(ErrorMessage = " New Password field required")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{6,24}$", ErrorMessage = "Password")]
        public string NewPasswords { get; set; }

   
        [Required(ErrorMessage = "Confirm Password field required")]
        [CompareAttribute("NewPasswords", ErrorMessage = "Password doesn't match.")]
        public string ConfirmPasswords { get; set; }



    }
}