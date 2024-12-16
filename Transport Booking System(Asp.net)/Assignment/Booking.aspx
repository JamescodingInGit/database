<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="Assignment.Booking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Booking</title>
        <style>
        * {
            font-family: 'Roboto', sans-serif;
            font-size: 14px;
        }

        .wrap-panel {
            display: grid;
            grid-template-columns: 10% 20% 5% 55% 10%;
        }

        .left-panel,
        .right-panel {
            box-sizing: border-box;
            padding: 8px;
        }

        .left-panel {
            grid-column: 2 / span 1;
        }

        .left-panel a{
            text-decoration: none;
        }

        .right-panel {
            grid-column: 4 / span 1;
        }

        table {
            width: 100%;
        }

        .left-table {
            border-collapse: separate;
            border-spacing: 0 2px;
        }

        td,
        th {
            padding: 18px;
            position: relative;
            font-size:14px;
        }

        .left-table td {
            border-radius: 5px;
            border: 1px solid black;
        }

        .right-heading {
            border: 1px solid black;
            border-top-left-radius: 5px;
            border-top-right-radius: 5px;
            height: 60px;
            display: flex;
            align-items: center; /* Center the text vertically */
            justify-content: center; /* Center the text horizontally */
            background-color: #ddd;
        }

        .content {
            border: 1px solid black;
            padding: 18px;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }

        .alert {
            background-color: #89CFF0;
            color: #0047AB;
            padding: 10px;
            text-align: center;
            border-radius: 4px;
        }

            .alert h5 {
                margin: 0;
            }

        .date {
            margin-top: 10px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
        }

        .date-col1,
        .date-col2,
        .date-col3,
        .date-col4 {
            display: flex;
            flex-direction: column;
            padding: 10px;
            border-radius: 4px;
            font-size:14px;
        }

        .date p {
            margin: 0;
        }

        .date input {
            margin-top: 5px;
            width: 180px;
        }

        .date select {
            margin-top: 5px;
            width: 100px;
        }

        #btnSearch {
            margin-top: 5px;
            width: 80px;
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .transactionH-table {
            border-collapse: collapse;
            overflow: hidden;
        }

             .btnCancel {
                padding: 8px;
                background-color: #800080;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 80%;
            }
        .left-table td:hover {
            background-color: #ddd;
        }

        .transactionH-table{
            text-align: left;
        }

        .rowList {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 10px 0 10px 0;
            border-radius: 8px;
            border:2px solid #d3d3d3;
            background-color: #fff;
            padding: 15px;
        }

        .rowList:hover{
            background-color:#fffde9;
        }

        .bookingRow, .infoRow{
            width: 100%;
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .infoRow{
            border-top:2px solid #d3d3d3;
        }

        .bookingFrom, .bookingTo{
            font-size:13px;
        }

        .bookingTime, .bookingStatus {
            font-size: 14px;
            margin-right: 20px;
        }

        .bookingFrom, .bookingTo{
            width: 20%;
        }

        .bookingUntil{
            width:5%;
            margin:0 3% 0 3%;
        }

        .infoButton, .closeButton{
            margin:0 5% 0 5%;
        }

        .infoBtt{
            border-radius: 5px;
            font-size: 16px;
            color:white;
            padding: 7px 12px;
            border: 1px solid #F0C400;
            background-color: #FF5F1F;
            width:100%;
            cursor: pointer;
        }

        .none{
            display:none;
        }

    </style>
     <script>
         function openInfo(i) {
             var info = document.getElementsByClassName("infoRow");
             var more = document.getElementsByClassName("infoButton");
             var close = document.getElementsByClassName("closeButton");
             info[i].classList.remove("none");
             more[i].classList.add("none");
             close[i].classList.remove("none");
         }

         function closeInfo(i) {
             var info = document.getElementsByClassName("infoRow");
             var more = document.getElementsByClassName("infoButton");
             var close = document.getElementsByClassName("closeButton");
             info[i].classList.add("none");
             more[i].classList.remove("none");
             close[i].classList.add("none");
         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="history" runat="server">
             <div class="wrap-panel">
            <div class="left-panel">
                <table class="left-table">
                    <tr>
                        <td><asp:HyperLink ID="profileLink" runat="server" NavigateUrl="Profile.aspx">My Profile</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td><asp:HyperLink ID="editProfileLink" runat="server" NavigateUrl="EditProfile.aspx">Edit Profile</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td><asp:HyperLink ID="changePasswordLink" runat="server" NavigateUrl="ChangePassword.aspx">Change Password</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td><asp:HyperLink ID="bookingLink" runat="server" NavigateUrl="Booking.aspx">My Booking</asp:HyperLink></td>
                    </tr>
                </table>
            </div>

            <div class="right-panel">
                <div class="right-heading">
                    <p style="font-size: 14px; font-weight: 700;">My Booking</p>
                </div>
                <div class="content">
                    <div class="alert">
                        <h5>Please select the sales period below to retrieve your transaction history:</h5>
                    </div>
                    <div class="date">
                        <div class="date-col1">
                            <p>From Departure Date</p>
                            <asp:TextBox ID="txtFormDt" runat="server" type="date"></asp:TextBox>
                        </div>
                        <div class="date-col2">
                            <p>To Departure Date</p>
                            <asp:TextBox ID="txtToDt" runat="server" type="date"></asp:TextBox>
                        </div>
                        <div class="date-col3">
                            <p>Product</p>
                            <asp:DropDownList ID="ddlType" runat="server">
                                <asp:ListItem>Bus</asp:ListItem>
                                <asp:ListItem>Train</asp:ListItem>
                                <asp:ListItem>Ferry</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;
                        </div>
                        <div class="date-col4">
                            <asp:Button ID="btnSearch" runat="server" Text="Seacrch" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
                <asp:Label ID="lbltest" runat="server" ForeColor="Red"></asp:Label>


                <br />
                <hr />

               <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>

            <div class="rowList">
                        <div class="bookingRow">
                            <div class="bookingTime"><b><%# Eval("departureDateTime", "{0:dd MMM yyyy HH:mm tt}") %></b></div>
                            <div class="bookingFrom"><%# Eval("from") %><br /><%# Eval("pickUpPoint") %></div>
                            <div class="bookingUntil"><i class="fa-solid fa-angle-right"></i></div>
                            <div class="bookingTo"><%# Eval("to") %><br /><%# Eval("dropOffPoint") %></div>
                            <div class="bookingStatus"><b><%# Eval("state") %></b></div>
                            <div class="infoButton">
                                <asp:Button ID="Button2" runat="server" Text="More Info" Cssclass="infoBtt" OnClientClick='<%# "openInfo(" + Container.ItemIndex + "); return false;" %>'/>
                            </div>
                            <div class="closeButton none">
                                <asp:Button ID="Button3" runat="server" Text="Close" Cssclass="infoBtt" OnClientClick='<%# "closeInfo(" + Container.ItemIndex + "); return false;" %>'/>
                            </div>
                        </div>
                     <div class="infoRow none">
                         <table class="transactionH-table">
                    <tr>
                        <th>Order Number</th>
                        <td colspan="3"><%# Eval("orderNumber") %></td>
                    </tr>
                    <tr>
                        <th>Invoice Number</th>
                        <td colspan="3"><%# Eval("invoiceNumber") %></td>
                    </tr>
                    <tr>
                        <th>Product</th>
                        <td colspan="3"><%# Eval("transportType") %></td>
                    </tr>


                    <tr>
                        <th>Trips Details</th>
                        <td colspan="3"><%# Eval("from") %> -&gt; <%# Eval("to") %></td>
                    </tr>


                    <tr>
                        <th>Coach Company</th>
                        <td colspan="3"><%# Eval("operatorName") %></td>
                    </tr>


                    <tr>
                        <th>Depart Date &amp; Time</th>
                        <td colspan="3"><%# Eval("departureDateTime", "{0:dd MMM yyyy HH:mm tt}") %></td>
                    </tr>


                    <tr>
                        <th>Purchase Date &amp; Time</th>
                        <td colspan="3"><%# Eval("purchaseDateTime", "{0:dd MMM yyyy HH:mm tt}") %></td>
                    </tr>


                    <tr <%# Eval("transportType").ToString().Equals("bus", StringComparison.OrdinalIgnoreCase) ? "" : "style='display:none;'" %>>
                        <th>Passenger</th>
                        <td colspan="3"><%# Eval("seatNumbers") %></td>
                    </tr>
                    <tr>
                        <th>Adult Number</th>
                        <td colspan="3"><%# Eval("adultNumber") %></td>
                    </tr>
                    <tr>
                        <th>Child Number</th>
                        <td colspan="3"><%# Eval("childNumber") %></td>
                    </tr
                    <tr>
                        <th>Payment Method</th>
                        <td colspan="3"><%# Eval("paymentMethod") %></td>
                    </tr>
                     
                     <tr>
                        <th>Total Price</th>
                        <td colspan="3">RM <%# Eval("totalPrice", "{0:0.00}") %></td>
                    </tr>
                </table>
                        </div>
                    </div>
        <hr />
    </ItemTemplate>
            </asp:Repeater>

            </div>
        </div>
             <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Booking] WHERE ([userID] = @userID)">
                 <SelectParameters>
                     <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Booking]
WHERE
    ([userID] = @userID)
    AND (@departureDateTime &lt;= [departureDateTime])
    AND (@departureDateTime2 &gt;= [departureDateTime])
    AND (transportType = @type)">
                 <SelectParameters>
                     <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32" />
                     <asp:ControlParameter ControlID="txtFormDt" DbType="DateTime2" Name="departureDateTime" PropertyName="Text" />
                     <asp:ControlParameter ControlID="txtToDt" DbType="DateTime2" Name="departureDateTime2" PropertyName="Text" />
                     <asp:ControlParameter ControlID="ddlType" Name="type" PropertyName="SelectedValue" />
                 </SelectParameters>
             </asp:SqlDataSource>
        <br />
        </form>
</asp:Content>
