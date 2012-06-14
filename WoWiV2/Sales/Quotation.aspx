<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="Quotation.aspx.cs" Inherits="Sales_Quotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .style4
        {
            width: 15%;
            text-align:right;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <p>
        <asp:Button ID="ButtonAdd" runat="server" PostBackUrl="~/Sales/CreateQuotation.aspx"
            Text="Create" />
            <asp:TextBox ID="txtCurrentEmployee_id" runat="server" Visible="false"></asp:TextBox>
          
        <br />
    </p>
    <table align="center" border="1" cellpadding="0" cellspacing="0"  width="100%" style="background-color: #EFF3FB">
        <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
            <th colspan="4">
                Create Quotation
            </th>
        </tr>
        <tr>
            <th  class="style4">
                Client
            </th>
            <td>
                <asp:DropDownList ID="ddlClient" runat="server" >
                </asp:DropDownList>
            </td>
             <th  class="style4">
                Product Name
            </th>
            <td>
                <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th  class="style4">
                AE Name
            </th>
            <td>
                <asp:DropDownList ID="ddlEmp" runat="server" DataSourceID="SqlDataSourceEmp" DataTextField="fname"
                    DataValueField="id" OnDataBound="ddlEmp_DataBound">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                    SelectCommand="SELECT [id], [fname] FROM [employee] where status='Active'"></asp:SqlDataSource>
            </td>
             <th  class="style4">
                Model No
            </th>
            <td>
                <asp:TextBox ID="txtModelNo" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align: center">
                <asp:Button ID="ButtonSearch" runat="server" Text="Search" OnClick="ButtonSearch_Click" />
            </td>
        </tr>
    </table>
    <p>
        Quotation Lists :
        <br />
        <asp:GridView ID="GridViewQuotation" runat="server" AutoGenerateColumns="False" DataKeyNames="Quotation_Version_Id"
            DataSourceID="SqlDataSourceQuot" Style="text-align: center" Width="100%" AllowSorting="True" PageSize="20"
            CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="Quotation_Version_Id" DataNavigateUrlFormatString="CreateQuotation.aspx?q={0}"
                    NavigateUrl="CreateQuotation.aspx" Text="Edit\View" />
                <asp:BoundField DataField="Quotation_No" HeaderText="Quot. No" SortExpression="Quotation_No" />
                <asp:BoundField DataField="Vername" HeaderText="Version" SortExpression="Vername" />
                <asp:BoundField DataField="Quotation_Status_Name" HeaderText="Status" SortExpression="Quotation_Status_Name" />
                <asp:BoundField DataField="code" HeaderText="Client Code" SortExpression="code" 
                    Visible="False" />
                <asp:BoundField DataField="companyname" HeaderText="Client Company Name" SortExpression="companyname" />
                <asp:BoundField DataField="Product_Name" HeaderText="Product Name" SortExpression="Product_Name" />
                <asp:BoundField DataField="Model_No" HeaderText="Model No" SortExpression="Model_No" />
                <asp:BoundField DataField="fname" HeaderText="AE" SortExpression="fname" />
                <asp:BoundField DataField="Quotation_OpenDate" HeaderText="Open Date" SortExpression="Quotation_OpenDate"
                    DataFormatString="{0:yyyy/MM/dd HH:mm}" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceQuot" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            
            
            
            SelectCommand="SELECT vw_Quotation.Quotation_Version_Id, vw_Quotation.Quotation_No, vw_Quotation.Vername, vw_Quotation.Quotation_Status_Name, vw_Quotation.code, vw_Quotation.companyname, vw_Quotation.Product_Name, vw_Quotation.Model_No, vw_Quotation.username, vw_Quotation.Quotation_OpenDate, vw_Quotation.Client_Id, vw_Quotation.fname, vw_Quotation.SalesId FROM vw_Quotation LEFT OUTER JOIN m_employee_accesslevel ON vw_Quotation.Access_Level_ID = m_employee_accesslevel.accesslevel_id WHERE (m_employee_accesslevel.employee_id = @employee_id) OR (vw_Quotation.Access_Level_ID IS NULL) ORDER BY vw_Quotation.Quotation_No DESC, vw_Quotation.Vername, vw_Quotation.Model_No">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtCurrentEmployee_id" Name="employee_id" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
