using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class InsertExercise : System.Web.UI.Page
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

                string value = db.QuestionAnswers
                            .OrderByDescending(p => p.QuesId)
                            .Select(r => r.QuesId)
                            .First().ToString();
                int id = Convert.ToInt16(value.Substring(1, 2)) + 1;
                if (id < 10)
                {
                    lblQuestionId.Text = "Q0" + id.ToString();

                }
                else
                {
                    lblQuestionId.Text = "Q" + id.ToString();
                }

            }
        }
        protected void btnAddQ_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string questionid = lblQuestionId.Text;
                string question = txtQuestion.Text;
                string optionA = txtOptionA.Text;
                string optionB = txtOptionB.Text;
                string optionC = txtOptionC.Text;
                string optionD = txtOptionD.Text;
                char answer = Convert.ToChar(txtAnswer.Text.ToUpper());
                string topic = ddlTopic.Text;
                string level = ddlLevel.Text;

                QuestionAnswer sq = new QuestionAnswer
                {
                    QuesId = questionid,
                    Question = question,
                    OptA = optionA,
                    OptB = optionB,
                    OptC = optionC,
                    OptD = optionD,
                    Answer = answer,
                    TopicId = topic,
                    Level = level

                };

                db.QuestionAnswers.InsertOnSubmit(sq);
                db.SubmitChanges();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('The question is inserted succesfully');window.location ='InsertExercise.aspx';", true);

            }
        }



        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string id = args.Value;

            if (db.QuestionAnswers.Any(sq => sq.QuesId == id))
            {
                args.IsValid = false;

            }
        }

        protected void btnClear_Click1(object sender, EventArgs e)
        {
            Server.Transfer("InsertExercise.aspx");
        }
    }

}