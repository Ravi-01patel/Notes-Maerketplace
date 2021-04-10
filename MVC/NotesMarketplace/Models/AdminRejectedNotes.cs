using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminRejectedNotes
    {
        public List<string> Sellerddl { get; set; }

        public IPagedList<AdminCommon> rejectednote { get; set; }

        public int? RejectedNoteIndex { get; set; }

        public string RejectedNoteSearch { set; get; }

        public string RejectedNoteTitleSort { get; set; }

        public string RejectedNoteCategorySort { get; set; }


        public string RejectedNoteSellerSort { get; set; }

        public string RejectedNoteRejectedBySort { get; set; }

    }
}