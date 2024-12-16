using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Dashboard.aspx";
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                if (Session["role"].ToString() != "Manager")
                {
                    GridView2.Columns[6].Visible = false;
                    DropDownList1.Items[2].Enabled = false;
                }

                DropDownList4.DataSourceID = "SqlDataSource9";
                DropDownList4.DataBind();
                DropDownList4.Items.Insert(0, new ListItem("-- Select --", string.Empty));
                DropDownList5.DataSourceID = "SqlDataSource10";
                DropDownList5.DataBind();
                DropDownList5.Items.Insert(0, new ListItem("-- Select --", string.Empty));

            }
            else
            {
                // Clear the values of the textboxes
                txtEmail.Text = "";
                txtContactNumber.Text = "";
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtICNo.Text = "";

                // Optionally, clear the Calendar control if applicable
                clHireDate.SelectedDates.Clear();

            }



            ScriptManager.GetCurrent(this.Page).RegisterPostBackControl(SaveUser);

        }

        protected void customerRow(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.originalColor=this.style.backgroundColor;this.style.backgroundColor='#f0cead';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor=this.originalColor;";
            }
        }

        protected void staffRow(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.originalColor=this.style.backgroundColor;this.style.backgroundColor='#f0cead';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor=this.originalColor;";
            }
        }

        protected void adminRow(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.originalColor=this.style.backgroundColor;this.style.backgroundColor='#f0cead';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor=this.originalColor;";
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (DropDownList1.SelectedValue == "Customer")
            {

                MultiView1.ActiveViewIndex = 0;
                DropDownList3.Items.Remove("IC No");

            }
            else if (DropDownList1.SelectedValue == "Staff")
            {
                MultiView1.ActiveViewIndex = 1;
               
                if (!ItemExists("IC No"))
                {
                    DropDownList3.Items.Add("IC No");
                 

                }

            }
            else if (DropDownList1.SelectedValue == "Manager")
            {
                MultiView1.ActiveViewIndex = 2;
                if (!ItemExists("IC No"))
                {
                    DropDownList3.Items.Add("IC No");
                 
                }
            }

        }

        protected void DropDownList4_SelectedIndexChanged(object sender, EventArgs e)
        {

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                string selectQuery = "";
                string id = "";
                if (DropDownList1.SelectedValue == "Manager")
                {
                    selectQuery = "SELECT * FROM [dbo].[TempAdmin] WHERE [tempAdminId] = @ID";
                    id = DropDownList5.SelectedValue;

                }
                else if (DropDownList1.SelectedValue == "Staff")
                {
                    selectQuery = "SELECT * FROM [dbo].[TempStaff] WHERE [tempStaffId] = @ID";
                    id = DropDownList4.SelectedValue;
                   
                }

                using (SqlCommand cmd = new SqlCommand(selectQuery, connection))
                {
                  
                    cmd.Parameters.AddWithValue("@ID", id);

                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        if(DropDownList1.SelectedValue == "Manager")
                        {
                            txtEmail.Text = reader["emailAdmin"].ToString();
                            txtContactNumber.Text = reader["contactNumberAdmin"].ToString();
                            txtFirstName.Text = reader["firstNameAdmin"].ToString();
                            txtLastName.Text = reader["lastNameAdmin"].ToString();
                            txtICNo.Text = reader["icNoAdmin"].ToString();
                        }
                        else if(DropDownList1.SelectedValue == "Staff")
                        {
                            txtEmail.Text = reader["emailStaff"].ToString();
                            txtContactNumber.Text = reader["contactNumberStaff"].ToString();
                            txtFirstName.Text = reader["firstNameStaff"].ToString();
                            txtLastName.Text = reader["lastNameStaff"].ToString();
                            txtICNo.Text = reader["icNoStaff"].ToString();

                            DateTime hireDate = Convert.ToDateTime(reader["hireDateStaff"]);
                            clHireDate.SelectedDate = hireDate;
                        }


                    }

                    reader.Close();
                }
            }
        }

        protected bool ItemExists(string text)
        {
            foreach (ListItem item in DropDownList3.Items)
            {
                if (item.Text == text)
                {
                    return true;
                }
            }
            return false;
        }

        protected byte[] ComputeHash(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
              
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);

                return sha256.ComputeHash(inputBytes);
            }
        }

        protected void SaveUser_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(DropDownList1.SelectedValue) ||
                string.IsNullOrEmpty(DropDownList4.SelectedValue) ||
           string.IsNullOrEmpty(txtEmail.Text) ||
           string.IsNullOrEmpty(txtContactNumber.Text) ||
           string.IsNullOrEmpty(txtFirstName.Text) ||
           string.IsNullOrEmpty(txtLastName.Text) ||
           (DropDownList1.SelectedValue == "Manager" && string.IsNullOrEmpty(txtICNo.Text)) ||
           (DropDownList1.SelectedValue == "Staff" && (string.IsNullOrEmpty(txtICNo.Text) || !IsValidDate(clHireDate.SelectedDate.ToShortDateString()))))
            {

                // Handle validation failure, show an error message, or return false
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill in all required fields.');", true);

                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    using (SqlCommand selectUserCommand = new SqlCommand("SELECT * FROM [User]", conn))
                    {
                        string newUserName = txtLastName.Text.TrimEnd() + " " + txtFirstName.Text.TrimEnd();
                        string existedUserName ="";
                        SqlDataReader reader = selectUserCommand.ExecuteReader();

                            while (reader.Read())
                            {
                                existedUserName = reader["username"].ToString();

                                if(existedUserName == newUserName)
                                {
                                      ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('The User is existed, Please Add Again!.');", true);
                                      return;
                                }
                            }

                            reader.Close();

               


                            using (SqlCommand insertUserCommand = new SqlCommand("INSERT INTO [User] ([role], [username], [password], [email], [contactNumber], [firstName], [lastName]) VALUES (@role, @username, @password, @email, @contactNumber, @firstName, @lastName); SELECT SCOPE_IDENTITY();", conn))
                            {
                                insertUserCommand.Parameters.AddWithValue("@role", DropDownList1.SelectedValue);
                                insertUserCommand.Parameters.AddWithValue("@username", txtLastName.Text.TrimEnd() + " " + txtFirstName.Text.TrimEnd());
                                insertUserCommand.Parameters.AddWithValue("@password", ComputeHash(txtICNo.Text));
                                insertUserCommand.Parameters.AddWithValue("@email", txtEmail.Text);
                                insertUserCommand.Parameters.AddWithValue("@contactNumber", txtContactNumber.Text);
                                insertUserCommand.Parameters.AddWithValue("@firstName", txtFirstName.Text);
                                insertUserCommand.Parameters.AddWithValue("@lastName", txtLastName.Text);


                                int userId = Convert.ToInt32(insertUserCommand.ExecuteScalar());


                                if (DropDownList1.SelectedValue == "Manager")
                                {
                                    using (SqlCommand insertAdminCommand = new SqlCommand("INSERT INTO [Admin] ([admin_IC], [userID]) VALUES (@adminIC, @userID)", conn))
                                    {

                                        insertAdminCommand.Parameters.AddWithValue("@adminIC", txtICNo.Text);
                                        insertAdminCommand.Parameters.AddWithValue("@userID", userId);

                                        insertAdminCommand.ExecuteNonQuery();


                                    }
                                }
                                else if (DropDownList1.SelectedValue == "Staff")
                                {
                                    using (SqlCommand insertStaffCommand = new SqlCommand("INSERT INTO [Staff] ([staff_IC], [hireDate], [userID]) VALUES (@staffIC, @hireDate, @userID)", conn))
                                    {

                                        insertStaffCommand.Parameters.AddWithValue("@staffIC", txtICNo.Text);
                                        insertStaffCommand.Parameters.AddWithValue("@hireDate", clHireDate.SelectedDate.ToShortDateString());
                                        insertStaffCommand.Parameters.AddWithValue("@userID", userId);

                                        insertStaffCommand.ExecuteNonQuery();


                                    }
                                }

                                txtEmail.Text = "";
                                txtContactNumber.Text = "";
                                txtFirstName.Text = "";
                                txtLastName.Text = "";
                                txtICNo.Text = "";
                                clHireDate.SelectedDate = DateTime.MinValue;
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Added Successful !.');", true);
                            }
                  
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
                finally
                {
                    conn.Close();
                }
              
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();

            }
        }

        private bool IsValidDate(string date)
        {
            DateTime hireDate;
            return DateTime.TryParse(date, out hireDate);
        }


        protected void AddButton_Click(object sender, EventArgs e)
        {
            txtEmail.Text = "";
            txtContactNumber.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtICNo.Text = "";
            clHireDate.SelectedDate = DateTime.MinValue;
        }


        protected void DropDownList2_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Customer")
            {
                SqlDataSource2.SelectParameters.Clear();
                if (DropDownList2.SelectedValue == "1")
                {
                    SqlDataSource2.SelectCommand = "SELECT [userID] as User_ID, CONCAT([lastName], ' ' , [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM[User] WHERE([role] = @role) ORDER BY Full_Name ASC;";

                }
                else if (DropDownList2.SelectedValue == "2")
                {
                    SqlDataSource2.SelectCommand = "SELECT [userID] as User_ID, CONCAT([lastName], ' ' , [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM[User] WHERE([role] = @role) ORDER BY Full_Name DESC;";

                }
                else
                {
                    SqlDataSource2.SelectCommand = "SELECT [userID] as User_ID, CONCAT([lastName], ' ' , [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM[User] WHERE([role] = @role);";

                }
                SqlDataSource2.SelectParameters.Add("role", DropDownList1.SelectedValue);
                GridView1.DataSourceID = "SqlDataSource2";
                GridView1.DataBind();
            }
            else if (DropDownList1.SelectedValue == "Manager")
            {
                SqlDataSource7.SelectParameters.Clear();
                if (DropDownList2.SelectedValue == "1")
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID ORDER BY Full_Name ASC;";

                }
                else if (DropDownList2.SelectedValue == "2")
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID ORDER BY Full_Name DESC;";

                }
                else
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID;";
                }
                GridView2.DataSourceID = "SqlDataSource7";
                GridView2.DataBind();
            }
            else if (DropDownList1.SelectedValue == "Staff")
            {
                SqlDataSource7.SelectParameters.Clear();
                if (DropDownList2.SelectedValue == "1")
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID] ORDER BY Full_Name ASC;";

                }
                else if (DropDownList2.SelectedValue == "2")
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID] ORDER BY Full_Name DESC;";

                }
                else
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID];";

                }
                GridView2.DataSourceID = "SqlDataSource7";
                GridView2.DataBind();
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Customer" && (DropDownList3.SelectedValue == "Full Name" || DropDownList3.SelectedValue == "Email"))
            {
                SqlDataSource2.SelectParameters.Clear();
                if (DropDownList3.SelectedValue == "Full Name")
                {
                    SqlDataSource2.SelectCommand = "SELECT [userID] as User_ID, CONCAT([lastName], ' ', [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM [User] WHERE ([role] = @role) AND (CONCAT([lastName], ' ', [firstName]) = @fullname)";

                }
                else if (DropDownList3.SelectedValue == "Email")
                {
                    SqlDataSource2.SelectCommand = "SELECT [userID] as User_ID, CONCAT([lastName], ' ', [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM [User] WHERE ([role] = @role) AND ([email] = @email)";

                }
                SqlDataSource2.SelectParameters.Add("role", DropDownList1.SelectedValue);
                SqlDataSource2.SelectParameters.Add("fullname", txtSearch.Text);
                SqlDataSource2.SelectParameters.Add("email", txtSearch.Text);
                GridView1.DataSourceID = "SqlDataSource2";
                GridView1.DataBind();

            }
            else if (DropDownList1.SelectedValue == "Staff" && (DropDownList3.SelectedValue == "Full Name" || DropDownList3.SelectedValue == "Email" || DropDownList3.SelectedValue == "IC No"))
            {
                SqlDataSource7.SelectParameters.Clear();
                if (DropDownList3.SelectedValue == "Full Name")
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID] where (CONCAT([lastName], ' ', [firstName]) = @fullname);";
                    SqlDataSource7.SelectParameters.Add("fullname", txtSearch.Text);
                }
                else if (DropDownList3.SelectedValue == "Email")
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID] where ([U].[email] = @email);";
                    SqlDataSource7.SelectParameters.Add("email", txtSearch.Text);
                }
                else if (DropDownList3.SelectedValue == "IC No")
                {
                    SqlDataSource7.SelectCommand = "SELECT U.[lastName] + ' ' + U.[firstName] AS Full_Name, [S].[staff_IC] AS Staff_IC, [S].[hireDate] AS Hire_Date, [U].[email] AS Email, [U].[contactNumber] AS Contact_Number FROM [User] U JOIN [Staff] S ON U.[userID] = S.[userID] where ([S].[staff_IC] = @staffIC);";
                    SqlDataSource7.SelectParameters.Add("staffIC", txtSearch.Text);
                }

                GridView2.DataSourceID = "SqlDataSource7";
                GridView2.DataBind();
            }
            else if (DropDownList1.SelectedValue == "Manager" && (DropDownList3.SelectedValue == "Full Name" || DropDownList3.SelectedValue == "Email" || DropDownList3.SelectedValue == "IC No"))
            {
                SqlDataSource8.SelectParameters.Clear();
                if (DropDownList3.SelectedValue == "Full Name")
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID where (CONCAT([lastName], ' ', [firstName]) = @fullname);";
                    SqlDataSource8.SelectParameters.Add("fullname", txtSearch.Text);
                }
                else if (DropDownList3.SelectedValue == "Email")
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID where ([U].[email] = @email);";
                    SqlDataSource8.SelectParameters.Add("email", txtSearch.Text);
                }
                else if (DropDownList3.SelectedValue == "IC No")
                {
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName]+' '+U.[firstName] as Full_Name, A.admin_IC as Admin_IC, U.[email] as Email, U.[contactNumber] as Contact_Number FROM [User] U JOIN [Admin] A ON U.userID = A.userID where ([A].[admin_IC] = @adminIC);";
                    SqlDataSource8.SelectParameters.Add("adminIC", txtSearch.Text);
                }

                GridView3.DataSourceID = "SqlDataSource8";
                GridView3.DataBind();
            }

        }

        protected void btnDeleteStaff_Click(object sender, EventArgs e)
        {
            string role = DropDownList1.SelectedValue;

            int userID = int.Parse(((Button)sender).CommandArgument.ToString());
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string deleteQuery = (role == "Staff") ? "DELETE FROM Staff WHERE userID = @ID" : "DELETE FROM Admin WHERE userID = @ID";
                string userDeleteQuery = "DELETE FROM [User] WHERE [userID] = @UserID";
                SqlCommand cmd1 = new SqlCommand(deleteQuery, connection);
                SqlCommand cmd2= new SqlCommand(userDeleteQuery, connection);
                try
                {
                    connection.Open();

                  
                    cmd1.Parameters.Clear();
                    cmd1.Parameters.AddWithValue("@ID", userID);
                    cmd1.ExecuteNonQuery();

                    cmd2.Parameters.Clear();
                    cmd2.Parameters.AddWithValue("@UserID", userID);
                    cmd2.ExecuteNonQuery();

                    GridView2.DataBind();
                    GridView3.DataBind();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Deleted Successfully!');", true);
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                }
                finally
                {
                    cmd1.Dispose();
                    cmd2.Dispose(); // Dispose of the SqlCommand
                }
            }
        }
    }
}