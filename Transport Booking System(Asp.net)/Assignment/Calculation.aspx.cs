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
    public partial class Calculation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["role"] == null)
                {
                    Session["link"]="Calculation.aspx";
                    Response.Redirect("Login.aspx");
                }
                else if (Session["selected"] == null|| Session["role"].ToString()=="Staff"|| Session["role"].ToString() == "Admin"|| Session["role"].ToString() == "Manager")
                {
                    string link = (string)Session["link"];
                    if (Session["link"] == null)
                    {
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        Response.Redirect(link);
                    }
                    
                }
                string departTrip = Session["departTrip"] as string;
                SqlConnection conn;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                conn = new SqlConnection(strCon);
                if (!string.IsNullOrEmpty(departTrip))
                {
                    departView.Visible = true;
                    string[] keyValuePairs = departTrip.Split('&');

                    foreach (string pair in keyValuePairs)
                    {
                        string[] parts = pair.Split('=');
                        
                        if (parts.Length == 2)
                        {
                            string key = parts[0];
                            string value = parts[1];
                            if (key == "scheduleID")
                            {
                                int scheduleID;
                                if (int.TryParse(value, out scheduleID))
                                {
                                    string query = "SELECT * FROM [ScheduleSelection] Where scheduleID = @scheduleID";
                                    SqlCommand cmdSelect = new SqlCommand(query, conn);
                                    cmdSelect.Parameters.AddWithValue("@scheduleID", scheduleID);

                                    conn.Open();
                                    SqlDataReader schedule = cmdSelect.ExecuteReader();
                                    if (schedule.HasRows)
                                    {
                                        if (schedule.Read())
                                        {
                                            Session["departScheduleID"] = scheduleID;
                                            Session["transportType"] = schedule["transportType"];
                                            lblDepartFrom.Text = schedule["from"].ToString();
                                            lblDepartArrive.Text = schedule["to"].ToString();
                                            lblDepartDate.Text = schedule["departureDateTime"].ToString();
                                            lblDepartOperator.Text = schedule["operatorName"].ToString();
                                            lblDepartType.Text = schedule["transportType"].ToString()+":";
                                            decimal adultPrice = Convert.ToDecimal(schedule["adultPrice"]);
                                            decimal childPrice = Convert.ToDecimal(schedule["childPrice"]);
                                            lblAdultPriceDepart.Text = adultPrice.ToString("0.00");
                                            lblChildPriceDepart.Text = childPrice.ToString("0.00");
                                            if (schedule["promotionID"] != null)
                                            {
                                                DateTime startDate = (DateTime)schedule["promotionStartDate"];
                                                DateTime endDate = (DateTime)schedule["promotionEndDate"];
                                                if (DateTime.Now >= startDate && DateTime.Now <= endDate)
                                                {
                                                    Session["discount"] = (double)schedule["discount"];
                                                }
                                            }
                                        }

                                    }
                                    conn.Close();
                                }
                            }
                            else if (key == "seat")
                            {
                                int numberSeat = 0;
                                lblDepartSeat.Text = value;
                                Session["departSeat"] = value;
                                string[] seatNumbers = value.Split(',');
                                foreach (string seatNumber in seatNumbers)
                                {
                                    numberSeat++;
                                }
                                if (Session["transportType"].ToString() == "Bus")
                                {
                                    Session["numberSeat"] = numberSeat;
                                }
                                else
                                {
                                    Session["numberSeat"] = value;
                                }
                                
                            }
                        }
                    }
                }

                string returnTrip = Session["returnTrip"] as string;
                if (!string.IsNullOrEmpty(returnTrip))
                {
                    returnView.Visible = true;
                    string[] keyValuePairs = returnTrip.Split('&');

                    foreach (string pair in keyValuePairs)
                    {
                        string[] parts = pair.Split('=');

                        if (parts.Length == 2)
                        {
                            string key = parts[0];
                            string value = parts[1];

                            if (key == "scheduleID")
                            {
                                int scheduleID;
                                if (int.TryParse(value, out scheduleID))
                                {
                                    string query = "SELECT * FROM [ScheduleSelection] Where scheduleID = @scheduleID";
                                    SqlCommand cmdSelect = new SqlCommand(query, conn);
                                    cmdSelect.Parameters.AddWithValue("@scheduleID", scheduleID);

                                    conn.Open();
                                    SqlDataReader schedule = cmdSelect.ExecuteReader();
                                    if (schedule.HasRows)
                                    {
                                        if (schedule.Read())
                                        {
                                            Session["returnScheduleID"] = scheduleID;
                                            lblReturnFrom.Text = schedule["from"].ToString();
                                            lblReturnArrive.Text = schedule["to"].ToString();
                                            lblReturnDate.Text = schedule["departureDateTime"].ToString();
                                            lblReturnOperator.Text = schedule["operatorName"].ToString();
                                            lblReturnType.Text = schedule["transportType"].ToString() + ":";
                                            decimal adultPrice = Convert.ToDecimal(schedule["adultPrice"]);
                                            decimal childPrice = Convert.ToDecimal(schedule["childPrice"]);
                                            lblAdultPriceReturn.Text = adultPrice.ToString("0.00");
                                            lblAdultPriceReturn.Text = childPrice.ToString("0.00");

                                        }

                                    }
                                    conn.Close();
                                }
                            }
                            else if (key == "seat")
                            {
                                lblReturnSeat.Text = value;
                                Session["returnSeat"] = value;
                            }
                        }
                    }
                }
            }
            if (IsPostBack)
            {
                if (txtAdult.Text=="")
                {
                    txtAdult.Text = "0";
                }
                if (txtChild.Text == "")
                {
                    txtChild.Text = "0";
                }
                int totalSeat = int.Parse(txtAdult.Text) + int.Parse(txtChild.Text);
                if (totalSeat > int.Parse(Session["numberSeat"].ToString()))
                {
                    lblMessage.Text = "Total cannot more than " + Session["numberSeat"].ToString();
                }
                else
                {
                    double discount = (double)Session["discount"];
                    double departPrice = 0;
                    double returnPrice = 0;

                    departPrice += (int.Parse(txtAdult.Text) * double.Parse(lblAdultPriceDepart.Text))+ (int.Parse(txtChild.Text) * double.Parse(lblChildPriceDepart.Text));
                    if (Session["returnSeat"] != null)
                    {
                        returnPrice += (int.Parse(txtAdult.Text) * double.Parse(lblAdultPriceReturn.Text)) + (int.Parse(txtChild.Text) * double.Parse(lblChildPriceReturn.Text));
                    }
                    
                    lblDepartFare.Text = departPrice.ToString();
                    lblReturnFare.Text = returnPrice.ToString();
                    double total = departPrice + returnPrice;
                    double disountPrice = total*discount;
                    lblDiscount.Text = disountPrice.ToString();
                    Session["totalPrice"] = total- disountPrice;
                    lblTotal.Text = Session["totalPrice"].ToString();
                    lblMessage.Text = "";
                    Session["adultNumber"] = txtAdult.Text;
                    Session["childNumber"] = txtChild.Text;
                }
            }
        }


    }
}