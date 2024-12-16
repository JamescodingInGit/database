<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Assignment.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Payment</title>
    <style>
        .payment{
            font-size:13px;
            margin:0 30%;
        }

        .auto-style2 {
            color: #000080;
        }

        .auto-style4 {
            height: 26px;
            width: 492px;
        }

        .auto-style15 {
            height: 50px;
        }

        .auto-style16 {
            height: 26px;
            width: 139px;
        }

        .auto-style17 {
            width: 139px;
        }

        .auto-style18 {
            text-align: center;
            width: 290px;
        }

        .auto-style12 {
            width: 492px;
            text-align: left;
        }

        .txtcard {
            letter-spacing: 1px;
            font-size: 14px;
            box-sizing: border-box;
            width: 250px;
            height: 35px;
            border-radius: 5px;
            border: 1px solid rgb(0 0 0);
            background: rgb(255 255 255);
            outline: none;
            padding: 0 12px;
            color: rgb(10 10 10);
            transition: 0.2s;
            margin-bottom: 10px;
        }

        .auto-style19 {
            height: 23px;
        }

        .auto-style20 {
            height: 25px;
        }

        .auto-style21 {
            height: 28px;
        }

        .auto-style22 {
            text-align: right;
        }

        .auto-style24 {
            height: 70px;
        }
    </style>
    <script>
        function formatDate(input) {
            var val = input.value.replace(/\D/g, ''); // Remove non-numeric characters
            if (val.length > 2) {
                input.value = val.substring(0, 2) + '/' + val.substring(2);
            } else {
                input.value = val;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <form id="form1" runat="server">
        <div class="payment">
            <div class="auto-style2" style="color: #313848; font-weight: bolder; text-decoration: underline;">
                Billing<br />
            </div>
            <table>
                <tr>
                    <td class="auto-style12" style="font-weight: bold">Please choose yuour payment method :
						<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" CssClass="txtcard" Height="20px" Width="140px">
                            <asp:ListItem>credit / debit card</asp:ListItem>
                            <asp:ListItem>pay at counter</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                            <asp:View ID="View1" runat="server">

                                <table style="border-width: 2px; border-style: outset; width: 100%;">
                                    <tr>
                                        <td class="auto-style37" style="font-weight: bolder; margin-top: 5%; color: #181714; margin-bottom: 5%;">&nbsp;</td>
                                        <td class="auto-style15" colspan="3" style=" font-weight: bolder; margin-top: 5%; color: #181714; margin-bottom: 5%;">Credit / Debit Card </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style28" style="font-weight: bolder; margin-top: 5%; color: #181714; margin-bottom: 5%;"></td>
                                        <td class="auto-style29" colspan="3" style="font-weight: bolder; margin-top: 5%; color: #181714; margin-bottom: 5%;"></td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style37">&nbsp;</td>
                                        <td class="auto-style16" style="">Card Number </td>
                                        <td class="auto-style20">:</td>
                                        <td class="auto-style33">
                                            <asp:TextBox ID="txtCardNumber" runat="server" CssClass="txtcard"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style37">&nbsp;</td>
                                        <td class="auto-style16" style="">&nbsp;</td>
                                        <td class="auto-style20">&nbsp;</td>
                                        <td class="auto-style33">
                                            <asp:Label ID="lblMessage1" runat="server" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style31">&nbsp;</td>
                                        <td class="auto-style19" style="">Expiring Date </td>
                                        <td class="auto-style21">:</td>
                                        <td class="auto-style34">
                                            <asp:TextBox ID="txtExpireDate" runat="server" type="text" CssClass="txtcard" oninput="formatDate(this)" MaxLength="5"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style31">&nbsp;</td>
                                        <td class="auto-style19" style="">&nbsp;</td>
                                        <td class="auto-style21">&nbsp;</td>
                                        <td class="auto-style34">
                                            <asp:Label ID="lblMessage2" runat="server" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style38">&nbsp;</td>
                                        <td class="auto-style17">CVV Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
                                        <td class="auto-style23">:</td>
                                        <td class="auto-style34">
                                            <asp:TextBox ID="txtCCV" runat="server" CssClass="txtcard"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style38">&nbsp;</td>
                                        <td class="auto-style17">&nbsp;</td>
                                        <td class="auto-style23">&nbsp;</td>
                                        <td class="auto-style34">
                                            <asp:Label ID="lblMessage3" runat="server" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style38">&nbsp;</td>
                                        <td class="auto-style17">&nbsp;</td>
                                        <td class="auto-style23">&nbsp;</td>
                                        <td class="auto-style18">
                                            <div class="checkOut">
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<asp:Button ID="Button1" runat="server" Text="CheckOut" CssClass="txtcard" BackColor="#0066CC" BorderColor="#0033CC" Font-Italic="True" Font-Size="Medium" ForeColor="#FFFFCC" Width="120px" OnClick="Button1_Click" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <table style="border-width: 2px; border-style: outset; width: 100%;">
                                    <tr>
                                        <td style="font-weight: bolder; color: #3366FF; text-align: justify" class="auto-style24"></td>
                                        <td style="font-weight: bolder; color: #333333; text-align: justify" class="auto-style24">You need to go depature station that you select and make the payment at counter.</td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style20" style="color: #FF0000"></td>
                                        <td class="auto-style20" style="color: #FF0000">Do you confirm ?</td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style21"></td>
                                        <td class="auto-style21">
                                            <asp:RadioButtonList ID="rblSelect" runat="server" RepeatDirection="Horizontal" Width="156px">
                                                <asp:ListItem>yes</asp:ListItem>
                                                <asp:ListItem>no</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td class="auto-style22">
                                            <asp:Button ID="Button2" runat="server" BackColor="#0066CC" BorderColor="#0033CC" CssClass="txtcard" Font-Italic="True" Font-Size="Medium" ForeColor="#FFFFCC" Height="25px" Text="CheckOut" Width="120px" OnClick="Button2_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                &nbsp;
                            </asp:View>
                            <asp:View ID="View3" runat="server">
                                <table style="border-width: 2px; border-style: outset; width: 100%;">
                                    <tr>
                                        <td style="font-weight: bolder; color: #3366FF; text-align: justify" class="auto-style24"></td>
                                        <td style="font-weight: bolder; color: #333333; text-align: justify" class="auto-style24">Payment Successful</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td class="auto-style22">
                                            <asp:Button ID="Button3" runat="server" BackColor="#0066CC" BorderColor="#0033CC" CssClass="txtcard" Font-Italic="True" Font-Size="Medium" ForeColor="#FFFFCC" Height="25px" Text="Next" Width="120px" OnClick="Button3_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                &nbsp;
                            </asp:View>
                        </asp:MultiView>
                    </td>
                </tr>
            </table>


        </div>
    </form>
</asp:Content>
