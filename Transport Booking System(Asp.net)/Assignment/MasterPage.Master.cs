using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                DropDownHeader.NavigateUrl = "profile.aspx";
                DropDownHeader.Text = (string)Session["username"];
                loginLink.Visible = false;
                registerLink.Visible = false;
                logoutLink.Visible = true;
                if (Session["role"].ToString() == "Admin"|| Session["role"].ToString() == "Staff"|| Session["role"].ToString() == "Manager")
                {
                    adminLink.Visible = true;
                }
            }
        }
    }
}