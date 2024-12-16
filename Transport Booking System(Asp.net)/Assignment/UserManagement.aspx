<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>User Management</title>
    <style>
        
        .auto-style28 {
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

            .auto-style28:hover {
                border-color: #737373;
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
            backdrop-filter: contrast();
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
            position: absolute;
            left: 0;
            top: 0;
            cursor: pointer;
            width: 150px;
            padding: 5px;
            font-size: 14px;
        }


            .drpDownMngment option:selected {
                background-color: #e0e0e0;
                color: #333;
            }

        .auto-style29 {
            position: relative;
            left: 0px;
            top: 0px;
            height: 96px;
            margin: 10px;
        }

        .auto-style30 {
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

            .auto-style30:hover {
                border-color: #737373;
            }

        .auto-style31 {
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

            .auto-style31:hover {
                border-color: #737373;
            }

        .saveButton1 {
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

            .saveButton1:hover {
                border-color: #737373;
            }


        .button {
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

            .button:hover {
                border-color: #737373;
            }

        .dropDownRole {
            left: 0;
            top: 0;
            cursor: pointer;
            width: 150px;
            padding: 1px;
            font-size: 14px;
        }

        .gridCss1 {
            box-shadow: 5px 8px 3px #888888;
            margin-left: 10px;
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

            .search-button:hover {
                border: 1px black solid;
            }

        .auto-style33 {
            box-shadow: 5px 8px 3px #888888;
            margin-left: 10px;
            margin-top: 0px;
        }



        .auto-style34 {
            display: flex;
            align-items: center;
            position: absolute;
            left: 279px;
            top: 0px;
        }

        .auto-style35 {
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
            margin-right: 10px;
            transition: 0.5s;
        }

            .auto-style35:hover {
                border-color: #737373;
            }
    </style>
    <style type="text/css">
        .auto-style26 {
            height: 29px;
        }
    </style>
    <style type="text/css">
        .auto-style26 {
            height: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <div class="auto-style29">
        <asp:Label ID="Label2" runat="server" Font-Size="15px" ForeColor="#999999" Text="Filter By :"></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" CssClass="auto-style30">
            <asp:ListItem>Customer</asp:ListItem>
            <asp:ListItem>Staff</asp:ListItem>
            <asp:ListItem>Manager</asp:ListItem>
        </asp:DropDownList>
        <br />

        <br />
        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="auto-style31" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged1">
            <asp:ListItem disabled="disabled">Sort : </asp:ListItem>
            <asp:ListItem Value="1">A~Z </asp:ListItem>
            <asp:ListItem Value="2">Z~A</asp:ListItem>
            <asp:ListItem Value="3">NoSort</asp:ListItem>
        </asp:DropDownList>

        <div class="auto-style34">
            <asp:Label ID="Label1" runat="server" Font-Size="15px" ForeColor="#999999" Text="Search By :"></asp:Label>
            &nbsp;<asp:DropDownList ID="DropDownList3" runat="server" CssClass="auto-style35">
                <asp:ListItem>Full Name</asp:ListItem>
                <asp:ListItem>Email</asp:ListItem>
            </asp:DropDownList>

            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-button" OnClick="btnSearch_Click" />
            <br />
            &nbsp;
        </div>

        <div id="divAddButton">
            <asp:Button ID="AddButton" runat="server" Text="ADD" CssClass="auto-style28" OnClick="AddButton_Click" OnClientClick="showModal(); return false;" />
        </div>


         <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- Modal overlay and content -->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <%if (DropDownList1.SelectedValue == "Staff")
                    {%>
                <h2>Add Staff</h2>
                <%}
                    else
                    {%>
                <h2>Add Admin</h2>
                <%} %>
            
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>
                <table style="width: 100%;">
                    <tr>
                        <td class="auto-style26">Full Name</td>
                        <td class="auto-style26">:</td>
                        <td class="auto-style26">
                              <%if (DropDownList1.SelectedValue == "Staff")
                                {%>
                            <asp:DropDownList ID="DropDownList4" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged" DataSourceID="SqlDataSource9" DataTextField="Full_Name" DataValueField="tempStaffID">
                             </asp:DropDownList>
                            <%}
                                else
                                {%>
                          <asp:DropDownList ID="DropDownList5" runat="server"  AutoPostBack="True" OnSelectedIndexChanged="DropDownList4_SelectedIndexChanged" DataSourceID="SqlDataSource10" DataTextField="Full_Name" DataValueField="tempAdminID">
                           </asp:DropDownList>
                            <%} %>
                          
                        </td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="modal-input" Width="250px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Contact Number</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtContactNumber" runat="server" placeholder="Contact Number" CssClass="modal-input" Width="250px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style26">First Name</td>
                        <td class="auto-style26">:</td>
                        <td class="auto-style26">
                            <asp:TextBox ID="txtFirstName" runat="server" placeholder="First Name" CssClass="modal-input" Width="250px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtLastName" runat="server" placeholder="Last Name" CssClass="modal-input" Width="250px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>IC No.</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtICNo" runat="server" placeholder="IC No." CssClass="modal-input" Width="250px" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                   
                    <%if (DropDownList1.SelectedValue == "Staff")
                        {%>
                    <tr>
                        <td>Hire Date</td>
                        <td>:</td>
                        <td>
                           
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:Calendar ID="clHireDate" runat="server" AutoPostBack="True"></asp:Calendar>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%} %>
                    <tr>
                        <td></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                      
                    <tr>
                        <td>
                            <asp:Button ID="SaveUser" runat="server" Text="Save" OnClick="SaveUser_Click" CssClass="saveButton1" />
                            &nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                    </ContentTemplate></asp:UpdatePanel>
                <br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT[role] FROM [User]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource9" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [tempStaffID], [lastNameStaff]+' '+ [firstNameStaff] as Full_Name from [TempStaff]"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSource10" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [tempAdminID], [lastNameAdmin]+' '+ [firstNameAdmin] as Full_Name from [TempAdmin]"></asp:SqlDataSource>

            </div>
        </div>
           <asp:Label ID="staffOrManagerName" runat="server"></asp:Label><br />
                
                
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT[role] FROM [User]"></asp:SqlDataSource>
        <br />
    </div>
    <div class="overlay" id="overlay" onclick="closeModal()">
    </div>
    <div class="overlay" id="overlayDelete" onclick="closeModalDelete()">
    </div>
    <br />
    <br />
        <br />
    <br />
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CssClass="auto-style33" DataKeyNames="User_ID" DataSourceID="SqlDataSource2" GridLines="Vertical" Width="1075px" Font-Underline="False" AllowSorting="True" OnRowDataBound="customerRow">
                <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px" />
                <Columns>
                    <asp:BoundField DataField="User_ID" HeaderText="User_ID" InsertVisible="False" ReadOnly="True" SortExpression="User_ID" />
                    <asp:BoundField DataField="Full_Name" HeaderText="Full_Name" ReadOnly="True" SortExpression="Full_Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Contact_Number" HeaderText="Contact_Number" SortExpression="Contact_Number" />
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Overline="False" Font-Underline="False" Font-Size="Medium" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px" />
                <SelectedRowStyle BackColor="#e7a868" Font-Bold="True" ForeColor="Black" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [User] WHERE [userID] = @userID" InsertCommand="INSERT INTO [User] ([role], [username], [password], [email], [contactNumber], [firstName], [lastName]) VALUES (@role, @username, @password, @email, @contactNumber, @firstName, @lastName)" SelectCommand="SELECT [userID] as User_ID, CONCAT([lastName], ' ' , [firstName]) as Full_Name, [email] as Email, [contactNumber] as Contact_Number FROM [User] WHERE ([role] = @role)" UpdateCommand="UPDATE [User] SET [role] = @role, [username] = @username, [password] = @password, [email] = @email, [contactNumber] = @contactNumber, [firstName] = @firstName, [lastName] = @lastName WHERE [userID] = @userID">
                <DeleteParameters>
                    <asp:Parameter Name="userID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="role" Type="String" />
                    <asp:Parameter Name="username" Type="String" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="contactNumber" Type="String" />
                    <asp:Parameter Name="firstName" Type="String" />
                    <asp:Parameter Name="lastName" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" DefaultValue="Customer" Name="role" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="role" Type="String" />
                    <asp:Parameter Name="username" Type="String" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="contactNumber" Type="String" />
                    <asp:Parameter Name="firstName" Type="String" />
                    <asp:Parameter Name="lastName" Type="String" />
                    <asp:Parameter Name="userID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:GridView ID="GridView2" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" Width="1075px" GridLines="Vertical" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource7" CssClass="gridCss1" DataKeyNames="staffID,userID" OnRowDataBound="staffRow" AllowSorting="True">
                <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px" />
                <Columns>
                    <asp:BoundField DataField="staffID" HeaderText="staffID" ReadOnly="True" SortExpression="staffID" InsertVisible="False" />
                    <asp:BoundField DataField="Full_Name" HeaderText="Full_Name" SortExpression="Full_Name" ReadOnly="True" />
                    <asp:BoundField DataField="Staff_IC" HeaderText="Staff_IC" SortExpression="Staff_IC" />
                    <asp:BoundField DataField="Hire_Date" HeaderText="Hire_Date" SortExpression="Hire_Date" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                      <asp:BoundField DataField="Contact_Number" HeaderText="Contact_Number" SortExpression="Contact_Number" />
                                          <asp:TemplateField HeaderText="Delete" >
                <ItemTemplate>
                    <asp:Button ID="btnDeleteStaff" runat="server" Text="Delete" CommandName="DeleteStaff" CommandArgument='<%# Eval("userID")  %>' CssClass="button" OnClientClick="return OpenConfirmDialog();" OnClick="btnDeleteStaff_Click"/>
               </ItemTemplate>
            </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Overline="False" Font-Size="Medium" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Staff] WHERE [staffID] = @staffID" InsertCommand="INSERT INTO [Staff] ([staff_IC], [hireDate], [userID]) VALUES (@staff_IC, @hireDate, @userID)" SelectCommand="SELECT S.staffID,
U.userID AS userID,
    U.[lastName] + ' ' + U.[firstName] AS Full_Name,
    [S].[staff_IC] AS Staff_IC,
    [S].[hireDate] AS Hire_Date,
    [U].[email] AS Email,
    [U].[contactNumber] AS Contact_Number
FROM
    [User] U
JOIN
    [Staff] S ON U.[userID] = S.[userID];"
                UpdateCommand="UPDATE [Staff] SET [staff_IC] = @staff_IC, [hireDate] = @hireDate, [userID] = @userID WHERE [staffID] = @staffID">
                <DeleteParameters>
                    <asp:Parameter Name="staffID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="staff_IC" Type="String" />
                    <asp:Parameter DbType="Date" Name="hireDate" />
                    <asp:Parameter Name="userID" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="staff_IC" Type="String" />
                    <asp:Parameter DbType="Date" Name="hireDate" />
                    <asp:Parameter Name="userID" Type="Int32" />
                    <asp:Parameter Name="staffID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <asp:GridView ID="GridView3" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" Width="1075px" GridLines="Vertical" AllowPaging="True" AutoGenerateColumns="False" CssClass="gridCss1" DataSourceID="SqlDataSource8" DataKeyNames="adminID,User_ID" OnRowDataBound="adminRow" >
                <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px" />
                <Columns>
                    <asp:BoundField DataField="adminID" HeaderText="adminID" ReadOnly=" True" SortExpression="adminID" InsertVisible="False" />
                    <asp:BoundField DataField="Full_Name" HeaderText="Full_Name" SortExpression="Full_Name" ReadOnly="True" />
                    <asp:BoundField DataField="Admin_IC" HeaderText="Admin_IC" SortExpression="Admin_IC" />
                         <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="Contact_Number" HeaderText="Contact_Number" SortExpression="Contact_Number" />
            <asp:TemplateField HeaderText="Delete" >
                <ItemTemplate>
                    <asp:Button ID="btnDeleteAdmin" runat="server" Text="Delete" CommandName="DeleteAdmin" CommandArgument='<%# Eval("User_ID")  %>' CssClass="button" OnClientClick="return OpenConfirmDialog();" OnClick="btnDeleteStaff_Click"/>
               </ItemTemplate>
            </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" Font-Overline="False" Font-Size="Medium" Font-Underline="False" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Admin] WHERE [adminID] = @adminID" InsertCommand="INSERT INTO [Admin] ([admin_IC], [userID]) VALUES (@admin_IC, @userID)" SelectCommand="SELECT A.adminID, 
U.[userID] as User_ID,
U.[lastName]+' '+U.[firstName] as Full_Name,
A.admin_IC as Admin_IC,
U.[email] as Email,
U.[contactNumber] as Contact_Number
FROM [User] U JOIN [Admin] A ON U.userID = A.userID"
                UpdateCommand="UPDATE [Admin] SET [admin_IC] = @admin_IC, [userID] = @userID WHERE [adminID] = @adminID">
                <DeleteParameters>
                    <asp:Parameter Name="adminID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="admin_IC" Type="String" />
                    <asp:Parameter Name="userID" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="admin_IC" Type="String" />
                    <asp:Parameter Name="userID" Type="Int32" />
                    <asp:Parameter Name="adminID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
        </form>


    <script>
        var userid = 0;
        function showModal() {
            <%if (DropDownList1.SelectedValue != "Customer")
        {%>
            document.getElementById('modalOverlay').style.display = 'flex';

            <%}
        else
        {%>
            alert("Customer Cannot ADD!");
        <%}%>

        }

        function OpenConfirmDialog() {

            var confirmed = confirm('Do you want to Delete?');
            if (confirmed == false) {
                alert('Cancel Delete!');
                return false;
            } else {
                return true;
            }

        }


        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }

        function overlayClick(event) {
            var modalOverlay = document.getElementById('modalOverlay');
           
            if (event.target === modalOverlay) {
                closeModal();
            }

        }

        document.getElementById('modalOverlay').addEventListener('click', overlayClick);
        document.getElementById('modalOverlayDelete').addEventListener('click', overlayClick);

  
    </script>
</asp:Content>

