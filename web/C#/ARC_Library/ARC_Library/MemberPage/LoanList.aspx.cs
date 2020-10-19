using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.MemberPage
{
    public partial class LoanList : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                bindGrid();
            }
        }
        protected void bindGrid()
        {
            string username = HttpContext.Current.User.Identity.Name;
            
            BookCount c = BookCount.createBookCount();
            
                var q = from s in db.Loans
                        orderby s.ReturnDate descending
                        orderby s.Status=="NotReturned" descending
                        where s.MemberId == c.memberId
                        select new
                        {
                            s.LoanId,
                            s.BorrowDate,
                            s.ReturnDate,
                            s.BookId,
                            s.Book.Title,
                            status = s.Status == "Returned" ? "Returned" : (s.ReturnDate < DateTime.Now ? "Overdue" : "Not Returned")
                        };

                gvLoan.DataSource = q;
                gvLoan.DataBind();
                int row = gvLoan.Rows.Count;
                for (int i = 0; i < row; i++)
                {
                    if (gvLoan.Rows[i].Cells[5].Text == "Overdue")
                    {
                        gvLoan.Rows[i].ForeColor = Color.Red;
                    }
                }
                lblCount.Text = "Current borrowed book : " + c.noBookBorrowed;
            }
       
        protected void gvLoan_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLoan.PageIndex = e.NewPageIndex;
            bindGrid();
        }
    }
    }
