using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*//hide banner after first time display
            if ((bool)Session["banner"] == true)
            {
                LoginView2.Visible = true;
                Session["banner"] = false;
            }
            */
        }
    }
}