using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage.Report
{
    public partial class ExceptionReport : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
           
           
        }
        

        protected void dsException_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var list = (from t in db.GrammarTypes
                        orderby t.Rating descending
                        select t).Take(5)
                ;
            e.Result = list;
        }
    }
}