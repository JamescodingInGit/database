using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Assignment
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Home.aspx";
            if (!IsPostBack)
            {

                string transport = Request.QueryString["transport"];
                txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtDateTo.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                txtDateFrom.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                txtDateTo.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                if (transport == null)
                {
                    transportView.ActiveViewIndex = 0;
                    Session["homeSearchUrl"] = "Bus.aspx";
                }
                else
                {
                    if (transport == "bus")
                    {
                        transportView.ActiveViewIndex = 0;
                        Session["homeSearchUrl"] = "Bus.aspx";
                    }
                    else if (transport == "train")
                    {
                        transportView.ActiveViewIndex = 1;
                        Session["homeSearchUrl"] = "Train.aspx";
                    }
                    else if (transport == "ferry")
                    {
                        transportView.ActiveViewIndex = 2;
                        Session["homeSearchUrl"] = "Ferry.aspx";
                    }
                }
            }

        }

        protected string GetImageFromDataBase(object imageData)
        {
            if (imageData != DBNull.Value)
            {
                byte[] bytes = (byte[])imageData;
                string base64String = Convert.ToBase64String(bytes);
                return "data:image/png;base64," + base64String;
            }
            else
            {
                return "Image/no-photo.png";
            }
        }

        protected void rblTrip_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblTrip.SelectedIndex == 0)
            {
                txtDateTo.Visible = false;
                returnText.Visible = false;
                rblTrip.SelectedIndex = 0;
            }
            else if (rblTrip.SelectedIndex == 1)
            {
                txtDateTo.Visible = true;
                returnText.Visible = true;
                rblTrip.SelectedIndex = 1;
            }
        }

        protected void bttSearch_Click(object sender, EventArgs e)
        {
            if (txtFrom.Text == "" || txtTo.Text == "")
            {
                lblMessage.Text = "Please enter depart location and desination!!!";
            }
            else
            {
                string url = (string)Session["homeSearchUrl"];
                Response.Redirect(url + "?trip=" + Server.UrlEncode(rblTrip.Text) + "&from=" + Server.UrlEncode(txtFrom.Text) + "&to=" + Server.UrlEncode(txtTo.Text) + "&fromDate=" + Server.UrlEncode(txtDateFrom.Text) + "&toDate=" + Server.UrlEncode(txtDateTo.Text));
            }

        }

    }
}