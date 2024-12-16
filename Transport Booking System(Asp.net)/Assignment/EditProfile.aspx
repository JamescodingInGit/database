<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="Assignment.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Edilt Profile</title>
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
            align-items: center;
            padding: 10px;
            border-radius: 4px;
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

        .date button {
            margin-top: 5px;
            width: 80px;
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .auto-style1 {
            left: -1px;
            top: 2px;
            width: 1003px;
        }

        .auto-style2 {
            width: 538px;
        }

        .auto-style3 {
            font-weight: bold;
            font-size: 14px;
        }

        #btnUpdate {
            margin-top: 5px;
            width: 80px;
            padding: 8px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .left-table td:hover {
            background-color: #ddd;
        }

        .left-panel a {
            text-decoration: none;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="edit" runat="server">
        <script type="text/javascript">
            function OpenConfirmDialog() {
                var confirmed = confirm('Do you want to proceed with the update?');

                if (confirmed == false) {
                    alert('Cancel Updated Profile!');
                    return false;
                } else {
                    return true;
                }

            }

        </script>
        <div class="wrap-panel">
            <div class="left-panel">
                <table class="left-table">
                    <tr>
                        <td>
                            <asp:HyperLink ID="profileLink" runat="server" NavigateUrl="Profile.aspx">My Profile</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HyperLink ID="editProfileLink" runat="server" NavigateUrl="EditProfile.aspx">Edit Profile</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HyperLink ID="changePasswordLink" runat="server" NavigateUrl="ChangePassword.aspx">Change Password</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HyperLink ID="bookingLink" runat="server" NavigateUrl="Booking.aspx">My Booking</asp:HyperLink></td>
                    </tr>
                </table>
            </div>
            
                    <div class="right-panel">
                        <div class="right-heading">
                            <p class="auto-style3">Edit My Profile</p>
                        </div>
                        <div class="content">
                            <div class="alert">
                                <h5>Modify the text box to edit your information:</h5>
                            </div>
                            <table>
                                <tr>
                                    <td class="auto-style2">Email</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="txtEmail" runat="server" Width="100%"></asp:TextBox>
                                        <small style="font-size: small">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="Please Enter Correct Email Format" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"></asp:RegularExpressionValidator>
							            </small>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">First Name</td>
                                    <td>
                                        <asp:TextBox ID="txtFName" runat="server" Width="100%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtFName" Display="Dynamic" ErrorMessage="FirstName Cannot Contain Digit Number" ForeColor="Red" ValidationExpression="^[a-zA-Z'.\s]{1,50}" Width="234px" Font-Size="X-Small"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Last Name</td>
                                    <td>
                                        <asp:TextBox ID="txtLName" runat="server" Width="100%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtLName" Display="Dynamic" ErrorMessage="LastName Cannot Contain Digit Number" ForeColor="Red" Width="258px" Font-Size="X-Small" ValidationExpression="^[a-zA-Z'.\s]{1,50}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Contact Number</td>
                                    <td style="color: #C0C0C0">
                                        <asp:TextBox ID="txtCNum" runat="server" Width="100%"></asp:TextBox>
                                        <small style="font-size: small">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtCNum" Display="Dynamic" ErrorMessage="Please Enter Correct Phone Number(###-###-####)" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"></asp:RegularExpressionValidator>
							            <br />
                                        For emergency call only</small>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2" style="text-align: right">&nbsp;</td>
                                    <td>
                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClientClick="OpenConfirmDialog();" OnClick="btnUpdate_Click" />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        
                    </div>
                
        </div>
                    
        <br />
    </form>
</asp:Content>