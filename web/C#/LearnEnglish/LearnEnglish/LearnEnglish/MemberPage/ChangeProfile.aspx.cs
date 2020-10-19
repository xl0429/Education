using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.Account
{
    public partial class ChangeProfile : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string username = HttpContext.Current.User.Identity.Name;

                ddlCountries.DataSource = db.Countries;
                ddlCountries.DataTextField = "CountryName";
                ddlCountries.DataValueField = "CountryCode";
                ddlCountries.DataBind();
                
                Member m = db.Members.SingleOrDefault(x => x.Username == username);
              
                if (m != null)
                {
                    lblUsername2.Text = m.Username;
                    txtEmail.Text = m.Email;
                    ddlCountries.Text = m.CountryCode;
                    txtBirthday.Text = m.Birthday.Value.ToString("yyyy-MM-dd");
                }
                else
                {
                   
                   Response.Redirect("../About.aspx");
                }
            }
        }
        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            if (db.Members.Any(s => s.Username == username))
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = lblUsername2.Text;
                string email = txtEmail.Text;
                string country = ddlCountries.Text;
                
                DateTime birthday;
                birthday = Convert.ToDateTime(txtBirthday.Text);

                Member m = db.Members.SingleOrDefault(x => x.Username == username);

                if (m != null)
                {
                    m.Email = email;
                    m.CountryCode = country;
                    m.Birthday = birthday;

                    db.SubmitChanges();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(),"alert","alert('Your account is updated sucessfully');window.location ='../Home.aspx';",true);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer("ChangeProfile.aspx");
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
    }
}