using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;

namespace NotesMarketplace.Models
{
    public class AdminCTCCommon
    {
        public IPagedList<AdminCTCWithAddedBy> ctc { get; set; }

        public string CTCSort { get; set; }

        public string AddedBySort { get; set; }

        public string CountryCodeSort { get; set; }

        public string CTCSearch {get; set;}

        public int ? CTCIndex { get; set; }
    }
}