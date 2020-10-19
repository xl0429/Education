using ARC_Library.MemberPage;
using ASPSnippets.GoogleAPI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.Account
{
    public partial class Log : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (!(User.IsInRole("User_Member") || User.IsInRole("User_Staff") || User.IsInRole("User_Admin") ))
                {
                    GoogleConnect.ClientId = WebConfigurationManager.AppSettings["GoogleClientId"];
                    GoogleConnect.ClientSecret = WebConfigurationManager.AppSettings["GoogleClientSecret"];
                    GoogleConnect.RedirectUri = Request.Url.AbsoluteUri.Split('?')[0];

                    if (!string.IsNullOrEmpty(Request.QueryString["code"]))
                    {
                        string username = "";
                        string mail = "";
                        bool rememberMe = chkRememberMe.Checked;

                        string code = Request.QueryString["code"];
                        string json = GoogleConnect.Fetch("me", code);
                        GoogleLoginHandler.GoogleProfile profile = new JavaScriptSerializer().Deserialize<GoogleLoginHandler.GoogleProfile>(json);

                        username = profile.DisplayName;
                        mail = profile.Emails.Find(email => email.Type == "account").Value;
                        string phone = profile.Phone;

                        insertMember(username, mail, phone);

                        Security.LoginUser(username, "User_Member", rememberMe);

                    }
                    if (Request.QueryString["error"] == "access_denied")
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "Access Denied')", true);
                    }
                }
                else
                {
                    Page.Response.Redirect("../Home.aspx");
                }
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string EncodedResponse = Request.Form["g-recaptcha-response"];
            var isCaptchaValid = Recaptcha.Validate(EncodedResponse);
            if (isCaptchaValid)
            {
                cvGoogleRecaptcha.IsValid = true;
            }
            else
            {
                cvGoogleRecaptcha.IsValid = false;
            }

            if (Page.IsValid)
            {
                string username = txtUsername.Text;
                string password = txtPassword.Text;
                bool rememberMe = chkRememberMe.Checked;

                // Login the user
                User u = db.Users.SingleOrDefault(
                    x => (x.Username.ToLower() == username.ToLower() || x.Email.ToLower() == username.ToLower()) && x.Hash == Security.GetHash(password)
                );
                if (u != null)
                {
                    if (u.Status == null || u.Status == "Active")
                    {
                        LoginInfo l = new LoginInfo
                        {
                            LoginId = 1,
                            DateTime = DateTime.Now,
                            Username = username
                        };
                        db.LoginInfos.InsertOnSubmit(l);
                        db.SubmitChanges();

                        Security.LoginUser(u.Username, u.Role, rememberMe);
                    }
                    else if (u.Status == "NoActive")
                    {
                        cvAccStatus.IsValid = false;
                        cvAccStatus.ErrorMessage = "Please check your email for activation";
                    }
                    else if (u.Status == "Blocked")
                    {
                        cvAccStatus.IsValid = false;
                        cvAccStatus.ErrorMessage = "[Username] blocked, activate account at library counter";
                    }
                }
                else
                {
                    cvNotMatch.IsValid = false;
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //check the email existence in dbs
                string email = txtEmail.Text;

                Member m = db.Members.SingleOrDefault(x => x.Email == email);

                if (m == null)
                {
                    cvCheckEmail.IsValid = false;
                }
                else
                {
                    //send recovery password to email
                    string password = Security.GetUniqueKey(); //generate password
                    string subject = "Password Recovery For Your Account ";
                    string bodyText
                    = " <html>"
                    + "<body>"
                    + "<h3><b>Hi, " + m.Username + "</b></h3>"
                    + "<p>This is your new password : <h3>" + password + "</h3>"
                    + "Please login with your <b>new passworrd</b> using the following link <br /><a href='http://localhost:50339/Account/Log.aspx'>Login Here</a>"
                    + "</body>"
                    + "</html>";

                    EmailHandler.ExecuteHtmlSendMail("webtesitngacc.test@gmail.com", email, bodyText, subject);

                    //update db for new password
                    m.Hash = Security.GetHash(password);
                    db.SubmitChanges();


                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Check your email to get your new password');window.location ='Log.aspx';", true);
                }

            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string value = db.Members.OrderByDescending(p => p.MemberId)
                                 .Select(re => re.MemberId).First().ToString();
                string id = helper.generateId(value);
                string email = txtSUemail.Text;
                string username = txtSUusername.Text;

                if (db.Members.Any(s => s.Email == email))
                {
                    cvEmailExist.IsValid = false;
                    cvUsernameExist.IsValid = true;
                }
                else if (db.Users.Any(s => s.Username == username))
                {
                    cvEmailExist.IsValid = true;
                    cvUsernameExist.IsValid = false;
                }
                else {
                    Member m = new Member
                    {
                        MemberId = id,
                        Username = txtSUusername.Text,
                        Hash = Security.GetHash(txtSUpassword.Text),
                        Email = email,
                        ContactNo = txtSUcontactNo.Text,
                        Status = "NoActive"
                    };
                    db.Members.InsertOnSubmit(m);
                    db.SubmitChanges();

                    emailActivation(txtSUusername.Text, txtSUemail.Text, id);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please check you email to activate your account within 3 days');window.location ='Log.aspx';", true);
                }
            }


        }
        //email for activation account
        protected void emailActivation(string username, string email, string memberID)
        {

            string subject = "New Account in ARC Library ";
            string bodyText
            = " <html>"
            + "<body>"
            + "<h3><b>Hi, " + username + "</b></h3>"
            + "<p>Your member id is <b>" + memberID + "</b></h3>"
            + "<p>Thank you for creating a ARC Library account. </p>"
            + "Please click the following link to activate your account <br /><a href='http://localhost:50339/Account/AccountActivation.aspx?Username=" + username + "&Token=" + TokenHandler.GenerateToken(username) + "'>Activation Link</a>"
            + "</body>"
            + "</html>";

            EmailHandler.ExecuteHtmlSendMail("webtesitngacc.test@gmail.com", email, bodyText, subject);
        }

        protected void insertMember(string username, string email, string phone){
            //non member google login insert as member
            if (!db.Users.Any(s => s.Username.ToLower() == username.ToLower()))
            {
                string value = db.Members.OrderByDescending(p => p.MemberId)
                                .Select(re => re.MemberId).First().ToString();
                string id = helper.generateId(value);
                Member m = new Member
                {
                    MemberId = id,
                    Username = username,
                    Hash = null,
                    ContactNo = phone,
                    Status = "User_Google",
                    Email = email
                };
                db.Members.InsertOnSubmit(m);
                db.SubmitChanges();
            }

        }

        protected void btnGoogle_Click(object sender, EventArgs e)
        {
            GoogleConnect.Authorize("profile", "email");
        }
        protected void btnGoogleSignUp_Click(object sender, EventArgs e)
        {
            GoogleConnect.Authorize("profile", "email", "phone");
        }

        protected void cvEmailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            if (db.Members.Any(s => s.Email.ToLower() == email.ToLower()))
            {
                args.IsValid = false;
            }
        }

        protected void cvUsernameExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            if (db.Users.Any(s => s.Username.ToLower() == username.ToLower()))
            {
                args.IsValid = false;
            }
        }     

        protected void cvAccStatus_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string status = db.Users.Where(x => x.Username.ToLower() == args.Value.ToLower()).Select(y => y.Status).SingleOrDefault();
            if (status == "Blocked")
            {
                cvAccStatus.ErrorMessage = "Your account is blocked please activate at library counter";
                args.IsValid = false;
            }
            if (status == "NoActive")
            {
                cvAccStatus.ErrorMessage = "Please check your email for activation link";
                args.IsValid = false;
            }
        }
      
        protected void cvOverDue_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            string username = args.Value.ToUpper();
            Member u = db.Members.SingleOrDefault(x => x.Username.ToUpper() == username || x.Email == username);
            if (u!=null)
            {
                var query = from l in db.Loans where l.MemberId == u.MemberId && l.Status == "NotReturned" && DateTime.Now > Convert.ToDateTime(l.ReturnDate).AddDays(15) select l;
                if (query.Any() && u.Status != "Blocked")
                {
                    u.Status = "Blocked";
                    db.SubmitChanges();
                    args.IsValid = false;
                }
                
            }
        }
    }
}