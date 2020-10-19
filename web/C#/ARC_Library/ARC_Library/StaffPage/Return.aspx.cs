using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class Return : System.Web.UI.Page
    {
        string userId = helper.GetCurrentId();
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Page.IsPostBack)
            {
                if (userId == null)
                {
                    Page.Response.Redirect("~/Account/Log.aspx?log=Login");
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
        }

        protected void bindGrid(string uNameId)
        {
            string id = db.Users.Where(u => u.Username == uNameId || u.Id == uNameId).Select(x => x.Id).SingleOrDefault();
            if(id != null)
            {
                var q = (from s in db.Loans
                        where s.MemberId == id
                        where  s.Status=="NotReturned"
                        orderby s.ReturnDate descending
                        select new
                        {
                            s.LoanId,
                            s.BorrowDate,
                            s.ReturnDate,
                            s.BookId,
                            bTitle = s.Book.Title,
                            status = s.ReturnDate < DateTime.Now ? "Overdue":"Not Returned"
                        });
                
                cvNoMember.IsValid = q.Any() ? true : false;
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

            }
            else
            {
                cvNoUsername.IsValid = false;
            }
           
        }
       

        protected void btnCheck_Click(object sender, EventArgs e)
        {
            divMember.Visible = divMember.Visible == false ? true : false;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            bindGrid(txtUnameId.Text);
        }

        protected void btnPenaltyPaid_Click(object sender, EventArgs e)
        {
            //insert penalty information
            string bookId = txtBookId.Text;
            decimal penaltyPaidAmount = chkException.Checked == true ? 0 : Decimal.Parse(lblPrice.Text); // check penalty exception
            Penalty p = new Penalty
            {
                PenaltyId = lblPenaltyId.Text,
                Price = decimal.Parse(lblPrice.Text),
                PayAmount = penaltyPaidAmount,
                PayDate = DateTime.Now,
                LoanId = lblLoanId.Text,
                StaffId = userId
            };
            db.Penalties.InsertOnSubmit(p);

            //update loan and book status
            Loan l = db.Loans.SingleOrDefault(x => x.LoanId == lblLoanId.Text);
            Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
            if (l != null & b != null)
            {
                l.Status = "Returned";
                b.Status = "Available";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Return sucessfully');window.location ='Borrow.aspx';", true);
            }

            db.SubmitChanges();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Return sucessfully');window.location ='Borrow.aspx';", true);
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string bookId = txtBookId.Text.ToUpper();
                //get loan id where overdue
                string loanId = (db.Loans.Where(l => l.BookId == bookId && l.ReturnDate < DateTime.Now && l.Status.Contains("NotReturned")).OrderByDescending(x=>x.ReturnDate).Select(s => s.LoanId)).Take(1).SingleOrDefault();
                if(loanId !=null)
                {
                    //has overdue loan
                    //generate penalty id
                    string value = db.Penalties.OrderByDescending(p => p.PenaltyId).Select(r => r.PenaltyId).First().ToString();
                    lblPenaltyId.Text = helper.generateId(value);
                    //get loan details
                    Loan lo = db.Loans.SingleOrDefault(x => x.LoanId == loanId);
                    if (lo != null)
                    {
                        lblLoanId.Text = lo.LoanId;
                        lblBookTitle.Text = lo.Book.Title;
                        lblReturnDate.Text = lo.ReturnDate.ToShortDateString();
                        int overdueDays = (DateTime.Now - lo.ReturnDate).Days;
                        lblOverdueDays.Text = overdueDays.ToString();
                        if(overdueDays > 15) // cap the maximum overduedays less than 15
                        {
                            lblOverdueDays.Text += " (15)";
                            overdueDays = 15;
                        }
                        lblPenaltyRate.Text = "RM "+ lo.Book.Category.PenaltyRate.ToString();
                        lblPrice.Text = (overdueDays * lo.Book.Category.PenaltyRate).ToString();
                      
                        divPenalty.Visible = true;
                        btnPenaltyPaid.Focus();
                    }           
                }
                else
                {
                    //loan is no overdue
                    //update book and loan status
                    string lId = (db.Loans.Where(ll => ll.BookId == bookId && ll.ReturnDate >= DateTime.Now && ll.Status.Contains("NotReturned")).OrderByDescending(x => x.ReturnDate).Select(s => s.LoanId)).Take(1).SingleOrDefault();
                    Loan l = db.Loans.SingleOrDefault(x => x.LoanId == lId);
                    Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
                    if (l != null & b != null)
                    {
                        l.Status = "Returned";
                        b.Status = "Available";
                        db.SubmitChanges();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Return sucessfully');window.location ='Borrow.aspx';", true);
                    }
                    
                }
            }
        }

        protected void cvLoanFound_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //check loan exist
            string bookId = args.Value;
            string loanId = db.Loans.Where(lo => lo.BookId == bookId && lo.Status == "NotReturned").OrderByDescending(s => s.ReturnDate).Select(x => x.LoanId).Take(1).SingleOrDefault();
            if(loanId == null)
            {
                args.IsValid = false;
            }
        }

        protected void cvBookFound_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //check book exist
            string bookId = args.Value;
            Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
            if(b == null)
            {
                args.IsValid = false;
            }
        }
    }
}