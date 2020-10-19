using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish.AdminPage.Report
{
    public partial class DetailReport : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var query = from s in db.Editions orderby s.Date descending select s;

                string totalLogin = query.Count() + "";
                litTotalCount.Text += totalLogin;    
                Label1.Text = totalLogin + " record(s)";

                //ddlYear - current year + 9 years before
                ddlYear.Items.Add(new ListItem("--Select One--", "0"));
                var cYear = DateTime.Today.Year;
                for (int i = 0; i < 10; i++)
                {
                    ddlYear.Items.Add((cYear - i).ToString());
                }
                rvDetail.LocalReport.SetParameters(new ReportParameter("TotalRecord", query.Count().ToString()));
            }
           
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filter = ddlFilter.SelectedValue.ToString();
            string year = ddlYear.SelectedValue.ToString();
            IEnumerable<Edition> query;
            if (year == "0")
            {
                //no year, has filter
                if(filter != "0") { 
                    query = from p in db.Editions
                            where p.EditionType.Contains(filter)
                            orderby p.Date descending
                            select p;
                    }
                else
                {
                    //no year, no filter
                    query = from p in db.Editions orderby p.Date descending select p;
                }
            }
            else
            {
                //has filter,has year
                query = from p in db.Editions
                        where p.EditionType == filter
                          && p.Date.ToString().Contains(year)
                        orderby p.Date descending
                        select p;
            }
            reportBind(query);
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filter = ddlFilter.SelectedValue.ToString();
            string year = ddlYear.SelectedValue.ToString();
            IEnumerable<Edition> query;
            if (filter == "0")
            {
                //no filter, has year
                if (year != "0")
                {
                    query = from p in db.Editions
                            where p.Date.ToString().Contains(year)
                            orderby p.Date descending
                            select p;
                }
                else
                {
                    //no filter, no year
                    query = from p in db.Editions  orderby p.Date descending select p;
                }
            }
            else
            {
                //has filter, has year
                query = from p in db.Editions
                        where p.EditionType == filter
                        && p.Date.ToString().Contains(year)
                        orderby p.Date descending
                        select p;
            }
            reportBind(query);
        }

        public void reportBind<T>(IEnumerable<T> q)
        {
            if (!q.Any())
            {
                Label1.Text = "No record selected!";
                btnBack.Visible = true;
                rvDetail.Visible = false;
            }
            else
            {
                rvDetail.Visible = true;
                btnBack.Visible = false;

                Label1.Text = q.Count() + " record(s) selected.";
                rvDetail.LocalReport.SetParameters(new ReportParameter("TotalRecord", q.Count().ToString()));

                rvDetail.LocalReport.DataSources.Clear();
                DataTable dt = linqToDT.LINQResultToDataTable(q);

                if (ddlFilter.SelectedValue != "0")
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("EditionType", "of " + ddlFilter.SelectedValue));
                }
                else
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("EditionType", ""));
                }

                if (ddlYear.SelectedValue != "0")
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("Year", "in " + ddlYear.SelectedValue));
                }
                else
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("Year", ""));
                }

                ReportDataSource rprtDTSource = new ReportDataSource("Edition", dt);
                rvDetail.LocalReport.DataSources.Add(rprtDTSource);
                rvDetail.LocalReport.Refresh();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetailReport.aspx");
        }

        protected void dsDetail_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var query = from s in db.Editions orderby s.Date descending select s;
            e.Result = query;          
        }

        
    }
}