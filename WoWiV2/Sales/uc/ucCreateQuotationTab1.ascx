<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCreateQuotationTab1.ascx.cs"
    Inherits="Sales_uc_ucCreateQuotationTab1" %>
<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .CCSBotton
    {
        font-style: normal;
        width: 80px;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;
        font-weight: 800;
    }
    .style4
    {
        width: 150px;
        text-align: left;
    }
    .style7
    {
        width: 35%;
    }
    .quoEdit tr
    {
        height: 30px;
    }
</style>
<table align="center" class="quoEdit" border="1" cellpadding="0" cellspacing="0"
    width="100%" style="background-color: #EFF3FB">
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF;">
        <th colspan="2">
            EUT
        </th>
    </tr>
    <tr>
        <th class="style4">
            AE Name
        </th>
        <td>
            <asp:DropDownList ID="DropDownListEmp" runat="server" DataSourceID="SqlDataSourceEmp"
                DataTextField="fname" DataValueField="id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [id], [fname] FROM [employee]"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Currency
        </th>
        <td>
            <asp:RadioButtonList ID="RadioButtonListCurrency" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>NTD</asp:ListItem>
                <asp:ListItem Selected="True">USD</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Product Name
        </th>
        <td>
            <asp:TextBox ID="txtProductName" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            產品名稱
        </th>
        <td>
            <asp:TextBox ID="txtCProductName" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Model No.
        </th>
        <td>
            <asp:TextBox ID="txtModelNo" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            型號
        </th>
        <td>
            <asp:TextBox ID="txtCModelNo" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Brand Name
        </th>
        <td>
            <asp:TextBox ID="txtBrandName" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            廠牌
        </th>
        <td>
            <asp:TextBox ID="txtCBrandName" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Model Difference
        </th>
        <td>
            <asp:TextBox ID="txtModelDifference" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            型號差異說明
        </th>
        <td>
            <asp:TextBox ID="txtCModelDifferencev" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
        <th colspan="2">
            Client & Applicant
        </th>
    </tr>
    <tr>
        <th class="style4">
            Client
        </th>
        <td>
            <asp:DropDownList ID="DropDownListClient" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceClient"
                DataTextField="companyname" DataValueField="Id" OnSelectedIndexChanged="DropDownListClient_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [id], [companyname] FROM [clientapplicant] WHERE (([clientapplicant_type] = @clientapplicant_type) OR ([clientapplicant_type] = @clientapplicant_type2))">
                <selectparameters>
                    <asp:Parameter DefaultValue="1" Name="clientapplicant_type" Type="Byte" />
                    <asp:Parameter DefaultValue="3" Name="clientapplicant_type2" Type="Byte" />
                </selectparameters>
                <updateparameters>
                    <asp:Parameter DefaultValue="1" Name="clientapplicant_type" Type="Byte" />
                    <asp:Parameter DefaultValue="3" Name="clientapplicant_type2" Type="Byte" />
                </updateparameters>
            </asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewClient" runat="server" AutoGenerateRows="False" Caption="Client Details"
                DataSourceID="SqlDataSourceClientAddress" Height="50px" CellPadding="4" ForeColor="#333333"
                GridLines="None">
                <alternatingrowstyle backcolor="White" />
                <commandrowstyle backcolor="#D1DDF1" font-bold="True" />
                <editrowstyle backcolor="#2461BF" />
                <fieldheaderstyle backcolor="#DEE8F5" />
                <fields>
                    <asp:BoundField DataField="country_name" HeaderText="Country" />
                    <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
                    <asp:BoundField DataField="c_address" HeaderText="地址" SortExpression="c_address" />
                    <asp:BoundField DataField="main_tel" HeaderText="Tel" SortExpression="main_tel" />
                    <asp:BoundField DataField="main_fax" HeaderText="Fax" SortExpression="main_fax" />
                </fields>
                <footerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <headerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <pagerstyle backcolor="#2461BF" forecolor="White" horizontalalign="Center" />
                <rowstyle backcolor="#EFF3FB" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceClientAddress" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT clientapplicant.address, clientapplicant.c_address, clientapplicant.main_tel, clientapplicant.main_fax, country.country_name FROM clientapplicant LEFT OUTER JOIN country ON clientapplicant.country_id = country.country_id WHERE (clientapplicant.id = @id)">
                <selectparameters>
                    <asp:ControlParameter ControlID="DropDownListClient" Name="id" PropertyName="SelectedValue" />
                </selectparameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Applicant
        </th>
        <td>
            <asp:DropDownList ID="DropDownListApp" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceApp"
                DataTextField="companyname" DataValueField="Id">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceApp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [Id], [companyname] FROM [clientapplicant] WHERE (([clientapplicant_type] = @clientapplicant_type) OR ([clientapplicant_type] = @clientapplicant_type2))">
                <selectparameters>
                    <asp:Parameter DefaultValue="2" Name="clientapplicant_type" Type="Byte" />
                    <asp:Parameter DefaultValue="3" Name="clientapplicant_type2" Type="Byte" />
                </selectparameters>
            </asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewApp" runat="server" AutoGenerateRows="False" Caption="Applicant Details"
                DataSourceID="SqlDataSourceAppAddress" CellPadding="4" ForeColor="#333333" GridLines="None">
                <alternatingrowstyle backcolor="White" />
                <commandrowstyle backcolor="#D1DDF1" font-bold="True" />
                <editrowstyle backcolor="#2461BF" />
                <fieldheaderstyle backcolor="#DEE8F5" />
                <fields>
                <asp:BoundField DataField="country_name" HeaderText="Country" />
                    <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
                    <asp:BoundField DataField="c_address" HeaderText="地址" SortExpression="c_address" />
                    <asp:BoundField DataField="main_tel" HeaderText="Tel" SortExpression="main_tel" />
                    <asp:BoundField DataField="main_fax" HeaderText="Fax" SortExpression="main_fax" />
                </fields>
                <footerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <headerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                <pagerstyle backcolor="#2461BF" forecolor="White" horizontalalign="Center" />
                <rowstyle backcolor="#EFF3FB" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceAppAddress" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT clientapplicant.address, clientapplicant.c_address, clientapplicant.main_tel, clientapplicant.main_fax, country.country_name FROM clientapplicant LEFT OUTER JOIN country ON clientapplicant.country_id = country.country_id WHERE (clientapplicant.id = @id)">
                <selectparameters>
                    <asp:ControlParameter ControlID="DropDownListApp" Name="id" PropertyName="SelectedValue" />
                </selectparameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
        <th colspan="2">
            Billing
        </th>
    </tr>
    <tr>
        <th class="style4">
            Bill Name
        </th>
        <td>
            <asp:TextBox ID="txtBill_Name" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Title
        </th>
        <td>
            <asp:TextBox ID="txtBill_Title" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Company Name
        </th>
        <td>
            <asp:TextBox ID="txtBillCompanyname" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款連絡人
        </th>
        <td>
            <asp:TextBox ID="txtBill_CName" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款連絡人職稱
        </th>
        <td>
            <asp:TextBox ID="txtBill_CTitle" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款公司
        </th>
        <td>
            <asp:TextBox ID="txtBill_CCompanyname" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Phone
        </th>
        <td>
            <asp:TextBox ID="txtBill_Phone" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Email
        </th>
        <td>
            <asp:TextBox ID="txtBill_Email" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Country
        </th>
        <td>
            <asp:TextBox ID="txtBill_Country" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Address
        </th>
        <td>
            <asp:TextBox ID="txtBill_Address" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款公司地址
        </th>
        <td>
            <asp:TextBox ID="txtBill_CAddress" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Payment days
        </th>
        <td>
            <asp:TextBox ID="txtPayment_Days" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Payment Term
        </th>
        <td>
            <asp:DropDownList ID="ddlPayment_Term" runat="server" AutoPostBack="True">
                <asp:ListItem>Net 30</asp:ListItem>
                <asp:ListItem>Cache</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Client Status
        </th>
        <td>
            <asp:TextBox ID="txtClient_Status" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            DHL Acct.
        </th>
        <td>
            <asp:TextBox ID="txtDHL" runat="server" Width="500px">
            </asp:TextBox>
        </td>
    </tr>
</table>
<p style="text-align: center">
    <asp:Button ID="btnSubmit" CssClass="CCSBotton" runat="server" Text="Save" OnClick="btnSubmit_Click"
        OnClientClick="btn();" />
</p>
<%--    </ContentTemplate>
</asp:UpdatePanel>--%>
<asp:Literal ID="ltlMessage" runat="server"></asp:Literal>
<div id="dialog" title="Message" style="display: none;">
    Saved Succeed</div>
