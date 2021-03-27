using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Downloads
    {
        public IPagedList<DownloadedNote> download { get; set; }


        public int? downloadindex { get; set; }

        public String downloadsearch { set; get; }

        public string downloadTitleSort { get; set; }

        public string downloadCategorySort { get; set; }


    }
}