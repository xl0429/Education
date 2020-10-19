using ARC_Library.MemberPage;
using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class BookList : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) { 
                ddlCategory.DataSource = db.Categories;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();

                if(Request.QueryString["q"] != null)
                {
                    txtSearch.Text = Request.QueryString["q"];
                }
                
                bindGrid();
                Session["showBanner"] = "false";
            }
        }
        protected void bindGrid()
        {
            if (Session["showBanner"].ToString() == "true")
            {
                banner.Visible = true;
                banner.InnerHtml = "Reservation done check in<b> <a href='MemberPage/ReservationList.aspx'>Reservation List</a></b>";
            }

            string category = ddlCategory.SelectedValue;
            string textSearch = txtSearch.Text;
            //query shown on page load
            var query = from s in db.Books
                        where s.Status != "Deleted"
                        orderby s.RegisterDate descending
                        orderby s.Status =="Available" descending
                        
                        select new {
                            s.Image,
                            s.BookId,
                            s.Title,
                            s.Author,
                            s.Publisher,
                            s.Status,
                            s.CategoryId,
                            Category = s.Category.CategoryName  
                        };

            if (category == "0")
            {
                if (txtSearch.Text == "")
                {
                    // no selected category, no user input for search
                }
                else
                {
                    //no selected category, user input for search
                    query = query.Where(s => s.Status != "Deleted" &&(s.Title.Contains(textSearch) || s.Author.Contains(textSearch) || s.Publisher.Contains(textSearch)));
                }
            }
            else
            {
                if (txtSearch.Text != "")
                {
                    //category selected, user input for search
                    query = query.Where(s => s.Status != "Deleted" &&((s.Title.Contains(textSearch) || s.Author.Contains(textSearch) || s.Publisher.Contains(textSearch)))
                    && (s.CategoryId == ddlCategory.SelectedValue));
                }
                else
                {
                    //category selected, no user input for search
                    query = query.Where(x => x.CategoryId == category && x.Status != "Deleted");
                }
            }
            gvBook.DataSource = query;
            gvBook.DataBind();
            lblFound.Text = query.Any() ? "" : "No record found";
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindGrid();
            gvBook.PageIndex = 0;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("BookList.aspx");
        }

        protected void gvBook_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBook.PageIndex = e.NewPageIndex;
            bindGrid();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            bindGrid();
            gvBook.PageIndex = 0;
        }

        protected void gvBook_Load(object sender, EventArgs e)
        {
            if (!User.IsInRole("User_Member"))
            {
                gvBook.Columns[gvBook.Columns.Count - 2].Visible = false;
                gvBook.Columns[gvBook.Columns.Count - 1].Visible = true;
            }
        }

        protected void gvBook_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow) //btnReserve if book status is available 
            {
                string lblStatus = ((Label)e.Row.FindControl("Status")).Text;
                if (lblStatus != "Available")
                {
                    LinkButton btn = (LinkButton)e.Row.FindControl("btnReserve");
                    btn.Enabled = false;
                    btn.Text = lblStatus;
                    btn.ForeColor = System.Drawing.Color.LightGray;

                }
            }
        }

        protected void gvBook_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Reserve")
            {
                BookCount mem = BookCount.createBookCount();
                int totalBook = mem.totalBook;

                if (totalBook < Global.MAX_BOOK_COUNT)
                {
                    GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                    int RowIndex = row.RowIndex;

                    if (Page.IsValid)
                    {
                        string value = db.Reservations.OrderByDescending(p => p.ReservationId)
                                  .Select(re => re.ReservationId).First().ToString();
                        string id = helper.generateId(value);
                        string bookId = ((Label)gvBook.Rows[RowIndex].Cells[0].FindControl("lblBookId")).Text;


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
                        }
                        Session["showBanner"] = "true";

                        Page.Response.Redirect("BookList.aspx");
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