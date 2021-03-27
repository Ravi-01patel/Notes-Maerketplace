using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Sold
    {
        public int? soldindex { get; set; }

        

        public IPagedList<DownloadedNote> sold{ get; set; }

        

        public string soldsearch {  get; set; }

 
        public string soldTitleSort { get; set; }

        public string soldCategorySort { get; set; }

        
    }
}