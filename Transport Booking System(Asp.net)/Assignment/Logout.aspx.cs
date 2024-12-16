using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            string link = (string)Session["link"];
            if (link == null)
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                Response.Redirect(link);
            }
        }
    }
}