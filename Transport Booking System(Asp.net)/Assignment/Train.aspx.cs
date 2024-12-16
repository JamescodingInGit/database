using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Train : System.Web.UI.Page
    {
        public string date = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Train.aspx";
            string fromLocation = Server.UrlDecode(Request.QueryString["from"]);
            string toLocation = Server.UrlDecode(Request.QueryString["to"]);
            string fromDate = Server.UrlDecode(Request.QueryString["fromDate"]);
            string toDate = Server.UrlDecode(Request.QueryString["toDate"]);
            string trip = Server.UrlDecode(Request.QueryString["trip"]);
            date = Server.UrlDecode(Request.QueryString["fromDate"]);
            if (!IsPostBack)
            {
                txtFromDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                txtToDate.Attributes["min"] = DateTime.Now.ToString("yyyy-MM-dd");
                if (string.IsNullOrEmpty(Request.QueryString["fromDate"]) || string.IsNullOrEmpty(Request.QueryString["toDate"]))
                {
                    txtFromDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtToDate.Text = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                }
                else
                {
                    txtFrom.Text = fromLocation;
                    txtTo.Text = toLocation;
                    txtFromDate.Text = fromDate;
                    txtToDate.Text = toDate;
                    Session["date"] = fromDate;
                }
                lblFrom.Text = fromLocation;
                lblTo.Text = toLocation;

                if (trip == "OneWay")
                {
                    MultiView1.ActiveViewIndex = 0;
                    lblDepartFrom1.Text = fromLocation;
                    lblDepartTo1.Text = toLocation;
                    lblDepartDate1.Text = fromDate;
                    txtToDate.Visible = false;
                    rblTrip.SelectedIndex = 0;
                }
                else if (trip == "RoundTrip")
                {
                    MultiView1.ActiveViewIndex = 1;
                    lblDepartFrom2.Text = fromLocation;
                    lblDepartTo2.Text = toLocation;
                    lblDepartDate2.Text = fromDate;
                    lblReturnFrom1.Text = toLocation;
                    lblReturnTo1.Text = fromLocation;
                    lblReturnDate1.Text = toDate;
                }

            }
            if (IsPostBack)
            {
                if (Request["__EVENTTARGET"] == "btnDepart")
                {
                    MultiView1.ActiveViewIndex = 2;
                    string scheduleID = Request["__EVENTARGUMENT"];
                    Session["departTrip"] = "scheduleID=" + scheduleID + "&seat=" + ddlDepart.Text;
                    lblDepartFrom3.Text = fromLocation;
                    lblDepartTo3.Text = toLocation;
                    lblDepartDate3.Text = fromDate;
                    lblReturnFrom2.Text = toLocation;
                    lblReturnTo2.Text = fromLocation;
                    lblReturnDate2.Text = toDate;
                    date = Server.UrlDecode(Request.QueryString["toDate"]);

                    lblFrom.Text = toLocation;
                    lblTo.Text = fromLocation;

                    Session["date"] = toDate;
                }
                else if (Request["__EVENTTARGET"] == "btnOneWay")
                {
                    string scheduleID = Request["__EVENTARGUMENT"];
                    Session["departTrip"] = "scheduleID=" + scheduleID + "&seat=" + ddlOneWay.SelectedValue;
                    Session["returnTrip"] = null;
                    Session["selected"] = "seleted";
                    Response.Redirect("Calculation.aspx");
                }
                else if (Request["__EVENTTARGET"] == "btnReturn")
                {
                    string scheduleID = Request["__EVENTARGUMENT"];
                    Session["returnTrip"] = "scheduleID=" + scheduleID + "&seat=" + ddlReturn.SelectedValue;
                    Session["selected"] = "seleted";
                    Response.Redirect("Calculation.aspx");
                }
                else if (Request["__EVENTTARGET"] == "btnProcessOneWay")
                {
                    string scheduleID = Request["__EVENTARGUMENT"];
                    Session["departTrip"] = "scheduleID=" + scheduleID + "&seat=" + ddlDepart.SelectedValue;
                    Session["selected"] = "seleted";
                    Response.Redirect("Calculation.aspx");
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

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblTrip.SelectedIndex == 0)
            {
                txtToDate.Visible = false;
                rblTrip.SelectedIndex = 0;
            }
            else if (rblTrip.SelectedIndex == 1)
            {
                txtToDate.Visible = true;
                rblTrip.SelectedIndex = 1;
            }
        }

        protected void bttSearch_Click(object sender, EventArgs e)
        {
            if (txtFrom.Text == "" || txtTo.Text == "")
            {
                lblMessage.Text = "Please enter depart location and desination!!!";
            }
            else
            {
                Response.Redirect("Train.aspx" + "?trip=" + Server.UrlEncode(rblTrip.Text) + "&from=" + Server.UrlEncode(txtFrom.Text) + "&to=" + Server.UrlEncode(txtTo.Text) + "&fromDate=" + Server.UrlEncode(txtFromDate.Text) + "&toDate=" + Server.UrlEncode(txtToDate.Text));
            }

        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (drpSortBy.SelectedIndex == 0)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [departureDateTime]";
            }
            else if (drpSortBy.SelectedIndex == 1)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [departureDateTime] DESC";
            }
            else if (drpSortBy.SelectedIndex == 2)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [price]";
            }
            else if (drpSortBy.SelectedIndex == 3)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [price] DESC";
            }
            else if (drpSortBy.SelectedIndex == 4)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [seatLeft] DESC";
            }
            else if (drpSortBy.SelectedIndex == 5)
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [ScheduleSelection] ORDER BY [seatLeft]";
            }
        }

        protected void cblTime_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        protected void cblOperator_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        protected void cblPickUp_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        protected void cblDropOff_SelectedIndexChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        protected void ApplyFilters()
        {
            List<string> selectedTimeValues = GetSelectedValues(cblTime);
            List<string> selectedOperatorValues = GetSelectedValues(cblOperator);
            List<string> selectedPickUpValues = GetSelectedValues(cblPickUp);
            List<string> selectedDropOffValues = GetSelectedValues(cblDropOff);

            string filterExpression = "";

            if (selectedTimeValues.Count > 0)
            {
                filterExpression += GenerateTimeFilterExpression();
            }

            if (selectedOperatorValues.Count > 0)
            {
                AddToFilterExpression(ref filterExpression, "operatorName", selectedOperatorValues);
            }

            if (selectedPickUpValues.Count > 0)
            {
                AddToFilterExpression(ref filterExpression, "pickUpPoint", selectedPickUpValues);
            }

            if (selectedDropOffValues.Count > 0)
            {
                AddToFilterExpression(ref filterExpression, "dropOffPoint", selectedDropOffValues);
            }
            if (selectedTimeValues.Count <= 0 && selectedOperatorValues.Count <= 0 && selectedPickUpValues.Count <= 0 && selectedDropOffValues.Count <= 0)
            {
                SqlDataSource1.FilterExpression = string.Empty;
                SqlDataSource1.FilterParameters.Clear();
            }
            SqlDataSource1.FilterExpression = filterExpression;
            SqlDataSource1.DataBind();
        }

        private List<string> GetSelectedValues(CheckBoxList checkBoxList)
        {
            List<string> selectedValues = new List<string>();

            foreach (ListItem item in checkBoxList.Items)
            {
                if (item.Selected)
                {
                    selectedValues.Add(item.Value);
                }
            }

            return selectedValues;
        }

        private string GenerateFilterExpression(string columnName, List<string> selectedValues)
        {
            string filterExpression = "(";

            for (int i = 0; i < selectedValues.Count; i++)
            {
                filterExpression += $"{columnName} LIKE '%{selectedValues[i]}%'";

                if (i < selectedValues.Count - 1)
                {
                    filterExpression += " OR ";
                }
            }

            filterExpression += ")";

            return filterExpression;
        }

        private void AddToFilterExpression(ref string filterExpression, string columnName, List<string> selectedValues)
        {
            string expression = GenerateFilterExpression(columnName, selectedValues);

            if (!string.IsNullOrEmpty(expression))
            {
                if (!string.IsNullOrEmpty(filterExpression))
                {
                    filterExpression += " AND ";
                }

                filterExpression += expression;
            }
        }

        private string GenerateTimeFilterExpression()
        {
            string filterExpression = "";
            string startTime = "";
            string endTime = "";
            int selectedCount = 0;
            if (cblTime.Items[0].Selected)
            {
                startTime = " 00:00:00";
                endTime = " 23:59:59";

            }
            else
            {
                foreach (ListItem item in cblTime.Items)
                {
                    if (item.Selected)
                    {
                        selectedCount++;
                        int selectedIndex = cblTime.Items.IndexOf(item);
                        if (selectedIndex == 1)
                        {
                            if (startTime != "")
                            {
                                if (TimeSpan.Parse("00:00:00") < TimeSpan.Parse(startTime))
                                {
                                    startTime = " 00:00:00";
                                }
                                if (TimeSpan.Parse("11:59:59") > TimeSpan.Parse(endTime))
                                {
                                    endTime = " 11:59:59";
                                }
                            }
                            else
                            {
                                startTime = " 00:00:00";
                                endTime = " 11:59:59";
                            }
                        }
                        if (selectedIndex == 2)
                        {
                            if (startTime != "")
                            {
                                if (TimeSpan.Parse("12:00:00") < TimeSpan.Parse(startTime))
                                {
                                    startTime = " 12:00:00";
                                }
                                if (TimeSpan.Parse("18:59:59") > TimeSpan.Parse(endTime))
                                {
                                    endTime = " 18:59:59";
                                }
                            }
                            else
                            {
                                startTime = " 12:00:00";
                                endTime = " 18:59:59";
                            }
                        }
                        if (selectedIndex == 3)
                        {
                            if (startTime != "")
                            {
                                if (TimeSpan.Parse("19:00:00") < TimeSpan.Parse(startTime))
                                {
                                    startTime = " 19:00:00";
                                }
                                if (TimeSpan.Parse("23:59:59") > TimeSpan.Parse(endTime))
                                {
                                    endTime = " 23:59:59";
                                }
                            }
                            else
                            {
                                startTime = " 19:00:00";
                                endTime = " 23:59:59";
                            }

                        }
                    }
                }
            }
            filterExpression = "departureDateTime >= #" + date + startTime + "# AND departureDateTime <= #" + date + endTime + "#";

            return filterExpression;
        }

        protected void bttReset_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in cblTime.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in cblPickUp.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in cblDropOff.Items)
            {
                item.Selected = false;
            }
            foreach (ListItem item in cblOperator.Items)
            {
                item.Selected = false;
            }
        }
    }
}