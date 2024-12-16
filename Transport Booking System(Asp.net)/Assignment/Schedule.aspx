<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="Assignment.Schedule" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <title>Schedule</title>
    <style>
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 2;
        }

        .modal-content {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }


        .drpDownMngment {
           left: 0;
            top: 0;
            cursor: pointer;
            padding: 8px 15px;
            font-size: 14.5px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 150px;
            height: 35px;
            transition: 0.5s;
        }


            .drpDownMngment:hover {
                border-color: #737373;
            }

        .auto-style70 {
            position: relative;
            left: 0px;
            top: 0px;
            height: 56px;
            margin: 10px;
        }

        .auto-style72 {
            border-color: inherit;
            border-width: medium;
            padding: 8px 15px;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            position: absolute;
            top: 0px;
            width: 67px;
            height: 35px;
            left: 885px;
            transition: 0.5s;
        }

            .auto-style72:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }


            .auto-style73:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }


        .saveButton5 {
            border-color: inherit;
            border-width: medium;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            width: 67px;
            height: 25px;
            transition: 0.5s;
        }

            .saveButton5:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }


        .button5 {
            font: bold 11px Arial;
            text-decoration: none;
            padding: 2px 6px 2px 6px;
            border-color: inherit;
            border-width: medium;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            top: 0px;
            width: 67px;
            height: 35px;
            transition: 0.5s;
        }

            .button5:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

        .dropDownRole {
            left: 0;
            top: 0;
            cursor: pointer;
            width: 150px;
            padding: 1px;
            font-size: 14px;
        }

        .gridCss5 {
            box-shadow: 5px 8px 5px #6e6e6e;
            margin-left: 10px;
        }




        .search-input {
            padding: 8px;
            border: 2px solid #ccc;
            border-radius: 5px;
            margin-right: 8px;
        }

        .search-button {
            font-size:15px;
            padding: 10px 18px;
            background-color: #aaa;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.5s;
        }

            .search-button:hover {
                border: 1px black solid;
            }

        .search-bar {
            display: flex;
            align-items: center;
            position: absolute;
            left: 417px;
            top: 0px;
        }

        .auto-style74 {
            height: 301px;
            display: flex;
            justify-content: center;
        }

        .auto-style76 {
            height: 29px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
     <asp:ScriptManager ID="sc" runat="server" EnablePartialRendering="true">
    </asp:ScriptManager>
    <div class="auto-style70">
        <asp:Label ID="Label2" runat="server" Font-Size="15px" ForeColor="#999999" Text="Filter By :"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="drpDownMngment" AutoPostBack="True">
               <asp:ListItem Value="All">All</asp:ListItem>
            <asp:ListItem Value="One-way">One-way</asp:ListItem>
            <asp:ListItem Value="Round-trip">Round-trip</asp:ListItem>
        </asp:DropDownList>
   
   
        <asp:Button ID="AddSchedule" runat="server" CssClass="auto-style72" Text="ADD" OnClientClick="showModal(); return false;" />

        <!-- Modal overlay and content -->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <h2>Add Schedule</h2>
                <asp:Label ID="lblModalError" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td>From </td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtFrom" runat="server" placeholder="From" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>To</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtTo" runat="server" placeholder="To" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Departure Date</td>
                        <td>:</td>
                        <td>

                                <asp:TextBox ID="txtDate" runat="server" type="datetime-local"></asp:TextBox>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>Pick Up Point</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtPickUpPoint" runat="server" placeholder="Pick Up Point" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Drop Off Point</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtDropOffPoint" runat="server" placeholder="Drop Off Point" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Adult Ticket Price</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtAdult" runat="server" placeholder="Adult Ticket Price" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Child Ticket Price</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtChild" runat="server" placeholder="Child Ticket Price" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Promotion</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlPromotion" runat="server" DataSourceID="sqlDataSource10"  DataValueField="promotionID" DataTextField="promotionTitle"></asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Transport Type</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlType" runat="server"  DataValueField="promotionID" DataTextField="promotionTitle">
                                <asp:ListItem>Bus</asp:ListItem>
                                <asp:ListItem>Train</asp:ListItem>
                                <asp:ListItem>Ferry</asp:ListItem>
                            </asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Transport Size</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlSize" runat="server" >
                                <asp:ListItem>Medium</asp:ListItem>
                                <asp:ListItem>Larger</asp:ListItem>
                            </asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Operator</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlOperator" runat="server" DataSourceID="SqlDataSource11"  DataValueField="operatorID" DataTextField="operatorName"></asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>

                    <tr>
                        <td>

                            <asp:Button ID="saveSchedule" runat="server" Text="Save" CssClass="saveButton5" OnClick="saveSchedule_Click" OnClientClick="validateScheduleForm();"/>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <br />

            </div>
        </div>

           <div class="modal-overlay" id="modalOverlayUpdate" >
            <div class="modal-content">
                <h2>Update Schedule</h2>
                <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td>From </td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdateFrom" runat="server" placeholder="From" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>To</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdateTo" runat="server" placeholder="To" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Departure Date</td>
                        <td>:</td>
                        <td>

                                <asp:TextBox ID="txtUpdateDate" runat="server" type="datetime-local"></asp:TextBox>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>Pick Up Point</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdatePU" runat="server" placeholder="Pick Up Point" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Drop Off Point</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdateDO" runat="server" placeholder="Drop Off Point" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Adult Ticket Price</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdateAdult" runat="server" placeholder="Adult Ticket Price" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Child Ticket Price</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtUpdateChild" runat="server" placeholder="Child Ticket Price" CssClass="modal-input" Width="250px"></asp:TextBox>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Promotion</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlUpdatePromotion" runat="server" DataSourceID="sqlDataSource10"  DataValueField="promotionID" DataTextField="promotionTitle"></asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Transport Type</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlUpdateType" runat="server" >
                                <asp:ListItem>Bus</asp:ListItem>
                                <asp:ListItem>Train</asp:ListItem>
                                <asp:ListItem>Ferry</asp:ListItem>
                            </asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Transport Size</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlUpdateSize" runat="server" >
                                <asp:ListItem>Medium</asp:ListItem>
                                <asp:ListItem>Larger</asp:ListItem>
                            </asp:DropDownList>

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Operator</td>
                        <td>:</td>
                        <td>
                            <asp:DropDownList ID="ddlUpdateOperator" runat="server" DataSourceID="SqlDataSource11"  DataValueField="operatorID" DataTextField="operatorName"></asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>

                            <asp:Button ID="updateSchedule" runat="server" Text="Save" CssClass="saveButton5" OnClick="updateSchedule_Click" />

                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <br />

            </div>
        </div>

        <br />
        <br />
    </div>
    <div class="overlay" id="overlay" onclick="closeModal()">
    </div>
         <div class="overlay" id="overlayUpdate" onclick="closeModalUpdate()">
    </div>
   
    <br />
   
    <div class="auto-style74">
        <asp:UpdatePanel ID="updpnl" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Calendar ID="Calendar1" runat="server" CssClass="calenderCss" Height="293px" Width="676px" OnDayRender="Calendar1_DayRender">
                    <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                    <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333"
                        VerticalAlign="Bottom" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                    <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px"
                        Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                </asp:Calendar>
                <br />
            </ContentTemplate>

        </asp:UpdatePanel>
        <asp:Label ID="lblError" runat="server"></asp:Label>
    </div>

  

    <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" Width="1075px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AllowPaging="True" CssClass="gridCss5" Font-Size="13px" DataSourceID="SqlDataSource7" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" OnRowDataBound="scheduleRow" AllowSorting="True">
        <AlternatingRowStyle BackColor="#CCCCCC" />
        <Columns>
            <asp:BoundField DataField="scheduleID" HeaderText="ID" SortExpression="scheduleID" />
            <asp:BoundField DataField="from" HeaderText="from" SortExpression="from" />
            <asp:BoundField DataField="to" HeaderText="to" SortExpression="to" />
            <asp:BoundField DataField="departureDateTime" HeaderText="departureDateTime" SortExpression="departureDateTime" />
             <asp:BoundField DataField="Seat" HeaderText="Seat" SortExpression="Seat" ReadOnly="True" />
            <asp:BoundField DataField="pickUpPoint" HeaderText="pickUpPoint" SortExpression="pickUpPoint" />
            <asp:BoundField DataField="dropOffPoint" HeaderText="dropOffPoint" SortExpression="dropOffPoint" />
            <asp:BoundField DataField="adultPrice" HeaderText="adultPrice" SortExpression="adultPrice" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="childPrice" HeaderText="childPrice" SortExpression="childPrice" DataFormatString="{0:0.00}" />
             <asp:BoundField DataField="transportType" HeaderText="transportType" SortExpression="transportType" />
             <asp:BoundField DataField="operatorName" HeaderText="operatorName" SortExpression="operatorName" />
             <asp:BoundField DataField="promotionTitle" HeaderText="promotionTitle" SortExpression="promotionTitle" />
            <asp:TemplateField HeaderText="Ticket">
                <ItemTemplate>
                    <asp:Button ID="btnViewTicket" runat="server" CommandName="ViewTicket" CommandArgument='<%# Eval("scheduleID").ToString() %>' CssClass="button5" Text="View Ticket" Width="85px" />
                </ItemTemplate>
            </asp:TemplateField>
              <asp:TemplateField HeaderText="Update">
                <ItemTemplate>
                    <asp:Button ID="btnUpdateSchedule" runat="server" CommandName="UpdateSchedule" CommandArgument='<%# Eval("scheduleID").ToString() %>' CssClass="button5" Text="Update" Width="85px"  OnClientClick='<%# "showModalUpdate(" + Eval("scheduleID") + "); return false;" %>' />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" Font-Overline="False" Font-Size="Medium" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px"/>
        <SelectedRowStyle BackColor="#e7a868" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>


    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ScheduleSelection] WHERE ([date] = @departureDateTime)" DeleteCommand="DELETE FROM [ScheduleSelection] where ([scheduleID] = @scheduleID)">
        <DeleteParameters>
            <asp:Parameter Name="scheduleID" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="Calendar1" DbType="DateTime2" Name="departureDateTime" PropertyName="SelectedDate" />
        </SelectParameters>
    </asp:SqlDataSource>
