using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.MemberPage
{
    public partial class ViewExercise : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            Uri uri = new Uri(Request.Url.AbsoluteUri);
            string level = HttpUtility.ParseQueryString(uri.Query).Get("Level");
            string topicId = HttpUtility.ParseQueryString(uri.Query).Get("TopicId");
            if (!Page.IsPostBack)
            {
                string levelText = level.Equals("L01") ? "Beginner" : (level.Equals("L02") ? "Intermediate" : "Advanced");
                lblLevel.Text = "( " + levelText + " )";
                var q = (from sq in db.QuestionAnswers
                         where sq.Level.Equals(level) || sq.TopicId.Equals(topicId)
                         select new
                         {
                             sq.QuesId,
                             sq.Question,
                             sq.OptA,
                             sq.OptB,
                             sq.OptC,
                             sq.OptD,
                             sq.Level,
                             sq.Answer
                         }).ToList()
                        .OrderBy(QuesId => Guid.NewGuid()).Take(10).ToList();

                gvExercise.DataSource = q;
                gvExercise.DataBind();
            }
        }

        protected void btnCheckAnswer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int rows = gvExercise.Rows.Count;
                int correct = rows;


                foreach (GridViewRow row in gvExercise.Rows)
                {
                    Panel answer = (Panel)row.Cells[2].FindControl("pnlAnswer");

                    RadioButton[] rbl = new RadioButton[4]{
                        (RadioButton)row.Cells[1].FindControl("rbOptA"),
                        (RadioButton)row.Cells[1].FindControl("rbOptB"),
                        (RadioButton)row.Cells[1].FindControl("rbOptC"),
                        (RadioButton)row.Cells[1].FindControl("rbOptD")
                    };

                    Label correctAnswer = (Label)row.Cells[2].FindControl("lblAnswer");

                    RadioButton rbChecked = new RadioButton();

                    foreach (RadioButton rb in rbl)
                    {
                        rb.Style.Add("background-color", "");


                        if (rb.Checked)
                        {
                            rbChecked = rb;
                        }
                    }

                    if (correctAnswer.Text.Equals("A") && rbl[0].Checked == true)
                    {
                        rbl[0].Style.Add("background-color", "#ddefd7");

                    }
                    else if (correctAnswer.Text.Equals("B") && rbl[1].Checked == true)
                    {
                        rbl[1].Style.Add("background-color", "#ddefd7");
                    }
                    else if (correctAnswer.Text.Equals("C") && rbl[2].Checked == true)
                    {
                        rbl[2].Style.Add("background-color", "#ddefd7");
                    }
                    else if (correctAnswer.Text.Equals("D") && rbl[3].Checked == true)
                    {
                        rbl[3].Style.Add("background-color", "#ddefd7");
                    }
                    else
                    {
                        if (correctAnswer.Text.Equals("A"))
                        {
                            rbl[0].Style.Add("background-color", "#ddefd7");
                            rbl[0].Style.Add("font-weight", "bold");

                        }
                        else if (correctAnswer.Text.Equals("B"))
                        {
                            rbl[1].Style.Add("background-color", "#ddefd7");
                            rbl[1].Style.Add("font-weight", "bold");

                        }
                        else if (correctAnswer.Text.Equals("C"))
                        {
                            rbl[2].Style.Add("background-color", "#ddefd7");
                            rbl[2].Style.Add("font-weight", "bold");

                        }
                        else if (correctAnswer.Text.Equals("D"))
                        {
                            rbl[3].Style.Add("background-color", "#ddefd7");
                            rbl[3].Style.Add("font-weight", "bold");

                        }
                        else
                        {
                        }
                        rbChecked.Style.Add("background-color", "#fcf8c2");
                        correct--;
                    }
                }

                double mark = Convert.ToDouble(correct) / Convert.ToDouble(rows) * 100;
                lblCorrect.Text = "You get " + mark.ToString("0.#") + "% (" + correct.ToString() + " out of " + rows.ToString() + " )";

            }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            Uri uri = new Uri(Request.Url.AbsoluteUri);
            string level = HttpUtility.ParseQueryString(uri.Query).Get("Level");
            string link = "ViewExercise.aspx?Level=" + level;
            Server.Transfer(link);
        }

        protected void cvRequiredAnswer_ServerValidate(object source, ServerValidateEventArgs args)
        {
            foreach (GridViewRow row in gvExercise.Rows)
            {

                Panel answer = (Panel)row.Cells[2].FindControl("pnlAnswer");
                var checkedButton = answer.Controls.OfType<RadioButton>()
                                       .SingleOrDefault(r => r.Checked);

                //if no answer provided
                if (checkedButton == null)
                {
                    answer.Style.Add("background-color", "#e1e3e8");
                    Label1.Text = "* Please filled in ALL answer *";
                    args.IsValid = false;
                }
                else
                {
                    answer.Style.Add("background-color", "");
                    Label1.Text = "";

                }

            }
        }
    }
}