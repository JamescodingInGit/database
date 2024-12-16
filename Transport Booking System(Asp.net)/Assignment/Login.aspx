<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Assignment.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Login</title>
    <style>


<style>
        .section {
            margin: 10% 40% 10%;
            font-size: 13px;
        }

        .box {
            width: 350px;
            height: 350px;
            border: 2px solid grey;
            backdrop-filter: blur(4px);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
            margin:10% 40% 10% 40%;
        }

            .box .input-box input {
                letter-spacing: 1px;
                font-size: 14px;
                box-sizing: border-box;
                width: 250px;
                height: 35px;
                border-radius: 5px;
                color: black;
                background: rgba(255,255,255,0.2);
                outline: none;
                padding: 0 12px;
                transition: 0.2s;
                margin-bottom: 10px;
            }

                .box .input-box input:focus {
                    border: 2px solid rgba(255,255,255,0.8);
                }

        .auto-style1 {
            height: 23px;
        }

        .auto-style2 {
            width: 50px;
        }

        .auto-style3 {
            text-align: center;
        }

        .auto-style4 {
            height: 23px;
            width: 8px;
            bottom: 5px;
        }

        .auto-style5 {
            width: 8px;
        }

        .auto-style6 {
            width: 50px;
            height: 23px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <form id="form1" runat="server">
  <div class="section">
            <div class="box">
                <div class="input-box">
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style3" colspan="2" style="font-weight: bold; font-style: oblique;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login<br />
                            </td>
                            <td class="auto-style3">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style6"></td>
                            <td class="auto-style4">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Txtusername" ErrorMessage="Username Required" Font-Size="Medium" ForeColor="Red" Width="211px"></asp:RequiredFieldValidator>
                                <br />
                                Username </td>
                            <td class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="Txtusername" runat="server"></asp:TextBox>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td class="auto-style5" style="height: 5px; bottom: 5px;">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtPsw" ErrorMessage="Password Required" Font-Size="Medium" ForeColor="Red" Width="232px"></asp:RequiredFieldValidator>
                                <br />
                                Password</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="TxtPsw" runat="server" TextMode="Password"></asp:TextBox>
                                <br />
                                <asp:Label ID="MessageBox" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                <br />
                                <br />
                            </td>
                        </tr>

                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td colspan="2">
                                <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" ForeColor="Blue" NavigateUrl="~/ForgetPassword.aspx">Forgot Password?</asp:HyperLink> 
                                <asp:Button ID="BtnLogin" runat="server" Text="Login" BackColor="#1B7399" BorderColor="#99CCFF" OnClick="BtnLogin_Click" />
                                <asp:Button ID="BtnGoRegister" runat="server" Text="Register" BackColor="#1B7399" BorderColor="#99CCFF" OnClick="BtnGoRegister_Click" CausesValidation="False" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</asp:Content>
