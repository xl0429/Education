using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.Account
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            ddlCountries.DataSource = db.Countries;
            ddlCountries.DataTextField = "countryName";
            ddlCountries.DataValueField = "countryCode";
            ddlCountries.DataBind();
        }


        protected void btnSubmit_Click1(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //check the email existence in dbs
                string email = txtEmail.Text;

                Member m = db.Members.SingleOrDefault(x => x.Email == email);

                if (m == null)
                {
                    cvNotMatched.IsValid = false;
                }
                else
                {
                    //check security question
                    if(m.Birthday.Value.ToString("yyyy-MM-dd") == txtBirthday.Text && m.CountryCode == ddlCountries.Text) {
                        
                        //send recovery password to email
                        string password = Security.GetUniqueKey(); //generate password

                        string subject = "Password Recovery For Your Account ";
                        string bodyText
                        = " <html>"
                        + "<body>"
                        + "<h3><b>Hi, " + m.Username + "</b></h3>"
                        + "<p>This is your new password : <h3>" + password + "</h3>"
                        + "Please login with your <b>new passworrd</b> using the following link <br /><a href='http://localhost:49333/Account/Login.aspx'>Login Here</a>"
                        + "</body>"
                        + "</html>";

                        EmailHandler.ExecuteHtmlSendMail("webtesitngacc.test@gmail.com", email, bodyText, subject);

                        //update db for new password
                        m.HashPassword = Security.GetHash(password);
                        db.SubmitChanges();


                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Check your email to get your new password');window.location ='Login.aspx';", true);
                    }
                    else
                    {
                        CustomValidator1.IsValid = false;
                    }
                }


            }


        }

   
    }
}