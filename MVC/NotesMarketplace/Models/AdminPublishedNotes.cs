using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminPublishedNotes
    {
        public List<string> Sellerddl { get; set; }

        public IPagedList<AdminCommon> publishednote { get; set; }

        public int? PublishedNoteIndex { get; set; }

        public string PublishedNoteSearch { set; get; }

        public string PublishedNoteTitleSort { get; set; }

        public string PublishedNoteCategorySort { get; set; }

        public string PublishedNotePriceSort { get; set; }

        public string PublishedNoteNODSort { get; set; }

        public string PublishedNoteSizeSort { get; set; }
        public string PublishedNoteSellerSort { get; set; }

        public string PublishedNoteApprovedBySort { get; set; }
    }
}