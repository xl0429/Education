using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class ExceptionReport : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var datasource = from x in db.Users
                                 where x.Role=="User_Admin" || x.Role == "User_Staff"
                                 select new
                                 {
                                     x.Id,
                                     x.Username,
                                     DisplayField = String.Format("{0} - {1}", x.Id, x.Username)
                                 };
                ddlFilter.DataSource = datasource;
                ddlFilter.DataTextField = "DisplayField";
                ddlFilter.DataValueField = "Id";
                ddlFilter.DataBind();

                var query = from s in db.PenaltyLoans where s.PayAmount==0 select s;

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
                rvException.LocalReport.SetParameters(new ReportParameter("TotalRecord", query.Count().ToString()));
            }
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filter = ddlFilter.SelectedValue.ToString();
            string year = ddlYear.SelectedValue.ToString();
            IEnumerable<PenaltyLoan> query;
            if (year == "0")
            {
                //no year, has filter
                if (filter != "0")
                {
                    query = from p in db.PenaltyLoans
                            where p.Id.Contains(filter) 
                           
                            select p;
                }
                else
                {
                    //no year, no filter
                    query = from p in db.PenaltyLoans select p;
                }
            }
            else
            {
                //has filter,has year
                query = from p in db.PenaltyLoans
                        where p.Id == filter
                          && p.PayDate.ToString().Contains(year)
                        orderby p.PayDate descending
                        select p;
            }
            reportBind(query);
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filter = ddlFilter.SelectedValue.ToString();
            string year = ddlYear.SelectedValue.ToString();
            IEnumerable<PenaltyLoan> query;
            if (filter == "0")
            {
                //no filter, has year
                if (year != "0")
                {
                    query = from p in db.PenaltyLoans
                            where p.PayDate.ToString().Contains(year)
                            orderby p.PayDate descending
                            select p;
                }
                else
                {
                    //no filter, no year
                    query = from p in db.PenaltyLoans orderby p.PayDate descending select p;
                }
            }
            else
            {
                //has filter, has year
                query = from p in db.PenaltyLoans
                        where p.Id == filter
                        && p.PayDate.ToString().Contains(year)
                        orderby p.PayDate descending
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
                rvException.Visible = false;
            }
            else
            {
                rvException.Visible = true;
                btnBack.Visible = false;

                Label1.Text = q.Count() + " record(s) selected.";
                rvException.LocalReport.SetParameters(new ReportParameter("TotalRecord", q.Count().ToString()));

                rvException.LocalReport.DataSources.Clear();
                DataTable dt = helper.LINQResultToDataTable(q);

                if (ddlFilter.SelectedValue != "0")
                {
                    rvException.LocalReport.SetParameters(new ReportParameter("Staff", "of " + ddlFilter.SelectedItem));
                }
                else
                {
                    rvException.LocalReport.SetParameters(new ReportParameter("Staff", ""));
                }

                if (ddlYear.SelectedValue != "0")
                {
                    rvException.LocalReport.SetParameters(new ReportParameter("Year", "in " + ddlYear.SelectedValue));
                }
                else
                {
                    rvException.LocalReport.SetParameters(new ReportParameter("Year", ""));
                }

                ReportDataSource rprtDTSource = new ReportDataSource("PenaltyLoan", dt);
                rvException.LocalReport.DataSources.Add(rprtDTSource);
                rvException.LocalReport.Refresh();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExceptionReport.aspx");
        }

        protected void dsPenaltyLoan_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            var query = from s in db.PenaltyLoans select s;
            e.Result = query;
        }
    }
}