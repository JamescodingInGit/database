using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                Repeater1.DataSource = SqlDataSource1;
                Repeater1.DataBind();
            }
            

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (txtFormDt.Text == "" || txtToDt.Text == "")
            {
                lbltest.Text = "Please enter from date and to date";
            }
            else
            {
                Repeater1.DataSource = SqlDataSource2;
                Repeater1.DataBind();
            }
        }
    }
}