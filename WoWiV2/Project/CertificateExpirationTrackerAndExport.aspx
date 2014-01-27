<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" EnableEventValidation="false"
  CodeFile="CertificateExpirationTrackerAndExport.aspx.cs" Inherits="Project_CertificateExpirationTrackerAndExport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
  <script type="text/javascript">
    $(document).ready(function () {
      $("[id*=txt_certificate_issue_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=txt_certificate_expiry_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
    });
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <asp:Panel ID="PanelSearch" runat="server" GroupingText="Certificate Expiration Tracker Search Condition (Target Status is Done or Delay)">
    Certificate Date : Start
    <asp:TextBox ID="txt_certificate_issue_date" runat="server" />
    <asp:CompareValidator ID="CV1" runat="server" ControlToValidate="txt_certificate_issue_date"
      Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
      Type="Date" ForeColor="Red"></asp:CompareValidator>
    ~ Expiry
    <asp:TextBox ID="txt_certificate_expiry_date" runat="server" />
    <asp:CompareValidator ID="CV2" runat="server" ControlToValidate="txt_certificate_expiry_date"
      Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
      Type="Date" ForeColor="Red"></asp:CompareValidator>
    <br />
    <br />
    Project No:
    <asp:DropDownList ID="DropDownListPO" runat="server" DataSourceID="SqlDataSourceProject"
      DataTextField="Project_Name" DataValueField="Project_Id" AppendDataBoundItems="True">
      <asp:ListItem Value="%">- All -</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Country Manager :
    <asp:DropDownList ID="DropDownListCM" runat="server" AppendDataBoundItems="True"
      DataSourceID="SqlDataSourceCM" DataTextField="fname" DataValueField="id">
      <asp:ListItem Value="0">- All -</asp:ListItem>
    </asp:DropDownList>
    &nbsp;AE :
    <asp:DropDownList ID="DropDownListAE" runat="server" AppendDataBoundItems="True"
      DataSourceID="SqlDataSourceAE" DataTextField="empname" DataValueField="id">
      <asp:ListItem Value="%">- All -</asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceAE" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      SelectCommand="SELECT [id],  empname FROM vw_GetAEWithoutAccounting"></asp:SqlDataSource>
    <br />
    <br />
    Region :
    <asp:DropDownList ID="DropDownListRegion" runat="server" AppendDataBoundItems="True"
      AutoPostBack="True" DataSourceID="SqlDataSourceRegion" DataTextField="world_region_name"
      DataValueField="world_region_id">
      <asp:ListItem Value="0">- All -</asp:ListItem>
    </asp:DropDownList>
    Country :
    <asp:DropDownList ID="DropDownListCountry" runat="server" DataSourceID="SqlDataSourceCountry"
      DataTextField="country_name" DataValueField="country_name" OnDataBound="DropDownListCountry_DataBound">
    </asp:DropDownList>
    &nbsp;<br />
    <br />
    Client :
    <asp:DropDownList ID="DropDownListClient" runat="server" AppendDataBoundItems="True"
      DataSourceID="SqlDataSourceClient" DataTextField="companyname" DataValueField="id">
      <asp:ListItem Value="%">- All -</asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      SelectCommand="SELECT [id], [companyname] FROM [clientapplicant] Where clientapplicant_type = 1 or clientapplicant_type = 3 order by companyname">
    </asp:SqlDataSource>
    Model :
    <asp:TextBox ID="TextBoxModel" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Search" />
    <asp:Button ID="btn_export" runat="server" OnClick="btn_export_Click" Text="Export Data To Excel" />
  </asp:Panel>
  <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
  <br />
  <asp:Panel ID="PanelReport" runat="server">
    <asp:GridView ID="GridViewProjectTarget" runat="server" AutoGenerateColumns="False"
      DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceTarget" PageSize="20"
      Width="100%" EmptyDataText="No Data!" OnRowDataBound="GridViewProjectTarget_RowDataBound"
      AllowPaging="True" EnableTheming="False">
      <Columns>
        <asp:TemplateField HeaderText="ID" InsertVisible="False" Visible="False">
          <ItemTemplate>
            <asp:Label ID="LabelTarget" runat="server" Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Project No" SortExpression="Project_No">
          <ItemTemplate>
            <asp:Label ID="LabelNo" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
            <asp:HiddenField ID="HFCountry" runat="server" Value='<%# Bind("country_id") %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="world_region_name" HeaderText="Region" Visible="False" />
        <asp:BoundField DataField="country_name" HeaderText="Country" SortExpression="country_name" />
        <asp:BoundField DataField="authority_name" HeaderText="Target" 
          SortExpression="authority_name" />
        <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client" />
        <asp:BoundField DataField="Model_No" HeaderText="Model No." />
        <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
        <asp:BoundField DataField="target_description" HeaderText="T.Description" Visible="False" />
        <asp:BoundField DataField="test_started" HeaderText="Test Started" SortExpression="test_started"
          Visible="False" DataFormatString="{0:d}" />
        <asp:BoundField DataField="test_completed" HeaderText="Test Completed" SortExpression="test_completed"
          Visible="False" DataFormatString="{0:d}" />
        <asp:BoundField DataField="certification_submit_to_authority" HeaderText="Certification Submit To Authority"
          Visible="False" SortExpression="certification_submit_to_authority" DataFormatString="{0:d}" />
        <asp:BoundField DataField="certification_completed" HeaderText="Certification Completed"
          Visible="False" SortExpression="certification_completed" DataFormatString="{0:d}" />
        <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated Lead Time"
          SortExpression="Estimated_Lead_time" Visible="False" />
        <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" Visible="False" />
        <asp:TemplateField HeaderText="Agent" SortExpression="Agent" Visible="False">
          <EditItemTemplate>
            <asp:TextBox ID="TextBoxAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="LabelAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Country Manager" Visible="False">
          <EditItemTemplate>
            <asp:Label ID="LabelCM" runat="server" Text='<%# Eval("CountryManager") %>'></asp:Label>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:Label ID="LabelCM0" runat="server" Text='<%# Bind("CountryManager") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="AE" HeaderText="AE" SortExpression="AE" Visible="False" />
        <asp:BoundField DataField="certificate_type" HeaderText="Certification Type" />
        <asp:TemplateField HeaderText="Certificate Issue Date">
          <ItemTemplate>
            <asp:Label ID="lbl_certificate_issue_date" runat="server" 
              Text='<%# Bind("certificate_issue_date", "{0:d}") %>'></asp:Label>
          </ItemTemplate>          
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Certificate Expiry Date">
          <ItemTemplate>
            <asp:Label ID="lbl_certificate_expiry_date" runat="server" 
              Text='<%# Bind("certificate_expiry_date", "{0:d}") %>'></asp:Label>
              <asp:CheckBox ID="cb_Lifetime" runat="server" Text="Lifetime" Checked='<%# Bind("Lifetime") %>' Visible="false" />
          </ItemTemplate>         
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Certificate Duration">
          <ItemTemplate>
            <asp:Label ID="lbl_certificate_duration" runat="server"></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Time until Expiration">
          <ItemTemplate>
            <asp:Label ID="lbl_time_until_expiration" runat="server"></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Today's Date">
          <ItemTemplate>
            <asp:Label ID="lbl_today_date" runat="server"></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="email_renewal_notice_date" HeaderText="Email Renewal Notice Date"
          DataFormatString="{0:d}" Visible="False" />
        <asp:TemplateField HeaderText="Renewal Confirmation Check">
          <ItemTemplate>
            <asp:Label ID="lbl_renewal_confirmation_check" runat="server" Text='<%# Bind("renewal_confirmation_check") %>'></asp:Label>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="conduct_renewal_action_date" HeaderText="Conduct Renewal Action Date"
          DataFormatString="{0:d}" />
      </Columns>
    </asp:GridView>
  </asp:Panel>
  <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager 
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent 
, country.country_name, Authority.authority_name ,world_region.world_region_name 
, (Select fname + ' ' + lname as cmname from employee where id = Country_Manager ) as CountryManager 
, Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No 
, SalesId , Employee.fname + ' ' + lname  as 'AE' 
, Client_Id , clientapplicant.companyname as 'Client' 
, [certificate_type],[certificate_issue_date],[certificate_expiry_date]
, [email_renewal_notice_date],[renewal_confirmation_check],[conduct_renewal_action_date],[Lifetime]
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN world_region ON world_region.world_region_id = country.world_region_id
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN Quotation_Version ON Quotation_Version.Quotation_Version_Id = Quotation_Target.quotation_id AND Quotation_Status=5
INNER JOIN Project ON Project.Quotation_No = Quotation_Version.Quotation_No
INNER JOIN Employee ON Employee.id = Quotation_Version.SalesId
INNER JOIN clientapplicant ON Quotation_Version.Client_Id = clientapplicant.id 
WHERE (Project.Project_ID LIKE @Project_ID)  
AND (Quotation_Target.Status = 'Done' OR Quotation_Target.Status = 'Delay') 
AND (country.country_name LIKE @country_name ) 
AND (SalesId  LIKE @SalesId) 
AND (Client_Id  LIKE @Client_Id) 
AND (Model_No LIKE  '%' + @Model_No + '%')
" OnSelecting="SqlDataSourceTarget_Selecting">
    <SelectParameters>
      <asp:ControlParameter ControlID="DropDownListPO" DefaultValue="%" Name="Project_ID"
        PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListCountry" DefaultValue="%" Name="country_name"
        PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListAE" DefaultValue="%" Name="SalesId"
        PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListClient" DefaultValue="%" Name="Client_Id"
        PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="TextBoxModel" DefaultValue="%" Name="Model_No" PropertyName="Text" />
    </SelectParameters>
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceCM" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT [id],fname + ' ' + lname as [fname] FROM [employee] where status='Active'">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT [Project_Id],[Project_Name] FROM vw_GetProjectLists  Order By Companyname , Project_Id desc">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT [world_region_id], [world_region_name] FROM [world_region]">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT [country_id], [country_name] FROM [country] WHERE ([world_region_id] = @world_region_id) order by country_name">
    <SelectParameters>
      <asp:ControlParameter ControlID="DropDownListRegion" Name="world_region_id" PropertyName="SelectedValue"
        Type="Byte" />
    </SelectParameters>
  </asp:SqlDataSource>
</asp:Content>
