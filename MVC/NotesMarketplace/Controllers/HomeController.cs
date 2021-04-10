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
    public class HomeController : Controller
    {
        static String MyRoute = null;

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

                        MailMessage mm = new MailMessage("rajp30398@gmail.com", user.EmailID);
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
            HttpCookie cookieObj = Request.Cookies["RememberMe"];
            User user = new User();

            if (cookieObj != null)
            {
                user.EmailID = cookieObj["emailid"];
                user.Passwords = cookieObj["password"];

                if (cookieObj["emailid"].Length != 0)
                {
                    user.RememberMe = true;
                }
                else
                {
                    user.RememberMe = false;
                }
            }
            return View(user);

        }
        //Post Login
        [HttpPost]
        public ActionResult Login(User user)
        {
            HttpCookie cookie = new HttpCookie("RememberMe");
            if (user.RememberMe == true)
            {
                cookie["emailid"] = user.EmailID;
                cookie["password"] = user.Passwords;
                cookie.Expires = DateTime.Now.AddMonths(1);
            }
            else
            {
                cookie["emailid"] = null;
                cookie["password"] = null;
            }
            Response.Cookies.Add(cookie);

            User LoginUser = db.Users.FirstOrDefault(m => m.EmailID == user.EmailID && m.Passwords == user.Passwords && m.IsActive);

            if(LoginUser!=null)
            {
                ViewBag.Login = "true";
                if (LoginUser.IsEmailVerified)
                {
                    if (LoginUser.UserRole >= 2)
                    {
                        Session["User"] = LoginUser;
                        return RedirectToAction("Dashboard", "Admin");
                    }
                    if (LoginUser.UserRole == 1)
                    {
                        

                            
                            if (!LoginUser.IsDetailSubmitted)
                            {
                                Session["User"] = LoginUser;
                                return RedirectToAction("UserProfile", "Home");
                            }
                            else
                            {
                                Session["User"] = LoginUser;
                                return RedirectToAction(MyRoute, "Home");
                            }
                        
                        
                    }

                }
                else
                {
                    try
                    {


                        ViewBag.Message = "Please verify your email from registered email";
                        MailMessage mm = new MailMessage("rajp30398@gmail.com", user.EmailID);
                        mm.Subject = "Notes Marketplace Email-Verification";
                        mm.Body = "Hello " + LoginUser.FirstName + " " + LoginUser.LastName + ",\n\nThank you for signing up with us. Please click on below link to verify your email address and to do login. \n\nhttps//https://localhost:44351/Home/EmailVerification/?id=" + LoginUser.Users + "\n\nRegards,\nNotes Marketplace";

                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.gmail.com";
                        smtp.Port = 587;
                        smtp.UseDefaultCredentials = false;

                        NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                        smtp.EnableSsl = true;
                        smtp.Credentials = nc;
                        smtp.Send(mm);
                        return View();
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e.Message);
                    }
                }
            }
            else
            {

                ViewBag.Login = "false";
                return View(user);
            }
            

            return View();

        }
        //Get Email Verification
        public ActionResult EmailVerification(int id)
        {
            User user = db.Users.FirstOrDefault(m => m.Users == id);

            ViewBag.Name = user.FirstName;

            Session["id"] = user.Users;
            return View();
        }
        //Post Email Verification
        [HttpPost]
        public ActionResult EmailVerification()
        {
            int id = Convert.ToInt32(Session["id"]);
            User user2 = db.Users.FirstOrDefault(m => m.Users == id);
            user2.IsEmailVerified = true;
            user2.ConfirmPasswords = user2.Passwords;
            Statistic stat = new Statistic();
            stat.Users = user2.Users;
            db.Statistics.Add(stat);
            db.SaveChanges();
            Session["User"] = user2;
            Session["id"] = null;
            
            if (user2.IsDetailSubmitted)
            {
                return RedirectToAction("Home", "Home");
            }
            else
            {
                return RedirectToAction("UserProfile", "Home");
            }



        }

        //Get User Profile
        public ActionResult UserProfile()
        {
            ViewBag.Category = db.ManageCTCs;
            User user2 = Session["User"] as User;
            if (user2.IsDetailSubmitted == true)
            {
                UserProfileDetail userprofiledetail = db.UserProfileDetails.FirstOrDefault(m => m.Users == user2.Users);
                if (userprofiledetail.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofiledetail.ProfilePicture;
                }
                else
                {
                    
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
                userprofiledetail.User = user2;
                ViewBag.Name = userprofiledetail.ProfilePicture;
                string[] MobileNumber = userprofiledetail.PhoneNumber.Split(' ');
                ViewBag.CountryCode = MobileNumber[0];
                userprofiledetail.DOB = userprofiledetail.DOB;
                userprofiledetail.Number = MobileNumber[1];
                ViewBag.Country = userprofiledetail.Country;
                ViewBag.Gender = userprofiledetail.Gender;
                return View(userprofiledetail);
            }
            else
            {
                UserProfileDetail userProfileDetail = new UserProfileDetail();
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                userProfileDetail.User = user2;
                return View(userProfileDetail);
            }

        }

        //Post User Profile
        [HttpPost]
        public ActionResult UserProfile(UserProfileDetail UserProfile)
        {
            ViewBag.Category = db.ManageCTCs;
            User user2 = Session["User"] as User;
            if (user2.IsDetailSubmitted == true)
            {
                if (UserProfile != null)
                {
                    UserProfileDetail UserProfile2 = db.UserProfileDetails.FirstOrDefault(m => m.Users == user2.Users);
                    if (UserProfile.ProfilePic != null)
                    {
                        if (UserProfile.ProfilePic.ContentLength < (5 * 1024 * 1024))
                        {
                            var ProfilePicExt = Path.GetExtension(UserProfile.ProfilePic.FileName);
                            var ProfilePicName = "User" + user2.Users + ProfilePicExt;
                            var ProfilePicPath = Path.Combine(Server.MapPath("~/Upload/UserProfilePicture"), ProfilePicName);
                            UserProfile.ProfilePic.SaveAs(ProfilePicPath);
                            UserProfile2.ProfilePicture = ProfilePicName;
                        }
                        else
                        {
                            ViewBag.Img = "FIle must be less than 5 MB";
                            return View(UserProfile);
                        }

                    }

                    UserProfile2.ModifiedDate = DateTime.Now.Date;
                    if (UserProfile.Number != null)
                    {
                        UserProfile2.PhoneNumber = "+" + UserProfile.CountryCode + " " + UserProfile.Number;
                    }

                    User user = db.Users.FirstOrDefault(m => m.Users == user2.Users);
                    user.FirstName = UserProfile.User.FirstName;
                    user.LastName = UserProfile.User.LastName;
                    user.ConfirmPasswords = user.Passwords;
                    UserProfile2.DOB = UserProfile.DOB;
                    UserProfile2.College = UserProfile.College;
                    UserProfile2.University = UserProfile.University;
                    UserProfile2.Address1 = UserProfile.Address1;
                    UserProfile2.Address2 = UserProfile.Address2;
                    UserProfile2.City = UserProfile.City;
                    UserProfile2.States = UserProfile.States;
                    UserProfile2.ZipCode = UserProfile.ZipCode;
                    UserProfile2.IsActive = true;
                    if (UserProfile.Country == null)
                    {
                        ViewBag.CountryMessage = "This is required field";
                        return View(UserProfile);
                    }
                    UserProfile2.Country = UserProfile.Country;
                    UserProfile2.Gender = UserProfile.Gender;
                    UserProfile2.User = user;
                    UserProfile2.ProfilePic = null;
                    db.SaveChanges();
                    return RedirectToAction("Home", "Home");
                }
                else
                {
                    ViewBag.Message = "User Profile is Null";
                    return View();
                }



            }
            else
            {
                if (UserProfile != null)
                {

                    if (UserProfile.ProfilePic.ContentLength < (5 * 1024 * 1024))
                    {
                        var ProfilePicExt = Path.GetExtension(UserProfile.ProfilePic.FileName);

                        var ProfilePicName = "User" + user2.Users + ProfilePicExt;
                        // store the file inside ~/App_Data/uploads folder
                        var ProfilePicPath = Path.Combine(Server.MapPath("~/Upload/UserProfilePicture/"), ProfilePicName);
                        UserProfile.ProfilePic.SaveAs(ProfilePicPath);
                        UserProfile.ProfilePicture = ProfilePicName;

                        if (UserProfile.Number != null)
                        {
                            UserProfile.PhoneNumber = "+" + UserProfile.CountryCode + " " + UserProfile.Number;
                        }
                        User user = db.Users.FirstOrDefault(m => m.Users == user2.Users);
                        user.IsDetailSubmitted = true;
                        user.FirstName = UserProfile.User.FirstName;
                        user.LastName = UserProfile.User.LastName;
                        user.ConfirmPasswords = user.Passwords;
                        UserProfile.User = user;
                        UserProfile.IsActive = true;
                        UserProfile.ProfilePic = null;
                        UserProfile.ModifiedDate = DateTime.Now;
                        UserProfile.User.ModifiedDate = DateTime.Now.Date;
                        db.UserProfileDetails.Add(UserProfile);

                        db.SaveChanges();



                        return RedirectToAction("Home", "Home");

                    }
                    else
                    {
                        ViewBag.Img = "Profile pic size must be less than 5 MB";
                        return View(UserProfile);
                    }


                }
                else
                {
                    return View();
                }
            }

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

                MailMessage mm = new MailMessage("rajp30398@gmail.com", user.EmailID);
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
            MyRoute = "ContactUs";
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
                return View();
            }

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
            MyRoute = "FAQ";
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
                return View();
            }

            return View();
        }

        //Get Add Notes
        public ActionResult AddNotes()
        {
            ViewBag.Category = db.ManageCTCs;
            User user = Session["User"] as User;

            var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
            if (userprofile.ProfilePicture != null)
            {

                ViewBag.ProfilePic = userprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            int id = Convert.ToInt32(Session["EditId"]);
            if (id != 0)
            {
                NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == id);
                ViewBag.Edit = "true";
                return View(note);
            }
            else
            {
                return View();
            }

        }
        //Get Add Notes
        [HttpPost]
        public ActionResult AddNotes(HttpPostedFileBase DisplayPicture, HttpPostedFileBase NotePDF, HttpPostedFileBase Preview, NoteDetail note, string save, string publish)
        {
            ViewBag.Category = db.ManageCTCs;
            User user = Session["User"] as User;
            if (note.Category.Equals("Select Your category"))
            {

                ViewBag.CategoryError = "Please select category";
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
                        var DisplayPicturePath = Path.Combine(Server.MapPath("~/Upload/BookPicture/"), DisplayPictureName);
                        DisplayPicture.SaveAs(DisplayPicturePath);
                        note.BookPicture = DisplayPictureName;

                        var NotePDFExt = Path.GetExtension(NotePDF.FileName);
                        var NotePDFName = DateTime.Now.ToString("G").Replace(" ", "f").Replace("-", "s").Replace(":", "a") + NotePDFExt;
                        // store the file inside ~/App_Data/uploads folder
                        var NotePDFpath = Path.Combine(Server.MapPath("~/Upload/NoteAttchment/"), NotePDFName);
                        NotePDF.SaveAs(NotePDFpath);
                        note.NoteAttachment = NotePDFName;
                        note.CreatedDate = DateTime.Now;


                        if(note.SellPrice != 0)
                        {
                            if(Preview != null )
                            {
                                var PreviewPDFExt = Path.GetExtension(Preview.FileName);
                                var PreviewPDFName = DateTime.Now.ToString("G").Replace(" ", "f").Replace("-", "s").Replace(":", "a") + PreviewPDFExt;
                                // store the file inside ~/App_Data/uploads folder
                                var PreviewPDFpath = Path.Combine(Server.MapPath("~/Upload/NotePreview/"), PreviewPDFName);
                                NotePDF.SaveAs(PreviewPDFpath);
                                note.NotePreview = PreviewPDFName;
                            }
                            else
                            {
                                ViewBag.Preview = "Preview is mendatory for paid notes";
                                return View(note);
                            }
                        }
                        

                        note.NoteSize = Convert.ToInt32((NotePDF.ContentLength) / (1024 * 1024));
                        note.Users = user.Users;
                        note.IsActive = true;
                        note.Preview = null;
                        note.NotePDF = null;
                        note.DisplayPicture = null;
                        note.CreatedDate = DateTime.Now;

                        if (!string.IsNullOrEmpty(save))
                        {
                            int id = Convert.ToInt32(Session["EditId"]);
                            if (id != 0)
                            {
                                NoteDetail EditNote = db.NoteDetails.FirstOrDefault(m => m.Note == id);
                                db.SaveChanges();
                                if (System.IO.File.Exists("~/Upload/BookPicture/" + EditNote.BookPicture))
                                {
                                    System.IO.File.Delete("~/Upload/BookPicture/" + EditNote.BookPicture);

                                }
                                if (System.IO.File.Exists("~/Upload/NoteAttchment/" + EditNote.NoteAttachment))
                                {
                                    System.IO.File.Delete("~/Upload/NoteAttchment/" + EditNote.NoteAttachment);

                                }
                                if (System.IO.File.Exists("~/Upload/NotePreview/" + EditNote.Preview))
                                {
                                    System.IO.File.Delete("~/Upload/NotePreview/" + EditNote.Preview);

                                }

                                return RedirectToAction("Dashboard", "Home");
                            }
                            else
                            {
                                note.NoteStatus = 1;
                                db.NoteDetails.Add(note);
                                db.SaveChanges();
                                return RedirectToAction("Dashboard", "Home");
                            }

                        }
                        if (!string.IsNullOrEmpty(publish))
                        {
                            int id = Convert.ToInt32(Session["EditId"]);
                            if (id != 0)
                            {
                                NoteDetail EditNote = db.NoteDetails.FirstOrDefault(m => m.Note == id);
                                EditNote.BookPicture = note.BookPicture;
                                EditNote.NoteAttachment = note.NoteAttachment;
                                EditNote.NotePreview = note.NotePreview;
                                EditNote.IsActive = true;
                                EditNote.ModifiedDate = DateTime.Now;
                                EditNote.NoteStatus = 2;
                                EditNote.Title = note.Title;
                                EditNote.Category = note.Category;
                                EditNote.NoteType = note.NoteType;
                                EditNote.NumberOfPages = note.NumberOfPages;
                                EditNote.NotesDescription = note.NotesDescription;
                                EditNote.InstitutionName = note.InstitutionName;
                                EditNote.Country = note.Country;
                                EditNote.Course = note.Course;
                                EditNote.CourseCode = note.CourseCode;
                                EditNote.Professor = note.Professor;
                                EditNote.SellPrice = note.SellPrice;
                                EditNote.NoteSize = note.NoteSize;
                                EditNote.PublishedDate = note.PublishedDate;
                                EditNote.Remark = note.Remark;
                                
                                EditNote.IsActive = note.IsActive;

                                db.SaveChanges();
                                if (System.IO.File.Exists("~/Upload/Img/" + EditNote.BookPicture))
                                {
                                    System.IO.File.Delete("~/Upload/Img/" + EditNote.BookPicture);

                                }
                                if (System.IO.File.Exists("~/Upload/NoteAttchment/" + EditNote.NoteAttachment))
                                {
                                    System.IO.File.Delete("~/Upload/NoteAttchment/" + EditNote.NoteAttachment);

                                }
                                if (System.IO.File.Exists("~/Upload/NotePreview/" + EditNote.Preview))
                                {
                                    System.IO.File.Delete("~/Upload/NotePreview/" + EditNote.Preview);

                                }
                                MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                                mm.Subject = user.FirstName + " " + user.LastName + " sent his note for reviews";
                                mm.Body = "Hello Admins,\n\nWe want to inform you that, "+user.FirstName + " " + user.LastName + " sent his note\n" + EditNote.Title + " for review. Please look at the notes and take required actions.\n\nRegards,\nNotes Marketplace";

                                SmtpClient smtp = new SmtpClient();
                                smtp.Host = "smtp.gmail.com";
                                smtp.Port = 587;
                                smtp.UseDefaultCredentials = false;

                                NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                                smtp.EnableSsl = true;
                                smtp.Credentials = nc;
                                smtp.Send(mm);

                                return RedirectToAction("Dashboard", "Home");
                            }
                            else
                            {
                                note.NoteStatus = 2;
                                db.NoteDetails.Add(note);
                                db.SaveChanges();
                                MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                                mm.Subject = user.FirstName + " " + user.LastName + " sent his note for reviews";
                                mm.Body = "Hello Admins,\n\nWe want to inform you that, " + user.FirstName + " " + user.LastName + " sent his note\n" + note.Title + " for review. Please look at the notes and take required actions.\n\nRegards,\nNotes Marketplace";

                                SmtpClient smtp = new SmtpClient();
                                smtp.Host = "smtp.gmail.com";
                                smtp.Port = 587;
                                smtp.UseDefaultCredentials = false;

                                NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                                smtp.EnableSsl = true;
                                smtp.Credentials = nc;
                                smtp.Send(mm);
                                return RedirectToAction("Dashboard", "Home");
                            }

                        }
                        db.SaveChanges();

                    }
                    else
                    {
                        ViewBag.Message = "File Greater than 5MB";
                        ViewBag.Edit = "true";
                    }


                }
                else
                {
                    ViewBag.Message = "You have not specified a file.";
                    ViewBag.Edit = "true";
                }

                int Id = Convert.ToInt32(Session["EditId"]);
                if(Id!=0)
                {
                    ViewBag.Edit = "true";

                }



                return View();
            }
        }



        //Get Dashboard
        public ActionResult Dashboard(MyDashboard dashboard)
        {
            MyRoute = "Dashboard";
            User user = Session["User"] as User;

            var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
            if (userprofile.ProfilePicture != null)
            {

                ViewBag.ProfilePic = userprofile.ProfilePicture;
            }
            else
            {
                
            }
            MyDashboard myDashboard = new MyDashboard();
            List<NoteDetail> progresslist = db.NoteDetails.Where(m => m.IsActive && m.Users == user.Users).OrderByDescending(m => m.CreatedDate).ToList();
            progresslist = progresslist.Where(m => m.NoteStatus == 1 || m.NoteStatus == 2).ToList();
            if (!String.IsNullOrEmpty(dashboard.progresssearch))
            {
                progresslist = progresslist.Where(m => m.Title.ToLower().Contains(dashboard.progresssearch.ToLower()) || m.Category.ToLower().Contains(dashboard.progresssearch.ToLower())).ToList();
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




            List<NoteDetail> publishlist = db.NoteDetails.Where(m => m.NoteStatus == 4 && m.IsActive && m.Users == user.Users).OrderByDescending(m => m.PublishedDate).ToList();
            if (!String.IsNullOrEmpty(dashboard.publishsearch))
            {
                publishlist = publishlist.Where(m => m.Title.ToLower().Contains(dashboard.publishsearch.ToLower()) || m.Category.ToLower().Contains(dashboard.publishsearch.ToLower())).ToList();
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
            if (publishlist.Count == 0)
            {
                ViewBag.Publish = "true";
            }
            if (progresslist.Count == 0)
            {
                ViewBag.Progress = "true";
            }
            myDashboard.progress = progresslist.ToPagedList(dashboard.progressindex ?? 1, 5);
            myDashboard.published = publishlist.ToPagedList(dashboard.publishindex ?? 1, 5);

            myDashboard.BuyerRequest = user.DownloadedNotes1.Where(m=>m.IsApproved==false).Count();
            myDashboard.MyDownload = user.DownloadedNotes.Where(m=>m.IsApproved).Count();
            myDashboard.TotalEarning = user.DownloadedNotes1.Where(m=>m.IsApproved).Select(x=>x.SellPrice).Sum();
            myDashboard.NumberOfSold = user.DownloadedNotes1.Where(m=>m.IsApproved).Count();
            myDashboard.MyRejected =  user.NoteDetails.Where(m=>m.NoteStatus==5 || m.NoteStatus == 6).Count();
            return View(myDashboard);
        }

        //Get Buyer Request
        public ActionResult BuyerRequests(BuyerRequest buyerrequest)
        {

            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
            }
            BuyerRequest MyRequest = new BuyerRequest();
            List<DownloadedNote> buyerrequestlist = db.DownloadedNotes.Where(m => m.Users == user.Users && m.IsApproved == false && m.IsActive == true).OrderByDescending(m => m.CreatedDate).ToList();

            if (!String.IsNullOrEmpty(buyerrequest.buyerrequestsearch))
            {
                buyerrequestlist = buyerrequestlist.Where(m => m.NoteTitle.ToLower().Contains(buyerrequest.buyerrequestsearch.ToLower()) || m.Category.ToLower().Contains(buyerrequest.buyerrequestsearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(buyerrequest.buyerrequestTitleSort))
            {
                if (buyerrequest.buyerrequestTitleSort.Equals("title"))
                {
                    buyerrequestlist = buyerrequestlist.OrderBy(m => m.NoteTitle).ToList();
                }
            }
            if (!String.IsNullOrEmpty(buyerrequest.buyerrequestCategorySort))
            {
                if (buyerrequest.buyerrequestCategorySort.Equals("category"))
                {
                    buyerrequestlist = buyerrequestlist.OrderBy(m => m.Category).ToList();
                }
            }
            MyRequest.buyerrequest = buyerrequestlist.ToPagedList(buyerrequest.buyerrequestindex ?? 1, 9);
            if (buyerrequestlist.Count == 0)
            {
                ViewBag.BuyerRequest = "true";
            }
            return View(MyRequest);
        }

        //Get My Download
        public ActionResult MyDownloads(Downloads download)
        {

            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
            }
            Downloads MyDownload = new Downloads();
            List<DownloadedNote> downloadlist = db.DownloadedNotes.Where(m => m.Buyer == user.Users && m.IsApproved == true && m.IsActive == true).OrderByDescending(m => m.CreatedDate).ToList();

            if (!String.IsNullOrEmpty(download.downloadsearch))
            {
                downloadlist = downloadlist.Where(m => m.NoteTitle.ToLower().Contains(download.downloadsearch.ToLower()) || m.Category.ToLower().Contains(download.downloadsearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(download.downloadTitleSort))
            {
                if (download.downloadTitleSort.Equals("title"))
                {
                    downloadlist = downloadlist.OrderBy(m => m.NoteTitle).ToList();
                }
            }
            if (!String.IsNullOrEmpty(download.downloadCategorySort))
            {
                if (download.downloadCategorySort.Equals("category"))
                {
                    downloadlist = downloadlist.OrderBy(m => m.Category).ToList();
                }
            }
            MyDownload.download = downloadlist.ToPagedList(download.downloadindex ?? 1, 9);
            if (downloadlist.Count == 0)
            {
                ViewBag.Downloads = "true";
            }
            return View(MyDownload);
        }
        // Get Home
        public ActionResult Home()
        {
            MyRoute = "Home";
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
                return View();
            }
            return View();
        }

        //Post Home 
        [HttpPost]
        public ActionResult Home(string Sell, string Download)
        {
            User user = Session["User"] as User;
            if (!string.IsNullOrEmpty(Sell))
            {
                if (user != null)
                {
                    return RedirectToAction("Dashboard", "Home");
                }
                else
                {
                    return RedirectToAction("Login", "Home");
                }
            }
            if (!string.IsNullOrEmpty(Download))
            {
                if (user != null)
                {
                    return RedirectToAction("Search", "Home");
                }
                else
                {
                    return RedirectToAction("Login", "Home");
                }
            }

            return View();
        }
        // Get Search Note
        public ActionResult Search(Search MySearch, string university, string types, string category, string course, string country, string rating)
        {
            MyRoute = "Search";
            ViewBag.BookImage = "~/Content/img/defaultBookImage.png";
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";
                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";

            }


            List<NoteDetail> MyNote = db.NoteDetails.Where(m => m.NoteStatus == 4 && m.IsActive).OrderByDescending(m => m.CreatedDate).ToList();
            MySearch.Category = MyNote.Select(m => m.Category).Distinct().ToList();
            MySearch.Type = MyNote.Select(m => m.NoteType).Distinct().ToList();
            MySearch.University = MyNote.Select(m => m.InstitutionName).Distinct().ToList();
            MySearch.Course = MyNote.Select(m => m.Course).Distinct().ToList();
            MySearch.Country = MyNote.Select(m => m.Country).Distinct().ToList();

            if (!String.IsNullOrEmpty(MySearch.notesearch))
            {
                MyNote = MyNote.Where(m => m.Title.ToLower().Contains(MySearch.notesearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(university))
            {
                MyNote = MyNote.Where(m => m.InstitutionName != null).ToList();
                MyNote = MyNote.Where(m => m.InstitutionName.ToLower().Equals(university.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(course))
            {
                MyNote = MyNote.Where(m => m.Course != null).ToList();
                MyNote = MyNote.Where(m => m.Course.ToLower().Equals(course.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(types))
            {
                MyNote = MyNote.Where(m => m.NoteType != null).ToList();
                MyNote = MyNote.Where(m => m.NoteType.ToLower().Equals(types.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(country))
            {
                MyNote = MyNote.Where(m => m.Country != null).ToList();
                MyNote = MyNote.Where(m => m.Country.ToLower().Equals(country.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(category))
            {
                MyNote = MyNote.Where(m => m.Category != null).ToList();
                MyNote = MyNote.Where(m => m.Category.ToLower().Equals(category.ToLower())).ToList();
            }
            List<NoteRating> noteRatings = new List<NoteRating>();
            foreach(NoteDetail note in MyNote)
            {
                NoteRating noteRating = new NoteRating();
                noteRating.note = note;
                noteRating.review = db.Feedbacks.Where(m=>m.Note==note.Note && m.IsActive).Count();
                noteRating.inappropriat = db.SpamReports.Where(m => m.Note == note.Note).Count();
                noteRating.rating = 0;
                var temp = db.Feedbacks.Where(m => m.Note== note.Note);
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
                       noteRating.rating = sum / count;
                    }
                }
                noteRatings.Add(noteRating);
            }
            if (!String.IsNullOrEmpty(rating))
            {
                var temp = noteRatings.Where(m => m.rating == Convert.ToInt32(rating));
                if(temp!=null)
                { 
                noteRatings = temp.ToList();
                }
            }
            MySearch.count = noteRatings.Count;
            MySearch.search = noteRatings.ToPagedList(MySearch.searchindex ?? 1, 9);
            
            
           
            return View(MySearch);
        }
        // Get Note Detail
        public ActionResult NoteDetails(NoteDetails note, string sellprice)
        {
            MyRoute = "NoteDetails";
            ViewBag.BookImage = "~/Content/img/defaultBookImage.png";
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";

                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
            }
            int BookId = Convert.ToInt32(Session["BookID"]);

            NoteDetail notedetail = db.NoteDetails.FirstOrDefault(m => m.Note == BookId && m.IsActive);
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
            List<Feedback> Feedback = db.Feedbacks.Where(m=>m.Note == BookId).ToList();
            foreach(Feedback fb in Feedback)
            {
                UserFeedback users = new UserFeedback();
                User user1 = db.Users.FirstOrDefault(m=>m.Users == fb.Users && m.IsActive);
                users.UserName = user1.FirstName+" "+user1.LastName;
                UserProfileDetail up = db.UserProfileDetails.FirstOrDefault(m=>m.Users == fb.Users && m.IsActive);
                users.UserImage = up.ProfilePicture;
                users.Rating = fb.Review;
                users.Comment = fb.Comments;
                userFeedbacks.Add(users);
            }
            note.feedback = userFeedbacks;
            if (user != null)
            {
                bool IsEntry = db.DownloadedNotes.Any(m => m.Note == notedetail.Note && m.Buyer == user.Users);
                bool IsPayment = db.DownloadedNotes.Any(m => m.Note == notedetail.Note && m.Buyer == user.Users && m.IsApproved == true);
                if (IsEntry)
                {
                    if(IsPayment)
                    {
                        ViewBag.UserSelf = "true";
                    }
                    else
                    { 
                        ViewBag.Button = "true";
                    }
                }

                else if (user.Users == notedetail.Users)
                {
                    ViewBag.UserSelf = "true";
                }
                else
                {

                }


            }
           
            if (sellprice != null)
            {


                if (user == null)
                {
                    return RedirectToAction("Login", "Home");

                }

                if (user.Users == notedetail.Users)
                {
                    string path = "C:/Project/NotesMarketplace/Upload/NoteAttchment/" + notedetail.NoteAttachment;
                    return RedirectToAction("DownloadFile", "Home", new { filename = path });
                }
                else
                {
                    if (sellprice == "0")
                    {

                        bool IsEntry = db.DownloadedNotes.Any(m => m.Note == notedetail.Note && m.Buyer == user.Users);
                        if (IsEntry)
                        {
                            string path = "C:/Project/NotesMarketplace/Upload/NoteAttchment/" + notedetail.NoteAttachment;
                            return RedirectToAction("DownloadFile", "Home", new { filename = path });
                        }
                        else
                        {
                            DownloadedNote downloadnote = new DownloadedNote();
                            downloadnote.Note = notedetail.Note;
                            downloadnote.Users = notedetail.Users;
                            downloadnote.Buyer = user.Users;
                            downloadnote.IsApproved = true;
                            downloadnote.CreatedDate = DateTime.Now;
                            downloadnote.IsActive = true;
                            downloadnote.NoteTitle = notedetail.Title;
                            downloadnote.Attachment = notedetail.NoteAttachment;
                            downloadnote.SellPrice = notedetail.SellPrice;
                            downloadnote.Category = notedetail.Category;
                            downloadnote.BuyerEmail = user.EmailID;
                            downloadnote.AttachmentSize = notedetail.NoteSize;
                            UserProfileDetail userProfile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                            downloadnote.BuyerMobile = userProfile.PhoneNumber;
                            db.DownloadedNotes.Add(downloadnote);
                            db.SaveChanges();
                            string path = "C:/Project/NotesMarketplace/Upload/NoteAttchment/" + notedetail.NoteAttachment;
                            return RedirectToAction("DownloadFile", "Home", new { filename = path });
                        }

                    }
                    else
                    {
                        bool IsEntry = db.DownloadedNotes.Any(m => m.Note == notedetail.Note && m.Buyer == user.Users);
                        bool IsPayment = db.DownloadedNotes.Any(m => m.Note == notedetail.Note && m.Buyer == user.Users && m.IsApproved == true);
                        if (IsEntry)
                        {
                            if (IsPayment)
                            {
                                string path = "C:/Project/NotesMarketplace/Upload/NoteAttchment/" + notedetail.NoteAttachment;
                                return RedirectToAction("DownloadFile", "Home", new { filename = path });
                            }
                            else
                            {
                                ViewBag.Button = "true";
                                return View(note);

                            }

                        }
                        else
                        {
                            DownloadedNote downloadnote = new DownloadedNote();
                            downloadnote.Note = notedetail.Note;
                            downloadnote.Users = notedetail.Users;
                            downloadnote.Buyer = user.Users;
                            downloadnote.CreatedDate = DateTime.Now;
                            downloadnote.IsActive = true;
                            downloadnote.NoteTitle = notedetail.Title;
                            downloadnote.Attachment = notedetail.NoteAttachment;
                            downloadnote.SellPrice = notedetail.SellPrice;
                            downloadnote.Category = notedetail.Category;
                            downloadnote.BuyerEmail = user.EmailID;
                            downloadnote.AttachmentSize = notedetail.NoteSize;
                            UserProfileDetail userProfile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                            downloadnote.BuyerMobile = userProfile.PhoneNumber;
                            db.DownloadedNotes.Add(downloadnote);
                            db.SaveChanges();
                            ViewBag.IsModel = "true";
                            ViewBag.Button = "true";
                            ViewBag.Buyer = user.FirstName + user.LastName;
                            User user1 = db.Users.FirstOrDefault(m => m.Users == notedetail.Users);
                            ViewBag.seller = user1.FirstName + user1.LastName;

                            MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                            mm.Subject = user.FirstName + " " + user.LastName + " wants to purchase your notes";
                            mm.Body = "Hello " + user1.FirstName + " " + user1.LastName + ",\n\nWe would like to inform you that, " + user.FirstName + " " + user.LastName + " wants to purchase your notes. Please see Buyer Requests tab and allow download access to Buyer if you have received the payment from him.\n\nRegards,\nNotes Marketplace";

                            SmtpClient smtp = new SmtpClient();
                            smtp.Host = "smtp.gmail.com";
                            smtp.Port = 587;
                            smtp.UseDefaultCredentials = false;

                            NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                            smtp.EnableSsl = true;
                            smtp.Credentials = nc;
                            smtp.Send(mm);
                            return View(note);
                        }
                    }
                }
            }
            return View(note);
        }

        //Get Change Password 
        public ActionResult ChangePassword()
        {
            User user = Session["User"] as User;
            if (user != null)
            {
                ViewBag.Header = "true";

                var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
                if (userprofile.ProfilePicture != null)
                {

                    ViewBag.ProfilePic = userprofile.ProfilePicture;
                }
                else
                {
                    ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
                }
            }
            else
            {
                ViewBag.Header = "false";
            }
            return View();
        }
        //Post Change Password 
        [HttpPost]
        public ActionResult ChangePassword(ChangePassword cp)
        {
            User user = Session["User"] as User;
            if (user.Passwords == cp.OldPasswords)
            {
                User user2 = db.Users.FirstOrDefault(m => m.Passwords == cp.OldPasswords);
                user2.Passwords = cp.NewPasswords;
                user2.ConfirmPasswords = user2.Passwords;
                db.SaveChanges();
                return RedirectToAction("Login", "Home");
            }
            else
            {

                ViewBag.Message = "Old password is incorrect";
                return View(cp);
            }

        }
        
        //Get Rejected Notes
        public ActionResult RejectedNotes(Rejected rejected)
        {
            MyRoute = "Dashboard";
            User user = Session["User"] as User;

            var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
            if (userprofile.ProfilePicture != null)
            {

                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = "~/Content/img/DefaultUserImage.png";
            }
            Rejected MyRejected = new Rejected();
            List<NoteDetail> rejectedlist = db.NoteDetails.Where(m => m.NoteStatus == 5 && m.IsActive && m.Users == user.Users).OrderByDescending(m => m.CreatedDate).ToList();

            if (!String.IsNullOrEmpty(rejected.rejectedsearch))
            {
                rejectedlist = rejectedlist.Where(m => m.Title.ToLower().Contains(rejected.rejectedsearch.ToLower()) || m.Category.ToLower().Contains(rejected.rejectedsearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(rejected.rejectedTitleSort))
            {
                if (rejected.rejectedTitleSort.Equals("title"))
                {
                    rejectedlist = rejectedlist.OrderBy(m => m.Title).ToList();
                }
            }
            if (!String.IsNullOrEmpty(rejected.rejectedCategorySort))
            {
                if (rejected.rejectedCategorySort.Equals("category"))
                {
                    rejectedlist = rejectedlist.OrderBy(m => m.Category).ToList();
                }
            }
            MyRejected.rejected = rejectedlist.ToPagedList(rejected.rejectedindex ?? 1, 10);
            if (rejectedlist.Count == 0)
            {
                ViewBag.Rejected = "true";
            }
            return View(MyRejected);

        }
        //Get Sold Notes
        public ActionResult SoldNotes(Sold sold)
        {
            MyRoute = "Dashboard";
            User user = Session["User"] as User;

            var userprofile = db.UserProfileDetails.FirstOrDefault(m => m.Users == user.Users);
            if (userprofile.ProfilePicture != null)
            {

                ViewBag.ProfilePic = userprofile.ProfilePicture;
            }
            else
            {
                ViewBag.ProfilePic = db.SystemConfigurations.FirstOrDefault(m => m.ConfigId == 1).DefaultProfilePicture;
            }
            Sold MySold = new Sold();
            List<DownloadedNote> soldlist = db.DownloadedNotes.Where(m => m.IsActive && m.Users == user.Users && m.IsApproved == true).OrderByDescending(m => m.ModifiedDate).ToList();

            if (!String.IsNullOrEmpty(sold.soldsearch))
            {
                soldlist = soldlist.Where(m => m.NoteTitle.ToLower().Contains(sold.soldsearch.ToLower()) || m.Category.ToLower().Contains(sold.soldsearch.ToLower())).ToList();
            }
            if (!String.IsNullOrEmpty(sold.soldTitleSort))
            {
                if (sold.soldTitleSort.Equals("title"))
                {
                    soldlist = soldlist.OrderBy(m => m.NoteTitle).ToList();
                }
            }
            if (!String.IsNullOrEmpty(sold.soldCategorySort))
            {
                if (sold.soldCategorySort.Equals("category"))
                {
                    soldlist = soldlist.OrderBy(m => m.Category).ToList();
                }
            }
            MySold.sold = soldlist.ToPagedList(sold.soldindex ?? 1, 10);
            if (soldlist.Count == 0)
            {
                ViewBag.sold = "true";
            }
            return View(MySold);

        }

        public ActionResult Logout()
        {
            Session["User"] = null;
            return RedirectToAction("Home", "Home");
        }
        public ActionResult BookID(int id)
        {
            Session["BookID"] = id;
            return RedirectToAction("NoteDetails", "Home");
        }
        public FileResult DownloadFile(string fileName)
        {

            byte[] bytes = System.IO.File.ReadAllBytes(fileName);
            return File(bytes, "application/octet-stream", fileName);
        }

        public ActionResult EditNotes(int id)
        {
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == id);
            Session["EditId"] = note.Note;
            return RedirectToAction("AddNotes", "Home", new { NoteDetail = note });
        }
        public ActionResult DeleteNotes(int id)
        {
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == id);
            db.NoteDetails.Remove(note);
            db.SaveChanges();
            return RedirectToAction("Dashboard", "Home");
        }
        public ActionResult ViewNotes(int id)
        {
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == id);
            Session["BookID"] = id;
            return RedirectToAction("NoteDetails", "Home", new { NoteDetail = note });
        }

        public ActionResult AllowDownload(int BookID, int BuyerID)
        {
            User user = Session["User"] as User;
            User buyer = db.Users.FirstOrDefault(m=>m.Users==BuyerID && m.IsActive);
            DownloadedNote note = db.DownloadedNotes.FirstOrDefault(m => m.Note == BookID && m.Buyer == BuyerID && m.IsApproved == false);
            note.IsApproved = true;

            db.SaveChanges();
            MailMessage mm = new MailMessage("rajp30398@gmail.com", buyer.EmailID);
            mm.Subject = user.FirstName + " " + user.LastName + " Allows you to download a note";
            mm.Body = "Hello "+buyer.FirstName +" "+buyer.LastName+ ",\n\nWe would like to inform you that, "+ user.FirstName + " " + user.LastName + " Allows you to download a note.\nPlease login and see My Download tabs to download particular note.\n\nRegards,\nNotes Marketplace";

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.UseDefaultCredentials = false;

            NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
            smtp.EnableSsl = true;
            smtp.Credentials = nc;
            smtp.Send(mm);

            return RedirectToAction("BuyerRequests", "Home");
        }
        public ActionResult CloneNotes(int BookID)
        {
            User user = Session["User"] as User;
            NoteDetail note = db.NoteDetails.FirstOrDefault(m => m.Note == BookID && m.Users == user.Users && m.IsActive == true);
            NoteDetail EditNote = new NoteDetail();
            EditNote.Users = user.Users;
            EditNote.BookPicture = note.BookPicture;
            EditNote.NoteAttachment = note.NoteAttachment;
            EditNote.NotePreview = note.NotePreview;
            EditNote.IsActive = true;
            EditNote.CreatedDate = DateTime.Now;
            EditNote.NoteStatus = 1;
            EditNote.Title = note.Title;
            EditNote.Category = note.Category;
            EditNote.NoteType = note.NoteType;
            EditNote.NumberOfPages = note.NumberOfPages;
            EditNote.NotesDescription = note.NotesDescription;
            EditNote.InstitutionName = note.InstitutionName;
            EditNote.Country = note.Country;
            EditNote.Course = note.Course;
            EditNote.CourseCode = note.CourseCode;
            EditNote.Professor = note.Professor;
            EditNote.SellPrice = note.SellPrice;
            EditNote.NoteSize = note.NoteSize;
            EditNote.PublishedDate = note.PublishedDate;
            EditNote.Remark = note.Remark;
            EditNote.IsActive = note.IsActive;
            db.NoteDetails.Add(EditNote);
            note.IsActive = false;
            db.SaveChanges();
            return RedirectToAction("RejectedNotes", "Home");
        }
        public FileResult DownloadNote(int BookID)
        {
            NoteDetail note = db.NoteDetails.FirstOrDefault(m=>m.Note == BookID && m.IsActive==true);
            string path = "C:/Project/NotesMarketplace/Upload/Pdf/" + note.NoteAttachment;
            byte[] bytes = System.IO.File.ReadAllBytes(path);
            return File(bytes, "application/octet-stream", path);

        }
        public ActionResult Feedback(string bookId1, string rate, string Comment)
        {
            User user = Session["User"] as User;
            int id = Convert.ToInt32(bookId1);
            Feedback feedback = db.Feedbacks.FirstOrDefault(m=>m.Note == id && m.Users == user.Users && m.IsActive==true);
            if(feedback!=null)
            {
                feedback.Note = Convert.ToInt32(bookId1);
                feedback.Users = user.Users;
                if (rate == null)
                {
                    
                }
                {
                    feedback.Review = Convert.ToInt32(rate);
                }
                feedback.Comments = Comment;
                feedback.ModifiedDate = DateTime.Now;
                feedback.IsActive = true;

            }
            else
            { 
                Feedback fb = new Feedback();
                fb.Note = Convert.ToInt32(bookId1);
                fb.Users = user.Users;
                if(rate == null)
                {
                    fb.Review = 0;
                }
                {
                    fb.Review = Convert.ToInt32(rate);
                }
                fb.Comments = Comment;
                fb.CreatedDate = DateTime.Now;
                fb.IsActive = true;
                db.Feedbacks.Add(fb);
            
            }
            db.SaveChanges();
            return RedirectToAction("MyDownloads","Home");
        }
        public ActionResult Spam(string bookId2, string Comment)
        {
            if(Comment!=null)
            {
                User user = Session["User"] as User;
                int id = Convert.ToInt32(bookId2);
                SpamReport SpamReport = db.SpamReports.FirstOrDefault(m => m.Note == id  && m.Users == user.Users);
                if (SpamReport != null)
                {
                    SpamReport.ModifiedDate = DateTime.Now;
                    db.SaveChanges();
                    return RedirectToAction("MyDownloads", "Home");
                }
                else
                {
                    SpamReport spam = new SpamReport();
                    spam.Note = Convert.ToInt32(bookId2);
                    spam.Users = user.Users;
                    spam.Remark = Comment;
                    spam.CreatedDate = DateTime.Now;
                    NoteDetail note = db.NoteDetails.FirstOrDefault(m=>m.Note== id && m.IsActive);
                    User seller = db.Users.FirstOrDefault(m=>m.Users==note.Users && m.IsActive);
                    db.SpamReports.Add(spam); MailMessage mm = new MailMessage("rajp30398@gmail.com", "rajp30398@gmail.com");
                    mm.Subject = user.FirstName +" "+user.LastName+" Reported an issue for "+note.Title;
                    mm.Body = "Hello Admins,\n\nWe want to inform you that, "+user.FirstName+" "+user.LastName+" Reported an issue for "+seller.FirstName+" "+seller.LastName+"’s Note with title "+note.Title+". Please look at the notes and take required actions.\n\nRegards,\nNotes Marketplace";

                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "smtp.gmail.com";
                    smtp.Port = 587;
                    smtp.UseDefaultCredentials = false;

                    NetworkCredential nc = new NetworkCredential("rajp30398@gmail.com", "Apple0198");
                    smtp.EnableSsl = true;
                    smtp.Credentials = nc;
                    smtp.Send(mm);


                    db.SaveChanges();

                }

                return RedirectToAction("MyDownloads", "Home");
            }
            else
            {
                return RedirectToAction("MyDownloads", "Home");
            }
            
            
        }



    }
}