using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.Account
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Logout the user
            if (User.Identity.IsAuthenticated)
            {
                FormsAuthentication.SignOut();
                Response.Redirect("../Home.aspx");
                Session.Clear();
            }

        }
    }
}