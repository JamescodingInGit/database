<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Home</title>
    <style type="text/css">
        .searchSection {
            min-height: 400px;
            padding: 20px 0 10px 0;
            background-position: top center;
            background-repeat: no-repeat;
            background-image: url("Image/home2.jpg");
            background-size: cover;
        }

            .searchSection h3 {
                color: white;
                margin-left: 10%;
            }

            .searchSection h4 {
                color: white;
                margin: 2% 0 0 4%;
                font-size: 14px;
                text-decoration: underline #F0C400 3px;
            }

        .searchBar {
            margin-top: 15px;
            margin-bottom: 0px;
            margin-left: 10%;
            margin-right: 10%;
            padding: 15px 0 15px 0;
            background: rgba(35, 30, 38, 0.9);
            color: #fff;
            font-size: 13px;
            z-index: 99;
        }

        .productTab {
            padding-left: 0.5%;
            padding-right: 0.5%;
        }

            .productTab li a {
                padding: 3% 4% 3% 4%;
                display: block;
                text-decoration: none;
                color: white;
            }

                .productTab li a:hover {
                    color: black;
                }

            .productTab li {
                display: inline-block;
                width: 16%;
                padding: 3% 4% 3% 4%;
                text-align: center;
                background-color: #45444a;
                border-radius: 5px;
                font-size: 14px;
            }

                .productTab li:hover {
                    background-color: #F0C400;
                }

        .selected {
            background-color: #F0C400 !important;
            color: black !important;
        }

        .rblTrip {
            margin: 0 0 0 4%;
        }

        .searchBtt{
            border-radius: 0px;
            font-size: 16px;
            padding: 7px 12px;
            border: 1px solid #F0C400;
            background-color: #F0C400;
            width:100%;
            cursor:pointer;
        }

        .searchBtt:hover{
            background-color:#fcd41e;
        }
        
        .promotionSection{
            min-height: 100px;
            padding: 20px 9% 10px 9%;
        }

        .promotionSection ul{
            padding-left:1.5%;
        }

        .promotionSection li{
            display: inline-block;
            width: 15%;
            padding: 3% 4% 3% 4%;
            border:2px solid #d3d3d3;
            border-radius:5px;
        }

        .promotionSection li a{
            font-size:13px;
        }

        .promotionSlideSection{
            min-height: 200px;
            padding: 20px 10% 10px 10%;
        }

        .promotionItem{
            display: none;
            width:31%;
        }

        .promotionItem img{
            height:100%;
            width:100%;
            display:block;
        }

        .prev, .next {
            cursor: pointer;
            position: absolute;
            width: auto;
            margin-top: 100px;
            padding: 16px;
            color: black;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
            box-shadow:rgba(0, 0, 0, 0.25) 0px 2px 4px;
        }

        .next {
            right: 10.5%;
        }

        .prev {
            left: 6%;
        }

        .active{
            display: inline-block;
        }

        .auto-style2 {
            height: 20px;
            width: 40px;
        }

        .auto-style9 {
            height: 20px;
            width: 200px;
        }

        .auto-style11 {
            height: 20px;
            width: 230px;
        }

        .auto-style12 {
            height: 20px;
            width: 235px;
        }

        .searchTable {
            width: 1120px;
            padding:0 3.5% 0 3.5%;
        }
    </style>
    <script language="javascript" type="text/javascript">
        let slideIndex = 0;
        let slides = document.getElementsByClassName("promotionItem");
        window.onload = pageLoad;

        function pageLoad() {
            showSlides(slideIndex);
        }

        function plusSlides(n) {
            let newSlideIndex = slideIndex + n;

            if (newSlideIndex >= slides.length / 3) {
                slideIndex = 0;
            } else if (newSlideIndex < 0) {
                slideIndex = Math.floor(slides.length / 3) - 1;
            } else {
                slideIndex = newSlideIndex;
            }

            showSlides(slideIndex);
        }

        function showSlides(n) {
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }

            let startIndex = n * 3;
            let endIndex = startIndex + 3;

            if (endIndex > slides.length) {
                startIndex = 0;
                endIndex = Math.min(3, slides.length);
            }

            for (let i = startIndex; i < endIndex; i++) {
                slides[i].style.display = "inline-block";
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="search" runat="server">
         <div class="searchSection">
            <h3>Largest Land & Sea Ticketing Website</h3>
            <div class="searchBar">

                <asp:MultiView ID="transportView" runat="server">

                    <asp:View ID="busView" runat="server">
                        <div class="productTab">
                            <ul>
                                <li class="selected">
                                    <asp:HyperLink ID="busViewLink1" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=bus"><i class="fa-solid fa-bus"></i>
                                    <br />
                                    <br />
                                    Bus Ticket</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="trainLink1" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=train"><i class="fa-solid fa-train"></i>
                                    <br />
                                    <br />
                                    Train Ticket</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="ferryLink1" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=ferry"><i class="fa-solid fa-ferry"></i>
                                    <br />
                                    <br />
                                    Ferry and Fastboat Ticket</asp:HyperLink></li>
                            </ul>
                        </div>
                        <h4>Bus Ticket</h4>
                    </asp:View>

                    <asp:View ID="trainView" runat="server">
                        <div class="productTab">
                            <ul>
                                <li>
                                    <asp:HyperLink ID="busViewLink2" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=bus"><i class="fa-solid fa-bus"></i>
                                    <br />
                                    <br />
                                    Bus Ticket</asp:HyperLink></li>
                                <li class="selected">
                                    <asp:HyperLink ID="trainLink2" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=train"><i class="fa-solid fa-train"></i>
                                    <br />
                                    <br />
                                    Train Ticket</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="ferryLink2" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=ferry"><i class="fa-solid fa-ferry"></i>
                                    <br />
                                    <br />
                                    Ferry and Fastboat Ticket</asp:HyperLink></li>
                            </ul>
                        </div>
                        <h4>Train Ticket</h4>
                    </asp:View>

                    <asp:View ID="ferryBoatView" runat="server">
                        <div class="productTab">
                            <ul>
                                <li>
                                    <asp:HyperLink ID="busViewLink3" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=bus"><i class="fa-solid fa-bus"></i>
                                    <br />
                                    <br />
                                    Bus Ticket</asp:HyperLink></li>
                                <li>
                                    <asp:HyperLink ID="trainLink3" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=train"><i class="fa-solid fa-train"></i>
                                    <br />
                                    <br />
                                    Train Ticket</asp:HyperLink></li>
                                <li class="selected">
                                    <asp:HyperLink ID="ferryLink3" runat="server" CssClass="first-link" NavigateUrl="~/Home.aspx?transport=ferry"><i class="fa-solid fa-ferry"></i>
                                    <br />
                                    <br />
                                    Ferry and Fastboat Ticket</asp:HyperLink></li>
                            </ul>
                        </div>
                        <h4>Ferry and Boat Ticket</h4>
                    </asp:View> 

                </asp:MultiView>

                <asp:RadioButtonList ID="rblTrip" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" CssClass="rblTrip" OnSelectedIndexChanged="rblTrip_SelectedIndexChanged">
                    <asp:ListItem>OneWay</asp:ListItem>
                    <asp:ListItem Selected="True">RoundTrip</asp:ListItem>
                </asp:RadioButtonList>

                <table class="searchTable">
                    <tr>
                        <td class="auto-style11">
                            <p>From</p>
                        </td>
                        <td class="auto-style2"></td>
                        <td class="auto-style12">
                            <p>To</p>
                        </td>
                        <td class="auto-style9">
                            <p>Departure Date</p>
                        </td>
                        <td class="auto-style9">
                            <asp:Label ID="returnText" runat="server" Text="Return Date"></asp:Label>
                        </td>
                        <td ></td>
                    </tr>
                    <tr>
                        <td class="auto-style11">
                            <asp:TextBox ID="txtFrom" runat="server" Height="30px" Width="200px"></asp:TextBox>
                            <br />
                        </td>
                        <td class="auto-style2"></td>
                        <td class="auto-style12">
                            <asp:TextBox ID="txtTo" runat="server" Height="30px" Width="200px"></asp:TextBox>
                        </td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtDateFrom" runat="server" type="date" Height="30px" Width="150px"></asp:TextBox>
                        </td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtDateTo" runat="server" type="date" Height="30px" Width="150px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="bttSearch" runat="server" Text="Search" CssClass="searchBtt" OnClick="bttSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style11" colspan="6">
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                        </td>
  
                    </tr>
                </table>

            </div>
        </div>

        <div class="promotionSlideSection">
        <asp:Repeater ID="promotionRepeater" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div class="promotionItem">
                    <asp:HyperLink ID="promotionLink" runat="server" NavigateUrl='<%# "PromotionDetail.aspx?promotionID=" + Server.UrlEncode(Eval("promotionID").ToString()) %>'>
                        <asp:Image ID="promotionImage1" runat="server" ImageUrl='<%# GetImageFromDataBase(Eval("promotionImage")) %>' />
                        <asp:Label ID="promotionLabel" runat="server" Text='<%# Eval("promotionTitle") %>'></asp:Label>
                    </asp:HyperLink>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:HyperLink ID="prevSlide" runat="server" CssClass="prev" onclick="plusSlides(-1)">❮</asp:HyperLink>
        <asp:HyperLink ID="nextSlide" runat="server" CssClass="next" onclick="plusSlides(1)">❯</asp:HyperLink>
    </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT *
FROM [Promotion]
WHERE GETDATE() &gt;= promotionStartDate AND GETDATE() &lt;=promotionEndDate
"></asp:SqlDataSource>
        </form>
</asp:Content>
