using ARC_Library.MemberPage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class ReservationList : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        BookCount c = BookCount.createBookCount();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                bindGrid();
                Session["showBanner"] = "false";
            }
        }
       
        protected void gvReservation_Load(object sender, EventArgs e)
        {

        }

        protected void bindGrid()
        {
            if (Session["showBanner"].ToString() == "true")
            {
                banner.Visible = true;
                banner.InnerHtml = "<b>" + Session["bookTitle"] + " is removed from reservation </b>";
            }

            string uName = HttpContext.Current.User.Identity.Name;
            var query = (from s in db.Members where s.Username == uName select new { s.MemberId }).SingleOrDefault();
            string memberID = query.MemberId;
            if (memberID != null)
            {
                var q = from r in db.Reservations
                        join b in db.Books on r.BookId equals b.BookId
                        where r.MemberId == memberID
                        orderby r.ReserveDate descending
                        select new
                        {
                            r.ReservationId,
                            ReserveDate = r.ReserveDate.ToShortDateString(),
                            ReserveTime = r.ReserveDate.ToShortTimeString(),
                            r.MemberId,
                            b.BookId,
                            b.Title,
                            b.Author,
                            Status = (r.ReserveDueDate > DateTime.Now ? "Pending" : "Expired"),
                        };
                if (!q.Any())
                {
                    Label1.Text = "You reserve no book.";
                }
                gvReservation.DataSource = q;
                gvReservation.DataBind();
                lblCount.Text = "Total reserving book : " + c.noBookReserved;
    
            }
            else
            {
                Label1.Text = "You reserve no book.";
            }
           
        }

        protected void gvReservation_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string lblstatus = e.Row.Cells[6].Text;
                if (lblstatus == "Pending")
                {
                    gvReservation.Columns[7].Visible = true;
                    ((Button)e.Row.FindControl("btnCancel")).Visible = true;
                }
               
            }
        }
        
        protected void gvReservation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string bTitle = gvReservation.Rows[e.RowIndex].Cells[4].Text;
            string bID = gvReservation.Rows[e.RowIndex].Cells[3].Text;
            string rID = gvReservation.Rows[e.RowIndex].Cells[0].Text;

            //remove reservation
            Reservation r = db.Reservations.SingleOrDefault(x => x.ReservationId == rID);
            if (r != null)
            {
                db.Reservations.DeleteOnSubmit(r);
                db.SubmitChanges();
                
                //update book status -> available
                Book b = db.Books.SingleOrDefault(x => x.BookId == bID);
                if (b != null)
                {
                    b.Status = "Available";
                    db.SubmitChanges();
                }
             

                if (gvReservation.Rows[0].Cells[6].Text != "Pending" && gvReservation!=null)
                {
                    gvReservation.Columns[7].Visible = false;
                }
                Session["showBanner"] = "true";
                Session["bookTitle"] = bTitle;
                
                bindGrid();
               
                Page.Response.Redirect("ReservationList.aspx");
                
            }
            else
            {
                Session["showBanner"] = "false";
            }

        }

        protected void gvReservation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvReservation.PageIndex = e.NewPageIndex;
            bindGrid();
        }
      
    }
}