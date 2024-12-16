<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Bus.aspx.cs" Inherits="Assignment.Bus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Bus</title>
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

        .legendSection{
            margin:0 30% 0 35%;
        }

            .legendSection li {
                display: inline-block;
                font-size: 12px;
                padding: 8px 20px;
            }

        .available, .occupied{
            float: left;
            height: 15px;
            width: 15px;
            border-radius: 3px;
            margin-right: 3px;
            margin-top: 1px;
            position: relative;
            overflow: hidden;
            border: 1px solid #ccc;
        }

        .available{
            background: #fff;
        }

        .occupied{
            background:#ff5050;
        }

        .seats .seat, .seats .emptySeat {
            cursor: pointer;
            position: relative;
            border-radius: 2px;
            border: 1px solid #e0e0e0;
            height: 24px;
            width: 24px;
            float: left;
            margin: 6px 2px;
            text-align: center;
        }

        .seats {
            display: table;
            position: relative;
            width: 150px;
            margin: 0 auto;
            user-select: none;
        }

        .busChart{
             margin: 0 auto;
             text-align:center;
        }

        .busLabel{
            background-color:dimgrey;
            color:white;
        }

        .emptySeat{
            border:none!important;
        }

        .sold{
            background:#ff5050;
        }

        .selected{
            background:#50C878;
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

        function createEmpty() {
            var seat = document.createElement('DIV');
            seat.className = 'emptySeat';
            return seat;
        }
        function createSeat(seatNumber, seatIndex) {
            return createSeatCore('seat', seatNumber, seatIndex);
        }
        function createSoldSeat(seatNumber, seatIndex) {
            return createSeatCore('seat sold', seatNumber, seatIndex);
        }
        function createSeatCore(className, seatNumber, seatIndex) {
            var seat = document.createElement('DIV');
            seat.className = className;
            seat.setAttribute('data-seat-index', seatIndex);

            var span = document.createElement('SPAN');
            span.innerHTML = seatNumber;
            seat.appendChild(span);

            if (className != "seat sold") {
                seat.onclick = function () {
                    // Get the seat index when clicked
                    var clickedSeatIndex = this.getAttribute('data-seat-index');
                    select(this, clickedSeatIndex);
                };
            }

            return seat;
        }

        function select(selected, numSeat) {
            var seat = document.getElementsByClassName("seat");
            seat[numSeat].classList.toggle("selected");
        }

        function closeMap() {
            scheduleID = "";
            var select = document.getElementsByClassName("selectSection");
            select[0].classList.add("none");
            var seatElements = document.querySelectorAll('.seat, .emptySeat');

            var seatsContainer = document.querySelector('.seats');

            seatElements.forEach(function (element) {
                element.parentNode.removeChild(element);
            });
        }


        function openMap(seatMap, scheduleSeatMap, id) {
            scheduleID = id;
            var select = document.getElementsByClassName("selectSection");
            select[0].classList.remove("none");
            var mask = JSON.parse(seatMap);

            var sold = JSON.parse(scheduleSeatMap);

            var seats = document.querySelector('.seats');
            var seatNumber = 1;
            var seatIndex = 0;
            for (var i = 0; i < mask.length; i++) {
                var row = mask[i];
                var soldRow = sold[i];
                for (var j = 0; j < row.length; j++) {
                    var hasSeat = row[j] == 1;
                    var isSold = soldRow[j] === 1;

                    var seat = isSold ? createSoldSeat(seatNumber, seatIndex) : createSeat(seatNumber, seatIndex);
                    seats.appendChild(hasSeat ? seat : createEmpty());
                    if (hasSeat) {
                        seatNumber++;
                        seatIndex++;
                    }

                }
            }
        }

        function next() {
            var selectedSeats = document.querySelectorAll('.seat.selected');

            var selectedSeatNumbers = [];
            selectedSeats.forEach(function (seat) {
                selectedSeatNumbers.push(seat.textContent);
            });

            if (selectedSeatNumbers.length > 0) {
                var selectedSeatsQuery = selectedSeatNumbers.join(',');

                var tripData = "scheduleID=" + scheduleID + "&seat=" + selectedSeatsQuery;
                __doPostBack('btnOneWay', tripData);
            } else {
                alert("Please select a seat!!");
            }

        }

        function departTrip() {
            var selectedSeats = document.querySelectorAll('.seat.selected');

            var selectedSeatNumbers = [];
            selectedSeats.forEach(function (seat) {
                selectedSeatNumbers.push(seat.textContent);
            });

            if (selectedSeatNumbers.length > 0) {
                var selectedSeatsQuery = selectedSeatNumbers.join(',');

                var tripData = "scheduleID=" + scheduleID + "&seat=" + selectedSeatsQuery;
                __doPostBack('btnDepart', tripData);
            } else {
                alert("Please select a seat!!");
            }
        }

        function returnTrip() {
            var selectedSeats = document.querySelectorAll('.seat.selected');

            var selectedSeatNumbers = [];
            selectedSeats.forEach(function (seat) {
                selectedSeatNumbers.push(seat.textContent);
            });

            const queryString = '<%= Session["departTrip"] %>';
            const params = queryString.split('&');

            let seatNumberCount = 0;

            // Loop through the parameters to find the 'seat number' parameter and count its values
            params.forEach(param => {
                if (param.startsWith('seat=')) {
                    // Split the 'seat number' parameter by '=' and count the number of values
                    const seatValues = param.split('=')[1].split(',');
                    seatNumberCount = seatValues.length;
                }
            });
            if (seatNumberCount == selectedSeatNumbers.length) {
                if (selectedSeatNumbers.length > 0) {
                    var selectedSeatsQuery = selectedSeatNumbers.join(',');

                    var tripData = "scheduleID=" + scheduleID + "&seat=" + selectedSeatsQuery;
                    __doPostBack('btnReturn', tripData);
                } else {
                    alert("Please select a seat!!");
                }
            } else {
                alert("Please select a same number of seat as depart trip!!");
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
                            <div class="icon"><i class="fa-solid fa-bus"></i></div>
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
                            Choose Seates for Departing Trip
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div class="legendSection">
                            <ul>
                                <li>
                                    <div class="available"></div>
                                    available
                                </li>
                                <li>
                                    <div class="occupied"></div>
                                    Occupied
                                </li>
                            </ul>
                        </div>
                        <table class="busChart">
                            <tr>
                                <td class="busLabel">Front</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="seats"></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="busLabel">Back</td>
                            </tr>
                        </table>
                        <asp:Button ID="bttNext" runat="server" Text="Process" CssClass="nextBtt" OnClientClick="next(); return false;" />
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
                            Choose Seates for Departing Trip
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div class="legendSection">
                            <ul>
                                <li>
                                    <div class="available"></div>
                                    available
                                </li>
                                <li>
                                    <div class="occupied"></div>
                                    Occupied
                                </li>
                            </ul>
                        </div>
                        <table class="busChart">
                            <tr>
                                <td class="busLabel">Front</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="seats"></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="busLabel">Back</td>
                            </tr>
                        </table>
                        <asp:Button ID="btnOneWay" runat="server" Text="Process One Way" CssClass="nextBtt" OnClientClick="next(); return false;" />
                        <asp:Button ID="btnReturn" runat="server" Text="Choose Retruning Trip" CssClass="nextBtt" OnClientClick="departTrip();" />
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
                            Choose Seates for Departing Trip
                    <span class="close" onclick="closeMap()"><i class="fa-solid fa-xmark"></i></span>
                        </div>

                        <div class="legendSection">
                            <ul>
                                <li>
                                    <div class="available"></div>
                                    available
                                </li>
                                <li>
                                    <div class="occupied"></div>
                                    Occupied
                                </li>
                            </ul>
                        </div>
                        <table class="busChart">
                            <tr>
                                <td class="busLabel">Front</td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="seats"></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="busLabel">Back</td>
                            </tr>
                        </table>
                        <asp:Button ID="Button2" runat="server" Text="Process" CssClass="nextBtt" OnClientClick="returnTrip(); return false;" />
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
                                        <asp:Button ID="bttSelect" runat="server" Text="Select" CssClass="selectBtt" OnClientClick='<%# string.Format("openMap(\"{0}\", \"{1}\", \"{2}\"); return false", Eval("seatMap"), Eval("scheduleSeatMap"), Eval("scheduleID")) %>' />

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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date))">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bus" Name="transportType" Type="String" />
                <asp:ControlParameter ControlID="lblFrom" Name="from" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" Type="String" />
                <asp:SessionParameter DbType="Date" Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [operatorName] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [operatorName]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bus" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [pickUpPoint] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [pickUpPoint]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bus" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [dropOffPoint] FROM [ScheduleSelection] WHERE (([transportType] = @transportType) AND ([from] = @from) AND ([to] = @to) AND ([date] = @date)) Group By [dropOffPoint]">
            <SelectParameters>
                <asp:Parameter DefaultValue="Bus" Name="transportType" />
                <asp:ControlParameter ControlID="lblFrom" DefaultValue="" Name="from" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblTo" Name="to" PropertyName="Text" />
                <asp:SessionParameter Name="date" SessionField="date" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</asp:Content>
