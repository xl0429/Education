using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.Account
{
    public partial class AccountActivation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ARCLibraryDataContext db = new ARCLibraryDataContext();
            if (!Page.IsPostBack)
            {
                Uri uri = new Uri(Request.Url.AbsoluteUri);
                string username = HttpUtility.ParseQueryString(uri.Query).Get("Username");
                string token = HttpUtility.ParseQueryString(uri.Query).Get("Token");

                Member m = db.Members.SingleOrDefault(x => x.Username == username);

                if (m != null)
                {
                    Label1.Text = "token";
                    //token is valid and own by the usernames
                    if (TokenHandler.ValidateToken(token) != null && TokenHandler.ValidateToken(token) == username)
                    {
                        //update active status
                        m.Status = "Active";
                        db.SubmitChanges();
                        Response.Redirect("~/Account/Log.aspx");
                    }
                    else
                    {
                        db.Members.DeleteOnSubmit(m);
                        db.SubmitChanges();
                        Label1.Text = "Your activation link is expired! Please sign up again <br />";
                        Label1.Text += "After 3 seconds, you will be redirected to : ";

                        HyperLink1.Visible = true;
                    }
                }
            }
        }
    }
}