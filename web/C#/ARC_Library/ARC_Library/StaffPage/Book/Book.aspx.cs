using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.StaffPage.Book
{
    public partial class Book : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected void imgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void gvBook_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowType == DataControlRowType.DataRow))
            {
                string QueryString = DataBinder.Eval(e.Row.DataItem, "BookId").ToString();
                string NavigateURL = ResolveUrl(("~/StaffPage/Book/BookDetails.aspx?BookId=" + QueryString));
                e.Row.Attributes.Add("onClick", string.Format("javascript:window.location=\'{0}\';", NavigateURL));
                e.Row.Style.Add("cursor", "pointer");
            }
        }

        protected void bindGrid()
        {
            string str = "";

            string search = txtSearch.Text.Trim();

            if (search != null)
            {
                str = "(Title.Contains(\"" + search + "\")" + " || Author.Contains(\"" + search + "\") ||BookId.Contains(\"" + search + "\") || " + "Publisher.Contains(\"" + search + "\")) && Status!=\"" + "Deleted\"";
                if (chkCategory.Checked == true)
                {
                    str = "(Title.Contains(\"" + search + "\")" + " || Author.Contains(\"" + search + "\") ||BookId.Contains(\"" + search + "\") || " + "Publisher.Contains(\"" + search + "\")) && Status!=\"" + "Deleted\" &&CategoryId == null";
                }

                dsBook.Where = str;
            }
            else
            {
                dsBook.Where = "";
            }
           
            gvBook.DataBind();

            if(gvBook.Rows.Count == 0)
            {
                lblFound.Text = "No book is found";
            }
            else
            {
                lblFound.Text = "";
            }

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            bindGrid();
        }

       

        protected void gvBook_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBook.PageIndex = e.NewPageIndex;
            bindGrid();
        }

        protected void Back_Click(object sender, EventArgs e)
        {
            Server.Transfer("Book.aspx");
        }

        protected void dsBook_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
      
        }

       
        protected void chkCategory_CheckedChanged(object sender, EventArgs e)
        {
            bindGrid();
            
           

        }
    }
}