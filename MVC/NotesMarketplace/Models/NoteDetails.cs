using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class NoteDetails
    {
        

        public NoteDetail notedetail { get; set; }

        public List<UserFeedback> feedback { get; set; }

        public int rating { get; set; }

        public int inappropriat { get; set; }

        public int review { get; set; }



    }
}