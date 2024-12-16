using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                int userId = Convert.ToInt32(Session["userid"]);
                //int userId = 6;
                SqlConnection conn;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                conn = new SqlConnection(strCon);

                //connect sql, using the session id (user id) 
                string query = "SELECT [email], [firstName], [lastName], [contactNumber] FROM [User] WHERE [userID] = @userID";
                SqlCommand cmdSelect = new SqlCommand(query, conn);
                // Add parameter for user ID
                cmdSelect.Parameters.AddWithValue("@userID", userId);
                try
                {
                    conn.Open();
                    SqlDataReader user = cmdSelect.ExecuteReader();
                    // Check if there are rows returned
                    if (user.HasRows)
                    {
                        // Read the first row
                        user.Read();

                        // Get the data from the column
                        string email = user["email"].ToString();
                        string firstName = user["firstName"].ToString();
                        string lastName = user["lastName"].ToString();
                        string contactNumber = user["contactNumber"].ToString();
                        lblEmail.Text = email.ToString();
                        lblFName.Text = firstName.ToString();
                        lblLName.Text = lastName.ToString();
                        lblCNum.Text = contactNumber.ToString();

                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions, log, or display an error message
                    Response.Write("<script>alert('" + ex + "')</script>");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
            
        }
    }
}