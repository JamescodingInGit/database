<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Assignment.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Profile</title>
     <style>
        * {
            font-family: 'Roboto', sans-serif;
            font-size: 14px;
            font-weight: 300;
        }

        .wrap-panel {
            display: grid;
            grid-template-columns: 10% 20% 5% 55% 10%;
            margin: 0;
            padding: 0;
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

        .right-table {
            border-collapse: collapse;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 0 0 1px #666;
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

        .right-table tr {
            position: relative;
        }

        .no-border th::after {
            content: none;
        }

        .right-table tr::after {
            content: '';
            position: absolute;
            left: 1%;
            right: 1%;
            bottom: 0;
            height: 90%;
            border-bottom: 1px solid #000;
        }

        .right-table .no-border::after {
            content: none; /*hide the border*/
        }

        .left-table td:hover {
            background-color: #ddd;
        }

        .left-panel a{
            text-decoration: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="form1" runat="server">
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
                <table class="right-table">
                    <tr class="no-border">
                        <th colspan="2" style="background-color: #ddd; font-size: 14px; font-weight: 700;">My Profile</th>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>First Name</td>
                        <td>&nbsp;<asp:Label ID="lblFName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td>
                            <asp:Label ID="lblLName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>Contact Number</td>
                        <td>
                            <asp:Label ID="lblCNum" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <br />
     </form>
</asp:Content>
