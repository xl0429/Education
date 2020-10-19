using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class BookDetails : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["BookId"] == null)
            {
                Page.Response.Redirect("Book.aspx");
            }
            else
            {
                var q = from s in db.Books
                        where s.BookId == Request.QueryString["BookId"] && s.Status != "Deleted"
                        select new
                        {
                            s.BookId,
                            Category= s.Category.CategoryName ?? "-",
                            s.Author,
                            s.Title,
                            s.Price,
                            s.RegisterDate,
                            s.Status,
                            s.Publisher,
                            s.PublishYear,
                            s.ISBN,
                            s.Image

                        };
               
                if (q.Any())
                {
                    dvBooks.DataSource = q;
                    dvBooks.DataBind();
                }
                else
                {
                    Response.Redirect("Book.aspx");
                }
                
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("UpdateBook.aspx?BookId=" + Request.QueryString["BookId"]);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("DeleteBook.aspx?BookId=" + Request.QueryString["BookId"]);

        }

       
    }
}