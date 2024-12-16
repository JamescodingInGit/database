using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace Assignment
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Profile.aspx";
            if (!IsPostBack)
            {
                if (Session["role"] != null)
                {
                    int userId = Convert.ToInt32(Session["userid"]);
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
                            txtEmail.Text = email.ToString();
                            txtFName.Text = firstName.ToString();
                            txtLName.Text = lastName.ToString();
                            txtCNum.Text = contactNumber.ToString();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('" + ex + "')</script>");
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (check(txtEmail.Text) != 1)
            {
                // Continue with the update
                String emailU = txtEmail.Text;
                String fNameU = txtFName.Text;
                String lNameU = txtLName.Text;
                String cNumU = txtCNum.Text;
                // Get user ID from session
                int userId = Convert.ToInt32(Session["userid"]);

                // Connection string
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // SQL update query
                string queryEdit = "Update [User] Set email = @email, firstName = @firstName, lastName = @lastName, contactNumber = @contactNumber WHERE [userID] = @userID";

                // Create SqlConnection and SqlCommand
                using (SqlConnection conn = new SqlConnection(strCon))
                using (SqlCommand cmdEdit = new SqlCommand(queryEdit, conn))
                {
                    cmdEdit.Parameters.AddWithValue("@userID", userId);
                    cmdEdit.Parameters.AddWithValue("@email", emailU);
                    cmdEdit.Parameters.AddWithValue("@firstName", fNameU);
                    cmdEdit.Parameters.AddWithValue("@lastName", lNameU);
                    cmdEdit.Parameters.AddWithValue("@contactNumber", cNumU);

                    try
                    {
                        // Open the connection
                        conn.Open();
                        // Execute the update query
                        cmdEdit.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions, log, or display an error message
                        Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                    }
                    conn.Close();
                }
            }
            else
            {
                Response.Write("<script>alert('This Email already Registered!!!')</script>");
            }
        }

        int check(string TxtEmail)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();
            string query = "SELECT COUNT(*) FROM [User] WHERE email = @Email";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", TxtEmail);
            int c = (int)cmd.ExecuteScalar();
            conn.Close();
            return c;
        }
    }
}