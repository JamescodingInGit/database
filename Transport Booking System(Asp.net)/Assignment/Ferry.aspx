<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Ferry.aspx.cs" Inherits="Assignment.Ferry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Ferry And Fastboat</title>
    <style type="text/css">
        .searchSection {
            background-color: #F0C400;
        }

        .searchBar {
            padding: 0 10% 0 10%;
        }

        .icon {
            font-size: 30px;
        }

        .filterSection{
            padding:2% 0 0 5%;
            width:25%;
            min-height:20%;
        }

        .filterBar{
             border:2px solid #d3d3d3;
             border-radius:5px;
        }

        .selectionBar{
            padding:3.5%;
            border-bottom: 2px solid #d3d3d3;
        }

        .selectionBar b{
            font-size:15px;
        }

        .title{
            background-color:#c6c6c6;
        }

        .scheduleSection{
            margin:3%;
        }

        .section{
            display:flex;
            box-sizing:border-box;
        }

        .sort{
            padding:5% 0 0 0;
        }

        .trip{
            margin: 2% 5% 2% 5%;
            width:90%;
            border: 1px solid black;
            border-collapse: collapse;
        }

        .trip td {
          padding: 15px;
        }

        .selecting{
            background-color: #303033;
            color: white;
        }

        .scheduleList .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 10px 0 10px 0;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            padding: 15px;
            width: 135%;
        }

        .scheduleList .row:hover{
            background-color:#fffde9;
        }

        .scheduleRow {
            width: 100%;
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .scheduleFrom, .scheduleTo, .scheduleSeat, .operatorName, .detail{
            font-size:13px;
        }

        .scheduleTime ,.schedulePrice{
            font-size: 17px;
            margin-right: 20px;
            width:15%;
        }

        .scheduleFrom, .scheduleTo{
            width: 30%;
        }

        .scheduleUntil{
            width:5%;
            margin:0 3% 0 3%;
        }

        .scheduleSeat{
            width:15%;
        }

        .scheduleButton{
            margin:0 5% 0 5%;
        }

        .selectBtt{
            border-radius: 5px;
            font-size: 16px;
            color:white;
            padding: 7px 12px;
            border: 1px solid #F0C400;
            background-color: #F0C400;
            width:100%;
            cursor: pointer;
        }

        .operatorRow {
            width: 100%;
            display: flex;
            align-items: center;
        }

        .operatorImage img {
            max-width: 70px;
            height: auto;
            border-radius: 50%;
            margin-right: 20px;
        }

        .detail{
            margin:0 3% 0 3%;
            color:deepskyblue;
        }

        .selectSection {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .selectcontent {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            width: 70%;
            height: 70%;
            margin:auto;
            margin-top:5%;
        }

        .close {
            float:right;
            cursor: pointer;
            font-size:20px;
        }

        .auto-style1 {
            margin-left: 25px;
            margin-right: 20px;
        }
        .auto-style2 {
            width: 25px;
        }
        .auto-style5 {
            margin-left: 5px;
        }
        .auto-style6 {
            width: 250px;
        }
        .auto-style7 {
            width: 150px;
        }
        .auto-style8 {
            width: 175px;
        }
        .auto-style9 {
            width: 9px;
        }
        .auto-style10 {
            width: 110px;
        }

        .none{
            display:none;
        }
        .nextBtt{
            margin-top:30%;
            float:right;            
        }

    </style>
    <script>
        var scheduleID = "";

        window.addEventListener('load', function () {
            var url = window.location.href;
            var params = new URL(url).searchParams;

            var to = params.get('to');

            if (to === null || to === "") {
                var label = document.getElementsByClassName("label");
                if (label.length > 0) {
                    label[0].classList.add("none");
                }
            }
            var rows = document.getElementsByClassName("scheduleRow");
            var lblNoResult = document.getElementsByClassName("noResult");

            if (rows.length > 0) {
                lblNoResult[0].classList.add("none");
            }
        });



        function closeMap() {
            var select = document.getElementsByClassName("selectSection");
            select[0].classList.add("none");
            scheduleID = "";
            var ddlDepart = document.getElementById('<%= ddlDepart.ClientID %>');
            ddlDepart.selectedIndex = 0
            var ddlOneWay = document.getElementById('<%= ddlOneWay.ClientID %>');
            ddlOneWay.selectedIndex = 0;
            var ddlReturn = document.getElementById('<%= ddlReturn.ClientID %>');
            ddlReturn.selectedIndex = 0;

        }


        function openMap(id) {
            var select = document.getElementsByClassName("selectSection");
            select[0].classList.remove("none");
            scheduleID = id;
        }

        function next() {
            var tripData = scheduleID;
            __doPostBack('btnOneWay', tripData);

        }

        function processOneWay() {
            var tripData = scheduleID;
            __doPostBack('btnProcessOneWay', tripData);
        }

        function departTrip() {
            var tripData = scheduleID;
            __doPostBack('btnDepart', tripData);
        }

        function returnTrip() {
            const queryStringFromSession = '<%= Session["departTrip"] %>';

            // Now use the JavaScript variable queryStringFromSession as needed
            const urlParams = new URLSearchParams(queryStringFromSession);
            var seatNumberCount = urlParams.get('seat');

            if (seatNumberCount == '<%= ddlReturn.SelectedValue %>') {
                var tripData = scheduleID; // Assuming scheduleID is defined elsewhere
                __doPostBack('btnReturn', tripData);
            } else {
                alert("Please select the same number of seats as the departure trip.");
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="busForm" runat="server">

        <div class="searchSection">
            <div class="searchBar">
                <table class="auto-style13">
                    <tr>
                        <td>
                            <div class="icon"><i class="fa-solid fa-ferry"></i></div>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="rblTrip" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                                <asp:ListItem>OneWay</asp:ListItem>
                                <asp:ListItem Selected="True">RoundTrip</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td class="auto-style7">
                            <asp:TextBox ID="txtFrom" runat="server" CssClass="auto-style1" Width="185px" Height="25px">
                            </asp:TextBox>
                        </td>
                        <td class="auto-style2"></td>
                        <td class="auto-style6">
                            <asp:TextBox ID="txtTo" runat="server" CssClass="auto-style5" Width="185px" Height="25px">
                            </asp:TextBox>
                        </td>
                        <td class="auto-style8">
                            <asp:TextBox ID="txtFromDate" runat="server" type="date" Height="25px"></asp:TextBox>
                        </td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtToDate" runat="server" type="date" Height="25px"></asp:TextBox>
                        </td>
                        <td class="auto-style10">
                            <asp:Button ID="bttSearch" runat="server" Text="Search" OnClick="bttSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="Red"></asp:Label></td>
                       
                    </tr>
                </table>

            </div>
        </div>

        <asp:MultiView ID="MultiView1" runat="server">
            <asp:View ID="View1" runat="server">
                <table class="trip">
                    <tr>
                        <td colspan="4" class="selecting"><b>Depart Trip</b></td>
                    </tr>
                    <tr>
                        <td class="selecting">
                            <asp:Label ID="lblDepartFrom1" runat="server" Text=""></asp:Label></td>
                        <td class="selecting"><i class="fa-solid fa-arrow-right"></i></td>
                        <td class="selecting">
                            <asp:Label ID="lblDepartTo1" runat="server" Text=""></asp:Label></td>
                        <td class="selecting">
                            <asp:Label ID="lblDepartDate1" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                <div class="selectSection none">
                    <div class="selectcontent">
                        <div class="selectionTop ">
                            Choose Number of Ticket
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div style="text-align: center; margin-top: 10%;">
                            <asp:DropDownList ID="ddlOneWay" runat="server" Width="25%">
                                <asp:ListItem Value="1">1 passenger</asp:ListItem>
                                <asp:ListItem Value="2">2 passengers</asp:ListItem>
                                <asp:ListItem Value="3">3 passengers</asp:ListItem>
                                <asp:ListItem Value="4">4 passengers</asp:ListItem>
                                <asp:ListItem Value="5">5 passengers</asp:ListItem>
                                <asp:ListItem Value="6">6 passengers</asp:ListItem>
                                <asp:ListItem Value="7">7 passengers</asp:ListItem>
                                <asp:ListItem Value="8">8 passengers</asp:ListItem>
                                <asp:ListItem Value="9">9 passengers</asp:ListItem>
                                <asp:ListItem Value="10">10 passengers</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="bttProcess" runat="server" Text="Process" CssClass="nextBtt" OnClientClick="next()"/>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <table class="trip">
                    <tr>
                        <td colspan="4" class="selecting"><b>Depart Trip</b></td>
                    </tr>
                    <tr>
                        <td class="selecting">
                            <asp:Label ID="lblDepartFrom2" runat="server" Text=""></asp:Label></td>
                        <td class="selecting"><i class="fa-solid fa-arrow-right"></i></td>
                        <td class="selecting">
                            <asp:Label ID="lblDepartTo2" runat="server" Text=""></asp:Label></td>
                        <td class="selecting">
                            <asp:Label ID="lblDepartDate2" runat="server" Text=""></asp:Label></td>
                        <td>
                            <asp:Label ID="lblReturnFrom1" runat="server" Text=""></asp:Label></td>
                        <td><i class="fa-solid fa-arrow-right"></i></td>
                        <td>
                            <asp:Label ID="lblReturnTo1" runat="server" Text=""></asp:Label></td>
                        <td>
                            <asp:Label ID="lblReturnDate1" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                <div class="selectSection none">
                    <div class="selectcontent">
                        <div class="selectionTop ">
                            Choose Number of Ticket
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div style="text-align: center; margin-top: 10%;">
                            <asp:DropDownList ID="ddlDepart" runat="server" Width="25%">
                                <asp:ListItem Value="1">1 passenger</asp:ListItem>
                                <asp:ListItem Value="2">2 passengers</asp:ListItem>
                                <asp:ListItem Value="3">3 passengers</asp:ListItem>
                                <asp:ListItem Value="4">4 passengers</asp:ListItem>
                                <asp:ListItem Value="5">5 passengers</asp:ListItem>
                                <asp:ListItem Value="6">6 passengers</asp:ListItem>
                                <asp:ListItem Value="7">7 passengers</asp:ListItem>
                                <asp:ListItem Value="8">8 passengers</asp:ListItem>
                                <asp:ListItem Value="9">9 passengers</asp:ListItem>
                                <asp:ListItem Value="10">10 passengers</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="btnDepart" runat="server" Text="Choose Departing Trip" CssClass="nextBtt" OnClientClick="departTrip()"/>
                        <asp:Button ID="btnOneWay" runat="server" Text="Process One Way" CssClass="nextBtt" OnClientClick="processOneWay()"/>
                    </div>
                </div>
            </asp:View>
            <asp:View ID="View3" runat="server">
                <table class="trip">
                    <tr>
                        <td colspan="4"><b>Depart Trip</b></td>
                        <td colspan="4" class="selecting"><b>Return Trip</b></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDepartFrom3" runat="server" Text=""></asp:Label></td>
                        <td><i class="fa-solid fa-arrow-right"></i></td>
                        <td>
                            <asp:Label ID="lblDepartTo3" runat="server" Text=""></asp:Label></td>
                        <td>
                            <asp:Label ID="lblDepartDate3" runat="server" Text=""></asp:Label></td>
                        <td class="selecting">
                            <asp:Label ID="lblReturnFrom2" runat="server" Text=""></asp:Label></td>
                        <td class="selecting"><i class="fa-solid fa-arrow-right"></i></td>
                        <td class="selecting">
                            <asp:Label ID="lblReturnTo2" runat="server" Text=""></asp:Label></td>
                        <td class="selecting">
                            <asp:Label ID="lblReturnDate2" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                <div class="selectSection none">
                    <div class="selectcontent">
                        <div class="selectionTop ">
                            Choose Number of Ticket
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div style="text-align: center; margin-top: 10%;">
                            <asp:DropDownList ID="ddlReturn" runat="server" Width="25%">
                                <asp:ListItem Value="1">1 passenger</asp:ListItem>
                                <asp:ListItem Value="2">2 passengers</asp:ListItem>
                                <asp:ListItem Value="3">3 passengers</asp:ListItem>
                                <asp:ListItem Value="4">4 passengers</asp:ListItem>
                                <asp:ListItem Value="5">5 passengers</asp:ListItem>
                                <asp:ListItem Value="6">6 passengers</asp:ListItem>
                                <asp:ListItem Value="7">7 passengers</asp:ListItem>
                                <asp:ListItem Value="8">8 passengers</asp:ListItem>
                                <asp:ListItem Value="9">9 passengers</asp:ListItem>
                                <asp:ListItem Value="10">10 passengers</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <asp:Button ID="btnRetturn" runat="server" Text="Process" CssClass="nextBtt" OnClientClick="returnTrip()"/>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>

        <div class="section">
        <div class="filterSection">
            <div class="filterBar">
                <div class="selectionBar title"><b>Filter</b></div>
                <div class="selectionBar">
                    <asp:HyperLink ID="departTimeLink" runat="server"><b>Depart Time</b></asp:HyperLink>
                    <asp:CheckBoxList ID="cblTime" runat="server" Font-Size="13px" OnSelectedIndexChanged="cblTime_SelectedIndexChanged" AutoPostBack="True">
                        <asp:ListItem Value="*">All</asp:ListItem>
                        <asp:ListItem Value="0:00">Morning (12:00 Midnight - 11:59 AM)</asp:ListItem>
                        <asp:ListItem Value="12:00">Afternoon (12:00 PM - 6:59 PM)</asp:ListItem>
                        <asp:ListItem Value="7:00">Evening (7:00 PM - 11:59 PM)</asp:ListItem>
                    </asp:CheckBoxList>
                </div>
                <div class="selectionBar">
                    <asp:HyperLink ID="operatorLink" runat="server"><b>Operator</b></asp:HyperLink>
                    <asp:CheckBoxList ID="cblOperator" runat="server" Font-Size="13px" AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="operatorName" DataValueField="operatorName" OnSelectedIndexChanged="cblOperator_SelectedIndexChanged">
                    </asp:CheckBoxList>
                </div>
                <div class="selectionBar">
                    <asp:HyperLink ID="pickUpLink" runat="server"><b>Pick-up Point</b></asp:HyperLink>
                    <asp:CheckBoxList ID="cblPickUp" runat="server" Font-Size="13px" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="pickUpPoint" DataValueField="pickUpPoint" OnSelectedIndexChanged="cblPickUp_SelectedIndexChanged">
                    </asp:CheckBoxList>
                </div>
                <div class="selectionBar">
                    <asp:HyperLink ID="dropOffLink" runat="server"><b>Drop-off Point</b></asp:HyperLink>
                    <asp:CheckBoxList ID="cblDropOff" runat="server" Font-Size="13px" AutoPostBack="True" DataSourceID="SqlDataSource4" DataTextField="dropOffPoint" DataValueField="dropOffPoint" OnSelectedIndexChanged="cblDropOff_SelectedIndexChanged">
                    </asp:CheckBoxList>
                </div>
                <div class="selectionBar"><asp:Button ID="bttReset" runat="server" Text="Reset Fitler" OnClick="bttReset_Click" /></div>
            </div>
        </div>

        <div class="scheduleSection">
            <div class="locationDetails">
                <div class="label">
                    <asp:Label ID="lblFrom" runat="server" Font-Bold="True"></asp:Label>
                    <i class="fa-solid fa-arrow-right"></i>
                    <asp:Label ID="lblTo" runat="server" Font-Bold="True"></asp:Label>
                </div>
                <div class="sort">
                    <asp:Label ID="lblSort" runat="server" Text="Sort By:" Font-Bold="False" Font-Size="15px"></asp:Label>
                    <asp:DropDownList ID="drpSortBy" runat="server" Height="30px" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                    <asp:ListItem>Departure(Earliest)</asp:ListItem>
                    <asp:ListItem>Departure(Latest)</asp:ListItem>
                    <asp:ListItem>Cheapest Price</asp:ListItem>
                    <asp:ListItem>Highest Price</asp:ListItem>
                    <asp:ListItem>Seat availability (Highest)</asp:ListItem>
                    <asp:ListItem>Seat availability (Lowest)</asp:ListItem>
                </asp:DropDownList>
                </div>
                <asp:Label ID="lblNoResult" runat="server" Font-Bold="True" Text="No Result Found By This Schedule!!!" ForeColor="Red" CssClass="noResult"></asp:Label>
                <div class="scheduleList">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="row">
                                <div class="scheduleRow">
                                    <div class="scheduleTime"><b><%# Eval("departureDateTime", "{0:hh:mm tt}") %></b></div>
                                    <div class="scheduleFrom"><%# Eval("from") %></div>
                                    <div class="scheduleUntil"><i class="fa-solid fa-angle-right"></i></div>
                                    <div class="scheduleTo"><%# Eval("to") %></div>
                                    <div class="scheduleSeat"><%# Eval("seatLeft") %> Seats</div>
                                    <div class="schedulePrice"><b>RM <%# Eval("adultPrice","{0:0.00}") %></b></div>
                                    <div class="scheduleButton">
                                        <asp:Button ID="bttSelect" runat="server" Text="Select" CssClass="selectBtt" OnClientClick='<%# string.Format("openMap(\"{0}\"); return false", Eval("scheduleID")) %>' />

                                    </div>
                                </div>
                                <div class="operatorRow">
                                    <asp:HyperLink ID="operatorLink" runat="server" NavigateUrl='<%# "operatorDetail.aspx?operatorID=" + Server.UrlEncode(Eval("operatorID").ToString()) %>'>
                                    <div class="operatorImage">
                                        <asp:Image ID="operatorImage1" runat="server" ImageUrl='<%# GetImageFromDataBase(Eval("operatorLogo")) %>'/>
                                    </div>
                                        </asp:HyperLink>
                                    <div class="operatorName"><%# Eval("operatorName") %></div>
                                    <div class="detail">
                                        <asp:HyperLink ID="detailLink" runat="server">Details</asp:HyperLink>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([pickUpPoint] = @pickUpPoint) AND ([dropOffPoint] = @dropOffPoint))">
            <SelectParameters>
                <asp:Parameter DefaultValue="Ferry" Name="transportType" Type="String" />
                <asp:Parameter DefaultValue="" Name="pickUpPoint" Type="String" />
                <asp:Parameter Name="dropOffPoint" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
               <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [operatorName] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [operatorName]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Ferry" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [pickUpPoint] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [pickUpPoint]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Ferry" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dropOffPoint] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [dropOffPoint]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Ferry" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>


