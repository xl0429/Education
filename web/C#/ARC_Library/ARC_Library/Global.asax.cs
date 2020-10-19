using ARC_Library.Account;
using ARC_Library.MemberPage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace ARC_Library
{
    public class Global : System.Web.HttpApplication
    {
        public const int MAX_BOOK_COUNT = 5;
        protected void Application_Start(object sender, EventArgs e)
        {
        }
       
        protected void Session_Start(object sender, EventArgs e)
        {
            Session["showBanner"] = "false";

        }

        public void getNumber(string username)
        {
           
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            Security.ProcessRoles();

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
        }

        protected void Application_End(object sender, EventArgs e)
        {
        }
    }
}