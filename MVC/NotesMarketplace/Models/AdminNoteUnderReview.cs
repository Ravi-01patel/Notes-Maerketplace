using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminNoteUnderReview
    {
        public List<string> Sellerddl { get; set; }

        public IPagedList<NoteDetail> NoteUnderReview { get; set; }

        public int? NoteUnderReviewIndex { get; set; }

        public string NoteUnderReviewSearch { set; get; }

        public string NoteUnderReviewTitleSort { get; set; }

        public string NoteUnderReviewCategorySort { get; set; }

        

        public string NoteUnderReviewSellerSort { get; set; }

    }
}