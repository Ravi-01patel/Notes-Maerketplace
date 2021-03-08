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

       

        public IPagedList<NoteDetail> search { get; set; }

        public List<ManageCTC> Category { get; set; }

        public List<ManageCTC> Type { get; set; }

        public List<ManageCTC> Country { get; set; }


        public string notesearch {  get; set; }

        public string typesort { get; set; }
        public string categorysort{ get; set; }
        public string universitysort { get; set; }
        public string coursesort { get; set; }
        public string countrysort { get; set; }

        






    }
}