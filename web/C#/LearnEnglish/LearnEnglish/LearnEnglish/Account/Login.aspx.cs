using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.Script.Serialization;
using ASPSnippets.GoogleAPI;

namespace LearnEnglish.Account
   
{
    public partial class Login : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            GoogleConnect.ClientId = "406697224244-cemjvmb592isgtmo6pfr96nfqq1ab922.apps.googleusercontent.com";
            GoogleConnect.ClientSecret = "rhCgoGOH_aVdU_c_6dbajPNS";
            GoogleConnect.RedirectUri = Request.Url.AbsoluteUri.Split('?')[0];

            string username = "";
            string mail = "";
            bool rememberMe = chkRememberMe.Checked;

            if (!string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                string code = Request.QueryString["code"];
                string json = GoogleConnect.Fetch("me", code);
                GoogleLoginHandler.GoogleProfile profile = new JavaScriptSerializer().Deserialize<GoogleLoginHandler.GoogleProfile>(json);

                username = profile.DisplayName;
                mail = profile.Emails.Find(email => email.Type == "account").Value;

                LoginInfo l = new LoginInfo
                {
                    LoginId = 1,
                    Username = username.ToLower(),
                    DateTime = DateTime.Now,
                };

                db.LoginInfos.InsertOnSubmit(l);
                db.SubmitChanges();

                //control welcome banner
                Session["banner"] = true;
                Security.LoginUser(username, "User_Google", rememberMe);

                
            }
            
            if (Request.QueryString["error"] == "access_denied")
            {
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "Access Denied')", true);
            }
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string EncodedResponse = Request.Form["g-recaptcha-response"];
            var isCaptchaValid = ReCaptchaClass.Validate(EncodedResponse);
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
                    x => x.Username == username && x.HashPassword == Security.GetHash(password)

                    );

                if (u != null)
                {

                    if (u.Status == "" || u.Status == "Active")
                    {
                        LoginInfo l = new LoginInfo
                        {
                            LoginId = 1,
                            Username = username.ToLower(),
                            DateTime = DateTime.Now,

                        };

                        db.LoginInfos.InsertOnSubmit(l);
                        db.SubmitChanges();

                        //control welcome banner
                        Session["banner"] = true;
                        Security.LoginUser(u.Username, u.Role, rememberMe);
                    }
                    else if(u.Status == "NoActive")
                    {
                        CustomValidator1.IsValid = false;
                      
                    }
                }
                else
                {
                    cvNotMatched.IsValid = false;
                }
            }

        }

        protected void btnGoogle_Click(object sender, EventArgs e)
        {
            GoogleConnect.Authorize("profile", "email");
        }

        protected void cvGoogleRecaptcha_ServerValidate(object source, ServerValidateEventArgs args)
        {
           

        }
    }
    
    
}