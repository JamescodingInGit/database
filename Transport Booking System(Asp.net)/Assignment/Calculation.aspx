<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Calculation.aspx.cs" Inherits="Assignment.Calculation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Calculation</title>
     <style>
        .departing-table {
            border-collapse: collapse;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 0 0 1px #ddd;
            width: 100%;
            margin-bottom: 10px;
        }


        .calculation-table{
            border-collapse: collapse;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 0 0 1px #ddd ;
            width: 150%;
            margin-bottom: 10px;
        }

        td,
        th {
            padding: 6px;
            position: relative;
        }

        .info-parnel {
            display: flex;
        }

        .center-panel {
            text-align: left;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            margin:3% 1% 0 25%;
            width: 30%;
        }

        .right-panel{
            margin:3%;
            text-align: left;
        }
        .payBtt{
            border-radius: 5px;
            font-size: 16px;
            color:white;
            padding: 10px 16px;
            text-align: center;
            border: 1px solid #F0C400;
            background-color: #70266e;
            margin-right:auto;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="calculation" runat="server">
        <div class="info-parnel">
            <div class="center-panel">
                <table class="departing-table" id="departView" runat="server" visible="false"> 
                    <tr class="no-border">
                        <th style="background-color: #f5f5f5; font-size: large; font-weight: 700; text-align: left;">Departure Date: </th>
                    </tr>
                    <tr>
                        <th>Departure Date:</th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDepartDate" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Depart From:</th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDepartFrom" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Arrive At:</th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDepartArrive" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th><asp:Label ID="lblDepartType" runat="server"></asp:Label></th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDepartOperator" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Seat Numbers:</th>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblDepartSeat" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Adult Ticket Unit Price:</th>
                    </tr>
                    <tr>
                        <td>RM <asp:Label ID="lblAdultPriceDepart" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Child Ticket Unit Price:</th>
                    </tr>
                    <tr>
                        <td>RM <asp:Label ID="lblChildPriceDepart" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                <table class="departing-table" id="returnView" runat="server" visible="false">
                    <tr class="no-border">
                        <th style="background-color: #f5f5f5; font-size: large; font-weight: 700; text-align: left;">Return Info: </th>
                    </tr>
                    <tr>
                        <th>Depart Date:</th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReturnDate" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Depart From:</th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReturnFrom" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Arrive At:</th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReturnArrive" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th><asp:Label ID="lblReturnType" runat="server" Text="Label"></asp:Label></th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReturnOperator" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Seat Numbers:</th>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReturnSeat" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Adult Ticket Unit Price:</th>
                    </tr>
                    <tr>
                        <td>RM
                            <asp:Label ID="lblAdultPriceReturn" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Child Ticket Unit Price:</th>
                    </tr>
                    <tr>
                        <td>RM
                            <asp:Label ID="lblChildPriceReturn" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                 <asp:Button ID="bttPay" runat="server" Text="Pay Now" Cssclass="payBtt" PostBackUrl="~/Payment.aspx" />
            </div>
            <div class="right-panel">
                
                <table class="calculation-table">
                    <tr class="no-border">
                        <th style="background-color: #f5f5f5; font-size: large; font-weight: 700; text-align: left;" colspan="2">Payment Info: </th>
                    </tr>
                    <tr>
                        <th>Depart Journey Fare:</th>
                        <td><asp:Label ID="lblDepartFare" runat="server" Text="0.00"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Return Journey Fare:</th>
                         <td><asp:Label ID="lblReturnFare" runat="server" Text="0.00"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Discount:</th>
                         <td><asp:Label ID="lblDiscount" runat="server" Text="0.00"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Adult Ticket</th>
                         <td><asp:TextBox ID="txtAdult" runat="server" AutoPostBack="True" Text="0" type="number"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <th>Child Ticket;</th>
                         <td><asp:TextBox ID="txtChild" runat="server" AutoPostBack="True" Text="0" type="number"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <th>
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label></th>
                    </tr>
                    <tr>
                        <th><b>Total</b></th>
                         <td><asp:Label ID="lblTotal" runat="server" ForeColor="#3399FF" Font-Bold="True">0.00</asp:Label></td>
                    </tr>
                </table>
            </div>
        </div>
        
    </form>
</asp:Content>
