using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Promotion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Dashboard.aspx";
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void promotionRow(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.originalColor=this.style.backgroundColor;this.style.backgroundColor='#f0cead';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor=this.originalColor;";
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
                return "Image/operator1.png";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                int promotionID = Convert.ToInt32(dropDownPromotionID.SelectedValue);
                byte[] imageData = FileUpload1.FileBytes;
                UpdateOperatorImage(promotionID, imageData);

            }
        }

        private void UpdateOperatorImage(int promotionID, byte[] imageData)
        {

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Promotion SET promotionImage = @ImageData WHERE promotionID = @PromotionID", connection))
                {
                    command.Parameters.AddWithValue("@ImageData", imageData);
                    command.Parameters.AddWithValue("@PromotionID", promotionID); // Assuming you have a promotionID variable
                    command.ExecuteNonQuery();
                    GridView3.DataBind();
                }
            }

        }

        protected void AddPromo_Click(object sender, EventArgs e)
        {
            try
            {
                string promotionTitle = txtPromotionTitle.Text;
                string promotionDescription = txtPromotionDescription.Text;
                string discountText = txtDiscount.Text;
                DateTime promotionStartDate = DateTime.Parse(txtDateFrom.Text);
                DateTime promotionEndDate = DateTime.Parse(txtDateTo.Text);
                float discount = float.Parse(discountText);


                byte[] imageData = promotionImage.FileBytes;


                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("INSERT INTO Promotion (promotionTitle, promotionDescription, discount, promotionImage, promotionStartDate, promotionEndDate) VALUES (@PromotionTitle, @PromotionDescription, @Discount, @ImageData,@promotionStartDate, @promotionEndDate);", connection))
                    {
                        command.Parameters.AddWithValue("@PromotionTitle", promotionTitle);
                        command.Parameters.AddWithValue("@PromotionDescription", promotionDescription);
                        command.Parameters.AddWithValue("@Discount", discount);
                        command.Parameters.AddWithValue("@ImageData", imageData);
                        command.Parameters.AddWithValue("@promotionStartDate", promotionStartDate);
                        command.Parameters.AddWithValue("@promotionEndDate", promotionEndDate);
                        command.ExecuteNonQuery();


                    }
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Added Successful !.');", true);

                GridView3.DataBind();


                txtPromotionTitle.Text = string.Empty;
                txtPromotionDescription.Text = string.Empty;
                txtDiscount.Text = string.Empty;
                lblModalError.Text = string.Empty;

            }
            catch (Exception ex)
            {

            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Promotion Title")
            {

                SqlDataSource7.SelectParameters.Clear();
                SqlDataSource7.SelectCommand = "SELECT * FROM [Promotion] where ([promotionTitle] = @promotionTitle)";
                SqlDataSource7.SelectParameters.Add("promotionTitle", txtSearch.Text);
                GridView3.DataSourceID = "SqlDataSource7";
                GridView3.DataBind();

            }
        }

        protected void DropDownList6_SelectedIndexChanged(object sender, EventArgs e)
        {


            if (DropDownList6.SelectedValue == "1")
            {
                SqlDataSource7.SelectCommand = "SELECT * FROM [Promotion] ORDER BY [promotionTitle] ASC;";

            }
            else if (DropDownList6.SelectedValue == "2")
            {
                SqlDataSource7.SelectCommand = "SELECT * FROM [Promotion] ORDER BY [promotionTitle] DESC;";
            }
            else
            {
                SqlDataSource7.SelectCommand = "SELECT * FROM [Promotion];";

            }
            GridView3.DataSourceID = "SqlDataSource7";
            GridView3.DataBind();
        }
    }
}