</ContentTemplate></asp:UpdatePanel>
    <br />
        <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Promotion]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource11" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Operator] WHERE ([isDeleted] IS NULL)"></asp:SqlDataSource>
    <br />
        </form>
    <script>
        window.addEventListener('load', function () {
            var txtUpdateFrom = document.getElementById('<%= txtUpdateFrom.ClientID %>');
            if (txtUpdateFrom.value.trim() !== '') {
                document.getElementById('modalOverlayUpdate').style.display = 'flex';
            }

        });

        function showModal() {
            document.getElementById('modalOverlay').style.display = 'flex';
        }

        function showModalUpdate(id) {
            __doPostBack('showUpdate', id);
        }


        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }

        function closeModalUpdate() {
            document.getElementById('modalOverlayUpdate').style.display = 'none';
            __doPostBack('closeUpdate', '');

        }
        // Close the modal if the overlay is clicked
        function overlayClick(event) {
            var modalOverlay = document.getElementById('modalOverlay');
            var modalOverlayUpdate = document.getElementById('modalOverlayUpdate');
            if (event.target === modalOverlay) {
                closeModal();
            }
            if (event.target === modalOverlayUpdate) {
                closeModalUpdate();
            }
        }

        // Attach the overlayClick function to the modal overlay
        document.getElementById('modalOverlay').addEventListener('click', overlayClick);
        document.getElementById('modalOverlayUpdate').addEventListener('click', overlayClick);

        function validateScheduleForm() {
            var errorMessage = '';

            var txtFrom = document.getElementById('<%= txtFrom.ClientID %>').value.trim();
            var txtTo = document.getElementById('<%= txtTo.ClientID %>').value.trim();
            var txtDate = document.getElementById('<%= txtDate.ClientID %>').value.trim();
            var txtPickUpPoint = document.getElementById('<%= txtPickUpPoint.ClientID %>').value.trim();
            var txtDropOffPoint = document.getElementById('<%= txtDropOffPoint.ClientID %>').value.trim();
            var txtAdult = document.getElementById('<%= txtAdult.ClientID %>').value.trim();
            var txtChild = document.getElementById('<%= txtChild.ClientID %>').value.trim();


            if (txtFrom === '') {
                errorMessage += 'Please fill in the "From" field.\n';
            }

            if (txtTo === '') {
                errorMessage += 'Please fill in the "To" field.\n';
            }

            if (txtDate === '') {
                errorMessage += 'Please fill in the departure date time.\n';
            }
            if (txtPickUpPoint === '') {
                errorMessage += 'Please fill in the Pick Up Point.\n';
            }

            if (txtDropOffPoint === '') {
                errorMessage += 'Please fill in the Drop Off Point.\n';
            }
            if (txtAdult === '') {
                errorMessage += 'Please fill in the Adult Ticket Price.\n';
            }
            if (txtChild === '') {
                errorMessage += 'Please fill in the Child Ticket Price.\n';
            }

            if (errorMessage !== '') {
                alert(errorMessage);
                return false;
            }

            return true;
        }
    </script>


</asp:Content>

