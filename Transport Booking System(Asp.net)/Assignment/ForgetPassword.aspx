<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="Assignment.ForgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Forget Password</title>
	  <style>
        .section {
            margin: 5% 40% 5%;
            font-size: 13px;
        }

        .box {
            width: 300px;
            height: 315px;
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
			  width: 356px;
			  text-align: center;
		  }
          </style>

	<title>Forgot Password</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="forgetPasswordForm" runat="server">
         <div class="section">
              <div class="box"><br />
        <div style="font-size: large; font-weight: bold; font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif; color: #333333; text-shadow:1px 1px Grey" class="auto-style1">
        	Send Code via Email To Login<br /> </div>
			
		
             <div class="input-box" style="font-size: small; font-weight: bold; font-style: italic; font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">
				 <br />
			<asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
				 <br />
        	Please enter Your email:<br />
			<asp:TextBox ID="emailVerify" runat="server"></asp:TextBox>
			<br />
			<br />
			<asp:Button ID="ButtonSendCode" runat="server" OnClick="ButtonSendCode_Click" Text="Send" Width="89px" BackColor="#CCCCCC" BorderColor="#CCCCCC" Font-Italic="True" />
			<br />
			<asp:Label ID="LblErrorCode" runat="server" ForeColor="Red"></asp:Label>
			<br />
			Verify Code: <br />
			<asp:TextBox ID="CodeVerify" runat="server"></asp:TextBox>
				 <br />
				 <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="Login.aspx">Back To Login</asp:HyperLink>
			<br />
			<asp:Button ID="ButtonVerify" runat="server" OnClick="ButtonVerify_Click" Text="Verify" Width="89px" BackColor="#CCCCCC" BorderColor="#CCCCCC" Font-Italic="True" />
        &nbsp;</div>
				</div>
			 </div>
             
    </form>
</asp:Content>
