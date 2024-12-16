<%@ Page Title="" Language="C#" MasterPageFile="~/NestedMasterPage1.master" AutoEventWireup="true" CodeBehind="Operator.aspx.cs" Inherits="Assignment.Operator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Operator</title>
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

        .auto-style50 {
            position: relative;
            left: 0px;
            top: 0px;
            height: 56px;
            margin: 10px;
        }


        .auto-style52 {
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


            .auto-style52:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

        .auto-style53 {
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

            .auto-style53:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }


        .auto-style54 {
            padding: 8px 15px;
            font-size: 14px;
            border: 3px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            color: #333;
            cursor: pointer;
            position: absolute;
            top: 0;
            width: 67px;
            height: 35px;
            left: 766px;
            transition: 0.5s;
        }


            .auto-style54:hover {
                background-color: #f9f9f9;
                border-color: #aaa;
            }

        .auto-style55:hover{
              border-color: #737373;
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




        .button2 {
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

            .button2:hover {
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

        .gridCss2 {
            box-shadow: 5px 8px 5px #6e6e6e;
            margin-left: 10px;
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

            .search-button:hover {
                border: 1px black solid;
            }

        .search-bar {
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
    <div class="auto-style50">
        <asp:DropDownList ID="DropDownList8" runat="server" CssClass="auto-style53" OnSelectedIndexChanged="DropDownList8_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem disabled="disabled">Sort :</asp:ListItem>
            <asp:ListItem Value="1">A~Z</asp:ListItem>
            <asp:ListItem Value="2">Z~A</asp:ListItem>
            <asp:ListItem Value="3">NoSort</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="updImage" runat="server" CssClass="auto-style52" Text="Update Image" OnClientClick="showModalUpd(); return false;" />
        <br />
        <br />
        <div class="search-bar">
            <asp:Label ID="Label1" runat="server" Font-Size="15px" ForeColor="#999999" Text="Search By :"></asp:Label>
             &nbsp;<asp:TextBox ID="txtSearch" runat="server" CssClass="search-input"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="search-button" OnClick="btnSearch_Click" />
        </div>
        <asp:Button ID="AddOperator" runat="server" CssClass="auto-style54" Text="ADD" OnClientClick="showModal(); return false;" />

        <!-- Modal overlay and content -->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <h2>Add Operator</h2>
                <asp:Label ID="lblModalError" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <table style="width: 100%;">
                    <tr>
                        <td>Operator Name</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtOperatorName" runat="server" placeholder="Operator Name" CssClass="modal-input" Width="250px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Operator Description</td>
                        <td>:</td>
                        <td>
                            <asp:TextBox ID="txtOperatorDescription" runat="server" placeholder="Description" CssClass="modal-input" Height="120px" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>Operator Logo</td>
                        <td>:</td>
                        <td>
                            <asp:FileUpload ID="operatorLogoImage" runat="server" />

                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="SaveOperator" runat="server" Text="Save" CssClass="saveButton2" OnClick="SaveOperator_Click1" OnClientClick="validateForm();" />
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <br />
            </div>
        </div>

        <div class="modal-overlay" id="modalOverlayUpd">
            <div class="modal-content">
                <h2>Update Operator Logo</h2>
                <asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <asp:Label ID="Label3" runat="server" Text="Operator ID :"></asp:Label>
                <asp:DropDownList ID="drpDownOperatorID" runat="server" DataSourceID="SqlDataSource7" DataTextField="operatorID" DataValueField="operatorID"></asp:DropDownList>
                <br />
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <br />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Update" />
                <br />
            </div>
        </div>
       
       
         <div class="modal-overlay" id="modalOverlayImage">
            <div class="modal-content">
                  <h2 id="optNm"></h2>
                  <asp:Image ID="imgOperator" runat="server" Visible="false"/>
                  <img id="<%= imgOperator.ClientID %>" src="" alt="Operator Image" />
      
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [operatorID], [operatorName] FROM [Operator]"></asp:SqlDataSource>

        <br />
        <br />
    </div>
    <div class="overlay" id="overlay" onclick="closeModal()"></div>
    <div class="overlay" id="overlayUpd" onclick="closeModalUpd()"></div>
     <div class="overlay" id="overlayImage" onclick="closeModalImage()"></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="1075px" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" GridLines="Vertical" DataKeyNames="operatorID" DataSourceID="SqlDataSource8" AllowPaging="True" CssClass="gridCss2" AllowSorting="True" OnRowCommand="GridView1_RowCommand"><%-- OnRowCommand="GridView1_RowCommand"--%>
        <AlternatingRowStyle BackColor="#DCDCDC" Height="30px" Width="100px" />
        <Columns>
            <asp:BoundField DataField="operatorID" HeaderText="Operator ID" InsertVisible="False" ReadOnly="True" SortExpression="operatorID" />
            <asp:BoundField DataField="operatorName" HeaderText="Operator Name" SortExpression="operatorName" />
            <asp:BoundField DataField="operatorDescription" HeaderText="Operator Description" SortExpression="operatorDescription" />
            <asp:TemplateField HeaderText="Operator Image">
                <ItemTemplate>
                    <asp:Button ID="btnViewOperator" runat="server" CommandName="ViewOperator" CommandArgument='<%# Container.DataItemIndex %>' Text="View" CssClass="button2" OnClientClick='<%# "showModalImage(\"" + GetImageFromDataBase(Eval("operatorLogo")) + "\"); return false;" %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:Button ID="btnDelete" runat="server" CommandName="DeleteOperator" CommandArgument='<%# Eval("operatorID").ToString() %>' CssClass="button5" Text="Delete" Width="85px"  OnClientClick="return OpenConfirmDialog()" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowEditButton="True">
                <ControlStyle CssClass="button2" />
            </asp:CommandField>
        </Columns>
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" Font-Overline="False" Font-Size="Medium" Font-Underline="False" HorizontalAlign="Center" Wrap="False" />
        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        <RowStyle BackColor="#EEEEEE" ForeColor="Black" Height="40px" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#e7a868" Font-Bold="True" ForeColor="Black" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource8" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Operator] WHERE [operatorID] = @operatorID" InsertCommand="INSERT INTO [Operator] ([operatorName], [operatorDescription], [operatorLogo]) VALUES (@operatorName, @operatorDescription, @operatorLogo)" SelectCommand="SELECT * FROM [Operator]" UpdateCommand="UPDATE [Operator] SET [operatorName] = @operatorName, [operatorDescription] = @operatorDescription WHERE [operatorID] = @operatorID">
        <DeleteParameters>
            <asp:Parameter Name="operatorID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="operatorName" Type="String" />
            <asp:Parameter Name="operatorDescription" Type="String" />
            <asp:Parameter Name="operatorLogo" Type="Object" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="operatorName" Type="String" />
            <asp:Parameter Name="operatorDescription" Type="String" />
            <asp:Parameter Name="operatorLogo" Type="Object" />
            <asp:Parameter Name="operatorID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
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
            var imgElement = document.getElementById('<%= imgOperator.ClientID %>');
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

            var txtOperatorName = document.getElementById('<%= txtOperatorName.ClientID %>').value.trim();
            var txtOptDescription = document.getElementById('<%= txtOperatorDescription.ClientID %>').value.trim();
            var fileUpload = document.getElementById('<%= operatorLogoImage.ClientID %>');


            if (txtOperatorName === '') {
                errorMessage += 'Please fill in the Operator Name.\n';
            }

            if (txtOptDescription === '') {
                errorMessage += 'Please fill in the Operator Description.\n';
            }

            if (fileUpload.files.length === 0) {
                errorMessage += 'Please select a file for the Operator Logo.\n';
            }

            if (errorMessage !== '') {
                alert(errorMessage);
                return false;
            }

            return true;
        }

            function OpenConfirmDialog() {
                 // Use confirm dialog to ask the user if they want to proceed
                 var confirmed = confirm('Do you want to delete the operator?');
            if (confirmed == false) {
                alert('Cancel delete!!');
            return false;
                 } else {
                     return true;
                 }

             }

    </script>
</asp:Content>
