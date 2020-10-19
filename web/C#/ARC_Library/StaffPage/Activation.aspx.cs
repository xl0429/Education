using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.StaffPage
{
    public partial class Activation : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        string userId = helper.GetCurrentId();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (userId == null)
                {
                    Page.Response.Redirect("~/Account/Log.aspx?log=Login");
                }
            }
        }

        protected void btnActivate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string memberId = hfMemberId.Value.ToUpper();
                var q = from l in db.Loans
                        where l.MemberId.ToUpper() == memberId && Convert.ToDateTime(l.ReturnDate).AddDays(15) < DateTime.Now && l.Status.Contains("NotReturned")
                        select new
                        {
                            l.LoanId,
                            l.BookId,
                            l.Book.Title,
                            penaltyRate =l.Book.Category.PenaltyRate,
                            l.ReturnDate,
                            l.BorrowDate,
                            OverdueDays = (DateTime.Now - l.ReturnDate).Days > 15 ? (DateTime.Now - l.ReturnDate).Days + "(15)" : (DateTime.Now - l.ReturnDate).Days +"",
                            Price =((DateTime.Now - l.ReturnDate).Days > 15 ? 15 : (DateTime.Now - l.ReturnDate).Days ) * l.Book.Category.PenaltyRate,

                        };
                if (q.Any())
                {
                    divPenalty.Style.Add("display", "block"); 

                    gvPenalty.DataSource = q;
                   
                    gvPenalty.DataBind();
                    
                    if (q.Count() > 1)
                    {
                        double total = 0;
                        int index = gvPenalty.Columns.Count - 1;
                        for (int i = 0; i < gvPenalty.Rows.Count; i++)
                        {
                            total += double.Parse(gvPenalty.Rows[i].Cells[7].Text);
                        }
                        lblPrice.Text = total+"";
                    }

                }
                else
                {
                    divPenalty.Visible = true;
                    Member m = db.Members.SingleOrDefault(x=> x.MemberId == memberId);
                    if(m!= null)
                    {
                        m.Status = "Active";
                        db.SubmitChanges();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Overdue not found. Account reactive succesfully');window.location ='Activation.aspx';", true);
                    }
                }

            }
        }

      
      

        protected void cvMemberExist_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            string username = args.Value.ToUpper();
            Member m = db.Members.SingleOrDefault(s => s.MemberId == username || s.Email == username);
            if (m == null)
            {
                //check is not member
                args.IsValid = false;
            }
            else
            {
                if(m.Status != "Blocked")
                {
                    //check member status
                    cvMemberBlocked.IsValid = false;
                }
                else
                {
                    hfMemberId.Value = m.MemberId;
                }
            }
        }

        protected void btnPenaltyPaid_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string memberId = hfMemberId.Value;
                decimal penaltyPaidAmount = chkException.Checked == true ? 0 : decimal.Parse(lblPrice.Text); // check penalty exception
                string value = db.Penalties.OrderByDescending(x => x.PenaltyId).Select(r => r.PenaltyId).First().ToString();
                string id = helper.generateId(value);
                //insert penalty
                Penalty p = new Penalty
                {
                    PenaltyId = id,
                    Price = decimal.Parse(lblPrice.Text),
                    PayAmount = penaltyPaidAmount,
                    PayDate = DateTime.Now,
                    LoanId = null,
                    StaffId = userId
                };
                db.Penalties.InsertOnSubmit(p);

                //update all books and loan status
                var loan = db.Loans.Where(x => x.MemberId == memberId && x.Status == "NotReturned" && Convert.ToDateTime(x.ReturnDate).AddDays(15) < DateTime.Now);
                List<string> lst = new List<string>();

                foreach (var l in loan)
                {
                    lst.Add(l.BookId);
                    l.Status = "Returned";
                }
                List<ARC_Library.Book> lstBook = new List<ARC_Library.Book>();
                foreach (string bId in lst)
                {
                    lstBook.Add(db.Books.Where(x => x.BookId == bId).SingleOrDefault());
                }
                foreach (ARC_Library.Book b in lstBook)
                {
                    b.Status = "Available";
                }

                //update user status
                Member m = db.Members.SingleOrDefault(x=>x.MemberId == memberId);
                if (m != null)
                {
                    m.Status = "Active";
                }
         
                  
                db.SubmitChanges();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Account reactive succesfully');window.location ='Activation.aspx';", true);
            }
        }

        
    }
}