using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminCommon
    {
        public NoteDetail note { get; set; }

        public int NumberOfDownload { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }
    }
}