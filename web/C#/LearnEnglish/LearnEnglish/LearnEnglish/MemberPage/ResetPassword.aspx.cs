using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.Account
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
       
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //check current password
                string username = HttpContext.Current.User.Identity.Name;
                string currentPassword = txtCurrentPassword.Text;
                User u = db.Users.SingleOrDefault( x => x.Username == username && x.HashPassword == Security.GetHash(currentPassword) );

                if (u == null)
                {
                    cvNotMatch.IsValid = false;

                }
                else
                {
                    //upload new password
                    string password = txtPassword.Text;

                    Member m = db.Members.SingleOrDefault(x => x.Username == username);

                    if (m != null)
                    {
                        m.HashPassword = Security.GetHash(password);
                        db.SubmitChanges();
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your password is changed successfully');window.location ='../Home.aspx';", true);
                }
            }
        }

        
    }
}