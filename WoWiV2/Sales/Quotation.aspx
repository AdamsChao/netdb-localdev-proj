<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="Quotation.aspx.cs" Inherits="Sales_Quotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
  <style type="text/css">
    .style4
    {
      width: 15%;
      text-align: right;
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
  <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" style="background-color: #EFF3FB">
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
      <th colspan="4">
        Create Quotation
      </th>
    </tr>
    <tr>
      <th class="style4">
        Client
      </th>
      <td>
        <asp:DropDownList ID="ddlClient" runat="server" OnDataBound="ddlClient_DataBound">
        </asp:DropDownList>
      </td>
      <th class="style4">
        Product Name
      </th>
      <td>
        <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
      </td>
    </tr>
    <tr>
      <th class="style4">
        AE Name
      </th>
      <td>
        <asp:DropDownList ID="ddlEmp" runat="server" DataSourceID="SqlDataSourceEmp" DataTextField="empname"
          DataValueField="id" OnDataBound="ddlEmp_DataBound">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
          SelectCommand="SELECT [id], [empname] FROM [vw_GetAEWithoutAccounting]"></asp:SqlDataSource>
      </td>
      <th class="style4">
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
      DataSourceID="SqlDataSourceQuot" Style="text-align: center" Width="100%" AllowSorting="True"
      PageSize="20" AllowPaging="True">
      <Columns>
        <asp:TemplateField ShowHeader="False" Visible="False">
          <ItemTemplate>
            <asp:Button ID="ButtonDel" runat="server" CausesValidation="False" CommandName="Delete"
              Text="刪除" OnClientClick="return confirm('是否確定刪除此報價單?\r請注意：\r一旦報價單刪除後，其所對應之Project資料亦將同步移除!');" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:HyperLinkField DataNavigateUrlFields="Quotation_Version_Id" DataNavigateUrlFormatString="CreateQuotation.aspx?q={0}"
          NavigateUrl="CreateQuotation.aspx" Text="Edit\View" />
        <asp:BoundField DataField="Quotation_Version_Id" HeaderText="Quot. ID" Visible="False" />
        <asp:BoundField DataField="Quotation_No" HeaderText="Quot. No" SortExpression="Quotation_No" />
        <asp:BoundField DataField="Vername" HeaderText="Version" SortExpression="Vername" />
        <asp:BoundField DataField="Quotation_Status_Name" HeaderText="Status" SortExpression="Quotation_Status_Name" />
        <asp:BoundField DataField="code" HeaderText="Client Code" SortExpression="code" Visible="False" />
        <asp:BoundField DataField="companyname" HeaderText="Client Company Name" SortExpression="companyname" />
        <asp:BoundField DataField="Product_Name" HeaderText="Product Name" SortExpression="Product_Name" />
        <asp:BoundField DataField="Model_No" HeaderText="Model No" SortExpression="Model_No" />
        <asp:BoundField DataField="fname" HeaderText="AE" SortExpression="fname" />
        <asp:BoundField DataField="Quotation_OpenDate" HeaderText="Open Date" SortExpression="Quotation_OpenDate"
          DataFormatString="{0:yyyy/MM/dd HH:mm}" />
      </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceQuot" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      SelectCommand="
SELECT vw_Quotation.Quotation_Version_Id, vw_Quotation.Quotation_No, vw_Quotation.Vername, vw_Quotation.Quotation_Status_Name, vw_Quotation.code, vw_Quotation.companyname, vw_Quotation.Product_Name, vw_Quotation.Model_No, vw_Quotation.username, vw_Quotation.Quotation_OpenDate, vw_Quotation.Client_Id, vw_Quotation.fname, vw_Quotation.SalesId 
FROM vw_Quotation 
LEFT OUTER JOIN m_employee_accesslevel ON vw_Quotation.Access_Level_ID = m_employee_accesslevel.accesslevel_id 
WHERE ((m_employee_accesslevel.employee_id = @employee_id) OR (vw_Quotation.Access_Level_ID IS NULL)) 
AND Client_Id like @Client_Id 
AND SalesId like @SalesId 
AND ([Product_Name] LIKE '%' + @Product_Name + '%') 
AND ([Model_No] LIKE '%' + @Model_No + '%') 
ORDER BY vw_Quotation.Quotation_No DESC, vw_Quotation.Vername, vw_Quotation.Model_No "
      DeleteCommand="Delete from Quotation_Version where Quotation_Version_Id = @Quotation_Version_Id">
      <DeleteParameters>
        <asp:Parameter Name="Quotation_Version_Id" />
      </DeleteParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="txtCurrentEmployee_id" Name="employee_id" PropertyName="Text" />
        <asp:ControlParameter ControlID="txtModelNo" DefaultValue="%" Name="Model_No" PropertyName="Text"
          Type="String" />
        <asp:ControlParameter ControlID="txtProductName" DefaultValue="%" Name="Product_Name"
          PropertyName="Text" Type="String" />
        <asp:ControlParameter ControlID="ddlClient" DefaultValue="%" Name="Client_Id" PropertyName="SelectedValue"
          Type="String" />
        <asp:ControlParameter ControlID="ddlEmp" DefaultValue="%" Name="SalesId" PropertyName="SelectedValue"
          Type="String" />
      </SelectParameters>
    </asp:SqlDataSource>
  </p>
</asp:Content>
