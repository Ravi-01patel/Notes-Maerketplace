using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class MyDashboard
    {
        public int? progressindex { get; set; }

        public int? publishindex { get; set; }

        public IPagedList<NoteDetail> progress { get; set; }

        public IPagedList<NoteDetail> published { get; set; }

        public Statistic stat { get; set; }
       
        public int NumberOfSold { get; set; }

        public int TotalEarning { get; set; }

        public int MyDownload { get; set; }

        public int MyRejected { get; set; }

        public int BuyerRequest { get; set; }


        public string progresssearch {  get; set; }

        public string publishsearch { get; set; }

        public string ProgressTitleSort { get; set; }

        public string ProgressCategorySort { get; set; }

        public string PublishTitleSort { get; set; }

        public string PublishCategorySort { get; set; }
    }
}