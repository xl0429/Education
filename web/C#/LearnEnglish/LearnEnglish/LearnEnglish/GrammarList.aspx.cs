using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish
{
    public partial class GrammarList : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {
                string level = getUrlLevel();


                if (level == null)
                {
                    lblHeader.Text = "Grammar List";
                    var q = from s in db.GrammarTypes
                            
                            select new
                            {
                                s.GrammarCode,
                                s.Title
                            };
                    gvLevel.DataSource = q;

                }
                else {
                    if (level == "l01")
                    {
                        lblHeader.Text = "Beginner";
                    }
                    else if (level == ("l02"))
                    {
                        lblHeader.Text = "Intermediate";

                    }
                    else if (level == ("l03"))
                    {
                        lblHeader.Text = "Advanced";
                    }

                    var q = from s in db.GrammarTypes
                            where s.Level.Equals(level) // filter grammar level
                            select new
                            {
                                s.GrammarCode,
                                s.Title
                            };
                    gvLevel.DataSource = q;

                }

                gvLevel.DataBind();
            }
        }

        private void BindGrid(string str)
        {
            string level = getUrlLevel();
            if (level == null) {
              var query = from p in db.GrammarTypes
                        where p.Description.Contains(str)
                        select new
                        {
                            p.GrammarCode,
                            p.Title
                        };
                gvLevel.DataSource = query;
                

            }
            else
            {
                var query = from p in db.GrammarTypes
                            where p.Description.Contains(str) && p.Level.Equals(getUrlLevel())
                            select new
                            {
                                p.GrammarCode,
                                p.Title
                            };
                gvLevel.DataSource = query;

            }
            gvLevel.DataBind();

            if (gvLevel.Rows.Count == 0)
            {
                Label1.Text = "No records found!";
            }
        }

        protected void btnSearch_Click1(object sender, EventArgs e)
        {
            BindGrid(txtSearch.Text);
        }

        protected string getUrlLevel()
        {
            Uri uri = new Uri(Request.Url.AbsoluteUri);
            string level = HttpUtility.ParseQueryString(uri.Query).Get("Level");
            return level;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            

            string link = "GrammarList.aspx";
            if (getUrlLevel() != null)
            {
                link += "?Level=" + getUrlLevel(); 
            }
            Response.Redirect(link);
        }
    }
}