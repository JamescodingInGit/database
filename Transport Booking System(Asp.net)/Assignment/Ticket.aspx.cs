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
    public partial class Ticket : System.Web.UI.Page
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
                if (Session["SelectedScheduleID"] != null)
                {

                    int scheduleID = Convert.ToInt32(Session["SelectedScheduleID"]);
                    SqlDataSource8.SelectParameters.Clear();
                    SqlDataSource8.SelectCommand = "SELECT U.[lastName] + ' '+ U.[firstName] as FullName, S.scheduleID, T.purchaseDateTime, T.state FROM [User] U JOIN [Ticket] T ON U.userID = T.userID JOIN [Schedule] S ON S.scheduleID = T.scheduleID where [S].[scheduleID] = @scheduleID";
                    SqlDataSource8.SelectParameters.Add("scheduleID", scheduleID.ToString());
                    GridView2.DataSourceID = "SqlDataSource8";
                    GridView2.DataBind();
                }
                else
                {

                }
            }

        }

        protected void AddButton2_Click(object sender, EventArgs e)
        {

        }

        protected void SaveTicket_Click(object sender, EventArgs e)
        {

            try
            {
                // Retrieve values from the input controls
                int userID = Convert.ToInt32(ticket_userID.SelectedValue);
                int scheduleID = Convert.ToInt32(ticket_scheduleID.SelectedValue);
                DateTime purchaseDateTime = purchaseDT.SelectedDate;
                string tkState = ticketState.SelectedValue;

                // Perform the database insertion
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    connection.Open();

                    string query = "INSERT INTO [Ticket] ([userID], [scheduleID], [purchaseDateTime], [state]) VALUES (@userID, @scheduleID, @purchaseDateTime, @ticketState)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the query
                        command.Parameters.AddWithValue("@userID", userID);
                        command.Parameters.AddWithValue("@scheduleID", scheduleID);
                        command.Parameters.AddWithValue("@purchaseDateTime", purchaseDateTime);
                        command.Parameters.AddWithValue("@ticketState", tkState);

                        // Execute the query
                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the insertion was successful
                        if (rowsAffected > 0)
                        {
                            lblSuccesAdd.Text = "Ticket added successfully!";
                            purchaseDT.SelectedDate = DateTime.Today;


                        }
                        else
                        {
                            lblModalError.Text = "Failed to add ticket. Please try again.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblModalError.Text = "An error occurred: " + ex.Message;
            }

        }

        protected void ticket_userID_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();
                string query = "SELECT userID, CONCAT([lastName], ' ', [firstName]) as Full_Name FROM [User] WHERE [role] = 'Customer'";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int userID = reader.GetInt32(reader.GetOrdinal("userID"));

                            if (ticket_userID.SelectedValue != null)
                            {
                                int selectedUserID = Convert.ToInt32(ticket_userID.SelectedValue);

                                if (userID == selectedUserID)
                                {
                                    string fullName = reader.GetString(reader.GetOrdinal("Full_Name"));
                                    lblFullname.Text = fullName;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}