using NotesMarketplace.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using PagedList;

namespace NotesMarketplace.Controllers
{
    public class HomeController : Controller
    {
        static String myrout = null;

        NotesMarketplaceEntities db = new NotesMarketplaceEntities();
        //Get Sign Up 
        public ActionResult SignUp()
        {

            return View();
        }

        //Post Sign Up 
        [HttpPost]
        public ActionResult SignUp(User user)
        {
            bool a = db.Users.Any(m => m.EmailID == user.EmailID);
            if (a)
            {
                ViewBag.flag = "true";
                return View();
            }

            else
            {
                ViewBag.flag = "false";
                if (user != null)
                {
                    user.UserRole = 1;
                    user.IsActive = true;
                    user.CreatedDate = DateTime.Now;


                    try
                    {
                        db.Users.Add(user);
                        db.SaveChanges();

                        MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                        mm.Subject = "Notes Marketplace Email-Verification";
                        mm.Body = "Hello " + user.FirstName + " " + user.LastName + ",\n\nThank you for signing up with us. Please click on below link to verify your email address and to do login. \n\nhttps//https://localhost:44351/Home/EmailVerification/?id=" + user.Users + "\n\nRegards,\nNotes Marketplace";

                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.gmail.com";
                        smtp.Port = 587;
                        smtp.UseDefaultCredentials = false;

                        NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                        smtp.EnableSsl = true;
                        smtp.Credentials = nc;
                        smtp.Send(mm);
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e.Message);
                    }


                }
            }

            return View();
        }

