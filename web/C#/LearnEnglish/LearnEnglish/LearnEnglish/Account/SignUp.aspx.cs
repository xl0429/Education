using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.Account
{
    public partial class SignUp : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlCountries.DataSource = db.Countries;
                ddlCountries.DataTextField = "countryName";
                ddlCountries.DataValueField = "countryCode";
                ddlCountries.DataBind();
            }
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime minDate = DateTime.Now.Date.AddYears(-100);
            DateTime maxDate = DateTime.Now.Date;
            DateTime dt;

            args.IsValid = (DateTime.TryParse(args.Value, out dt)
                            && dt <= maxDate
                            && dt >= minDate);
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            if (db.Users.Any(s => s.Username == username))
            {
                args.IsValid = false;
            }
            
        }

        protected void CustomValidator3_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            if (db.Members.Any(s => s.Email == email))
            {
                args.IsValid = false;
            }

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text;
                string password = txtPassword.Text;
                string email = txtEmail.Text;
                string countryCode = ddlCountries.Text;
                DateTime birthday;
                birthday = Convert.ToDateTime(txtBirthday.Text);

                //store new member infor to db
                Member m = new Member
                {
                    Username = username,
                    HashPassword = Security.GetHash(password),
                    Email = email,
                    CountryCode = countryCode,
                    Birthday = birthday,
                    Status = "NoActive"
                };


                db.Members.InsertOnSubmit(m);
                db.SubmitChanges();

                emailActivation(username, email);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please check you email to activate your account within 3 days');window.location ='Login.aspx';", true);

            }
        }

        //email for activation account
        protected void emailActivation(string username, string email)
        {
   
            string subject = "New Account in LearnEnglish ";
            string bodyText
            = " <html>"
            + "<body>"
            + "<h3><b>Hi, " + username + "</b></h3>"
            + "<p>Thank you for creating a LearnEnglish account. </p>"
            + "Please click the following link to activate your account <br /><a href='http://localhost:49333/Account/AccountActivation.aspx?Username=" + username+ "&Token=" + TokenHandler.GenerateToken(username)+ "'>Activation Link</a>"
            + "</body>"
            + "</html>";

            EmailHandler.ExecuteHtmlSendMail("webtesitngacc.test@gmail.com", email, bodyText, subject);
        }

        
    }
}