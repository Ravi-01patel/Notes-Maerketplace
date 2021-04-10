using NotesMarketplace.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;

namespace NotesMarketplace.Controllers
{
    public class AdminController : Controller
    {
        static String Route = null;

        NotesMarketplaceEntities db = new NotesMarketplaceEntities();
        // GET: Dashboard
        public ActionResult Dashboard(AdminDashboard adminDashboard, string MonthSort)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            var lowerlimit = DateTime.Now.AddMonths(-6);
            List<NoteDetail> notes = db.NoteDetails.Where(m => m.IsActive && m.NoteStatus == 4).OrderByDescending(m => m.PublishedDate < lowerlimit).ToList();

            if (!String.IsNullOrEmpty(MonthSort))
            {
                if (!MonthSort.Equals("Select Month") || !MonthSort.Equals("/Admin/Dashboard"))
                {
                    notes = notes.Where(m => m.PublishedDate.Value.ToString("Y").Equals(MonthSort)).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardSearch))
            {
                notes = notes.Where(m => m.Category.ToLower().Contains(adminDashboard.DashboardSearch.ToLower()) || m.Title.ToLower().Contains(adminDashboard.DashboardSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardCategorySort))
            {
                if (adminDashboard.DashboardCategorySort.Equals("category"))
                {
                    notes = notes.OrderBy(m => m.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardTitleSort))
            {

                if (adminDashboard.DashboardTitleSort.Equals("title"))
                {
                    notes = notes.OrderBy(m => m.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardSizeSort))
            {
                if (adminDashboard.DashboardSizeSort.Equals("size"))
                {
                    notes = notes.OrderBy(m => m.NoteSize).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardPriceSort))
            {
                if (adminDashboard.DashboardPriceSort.Equals("price"))
                {
                    notes = notes.OrderBy(m => m.SellPrice).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardPublisherSort))
            {
                if (adminDashboard.DashboardPublisherSort.Equals("publisher"))
                {
                    notes = notes.OrderBy(m => m.User.LastName).ToList();
                    notes = notes.OrderBy(m => m.User.FirstName).ToList();
                }
            }

            if (notes.Count == 0)
            {
                ViewBag.Dashboard = "true";
            }
            List<AdminCommon> ac = new List<AdminCommon>();
            foreach (NoteDetail note in notes)
            {
                AdminCommon acommon = new AdminCommon();
                acommon.note = note;
                int count = db.DownloadedNotes.Where(m => m.Note == note.Note && m.IsActive == true && m.IsApproved == true).Count();
                acommon.NumberOfDownload = count;
                ac.Add(acommon);
            }
            if (!String.IsNullOrEmpty(adminDashboard.DashboardNODSort))
            {
                if (adminDashboard.DashboardNODSort.Equals("NOD"))
                {
                    ac = ac.OrderByDescending(m => m.NumberOfDownload).ToList();
                }
            }
            adminDashboard.dashboard = ac.ToPagedList(adminDashboard.DashboardIndex ?? 1, 5);
            var dt = DateTime.Now.Date.AddDays(-7);
            adminDashboard.newuser = db.Users.Where(m => m.UserRole == 1 && m.IsActive == true && m.IsEmailVerified == true && m.CreatedDate >= dt).Count();
            adminDashboard.notereview = db.NoteDetails.Where(m => m.NoteStatus == 3 && m.IsActive).Count();
            adminDashboard.notedownloaded = db.DownloadedNotes.Where(m => m.IsApproved && m.IsActive && m.ModifiedDate >= dt).Count();
            return View(adminDashboard);
        }
        public ActionResult Unpublish(string bookId2, string Comment)
        {
            if (Comment != null)
            {
                User Admin = Session["User"] as User;
                int id = Convert.ToInt32(bookId2);

                NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.IsActive && m.NoteStatus == 4 && m.Note == id);


                note.Remark = Comment;
                note.NoteStatus = 6;
                note.ModifiedBy = Admin.Users;
                note.ModifiedDate = DateTime.Now;
                User seller = db.Users.FirstOrDefault(m => m.Users == note.Users && m.IsActive);

                MailMessage mm = new MailMessage("rajp30398@gmail.com", seller.EmailID);
                mm.Subject = "Sorry! We need to remove your notes from our portal.";
                mm.Body = "Hello " + seller.FirstName + " " + seller.LastName + ",\n\nWe want to inform you that, your note" + note.Title + " has been removed from the portal.\n Please find our remarks as below -\n" + Comment + "\n\nRegards,\nNotes Marketplace";

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.UseDefaultCredentials = false;

                NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                smtp.EnableSsl = true;
                smtp.Credentials = nc;
                smtp.Send(mm);


                db.SaveChanges();
                return RedirectToAction("Dashboard", "Admin");

            }
            else
            {
                return RedirectToAction("Dashboard", "Admin");
            }


        }
        public ActionResult NoteDetails(NoteDetails note)
        {
            Route = "NoteDetails";
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }


            int BookId = Convert.ToInt32(Session["BookID"]);

            NoteDetail notedetail = db.NoteDetails.FirstOrDefault(m => m.Note == BookId && m.IsActive);
            if (notedetail.BookPicture != null)
            {
                ViewBag.BookImage = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultNotePreview;
            }
            note.notedetail = notedetail;
            note.review = db.Feedbacks.Where(m => m.Note == notedetail.Note && m.IsActive).Count();
            note.inappropriat = db.SpamReports.Where(m => m.Note == notedetail.Note).Count();
            var temp = db.Feedbacks.Where(m => m.Note == notedetail.Note);

            if (temp != null)
            {
                var listofreviews = temp.ToList();
                var count = listofreviews.Count();
                if (count != 0)
                {
                    int sum = 0;
                    for (int i = 0; i < count; i++)
                    {
                        sum = sum + listofreviews[i].Review;
                    }
                    note.rating = sum / count;
                }
            }

            List<UserFeedback> userFeedbacks = new List<UserFeedback>();
            List<Feedback> Feedback = db.Feedbacks.Where(m => m.Note == BookId).ToList();
            foreach (Feedback fb in Feedback)
            {
                UserFeedback users = new UserFeedback();
                User user1 = db.Users.FirstOrDefault(m => m.Users == fb.Users && m.IsActive);
                users.UserName = user1.FirstName + " " + user1.LastName;
                UserProfileDetail up = db.UserProfileDetails.FirstOrDefault(m => m.Users == fb.Users && m.IsActive);
                if (up.ProfilePicture != null)
                {
                    users.UserImage = up.ProfilePicture;
                }
                else
                {
                    users.UserImage = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }

                users.Rating = fb.Review;
                users.Comment = fb.Comments;
                userFeedbacks.Add(users);
            }
            note.feedback = userFeedbacks;

            return View(note);
        }
        public ActionResult DownloadedNotes(AdminDownloadedNotes adminDownloadedNotes, string notesddl, string buyerddl, string sellerddl)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<string> notes = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved).Select(m => m.NoteTitle).Distinct().ToList();
            List<string> buyer = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved).Select(m => m.User.FirstName + " " + m.User.LastName).Distinct().ToList();
            List<string> seller = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved).Select(m => m.User1.FirstName + " " + m.User1.LastName).Distinct().ToList();
            adminDownloadedNotes.Notesddl = notes;
            adminDownloadedNotes.Buyerddl = buyer;
            adminDownloadedNotes.Sellerddl = seller;
            List<DownloadedNote> DownloadedNotes = db.DownloadedNotes.Where(m => m.IsActive && m.IsApproved).ToList();
            if (!String.IsNullOrEmpty(notesddl))
            {
                DownloadedNotes = DownloadedNotes.Where(m => m.NoteTitle.Equals(notesddl)).ToList();
            }
            if (!String.IsNullOrEmpty(buyerddl))
            {
                DownloadedNotes = DownloadedNotes.Where(m => (m.User.FirstName + " " + m.User.LastName).Equals(buyerddl)).ToList();
            }
            if (!String.IsNullOrEmpty(sellerddl))
            {
                DownloadedNotes = DownloadedNotes.Where(m => (m.User1.FirstName + " " + m.User1.LastName).Equals(sellerddl)).ToList();
            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNoteSearch))
            {
                DownloadedNotes = DownloadedNotes.Where(m => m.Category.ToLower().Contains(adminDownloadedNotes.DownloadedNoteSearch.ToLower()) || m.NoteTitle.ToLower().Contains(adminDownloadedNotes.DownloadedNoteSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNoteCategorySort))
            {
                if (adminDownloadedNotes.DownloadedNoteCategorySort.Equals("category"))
                {
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNoteTitleSort))
            {

                if (adminDownloadedNotes.DownloadedNoteTitleSort.Equals("title"))
                {
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.NoteTitle).ToList();
                }

            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNotePriceSort))
            {
                if (adminDownloadedNotes.DownloadedNotePriceSort.Equals("price"))
                {
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.SellPrice).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNoteBuyerSort))
            {
                if (adminDownloadedNotes.DownloadedNoteBuyerSort.Equals("buyer"))
                {
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.User.LastName).ToList();
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.User.FirstName).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminDownloadedNotes.DownloadedNoteSellerSort))
            {
                if (adminDownloadedNotes.DownloadedNoteSellerSort.Equals("seller"))
                {
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.User1.LastName).ToList();
                    DownloadedNotes = DownloadedNotes.OrderBy(m => m.User1.FirstName).ToList();
                }
            }
            if (DownloadedNotes.Count == 0)
            {
                ViewBag.Downloaded = "true";
            }
            adminDownloadedNotes.DownloadedNote = DownloadedNotes.ToPagedList(adminDownloadedNotes.DownloadedNoteIndex ?? 1, 5);
            return View(adminDownloadedNotes);
        }
        public ActionResult NotesUnderReview(AdminNoteUnderReview adminNoteUnderReview, string sellerddl)
        {
            Route = "NotesUnderReview";
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<NoteDetail> notes = db.NoteDetails.Where(m => m.IsActive && (m.NoteStatus == 2 || m.NoteStatus == 3)).OrderByDescending(m => m.PublishedDate).ToList();

            List<string> seller = db.NoteDetails.Where(m => m.NoteStatus == 2 || m.NoteStatus == 3).Select(m => m.User.FirstName + " " + m.User.LastName).Distinct().ToList();
            adminNoteUnderReview.Sellerddl = seller;

            if (!String.IsNullOrEmpty(sellerddl))
            {
                notes = notes.Where(m => (m.User.FirstName + " " + m.User.LastName).Equals(sellerddl)).ToList();
            }
            if (!String.IsNullOrEmpty(adminNoteUnderReview.NoteUnderReviewSearch))
            {
                notes = notes.Where(m => m.Category.ToLower().Contains(adminNoteUnderReview.NoteUnderReviewSearch.ToLower()) || m.Title.ToLower().Contains(adminNoteUnderReview.NoteUnderReviewSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminNoteUnderReview.NoteUnderReviewCategorySort))
            {
                if (adminNoteUnderReview.NoteUnderReviewCategorySort.Equals("category"))
                {
                    notes = notes.OrderBy(m => m.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminNoteUnderReview.NoteUnderReviewTitleSort))
            {

                if (adminNoteUnderReview.NoteUnderReviewTitleSort.Equals("title"))
                {
                    notes = notes.OrderBy(m => m.Title).ToList();
                }
            }


            if (!String.IsNullOrEmpty(adminNoteUnderReview.NoteUnderReviewSellerSort))
            {
                if (adminNoteUnderReview.NoteUnderReviewSellerSort.Equals("seller"))
                {
                    notes = notes.OrderBy(m => m.User.LastName).ToList();
                    notes = notes.OrderBy(m => m.User.FirstName).ToList();
                }
            }
            if (notes.Count == 0)
            {
                ViewBag.NoteunderReview = "true";
            }
            adminNoteUnderReview.NoteUnderReview = notes.ToPagedList(adminNoteUnderReview.NoteUnderReviewIndex ?? 1, 5);
            return View(adminNoteUnderReview);
        }

        public ActionResult RejectedNotes(AdminRejectedNotes adminRejectedNotes, string sellerddl)
        {
            Route = "RejectedNotes";
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            List<string> seller = db.NoteDetails.Where(m => m.NoteStatus == 5 || m.NoteStatus ==6).Select(m => m.User.FirstName + " " + m.User.LastName).Distinct().ToList();
            adminRejectedNotes.Sellerddl = seller;

            List<NoteDetail> RejectedNotes = db.NoteDetails.Where(m => m.NoteStatus == 5 || m.NoteStatus == 6).OrderByDescending(m => m.ModifiedDate).ToList();
            if (!String.IsNullOrEmpty(sellerddl))
            {
                RejectedNotes = RejectedNotes.Where(m => (m.User.FirstName + " " + m.User.LastName).Equals(sellerddl)).ToList();
            }
            if (!String.IsNullOrEmpty(adminRejectedNotes.RejectedNoteSearch))
            {
                RejectedNotes = RejectedNotes.Where(m => m.Category.ToLower().Contains(adminRejectedNotes.RejectedNoteSearch.ToLower()) || m.Title.ToLower().Contains(adminRejectedNotes.RejectedNoteSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminRejectedNotes.RejectedNoteCategorySort))
            {
                if (adminRejectedNotes.RejectedNoteCategorySort.Equals("category"))
                {
                    RejectedNotes = RejectedNotes.OrderBy(m => m.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminRejectedNotes.RejectedNoteTitleSort))
            {

                if (adminRejectedNotes.RejectedNoteTitleSort.Equals("title"))
                {
                    RejectedNotes = RejectedNotes.OrderBy(m => m.Title).ToList();
                }

            }
            if (!String.IsNullOrEmpty(adminRejectedNotes.RejectedNoteSellerSort))
            {
                if (adminRejectedNotes.RejectedNoteSellerSort.Equals("seller"))
                {
                    RejectedNotes = RejectedNotes.OrderBy(m => m.User.LastName).ToList();
                    RejectedNotes = RejectedNotes.OrderBy(m => m.User.FirstName).ToList();
                }
            }
            List<AdminCommon> RejectedNote = new List<AdminCommon>();
            foreach (NoteDetail note in RejectedNotes)
            {
                AdminCommon adminRejected = new AdminCommon();
                adminRejected.note = note;
                User user1 = db.Users.FirstOrDefault(m => m.Users == note.ModifiedBy);
                adminRejected.FirstName = user1.FirstName;
                adminRejected.LastName = user1.LastName;
                RejectedNote.Add(adminRejected);
            }
            if (!String.IsNullOrEmpty(adminRejectedNotes.RejectedNoteRejectedBySort))
            {
                if (adminRejectedNotes.RejectedNoteRejectedBySort.Equals("rejectedby"))
                {
                    RejectedNote = RejectedNote.OrderBy(m => m.LastName).ToList();
                    RejectedNote = RejectedNote.OrderBy(m => m.FirstName).ToList();
                }
            }
            if (RejectedNote.Count == 0)
            {
                ViewBag.Rejected = "true";
            }
            adminRejectedNotes.rejectednote = RejectedNote.ToPagedList(adminRejectedNotes.RejectedNoteIndex ?? 1, 5);
            return View(adminRejectedNotes);
        }

        public ActionResult PublishedNotes(AdminPublishedNotes adminPublishedNotes, string sellerddl)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<NoteDetail> notes = db.NoteDetails.Where(m => m.IsActive && m.NoteStatus == 4).OrderByDescending(m => m.PublishedDate).ToList();

            List<string> seller = db.NoteDetails.Where(m => m.NoteStatus == 4).Select(m => m.User.FirstName + " " + m.User.LastName).Distinct().ToList();
            adminPublishedNotes.Sellerddl = seller;

            if (!String.IsNullOrEmpty(sellerddl))
            {
                notes = notes.Where(m => (m.User.FirstName + " " + m.User.LastName).Equals(sellerddl)).ToList();
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteSearch))
            {
                notes = notes.Where(m => m.Category.ToLower().Contains(adminPublishedNotes.PublishedNoteSearch.ToLower()) || m.Title.ToLower().Contains(adminPublishedNotes.PublishedNoteSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteCategorySort))
            {
                if (adminPublishedNotes.PublishedNoteCategorySort.Equals("category"))
                {
                    notes = notes.OrderBy(m => m.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteTitleSort))
            {

                if (adminPublishedNotes.PublishedNoteTitleSort.Equals("title"))
                {
                    notes = notes.OrderBy(m => m.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteSizeSort))
            {
                if (adminPublishedNotes.PublishedNoteSizeSort.Equals("size"))
                {
                    notes = notes.OrderBy(m => m.NoteSize).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNotePriceSort))
            {
                if (adminPublishedNotes.PublishedNotePriceSort.Equals("price"))
                {
                    notes = notes.OrderBy(m => m.SellPrice).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteSellerSort))
            {
                if (adminPublishedNotes.PublishedNoteSellerSort.Equals("seller"))
                {
                    notes = notes.OrderBy(m => m.User.LastName).ToList();
                    notes = notes.OrderBy(m => m.User.FirstName).ToList();
                }
            }


            List<AdminCommon> ac = new List<AdminCommon>();
            foreach (NoteDetail note in notes)
            {
                AdminCommon acommon = new AdminCommon();
                acommon.note = note;
                int count = db.DownloadedNotes.Where(m => m.Note == note.Note && m.IsActive == true && m.IsApproved == true).Count();
                acommon.NumberOfDownload = count;
                User user1 = db.Users.FirstOrDefault(m => m.Users == note.ModifiedBy);
                acommon.FirstName = user1.FirstName;
                acommon.LastName = user1.LastName;
                ac.Add(acommon);
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteNODSort))
            {
                if (adminPublishedNotes.PublishedNoteNODSort.Equals("NOD"))
                {
                    ac = ac.OrderByDescending(m => m.NumberOfDownload).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminPublishedNotes.PublishedNoteApprovedBySort))
            {
                if (adminPublishedNotes.PublishedNoteApprovedBySort.Equals("approvedby"))
                {
                    ac = ac.OrderByDescending(m => m.LastName).ToList();
                    ac = ac.OrderByDescending(m => m.FirstName).ToList();
                }
            }
            if (ac.Count == 0)
            {
                ViewBag.Published = "true";
            }
            adminPublishedNotes.publishednote = ac.ToPagedList(adminPublishedNotes.PublishedNoteIndex ?? 1, 5);
            return View(adminPublishedNotes);
        }

        public ActionResult AddCategory(ManageCTC manageCTC)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            return View(manageCTC);

        }
        [HttpPost]
        public ActionResult AddCategory(ManageCTC manageCTC, string extra)
        {
            User Admin = Session["User"] as User;

            if (manageCTC.CTCValue == null)
            {
                ViewBag.CTC = "Please enter the category";
                return View(manageCTC);
            }
            else if (manageCTC.Descriptions == null)
            {
                ViewBag.Description = "Please enter the description";
                return View(manageCTC);
            }
            else
            {


                int id = Convert.ToInt32(Session["CategoryId"]);

                if (id == 0)
                {
                    bool IsExist = db.ManageCTCs.Any(m => m.CTCValue.ToLower().Equals(manageCTC.CTCValue));
                    if (!IsExist)
                    {
                        ManageCTC AddCTC = new ManageCTC();
                        AddCTC.CTC = 1;
                        AddCTC.CTCValue = manageCTC.CTCValue;
                        AddCTC.Descriptions = manageCTC.Descriptions;
                        AddCTC.CreatedBy = Admin.Users;
                        AddCTC.CreatedDate = DateTime.Now;
                        AddCTC.IsActive = true;
                        db.ManageCTCs.Add(AddCTC);
                        db.SaveChanges();
                    }
                    else
                    {

                        ViewBag.Exist = "This category is already exist";
                        return View(manageCTC);
                    }


                }
                else
                {
                    ManageCTC AddCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
                    AddCTC.CTC = 1;
                    AddCTC.CTCValue = manageCTC.CTCValue;
                    AddCTC.Descriptions = manageCTC.Descriptions;
                    AddCTC.ModifiedBy = Admin.Users;
                    AddCTC.ModifiedDate = DateTime.Now;
                    AddCTC.IsActive = true;
                    db.SaveChanges();

                }

                Session["CategoryId"] = null;
                return RedirectToAction("ManageCatagory", "Admin");
            }



        }
        public ActionResult ManageCatagory(AdminCTCCommon category)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<ManageCTC> CategoryList = db.ManageCTCs.Where(m => m.CTC == 1).OrderByDescending(m => m.CreatedDate).ToList();
            if (!String.IsNullOrEmpty(category.CTCSearch))
            {
                CategoryList = CategoryList.Where(m => m.CTCValue.ToLower().Contains(category.CTCSearch)).ToList();
            }
            if (!String.IsNullOrEmpty(category.CTCSort))
            {
                if (category.CTCSort.Equals("CTC"))
                {
                    CategoryList = CategoryList.OrderBy(m => m.CTCValue).ToList();
                }
            }
            List<AdminCTCWithAddedBy> adminCTCWithAddedBy = new List<AdminCTCWithAddedBy>();
            foreach (ManageCTC ctc in CategoryList)
            {
                AdminCTCWithAddedBy adminCTCWithAddedBy1 = new AdminCTCWithAddedBy();
                adminCTCWithAddedBy1.CTC = ctc;
                User user = db.Users.FirstOrDefault(m => m.IsActive && m.Users == ctc.CreatedBy);
                adminCTCWithAddedBy1.FirstName = user.FirstName;
                adminCTCWithAddedBy1.LastName = user.LastName;
                adminCTCWithAddedBy.Add(adminCTCWithAddedBy1);
            }
            if (!String.IsNullOrEmpty(category.AddedBySort))
            {
                if (category.AddedBySort.Equals("addedby"))
                {
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.LastName).ToList();
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.FirstName).ToList();
                }
            }
            if (adminCTCWithAddedBy.Count == 0)
            {
                ViewBag.ManageCategory = "true";
            }
            category.ctc = adminCTCWithAddedBy.ToPagedList(category.CTCIndex ?? 1, 5);
            return View(category);
        }

        public ActionResult EditCategory(int id)
        {

            Session["CategoryId"] = id;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
            return RedirectToAction("AddCategory", "Admin", manageCTC);
        }
        public ActionResult DeleteCategory(int id)
        {
            User Admin = Session["User"] as User;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id && m.IsActive);
            if (manageCTC != null)
            {
                manageCTC.IsActive = false;
                manageCTC.ModifiedBy = Admin.Users;
                manageCTC.ModifiedDate = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("ManageCatagory", "Admin");
        }


        public ActionResult AddType(ManageCTC manageCTC)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            return View(manageCTC);

        }
        [HttpPost]
        public ActionResult AddType(ManageCTC manageCTC, string extra)
        {
            User Admin = Session["User"] as User;
            if (manageCTC.CTCValue == null)
            {
                ViewBag.CTC = "Please enter the type";
                return View(manageCTC);
            }
            else if (manageCTC.Descriptions == null)
            {
                ViewBag.Description = "Please enter the description";
                return View(manageCTC);
            }
            else
            {


                int id = Convert.ToInt32(Session["TypeId"]);

                if (id == 0)
                {
                    bool IsExist = db.ManageCTCs.Any(m => m.CTCValue.ToLower().Equals(manageCTC.CTCValue));
                    if (!IsExist)
                    {
                        ManageCTC AddCTC = new ManageCTC();
                        AddCTC.CTC = 2;
                        AddCTC.CTCValue = manageCTC.CTCValue;
                        AddCTC.Descriptions = manageCTC.Descriptions;
                        AddCTC.CreatedBy = Admin.Users;
                        AddCTC.CreatedDate = DateTime.Now;
                        AddCTC.IsActive = true;
                        db.ManageCTCs.Add(AddCTC);
                        db.SaveChanges();
                    }
                    else
                    {
                        ViewBag.Exist = "This type is already created";
                        return View(manageCTC);
                    }

                }
                else
                {
                    ManageCTC AddCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
                    AddCTC.CTC = 2;
                    AddCTC.CTCValue = manageCTC.CTCValue;
                    AddCTC.Descriptions = manageCTC.Descriptions;
                    AddCTC.ModifiedBy = Admin.Users;
                    AddCTC.ModifiedDate = DateTime.Now;
                    AddCTC.IsActive = true;
                    db.SaveChanges();

                }

                Session["TypeId"] = null;
                return RedirectToAction("ManageType", "Admin");
            }



        }
        public ActionResult ManageType(AdminCTCCommon type)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            List<ManageCTC> TypeList = db.ManageCTCs.Where(m => m.CTC == 2).OrderByDescending(m => m.CreatedDate).ToList();
            if (!String.IsNullOrEmpty(type.CTCSearch))
            {
                TypeList = TypeList.Where(m => m.CTCValue.ToLower().Contains(type.CTCSearch)).ToList();
            }
            if (!String.IsNullOrEmpty(type.CTCSort))
            {
                if (type.CTCSort.Equals("CTC"))
                {
                    TypeList = TypeList.OrderBy(m => m.CTCValue).ToList();
                }
            }
            List<AdminCTCWithAddedBy> adminCTCWithAddedBy = new List<AdminCTCWithAddedBy>();
            foreach (ManageCTC ctc in TypeList)
            {
                AdminCTCWithAddedBy adminCTCWithAddedBy1 = new AdminCTCWithAddedBy();
                adminCTCWithAddedBy1.CTC = ctc;
                User user = db.Users.FirstOrDefault(m => m.IsActive && m.Users == ctc.CreatedBy);
                adminCTCWithAddedBy1.FirstName = user.FirstName;
                adminCTCWithAddedBy1.LastName = user.LastName;
                adminCTCWithAddedBy.Add(adminCTCWithAddedBy1);
            }
            if (!String.IsNullOrEmpty(type.AddedBySort))
            {
                if (type.AddedBySort.Equals("addedby"))
                {
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.LastName).ToList();
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.FirstName).ToList();
                }
            }
            if (adminCTCWithAddedBy.Count == 0)
            {
                ViewBag.Managetype = "true";
            }
            type.ctc = adminCTCWithAddedBy.ToPagedList(type.CTCIndex ?? 1, 5);
            return View(type);
        }

        public ActionResult EditType(int id)
        {
            Session["TypeId"] = id;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
            return RedirectToAction("AddType", "Admin", manageCTC);
        }
        public ActionResult DeleteType(int id)
        {
            User Admin = Session["User"] as User;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id && m.IsActive);
            if (manageCTC != null)
            {
                manageCTC.IsActive = false;
                manageCTC.ModifiedBy = Admin.Users;
                manageCTC.ModifiedDate = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("ManageType", "Admin");
        }

        public ActionResult AddCountry(ManageCTC manageCTC)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            return View(manageCTC);

        }
        [HttpPost]
        public ActionResult AddCountry(ManageCTC manageCTC, string extra)
        {
            User Admin = Session["User"] as User;
            if (manageCTC.CTCValue == null)
            {
                ViewBag.CTC = "Please enter the country";
                return View(manageCTC);
            }
            else if (manageCTC.CountryCode == null)
            {
                ViewBag.CountryCode = "Please enter the country code";
                return View(manageCTC);
            }
            else
            {


                int id = Convert.ToInt32(Session["CountryId"]);

                if (id == 0)
                {
                    bool IsExist = db.ManageCTCs.Any(m => m.CTCValue.ToLower().Equals(manageCTC.CTCValue) || (m.CountryCode == manageCTC.CountryCode));
                    if (!IsExist)
                    {
                        ManageCTC AddCTC = new ManageCTC();
                        AddCTC.CTC = 3;
                        AddCTC.CTCValue = manageCTC.CTCValue;
                        AddCTC.CountryCode = manageCTC.CountryCode;
                        AddCTC.CreatedBy = Admin.Users;
                        AddCTC.CreatedDate = DateTime.Now;
                        AddCTC.Descriptions = "Country added";
                        AddCTC.IsActive = true;
                        db.ManageCTCs.Add(AddCTC);
                        db.SaveChanges();
                    }
                    else
                    {
                        ViewBag.CountryCode = "This country either countrycode is already exist";
                        return View(manageCTC);
                    }

                }
                else
                {
                    ManageCTC AddCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
                    AddCTC.CTC = 3;
                    AddCTC.CTCValue = manageCTC.CTCValue;
                    AddCTC.CountryCode = manageCTC.CountryCode;
                    AddCTC.ModifiedBy = Admin.Users;
                    AddCTC.ModifiedDate = DateTime.Now;
                    AddCTC.IsActive = true;
                    db.SaveChanges();

                }

                Session["CountryId"] = null;
                return RedirectToAction("ManageCountry", "Admin");
            }



        }
        public ActionResult ManageCountry(AdminCTCCommon country)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<ManageCTC> AdminList = db.ManageCTCs.Where(m => m.CTC == 3).OrderBy(m => m.CreatedDate).ToList();
            if (!String.IsNullOrEmpty(country.CTCSearch))
            {
                AdminList = AdminList.Where(m => m.CTCValue.ToLower().Contains(country.CTCSearch)).ToList();
            }
            if (!String.IsNullOrEmpty(country.CTCSort))
            {
                if (country.CTCSort.Equals("CTC"))
                {
                    AdminList = AdminList.OrderBy(m => m.CTCValue).ToList();
                }
            }
            if (!String.IsNullOrEmpty(country.CountryCodeSort))
            {
                if (country.CountryCodeSort.Equals("countrycode"))
                {
                    AdminList = AdminList.OrderBy(m => m.CountryCode).ToList();
                }
            }
            List<AdminCTCWithAddedBy> adminCTCWithAddedBy = new List<AdminCTCWithAddedBy>();
            foreach (ManageCTC ctc in AdminList)
            {
                AdminCTCWithAddedBy adminCTCWithAddedBy1 = new AdminCTCWithAddedBy();
                adminCTCWithAddedBy1.CTC = ctc;
                User user = db.Users.FirstOrDefault(m => m.IsActive && m.Users == ctc.CreatedBy);
                adminCTCWithAddedBy1.FirstName = user.FirstName;
                adminCTCWithAddedBy1.LastName = user.LastName;
                adminCTCWithAddedBy.Add(adminCTCWithAddedBy1);
            }
            if (!String.IsNullOrEmpty(country.AddedBySort))
            {
                if (country.AddedBySort.Equals("addedby"))
                {
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.LastName).ToList();
                    adminCTCWithAddedBy = adminCTCWithAddedBy.OrderBy(m => m.FirstName).ToList();
                }
            }
            if (adminCTCWithAddedBy.Count == 0)
            {
                ViewBag.ManageCountry = "true";
            }
            country.ctc = adminCTCWithAddedBy.ToPagedList(country.CTCIndex ?? 1, 5);
            return View(country);
        }

        public ActionResult EditCountry(int id)
        {
            Session["CountryId"] = id;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id);
            return RedirectToAction("AddCountry", "Admin", manageCTC);
        }
        public ActionResult DeleteCountry(int id)
        {
            User Admin = Session["User"] as User;
            ManageCTC manageCTC = db.ManageCTCs.FirstOrDefault(m => m.CTCId == id && m.IsActive);
            if (manageCTC != null)
            {
                manageCTC.IsActive = false;
                manageCTC.ModifiedBy = Admin.Users;
                manageCTC.ModifiedDate = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("ManageCountry", "Admin");
        }
        public ActionResult AddAdministrator(AdminDetail adminProfile)
        {
            User SuperAdmin = Session["User"] as User;
            if (SuperAdmin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            AdminDetail adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == SuperAdmin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            ViewBag.CountryCode = db.ManageCTCs;
            int id = Convert.ToInt32(Session["AdminID"]);
            if (id != 0)
            {
                ViewBag.CountryCode = db.ManageCTCs;
                adminProfile = db.AdminDetails.FirstOrDefault(m => m.Users == id);
                string[] MobileNumber = adminProfile.PhoneNumber.Split(' ');
                adminProfile.Number = MobileNumber[1];
                ViewBag.CountryCode1 = MobileNumber[0];
                return View(adminProfile);

            }

            else
            {
                return View(adminProfile);
            }
        }
        [HttpPost]
        public ActionResult AddAdministrator(AdminDetail adminProfile, string CountryCode)
        {
            User SuperAdmin = Session["User"] as User;
            int id = Convert.ToInt32(Session["AdminID"]);

            if (id == 0)
            {
                bool IsExist = db.Users.Any(m => m.EmailID == adminProfile.User.EmailID);
                if (!IsExist)
                {
                    User user = adminProfile.User;
                    user.IsActive = true;
                    user.UserRole = 2;
                    user.Passwords = "Admin@123";
                    user.ConfirmPasswords = user.Passwords;
                    user.CreatedDate = DateTime.Now;
                    user.IsEmailVerified = true;
                    user.IsDetailSubmitted = true;
                    db.Users.Add(user);
                    db.SaveChanges();
                    adminProfile.Users = db.Users.FirstOrDefault(m => m.EmailID == adminProfile.User.EmailID).Users;
                    if (adminProfile.Number != null)
                    {
                        adminProfile.PhoneNumber = "+" + CountryCode + " " + adminProfile.Number;
                    }
                    adminProfile.IsActive = true;
                    adminProfile.ModifiedBy = SuperAdmin.Users;
                    adminProfile.ModifiedDate = DateTime.Now;

                    db.AdminDetails.Add(adminProfile);
                    db.SaveChanges();

                }
                else
                {
                    ViewBag.Admin = "Admin email you have entered is already exist";
                    ViewBag.CountryCode1 = CountryCode;
                    return View(adminProfile);
                }
            }
            else
            {

                AdminDetail adminProfileDetail = db.AdminDetails.FirstOrDefault(m => m.Users == id);
                if (adminProfileDetail.User.EmailID == adminProfile.User.EmailID)
                {
                    adminProfileDetail.User.FirstName = adminProfile.User.FirstName;
                    adminProfileDetail.User.LastName = adminProfile.User.LastName;
                    adminProfileDetail.ModifiedBy = SuperAdmin.Users;
                    adminProfileDetail.ModifiedDate = DateTime.Now;
                    adminProfileDetail.User.ConfirmPasswords = adminProfileDetail.User.Passwords;
                    if (adminProfile.Number != null)
                    {
                        adminProfileDetail.PhoneNumber = "+" + CountryCode + " " + adminProfile.Number;
                    }
                    adminProfileDetail.User.IsActive = true;
                    db.SaveChanges();
                }
                else
                {
                    bool IsExist = db.Users.Any(m => m.EmailID == adminProfile.User.EmailID);
                    if (!IsExist)
                    {
                        adminProfileDetail.User.FirstName = adminProfile.User.FirstName;
                        adminProfileDetail.User.LastName = adminProfile.User.LastName;
                        adminProfileDetail.ModifiedBy = SuperAdmin.Users;
                        adminProfileDetail.ModifiedDate = DateTime.Now;
                        adminProfileDetail.User.ConfirmPasswords = adminProfileDetail.User.Passwords;
                        adminProfileDetail.User.IsActive = true;
                        if (adminProfile.Number != null)
                        {
                            adminProfileDetail.PhoneNumber = "+" + CountryCode + " " + adminProfile.Number;
                        }
                        db.SaveChanges();
                    }
                    else
                    {
                        ViewBag.Admin = "Admin email you have entered is already exist";
                        ViewBag.CountryCode1 = CountryCode;
                        return View(adminProfile);
                    }
                }


            }
            Session["AdminID"] = null;
            return RedirectToAction("ManageAdministrator", "Admin");

        }
        public ActionResult ManageAdministrator(AdminManageAdmin adminManageAdmin)
        {
            User SuperAdmin = Session["User"] as User;
            if (SuperAdmin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            AdminDetail adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == SuperAdmin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<AdminDetail> AdminList = db.AdminDetails.Where(m => m.User.UserRole == 2).OrderByDescending(m => m.User.CreatedDate).ToList();
            if (!String.IsNullOrEmpty(adminManageAdmin.AdminSearch))
            {
                AdminList = AdminList.Where(m => m.User.FirstName.ToLower().Contains(adminManageAdmin.AdminSearch.ToLower()) || m.User.LastName.ToLower().Contains(adminManageAdmin.AdminSearch.ToLower()) || m.User.EmailID.ToLower().Contains(adminManageAdmin.AdminSearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(adminManageAdmin.FirstNameSort))
            {
                if (adminManageAdmin.FirstNameSort.Equals("FirstName"))
                {
                    AdminList = AdminList.OrderBy(m => m.User.FirstName).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminManageAdmin.LastNameSort))
            {
                if (adminManageAdmin.FirstNameSort.Equals("LastName"))
                {
                    AdminList = AdminList.OrderBy(m => m.User.LastName).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminManageAdmin.PhoneNumberSort))
            {
                if (adminManageAdmin.PhoneNumberSort.Equals("PhoneNumber"))
                {
                    AdminList = AdminList.OrderBy(m => m.User.AdminDetails.Select(x => x.PhoneNumber)).ToList();
                }
            }
            if (AdminList.Count == 0)
            {
                ViewBag.ManageAdmin = "true";
            }
            adminManageAdmin.Admin = AdminList.ToPagedList(adminManageAdmin.AdminIndex ?? 1, 5);
            return View(adminManageAdmin);
        }

        public ActionResult EditAdministrator(int id)
        {
            Session["AdminID"] = id;

            return RedirectToAction("AddAdministrator", "Admin");
        }
        public ActionResult DeleteAdministrator(int id)
        {
            User SuperAdmin = Session["User"] as User;
            User user = db.Users.FirstOrDefault(m => m.Users == id && m.IsActive);
            if (user != null)
            {
                user.IsActive = false;
                user.ConfirmPasswords = user.Passwords;
                user.ModifiedBy = SuperAdmin.Users;
                user.ModifiedDate = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("ManageAdministrator", "Admin");
        }

        public ActionResult ManageSystemConfig(SystemConfiguration SC)
        {
            User SuperAdmin = Session["User"] as User;
            if (SuperAdmin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == SuperAdmin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            SystemConfiguration SystemConfig = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1);
            if (SystemConfig == null)
            {
                return View();
            }
            else
            {
                return View(SystemConfig);
            }
        }
        [HttpPost]
        public ActionResult ManageSystemConfig(SystemConfiguration SC, string extra)
        {
            User SuperAdmin = Session["User"] as User;
            SystemConfiguration SystemConfig = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1);
            if (SystemConfig == null)
            {
                SystemConfiguration SystemCon = new SystemConfiguration();
                if (SC.DefaultUserProfilePicture != null && SC.DefaultNotePicture != null)
                {
                    if (SC.DefaultUserProfilePicture.ContentLength < (5 * 1024 * 1024))
                    {
                        var DefaultUserProfilePictureExt = Path.GetExtension(SC.DefaultUserProfilePicture.FileName);
                        var DefaultUserProfilePictureName = "Default" + DefaultUserProfilePictureExt;
                        // store the file inside ~/App_Data/uploads folder
                        var DefaultUserProfilePicturePath = Path.Combine(Server.MapPath("~/Upload/UserProfilePicture/"), DefaultUserProfilePictureName);
                        SC.DefaultUserProfilePicture.SaveAs(DefaultUserProfilePicturePath);
                        SystemCon.DefaultProfilePicture = DefaultUserProfilePictureName;
                    }
                    else
                    {
                        ViewBag.SystemConfig = "Image size should be less than 5MB";
                        return View(SC);
                    }


                    if (SC.DefaultNotePicture.ContentLength < (5 * 1024 * 1024))
                    {
                        var DefaultNotePictureExt = Path.GetExtension(SC.DefaultUserProfilePicture.FileName);
                        var DefaultNotePictureName = "Default" + DefaultNotePictureExt;
                        // store the file inside ~/App_Data/uploads folder
                        var DefaultUserProfilePicturePath = Path.Combine(Server.MapPath("~/Upload/BookPicture/"), DefaultNotePictureName);
                        SC.DefaultNotePicture.SaveAs(DefaultUserProfilePicturePath);
                        SystemCon.DefaultNotePreview = DefaultNotePictureName;
                    }
                    else
                    {
                        ViewBag.SystemConfig = "Image size should be less than 5MB";
                        return View(SC);
                    }
                    SystemCon.ConfigId = 1;
                    SystemCon.EmailID1 = SC.EmailID1;
                    SystemCon.EmailID2 = SC.EmailID2;
                    SystemCon.PhoneNumber = SC.PhoneNumber;
                    SystemCon.FacebookUrl = SC.FacebookUrl;
                    SystemCon.TwitterUrl = SC.TwitterUrl;
                    SystemCon.LinkedInUrl = SC.LinkedInUrl;
                    SystemCon.CreatedBy = SuperAdmin.Users;
                    SystemCon.CreatedDate = DateTime.Now;
                    db.SystemConfigurations.Add(SystemCon);
                    db.SaveChanges();


                }
                else
                {
                    ViewBag.SystemConfig1 = "Please upload default images";
                    return View(SC);

                }


            }
            else
            {
                SystemConfiguration SystemCon = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1);
                if (SC.DefaultUserProfilePicture != null)
                {
                    if (SC.DefaultUserProfilePicture.ContentLength < (5 * 1024 * 1024))
                    {
                        var DefaultUserProfilePictureExt = Path.GetExtension(SC.DefaultUserProfilePicture.FileName);
                        var DefaultUserProfilePictureName = "UserProfilePicture";
                        // store the file inside ~/App_Data/uploads folder
                        var DefaultUserProfilePicturePath = Path.Combine(Server.MapPath("~/Upload/DefaultImage/"), DefaultUserProfilePictureName);
                        SC.DefaultUserProfilePicture.SaveAs(DefaultUserProfilePicturePath);
                        SystemCon.DefaultProfilePicture = DefaultUserProfilePictureName;
                    }
                    else
                    {
                        ViewBag.SystemConfig = "Image size should be less than 5MB";
                        return View(SC);
                    }

                }
                if (SC.DefaultNotePicture != null)
                {
                    if (SC.DefaultNotePicture.ContentLength < (5 * 1024 * 1024))
                    {
                        var DefaultNotePictureExt = Path.GetExtension(SC.DefaultUserProfilePicture.FileName);
                        var DefaultNotePictureName = "NotePicture";
                        // store the file inside ~/App_Data/uploads folder
                        var DefaultUserProfilePicturePath = Path.Combine(Server.MapPath("~/Upload/DefaultImage/"), DefaultNotePictureName);
                        SC.DefaultNotePicture.SaveAs(DefaultUserProfilePicturePath);
                        SystemCon.DefaultNotePreview = DefaultNotePictureName;
                    }
                    else
                    {
                        ViewBag.SystemConfig = "Image size should be less than 5MB";
                        return View(SC);
                    }

                }
                SystemCon.EmailID1 = SC.EmailID1;
                SystemCon.EmailID2 = SC.EmailID2;
                SystemCon.PhoneNumber = SC.PhoneNumber;
                SystemCon.FacebookUrl = SC.FacebookUrl;
                SystemCon.TwitterUrl = SC.TwitterUrl;
                SystemCon.LinkedInUrl = SC.LinkedInUrl;
                SystemCon.ModifiedBy = SuperAdmin.Users;
                SystemCon.ModifiedDate = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("Dashboard", "Admin");
        }

        public ActionResult MyProfile(AdminDetail adminDetail)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            ViewBag.CountryCode = db.ManageCTCs;
            //int id = Convert.ToInt32(Session["AdminID"]);
            int id = 91;
            if (id != 0)
            {
                ViewBag.CountryCode = db.ManageCTCs;
                adminDetail = db.AdminDetails.FirstOrDefault(m => m.Users == id);
                string[] MobileNumber = adminDetail.PhoneNumber.Split(' ');
                adminDetail.Number = MobileNumber[1];
                ViewBag.CountryCode1 = MobileNumber[0];
                return View(adminDetail);

            }

            else
            {
                return View(adminDetail);
            }
        }
        [HttpPost]
        public ActionResult MyProfile(AdminDetail adminDetail, string CountryCode)
        {
            User Admin = Session["User"] as User;
            if (adminDetail.ProfilePic != null)
            {
                if (adminDetail.ProfilePic.ContentLength < (5 * 1024 * 1024))
                {
                    AdminDetail MyProfile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);

                    var ProfilePicExt = Path.GetExtension(adminDetail.ProfilePic.FileName);
                    var ProfilePicName = "User" + MyProfile.Users + ProfilePicExt;
                    // store the file inside ~/App_Data/uploads folder
                    var ProfilePicPath = Path.Combine(Server.MapPath("~/Upload/UserProfilePicture/"), ProfilePicName);
                    adminDetail.ProfilePic.SaveAs(ProfilePicPath);
                    adminDetail.ProfilePicture = ProfilePicName;

                    MyProfile.User.FirstName = adminDetail.User.FirstName;
                    MyProfile.User.LastName = adminDetail.User.LastName;
                    MyProfile.User.ConfirmPasswords = adminDetail.User.Passwords;
                    MyProfile.ModifiedBy = Admin.Users;
                    if (adminDetail.Number != null)
                    {
                        MyProfile.PhoneNumber = "+" + CountryCode + " " + adminDetail.Number; ;
                    }
                    if (adminDetail.SecondaryEmail != null)
                    {
                        MyProfile.SecondaryEmail = adminDetail.SecondaryEmail;
                    }
                    db.SaveChanges();
                }
                else
                {
                    ViewBag.Img = "Profile picture size must be less than 5MB";
                    return View(adminDetail);
                }
            }
            else
            {
                AdminDetail MyProfile = db.AdminDetails.FirstOrDefault(m => m.Users == 91);

                MyProfile.User.FirstName = adminDetail.User.FirstName;
                MyProfile.User.LastName = adminDetail.User.LastName;
                MyProfile.User.ConfirmPasswords = adminDetail.User.Passwords;
                MyProfile.ModifiedBy = Admin.Users;
                if (adminDetail.Number != null)
                {
                    MyProfile.PhoneNumber = "+" + CountryCode + " " + adminDetail.Number; ;
                }
                if (adminDetail.SecondaryEmail != null)
                {
                    MyProfile.SecondaryEmail = adminDetail.SecondaryEmail;
                }
                db.SaveChanges();

            }
            return RedirectToAction("Dashboard", "Admin");
        }
        public ActionResult EditProfile(int id)
        {
            return RedirectToAction("MyProfile", "Admin");
        }

        public ActionResult SpamReport(AdminSpamReport adminSpamReport)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<SpamReport> SpamList = db.SpamReports.OrderByDescending(m => m.CreatedDate).ToList();
            if (!String.IsNullOrEmpty(adminSpamReport.SpamSearch))
            {
                SpamList = SpamList.Where(m => m.NoteDetail.Title.ToLower().Contains(adminSpamReport.SpamSearch.ToLower()) || (m.NoteDetail.Category.ToLower().Contains(adminSpamReport.SpamSearch.ToLower())) || (m.User.FirstName.ToLower().Contains(adminSpamReport.SpamSearch.ToLower())) || (m.User.LastName.ToLower().Contains(adminSpamReport.SpamSearch.ToLower()))).OrderByDescending(m => m.CreatedDate).ToList();
            }
            if (!String.IsNullOrEmpty(adminSpamReport.SpamCategorySort))
            {
                if (adminSpamReport.SpamCategorySort.Equals("category"))
                {
                    SpamList = SpamList.OrderBy(m => m.NoteDetail.Category).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminSpamReport.SpamTitleSort))
            {
                if (adminSpamReport.SpamTitleSort.Equals("title"))
                {
                    SpamList = SpamList.OrderBy(m => m.NoteDetail.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminSpamReport.SpamReportedBySort))
            {
                if (adminSpamReport.SpamReportedBySort.Equals("reportedby"))
                {
                    SpamList = SpamList.OrderBy(m => m.User.LastName).ToList();
                    SpamList = SpamList.OrderBy(m => m.User.FirstName).ToList();
                }
            }
            if (SpamList.Count == 0)
            {
                ViewBag.Spam = "true";
            }
            adminSpamReport.SpamReport = SpamList.ToPagedList(adminSpamReport.SpamIndex ?? 1, 5);
            return View(adminSpamReport);
        }

        public ActionResult Members(AdminMembers adminMembers)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }

            List<User> UserList = db.Users.Where(m => m.IsActive && m.IsDetailSubmitted && m.IsEmailVerified && m.UserRole == 1).OrderByDescending(m => m.ModifiedDate).ToList();
            if (!String.IsNullOrEmpty(adminMembers.MemberSearch))
            {
                UserList = UserList.Where(m => m.FirstName.ToLower().Contains(adminMembers.MemberSearch.ToLower()) || (m.LastName.ToLower().Contains(adminMembers.MemberSearch.ToLower())) || (m.EmailID.ToLower().Contains(adminMembers.MemberSearch.ToLower()))).OrderByDescending(m => m.CreatedDate).ToList();
            }
            if (!String.IsNullOrEmpty(adminMembers.FirstNameSort))
            {
                if (adminMembers.FirstNameSort.Equals("firstname"))
                {
                    UserList = UserList.OrderBy(m => m.FirstName).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.LastNameSort))
            {
                if (adminMembers.LastNameSort.Equals("lastname"))
                {
                    UserList = UserList.OrderBy(m => m.LastName).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.NotesUnderReviewSort))
            {
                if (adminMembers.NotesUnderReviewSort.Equals("notesunderreview"))
                {
                    UserList = UserList.OrderByDescending(m => m.NoteDetails.Where(x => x.NoteStatus == 3 && x.IsActive).Count()).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.PublishedNotesSort))
            {
                if (adminMembers.PublishedNotesSort.Equals("publishednotes"))
                {
                    UserList = UserList.OrderByDescending(m => m.NoteDetails.Where(x => x.NoteStatus == 4 && x.IsActive).Count()).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.DownloadedNotesSort))
            {
                if (adminMembers.DownloadedNotesSort.Equals("downloadednotes"))
                {
                    UserList = UserList.OrderByDescending(m => m.DownloadedNotes1.Where(x => x.IsApproved).Count()).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.TotalExpenseSort))
            {
                if (adminMembers.TotalExpenseSort.Equals("totalexpense"))
                {
                    UserList = UserList.OrderByDescending(m => m.DownloadedNotes1.Where(x => x.IsApproved).Select(x => x.SellPrice).Sum()).ToList();
                }
            }
            if (!String.IsNullOrEmpty(adminMembers.TotalEarningSort))
            {
                if (adminMembers.TotalEarningSort.Equals("totalearning"))
                {
                    UserList = UserList.OrderByDescending(m => m.DownloadedNotes.Where(x => x.IsApproved).Select(x => x.SellPrice).Sum()).ToList();
                }
            }
            if (UserList.Count == 0)
            {
                ViewBag.Members = "true";
            }
            adminMembers.User = UserList.ToPagedList(adminMembers.MemberIndex ?? 1, 5);
            return View(adminMembers);
        }
        public ActionResult MemberDetail(AdminMemberDetail adminMemberDetail)
        {
            User Admin = Session["User"] as User;
            if (Admin.UserRole == 3)
            {
                ViewBag.SuperAdmin = "true";
            }
            var adminprofile = db.AdminDetails.FirstOrDefault(m => m.Users == Admin.Users);
            if (adminprofile.ProfilePicture != null)
            {
                ViewBag.ProfilePic = adminprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            int id = Convert.ToInt32(Session["MemberID"]);
            UserProfileDetail userProfile = db.UserProfileDetails.FirstOrDefault(m => m.IsActive && m.Users == id);
            adminMemberDetail.Member = userProfile;
            List<NoteDetail> notes = db.NoteDetails.Where(m => m.Users == id && m.IsActive && (m.NoteStatus < 5)).ToList();
            if (notes.Count == 0)
            {
                ViewBag.MemberDetail = "true";
            }
            adminMemberDetail.Note = notes.ToPagedList(adminMemberDetail.MemberDetailIndex ?? 1, 5);
            return View(adminMemberDetail);
        }
        public FileResult DownloadNote(int BookID)
        {
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == BookID && m.IsActive == true);
            string path = "C:/Project/NotesMarketplace/Upload/NoteAttchment/" + note.NoteAttachment;
            byte[] bytes = System.IO.File.ReadAllBytes(path);
            return File(bytes, "application/octet-stream", path);
        }

        public ActionResult ApproveNote(int BookID)
        {
            User Admin = Session["User"] as User;
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == BookID && m.IsActive == true);
            note.NoteStatus = 4;
            note.ModifiedBy = Admin.Users;
            note.ModifiedDate = DateTime.Now;
            note.PublishedDate = DateTime.Now;
            db.SaveChanges();
            return RedirectToAction(Route, "Admin");
        }
        public ActionResult RejectNote(int BookID)
        {
            User Admin = Session["User"] as User;
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == BookID && m.IsActive == true);
            note.NoteStatus = 5;
            note.ModifiedBy = Admin.Users;
            note.ModifiedDate = DateTime.Now;
            db.SaveChanges();
            return RedirectToAction("NotesUnderReview", "Admin");
        }
        public ActionResult InReviewNote(int BookID)
        {
            User Admin = Session["User"] as User;
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == BookID && m.IsActive == true);
            note.NoteStatus = 3;
            note.ModifiedBy = Admin.Users;
            note.ModifiedDate = DateTime.Now;
            db.SaveChanges();
            return RedirectToAction("NotesUnderReview", "Admin");
        }
        public ActionResult BookID(int id)
        {
            Session["BookID"] = id;
            return RedirectToAction("NoteDetails", "Admin");
        }
        public ActionResult DeleteSpam(int id)
        {
            SpamReport Spam = db.SpamReports.FirstOrDefault(m => m.Note == id);
            db.SpamReports.Remove(Spam);
            db.SaveChanges();
            return RedirectToAction("SpamReport", "Admin");
        }
        public ActionResult ViewMemberDetail(int id)
        {
            Session["MemberID"] = id;
            return RedirectToAction("MemberDetail", "Admin");
        }
        public ActionResult DeactiveMember(int id)
        {
            User Admin = Session["User"] as User;
            User user = db.Users.FirstOrDefault(m => m.IsActive && m.Users == id);
            user.IsActive = false;
            user.ModifiedBy = Admin.Users;
            user.ModifiedDate = DateTime.Now;
            user.ConfirmPasswords = user.Passwords;
            db.SaveChanges();
            return RedirectToAction("Members", "Admin");
        }
        public ActionResult Logout()
        {
            Session["Admin"] = null;
            Session["SuperAdmin"] = null;
            return RedirectToAction("Home", "Home");
        }
    }
}