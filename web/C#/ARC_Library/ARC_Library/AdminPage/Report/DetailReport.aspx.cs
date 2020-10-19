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
    public partial class DetailReport : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var datasource = from x in db.Categories
                                 select new
                                 {
                                     x.CategoryId,
                                     x.CategoryName,
                                     DisplayField = String.Format("{0} - {1}", x.CategoryId, x.CategoryName)
                                 };
                ddlFilter.DataSource = datasource;
                ddlFilter.DataTextField = "DisplayField";
                ddlFilter.DataValueField = "CategoryId";
                ddlFilter.DataBind();

                var query = from s in db.Books orderby s.RegisterDate descending select s;

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
            IEnumerable<BookCategory> query;
            if (year == "0")
            {
                //no year, has filter
                if (filter != "0")
                {
                    query = from p in db.BookCategories
                            where p.CategoryId.Contains(filter)
                            orderby p.RegisterDate descending
                            select p;
                }
                else
                {
                    //no year, no filter
                    query = from p in db.BookCategories orderby p.RegisterDate descending select p;
                }
            }
            else
            {
                //has filter,has year
                query = from p in db.BookCategories
                        where p.CategoryId == filter
                          && p.RegisterDate.ToString().Contains(year)
                        orderby p.RegisterDate descending
                        select p;
            }
            reportBind(query);
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            string filter = ddlFilter.SelectedValue.ToString();
            string year = ddlYear.SelectedValue.ToString();
            IEnumerable<BookCategory> query;
            if (filter == "0")
            {
                //no filter, has year
                if (year != "0")
                {
                    query = from p in db.BookCategories
                            where p.RegisterDate.ToString().Contains(year)
                            orderby p.RegisterDate descending
                            select p;
                }
                else
                {
                    //no filter, no year
                    query = from p in db.BookCategories orderby p.RegisterDate descending select p;
                }
            }
            else
            {
                //has filter, has year
                query = from p in db.BookCategories
                        where p.CategoryId == filter
                        && p.RegisterDate.ToString().Contains(year)
                        orderby p.RegisterDate descending
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
                DataTable dt = helper.LINQResultToDataTable(q);

                if (ddlFilter.SelectedValue != "0")
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("CategoryId", "of " + ddlFilter.SelectedItem));
                }
                else
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("CategoryId", ""));
                }

                if (ddlYear.SelectedValue != "0")
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("Year", "in " + ddlYear.SelectedValue));
                }
                else
                {
                    rvDetail.LocalReport.SetParameters(new ReportParameter("Year", ""));
                }

                ReportDataSource rprtDTSource = new ReportDataSource("BookCategory", dt);
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
            var query = from s in db.BookCategories orderby s.RegisterDate descending select s;
            e.Result = query;
        
        }
       
    }
}