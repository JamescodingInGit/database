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
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Dashboard.aspx";
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            DisplayUserCount();
            DisplayOperatorCount();
            DisplayTicketCount();
            DisplaySales();
        }

        private void DisplayUserCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string countQuery = "SELECT COUNT(*) FROM [User] where [role] = 'Customer'";

                    using (SqlCommand command = new SqlCommand(countQuery, connection))
                    {
                        int userCount = (int)command.ExecuteScalar();

                        totalUsers.InnerText = userCount.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }

        private void DisplaySales()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string countQuery = "SELECT SUM(totalPrice) FROM [Ticket]";

                    using (SqlCommand command = new SqlCommand(countQuery, connection))
                    {
                        decimal sales = (decimal)command.ExecuteScalar();
                        string formattedSales = sales.ToString("0.00");

                        totalSales.InnerText = formattedSales;


                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }



        private void DisplayOperatorCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string countQuery = "SELECT COUNT(*) FROM [Operator]";

                    using (SqlCommand command = new SqlCommand(countQuery, connection))
                    {
                        int operatorCount = (int)command.ExecuteScalar();


                        totalOperator.InnerText = operatorCount.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }

        private void DisplayTicketCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string countQuery = "SELECT COUNT(*) FROM [Ticket]";

                    using (SqlCommand command = new SqlCommand(countQuery, connection))
                    {
                        int ticketCount = (int)command.ExecuteScalar();

                        totalTicket.InnerText = ticketCount.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: " + ex.Message + "');", true);
            }
        }

    }
}