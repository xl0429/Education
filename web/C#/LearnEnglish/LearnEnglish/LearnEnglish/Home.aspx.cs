using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearnEnglish
{

    public partial class Home : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {

            var q = (from s in db.GrammarTypes
                     orderby s.Rating descending
                     select new { GrammarCode = s.GrammarCode, s.Title, s.Description}
                     ).Take(3);

     
            List<HyperLink> hlList = new List<HyperLink>();
            hlList.Add(hlTop1);
            hlList.Add(hlTop2);
            hlList.Add(hlTop3);

            List<Label> lblList = new List<Label>();
            lblList.Add(lblDesc1);
            lblList.Add(lblDesc2);
            lblList.Add(lblDesc3);

            int index = 0;
            foreach (var n in q)
            {
                hlList[index].NavigateUrl = "~/GrammarDetail.aspx?GrammarCode=" + n.GrammarCode;
                hlList[index].Text = n.Title;
                lblList[index].Text = n.Description.Substring(0,150)+ " ......";
                index++;
            }

           
        }
    }
}