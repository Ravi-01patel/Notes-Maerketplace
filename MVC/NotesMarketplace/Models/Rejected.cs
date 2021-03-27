using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Rejected
    {
        public int? rejectedindex { get; set; }

        

        public IPagedList<NoteDetail> rejected{ get; set; }

        

        public string rejectedsearch {  get; set; }

 
        public string rejectedTitleSort { get; set; }

        public string rejectedCategorySort { get; set; }

        
    }
}