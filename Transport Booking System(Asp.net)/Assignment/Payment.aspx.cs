using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
	public partial class Payment : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["selected"] == null)
			{
				string link = (string)Session["link"];
				Response.Redirect(link);
			}

		}

		protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (DropDownList1.SelectedValue == "credit / debit card")
			{
				MultiView1.ActiveViewIndex = 0;

			}
			else if (DropDownList1.SelectedValue == "pay at counter")
			{
				MultiView1.ActiveViewIndex = 1;
			}
		}

		protected void Button1_Click(object sender, EventArgs e)
		{
			if (txtCardNumber.Text == null)
			{
				lblMessage1.Text = "Please enter card number!!";
			}
			else if (txtExpireDate.Text == null)
			{
				lblMessage2.Text = "Please enter card expire date!!";
			}
			else if (txtCCV.Text == null)
			{
				lblMessage3.Text = "Please enter CCV!!";
			}
			else
			{
				SqlConnection conn;
				string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
				conn = new SqlConnection(strCon);

				string query = "SELECT COUNT(*) FROM [card] Where cardNumber = @cardNumber AND expiringDate = @expiringDate AND CCV = @CCV";
				SqlCommand cmdSelect = new SqlCommand(query, conn);
				cmdSelect.Parameters.AddWithValue("@cardNumber", txtCardNumber.Text);
				cmdSelect.Parameters.AddWithValue("@expiringDate", txtExpireDate.Text);
				cmdSelect.Parameters.AddWithValue("@CCV", txtCCV.Text);

				conn.Open();
				int card = (int)cmdSelect.ExecuteScalar();
				conn.Close();
				if (card > 0)
				{
					if (Session["departSeat"] != null)
					{
						insertSchedule((int)Session["departScheduleID"], (string)Session["departSeat"], "Credit/Debit Card");
					}
					else if (Session["returnScheduleID"] != null)
					{
						insertSchedule((int)Session["returnScheduleID"], (string)Session["returnSeat"], "Credit/Debit Card");
					}
					MultiView1.ActiveViewIndex = 2;
				}
				else
				{
					lblMessage3.Text = "Invalid Card!!";
				}
			}

		}

		static string GenerateRandomNumber(int length)
		{
			string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			Random random = new Random();
			StringBuilder stringBuilder = new StringBuilder(length);

			for (int i = 0; i < length; i++)
			{
				int index = random.Next(chars.Length);
				stringBuilder.Append(chars[index]);
			}

			return stringBuilder.ToString();
		}

		protected void Button2_Click(object sender, EventArgs e)
		{
			if (rblSelect.SelectedIndex == 0)
			{
				if (Session["departSeat"] != null)
				{
					insertSchedule((int)Session["departScheduleID"], (string)Session["departSeat"], "cash");
				}
				else if (Session["returnScheduleID"] != null)
				{
					insertSchedule((int)Session["returnScheduleID"], (string)Session["returnSeat"], "cash");
				}

				MultiView1.ActiveViewIndex = 2;
			}
			else
			{
				Response.Redirect("Home.aspx");
			}
		}

		protected void insertSchedule(int scheduleID, string seat, string paymentType)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			string queryInsert = "INSERT INTO Ticket values(@userID, @scheduleID, @purchaseDateTime, @state, @totalPrice, @orderNumber , @invoiceNumber,@paymentMethod,@adultNumber,@childNumber)";
			SqlCommand cmdInsert = new SqlCommand(queryInsert, conn);
			DateTime purchaseDateTime = DateTime.Now;
			cmdInsert.Parameters.AddWithValue("@userID", Session["userID"].ToString());
			cmdInsert.Parameters.AddWithValue("@scheduleID", scheduleID);
			cmdInsert.Parameters.AddWithValue("@purchaseDateTime", purchaseDateTime);
			cmdInsert.Parameters.AddWithValue("@state", "Confirmed");
			cmdInsert.Parameters.AddWithValue("@totalPrice", (double)Session["totalPrice"]);
			cmdInsert.Parameters.AddWithValue("@orderNumber", GenerateRandomNumber(8));
			cmdInsert.Parameters.AddWithValue("@invoiceNumber", GenerateRandomNumber(13));
			cmdInsert.Parameters.AddWithValue("@paymentMethod", paymentType);
			cmdInsert.Parameters.AddWithValue("@adultNumber", int.Parse(Session["adultNumber"].ToString()));
			cmdInsert.Parameters.AddWithValue("@childNumber", int.Parse(Session["childNumber"].ToString()));
			conn.Open();
			cmdInsert.ExecuteNonQuery();

			string[] seatNumbers = seat.Split(',');
			int i = 0;
			if (Session["transportType"].ToString() != "bus")
			{
				string queryGetTicketID = "SELECT ticketID FROM Ticket";
				SqlCommand cmdGetTicketID = new SqlCommand(queryGetTicketID, conn);

				SqlDataReader ticket = cmdGetTicketID.ExecuteReader();
				int ticketID = 0;
				while (ticket.Read())
				{
					ticketID = (int)ticket.GetValue(ticket.FieldCount - 1);
				}
				conn.Close();
				string queryInsertSeat = "INSERT INTO TicketSeat VALUES (@ticketID, @seatNumber)";
				SqlCommand cmdInsertSeat = new SqlCommand(queryInsertSeat, conn);
				conn.Open();
				foreach (string seatNumber in seatNumbers)
				{
					cmdInsertSeat.Parameters.Clear();
					cmdInsertSeat.Parameters.AddWithValue("@ticketID", ticketID);
					cmdInsertSeat.Parameters.AddWithValue("@seatNumber", seatNumber);
					cmdInsertSeat.ExecuteNonQuery();
					i++;
				}
			}

			updateSchedule(i, scheduleID, seatNumbers);
			conn.Close();
		}

		protected void updateSchedule(int soldNumber, int scheduleID, string[] seatNumbers)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			string queryUpdateSchedule = "";

			if (Session["transportType"].ToString() != "bus")
			{
				string scheduleSeatMap = "";
				string transportSeatMap = "";
				int i = 0;
				int k = 0;
				string queryGetSeatMap = "SELECT scheduleSeatMap, seatMap FROM Schedule WHERE scheduleID = @scheduleID";
				SqlCommand getSeatMap = new SqlCommand(queryGetSeatMap, conn);
				getSeatMap.Parameters.AddWithValue("@scheduleID", scheduleID);
				conn.Open();
				SqlDataReader seatMap = getSeatMap.ExecuteReader();
				while (seatMap.Read())
				{
					scheduleSeatMap = seatMap["scheduleSeatMap"].ToString();
					transportSeatMap = seatMap["seatMap"].ToString();
				}
				char[] map = scheduleSeatMap.ToCharArray();
				for (int j = 0; j < transportSeatMap.Length; j++)
				{
					if (transportSeatMap[j] == '1')
					{
						i++;
						foreach (string seatNumber in seatNumbers)
						{
							if (i == int.Parse(seatNumber))
							{
								map[j] = '1';
								k++;
								break;
							}

						}
						j++;
					}
					if (k == seatNumbers.Length)
					{
						break;
					}
				}

				conn.Close();
				scheduleSeatMap = new string(map);
				queryUpdateSchedule = "UPDATE Schedule SET soldNumberSeat = soldNumberSeat+" + soldNumber + ", scheduleSeatMap = @scheduleSeatMap WHERE scheduleID = @scheduleID";
				SqlCommand cmdUpdateSchedule = new SqlCommand(queryUpdateSchedule, conn);
				cmdUpdateSchedule.Parameters.AddWithValue("@scheduleID", scheduleID);
				cmdUpdateSchedule.Parameters.AddWithValue("@scheduleSeatMap", scheduleSeatMap);
				conn.Open();
				cmdUpdateSchedule.ExecuteNonQuery();
			}
			else
			{
				queryUpdateSchedule = "UPDATE Schedule SET soldNumberSeat = soldNumberSeat+" + seatNumbers[0] + "WHERE scheduleID = @scheduleID";
				SqlCommand cmdUpdateSchedule = new SqlCommand(queryUpdateSchedule, conn);
				cmdUpdateSchedule.Parameters.AddWithValue("@scheduleID", scheduleID);
				conn.Open();
				cmdUpdateSchedule.ExecuteNonQuery();
			}

			conn.Close();
		}

		protected void Button3_Click(object sender, EventArgs e)
		{
			Session["selected"] = null;
			Response.Redirect("Home.aspx");
		}
	}
}