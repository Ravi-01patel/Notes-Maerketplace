using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminMembers
    {
        public IPagedList<User> User { get; set; }

        public string FirstNameSort { get; set; }
        public string LastNameSort { get; set; }

        public string NotesUnderReviewSort { get; set; }

        public string PublishedNotesSort { get; set; }

        public string DownloadedNotesSort { get; set; }

        public string TotalExpenseSort { get; set; }
        public string TotalEarningSort { get; set; }

        public string MemberSearch { get; set; }

        public int? MemberIndex { get; set; }


    }
}