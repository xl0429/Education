using ARC_Library.Account;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.AdminPage
{
    public partial class StaffMgmt : System.Web.UI.Page
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

        

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            Server.Transfer("StaffMgmt.aspx");
        }

        protected void gvStaff_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStaff.EditIndex = e.NewEditIndex;
            BindGridView();
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
            string sID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            string uName = db.Staffs.Where(x => x.StaffId == sID).Select(y => y.Username).SingleOrDefault();
            Staff s = db.Staffs.SingleOrDefault(x => x.StaffId == sID);
            db.Staffs.DeleteOnSubmit(s);

            /*Staff deleted all relevant staff id replace by admin2*/
            var loan = db.Loans.Where(x => x.StaffId == sID);
            foreach (var l in loan)
            {
               l.StaffId = "A0002";
            }

            db.SubmitChanges();
            Session["bannerText"] = "<b>" + uName + "</b>" + " is successfully deleted";
            Page.Response.Redirect("StaffMgmt.aspx");
        }

        protected void gvStaff_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            gvStaff.EditIndex = -1;
            string uID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = gvStaff.Rows[e.RowIndex];
            int rowIndexByPage = row.DataItemIndex % gvStaff.PageSize;
            string txtUsername = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[1].FindControl("txtUsername")).Text;
            string txtPassword = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[2].FindControl("txtPassword")).Text;
            string txtEmail = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[3].FindControl("txtEmail")).Text;
            string txtContactNo  = ((TextBox)gvStaff.Rows[rowIndexByPage].Cells[4].FindControl("txtContactNo")).Text;
            Staff c = db.Staffs.SingleOrDefault(x => x.StaffId == uID);
            if (c != null)
            {
                c.Username = txtUsername;
                c.Hash = Security.GetHash(txtPassword);
                c.Email = txtEmail;
                c.ContactNo = txtContactNo;

                db.SubmitChanges();

                Session["bannerText"] = "<b>" + txtUsername + "</b>" + " is successfully updated";
                Page.Response.Redirect("StaffMgmt.aspx");
            }

        }

        protected void gvStaff_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStaff.EditIndex = -1;
            int index = gvStaff.EditIndex;
            string cID = gvStaff.DataKeys[e.RowIndex].Value.ToString();
            string uName = db.Staffs.Where(x => x.StaffId == cID).Select(y => y.Username).SingleOrDefault();

            Session["bannerText"] = "Editing for <b>" + uName + "</b> is cancelled";
            Page.Response.Redirect("StaffMgmt.aspx");
        }

        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ADD")
            {
                Page.Validate("vsInsert");
                if (Page.IsValid)
                {
                    string txtUsername = ((TextBox)gvStaff.HeaderRow.Cells[1].FindControl("txt_Username")).Text;
                    string txtPassword = ((TextBox)gvStaff.HeaderRow.Cells[2].FindControl("txt_Password")).Text;
                    string txtEmail = ((TextBox)gvStaff.HeaderRow.Cells[3].FindControl("txt_Email")).Text;
                    string txtContactNo = ((TextBox)gvStaff.HeaderRow.Cells[4].FindControl("txt_ContactNo")).Text;
                    AddNewRecord(txtUsername, txtPassword, txtEmail,  txtContactNo);
                }
            }
        }

        private void AddNewRecord(string uName, string password, string email, string contactNo)
        {//insert to db
            string value = db.Staffs.OrderByDescending(p => p.StaffId)
                          .Select(r => r.StaffId).First().ToString();
            string id = helper.generateId(value);

            Staff s = new Staff
            {
                StaffId = id,
                Username = uName,
                Hash = Security.GetHash(password),
                Email = email,
                ContactNo = contactNo
            };
            db.Staffs.InsertOnSubmit(s);
            db.SubmitChanges();
            Session["bannerText"] = "<b>" + uName + "</b>" + " is successfully inserted";
            Page.Response.Redirect("StaffMgmt.aspx");
        }

        protected void gvStaff_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                TextBox tb = (TextBox)e.Row.FindControl("txtUsername");
                string theScript = "document.getElementById('" + tb.ClientID + "').focus();";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "onload", "window.onload = function() { " + theScript + " }", true);
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