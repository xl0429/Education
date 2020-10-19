using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library
{
    public partial class DeleteBook : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString["BookId"];

            Book b = db.Books.Where(s=>s.Status!="Deleted").SingleOrDefault(x => x.BookId == id);
            if (b != null)
            {
                title.InnerHtml = "Delete - " + b.Title;

                lblBookId.Text = b.BookId;
                lblRegisterDate.Text = b.RegisterDate.ToShortDateString();
                lblISBN.Text = b.ISBN;
                lblCategory.Text = b.CategoryId + "-" +b.Category.CategoryName;
                lblTitle.Text = b.Title;
                lblAuthor.Text = b.Author;
                lblPublisher.Text = b.Publisher;
                lblPublisYear.Text = b.PublishYear.ToString();
                img.ImageUrl = "../../img/Books/" + b.Image+".jpg" ;
                lblPrice.Text = b.Price.ToString();
            }
            else
            {
                Response.Redirect("Book.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("Book.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string id = lblBookId.Text;
            Book b = db.Books.SingleOrDefault(x => x.BookId == id);
            if (b != null)
            {
                int count = db.Books.Count(x => x.Title == b.Title);

                string path = MapPath("~/img/Books/");
                string filename = b.Image;
                
                if (File.Exists(path + filename + ".jpg") && count == 1)
                {
                     File.Delete(path + filename+ ".jpg");
                }
                
                


                //update book staus
                b.Status = "Deleted";
                db.SubmitChanges();

            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfully deleted');window.location ='Book.aspx';", true);

        }
    }
}