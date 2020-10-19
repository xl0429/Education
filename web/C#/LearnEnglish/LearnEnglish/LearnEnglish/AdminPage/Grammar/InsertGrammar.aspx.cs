using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class InsertGrammar : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlLevel.DataSource = db.GrammarLevels;
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "Level";
                ddlLevel.DataBind();

                string value = db.GrammarTypes.OrderByDescending(p => p.GrammarCode)
                              .Select(r => r.GrammarCode).First().ToString();

                int id = Convert.ToInt16(value.Substring(1, 4)) + 1;
                if (id < 10)
                {
                    lblGrammarCode.Text = "G000" + id;
                }
                else if (id < 100)
                {
                    lblGrammarCode.Text = "G00" + id;
                }
                else if (id < 1000)
                {
                    lblGrammarCode.Text = "G0" + id;
                }
                else
                {
                    lblGrammarCode.Text = "G" + id;
                }
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (txtDesc.Text.Equals(""))
                {
                    CustomValidator2.IsValid = false;
                }
                else
                {
                    string grammarCode = lblGrammarCode.Text;
                    string title = txtTitle.Text;
                    string description = txtDesc.Text;
                    string level = ddlLevel.Text;

                    GrammarType s = new GrammarType
                    {
                        GrammarCode = grammarCode,
                        Title = title,
                        Description = txtDesc.Text,
                        Level = level,
                        Rating = 0,
                        RateCount = 0
                    };

                    db.GrammarTypes.InsertOnSubmit(s);

                    DateTime.Now.ToString("dd-MM-yyyy");
                    Edition a = new Edition
                    {
                        AdminName = HttpContext.Current.User.Identity.Name,
                        Date = DateTime.Now,
                        GrammarCode = grammarCode,
                        EditionType = "Insert"
                    };
                    db.Editions.InsertOnSubmit(a);
                    db.SubmitChanges();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfully inserted');window.location ='Grammar.aspx';", true);
                }
            }
        }
    }

}