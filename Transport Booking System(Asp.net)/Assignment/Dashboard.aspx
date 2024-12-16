<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Assignment.Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <style>
        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin: 20px;
        }

        .box {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 10px;
            flex: 1;
            max-width: 300px;
            text-align: center;
        }

            .box h2 {
                color: #333;
            }

            .box p {
                color: #666;
            }

        .container1 {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            padding: 20px;
        }

        .graph-container {
            width: 400px;
            height: 400px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin: 20px;
            padding: 20px;
            box-sizing: border-box;
            overflow: hidden; 
        }

            .textCss{
            font-size:24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="box">
            <h2>Total Users</h2><br/>
             <p class="textCss" id="totalUsers" runat="server"></p>
        </div>
        <div class="box">
            <h2>Total&nbsp;Ticket In Year</h2>
             <p class="textCss" id="totalTicket" runat="server"></p>
        </div>
        <div class="box">
            <h2>Total Sales In Year</h2>
            <p class="textCss" id="totalSales" runat="server"></p>
        </div>
        <div class="box">
            <h2>Total Operator </h2><br/>
             <p class="textCss" id="totalOperator" runat="server"></p>
        </div>

        <div class="container1">

            <div class="graph-container">
                <p>Ticket Booking Each Month in this Year</p>
                <asp:Chart ID="Chart3" runat="server" Height="201px" Width="350px" DataSourceID="SqlDataSource1">
                    <Series>
                        <asp:Series Name="Series1" XValueMember="PurchaseMonth" YValueMembers="TicketCount"></asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>

                <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT MONTH([purchaseDateTime]) AS PurchaseMonth, COUNT(*) AS TicketCount
FROM [dbo].[Ticket]
GROUP BY MONTH([purchaseDateTime]);"></asp:SqlDataSource>
                <br />
            </div>

            <div class="graph-container">
                <p>Number of Transport Type in this Year</p>
                <asp:Chart ID="Chart4" runat="server" Height="201px" Width="350px">
                    <Series>
                        <asp:Series Name="Series1"></asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
                <br />
                <br />
            </div>
        </div>

    </div>
</asp:Content>
