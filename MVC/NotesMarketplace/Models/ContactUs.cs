using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class ContactUs
    {
        [Required]
        [RegularExpression(@"^[a-zA-Z][a-zA-Z\s]+$", ErrorMessage = "Use letters only please")]
        public String FullName { get; set; }

        [Required]
        public String Email { get; set; }

        [Required]
        public String Subject { get; set; }

        [Required]
        public String Question { get; set; }
        
        
    }
}