using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminDashboard
    {
        

        public string MonthSort { get; set; }

        public IPagedList<AdminCommon> dashboard { get; set; }

        public int? DashboardIndex { get; set; }

        public int notereview { get; set; }

        public int notedownloaded { get; set; }
        public int newuser { get; set; }

        public string DashboardSearch { set; get; }

        public string DashboardTitleSort { get; set; }

        public string DashboardCategorySort { get; set; }

        public string DashboardSizeSort { get; set; }

        public string DashboardPublisherSort { get; set; }

        public string DashboardNODSort { get; set; }
        public string DashboardPriceSort { get; set; }
    }
}