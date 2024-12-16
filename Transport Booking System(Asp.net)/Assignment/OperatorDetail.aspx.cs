using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class OperatorDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["operatorID"]))
                {
                    Response.Redirect("Home.aspx");
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
    }
}