using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class Grammar : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            string level = Request.QueryString["Level"];

            var q = from s in db.GrammarTypes
                    where level == null || s.Level == level // filter Level
                    select new
                    {
                        s.GrammarCode,
                        s.Title,
                        Level = s.Level == "L01" ? "Beginner" : (s.Level == "L02" ? "Intermediate" : "Advance")
                    };

            gvGrammar.DataSource = q;
            gvGrammar.DataBind();
        }

        protected void gvGrammar_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvGrammar.PageIndex = e.NewPageIndex;
            gvGrammar.DataBind();
        }
    }
}