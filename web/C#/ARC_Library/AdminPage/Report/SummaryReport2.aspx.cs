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
    public partial class SuummaryReport2 : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                rvSummary2.LocalReport.SetParameters(new ReportParameter("top", "Top 5"));

                var query = (from s in db.BookLoans orderby s.TotalLoan descending select s);

                for (int i = 1; i <= query.Count(); i++)
                {
                    ddlFilter.Items.Add(i.ToString());
                }

                string totalException = query.Count() + "";
                litTotalCount.Text += totalException;

                //ddlYear - current year + 9 years before
                ddlYear.Items.Add(new ListItem("--Select One--", "0"));
                var cYear = DateTime.Today.Year;
                for (int i = 0; i < 10; i++)
                {
                    ddlYear.Items.Add((cYear - i).ToString());
                }
            }
        }
        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
            {
                int filter = int.Parse(ddlFilter.SelectedValue);
                string year = ddlYear.SelectedValue.ToString();
                IEnumerable<BookLoan> query;
                if (year == "0")
                {
                    //no year, has filter
                    if (filter != 0)
                    {
                        query = (from p in db.BookLoans
                                orderby p.TotalLoan descending
                                select p).Take(filter);
                    }
                    else
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("top", "Top 5"));
                        //no year, no filter
                        query = (from p in db.BookLoans orderby p.TotalLoan descending select p).Take(5);
                    }
                }
                else
                {
                    //has filter,has year
                    query = (from p in db.BookLoans
                            where p.max_date.ToString().Contains(year)
                            orderby p.TotalLoan descending
                            select p).Take(filter);
                }
                reportBind(query);
            }

            protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
            {
             int filter = int.Parse(ddlFilter.SelectedValue);
                string year = ddlYear.SelectedValue.ToString();
                IEnumerable<BookLoan> query;
                if (filter == 0)
                {
                    //no filter, has year
                    if (year != "0")
                    {
                        query = from p in db.BookLoans
                                where p.max_date.ToString().Contains(year)
                                orderby p.TotalLoan descending
                                select p;
                    }
                    else
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("top", "Top 5"));

                        //no filter, no year
                        query = (from p in db.BookLoans orderby p.TotalLoan descending select p).Take(5);
                    }
                }
                else
                {
                    //has filter, has year
                    query = (from p in db.BookLoans
                            where p.max_date.ToString().Contains(year)
                            orderby p.TotalLoan descending
                            select p).Take(filter);
                }
                reportBind(query);
            }

            public void reportBind<T>(IEnumerable<T> q)
            {
                if (!q.Any())
                {
                    Label1.Text = "No record selected!";
                    btnBack.Visible = true;
                    rvSummary2.Visible = false;
                }
                else
                {
                    rvSummary2.Visible = true;
                    btnBack.Visible = false;
                    Label1.Text = "";



                rvSummary2.LocalReport.DataSources.Clear();
                    DataTable dt = helper.LINQResultToDataTable(q);

                    if (ddlFilter.SelectedValue != "0")
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("top", "Top " + ddlFilter.SelectedItem));
                    }
                    else
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("top", ""));
                    }

                    if (ddlYear.SelectedValue != "0")
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("Year", "in " + ddlYear.SelectedValue));
                    }
                    else
                    {
                        rvSummary2.LocalReport.SetParameters(new ReportParameter("Year", ""));
                    }

                    ReportDataSource rprtDTSource = new ReportDataSource("BookLoan", dt);
                    rvSummary2.LocalReport.DataSources.Add(rprtDTSource);
                    rvSummary2.LocalReport.Refresh();
                }
            }

            protected void btnBack_Click(object sender, EventArgs e)
            {
                Response.Redirect("SummaryReport2.aspx");
            }

        protected void dsSummary2_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var query = (from s in db.BookLoans orderby s.TotalLoan descending select s).Take(5);
            e.Result = query;
        }
    }
}