using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class Exercise : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                addRadioButton();
            }
        }


        protected void btnDone_Click(object sender, EventArgs e)
        {
            Response.Redirect("Exercise.aspx");
        }

        protected void gvExercise_PageIndexChanging1(object sender, GridViewPageEventArgs e)
        {
            gvExercise.PageIndex = e.NewPageIndex;
            addRadioButton();
        }

        protected void addRadioButton()
        {
            bindData();
            foreach (GridViewRow row in gvExercise.Rows)
            {
                RadioButton rb = new RadioButton();
                if (row.Cells[1].Text.Equals("A"))
                {
                    rb = (RadioButton)row.Cells[0].FindControl("rbOptA");

                }
                else if (row.Cells[1].Text.Equals("B"))
                {
                    rb = (RadioButton)row.Cells[0].FindControl("rbOptB");
                }
                else if (row.Cells[1].Text.Equals("C"))
                {
                    rb = (RadioButton)row.Cells[0].FindControl("rbOptC");
                }
                else if (row.Cells[1].Text.Equals("D"))
                {
                    rb = (RadioButton)row.Cells[0].FindControl("rbOptD");
                }
                rb.Checked = true;
            }
        }
        protected void bindData()
        {
            gvExercise.DataSourceID = null; ;
            gvExercise.DataSource = dsExercise;
            gvExercise.DataBind();
        }
    }
}