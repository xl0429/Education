using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class DeleteExercise : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string id = Request.QueryString["QuesId"];

                QuestionAnswer sq = db.QuestionAnswers.SingleOrDefault(x => x.QuesId == id);
                if (sq != null)
                {
                    lblId.Text = sq.QuesId;
                    lblQuestion.Text = sq.Question;
                    lblOptionA.Text = sq.OptA;
                    lblOptionB.Text = sq.OptB;
                    lblOptionC.Text = sq.OptC;
                    lblOptionD.Text = sq.OptD;
                    lblAnswer.Text = sq.Answer.ToString();
                    lblTopic.Text = sq.Topic.TopicName;
                    lblLevel.Text = sq.Level;
                }
                else
                {
                    Response.Redirect("Exercise.aspx");
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblId.Text;

            QuestionAnswer sq = db.QuestionAnswers.SingleOrDefault(x => x.QuesId == id);
            if (sq != null)
            {
                db.QuestionAnswers.DeleteOnSubmit(sq);
                db.SubmitChanges();
            }
            
            Response.Redirect("Exercise.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Exercise.aspx");
        }
    }
}