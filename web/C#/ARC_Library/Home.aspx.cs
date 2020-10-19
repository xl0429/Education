using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class Home : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void dsTopBook_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var query = (from s in db.Books where s.Status!="Deleted" orderby s.RegisterDate descending select s).Take(5);
            e.Result = query;
        }
            
        protected void Button1_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("BookList.aspx");
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string url = "BookList.aspx?q=" + txtSearch.Text;
            Page.Response.Redirect(url);
        }

       

    }
}