using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;

namespace NotesMarketplace.Models
{
    public class AdminManageAdmin
    {
        public IPagedList<AdminDetail> Admin { get; set; }

        public string FirstNameSort { get; set; }

        public string LastNameSort { get; set; }

        public string PhoneNumberSort { get; set; }

        public string AdminSearch { get; set; }

        public int ? AdminIndex { get; set; }
    }
}