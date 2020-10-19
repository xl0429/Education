using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ARC_Library.MemberPage
{
    public partial class ChangeProfile : System.Web.UI.Page
    {
        ARCLibraryDataContext db = new ARCLibraryDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string username = HttpContext.Current.User.Identity.Name;
                Member m = db.Members.SingleOrDefault(x => x.Username == username);

                if (m != null)
                {
                    lblMemberId2.Text = m.MemberId;
                    lblUsername2.Text = username;
                    txtEmail.Text = m.Email;
                    txtContactNo.Text = m.ContactNo;
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
        }
        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //check similar username
            string username = args.Value;

            if (db.Members.Any(s => s.Username == username))
            {
                args.IsValid = false;
            }
        }

        protected void CustomValidator3_ServerValidate1(object source, ServerValidateEventArgs args)
        {
            //check similar email
            string email = args.Value;

            if (db.Members.Any(s => s.Email == email))
            {
                args.IsValid = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = lblUsername2.Text;
                string email = txtEmail.Text;
                string contactNo = txtContactNo.Text;

                Member m = db.Members.SingleOrDefault(x => x.Username == username);

                if (m != null)
                {
                    m.Email = email;
                    m.ContactNo = contactNo;

                    db.SubmitChanges();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your account is updated sucessfully');window.location ='../Home.aspx';", true);
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Server.Transfer("ChangeProfile.aspx");
        }

      
    }
}