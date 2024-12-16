<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="Ticket.aspx.cs" Inherits="Assignment.Ticket" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Ticket</title>
    <style>
      
        .auto-style35 {
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

            .auto-style35:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            border: 2px solid #757575; 
            border-radius: 10px; 
           
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
             left:0;
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

        .auto-style32 {
            position: relative;
            left: 0px;
            top: 0px;
            height: 56px;
            margin: 10px;
        }

        .auto-style34 {
            text-align: center;
            position: absolute;
            left: 972px;
            top: 0;
            appearance: none;
            cursor: pointer;
            padding: 8px 15px;
            font-size: 14.5px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 80px;
            height: 35px;
            transition: 0.5s;
        }

            .auto-style34:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

          .saveButton3 {
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

            .saveButton3:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }


        .button3 {
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

            .button3:hover {
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

        .gridCss2{
           box-shadow: 5px 8px 5px #6e6e6e;
            margin-left:10px;
        }
        .auto-style36 {
            width: 353px;
        }

           .search-input {
            padding: 8px;
            border: 2px solid #ccc;
            border-radius: 5px;
            margin-right: 8px;
        }

        .search-button {
            padding: 8px 16px;
            background-color: #aaa;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.5s;
        }

        .search-button:hover{
            border: 1px black solid;
        }


        .auto-style37 {
            display: flex;
            align-items: center;
            position: absolute;
           left: 279px;
            top: 0px;
        }

        .auto-style38{
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
            margin-right:10px;
            transition: 0.5s;
        }

        .auto-style38:hover{
            border-color: #737373;
        }
        .auto-style39 {
            height: 29px;
        }
        .auto-style40 {
            width: 353px;
            height: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <div class="auto-style32">
        <asp:Label ID="Label1" runat="server" Font-Size="15px" ForeColor="#999999" Text="Filter By :"></asp:Label>
        <asp:DropDownList ID="DropDownList3" runat="server" CssClass="drpDownMngment">
            <asp:ListItem>All</asp:ListItem>
            <asp:ListItem>Confirmed</asp:ListItem>
            <asp:ListItem>Pending</asp:ListItem>
        </asp:DropDownList>
        <asp:DropDownList ID="DropDownList4" runat="server" CssClass="auto-style34">
            <asp:ListItem>Sort :</asp:ListItem>
            <asp:ListItem>A~Z</asp:ListItem>
            <asp:ListItem>Z~A</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
           <div class="auto-style37">
               <asp:Label ID="Label2" runat="server" Font-Size="15px" ForeColor="#999999" Text="Search By :"></asp:Label>
            &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" CssClass="auto-style38">
                   <asp:ListItem>Full Name</asp:ListItem>
               </asp:DropDownList>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input"></asp:TextBox>
               <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-button" />
        </div>

        <asp:Button ID="AddButton2" runat="server" CssClass="auto-style35" Text="ADD"  OnClientClick="showModal(); return false;" OnClick="AddButton2_Click" />

        <!-- Modal overlay and content -->
        <div class="modal-overlay" id="modalOverlay">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                      <div class="modal-content">
              
                <h2>Add Ticket</h2>
                <asp:Label ID="lblModalError" runat="server" ForeColor="Red"></asp:Label>
                          <br />
                          <asp:Label ID="lblSuccesAdd" runat="server" ForeColor="Green"></asp:Label>
                <br />
                <table style="width:100%;">
                    <tr>
                        <td class="auto-style39">User ID</td>
                        <td class="auto-style39">:</td>
                        <td class="auto-style40">
                <asp:DropDownList ID="ticket_userID" runat="server" DataSourceID="SqlDataSource6" DataTextField="userID" DataValueField="userID" AutoPostBack="True" OnSelectedIndexChanged="ticket_userID_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style39">Full Name</td>
                        <td class="auto-style39">:</td>
                        <td class="auto-style40">
                            <asp:Label ID="lblFullname" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Schedule ID</td>
                        <td>:</td>
                        <td class="auto-style36">
                <asp:DropDownList ID="ticket_scheduleID" runat="server" DataSourceID="SqlDataSource9" DataTextField="scheduleID" DataValueField="scheduleID"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Purchase Date an Time</td>
                        <td>:</td>
                        <td class="auto-style36">
                <asp:Calendar ID="purchaseDT" runat="server"></asp:Calendar>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style39">Tickete State</td>
                        <td class="auto-style39">:</td>
                        <td class="auto-style40">
                <asp:DropDownList ID="ticketState" runat="server">
                    <asp:ListItem>Confirm</asp:ListItem>
                    <asp:ListItem>Pending</asp:ListItem>
                            </asp:DropDownList>

                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td class="auto-style36">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>

                <asp:Button ID="SaveTicket" runat="server" Text="Save" CssClass="saveButton3" OnClick="SaveTicket_Click" />

            
                        </td>
                        <td>&nbsp;</td>
                        <td class="auto-style36">&nbsp;</td>
                    </tr>
                </table>
                <br />
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [userID] FROM [User] where [role] = 'Customer'"></asp:SqlDataSource>

            
                <br />
                <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [scheduleID] FROM [Schedule]"></asp:SqlDataSource>

            
            </div>
                </ContentTemplate>
                </asp:UpdatePanel>
          
        </div>

        <br />
        <br />
    </div>
    <div class="overlay" id="overlay" onclick="closeModal()">
    </div>
    <br />
    <br />
    <asp:GridView ID="GridView2" runat="server" Width="1075px" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" CssClass="gridCss2" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="scheduleID" DataSourceID="SqlDataSource8">
        <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px" />
         <Columns>
             <asp:BoundField DataField="FullName" HeaderText="Full Name" ReadOnly="True" SortExpression="FullName" />
             <asp:BoundField DataField="scheduleID" HeaderText="Schedule ID" SortExpression="scheduleID" InsertVisible="False" ReadOnly="True" />
             <asp:BoundField DataField="purchaseDateTime" HeaderText="Purchase DateTime" SortExpression="purchaseDateTime" />
             <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" />
             <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True">
             <ControlStyle CssClass="button3" />
             </asp:CommandField>
        </Columns>
         <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" Font-Overline="False" Font-Size="Medium" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#e7a868" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Ticket] WHERE [ticketID] = @ticketID" InsertCommand="INSERT INTO [Ticket] ([userID], [scheduleID], [purchaseDateTime], [state]) VALUES (@userID, @scheduleID, @purchaseDateTime, @state)" SelectCommand="SELECT U.[lastName] + ' '+ U.[firstName] as FullName,
S.scheduleID,
T.purchaseDateTime,
T.state
FROM [User] U 
JOIN [Ticket] T ON U.userID = T.userID 
JOIN [Schedule] S ON S.scheduleID = T.scheduleID" UpdateCommand="UPDATE [Ticket] SET [userID] = @userID, [scheduleID] = @scheduleID, [purchaseDateTime] = @purchaseDateTime, [state] = @state WHERE [ticketID] = @ticketID">
        <DeleteParameters>
            <asp:Parameter Name="ticketID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="userID" Type="Int32" />
            <asp:Parameter Name="scheduleID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="purchaseDateTime" />
            <asp:Parameter Name="state" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="userID" Type="Int32" />
            <asp:Parameter Name="scheduleID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="purchaseDateTime" />
            <asp:Parameter Name="state" Type="String" />
            <asp:Parameter Name="ticketID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
   


        </form>
    <script>
        function showModal() {
            document.getElementById('modalOverlay').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }

        // Close the modal if the overlay is clicked
        function overlayClick(event) {
            var modalOverlay = document.getElementById('modalOverlay');
            if (event.target === modalOverlay) {
                closeModal();
            }
        }

        // Attach the overlayClick function to the modal overlay
        document.getElementById('modalOverlay').addEventListener('click', overlayClick);

    </script>
</asp:Content>
