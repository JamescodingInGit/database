<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="OperatorDetail.aspx.cs" Inherits="Assignment.OperatorDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Operator Detail</title>
        <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .news-image {
            text-align: center;
        }

        .news-details {
            margin-top: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container">
        <asp:Repeater ID="promotionRepeater" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div class="news-image">
                    <asp:Image ID="promotionImage1" runat="server" ImageUrl='<%# GetImageFromDataBase(Eval("operatorLogo")) %>' Width="50%" Height="40%" />
                </div>

                <div class="news-details">
                    <h1><%# Eval("operatorName") %></h1>
                    <p><%# Eval("operatorDescription") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Operator] WHERE ([operatorID] = @operatorID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="operatorID" QueryStringField="operatorID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
