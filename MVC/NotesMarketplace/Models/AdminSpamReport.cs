using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminSpamReport
    {
        public IPagedList<SpamReport> SpamReport { get; set; }

        public string SpamTitleSort { get; set; }

        public string SpamReportedBySort { get; set; }

        public string SpamCategorySort { get; set; }

        public string SpamSearch { get; set; }

        public int? SpamIndex { get; set; }
    }
}