using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.StaffPage
{
    public partial class StaffLoanList : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (!(User.IsInRole("User_Admin") || User.IsInRole("User_Staff"))){ 
                    Page.Response.Redirect("~/Account/Log.aspx");
                }
                else { 
                    bindGrid();
                }
            }

        }
        protected void gvBook_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLoan.PageIndex = e.NewPageIndex;
            bindGrid();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            bindGrid();
            gvLoan.PageIndex = 0;
        }

        protected void bindGrid()
        {
            string str = txtSearch.Text;
            var q = from s in db.Loans
                    orderby s.ReturnDate < DateTime.Now
                    select new
                    {
                        s.LoanId,
                        s.MemberId,
                        sName = s.Staff.Username,
                        s.ReturnDate,
                        s.BorrowDate,
                        bTitle=s.Book.Title,
                        lStatus = s.Status == "Returned" ? "Returned" :(s.ReturnDate < DateTime.Now ? "Overdue" : "Not Returned"),
                        s.BookId
                    };
            if (txtSearch.Text != null)
            {
                q = q.Where(s=> s.MemberId.Contains(str)|| s.BookId.Contains(str) || s.sName.Contains(str) || s.bTitle.Contains(str) || s.lStatus.Contains(str)|| s.BookId.Contains(str));
            }
            if (!q.Any())
            {
                divButton.Style.Add("display","block");
            }
            else
   
            gvLoan.DataSource = q;
            gvLoan.DataBind();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Server.Transfer("StaffLoanList.aspx");
        }
    }
}