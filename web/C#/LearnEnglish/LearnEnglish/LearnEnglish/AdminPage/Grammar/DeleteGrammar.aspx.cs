using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class DeleteGrammar : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string grammarCode = Request.QueryString["GrammarCode"];

                GrammarType s = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);
                if (s != null)
                {
                    lblCode.Text = s.GrammarCode;
                    lblTitle.Text = s.Title;
                    txtDesc.Text = s.Description;
                    lblLevel.Text = s.Level;
                }
                else
                {
                    Response.Redirect("Grammar.aspx");
                }
            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string grammarCode = lblCode.Text;

            GrammarType s = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);

            if (s != null)
            {
                //delete
                db.GrammarTypes.DeleteOnSubmit(s);


                //Update edition
                DateTime.Now.ToString("dd-MM-yyyy");
                Edition a = new Edition
                {
                    AdminName = "admin1",
                    Date = DateTime.Now,
                    GrammarCode = grammarCode,
                    EditionType = "Delete"
                };
                db.Editions.InsertOnSubmit(a);
                db.SubmitChanges();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfully deleted');window.location ='Grammar.aspx';", true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Grammar.aspx");
        }
    }
}