<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="Assignment.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Change Password</title>
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
            align-items: center;
            justify-content: center;
            background-color: #ddd;
        }

            .right-heading p {
                font-size: 14px;
                font-weight: bold;
                margin: 0;
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

        .pass {
            margin-top: 10px;
            display: grid;
            grid-template-rows: repeat(4, 1fr);
            gap: 10px;
        }

        .pass-row1,
        .pass-row2,
        .pass-row3,
        .pass-row4 {
            display: flex;
            flex-direction: column;
            padding: 10px;
            border-radius: 4px;
        }

            .pass-row1 input,
            .pass-row2 input,
            .pass-row3 input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
                margin-top: 5px;
            }

            .pass-row4 button {
                width: 100%;
                padding: 10px;
                background-color: black;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

        .auto-style2 {
            width: 40%;
        }

        #btnUpdate {
            margin-top: 5px;
            width: 80px;
            padding: 8px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .left-table td:hover {
            background-color: #ddd;
        }

        .left-panel a{
            text-decoration: none;
        }

        .btnUpdate {
            margin-top: 5px;
            width: 120px;
            padding: 8px;
            background-color: green;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="changePassword" runat="server">

         <script type="text/javascript">
             function OpenConfirmDialog() {
                 // Use confirm dialog to ask the user if they want to proceed
                 var confirmed = confirm('Do you want to proceed with Change the password?');
                 if (confirmed == false) {
                     alert('Cancel change password!');
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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
            <div class="right-panel">
                <div class="right-heading">
                    <p>Change Password</p>
                </div>
                <div class="content">
                    <div class="alert">
                        <h5>You may change your password below.</h5>
                    </div>
                    <table>
                        <tr>
                            <td class="auto-style2">New Password</td>
                            <td>
                                <asp:TextBox ID="txtNPass" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtNPass" Display="Dynamic" ErrorMessage="Password length must between 6 to 10 Characters" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&amp;#.\s]{6,10}$" Width="241px"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Confirm New Password</td>
                            <td>
                                <asp:TextBox ID="txtCNPass" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                                <br />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCNPass" Display="Dynamic" ErrorMessage="Password length must between 6 to 10 Characters" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&amp;#.\s]{6,10}$" Width="241px"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Verify Code</td>
                            <td>
                                <asp:TextBox ID="txtVerify" runat="server" Width="100%"></asp:TextBox>
                                <asp:Button ID="bttVerify" runat="server" OnClick="bttVerify_Click" Text="Send" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td>
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2"></td>
                            <td>

                                <asp:Button class="btnUpdate" ID="Button2" runat="server" Text="Change Button" OnClientClick="return OpenConfirmDialog()" OnClick="btnUpdate_Click"/>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <br />
         </form>
</asp:Content>