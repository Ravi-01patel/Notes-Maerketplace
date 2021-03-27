using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class Search
    {
        public int? searchindex { get; set; }

        public IPagedList<NoteRating> search { get; set; }

        public List<String> Type { get; set; }

        public List<String> Category { get; set; }

        public List<String> University { get; set; }

        public List<String> Course{ get; set; }

        public List<String> Country{ get; set; }

       
        public string notesearch { get; set; }

        
        public string rating{ get; set; }

        public int count { get; set; }

        






    }
}