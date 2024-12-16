<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Assignment.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Register</title>
     <style>
           .section {
            margin: 10% 33% 10%;
            font-size:13px;
        }
        .box {
            width: 540px;
            height: 480px;
            border: 2px solid grey;
            backdrop-filter: blur(4px);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
        }

            .box .input-box input {
                letter-spacing: 1px;
                font-size: 13px;
                box-sizing: border-box;
                width: 250px;
                height: 26px;
                border-radius: 5px;
                color:black;
                background: rgba(255,255,255,0.2);
                outline: none;
                padding: 0 12px;
                transition: 0.2s;
                margin-bottom: 10px;
            }

            .box .input-box input:focus {
                    border: 2px solid rgba(255,255,255,0.2);
                }

        .auto-style1 {
			height: 23px;
			width: 10px;
		}

        .auto-style3 {
            height: 20px;
			text-align: center;
		}

        .auto-style4 {
            height: 5px;
            width: 59px;
            bottom: 5px;
        }

        .auto-style7 {
            height: 23px;
            width: 59px;
            bottom: 5px;
        }

        .auto-style8 {
            width: 93%;
        }
    	.auto-style14 {
			text-align: center;
		}
    	.auto-style15 {
			height: 23px;
			bottom: 5px;
		}
		.auto-style21 {
			width: 10px;
		}
    	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<form id="form1" runat="server">
        <div class="section">
        <div class="box">
            <div class="input-box">
                <table class="auto-style8">
                    <tr>
                        <td class="auto-style3" colspan="5" style="font-weight: bold; font-style: oblique;">&nbsp;Register<br />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td class="auto-style4">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TxtFirstname" Display="Dynamic" ErrorMessage="FirstName Cannot Contain Digit Number" ForeColor="Red" ValidationExpression="^[a-zA-Z'.\s]{1,50}" Width="234px" Font-Size="X-Small"></asp:RegularExpressionValidator>
							<br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TxtFirstname" ErrorMessage="FirstName Required" Font-Size="X-Small" ForeColor="Red" Width="200px" Display="Dynamic"></asp:RequiredFieldValidator>
                            <br />
                            FirstName</td>
                        <td class="auto-style4">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="Txtusername" ErrorMessage="Username Required" Font-Size="X-Small" ForeColor="Red" Width="200px"></asp:RequiredFieldValidator>
                            <br />
                            Username</td>
                    </tr>
                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="TxtFirstname" runat="server"></asp:TextBox>
                        </td>
                        <td class="auto-style4">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:TextBox ID="Txtusername" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style7">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TxtLastname" Display="Dynamic" ErrorMessage="LastName Cannot Contain Digit Number" ForeColor="Red" Width="258px" Font-Size="X-Small" ValidationExpression="^[a-zA-Z'.\s]{1,50}"></asp:RegularExpressionValidator>
							<br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TxtLastname" ErrorMessage="LastName Required" Font-Size="X-Small" ForeColor="Red" Width="200px" Display="Dynamic"></asp:RequiredFieldValidator>
                            <br />
                            LastName</td>
                        <td class="auto-style7">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TxtPsw" ErrorMessage="Password Required" Font-Size="X-Small" ForeColor="Red" Width="200px"></asp:RequiredFieldValidator>
                            <br />
                            Password</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style7">
                            <asp:TextBox ID="TxtLastname" runat="server"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:TextBox ID="TxtPsw" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style7">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TxtEmail" Display="Dynamic" ErrorMessage="Please Enter Correct Email Format" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" Width="258px"></asp:RegularExpressionValidator>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TxtEmail" ErrorMessage="Email Required" Font-Size="X-Small" ForeColor="Red" Width="200px"></asp:RequiredFieldValidator>
                            <br />
                            Email</td>
                        <td class="auto-style7">
                            &nbsp;</td>
                        <td class="auto-style1"></td>
                        <td class="auto-style1">
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TxtConfirmPsw" ErrorMessage="Password Required" Font-Size="X-Small" ForeColor="Red" Width="204px"></asp:RequiredFieldValidator>
                            &nbsp;ConfirmPassword</td>
                    </tr>
                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="TxtEmail" runat="server" TextMode="Email"></asp:TextBox>
                        </td>
                        <td class="auto-style4">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:TextBox ID="TxtConfirmPsw" runat="server" TextMode="Password"></asp:TextBox>
                            </td>
                    </tr>
                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td class="auto-style4">
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TxtContact" ErrorMessage="ContactNumber Required" Font-Size="XX-Small" ForeColor="Red" Width="236px"></asp:RequiredFieldValidator>
                            <br />
                            ContactNumber</td>
                        <td class="auto-style4">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TxtPsw" ErrorMessage="Password length must between 6 to 10 Characters" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&amp;#.\s]{6,10}$" Display="Dynamic" Width="241px"></asp:RegularExpressionValidator>
							</td>
                    </tr>
                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td class="auto-style4">
                            <asp:TextBox ID="TxtContact" runat="server" ></asp:TextBox>
                        </td>
                        <td class="auto-style4">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">
							&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style15" colspan="4">
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TxtContact" Display="Dynamic" ErrorMessage="Please Enter Correct Phone Number(###-###-####)" Font-Size="X-Small" ForeColor="Red" ValidationExpression="^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"></asp:RegularExpressionValidator>
							<br />
                            <asp:Label ID="MessageBox" runat="server" ForeColor="Red" ValidateRequestMode="Enabled"></asp:Label>
                            </td>
                    </tr>

                    <tr>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style7">
                            &nbsp;</td>
                        <td class="auto-style7">
                            &nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                        <td class="auto-style1">&nbsp;</td>
                    </tr>

                    <tr>
                        <td class="auto-style21">&nbsp;</td>
                        <td colspan="4" class="auto-style14">
                            <asp:Button ID="BtnRegister" runat="server" Text="Register" BackColor="#1B7399" BorderColor="#99CCFF" OnClick="BtnRegister_Click" />
                            <asp:Button ID="BtnGoLogin" runat="server" Text="Back To Login" BackColor="#1B7399" BorderColor="#99CCFF" OnClick="BtnGoLogin_Click" CausesValidation="False" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
            </div>
    </form>
</asp:Content>