using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class UpdateExercise : System.Web.UI.Page
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

                ddlTopic.DataSource = db.Topics;
                ddlTopic.DataTextField = "TopicName";
                ddlTopic.DataValueField = "TopicId";
                ddlTopic.DataBind();

                string id = Request.QueryString["QuesId"];

                QuestionAnswer sq = db.QuestionAnswers.SingleOrDefault(x => x.QuesId == id);
                if (sq != null)
                {
                    lblId.Text = sq.QuesId;
                    txtQuestion.Text = sq.Question;
                    txtOptionA.Text = sq.OptA;
                    txtOptionB.Text = sq.OptB;
                    txtOptionC.Text = sq.OptC;
                    txtOptionD.Text = sq.OptD;
                    txtAnswer.Text = sq.Answer.ToString();
                    ddlTopic.Text = sq.Topic.TopicName;
                    ddlLevel.Text = sq.GrammarLevel.LevelName;
                }
                else
                {
                    Response.Redirect("Exercise.aspx");
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = lblId.Text;
                string question = txtQuestion.Text;
                string optionA = txtOptionA.Text;
                string optionB = txtOptionB.Text;
                string optionC = txtOptionC.Text;
                string optionD = txtOptionD.Text;
                char answer = Convert.ToChar(txtAnswer.Text.ToUpper());
                string topic = ddlTopic.Text;
                string level = ddlLevel.Text;


                QuestionAnswer sq = db.QuestionAnswers.SingleOrDefault(x => x.QuesId == id);
                if (sq != null)
                {
                    sq.QuesId = id;
                    sq.Question = question;
                    sq.OptA = optionA;
                    sq.OptB = optionB;
                    sq.OptC = optionC;
                    sq.OptD = optionD;
                    sq.TopicId = topic;
                    sq.Answer = answer;
                    sq.Level = level;

                    db.SubmitChanges();
                }
                else
                {
                    Response.Redirect("Exercise.aspx");
                }

                Response.Redirect("Exercise.aspx");

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Exercise.aspx");
        }
    }
}