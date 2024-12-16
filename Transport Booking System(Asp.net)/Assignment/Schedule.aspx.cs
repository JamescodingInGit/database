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
    public partial class Schedule : System.Web.UI.Page
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
                txtDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-ddTHH:mm");
                txtUpdateDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-ddTHH:mm");
            }
            if (IsPostBack)
            {
                if (Request["__EVENTTARGET"] == "showUpdate")
                {
                    Session["updateScheduleID"] = Request["__EVENTARGUMENT"];
                    int scheduleID = int.Parse(Request["__EVENTARGUMENT"]);
                    updateSchedule.CommandArgument = scheduleID.ToString();
                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        string sqlQuery = "SELECT * FROM Schedule WHERE scheduleID=" + scheduleID;
                        SqlCommand command = new SqlCommand(sqlQuery, connection);
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            txtUpdateFrom.Text = reader["from"].ToString();
                            txtUpdateTo.Text = reader["to"].ToString();
                            txtUpdateDate.Text = reader["departureDateTime"].ToString();
                            txtUpdatePU.Text = reader["pickUpPoint"].ToString();
                            txtUpdateDO.Text = reader["dropOffPoint"].ToString();
                            txtUpdateAdult.Text = reader["adultPrice"].ToString();
                            txtUpdateChild.Text = reader["childPrice"].ToString();
                            string promotionID = reader["promotionID"].ToString();
                            ListItem item = ddlUpdatePromotion.Items.FindByValue(promotionID);
                            if (item != null)
                            {
                                ddlUpdatePromotion.ClearSelection();
                                item.Selected = true;
                            }
                            ddlUpdateType.SelectedValue = reader["transportType"].ToString();
                            string operatorID = reader["operatorID"].ToString();
                            ListItem operatorItem = ddlUpdatePromotion.Items.FindByValue(operatorID);
                            if (operatorItem != null)
                            {
                                ddlUpdateOperator.ClearSelection();
                                item.Selected = true;
                            }
                            else
                            {
                                ddlUpdateOperator.SelectedIndex = 0;
                            }
                            string type = reader["transportType"].ToString();
                            object seat = reader["numberSeat"];
                            string size = "";
                            if (type == "Bus")
                            {
                                if (int.Parse(reader["numberSeat"].ToString()) == 36)
                                    size = "Medium";
                                if (int.Parse(reader["numberSeat"].ToString()) == 40)
                                    size = "Larger";
                            }
                            else if (type == "Train")
                            {
                                if (int.Parse(reader["numberSeat"].ToString()) == 50)
                                    size = "Medium";
                                if (int.Parse(reader["numberSeat"].ToString()) == 70)
                                    size = "Larger";
                            }
                            else if (type == "Ferry")
                            {
                                if (int.Parse(reader["numberSeat"].ToString()) == 300)
                                    size = "Medium";
                                if (int.Parse(reader["numberSeat"].ToString()) == 400)
                                    size = "Larger";
                            }
                            ddlUpdateSize.SelectedValue = size;
                        }

                        reader.Close();

                    }
                }
                else if (Request["__EVENTTARGET"] == "closeUpdate")
                {
                    txtUpdateFrom.Text = "";
                }
            }
        }

        protected void scheduleRow(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.originalColor=this.style.backgroundColor;this.style.backgroundColor='#f0cead';";
                e.Row.Attributes["onmouseout"] = "this.style.backgroundColor=this.originalColor;";
            }
        }







        public List<DateTime> GetAllDepartureDates()
        {
            List<DateTime> allDpDates = new List<DateTime>();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                conn.Open();
                string sqlQuery = "SELECT DISTINCT departureDateTime FROM Schedule";
                using (SqlCommand command = new SqlCommand(sqlQuery, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            DateTime? nullableDate = GetNullableDateTime(reader, 0);
                            if (nullableDate.HasValue)
                            {
                                allDpDates.Add(nullableDate.Value.Date);
                            }
                        }
                    }
                }
            }

            return allDpDates;
        }

        private DateTime? GetNullableDateTime(SqlDataReader reader, int columnIndex)
        {
            if (!reader.IsDBNull(columnIndex))
            {
                return reader.GetDateTime(columnIndex);
            }
            return null;
        }



        protected void Calendar1_DayRender(object sender, System.Web.UI.WebControls.DayRenderEventArgs e)
        {
            // Disable dates of past/future months
            if (e.Day.IsOtherMonth)
            {
                e.Day.IsSelectable = false;
                e.Cell.Text = "X";
            }
            else
            {
                List<DateTime> allDepartureDates = GetAllDepartureDates();

                DateTime currentDate = e.Day.Date;

                // Check if the current date is in the list of dates from the database
                if (allDepartureDates.Contains(currentDate))
                {
                    // Set the background color for the current date
                    e.Cell.BackColor = System.Drawing.Color.Green; // Change to the color you want
                    e.Cell.ToolTip = "Departure Date"; // Optional: Add a tooltip or other information
                }
            }


        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewTicket" && e.CommandArgument != null)
            {

                int scheduleID = Convert.ToInt32(e.CommandArgument);

                Session["SelectedScheduleID"] = scheduleID;
                Response.Redirect("ticket.aspx");

            }
        }


        protected void saveSchedule_Click(object sender, EventArgs e)
        {
            try
            {

                string from = txtFrom.Text;
                string to = txtTo.Text;
                DateTime departureDate = DateTime.Parse(txtDate.Text);
                string pickUpPoint = txtPickUpPoint.Text;
                string dropOffPoint = txtDropOffPoint.Text;
                string childPrice = txtChild.Text;
                string adultPrice = txtAdult.Text;

                if (string.IsNullOrEmpty(childPrice) ||
                    string.IsNullOrEmpty(from) ||
                    string.IsNullOrEmpty(to) ||
                    departureDate == DateTime.MinValue ||
                    string.IsNullOrEmpty(adultPrice) ||
                    string.IsNullOrEmpty(pickUpPoint) ||
                    string.IsNullOrEmpty(dropOffPoint) )

                {

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill in all required fields.');", true);
                    return;
                }


                string insertQuery = "INSERT INTO [dbo].[Schedule] ([from], [to], [departureDateTime], [pickUpPoint], [dropOffPoint], [adultPrice], [childPrice], " +
                     "[scheduleSeatMap], [soldNumberSeat], [promotionID], [operatorID], [seatMap], [transportType], [numberSeat]) " +
                     "VALUES (@From, @To, @DepartureDate, @PickUpPoint, @DropOffPoint, @adultPrice, @childPrice, " +
                     "@scheduleSeatMap, @soldNumberSeat, @promotionID, @operatorID, @seatMap, @transportType, @numberSeat)";

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {

                    string transportType = ddlType.SelectedValue;
                    string size = ddlSize.SelectedValue;
                    string seatMap = "";
                    string scheduleSeatMap = "";
                    int numberSeat = 0;
                    if (transportType == "Bus")
                    {
                        if (size == "Medium")
                        {
                            seatMap = "[[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1]]";
                            scheduleSeatMap = "[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]";
                            numberSeat = 36;
                        }
                        else if (size == "Large")
                        {
                            seatMap = "[[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1]]";
                            scheduleSeatMap = "[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]";
                            numberSeat = 40;
                        }
                    }
                    else if (transportType == "Train")
                    {
                        if (size == "Medium")
                        {
                            seatMap = null;
                            numberSeat = 50;
                        }
                        else if (size == "Large")
                        {
                            seatMap = null;
                            numberSeat = 70;
                        }
                    }
                    else if (transportType == "Ferry")
                    {
                        if (size == "Medium")
                        {
                            numberSeat = 300;
                        }
                        else if (size == "Large")
                        {
                            numberSeat = 400;
                        }
                    }


                        SqlCommand command = new SqlCommand(insertQuery, connection);
                        // Add parameters and their values to the SqlCommand
                        command.Parameters.AddWithValue("@From", txtFrom.Text);
                        command.Parameters.AddWithValue("@To", txtTo.Text);
                        command.Parameters.AddWithValue("@DepartureDate", DateTime.Parse(txtDate.Text));
                        command.Parameters.AddWithValue("@PickUpPoint", txtPickUpPoint.Text);
                        command.Parameters.AddWithValue("@DropOffPoint", txtDropOffPoint.Text);
                        command.Parameters.AddWithValue("@adultPrice", txtAdult.Text);
                        command.Parameters.AddWithValue("@childPrice", txtChild.Text);
                        command.Parameters.AddWithValue("@scheduleSeatMap", scheduleSeatMap);
                        command.Parameters.AddWithValue("@soldNumberSeat", 0);
                        command.Parameters.AddWithValue("@promotionID", ddlPromotion.SelectedValue);
                        command.Parameters.AddWithValue("@operatorID", ddlUpdateOperator.SelectedValue);
                        command.Parameters.AddWithValue("@seatMap", seatMap);
                        command.Parameters.AddWithValue("@transportType", ddlType.SelectedValue);
                        command.Parameters.AddWithValue("@numberSeat", numberSeat);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        connection.Close();

                    
                }
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Added Successful !.');", true);
                // Optionally, you can rebind the GridView to reflect the changes
                GridView1.DataBind();

                // Clear input controls or perform any other post-insert logic
                ClearInputs();
            }
            catch (Exception ex)
            {
                lblModalError.Text = ex.Message.ToString();
            }
        }
        private void ClearInputs()
        {
            txtFrom.Text = "";
            txtTo.Text = "";
            txtDate.Text = "";
            txtPickUpPoint.Text = "";
            txtDropOffPoint.Text = "";
            txtAdult.Text = "";
            txtChild.Text = "";
        }

        protected void updateSchedule_Click(object sender, EventArgs e)
        {
            if (txtUpdateDate.Text != null)
            {
                try
                {

                    string transportType = ddlUpdateType.SelectedValue;
                    string size = ddlUpdateSize.SelectedValue;
                    string seatMap = "";
                    string scheduleSeatMap = "";
                    int numberSeat = 0;
                    if (transportType == "Bus")
                    {
                        if (size == "Medium")
                        {
                            seatMap = "[[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1]]";
                            scheduleSeatMap = "[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]";
                            numberSeat = 36;
                        }
                        else if (size == "Large")
                        {
                            seatMap = "[[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1],[1,1,0,1,1]]";
                            scheduleSeatMap = "[[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]";
                            numberSeat = 40;
                        }
                    }
                    else if (transportType == "Train")
                    {
                        if (size == "Medium")
                        {
                            seatMap = null;
                            numberSeat = 50;
                        }
                        else if (size == "Large")
                        {
                            seatMap = null;
                            numberSeat = 70;
                        }
                    }
                    else if (transportType == "Ferry")
                    {
                        if (size == "Medium")
                        {
                            numberSeat = 300;
                        }
                        else if (size == "Large")
                        {
                            numberSeat = 400;
                        }
                    }
                    string updateQuery = "UPDATE [dbo].[Schedule] SET [from] = @From, [to] = @To, [departureDateTime] = @DepartureDate, [pickUpPoint] = @PickUpPoint, " +
                        "[dropOffPoint] = @DropOffPoint, [adultPrice] = @adultPrice, [childPrice] = @childPrice, [scheduleSeatMap] = @scheduleSeatMap, " +
                        "[soldNumberSeat] = @soldNumberSeat, [promotionID] = @promotionID, operatorID=@operatorID, seatMap=@seatMap, transportType=@transportType, " +
                        "numberSeat = @numberSeat WHERE [scheduleID] = @scheduleID";

                    using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        SqlCommand command = new SqlCommand(updateQuery, connection);
                        // Add parameters and their values to the SqlCommand
                        command.Parameters.AddWithValue("@From", txtUpdateFrom.Text);
                        command.Parameters.AddWithValue("@To", txtUpdateTo.Text);
                        command.Parameters.AddWithValue("@DepartureDate", DateTime.Parse(txtUpdateDate.Text));
                        command.Parameters.AddWithValue("@PickUpPoint", txtUpdatePU.Text);
                        command.Parameters.AddWithValue("@DropOffPoint", txtUpdateDO.Text);
                        command.Parameters.AddWithValue("@adultPrice", txtUpdateAdult.Text);
                        command.Parameters.AddWithValue("@childPrice", txtUpdateChild.Text);
                        command.Parameters.AddWithValue("@scheduleSeatMap", scheduleSeatMap);
                        command.Parameters.AddWithValue("@soldNumberSeat", 0);
                        command.Parameters.AddWithValue("@promotionID", ddlUpdatePromotion.SelectedValue);
                        command.Parameters.AddWithValue("@operatorID", ddlUpdateOperator.SelectedValue);
                        command.Parameters.AddWithValue("@seatMap", seatMap);
                        command.Parameters.AddWithValue("@transportType", ddlUpdateType.SelectedValue);
                        command.Parameters.AddWithValue("@numberSeat", numberSeat);
                        command.Parameters.AddWithValue("@scheduleID", int.Parse(Session["updateScheduleID"].ToString()));

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        connection.Close();
                    }
                    txtUpdateTo.Text = "";
                    txtUpdateFrom.Text = "";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Added Successful !.');", true);
                    // Optionally, you can rebind the GridView to reflect the changes
                    GridView1.DataBind();

                    // Clear input controls or perform any other post-insert logic
                    ClearInputs();
                }
                catch (Exception ex)
                {
                    Label1.Text = ex.Message.ToString();
                }
            }
            else
            {
                Label1.Text = "Please fill in departure date time!!!";
            }

        }

    }
}