        //Get Login
        public ActionResult Login()
        {
            return View();
        }
        //Post Login
        [HttpPost]
        public ActionResult Login(User user)
        {

            User LoginUser = db.Users.FirstOrDefault(m => m.EmailID == user.EmailID && m.Passwords == user.Passwords);
            if (LoginUser != null)
            {
                ViewBag.Login = "true";
                if(!String.IsNullOrEmpty(myrout))
                {
                    return RedirectToAction(myrout, "Home");
                }
                else
                {
                    return RedirectToAction("Home", "Home");
                }

            }
            else
            {
                ViewBag.Login = "false";
                return View();
            }





        }
        //Get Email Verification
        public ActionResult EmailVerification(int id)
        {
            User user = db.Users.FirstOrDefault(m => m.Users == id);

            ViewBag.Name = user.FirstName;

            user.IsEmailVerified = true;
            user.ConfirmPasswords = user.Passwords;
            db.SaveChanges();
            return View();
        }
        //Post Email Verification
        [HttpPost]
        public ActionResult EmailVerification(User user)
        {

            return RedirectToAction("UserProfile", "Home");


        }
        //Get User Profile
        public ActionResult UserProfile()
        {
            return View();
        }
        //Get Forgot Password
        public ActionResult ForgotPassword()
        {
            return View();
        }
        //Post Forgot Password
        [HttpPost]
        public ActionResult ForgotPassword(String EmailID)
        {

            GeneratePassword pass = new GeneratePassword();
            string Password = GeneratePassword.Generate(6, 24);

            User user = db.Users.FirstOrDefault(m => m.EmailID == EmailID);

            user.Passwords = Password;
            user.ConfirmPasswords = user.Passwords;

            try
            {

                db.SaveChanges();

                MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                mm.Subject = "New Temporary Password has been created for you";
                mm.Body = "Hello \n\nWe have generated a new password for you \nPassword:" + Password + "\n\nRegards,\nNotes Marketplace";

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.UseDefaultCredentials = false;

                NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                smtp.EnableSsl = true;
                smtp.Credentials = nc;
                smtp.Send(mm);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return View();
        }
        //Get Contact Us
        public ActionResult ContactUs()
        {
            myrout = "ContactUs";
            return View();
        }
        //Post Contact Us
        [HttpPost]
        public ActionResult ContactUs(ContactUs user)
        {
            
            try
            {


                MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                mm.Subject = user.Subject;
                mm.Body = "Hello \n\n" + user.Question + "\n\nRegards,\nNotes Marketplace";

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.UseDefaultCredentials = false;

                NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                smtp.EnableSsl = true;
                smtp.Credentials = nc;
                smtp.Send(mm);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            return View();
        }
        //Get FAQ
        public ActionResult FAQ()
        {
            myrout = "FAQ";
            return View();
        }

        //Get Add Notes
        public ActionResult AddNotes()
        {
            ViewBag.Category = db.ManageCTCs;
            return View();
        }
        //Get Add Notes
        [HttpPost]
        public ActionResult AddNotes(HttpPostedFileBase DisplayPicture, HttpPostedFileBase NotePDF, HttpPostedFileBase Preview, NoteDetail note)
        {
            ViewBag.Category = db.ManageCTCs;
            if (note.Category.Equals("Select Your category"))
            {

                ViewBag.Message = "Please select category";
                return View(note);

            }
            else
            {



                if (DisplayPicture != null && NotePDF != null)
                {


                    if (DisplayPicture.ContentLength < (5 * 1024 * 1024))
                    {
                        var DisplayPictureExt = Path.GetExtension(DisplayPicture.FileName);
                        var DisplayPictureName = DateTime.Now.ToString("G").Replace(" ", "f").Replace("-", "s").Replace(":", "a") + DisplayPictureExt;
                        // store the file inside ~/App_Data/uploads folder
                        var DisplayPicturePath = Path.Combine(Server.MapPath("~/Upload/Img/"), DisplayPictureName);
                        DisplayPicture.SaveAs(DisplayPicturePath);
                        note.BookPicture = DisplayPictureName;

                        var NotePDFExt = Path.GetExtension(NotePDF.FileName);
                        var NotePDFName = DateTime.Now.ToString("G").Replace(" ", "f").Replace("-", "s").Replace(":", "a") + NotePDFExt;
                        // store the file inside ~/App_Data/uploads folder
                        var NotePDFpath = Path.Combine(Server.MapPath("~/Upload/Pdf/"), NotePDFName);

                        NotePDF.SaveAs(NotePDFpath);
                        note.NoteAttachment = NotePDFName;

                        var PreviewPDFExt = Path.GetExtension(NotePDF.FileName);
                        var PreviewPDFName = DateTime.Now.ToString("G").Replace(" ", "f").Replace("-", "s").Replace(":", "a") + PreviewPDFExt;
                        // store the file inside ~/App_Data/uploads folder
                        var PreviewPDFpath = Path.Combine(Server.MapPath("~/Upload/Pdf/"), PreviewPDFName);
                        note.NoteSize = (NotePDF.ContentLength) / (1024 * 1024);

                        NotePDF.SaveAs(PreviewPDFpath);
                        note.NotePreview = PreviewPDFName;
                        note.NoteAttachment = NotePDFpath;
                        note.NoteAttachment = NotePDFpath;
                        note.NotePreview = PreviewPDFpath;
                        note.Users = 35;
                        note.IsActive = true;
                        note.NoteStatus = 1;

                        note.Preview = null;
                        note.NotePDF = null;
                        note.DisplayPicture = null;

                        db.NoteDetails.Add(note);
                        db.SaveChanges();

                    }
                    else
                    {
                        ViewBag.Message = "File Greater than 5MB";
                    }


                }
                else
                {
                    ViewBag.Message = "You have not specified a file.";
                }
                return View();
            }
        }
        //Get Add Notes
        public ActionResult Dashboard(MyDashboard dashboard)
        {
            myrout = "Dashboard";
            MyDashboard myDashboard = new MyDashboard();
            List<NoteDetail> progresslist = db.NoteDetails.Where(m => m.NoteStatus == 1 && m.IsActive).OrderByDescending(m => m.CreatedDate).ToList();

            if (!String.IsNullOrEmpty(dashboard.progresssearch))
            {
                progresslist = progresslist.Where(m => m.Title.ToLower().StartsWith(dashboard.progresssearch.ToLower()) || m.Category.ToLower().StartsWith(dashboard.progresssearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(dashboard.ProgressTitleSort))
            {
                if (dashboard.ProgressTitleSort.Equals("title"))
                {
                    progresslist = progresslist.OrderBy(m => m.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(dashboard.ProgressCategorySort))
            {
                if (dashboard.ProgressCategorySort.Equals("category"))
                {
                    progresslist = progresslist.OrderBy(m => m.Category).ToList();
                }
            }
            myDashboard.progress = progresslist.ToPagedList(dashboard.progressindex ?? 1, 5);




            List<NoteDetail> publishlist = db.NoteDetails.Where(m => m.NoteStatus == 3 && m.IsActive).ToList();
            if (!String.IsNullOrEmpty(dashboard.publishsearch))
            {
                publishlist = publishlist.Where(m => m.Title.ToLower().StartsWith(dashboard.publishsearch.ToLower()) || m.Category.ToLower().StartsWith(dashboard.publishsearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(dashboard.PublishTitleSort))
            {
                if (dashboard.PublishTitleSort.Equals("title"))
                {
                    publishlist = publishlist.OrderBy(m => m.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(dashboard.PublishCategorySort))
            {
                if (dashboard.PublishCategorySort.Equals("category"))
                {
                    publishlist = publishlist.OrderBy(m => m.Category).ToList();
                }
            }
            myDashboard.progress = progresslist.ToPagedList(dashboard.progressindex ?? 1, 5);
            myDashboard.published = publishlist.ToPagedList(dashboard.publishindex ?? 1, 5);
            Statistic mystatistic = new Statistic();





            mystatistic = db.Statistics.FirstOrDefault(m => m.Users == 35);
            myDashboard.mystatistic = mystatistic;

            return View(myDashboard);
        }
        //Get Buyer Request
        public ActionResult BuyerRequests(BuyerRequest buyerRequest, int ? buyerrequestindex, string buyerrequestsearch)
        {
            List<BuyerRequest> BR = new List<BuyerRequest>();
            List<DownloadedNote> BRlist = db.DownloadedNotes.Where(m => m.Users == 35 && m.IsActive).OrderByDescending(m => m.CreatedDate).ToList();
            foreach(DownloadedNote myrequests in BRlist)
            {
                BuyerRequest br = new BuyerRequest();
                br.buyerrequest = myrequests;
                br.phonenumber = "+91 7359665133";
                br.emailid = db.Users.FirstOrDefault(m => m.Users == myrequests.Users).EmailID.ToString();
                BR.Add(br);
            }


            //if (!String.IsNullOrEmpty(buyerRequest.buyerrequestsearch))
            //{
            //    BRlist = BRlist.Where(m => m.Category.ToLower().StartsWith(buyerRequest.buyerrequestsearch.ToLower()) || m.NoteTitle.ToLower().StartsWith(buyerRequest.buyerrequestsearch.ToLower())).ToList();
            //}
            //BR.buyerrequest = BRlist.ToPagedList(buyerRequest.buyerrequestindex ?? 1, 10);
                return View(BR.ToPagedList(buyerrequestindex ??1,9));
        }
        // Get Home
        public ActionResult Home()
        {
            return View();
        }
        // Get Search Note
        public ActionResult Search()
        {
            myrout = "Search";
            Search MySearch = new Search();
            MySearch.Category = db.ManageCTCs.Where(m => m.CTC==1 && m.IsActive).ToList();
            MySearch.Type = db.ManageCTCs.Where(m => m.CTC == 2 && m.IsActive).ToList();
            MySearch.Country = db.ManageCTCs.Where(m => m.CTC == 3 && m.IsActive).ToList();
            List<NoteDetail> MyNote = db.NoteDetails.Where(m => m.NoteStatus == 3 && m.IsActive).OrderByDescending(m => m.CreatedDate).ToList();
            //foreach(ManageCTC ctc in MySearch.Category)
            //{
            //    if (ctc.CTCValue.Equals(MySearch.categorysort))
            //{
            //        MyNote= MyNote.OrderBy(m => m.Category.Equals(MySearch.categorysort)).ToList();
            //    }
            //}
            //foreach (ManageCTC ctc in MySearch.Type)
            //{
            //    if (ctc.CTCValue.Equals(MySearch.typesort))
            //    {
            //        MyNote = MyNote.OrderBy(m => m.NoteType.Equals(MySearch.typesort)).ToList();
            //    }
            //}
            //foreach (ManageCTC ctc in MySearch.Country)
            //{
            //    if (ctc.CTCValue.Equals(MySearch.categorysort))
            //    {
            //        MyNote = MyNote.OrderBy(m => m.Country.Equals(MySearch.countrysort)).ToList();
            //    }
            //}
            MySearch.search = MyNote.ToPagedList(MySearch.searchindex ?? 1,9);
            return View(MySearch);
        }
        // Get Note Detail
        public ActionResult NoteDetails()
        {
            NoteDetails note = new NoteDetails();
            note.notedetail = db.NoteDetails.FirstOrDefault(m => m.Note == 21 && m.IsActive);
            return View(note);
        }
    }
}