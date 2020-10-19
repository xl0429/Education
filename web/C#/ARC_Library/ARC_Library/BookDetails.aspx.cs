using ARC_Library.MemberPage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class BookDetails1 : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {  
            if (!Page.IsPostBack)
            {
                string bookId = Request.QueryString["BookId"];
                if(bookId == null)
                {
                    Page.Response.Redirect("Home.aspx");
                }
                else
                {
                    if (User.IsInRole("User_Member"))
                    {
                        btnReserve.Visible = true;
                    }
                    var q = (from b in db.Books
                             where b.BookId == bookId  && b.Status != "Deleted"
                             select b.Title).SingleOrDefault();
                    if (q.Any())
                    {
                        title.InnerText = q;
                        h3.InnerText = q;

                        var qu = (from b in db.Books
                                  where b.BookId == bookId 
                                  select b.Status).SingleOrDefault();

                        if (qu != "Available" && qu != "Deleted")
                        {
                            btnReserve.Enabled = false;
                            btnReserve.Text = qu;
                        }
                    }
                    

                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("Home.aspx");
        }

        protected void dvBookDetails_DataBound(object sender, EventArgs e)
        {
            if (dvBookDetails.DataItemCount == 0)
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnReserve_Click(object sender, EventArgs e)
        {    
            if (Page.IsValid)
            {
                BookCount mem = BookCount.createBookCount();
                if (mem.totalBook < Global.MAX_BOOK_COUNT) { 
                    string value = db.Reservations.OrderByDescending(p => p.ReservationId)
                              .Select(re => re.ReservationId).First().ToString();
                    string id = helper.generateId(value);
                    string bookId = Request.QueryString["BookId"];

                    string uID = mem.memberId;
                    //insert reservation                
                    Reservation r = new Reservation
                    {
                        ReservationId = id,
                        ReserveDate = DateTime.Now,
                        ReserveDueDate = DateTime.Now.AddDays(1),
                        MemberId = uID,
                        BookId = bookId
                    };
                    db.Reservations.InsertOnSubmit(r);
                    db.SubmitChanges();

                    //update book status
                    Book b = db.Books.SingleOrDefault(x => x.BookId == bookId);
                    if (b != null)
                    {
                        b.Status = "Reserved";
                        db.SubmitChanges();
                        Page.Response.Redirect("~/MemberPage/ReservationList.aspx");
                    }
                }
                else
                {
                    System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Reserve is not allowed, number of borrowed and reserved book > 5');", true);
                }
            }
        }

      
    }
}