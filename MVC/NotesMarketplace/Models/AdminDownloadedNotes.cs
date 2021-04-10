using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminDownloadedNotes
    {
        public List<string> Notesddl { get; set; }

        public List<string> Buyerddl { get; set; }

        public List<string> Sellerddl { get; set; }

        public IPagedList<DownloadedNote> DownloadedNote { get; set; }
        

        public int? DownloadedNoteIndex { get; set; }

        public string DownloadedNoteSearch { set; get; }

        public string DownloadedNoteTitleSort { get; set; }

        public string DownloadedNoteCategorySort { get; set; }

        public string DownloadedNoteBuyerSort { get; set; }

        public string DownloadedNoteSellerSort { get; set; }
        public string DownloadedNotePriceSort { get; set; }
    }
}