using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminMemberDetail
    {
        public UserProfileDetail Member { get; set; }

        public IPagedList<NoteDetail> Note { get; set; }

        public string NoteTitleSort { get; set; }
        public string NoteCategorySort { get; set; }

        public string PublishedDateSort { get; set; }

        public string DownloadedNotesSort { get; set; }

        
        public string TotalEarningSort { get; set; }

        

        public int? MemberDetailIndex { get; set; }
    }
}