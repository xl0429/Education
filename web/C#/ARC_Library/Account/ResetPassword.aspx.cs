using ARC_Library.Account;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.Account
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (!(User.IsInRole("User_Member") || User.IsInRole("User_Staff") || User.IsInRole("User_Admin")))
                {
                    Page.Response.Redirect("~/Account/Log.aspx");

                }
            }            
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //check current password
                string username = HttpContext.Current.User.Identity.Name;
                string currentPassword = txtCurrentPassword.Text;
                User u = db.Users.SingleOrDefault(x => x.Username == username && x.Hash == Security.GetHash(currentPassword));
                bool control = true; // check user exist;
                if (u == null)
                {
                    cvNotMatch.IsValid = false;
                }
                else
                {
                    //upload new password
                    string password = txtPassword.Text;
                    if (User.IsInRole("User_Member"))
                    {
                        var m = db.Members.SingleOrDefault(x => x.Username == username);
                        m.Hash = Security.GetHash(password);

                    }
                    else if(User.IsInRole("User_Staff"))
                    {
                        var m = db.Staffs.SingleOrDefault(x => x.Username == username);
                        m.Hash = Security.GetHash(password);

                    }
                    else if (User.IsInRole("User_Admin"))
                    {
                        var m  = db.Admins.SingleOrDefault(x => x.Username == username);
                        m.Hash = Security.GetHash(password);
                    }
                    else
                    {
                        control = false;
                        Page.Response.Redirect("~/Account/Log.aspx");
                    }
                    if (control == true)
                    {
                        db.SubmitChanges();
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your password is changed successfully');window.location ='../Home.aspx';", true);
                }
            }
        }
    }
}