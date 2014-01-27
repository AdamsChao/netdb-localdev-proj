<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="ProjectWorkingStatus.aspx.cs" Inherits="Project_ProjectWorkingStatus"
  MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxcontroltoolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
  <script type="text/javascript">
    $(function () {
      $("#accordion").accordion({
        collapsible: true,
        heightStyle: "content"
      });

//      $('.open').click(function () {
//        $('.ui-accordion-header').removeClass('ui-corner-all').addClass('ui-accordion-header-active ui-state-active ui-corner-top').attr({ 'aria-selected': 'true', 'tabindex': '0' });
//        $('.ui-accordion-header .ui-icon').removeClass('ui-icon-triangle-1-e').addClass('ui-icon-triangle-1-s');
//        $('.ui-accordion-content').addClass('ui-accordion-content-active').attr({ 'aria-expanded': 'true', 'aria-hidden': 'false' }).show();
//        $(this).hide();
//        $('.close').show();
//      });
//      $('.close').click(function () {
//        $('.ui-accordion-header').removeClass('ui-accordion-header-active ui-state-active ui-corner-top').addClass('ui-corner-all').attr({ 'aria-selected': 'false', 'tabindex': '-1' });
//        $('.ui-accordion-header .ui-icon').removeClass('ui-icon-triangle-1-s').addClass('ui-icon-triangle-1-e');
//        $('.ui-accordion-content').removeClass('ui-accordion-content-active').attr({ 'aria-expanded': 'false', 'aria-hidden': 'true' }).hide();
//        $(this).hide();
//        $('.open').show();
//      });
//      $('.ui-accordion-header').click(function () {
//        $('.open').show();
//        $('.close').show();
//      });

//      // Expand/Collapse all
//      $('.accordion-expand-collapse a').click(function () {
//        $('.accordion .ui-accordion-header:not(.ui-state-active)').next().slideToggle();
//        $(this).text($(this).text() == 'Expand all' ? 'Collapse all' : 'Expand all');
//        $(this).toggleClass('collapse');
//        return false;
//      });

      //紀錄是哪一個accordion要展開
      var status = $("[id*=HFAccordionStatus]").val();
      $('#accordion').accordion('option', 'active', parseInt(status));
    });
  </script>
  <script type="text/javascript">

    $(document).ready(function () {

      $("[id*=TextBox_certificate_issue_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_certificate_expiry_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_email_renewal_notice_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_conduct_renewal_action_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_sample_received_from_client_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_sample_returned_to_client_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_original_certificate_mailed_to_client_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_returned_of_tested_sample_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });
      $("[id*=TextBox_original_certificate_received_date]").datepicker({
        showOn: "button",
        buttonImage: "../Images/Calendar_scheduleHS.png",
        buttonImageOnly: true,
        dateFormat: "yy/mm/dd"
      });

      //Sample Can be Returned from Authority using radioButtonlist
      if ($("[id*=rb_sample_returned_authority]:checked").val() == "1") {
        $("[id*=div_sample_return]").fadeIn(300);
      }
      $("[id*=rb_sample_returned_authority]").click(function () {
        if ($("[id*=rb_sample_returned_authority]:checked").val() == "1") {
          $("[id*=div_sample_return]").fadeIn(300);
        }
        else {
          $("[id*=div_sample_return]").fadeOut(300);
        }
      });

      //customer_request_sample_returned using radiobuttonlist
      if ($("[id*=rb_sample_returned]:checked").val() == "1") {
        $("[id*=div_customer_request_sample_returned]").fadeIn(300);
      }
      $("[id*=rb_sample_returned]").click(function () {
        if ($("[id*=rb_sample_returned]:checked").val() == "1") {
          $("[id*=div_customer_request_sample_returned]").fadeIn(300);
        }
        else {
          $("[id*=div_customer_request_sample_returned]").fadeOut(300);
        }
      });

      //customer_request_original_certificate_returned using radiobuttonlist
      if ($("[id*=rb_certificate_returned]:checked").val() == "1") {
        $("[id*=div_customer_request_original_certificate_returned]").fadeIn(300);
      }
      $("[id*=rb_certificate_returned]").click(function () {
        if ($("[id*=rb_certificate_returned]:checked").val() == "1") {
          $("[id*=div_customer_request_original_certificate_returned]").fadeIn(300);
        }
        else {
          $("[id*=div_customer_request_original_certificate_returned]").fadeOut(300);
        }
      });

    });
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <%--<div class="accordion-expand-holder">
    <button type="button" class="open">
      Expand all</button>
    <button type="button" class="close">
      Collapse all</button>
  </div>  --%>
  <div id="accordion">
    <h3>
      Project Target Lists</h3>
    <div>
      <asp:Panel ID="PanelSearch" runat="server" GroupingText="Project Target Search Condition">
        <table>
          <tr valign="top">
            <td>
              <asp:TreeView ID="tvProject" runat="server" ImageSet="WindowsHelp" ShowLines="True">
                <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                <Nodes>
                  <asp:TreeNode Text="案件總覽(All)" Value="%">
                    <asp:TreeNode Text="新開案的案子(Open)" Value="Open"></asp:TreeNode>
                    <asp:TreeNode Text="暫停的案子(On-Hold)" Value="On-Hold"></asp:TreeNode>
                    <asp:TreeNode Text="完成的案子(Done)" Value="Done"></asp:TreeNode>
                    <asp:TreeNode Text="取消的案子(Cancelled)" Value="Cancelled"></asp:TreeNode>
                  </asp:TreeNode>
                </Nodes>
                <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
                  NodeSpacing="0px" VerticalPadding="1px" />
                <ParentNodeStyle Font-Bold="False" />
                <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
                  VerticalPadding="0px" />
              </asp:TreeView>
            </td>
            <td>
              Project No:
              <asp:DropDownList ID="DropDownListPO" runat="server" DataSourceID="SqlDataSourceProject"
                DataTextField="Project_Name" DataValueField="Project_Id" OnDataBound="DropDownListPO_DataBound">
              </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [Project_Id],[Project_Name] FROM vw_GetProjectLists WHERE ([Project_Status] LIKE '%' + @Project_Status + '%')  Order By Companyname , Project_Id desc ">
                <SelectParameters>
                  <asp:ControlParameter ControlID="tvProject" DefaultValue="%" Name="Project_Status"
                    PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
              </asp:SqlDataSource>
              <br />
              <br />
              Country Manager :
              <asp:DropDownList ID="DropDownListCM" runat="server" AppendDataBoundItems="True"
                DataSourceID="SqlDataSourceCM" DataTextField="fname" DataValueField="id">
                <asp:ListItem Value="%">- All -</asp:ListItem>
              </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceCM" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [id],fname + ' ' + lname as [fname] FROM [employee] where status='Active'">
              </asp:SqlDataSource>
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
              <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [world_region_id], [world_region_name] FROM [world_region]">
              </asp:SqlDataSource>
              Country :
              <asp:DropDownList ID="DropDownListCountry" runat="server" DataSourceID="SqlDataSourceCountry"
                DataTextField="country_name" DataValueField="country_name" OnDataBound="DropDownListCountry_DataBound">
              </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [country_id], [country_name] FROM [country] WHERE ([world_region_id] = @world_region_id) order by country_name">
                <SelectParameters>
                  <asp:ControlParameter ControlID="DropDownListRegion" Name="world_region_id" PropertyName="SelectedValue"
                    Type="Byte" />
                </SelectParameters>
              </asp:SqlDataSource>
              <br />
              <br />
              Client :
              <asp:DropDownList ID="DropDownListClient" runat="server" AppendDataBoundItems="True"
                DataSourceID="SqlDataSourceClient" DataTextField="companyname" DataValueField="id">
                <asp:ListItem Value="%">- All -</asp:ListItem>
              </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [id], [companyname] FROM [clientapplicant] Where clientapplicant_type = 1 or clientapplicant_type = 3 order by companyname">
              </asp:SqlDataSource>
              <br />
              <br />
              Target Status :
              <asp:DropDownList ID="ddlTargetStatus" runat="server">
                <asp:ListItem Value="%">案件總覽(All)</asp:ListItem>
                <asp:ListItem Value="Open">新開案的案子(Open)</asp:ListItem>
                <asp:ListItem Value="In-Progress">申請中的案子(In-Progress)</asp:ListItem>
                <asp:ListItem Value="On-Hold">暫停的案子(On-Hold)</asp:ListItem>
                <asp:ListItem Value="Done">完成的案子(Done)</asp:ListItem>
                <asp:ListItem Value="Cancelled">取消的案子(Cancelled)</asp:ListItem>
                <asp:ListItem Value="Delay">逾時案件(Delay)</asp:ListItem>
              </asp:DropDownList>
              &nbsp;<asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Search" />
            </td>
          </tr>
        </table>
      </asp:Panel>
      <br />
      <asp:GridView ID="GridViewProjectTarget" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceTarget" PageSize="15"
        Width="100%" AllowSorting="True" OnSelectedIndexChanging="GridViewProjectTarget_SelectedIndexChanging"
        OnPageIndexChanging="GridViewProjectTarget_PageIndexChanging" OnSorting="GridViewProjectTarget_Sorting">
        <Columns>
          <asp:CommandField HeaderText="Working Status" SelectText="Setting" ShowSelectButton="True" />
          <asp:TemplateField HeaderText="ID" InsertVisible="False">
            <ItemTemplate>
              <asp:Label ID="LabelTarget" runat="server" Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Project No" SortExpression="Project_No">
            <ItemTemplate>
              <asp:Label ID="LabelProjectNo" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
              <asp:HiddenField ID="HFCountry" runat="server" Value='<%# Bind("country_id") %>' />
              <asp:HiddenField ID="HFProjectID" runat="server" Value='<%# Bind("Project_Id") %>' />
              <asp:HiddenField ID="HFClient" runat="server" Value='<%# Bind("Client") %>' />
              <asp:HiddenField ID="HFModelNo" runat="server" Value='<%# Bind("Model_No") %>' />
              <asp:HiddenField ID="HFProductName" runat="server" Value='<%# Bind("Product_Name") %>' />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client" />
          <asp:BoundField DataField="Model_No" HeaderText="Model No" />
          <asp:BoundField DataField="world_region_name" HeaderText="Region" SortExpression="world_region_name" />
          <asp:BoundField DataField="country_name" HeaderText="Country" SortExpression="country_name" />
          <asp:BoundField DataField="authority_name" HeaderText="Authority" SortExpression="authority_name" />
          <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
          <asp:BoundField DataField="target_description" HeaderText="T.Description" />
          <asp:BoundField DataField="test_started" HeaderText="Test Started" SortExpression="test_started"
            DataFormatString="{0:d}" />
          <asp:BoundField DataField="test_completed" HeaderText="Test Completed" SortExpression="test_completed"
            DataFormatString="{0:d}" />
          <asp:BoundField DataField="certification_submit_to_authority" HeaderText="Certification Submit To Authority"
            SortExpression="certification_submit_to_authority" DataFormatString="{0:d}" />
          <asp:BoundField DataField="certification_completed" HeaderText="Certification Completed"
            SortExpression="certification_completed" DataFormatString="{0:d}" />
          <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated Lead Time"
            SortExpression="Estimated_Lead_time" Visible="False" />
          <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" SortExpression="Actual_Lead_time"
            Visible="False" />
          <asp:TemplateField HeaderText="Agent" SortExpression="Agent" Visible="False">
            <EditItemTemplate>
              <asp:TextBox ID="TextBoxAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Country Manager">
            <EditItemTemplate>
              <asp:Label ID="LabelCM" runat="server" Text='<%# Eval("CountryManager") %>'></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelCM0" runat="server" Text='<%# Bind("CountryManager") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="AE" HeaderText="AE" SortExpression="AE" />
        </Columns>
      </asp:GridView>
      <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent
, country.country_name, Authority.authority_name ,world_region.world_region_name
,(Select fname + ' ' + lname as cmname from employee where id = Country_Manager ) as CountryManager
,Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No
, SalesId , Employee.fname + ' ' + lname  as 'AE' 
, Client_Id , clientapplicant.companyname as 'Client' 
, Quotation_Version.Product_Name 
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN world_region ON world_region.world_region_id = country.world_region_id
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN Quotation_Version ON Quotation_Version.Quotation_Version_Id = Quotation_Target.quotation_id AND Quotation_Status=5
INNER JOIN Project ON Project.Quotation_No = Quotation_Version.Quotation_No
INNER JOIN Employee ON Employee.id = Quotation_Version.SalesId
INNER JOIN clientapplicant ON Quotation_Version.Client_Id = clientapplicant.id 
WHERE (Project.Project_ID LIKE @Project_ID)  
AND (Quotation_Target.Status LIKE '%' + @Status + '%') 
AND (country.country_name LIKE @country_name ) 
AND (SalesId  LIKE @SalesId) 
AND (Country_Manager  LIKE @Country_Manager) 
AND (Client_Id  LIKE @Client_Id) 
" OnSelecting="SqlDataSourceTarget_Selecting">
        <SelectParameters>
          <asp:ControlParameter ControlID="DropDownListPO" DefaultValue="%" Name="Project_ID"
            PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="ddlTargetStatus" DefaultValue="%" Name="Status"
            PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="DropDownListCountry" DefaultValue="%" Name="country_name"
            PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="DropDownListAE" DefaultValue="%" Name="SalesId"
            PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="DropDownListCM" DefaultValue="%" Name="Country_Manager"
            PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="DropDownListClient" DefaultValue="%" Name="Client_Id"
            PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
    </div>
    <h3>
      Working Status</h3>
    <div>
      <asp:Label ID="lblProject" runat="server" Visible="False"></asp:Label>
      <asp:Label ID="lblCountry" runat="server" Visible="False"></asp:Label>
      <asp:Label ID="lblTarget" runat="server" Visible="False"></asp:Label>
      Project：<asp:DropDownList ID="ddlWorkingStatusProject" runat="server" AutoPostBack="True"
        DataSourceID="GetProjectsHasTargetSqlDataSource" DataTextField="Project_Name" DataValueField="Project_Id"
        EnableTheming="False" OnSelectedIndexChanged="ddlWorkingStatusProject_SelectedIndexChanged"
        OnDataBound="ddlWorkingStatusProject_DataBound" Enabled="False">
      </asp:DropDownList>
      <asp:SqlDataSource ID="GetProjectsHasTargetSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT [Project_Id],[Project_Name] FROM vw_GetProjectLists Order By Companyname , Project_Id desc ">
      </asp:SqlDataSource>
      <asp:TextBox ID="txtAction" runat="server" TextMode="MultiLine" Rows="5" Width="500"
        Visible="false" />
      <asp:Button ID="SaveClientAction" runat="server" Text="Save Client Action" Visible="false" />
      <p />
      Country：<asp:DropDownList ID="ddlWorkingStatusCountry" runat="server" AutoPostBack="True"
        DataSourceID="ProjectCountrySqlDataSource" DataTextField="country_name" DataValueField="country_id"
        EnableTheming="False" OnDataBound="ddlWorkingStatusCountry_DataBound" OnSelectedIndexChanged="ddlWorkingStatusCountry_SelectedIndexChanged"
        Enabled="False">
      </asp:DropDownList>
      <asp:SqlDataSource ID="ProjectCountrySqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT Quotation_Target.country_id, country.country_name 
FROM Quotation_Target
INNER JOIN country ON Quotation_Target.country_id = country.country_id
Where Quotation_Target.quotation_id in 
(Select Quotation_Version_Id FROM Quotation_Version Where Quotation_Status=5 AND Quotation_Version.Quotation_No in 
(Select Quotation_NO FROM Project Where Project_Id = @Project_Id))">
        <SelectParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusProject" Name="project_id" PropertyName="SelectedValue"
            Type="String" />
        </SelectParameters>
      </asp:SqlDataSource>
      <p />
      Target：<asp:DropDownList ID="ddlWorkingStatusTarget" runat="server" AutoPostBack="True"
        DataSourceID="WorkingStatusTargetSqlDataSource" DataTextField="authority_name"
        DataValueField="Quotation_Target_Id" EnableTheming="False" OnDataBound="ddlWorkingStatusTarget_DataBound"
        OnSelectedIndexChanged="ddlWorkingStatusTarget_SelectedIndexChanged" Enabled="False">
      </asp:DropDownList>
      <asp:SqlDataSource ID="WorkingStatusTargetSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, 
Authority.authority_name + ' - ' + Quotation_Target.target_description  as authority_name
FROM Quotation_Target 
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
Where Quotation_Target.quotation_id in 
(Select Quotation_Version_Id FROM Quotation_Version Where Quotation_Version.Quotation_No in 
(Select Quotation_NO FROM Project Where Project_Id = @project_id)) AND Quotation_Target.country_id = @country_id">
        <SelectParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusProject" Name="project_id" PropertyName="SelectedValue"
            Type="String" />
          <asp:ControlParameter ControlID="ddlWorkingStatusCountry" Name="country_id" PropertyName="SelectedValue" />
        </SelectParameters>
      </asp:SqlDataSource>
      <p />
      <asp:GridView ID="gvWorkingStatus" runat="server" DataSourceID="gvWorkingStatusSqlDataSource"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="log_id" EmptyDataText="沒有資料可以顯示。"
        ForeColor="#333333" HorizontalAlign="Center" RowHeaderColumn="id" ShowHeaderWhenEmpty="True"
        Width="100%" EnablePersistedSelection="True" EnableTheming="False" OnRowDataBound="gvWorkingStatus_RowDataBound"
        PageSize="30" OnRowEditing="gvWorkingStatus_RowEditing" OnSorting="gvWorkingStatus_Sorting">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
          <asp:BoundField DataField="log_id" HeaderText="ID" InsertVisible="False" ReadOnly="True"
            SortExpression="log_id">
            <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>
          <asp:BoundField DataField="log_date" HeaderText="Display Date" SortExpression="log_date"
            ApplyFormatInEditMode="True" DataFormatString="{0:d}" ReadOnly="True">
            <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>
          <asp:BoundField DataField="log_content" HeaderText="Working Status" HtmlEncode="False"
            ReadOnly="True"></asp:BoundField>
          <asp:BoundField DataField="create_date" HeaderText="Create Date" SortExpression="create_date"
            DataFormatString="{0:d}" ReadOnly="True">
            <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>
          <asp:BoundField DataField="create_by" HeaderText="Create By" SortExpression="create_by"
            ReadOnly="True">
            <ItemStyle HorizontalAlign="Center" />
          </asp:BoundField>
          <asp:CheckBoxField DataField="external_use" HeaderText="External" SortExpression="external_use">
            <ItemStyle HorizontalAlign="Center" />
          </asp:CheckBoxField>
          <asp:TemplateField HeaderText="Voided" InsertVisible="False" SortExpression="voided">
            <EditItemTemplate>
              <asp:CheckBox ID="chkVoided" runat="server" Checked='<%# Bind("voided") %>' />
            </EditItemTemplate>
            <ItemTemplate>
              <asp:CheckBox ID="chkVoided" runat="server" Checked='<%# Bind("voided") %>' Enabled="false" />
            </ItemTemplate>
            <ItemStyle HorizontalAlign="Center" />
          </asp:TemplateField>
          <asp:CommandField CancelText="Cancel" CausesValidation="False" EditText="Edit" ShowEditButton="True"
            UpdateText="Save" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <EmptyDataRowStyle Font-Bold="True" Font-Size="Large" HorizontalAlign="Center" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Font-Names="Courier New" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
      </asp:GridView>
      <asp:SqlDataSource ID="gvWorkingStatusSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        SelectCommand="sp_get_working_status_by_target_id" SelectCommandType="StoredProcedure"
        UpdateCommand="sp_update_working_status" UpdateCommandType="StoredProcedure">
        <SelectParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusTarget" Name="target_id" PropertyName="SelectedValue"
            Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
          <asp:Parameter Name="log_id" Type="Int32" />
          <asp:Parameter Name="external_use" Type="Boolean" />
          <asp:Parameter Name="voided" Type="Boolean" />
        </UpdateParameters>
      </asp:SqlDataSource>
      <asp:DetailsView ID="dvWorkingStatus" runat="server" Width="100%" AutoGenerateRows="False"
        CellPadding="4" DataKeyNames="log_id" DataSourceID="dvWorkingStatusSqlDataSource"
        DefaultMode="Insert" EnableTheming="False" ForeColor="#333333" OnItemInserted="dvWorkingStatus_ItemInserted"
        Visible="False" OnDataBound="dvWorkingStatus_DataBound">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <Fields>
          <asp:CommandField CancelText="Cancel" InsertText="Save" NewText="Add" ShowInsertButton="True"
            ValidationGroup="AddWorkingStatus">
            <ItemStyle HorizontalAlign="Right" />
          </asp:CommandField>
          <asp:BoundField DataField="log_id" HeaderText="ID" InsertVisible="False" ReadOnly="True">
            <HeaderStyle Width="10%" />
          </asp:BoundField>
          <asp:BoundField DataField="target_id" HeaderText="Target" InsertVisible="False" />
          <asp:TemplateField HeaderText="Display Date">
            <InsertItemTemplate>
              <asp:TextBox ID="txtLogDate" runat="server" ValidationGroup="AddWorkingStatus" Text='<%# Bind("log_date") %>'
                EnableTheming="False">
              </asp:TextBox>
              <ajaxcontroltoolkit:CalendarExtender ID="txtLogDate_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" TargetControlID="txtLogDate" TodaysDateFormat="yyyy/MM/dd">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtLogDate"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Please enter a valid date."
                ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" ValidationGroup="AddWorkingStatus">
              </asp:CompareValidator>
              <ajaxcontroltoolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server"
                Enabled="True" HighlightCssClass="RequiredFieldHighlight" TargetControlID="CompareValidator1"
                Width="250px" PopupPosition="Right">
              </ajaxcontroltoolkit:ValidatorCalloutExtender>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLogDate"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Date is required."
                ForeColor="Red" SetFocusOnError="True" ValidationGroup="AddWorkingStatus">
              </asp:RequiredFieldValidator>
              <ajaxcontroltoolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server"
                Enabled="True" HighlightCssClass="RequiredFieldHighlight" TargetControlID="RequiredFieldValidator2"
                Width="250px" PopupPosition="Right">
              </ajaxcontroltoolkit:ValidatorCalloutExtender>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("log_date") %>'></asp:Label>
            </ItemTemplate>
            <HeaderStyle Width="10%" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Working Status">
            <InsertItemTemplate>
              <table width="100%">
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Application in preparation：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate1" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Application in preparation.</asp:ListItem>
                      <asp:ListItem>Project opened.</asp:ListItem>
                      <asp:ListItem>Project status under confirmation by Client.</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Passive Status：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate2" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Application in progress.</asp:ListItem>
                      <asp:ListItem>Application under revision at Authority.</asp:ListItem>
                      <asp:ListItem>Awaiting confirmation from Authority.</asp:ListItem>
                      <asp:ListItem>Awaiting documents from Client (FCC, Test Report etc.)</asp:ListItem>
                      <asp:ListItem>Awaiting local rep, importer information.</asp:ListItem>
                      <asp:ListItem>Awaiting renewal of Local rep's dealer licence.</asp:ListItem>
                      <asp:ListItem>Awaiting resolution of local importer's licence issue.</asp:ListItem>
                      <asp:ListItem>Awaiting signed documents from Authority.</asp:ListItem>
                      <asp:ListItem>Awaiting signed documents from Client.</asp:ListItem>
                      <asp:ListItem>Awaiting signed documents from Local rep.</asp:ListItem>
                      <asp:ListItem>Certificate expected to be issued on 9/99.</asp:ListItem>
                      <asp:ListItem>Project progress may be delayed due to Authority chief officer being out of country.</asp:ListItem>
                      <asp:ListItem>Project progress may be delayed due to increasing political instability.</asp:ListItem>
                      <asp:ListItem>Project progress may be delayed due to long national holidays.</asp:ListItem>
                      <asp:ListItem>Project progress may be delayed due to structural changes at Authority.</asp:ListItem>
                      <asp:ListItem>Project temporarily suspended due to impossibility to carry on with escalation of violence in the country.</asp:ListItem>
                      <asp:ListItem>Project temporarily suspended due to unresolved licence issue.</asp:ListItem>
                      <asp:ListItem>Received documents from Client (FCC, Test Report etc.)</asp:ListItem>
                      <asp:ListItem>Received documents required for submission.</asp:ListItem>
                      <asp:ListItem>Received samples from Client.</asp:ListItem>
                      <asp:ListItem>Received signed documents from local importer.</asp:ListItem>
                      <asp:ListItem>Sample(s) arrives at Authority.</asp:ListItem>
                      <asp:ListItem>Sample(s) received by WoWi.</asp:ListItem>
                      <asp:ListItem>Testing begins.</asp:ListItem>
                      <asp:ListItem>Testing ends.</asp:ListItem>
                      <asp:ListItem>WoWi informed by Authority of incorrectly filed application.</asp:ListItem>
                      <asp:ListItem>WoWi informed by Authority of missing documents.</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Active Status：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate3" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Attempted checking with Authority. Additional documents requested.</asp:ListItem>
                      <asp:ListItem>Attempted checking with Authority. Additional sample(s) requested.</asp:ListItem>
                      <asp:ListItem>Attempted checking with Authority. Authority advised that…</asp:ListItem>
                      <asp:ListItem>Attempted checking with Authority. Authority confirms that application is still being processed.</asp:ListItem>
                      <asp:ListItem>Attempted checking with Authority. No response.</asp:ListItem>
                      <asp:ListItem>Certificate received with a minor error, revision requested.</asp:ListItem>
                      <asp:ListItem>Project resumed and treated as a new project.</asp:ListItem>
                      <asp:ListItem>Project resumed at Client's request.</asp:ListItem>
                      <asp:ListItem>Project resumed. No progress lost.</asp:ListItem>
                      <asp:ListItem>Project temporarily suspended at Client's request.</asp:ListItem>
                      <asp:ListItem>Sample(s) sent from WoWi to Authority, ETA: 9/99.</asp:ListItem>
                      <asp:ListItem>Submission on hold due to missing documents.</asp:ListItem>
                      <asp:ListItem>Submitted application materials to Authority. </asp:ListItem>
                      <asp:ListItem>Submitted samples to Authority.</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Application complete：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate4" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Application rejected by Authority.</asp:ListItem>
                      <asp:ListItem>Scanned Certificate received. Project closed.</asp:ListItem>
                      <asp:ListItem>Project cancelled by Client.</asp:ListItem>
                      <asp:ListItem>Project resumed at Client's request.</asp:ListItem>
                      <asp:ListItem>Revision rejected by Authority.</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Certificate / Sample return status：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate5" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Original certificate retained by (local rep., local agent etc.).</asp:ListItem>
                      <asp:ListItem>Original Certificate (and sample) is kept by local agent and will be returned (at the end of year or with materials of other projects).</asp:ListItem>
                      <asp:ListItem>Original certificate mailed from (local agent or authority)and arrived at WoWi.</asp:ListItem>
                      <asp:ListItem>Original certificate collected from (local agent or authority)and received by WoWi.</asp:ListItem>
                      <asp:ListItem>There is no actual certificate. Yearly Gazette is published and released.</asp:ListItem>
                      <asp:ListItem>There is no original certificate.  </asp:ListItem>
                      <asp:ListItem>The original certificate mailed to client from WoWi.</asp:ListItem>
                      <asp:ListItem>The original certificate mailed by local agent and received by local rep. (contact person).</asp:ListItem>
                      <asp:ListItem>Testing sample(s) retained by Authority.</asp:ListItem>
                      <asp:ListItem>Testing sample(s) returned from (testing lab, local agent etc.) to (WoWi, client etc.).</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
              </table>
              <br />
              <asp:TextBox ID="txtLogContent" runat="server" EnableTheming="False" Rows="5" TextMode="MultiLine"
                Width="100%" ValidationGroup="AddWorkingStatus" Text='<%# Bind("log_content") %>'>
              </asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLogContent"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Working Status is required."
                ForeColor="Red" SetFocusOnError="True" ValidationGroup="AddWorkingStatus">
              </asp:RequiredFieldValidator>
              <ajaxcontroltoolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server"
                Enabled="True" HighlightCssClass="RequiredFieldHighlight" TargetControlID="RequiredFieldValidator3"
                Width="250px" PopupPosition="BottomLeft">
              </ajaxcontroltoolkit:ValidatorCalloutExtender>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label2" runat="server" Text='<%# Bind("log_content") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Create By">
            <InsertItemTemplate>
              <asp:Label ID="LabelCreateBy" runat="server" Text='<%# Bind("create_by") %>'></asp:Label>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelCreateBy" runat="server" Text='<%# Bind("create_by") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:CheckBoxField DataField="external_use" HeaderText="External" />
          <asp:TemplateField HeaderText="Certification Completed">
            <InsertItemTemplate>
              <asp:Label ID="LabelCertificationDate" runat="server"></asp:Label>
            </InsertItemTemplate>
          </asp:TemplateField>
          <asp:CommandField CancelText="Cancel" InsertText="Save" NewText="Add" ShowInsertButton="True"
            ValidationGroup="AddWorkingStatus">
            <ItemStyle HorizontalAlign="Right" />
          </asp:CommandField>
        </Fields>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
      </asp:DetailsView>
      <asp:SqlDataSource ID="dvWorkingStatusSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>"
        InsertCommand="sp_add_working_status" InsertCommandType="StoredProcedure" SelectCommand="sp_get_working_status_by_target_id"
        SelectCommandType="StoredProcedure">
        <InsertParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusTarget" Name="target_id" PropertyName="SelectedValue"
            Type="Int32" />
          <asp:Parameter Name="log_date" Type="DateTime" />
          <asp:Parameter Name="log_content" Type="String" />
          <asp:Parameter Name="create_by" Type="String" />
          <asp:Parameter Name="external_use" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusTarget" Name="target_id" PropertyName="SelectedValue"
            Type="Int32" />
        </SelectParameters>
      </asp:SqlDataSource>
    </div>
    <h3>
      Target Estimate Date</h3>
    <div>
      <asp:DetailsView ID="DetailsViewTarget" runat="server" AutoGenerateRows="False" DataKeyNames="Quotation_Target_Id"
        DataSourceID="SqlDataSourceModifyTarget" DefaultMode="Edit" Width="100%" OnItemUpdated="DetailsViewTarget_ItemUpdated"
        OnItemUpdating="DetailsViewTarget_ItemUpdating" OnDataBound="DetailsViewTarget_DataBound">
        <Fields>
          <asp:BoundField DataField="Quotation_Target_Id" HeaderText="ID" InsertVisible="False"
            ReadOnly="True" SortExpression="Quotation_Target_Id" />
          <asp:BoundField DataField="world_region_name" HeaderText="Region" ReadOnly="True" />
          <asp:BoundField DataField="country_name" HeaderText="Country" ReadOnly="True" />
          <asp:TemplateField HeaderText="Authority" SortExpression="authority_id">
            <EditItemTemplate>
              <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
              <asp:TextBox ID="TextBox1" runat="server" Visible="false" Text='<%# Bind("authority_id") %>'></asp:TextBox>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Sample Received from Client Date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_sample_received_from_client_date" runat="server" Text='<%# Bind("sample_received_from_client_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              <asp:CompareValidator ID="CV5" runat="server" ControlToValidate="TextBox_sample_received_from_client_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Blue" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Customer Request Sample Returned">
            <EditItemTemplate>
              <%--<asp:CheckBox ID="cb_sample_returned" runat="server" Checked='<%# Bind("customer_request_sample_returned") %>' Text="YES" />
                    <asp:RadioButton ID="rb_sample_returnedYes" runat="server" Checked='<%# Bind("customer_request_sample_returned") %>'
                    GroupName="customer_request_sample_returned" Text="YES" />
                  <asp:RadioButton ID="rb_sample_returnedNo" runat="server" GroupName="customer_request_sample_returned" Text="NO" />--%>
              <asp:RadioButtonList ID="rb_sample_returned" runat="server" RepeatDirection="Horizontal"
                SelectedValue='<%# Bind("customer_request_sample_returned") %>'>
                <asp:ListItem Value="0">Not Setup</asp:ListItem>
                <asp:ListItem Value="1">YES</asp:ListItem>
                <asp:ListItem Value="2">NO</asp:ListItem>
              </asp:RadioButtonList>
              <div id="div_customer_request_sample_returned" style="display: none">
                Sample Returned to Client Date：
                <asp:TextBox ID="TextBox_sample_returned_to_client_date" runat="server" Text='<%# Bind("sample_returned_to_client_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
                <asp:CompareValidator ID="CV6" runat="server" ControlToValidate="TextBox_sample_returned_to_client_date"
                  Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                  Type="Date"></asp:CompareValidator><br />
                Shipping Tracking No.：
                <asp:TextBox ID="TextBox_sample_shipping_tracking_no" runat="server" Text='<%# Bind("sample_shipping_tracking_no") %>'></asp:TextBox>
              </div>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Blue" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Customer Request Original Certificate Returned">
            <EditItemTemplate>
              <%--<asp:CheckBox ID="cb_certificate_returned" runat="server" Text="YES" Checked='<%# Bind("customer_request_original_certificate_returned") %>' /><br />--%>
              <%-- <asp:RadioButton ID="rb_certificate_returnedYes" runat="server" Checked='<%# Bind("customer_request_original_certificate_returned") %>'
                    GroupName="customer_request_original_certificate_returned" Text="YES" />
                  <asp:RadioButton ID="rb_certificate_returnedNo" runat="server" GroupName="customer_request_original_certificate_returned"
                    Text="NO" />--%>
              <asp:RadioButtonList ID="rb_certificate_returned" runat="server" RepeatDirection="Horizontal"
                SelectedValue='<%# Bind("customer_request_original_certificate_returned") %>'>
                <asp:ListItem Value="0">Not Setup</asp:ListItem>
                <asp:ListItem Value="1">YES</asp:ListItem>
                <asp:ListItem Value="2">NO</asp:ListItem>
              </asp:RadioButtonList>
              <div id="div_customer_request_original_certificate_returned" style="display: none">
                Original Certificate Mailed to Client Date：
                <asp:TextBox ID="TextBox_original_certificate_mailed_to_client_date" runat="server"
                  Text='<%# Bind("original_certificate_mailed_to_client_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
                <asp:CompareValidator ID="CV7" runat="server" ControlToValidate="TextBox_original_certificate_mailed_to_client_date"
                  Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                  Type="Date"></asp:CompareValidator><br />
                Shipping Tracking No.：
                <asp:TextBox ID="TextBox_Certificate_shipping_tracking_no" runat="server" Text='<%# Bind("Certificate_shipping_tracking_no") %>'></asp:TextBox>
              </div>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Blue" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Sample Can be Returned from Authority">
            <EditItemTemplate>
              <%--<asp:CheckBox ID="cbSampleReturnedAuthority" runat="server" Text="YES" Checked='<%# Bind("sample_can_be_returned_from_authority") %>' />--%>
              <%--<asp:RadioButton ID="rbSampleReturnedAuthorityYes" runat="server" Checked='<%# Bind("sample_can_be_returned_from_authority") %>'
                    GroupName="sample_can_be_returned_from_authority" Text="YES" />
                  <asp:RadioButton ID="rbSampleReturnedAuthorityNo" runat="server" GroupName="sample_can_be_returned_from_authority"
                    Text="NO" />--%>
              <asp:RadioButtonList ID="rb_sample_returned_authority" runat="server" RepeatDirection="Horizontal"
                SelectedValue='<%# Bind("sample_can_be_returned_from_authority") %>'>
                <asp:ListItem Value="0">Not Setup</asp:ListItem>
                <asp:ListItem Value="1">YES</asp:ListItem>
                <asp:ListItem Value="2">NO</asp:ListItem>
              </asp:RadioButtonList>
              <div id="div_sample_return" style="display: none">
                1.
                <asp:CheckBox ID="cbKept" runat="server" Text="Sample is Kept by Local Agent/Authority"
                  Checked='<%# Bind("sample_is_kept_by_local_agent") %>' /><br />
                2.
                <asp:CheckBox ID="cbDestroy" runat="server" Text="WoWi Request Local Agent to Destroy Tested Samples"
                  Checked='<%# Bind("request_local_agent_to_destroy_tested_samples") %>' /><br />
                3. Returned of Tested Sample Date：
                <asp:TextBox ID="TextBox_returned_of_tested_sample_date" runat="server" Text='<%# Bind("returned_of_tested_sample_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
                <asp:CompareValidator ID="CV8" runat="server" ControlToValidate="TextBox_returned_of_tested_sample_date"
                  Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                  Type="Date"></asp:CompareValidator>
              </div>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Red" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Original Certificate">
            <EditItemTemplate>
              <asp:CheckBox ID="cb_OriginalCertificate1" runat="server" Checked='<%# Bind("CMB1") %>'
                Text="No Original Certificate" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate2" runat="server" Checked='<%# Bind("CMB2") %>'
                Text="There is No Actual Certificate, Yearly Gazette will be Published and Released" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate3" runat="server" Checked='<%# Bind("CMB3") %>'
                Text="Original Certificate is Kept by Authority and can be Returned upon Request" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate4" runat="server" Checked='<%# Bind("CMB4") %>'
                Text="Original Certificate is Held by Authority and cannot be Returned" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate5" runat="server" Checked='<%# Bind("CMB5") %>'
                Text="Original Certificate is Held by Local Rep. and cannot be Returned" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate6" runat="server" Checked='<%# Bind("CMB6") %>'
                Text="Original Certificate is Kept by Local Agent and can be Returned upon Request" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate7" runat="server" Checked='<%# Bind("CMB7") %>'
                Text="Original Certificate will be Returned by Authority via Postal Mail only" /><br />
              <asp:CheckBox ID="cb_OriginalCertificate8" runat="server" Checked='<%# Bind("CMB8") %>'
                Text="Original Certificate will be Returned by Authority via FedEx or DHL" /><br />
            </EditItemTemplate>
            <HeaderStyle ForeColor="Red" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Original Certificate Received Date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_original_certificate_received_date" runat="server" Text='<%# Bind("original_certificate_received_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              <asp:CompareValidator ID="CV9" runat="server" ControlToValidate="TextBox_original_certificate_received_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Red" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Document & Sample are ready to be process" SortExpression="document_ready_to_process">
            <EditItemTemplate>
              <asp:TextBox ID="txtProcess" runat="server" Text='<%# Bind("document_ready_to_process","{0:d}") %>' />
              <ajaxcontroltoolkit:CalendarExtender ID="txtProcess_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image_process" TargetControlID="txtProcess">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:Image ID="Image_process" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
              <asp:CompareValidator ID="CV_Process" runat="server" ControlToValidate="txtProcess"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date" ForeColor="Red"></asp:CompareValidator>
              <asp:CompareValidator ID="CV_LessThan" runat="server" ControlToCompare="TextBox6"
                ControlToValidate="txtProcess" Display="Dynamic" ErrorMessage="ready to be process 日期不得大於 certification completed，請重新輸入!"
                ForeColor="Red" Operator="LessThan" Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Test Started<br/>Test Completed" SortExpression="test_started">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("test_started","{0:d}") %>'></asp:TextBox>
              <ajaxcontroltoolkit:CalendarExtender ID="TextBox3_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image1" TargetControlID="TextBox3">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
              <asp:CompareValidator ID="CompareValidator9" runat="server" ControlToValidate="TextBox3"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date" ForeColor="Red"></asp:CompareValidator>
              <br />
              <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("test_completed","{0:d}") %>'></asp:TextBox>
              <ajaxcontroltoolkit:CalendarExtender ID="TextBox4_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image2" TargetControlID="TextBox4">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
              <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="TextBox4"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date" ForeColor="Red"></asp:CompareValidator>
              <asp:CompareValidator ID="CompareValidator7" runat="server" ControlToCompare="TextBox4"
                ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="test started 日期不得大於 test completed，請重新輸入!"
                ForeColor="Red" Operator="LessThan" Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certification Submit To Authority<br/>Certification Completed"
            SortExpression="certification_submit_to_authority">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("certification_submit_to_authority","{0:d}") %>'></asp:TextBox>
              <ajaxcontroltoolkit:CalendarExtender ID="TextBox5_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image5" TargetControlID="TextBox5">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:Image ID="Image5" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
              <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="TextBox5"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
              <br />
              <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("certification_completed","{0:d}") %>'></asp:TextBox>
              <ajaxcontroltoolkit:CalendarExtender ID="TextBox6_CalendarExtender" runat="server"
                Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image6" TargetControlID="TextBox6">
              </ajaxcontroltoolkit:CalendarExtender>
              <asp:Image ID="Image6" runat="server" ImageUrl="~/Images/Calendar_scheduleHS.png" />
              <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="TextBox6"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
              <asp:CompareValidator ID="CompareValidator8" runat="server" ControlToCompare="TextBox6"
                ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="certification_submit_to_authority 日期不得大於 certification_completed，請重新輸入!"
                ForeColor="Red" Operator="LessThan" Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Estimated Lead Time" SortExpression="Estimated_Lead_time">
            <EditItemTemplate>
              <asp:TextBox ID="TextBoxEstimated" runat="server" Text='<%# Bind("Estimated_Lead_time") %>'></asp:TextBox>
              (Weeks)
              <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBoxEstimated"
                ErrorMessage="Must be Numeric Format" ForeColor="Red" MaximumValue="10000" MinimumValue="0"
                SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Actual Lead Time" SortExpression="Actual_Lead_time">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_Actual_Lead_time" runat="server" ReadOnly="true" Enabled="false"
                Text='<%# Eval("Actual_Lead_time") %>'></asp:TextBox>
              <asp:Label ID="Label_Actual_Lead_time" runat="server"></asp:Label>
              (Weeks) [Certification Completed - Document & Sample are ready to be process]
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certificate Issue Date" SortExpression="certificate_issue_date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_certificate_issue_date" runat="server" Text='<%# Bind("certificate_issue_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              <asp:CompareValidator ID="CV1" runat="server" ControlToValidate="TextBox_certificate_issue_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certificate Expiry Date" SortExpression="certificate_expiry_date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_certificate_expiry_date" runat="server" Text='<%# Bind("certificate_expiry_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              <asp:CompareValidator ID="CV2" runat="server" ControlToValidate="TextBox_certificate_expiry_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>                
                <asp:CheckBox ID="cb_Lifetime" runat="server" Text="Lifetime" Checked='<%# Bind("Lifetime") %>' />
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Email Renewal Notice Date" SortExpression="email_renewal_notice_date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_email_renewal_notice_date" runat="server" Text='<%# Bind("email_renewal_notice_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              填入規則為：證書到期日期前 8 週 + Estimated Lead Time
              <asp:CompareValidator ID="CV3" runat="server" ControlToValidate="TextBox_email_renewal_notice_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Renewal Confirmation Check" SortExpression="renewal_confirmation_check">
            <EditItemTemplate>
              <asp:RadioButtonList ID="rb_renewal_confirmation_check" runat="server" SelectedValue='<%# Bind("renewal_confirmation_check") %>'>
                <asp:ListItem Value="0">Not Setup (未設定)</asp:ListItem>
                <asp:ListItem Value="1">Automatic Renewal Service provided by WoWi (WoWi 提供自動更新服務)</asp:ListItem>
                <asp:ListItem Value="2">Renewal Confirmed (更新確認)</asp:ListItem>
                <asp:ListItem Value="3">No Need (無須更新)</asp:ListItem>
              </asp:RadioButtonList>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Blue" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Conduct Renewal Action Date" SortExpression="conduct_renewal_action_date">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox_conduct_renewal_action_date" runat="server" Text='<%# Bind("conduct_renewal_action_date","{0:yyyy/MM/dd}") %>'></asp:TextBox>
              填入規則為：證書到期日期前 4 週 + Estimated Lead Time
              <asp:CompareValidator ID="CV4" runat="server" ControlToValidate="TextBox_conduct_renewal_action_date"
                Display="Dynamic" ErrorMessage="日期格式有誤" Operator="DataTypeCheck" SetFocusOnError="True"
                Type="Date"></asp:CompareValidator>
            </EditItemTemplate>
            <HeaderStyle ForeColor="Red" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certificate Type" SortExpression="certificate_type">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox2" runat="server" Width="300" Text='<%# Bind("certificate_type") %>'></asp:TextBox>
              (EX：NEW、RENEW#1、RENEW#2 ... )
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Country Manager" SortExpression="Country_Manager">
            <EditItemTemplate>
              <asp:TextBox ID="TextBoxCM" runat="server" Text='<%# Eval("Country_Manager") %>'
                Visible="false"></asp:TextBox>
              <asp:DropDownList ID="DropDownListEmp" runat="server" DataSourceID="SqlDataSourceEmp"
                DataTextField="fname" DataValueField="id" OnDataBound="DropDownListEmp_DataBound">
              </asp:DropDownList>
              <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [id], [fname] + ' ' + [lname] as [fname] FROM [employee]  where status='Active'">
              </asp:SqlDataSource>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Target Status">
            <EditItemTemplate>
              <asp:DropDownList ID="ddlStatus" runat="server">
                <asp:ListItem Value="Open">新開案的案子(Open)</asp:ListItem>
                <asp:ListItem Value="In-Progress">申請中的案子(In-Progress)</asp:ListItem>
                <asp:ListItem Value="On-Hold">暫停的案子(On-Hold)</asp:ListItem>
                <asp:ListItem Value="Done">完成的案子(Done)</asp:ListItem>
                <asp:ListItem Value="Cancelled">取消的案子(Cancelled)</asp:ListItem>
                <asp:ListItem Value="Delay">逾時案件(Delay)</asp:ListItem>
              </asp:DropDownList>
              <asp:TextBox ID="TextBoxStatus" runat="server" Text='<%# Eval("Status") %>' Visible="False"></asp:TextBox>
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:CommandField ShowEditButton="True" />
        </Fields>
      </asp:DetailsView>
      <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
      <asp:SqlDataSource ID="SqlDataSourceModifyTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id"
        InsertCommand="INSERT INTO [Quotation_Target] ([authority_id], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time]) VALUES (@authority_id, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time)"
        SelectCommand="
SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.authority_id, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, country.country_name , Authority.authority_name,Country_Manager,world_region_name , Quotation_Target.Status , Quotation_Target.document_ready_to_process 
,[certificate_type],[certificate_issue_date],[certificate_expiry_date],[email_renewal_notice_date],[renewal_confirmation_check],[conduct_renewal_action_date]
,[sample_received_from_client_date],[customer_request_sample_returned],[sample_returned_to_client_date],[sample_shipping_tracking_no],[customer_request_original_certificate_returned],[original_certificate_mailed_to_client_date],[Certificate_shipping_tracking_no]
,[sample_can_be_returned_from_authority],[sample_is_kept_by_local_agent]
,[request_local_agent_to_destroy_tested_samples]
,[returned_of_tested_sample_date]
,[CMB1],[CMB2],[CMB3],[CMB4],[CMB5],[CMB6],[CMB7],[CMB8],[original_certificate_received_date],[Lifetime]
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.Authority_id = Authority.Authority_id 
LEFT JOIN world_region ON country.world_region_id = world_region.world_region_id
WHERE (Quotation_Target.Quotation_Target_Id = @Quotation_Target_Id) " UpdateCommand="
UPDATE [Quotation_Target] SET [authority_id] = @authority_id,[document_ready_to_process] = @document_ready_to_process , [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Country_Manager] =@Country_Manager , [Status] = @Status 
, [certificate_type] = @certificate_type, [certificate_issue_date] = @certificate_issue_date, [certificate_expiry_date] = @certificate_expiry_date, [email_renewal_notice_date] = @email_renewal_notice_date, [renewal_confirmation_check] = @renewal_confirmation_check, [conduct_renewal_action_date] = @conduct_renewal_action_date
, [sample_received_from_client_date] = @sample_received_from_client_date, [customer_request_sample_returned] = @customer_request_sample_returned, [sample_returned_to_client_date] = @sample_returned_to_client_date, [sample_shipping_tracking_no] = @sample_shipping_tracking_no, [customer_request_original_certificate_returned] = @customer_request_original_certificate_returned, [original_certificate_mailed_to_client_date] = @original_certificate_mailed_to_client_date, [Certificate_shipping_tracking_no] = @Certificate_shipping_tracking_no
, [sample_can_be_returned_from_authority] = @sample_can_be_returned_from_authority, [sample_is_kept_by_local_agent] = @sample_is_kept_by_local_agent, [request_local_agent_to_destroy_tested_samples] = @request_local_agent_to_destroy_tested_samples, [returned_of_tested_sample_date] = @returned_of_tested_sample_date
, [CMB1] = @CMB1, [CMB2] = @CMB2, [CMB3] = @CMB3, [CMB4] = @CMB4, [CMB5] = @CMB5, [CMB6] = @CMB6, [CMB7] = @CMB7, [CMB8] = @CMB8, [original_certificate_received_date] = @original_certificate_received_date 
, [Lifetime] = @Lifetime
WHERE [Quotation_Target_Id] = @Quotation_Target_Id ">
        <DeleteParameters>
          <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
          <asp:Parameter Name="authority_id" Type="Int32" />
          <asp:Parameter Name="test_started" Type="DateTime" />
          <asp:Parameter Name="test_completed" Type="DateTime" />
          <asp:Parameter Name="certification_submit_to_authority" Type="DateTime" />
          <asp:Parameter Name="certification_completed" Type="DateTime" />
          <asp:Parameter Name="Estimated_Lead_time" Type="String" />
          <asp:Parameter Name="Actual_Lead_time" Type="String" />
        </InsertParameters>
        <SelectParameters>
          <asp:ControlParameter ControlID="ddlWorkingStatusTarget" Name="Quotation_Target_Id"
            PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
          <asp:Parameter Name="authority_id" Type="Int32" />
          <asp:Parameter Name="test_started" Type="DateTime" />
          <asp:Parameter Name="test_completed" Type="DateTime" />
          <asp:Parameter Name="certification_submit_to_authority" Type="DateTime" />
          <asp:Parameter Name="certification_completed" Type="DateTime" />
          <asp:Parameter Name="Estimated_Lead_time" Type="String" />
          <asp:Parameter Name="Actual_Lead_time" Type="String" />
          <asp:Parameter Name="Country_Manager" />
          <asp:Parameter Name="Status" Type="String" />
          <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
          <asp:Parameter Name="document_ready_to_process" Type="DateTime" />
          <asp:Parameter Name="certificate_type" Type="String" />
          <asp:Parameter Name="certificate_issue_date" Type="DateTime" />
          <asp:Parameter Name="certificate_expiry_date" Type="DateTime" />
          <asp:Parameter Name="email_renewal_notice_date" Type="DateTime" />
          <asp:Parameter Name="renewal_confirmation_check" Type="String" />
          <asp:Parameter Name="conduct_renewal_action_date" Type="DateTime" />
          <asp:Parameter Name="sample_received_from_client_date" Type="DateTime" />
          <asp:Parameter Name="customer_request_sample_returned" Type="String" />
          <asp:Parameter Name="sample_returned_to_client_date" Type="DateTime" />
          <asp:Parameter Name="sample_shipping_tracking_no" Type="String" />
          <asp:Parameter Name="customer_request_original_certificate_returned" Type="String" />
          <asp:Parameter Name="original_certificate_mailed_to_client_date" Type="DateTime" />
          <asp:Parameter Name="Certificate_shipping_tracking_no" Type="String" />
          <asp:Parameter Name="sample_can_be_returned_from_authority" Type="String" />
          <asp:Parameter Name="sample_is_kept_by_local_agent" Type="Boolean" />
          <asp:Parameter Name="request_local_agent_to_destroy_tested_samples" Type="Boolean" />
          <asp:Parameter Name="returned_of_tested_sample_date" Type="DateTime" />
          <asp:Parameter Name="CMB1" Type="Boolean" />
          <asp:Parameter Name="CMB2" Type="Boolean" />
          <asp:Parameter Name="CMB3" Type="Boolean" />
          <asp:Parameter Name="CMB4" Type="Boolean" />
          <asp:Parameter Name="CMB5" Type="Boolean" />
          <asp:Parameter Name="CMB6" Type="Boolean" />
          <asp:Parameter Name="CMB7" Type="Boolean" />
          <asp:Parameter Name="CMB8" Type="Boolean" />
          <asp:Parameter Name="original_certificate_received_date" Type="DateTime" />
          <asp:Parameter Name="Lifetime" Type="Boolean" />          
          <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
        </UpdateParameters>
      </asp:SqlDataSource>
    </div>
    <h3>
      Working Status Report</h3>
    <div>
      <asp:Panel ID="PanelReport" runat="server" Visible="False">
        <asp:Button ID="ButtonExcel" runat="server" Text="Export Report To Excel" OnClick="ButtonExcel_Click" />
        <br />
        <table cellspacing="1" class="style1">
          <tr>
            <td>
              <asp:Image ID="ImageLogo" runat="server" ImageUrl="~/Images/logo.gif" Visible="False" />
              <table border="1" cellpadding="0" cellspacing="0">
                <tr>
                  <td class="style2">
                    <strong>Product Name</strong>
                  </td>
                  <td class="style2">
                    <strong>Model No</strong>
                  </td>
                  <td class="style2">
                    <strong>Client</strong>
                  </td>
                  <td class="style2">
                    <strong>Project No</strong>
                  </td>
                </tr>
                <tr>
                  <td>
                    <asp:Label ID="LabelProduct" runat="server"></asp:Label>
                  </td>
                  <td>
                    <asp:Label ID="LabelModel" runat="server"></asp:Label>
                  </td>
                  <td>
                    <asp:Label ID="LabelClient" runat="server"></asp:Label>
                  </td>
                  <td>
                    <asp:Label ID="LabelProject" runat="server"></asp:Label>
                  </td>
                </tr>
              </table>
            </td>
            <td>
              <b>WoWi Approval Services, Inc.</b><br />
              Add: 3F., No.79, Zhouzi St., Neihu Dist., Taipei City 114, Taiwan (R.O.C.)
              <br />
              Tel: +886-2799-8382 Fax: +886-2799-8387
              <br />
              http://www.WoWiApproval.com
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <br />
              <asp:GridView ID="GridViewReport" runat="server" AutoGenerateColumns="False" DataKeyNames="Quotation_Target_Id"
                DataSourceID="SqlDataSourceReport" OnPreRender="GridViewReport_PreRender" Width="100%"
                Caption="Project Working Status" EmptyDataText="此案件尚未有相關的Project Status紀錄!" SkinID="None">
                <Columns>
                  <asp:BoundField DataField="country_name" HeaderText="Country" SortExpression="country_name" />
                  <asp:BoundField DataField="authority_name" HeaderText="Authority" SortExpression="authority_name" />
                  <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated Lead Time"
                    SortExpression="Estimated_Lead_time" />
                  <asp:BoundField HeaderText="Start Date" DataField="document_ready_to_process" DataFormatString="{0:d}" />
                  <asp:BoundField HeaderText="Sample Received" DataField="sample_received_from_client_date"
                    DataFormatString="{0:d}" />
                  <asp:BoundField DataField="certification_submit_to_authority" HeaderText="Submit to Authority / Test Lab"
                    SortExpression="certification_submit_to_authority" DataFormatString="{0:d}" />
                  <asp:TemplateField HeaderText="Test Started" SortExpression="test_started">
                    <ItemTemplate>
                      <asp:Label ID="LabelTestDate" runat="server" Text='<%# Bind("test_started", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Est. Test Completed" SortExpression="test_completed">
                    <ItemTemplate>
                      <asp:Label ID="LabelEstDate" runat="server" Text='<%# Bind("test_completed", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="certification_completed" HeaderText="Est. Completed" SortExpression="certification_completed"
                    DataFormatString="{0:d}" />
                  <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" SortExpression="Actual_Lead_time" />
                  <asp:BoundField DataField="CountryManager" HeaderText="Country Manager" />
                  <asp:TemplateField HeaderText="Project Status">
                    <ItemTemplate>
                      <asp:Label ID="Label_Quotation_Target_Id" runat="server" Visible="false" Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
                      <asp:BulletedList ID="BulletedListStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                        DataTextField="Status" DataValueField="voided" OnDataBound="BulletedListStatus_DataBound"
                        BulletStyle="Numbered">
                      </asp:BulletedList>
                      <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                        SelectCommand="SELECT voided , 
	Case external_use 
	When 1 Then Substring(CONVERT(char(10), log_date, 111) , 6,10) + ':' + log_content + '(External)' 
	When 0 Then Substring(CONVERT(char(10), log_date, 111) , 6,10) + ':' + log_content 
	End AS 'Status' 
FROM Project_working_log
WHERE (target_id = @Quotation_Version_Id)
Order by log_date">
                        <SelectParameters>
                          <asp:ControlParameter ControlID="Label_Quotation_Target_Id" Name="Quotation_Version_Id"
                            PropertyName="Text" />
                        </SelectParameters>
                      </asp:SqlDataSource>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="Client_Action" HeaderText="Required action from the client"
                    SortExpression="Client_Action" />
                </Columns>
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourceReport" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT Quotation_Target_Id, 
(SELECT COUNTRY_NAME FROM COUNTRY WHERE COUNTRY_ID=Quotation_Target.country_id) AS country_name,
(SELECT authority_name FROM Authority WHERE Authority.authority_id = Quotation_Target.authority_id ) AS authority_name, 
test_started, test_completed, certification_submit_to_authority, certification_completed, Estimated_Lead_time, Actual_Lead_time, 
Project.Client_Action, 
(Select fname + ' ' + lname as cm from employee where id = Country_Manager ) as CountryManager,
document_ready_to_process , sample_received_from_client_date
FROM PROJECT 
INNER JOIN Quotation_Version ON PROJECT.Quotation_No = Quotation_Version.Quotation_No  AND Quotation_Status=5 
INNER JOIN Quotation_Target ON Quotation_Target.quotation_id = Quotation_Version.Quotation_Version_Id
WHERE Project_Id = @Project_ID">
                <SelectParameters>
                  <asp:ControlParameter ControlID="ddlWorkingStatusProject" Name="Project_ID" PropertyName="SelectedValue" />
                </SelectParameters>
              </asp:SqlDataSource>
            </td>
          </tr>
        </table>
      </asp:Panel>
    </div>
  </div>
  <asp:HiddenField ID="HFAccordionStatus" runat="server" Value="0" />
</asp:Content>
