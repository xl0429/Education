using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static ARC_Library.helper;

namespace ARC_Library
{
    public partial class InsertBook : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int min = DateTime.Now.AddYears(-100).Year;
                int max = DateTime.Now.Year;
                RangeValidatorYear.MinimumValue = min.ToString();
                RangeValidatorYear.MaximumValue = max.ToString();
                RangeValidatorYear.ErrorMessage = string.Format("[Publish Year] is between <br/> {0} and {1}", min, max);

                string value = db.Books.OrderByDescending(p => p.BookId)
                          .Select(r => r.BookId).First().ToString();
                string id = generateId(value);
                lblBookId.Text = id;

                lblRegisterDate.Text = DateTime.Now.Date.ToShortDateString();
                ddlCategory.DataSource = db.Categories;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();

                for (int i = 1; i <= 10; i++)
                {
                    ddlQuantity.Items.Add(i.ToString());
                }
                ddlQuantity.SelectedValue = "1";

            }
            //find list item in ddl to add tiltle
            foreach (Category f in db.Categories)
            {
                ddlCategory.Items.FindByValue(f.CategoryId).Attributes.Add("title", f.Remark);
            }
        }

        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            int ddlQuantityValue = int.Parse(ddlQuantity.SelectedValue);
            string currentID = lblBookId.Text.Substring(0, 6);

            if (ddlQuantityValue > 1)
            {
                int value = int.Parse(currentID.Substring(1, currentID.Length - 1)) + ddlQuantityValue;
                string largestID = "B" + value.ToString().PadLeft(5, '0');
                lblBookId.Text = currentID + "-" + largestID;
            }
            else
            {
                lblBookId.Text = currentID;
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string filename = null;
                if (fuImage.HasFile==true)
                {
                    // Save photo
                    string path = MapPath("~/img/Books/");
                    filename = Guid.NewGuid().ToString("N");

                    SimpleImage img = new SimpleImage(fuImage.FileContent);
                    img.Square();
                    img.Resize(200);
                    img.SaveAs(path + filename + ".jpg");
                }
               
                DateTime registerDate;
                registerDate = Convert.ToDateTime(lblRegisterDate.Text);

                string value = db.Books.OrderByDescending(p => p.BookId)
                          .Select(r => r.BookId).First().ToString();
                string id = generateId(value);

                string currentId = id;
                string newID = "";
                for (int i=0; i < int.Parse(ddlQuantity.SelectedValue); i++)
                {
                        if (i != 0)
                        {   
                            currentId = newID;
                        }
                        Book b = new Book
                        {
                            BookId = currentId,
                            ISBN = txtISBN.Text,
                            Title = txtTile.Text,
                            Author = txtAuthor.Text,
                            Price = decimal.Parse(txtPrice.Text),
                            Publisher = txtPublisher.Text,
                            PublishYear = int.Parse(txtPublishYear.Text),
                            RegisterDate = registerDate,
                            Image = filename,
                            Status = "Available",
                            CategoryId = ddlCategory.SelectedValue,
                        };
                        newID = generateId(currentId); //update bookID
                        db.Books.InsertOnSubmit(b);
                        db.SubmitChanges();
                    }
                    
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('You have successfully insert');window.location ='Book.aspx';", true);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer("InsertBook.aspx");
        }
    }
}