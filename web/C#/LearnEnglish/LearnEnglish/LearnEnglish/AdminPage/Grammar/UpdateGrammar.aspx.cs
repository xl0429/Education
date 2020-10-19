using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class UpdateGrammar : System.Web.UI.Page
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

                string grammarCode = Request.QueryString["GrammarCode"];

                GrammarType m = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);

                if (m != null)
                {
                    lblCode.Text = m.GrammarCode;
                    txtTitle.Text = m.Title;
                    txtDesc.Text = m.Description;
                    ddlLevel.Text = m.Level;
                }
                else
                {
                    Response.Redirect("Grammar.aspx");
                }

            }
        }
        protected void btnCancel_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Grammar.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (txtDesc.Text.Equals(""))
                {
                    CustomValidator2.IsValid = false;
                }
                else
                {
                    string grammarCode = Request.QueryString["GrammarCode"];
                    string title = txtTitle.Text;
                    string description = txtDesc.Text;
                    string level = ddlLevel.Text;


                    GrammarType s = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);

                    if (s != null)
                    {
                        s.GrammarCode = grammarCode;
                        s.Title = title;
                        s.Description = description;
                        s.Level = level;

                        DateTime.Now.ToString("dd-MM-yyyy");
                        Edition a = new Edition
                        {
                            AdminName = HttpContext.Current.User.Identity.Name,
                            Date = DateTime.Now,
                            GrammarCode = grammarCode,
                            EditionType = "Update"
                        };
                        db.Editions.InsertOnSubmit(a);
                        db.SubmitChanges();
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfuly updated');window.location ='Grammar.aspx';", true);

                }
            }
        }
    }
}