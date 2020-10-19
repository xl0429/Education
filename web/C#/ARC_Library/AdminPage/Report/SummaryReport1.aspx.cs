using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.AdminPage.Report
{
    public partial class SummaryReport1 : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var query = from s in db.LoginInfos orderby s.DateTime descending select s;
                string count = query.Count() + "";
                litCount.Text = count;
                rvSummary.LocalReport.SetParameters(new ReportParameter("Year", DateTime.Now.Year + ""));

                //ddlYear - current year + 9 years before
                ddlYear.Items.Add(new ListItem("--Select One--", "0"));
                var cYear = DateTime.Today.Year;
                for (int i = 0; i < 10; i++)
                {
                    ddlYear.Items.Add((cYear - i).ToString());
                }


                rvSummary.LocalReport.SetParameters(new ReportParameter("TotalRecord", query.Where(s => s.DateTime.Year == DateTime.Now.Year).Count() + ""));
            }
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string year = ddlYear.SelectedValue.ToString();

            var query = from p in db.LoginInfos
                        where p.DateTime.ToString().Contains(year)
                        orderby p.DateTime descending
                        select p;

            reportBind(query);
        }


        public void reportBind<T>(IEnumerable<T> q)
        {
            if (!q.Any())
            {
                Label1.Text = "No record selected!";
                btnBack.Visible = true;
                rvSummary.Visible = false;
            }
            else
            {
                rvSummary.Visible = true;
                btnBack.Visible = false;

                string count = q.Count() + "";
                Label1.Text = count + " record(s)";
                rvSummary.LocalReport.SetParameters(new ReportParameter("TotalRecord", count));

                rvSummary.LocalReport.DataSources.Clear();
                DataTable dt = helper.LINQResultToDataTable(q);


                if (ddlYear.SelectedValue != "0")
                {
                    rvSummary.LocalReport.SetParameters(new ReportParameter("Year", "of " + ddlYear.SelectedValue));
                }
                else
                {
                    rvSummary.LocalReport.SetParameters(new ReportParameter("Year", ""));
                }
                ReportDataSource rprtDTSource = new ReportDataSource("LoginInfo", dt);
                rvSummary.LocalReport.DataSources.Add(rprtDTSource);
                rvSummary.LocalReport.Refresh();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("SummaryReport1.aspx");
        }


        protected void dsSummary_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var query = from s in db.LoginInfos orderby s.DateTime descending where s.DateTime.Year == DateTime.Now.Year select s;
            e.Result = query;
            Label1.Text = query.Count() + " record(s)";

        }

        protected void ddlUserType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}