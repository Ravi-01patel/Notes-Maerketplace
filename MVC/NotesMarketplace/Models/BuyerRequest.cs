using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class BuyerRequest
    {
        
       
        public IPagedList<DownloadedNote> buyerrequest { get; set; }

        
        public int? buyerrequestindex { get; set; }

        public String buyerrequestsearch { set; get; }

        public string buyerrequestTitleSort { get; set; }

        public string buyerrequestCategorySort { get; set; }



    }
}