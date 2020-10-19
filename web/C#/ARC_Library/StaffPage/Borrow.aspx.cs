using ARC_Library.MemberPage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class Borrow : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        string userId = helper.GetCurrentId();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtBookId.Focus();
            if (!Page.IsPostBack)
            {
                if (userId == null)
                {
                    Page.Response.Redirect("~/Account/Log.aspx?log=Login");
                }
            }
        }

       
        protected void btnBorrow_Click(object sender, EventArgs e)
        {
            Page.Validate("vgBorrow");

            string bookId = txtBookId.Text.ToUpper();
            string memberId = txtMemberId.Text.ToUpper();
            //check reservation is not expired and belong to the input member id
            Reservation re = db.Reservations.SingleOrDefault(s => s.BookId == bookId && s.MemberId == memberId && s.ReserveDueDate > DateTime.Now);
            if (re != null)
            {
                cvBookStatus.IsValid = true;
                db.Reservations.DeleteOnSubmit(re);
                db.SubmitChanges();
            }
           

            if (Page.IsValid)
            {
                BookCount mem = BookCount.createBookCount();

                string id = userId;
                string value = db.Loans.OrderByDescending(p => p.LoanId).Select(r => r.LoanId).First().ToString();
                int returnDays = (from s in db.Books join x in db.Categories on s.CategoryId equals x.CategoryId
                                  where s.BookId == bookId
                                  select x.ReturnDays).SingleOrDefault();
                //insert loan details
                Loan l = new Loan
                {
                    LoanId = helper.generateId(value),
                    BorrowDate = DateTime.Now.Date,
                    ReturnDate = DateTime.Now.AddDays(returnDays).Date,
                    StaffId = id,
                    MemberId = memberId,
                    BookId = bookId,
                    Status = "NotReturned"
                };
                db.Loans.InsertOnSubmit(l);

                //update book status
                Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
                if (b != null)
                {
                    b.Status = "Borrowed";

                }
                db.SubmitChanges();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Loan done.');window.location ='Borrow.aspx';", true);
            }

        }

        protected void txtBookId_TextChanged(object sender, EventArgs e)
        {
            //check book status
            string bookId = txtBookId.Text.ToUpper();
            string memberId = txtMemberId.Text.ToUpper();
            dvBooks.Visible = false;
            string status = db.Books.Where(s => s.BookId == bookId).Select(x => x.Status).SingleOrDefault();
            if (status == "Available")
            {
                //book available
                var q = from s in db.Books
                        where s.BookId == bookId
                        select new
                        {
                            s.Title,
                            s.Author,
                            s.Publisher,
                            s.Image,
                            s.Category.CategoryName
                        };
                if (q.Any())
                {
                    dvBooks.Visible = true;
                    dvBooks.DataSource = q;
                    dvBooks.DataBind();
                }
                txtMemberId.Focus();
            }
 
        }

        protected void btnCopy_Click(object sender, EventArgs e)
        {
            string id = db.Members.Where(x => x.Username.ToLower() == txtUsername.Text.ToLower()).Select(r=>r.MemberId).SingleOrDefault();
            if(id != null)
            {
                txtMemberId.Text = id;
                divMember.Visible = false;
                txtMemberId.Focus();
            }
            else
            {
                cvNoUsername.IsValid = false;
                txtUsername.Focus();

            }
        }

        protected void cvOverDue_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //check member id has overdue return book
            string id = args.Value.ToUpper();
            string memberWithLoan = db.Loans.Where(l => l.MemberId == id && l.Status == "NotReturned" && DateTime.Now > Convert.ToDateTime(l.ReturnDate).AddDays(15)).Select(x => x.MemberId).Take(1).SingleOrDefault();

            //update member account status to blocked
            Member m = db.Members.SingleOrDefault(x => x.MemberId == memberWithLoan);
            if (m != null && m.Status != "Blocked")
            {
                m.Status = "Blocked";
                db.SubmitChanges();
                args.IsValid = false;

            }

        }

        protected void cvAccBlocked_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            //check member acc status
            string id = args.Value;
            string status = db.Users.Where(s => s.Id == id).Select(x => x.Status).SingleOrDefault();
            if (status == "Blocked")
            {
                args.IsValid = false;
            }
        }

        protected void cvExistMember_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string id = args.Value;
            User m = db.Users.SingleOrDefault(x => x.Id == id);
            if(m == null){
                args.IsValid = false;
            }    
        }

        protected void btnCheck_ServerClick(object sender, EventArgs e)
        {
            if(divMember.Visible == false)
            {
                txtUsername.Focus();
            }
            else
            {
                txtMemberId.Focus();
            }
            divMember.Visible = divMember.Visible == false ? true : false;

        }

        protected void cvMaxBookCheck_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string memberId = args.Value;
            BookCount b = BookCount.createBookCount(memberId);
            int totalBook = b.totalBook;

            if (totalBook >= Global.MAX_BOOK_COUNT)
            {
                args.IsValid = false;
            }
        }

        protected void cvBookStatus_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string memberId = txtMemberId.Text.ToUpper();
            string bookId = args.Value.ToUpper();
            string status = db.Books.Where(s => s.BookId == bookId).Select(x => x.Status).SingleOrDefault();

            if (status == "Reserved")
            {
                //check the latest book reservation is expired then update book to available
                Reservation reExipired = db.Reservations.Where(s => s.BookId == bookId && s.ReserveDueDate < DateTime.Now).OrderByDescending(x=>x.ReserveDueDate).Take(1).SingleOrDefault();
                if (reExipired != null)
                {
                    Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
                    b.Status = "Available";
                    db.SubmitChanges();
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else if (status == "Borrowed")
            {
                cvBookStatus.ErrorMessage = "[Book Id] is borrowed";
                args.IsValid = false;
            }
            else if (status == "Repaired")
            {
                cvBookStatus.ErrorMessage = "[Book Id] is repaired";
                args.IsValid = false;

            }
            else if (status == null || status =="Deleted")
            {
                cvBookFound.IsValid = false;
                txtBookId.Focus();

                dvBooks.Visible = false;
            }

           
        }

       
    }
}