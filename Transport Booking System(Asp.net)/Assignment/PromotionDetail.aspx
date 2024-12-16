<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="PromotionDetail.aspx.cs" Inherits="Assignment.PromotionDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Promotion Detail</title>
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
                    <asp:Image ID="promotionImage1" runat="server" ImageUrl='<%# GetImageFromDataBase(Eval("promotionImage")) %>' Width="50%" Height="40%" />
                </div>

                <div class="news-details">
                    <h1><%# Eval("promotionTitle") %></h1>
                    <p><strong>From:</strong> <%# Eval("promotionStartDate") %></p>
                    <p><strong>To:</strong> <%# Eval("promotionEndDate") %></p>
                    <p><%# Eval("promotionDescription") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Promotion] WHERE ([promotionID] = @promotionID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="promotionID" QueryStringField="promotionID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
