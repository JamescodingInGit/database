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
    public partial class Operator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Dashboard.aspx";
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void SaveOperator_Click1(object sender, EventArgs e)
        {
            try
            {
                if (operatorLogoImage.HasFile)
                {
                    HttpPostedFile postedFile = operatorLogoImage.PostedFile;
                    byte[] fileBytes = new byte[postedFile.InputStream.Length];
                    postedFile.InputStream.Read(fileBytes, 0, fileBytes.Length);

                    string operatorName = txtOperatorName.Text;
                    string operatorDescription = txtOperatorDescription.Text;

                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        conn.Open();
                        string sqlQuery = "INSERT INTO Operator (operatorName, operatorDescription, operatorLogo) VALUES (@OperatorName, @OperatorDescription, @OperatorLogo)";
                        using (SqlCommand command = new SqlCommand(sqlQuery, conn))
                        {

                            command.Parameters.Add("@OperatorName", SqlDbType.VarChar, 50).Value = operatorName;
                            command.Parameters.Add("@OperatorDescription", SqlDbType.VarChar, 100).Value = operatorDescription;
                            command.Parameters.Add("@OperatorLogo", SqlDbType.VarBinary, -1).Value = fileBytes;

                            command.ExecuteNonQuery();
                            txtOperatorName.Text = string.Empty;
                            txtOperatorDescription.Text = string.Empty;
                            GridView1.DataBind();


                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                int operatorID = Convert.ToInt32(drpDownOperatorID.SelectedValue);
                byte[] imageData = FileUpload1.FileBytes;
                UpdateOperatorImage(operatorID, imageData);

            }
        }


        private void UpdateOperatorImage(int operatorID, byte[] imageData)
        {

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("UPDATE Operator SET operatorLogo = @ImageData WHERE operatorID = @OperatorID", connection))
                {
                    command.Parameters.AddWithValue("@ImageData", imageData);
                    command.Parameters.AddWithValue("@OperatorID", operatorID);
                    command.ExecuteNonQuery();
                    GridView1.DataBind();

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

        protected void DropDownList8_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DropDownList8.SelectedValue == "1")
            {
                SqlDataSource8.SelectCommand = "SELECT * FROM [Operator] ORDER BY [operatorName] ASC;";

            }
            else if (DropDownList8.SelectedValue == "2")
            {
                SqlDataSource8.SelectCommand = "SELECT * FROM [Operator] ORDER BY [operatorName] DESC;";

            }
            else
            {
                SqlDataSource8.SelectCommand = "SELECT * FROM [Operator];";
            }
            GridView1.DataSourceID = "SqlDataSource8";
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

                SqlDataSource8.SelectParameters.Clear();
                SqlDataSource8.SelectCommand = "SELECT * FROM [Operator] where ([operatorName] = @operatorName)";
                SqlDataSource8.SelectParameters.Add("operatorName", txtSearch.Text);
                GridView1.DataSourceID = "SqlDataSource8";
                GridView1.DataBind();

        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOperator" && e.CommandArgument != null)
            {
                try
                {
                    int operatorID = Convert.ToInt32(e.CommandArgument);

                    string updateQuery = "Update Operator SET isDeleted = @delete WHERE operatorID = @ID";

                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        SqlCommand command = new SqlCommand(updateQuery, connection);
                        // Add parameters and their values to the SqlCommand
                        command.Parameters.AddWithValue("@delete", 1);
                        command.Parameters.AddWithValue("@ID", operatorID);
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        connection.Close();
                    }
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Deleted Successful !.');", true);
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex + "')</script>");
                }
            }
        }

        protected void btnUpdateSchedule_Click(object sender, EventArgs e)
        {

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

        }
    }
}