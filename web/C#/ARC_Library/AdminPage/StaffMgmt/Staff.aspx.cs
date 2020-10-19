using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.AdminPage.Staff
{
    public partial class Staff : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                BindGridView();

            }
        }
        protected void BindGridView()
        {
            banner.Visible = false;

            if (Session["bannerText"] != null)
            {
                var text = Session["bannerText"].ToString();
                banner.InnerHtml = text;
                banner.Visible = true;

            }
            Session["bannerText"] = null;

            ViewState["GridPageIndex"] = "0";
            string textSearch = txtSearch.Text;
            var q = from s in db.Staffs
                    orderby s.StaffId descending
                    select new
                    {
                        s.StaffId,
                        s.Username,
                        s.Hash,
                        s.Email,
                        s.ContactNo
                    };
            if (textSearch != "")
            {
                q = q.Where(x => x.Username.Contains(textSearch));
            }

            Label1.Visible = q.Any() ? false : true;

            gvStaff.DataSource = q;
            gvStaff.DataBind();
        }

        protected void imgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Server.Transfer("Staff.aspx");
        }

        protected void gvStaff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStaff.EditIndex = e.NewEditIndex;
            BindGridView();
            int index = gvStaff.EditIndex;
            DropDownList d = (DropDownList)gvStaff.Rows[index].Cells[5].FindControl("ddlReturnDays");
            for (int i = 1; i <= 10; i++)
            {
                d.Items.Add(i.ToString());
            }
            string returnDay = ((HiddenField)gvStaff.Rows[index].Cells[5].FindControl("hfReturnDays")).Value;
            d.SelectedValue = returnDay;

            TextBox tb = (TextBox)gvStaff.Rows[e.NewEditIndex].Cells[1].FindControl("txtCatName");
            tb.Focus();

        }

        protected void gvStaff_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStaff.PageIndex = e.NewPageIndex;
            ViewState["GridPageIndex"] = e.NewPageIndex;
            gvStaff.EditIndex = -1;

            BindGridView();
        }

        protected void gvStaff_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string cID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            string cName = db.Categories.Where(x => x.CategoryId == cID).Select(y => y.CategoryName).SingleOrDefault();
            /**/
            Category c = db.Categories.SingleOrDefault(x => x.CategoryId == cID);
            db.Categories.DeleteOnSubmit(c);

            var book = db.Books.Where(x => x.CategoryId == cID);
            foreach (var b in book)
            {
                b.CategoryId = null;
            }

            db.SubmitChanges();
            Session["bannerText"] = "<b>" + cName + "</b>" + " is successfully deleted";
            Page.Response.Redirect("Staff.aspx");
        }

        protected void gvStaff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            gvStaff.EditIndex = -1;
            string cID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = gvStaff.Rows[e.RowIndex];
            int rowIndexByPage = row.DataItemIndex % gvStaff.PageSize;
            string txt_catname = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[1].FindControl("txtCatName")).Text;
            string txt_remark = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[2].FindControl("txtRemark")).Text;
            string txt_abbreviation = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[3].FindControl("txtAbbreviation")).Text;
            decimal txt_PenaltyRate = decimal.Parse(((TextBox)gvStaff.Rows[rowIndexByPage].Cells[4].FindControl("txtPenaltyRate")).Text);
            int txt_ReturnDays = int.Parse((((DropDownList)gvStaff.Rows[rowIndexByPage].Cells[5].FindControl("ddlReturnDays")).SelectedValue));

            Category c = db.Categories.SingleOrDefault(x => x.CategoryId == cID);
            if (c != null)
            {
                c.CategoryName = txt_catname;
                c.Remark = txt_remark;
                c.Abbreviation = txt_abbreviation.ToUpper();
                c.PenaltyRate = txt_PenaltyRate;
                c.ReturnDays = txt_ReturnDays;

                db.SubmitChanges();

                Session["bannerText"] = "<b>" + txt_catname + "</b>" + " is successfully updated";
                Page.Response.Redirect("Staff.aspx");
            }

        }

        protected void gvStaff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

            gvStaff.EditIndex = -1;
            int index = gvStaff.EditIndex;
            string cID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            string cName = db.Categories.Where(x => x.CategoryId == cID).Select(y => y.CategoryName).SingleOrDefault();

            Session["bannerText"] = "Editing for <b>" + cName + "</b> is cancelled";
            Page.Response.Redirect("Staff.aspx");
        }

        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ADD")
            {
                Page.Validate("vsInsert");
                if (Page.IsValid)
                {
                    string txtCatName = ((TextBox)gvStaff.HeaderRow.Cells[1].FindControl("txt_CatName")).Text;
                    string txtRemark = ((TextBox)gvStaff.HeaderRow.Cells[2].FindControl("txt_Remark")).Text;
                    string txtAbbreviation = ((TextBox)gvStaff.HeaderRow.Cells[3].FindControl("txt_Abbreviation")).Text;
                    decimal txtPenaltyRate = decimal.Parse(((TextBox)gvStaff.HeaderRow.Cells[4].FindControl("txt_PenaltyRate")).Text);
                    int txtReturnDays = int.Parse((((DropDownList)gvStaff.HeaderRow.Cells[5].FindControl("ddl_ReturnDays")).SelectedValue));
                    AddNewRecord(txtCatName, txtRemark, txtAbbreviation, txtPenaltyRate, txtReturnDays);
                }
            }
        }

        private void AddNewRecord(string name, string remark, string abbreviation, decimal penaltyRate, int returndays)
        {//insert to db
            string value = db.Staffs.OrderByDescending(p => p.StaffId)
                          .Select(r => r.StaffId).First().ToString();
            string id = helper.generateId(value);

            Staff s = new Staff
            {
             /*   StaffId = id,
                CategoryName = name,
                Remark = remark,
                Abbreviation = abbreviation.ToUpper(),
                PenaltyRate = penaltyRate,
                ReturnDays = returndays*/
            };
            db.Staffs.InsertOnSubmit(s);
            db.SubmitChanges();
            Session["bannerText"] = "<b>" + name + "</b>" + " is successfully inserted";
            Page.Response.Redirect("Staff.aspx");
        }

        protected void gvStaff_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox tb = (TextBox)e.Row.FindControl("txtCatName");
                string theScript = "document.getElementById('" + tb.ClientID + "').focus();";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "onload", "window.onload = function() { " + theScript + " }", true);
            }
            if (e.Row.RowType == DataControlRowType.Header)
            {
                DropDownList d = (DropDownList)e.Row.FindControl("ddl_ReturnDays");
                for (int i = 1; i <= 10; i++)
                {
                    d.Items.Add(i.ToString());
                }
                d.SelectedValue = "3";
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindGridView();
        }

        protected void cvUserNameExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string username = args.Value;

            if (db.Staffs.Any(s => s.Username == username))
            {
                args.IsValid = false;
            }
        }

    }
}