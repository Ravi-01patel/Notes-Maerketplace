using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class UserFeedback
    {
        public string Comment { get; set; }

        public string UserImage { get; set; }

        public string UserName { get; set; }

        public int Rating { get; set; }
    }
}