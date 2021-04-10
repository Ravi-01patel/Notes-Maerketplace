using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NotesMarketplace.Models
{
    public class AdminCTCWithAddedBy
    {
        public ManageCTC CTC { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

    }
}