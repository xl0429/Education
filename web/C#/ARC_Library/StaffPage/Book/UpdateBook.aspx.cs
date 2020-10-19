using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static ARC_Library.helper;

namespace ARC_Library
{
    public partial class UpdateBook : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) { 
                ddlCategory.DataSource = db.Categories;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();

                string id = Request.QueryString["BookId"];

                Book b = db.Books.SingleOrDefault(x => x.BookId == id);
                if (b != null)
                {
                    title.InnerHtml = "Update - " + b.Title;

                    lblBookId.Text = b.BookId;
                    txtRegisterDate.Text = b.RegisterDate.ToShortDateString();
                    txtIsbn2.Text = b.ISBN;
                    ddlCategory.SelectedValue = b.CategoryId;
                    txtTitle.Text = b.Title;
                    txtAuthor2.Text = b.Author;
                    ddlStatus.SelectedValue = b.Status;
                    txtPublisher2.Text = b.Publisher;
                    txtPublishYear.Text = b.PublishYear.ToString();
                    imgpreview.Src = "~/img/Books/" + b.Image + ".jpg";

                }
                else
                {
                    Response.Redirect("Book.aspx");
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Page.Response.Redirect("Book.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["BookId"];
            string url = "UpdateBook.aspx?BookId=" + id;
            Server.Transfer(url);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Book b = db.Books.SingleOrDefault(x => x.BookId == lblBookId.Text);
                DateTime registerDate;
                registerDate = Convert.ToDateTime(txtRegisterDate.Text);
               
                if (b != null)
                {
                    //Update photo

                    if (fuImage.HasFile  )
                    {
                        string path = MapPath("~/img/Books/");
                        string filename = b.Image;
                        if (b.Image != null) { 
                            // Delete existing photo if has file 
                            File.Delete(path + filename);
                        }

                        filename = Guid.NewGuid().ToString("N");
                        SimpleImage img = new SimpleImage(fuImage.FileContent);
                        img.Square();
                        img.Resize(200);
                        img.SaveAs(path + filename + ".jpg");
                        b.Image = filename;


                    }
                    b.RegisterDate = registerDate;
                    b.ISBN = txtIsbn2.Text;
                    b.CategoryId = ddlCategory.SelectedValue;
                    b.Title = txtTitle.Text;
                    b.Author = txtAuthor2.Text;
                    b.Publisher = txtPublisher2.Text;
                    b.PublishYear = int.Parse(txtPublishYear.Text);

                    db.SubmitChanges();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfully update');window.location ='Book.aspx';", true);

                }
                else
                {
                    Response.Redirect("Book.aspx");
                }
            }
        }
    }
}