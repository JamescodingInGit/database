<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="Promotion.aspx.cs" Inherits="Assignment.Promotion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Promotion</title>
    <style>
      
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 2;
        }

      .modal-content {
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            border: 2px solid #757575; 
            border-radius: 10px; 
             
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
        }


        .drpDownMngment {
            position: absolute;
            left: 0;
            top: 0;
            cursor: pointer;
            width: 150px;
            padding: 5px;
            font-size: 14px;
        }


            .drpDownMngment option:selected {
                background-color: #e0e0e0;
                color: #333;
            }

        .auto-style40 {
            position: relative;
            left: 0px;
            top: 0px;
            height: 56px;
            margin: 10px;
        }

        .auto-style41{
             padding: 8px 15px;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            position: absolute;
            top: 0px;
            width: 124px;
            height: 35px;
            left: 842px;
            transition: 0.5s;
        }

        .auto-style41:hover{
             background-color: #f9f9f9;
             border-color: #aaa;
        }

          
            .auto-style42 {
            border-color: inherit;
            border-width: medium;
            padding: 8px 15px;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            position: absolute;
            top: 0px;
           width: 67px;
            height: 35px;
            left: 766px;
            transition: 0.5s;
        }

            .auto-style42:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

              .auto-style43 {
            text-align: center;
            position: absolute;
            left: 972px;
            top: 0;
            appearance: none;
            cursor: pointer;
            padding: 8px 15px;
            font-size: 14.5px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 80px;
            height: 35px;
            transition: 0.5s;
        }

            .auto-style43:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

          .saveButton2 {
            border-color: inherit;
            border-width: medium;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            width: 67px;
            height: 25px;
            transition: 0.5s;
        }

            .saveButton2:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }
        

        .button1 {
            font: bold 11px Arial;
            text-decoration: none;
            padding: 2px 6px 2px 6px;
            border-color: inherit;
            border-width: medium;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            top: 0px;
            width: 67px;
            height: 35px;
            transition: 0.5s;
        }

            .button1:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

        .dropDownRole {
            left: 0;
            top: 0;
            cursor: pointer;
            width: 150px;
            padding: 1px;
            font-size: 14px;
        }

        .gridCss3{
           box-shadow: 5px 8px 5px #6e6e6e;
            margin-left:10px;
        }

           .search-input {
            padding: 8px;
            border: 2px solid #ccc;
            border-radius: 5px;
            margin-right: 8px;
        }

        .search-button {
            padding: 8px 16px;
            background-color: #aaa;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.5s;
        }

        .search-button:hover{
            border: 1px black solid;
        }

         .auto-style44{
           
          
            top: 0;
            cursor: pointer;
            padding: 8px 15px;
            font-size: 14.5px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            width: 160px;
            height: 35px;
            margin-right:10px;
            transition: 0.5s;

        }

        .auto-style44:hover{
             border-color: #737373;
        }

          .auto-style45 {
              display: flex;
              align-items: center;
              position: absolute;
              left: 214px;
              top: 0px;
          }

    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <div class="auto-style40">

        <asp:DropDownList ID="DropDownList6" runat="server" CssClass="auto-style43" OnSelectedIndexChanged="DropDownList6_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem disabled="disabled">Sort :</asp:ListItem>
            <asp:ListItem Value="1">A~Z</asp:ListItem>
            <asp:ListItem Value="2">Z~A</asp:ListItem>
            <asp:ListItem Value="3">NoSort</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="updImage" runat="server" Text="Update Image" OnClientClick="showModalUpd(); return false;" CssClass="auto-style41" />
        <br />
        <br />
      

        <div class="auto-style45">
            <asp:Label ID="Label1" runat="server" Font-Size="15px" ForeColor="#999999" Text="Search By :"></asp:Label>
             &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" CssClass="auto-style44">
                <asp:ListItem>Promotion Title</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-input"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-button" OnClick="btnSearch_Click"/>
             
        </div>


        <asp:Button ID="AddPromotion" runat="server" CssClass="auto-style42" Text="ADD" OnClientClick="showModal(); return false;" />

        <!-- Modal overlay and content -->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <h2>Add Promotion</h2>
                <asp:Label ID="lblModalError" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <table style="width:100%;">
                    <tr>
                        <td>Promotion Title</td>
                        <td>:</td>
                        <td>
                <asp:TextBox ID="txtPromotionTitle" runat="server" placeholder="Promotion Title" CssClass="modal-input" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Promotion Description</td>
                        <td>:</td>
                        <td>
                <asp:TextBox ID="txtPromotionDescription" runat="server" placeholder="Promotion Description" CssClass="modal-input" Height="120px" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Promotion Discount</td>
                        <td>:</td>
                        <td>
                <asp:TextBox ID="txtDiscount" runat="server" placeholder="Discount" CssClass="modal-input"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Promotion Image</td>
                        <td>:</td>
                        <td>
                <asp:FileUpload ID="promotionImage" runat="server" />
           
                        </td>
                    </tr>>
                    <tr>
                        <td>Promotion Date</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtDateFrom" runat="server" type="datetime-local"></asp:TextBox>
                        </td>
                        <td><asp:TextBox ID="txtDateTo" runat="server" type="datetime-local"></asp:TextBox>
           
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
           
                <asp:Button ID="AddPromo" runat="server" Text="Save" CssClass="saveButton2" OnClick="AddPromo_Click" OnClientClick="validateForm();" />
           
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <br />
                <br />
           
            </div>
        </div>

        <br />
        <br />
    </div>

     <div class="modal-overlay" id="modalOverlayUpd">
            <div class="modal-content">
                <h2>Update Promotion Image</h2>
                <asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text="Promotion ID :"></asp:Label>
                <asp:DropDownList ID="dropDownPromotionID" runat="server" DataSourceID="SqlDataSource8" DataTextField="promotionID" DataValueField="promotionID"></asp:DropDownList>
                <br />
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <br />
                <asp:Button ID="Button1" runat="server" Text="Update" OnClick="Button1_Click" />
                <br />
            </div>
        </div>
    
         <div class="modal-overlay" id="modalOverlayImage">
            <div class="modal-content">
                  <asp:Image ID="imgPromotion" runat="server" Visible="false"/>
                  <img id="<%= imgPromotion.ClientID %>" src="" alt="Promotion Image" />
      
            </div>
        </div>


    <div class="overlay" id="overlay" onclick="closeModal()"></div>
    <div class="overlay" id="overlayUpd" onclick="closeModalUpd()"></div>
    <div class="overlay" id="overlayImage" onclick="closeModalImage()"></div>

    <br />
    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [promotionID] FROM [Promotion]"></asp:SqlDataSource>
    <asp:Label ID="Label4" runat="server"></asp:Label>
    <br />
    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False" Width="1075px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" GridLines="Vertical" CssClass="gridCss3" DataKeyNames="promotionID" DataSourceID="SqlDataSource7" OnRowDataBound="promotionRow">
        <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px"/>
        <Columns>
            <asp:BoundField DataField="promotionID" HeaderText="promotionID" InsertVisible="False" ReadOnly="True" SortExpression="promotionID" />
            <asp:BoundField DataField="promotionTitle" HeaderText="promotionTitle" SortExpression="promotionTitle" />
            <asp:BoundField DataField="promotionDescription" HeaderText="promotionDescription" SortExpression="promotionDescription" />
            <asp:BoundField DataField="discount" HeaderText="discount" SortExpression="discount" />
                <asp:BoundField DataField="promotionStartDate" HeaderText="promotionStartDate" SortExpression="promotionStartDate" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="promotionEndDate" HeaderText="promotionEndDate" SortExpression="promotionEndDate" DataFormatString="{0:dd/MM/yyyy}" />
                   <asp:TemplateField HeaderText="Promotion Image">
                <ItemTemplate>
                    <asp:Button ID="btnViewPromotion" runat="server" CommandName="ViewPromotion" CommandArgument='<%# Container.DataItemIndex %>' Text="View" CssClass="button1" OnClientClick='<%# "showModalImage(\"" + GetImageFromDataBase(Eval("promotionImage")) + "\"); return false;" %>'/>
                </ItemTemplate>
            </asp:TemplateField>
               <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True">
            <ControlStyle CssClass="button1" />
            </asp:CommandField>
        </Columns>
       <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" Font-Overline="False" Font-Size="Medium" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px" HorizontalAlign="Center"/>
        <SelectedRowStyle BackColor="#e7a868" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Promotion]" DeleteCommand="DELETE FROM [Promotion] WHERE [promotionID] = @promotionID" InsertCommand="INSERT INTO [Promotion] ([promotionTitle], [promotionDescription], [discount], [promotionImage], [promotionStartDate], [promotionEndDate]) VALUES (@promotionTitle, @promotionDescription, @discount, @promotionImage, @promotionStartDate, @promotionEndDate)" UpdateCommand="UPDATE [Promotion] SET [promotionTitle] = @promotionTitle, [promotionDescription] = @promotionDescription, [discount] = @discount, [promotionStartDate] = @promotionStartDate, [promotionEndDate] = @promotionEndDate WHERE [promotionID] = @promotionID">
        <DeleteParameters>
            <asp:Parameter Name="promotionID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="promotionTitle" Type="String" />
            <asp:Parameter Name="promotionDescription" Type="String" />
            <asp:Parameter Name="discount" Type="Double" />
            <asp:Parameter Name="promotionImage" Type="Object" />
            <asp:Parameter DbType="Date" Name="promotionStartDate" />
            <asp:Parameter DbType="Date" Name="promotionEndDate" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="promotionTitle" Type="String" />
            <asp:Parameter Name="promotionDescription" Type="String" />
            <asp:Parameter Name="discount" Type="Double" />
            <asp:Parameter Name="promotionImage" Type="Object" />
            <asp:Parameter DbType="Date" Name="promotionStartDate" />
            <asp:Parameter DbType="Date" Name="promotionEndDate" />
            <asp:Parameter Name="promotionID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
   </form>



    <script>
        function showModal() {
            document.getElementById('modalOverlay').style.display = 'flex';
        }

        function showModalUpd() {
            document.getElementById('modalOverlayUpd').style.display = 'flex';
        }

        function showModalImage(imageUrl) {

            document.getElementById('modalOverlayImage').style.display = 'flex';
            var imgElement = document.getElementById('<%= imgPromotion.ClientID %>');
            imgElement.src = imageUrl;

        }
        function closeModal() {
            document.getElementById('modalOverlay').style.display = 'none';
        }

        function closeModalUpd() {
            document.getElementById('modalOverlayUpd').style.display = 'none';
        }

        function closeModalImage() {
            document.getElementById('modalOverlayImage').style.display = 'none';
        }

        function overlayClick(event) {
            var modalOverlay = document.getElementById('modalOverlay');
            var modalOverlayUpd = document.getElementById('modalOverlayUpd');
            var modalOverlayImage = document.getElementById('modalOverlayImage');

            if (event.target === modalOverlay) {
                closeModal();
            }

            if (event.target === modalOverlayUpd) {
                closeModalUpd();
            }

            if (event.target === modalOverlayImage) {
                closeModalImage();
            }
        }

        document.getElementById('modalOverlay').addEventListener('click', overlayClick);
        document.getElementById('modalOverlayUpd').addEventListener('click', overlayClick);
        document.getElementById('modalOverlayImage').addEventListener('click', overlayClick);

        function validateForm() {
            var errorMessage = '';

            var txtPromotionTitle = document.getElementById('<%= txtPromotionTitle.ClientID %>').value.trim();
            var txtPromotionDescription = document.getElementById('<%= txtPromotionDescription.ClientID %>').value.trim();
            var txtDiscount = document.getElementById('<%= txtDiscount.ClientID %>').value.trim();
            var fileUpload = document.getElementById('<%= promotionImage.ClientID %>');


            if (txtPromotionTitle === '') {
                errorMessage += 'Please fill in the Promotion Title.\n';
            }

            if (txtPromotionDescription === '') {
                errorMessage += 'Please fill in the Promotion Description.\n';
            }
            if (txtDiscount === '') {
                errorMessage += 'Please fill in the Discount.\n';
            }

            if (fileUpload.files.length === 0) {
                errorMessage += 'Please select a file for the Promotion Image.\n';
            }

            if (errorMessage !== '') {
                alert(errorMessage);
                return false;
            }

            return true;
        }

    </script>
</asp:Content>