using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage
{
    public partial class InsertTopic : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            string value = db.Topics.OrderByDescending(p => p.TopicId)
                            .Select(r => r.TopicId).First().ToString();

            int id = Convert.ToInt16(value.Substring(1, 2)) + 1;
            if (id < 10)
            {
                lblTopic.Text = "T0" + id;
            }
            else
            {
                lblTopic.Text = "T" + id;

            }
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtName.Text;

                Topic t = new Topic
                {
                    TopicId = lblTopic.Text,
                    TopicName = name
                };

                db.Topics.InsertOnSubmit(t);
                db.SubmitChanges();

                Response.Redirect("Exercise.aspx");
            }

        }

        
    }
}