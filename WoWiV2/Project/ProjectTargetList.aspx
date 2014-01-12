<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="ProjectTargetList.aspx.cs" Inherits="Project_ProjectTargetList" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxcontroltoolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
  <script type="text/javascript">
		<!--
    function switchMenu() {
      if (SwitchArraw.innerText == 3) {
        SwitchArraw.innerText = 4
        document.all("frmLeft").style.display = "none"
      } else {
        SwitchArraw.innerText = 3
        document.all("frmLeft").style.display = ""
      }
    }
		//-->
  </script>
  <style type="text/css">
    .Arraw
    {
      color: #0000BB;
      cursor: pointer;
      font-family: Webdings;
      font-size: 9pt;
    }
  </style>
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

      //Sample Can be Returned from Authority 
      //      if ($("[id*=cbSampleReturnedAuthority]").attr('checked') == 'checked') {
      //        $("[id*=div_sample_return]").show();
      //      }
      //      else {
      //        $("[id*=div_sample_return]").hide();
      //      }

      //      $("[id*=cbSampleReturnedAuthority]").click(function () {
      //        if ($("[id*=cbSampleReturnedAuthority]").attr('checked') == 'checked') {
      //          $("[id*=div_sample_return]").fadeIn(300);
      //        }
      //        else {
      //          $("[id*=div_sample_return]").fadeOut(300);
      //        }
      //      });

      //      if ($("[id*=rbSampleReturnedAuthority]:checked").length > 0) {
      //        $("[id*=div_sample_return]").show();
      //      }
      //      else {
      //        $("[id*=div_sample_return]").hide();
      //      }

      //Sample Can be Returned from Authority using radioButton
      //      if ($("[id*=rbSampleReturnedAuthorityYes]:checked").length > 0) {
      //        $("[id*=div_sample_return]").fadeIn(300);
      //      }
      //      else {
      //        $("[id*=rbSampleReturnedAuthorityNo]").attr("checked", true);
      //      }
      //      $("[id*=rbSampleReturnedAuthorityYes]").click(function () {
      //        if ($("[id*=rbSampleReturnedAuthorityYes]:checked").length > 0) {
      //          $("[id*=div_sample_return]").fadeIn(300);
      //        }
      //      });
      //      $("[id*=rbSampleReturnedAuthorityNo]").click(function () {
      //        if ($("[id*=rbSampleReturnedAuthorityNo]:checked").length > 0) {
      //          $("[id*=div_sample_return]").fadeOut(300);
      //        }
      //      });

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

      //customer_request_sample_returned
      //      if ($("[id*=cb_sample_returned]").attr('checked') == 'checked') {
      //        $("[id*=div_customer_request_sample_returned]").show();
      //      }
      //      else {
      //        $("[id*=div_customer_request_sample_returned]").hide();
      //      }

      //      $("[id*=cb_sample_returned]").click(function () {
      //        if ($("[id*=cb_sample_returned]").attr('checked') == 'checked') {
      //          $("[id*=div_customer_request_sample_returned]").fadeIn(300);
      //        }
      //        else {
      //          $("[id*=div_customer_request_sample_returned]").fadeOut(300);
      //        }
      //      });

      //customer_request_sample_returned using radio
      //      if ($("[id*=rb_sample_returnedYes]:checked").length > 0) {
      //        $("[id*=div_customer_request_sample_returned]").fadeIn(300);
      //      }
      //      else {
      //        $("[id*=rb_sample_returnedNo]").attr("checked", true);
      //      }

      //      $("[id*=rb_sample_returnedYes]").click(function () {
      //        if ($("[id*=rb_sample_returnedYes]:checked").length > 0) {
      //          $("[id*=div_customer_request_sample_returned]").fadeIn(300);
      //        }
      //      });
      //      $("[id*=rb_sample_returnedNo]").click(function () {
      //        if ($("[id*=rb_sample_returnedNo]:checked").length > 0) {
      //          $("[id*=div_customer_request_sample_returned]").fadeOut(300);
      //        }
      //      });

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


      //customer_request_original_certificate_returned
      //      if ($("[id*=cb_certificate_returned]").attr('checked') == 'checked') {
      //        $("[id*=div_customer_request_original_certificate_returned]").show();
      //      }
      //      else {
      //        $("[id*=div_customer_request_original_certificate_returned]").hide();
      //      }

      //      $("[id*=cb_certificate_returned]").click(function () {
      //        if ($("[id*=cb_certificate_returned]").attr('checked') == 'checked') {
      //          $("[id*=div_customer_request_original_certificate_returned]").fadeIn(300);
      //        }
      //        else {
      //          $("[id*=div_customer_request_original_certificate_returned]").fadeOut(300);
      //        }
      //      });

      //customer_request_original_certificate_returned using radio
      //      if ($("[id*=rb_certificate_returnedYes]:checked").length > 0) {
      //        $("[id*=div_customer_request_original_certificate_returned]").fadeIn(300);
      //      }
      //      else {
      //        $("[id*=rb_certificate_returnedNo]").attr("checked", true);
      //      }

      //      $("[id*=rb_certificate_returnedYes]").click(function () {
      //        if ($("[id*=rb_certificate_returnedYes]:checked").length > 0) {
      //          $("[id*=div_customer_request_original_certificate_returned]").fadeIn(300);
      //        }
      //      });
      //      $("[id*=rb_certificate_returnedNo]").click(function () {
      //        if ($("[id*=rb_certificate_returnedNo]:checked").length > 0) {
      //          $("[id*=div_customer_request_original_certificate_returned]").fadeOut(300);
      //        }
      //      });

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
  <center>
      <asp:LinkButton ID="LinkButtonTop" runat="server" onclick="LinkButtonTop_Click">Setting Working Status</asp:LinkButton>
    </center>
  <table>
    <tr>
      <td id="frmLeft" valign="top">
        Project Status :
        <asp:TreeView ID="TreeViewMenu" runat="server" ImageSet="WindowsHelp" ShowLines="True">
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
        <hr />
        Target Status :
        <asp:TreeView ID="TreeViewStatus" runat="server" ImageSet="WindowsHelp" ShowLines="True">
          <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
          <Nodes>
            <asp:TreeNode Text="案件總覽(All)" Value="%">
              <asp:TreeNode Text="新開案的案子(Open)" Value="Open"></asp:TreeNode>
              <asp:TreeNode Text="申請中的案子(In-Progress)" Value="In-Progress"></asp:TreeNode>
              <asp:TreeNode Text="暫停的案子(On-Hold)" Value="On-Hold"></asp:TreeNode>
              <asp:TreeNode Text="完成的案子(Done)" Value="Done"></asp:TreeNode>
              <asp:TreeNode Text="取消的案子(Cancelled)" Value="Cancelled"></asp:TreeNode>
              <asp:TreeNode Text="逾時案件(Delay)" Value="Delay"></asp:TreeNode>
            </asp:TreeNode>
          </Nodes>
          <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
            NodeSpacing="0px" VerticalPadding="1px" />
          <ParentNodeStyle Font-Bold="False" />
          <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" HorizontalPadding="0px"
            VerticalPadding="0px" />
        </asp:TreeView>
      </td>
      <td bgcolor="#c3dcf1" style="width: 5pt" onclick="switchMenu()">
        <span class="Arraw" id="SwitchArraw" title="顯示/隱藏選單">3</span>
      </td>
      <td valign="top">
        <div>
          Project No:
          <asp:DropDownList ID="DropDownListProject" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceProject"
            DataTextField="Project_Name" DataValueField="Project_Id" OnSelectedIndexChanged="DropDownListProject_SelectedIndexChanged"
            OnDataBound="DropDownListProject_DataBound">
          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            SelectCommand="SELECT [Project_Id],[Project_Name] FROM vw_GetProjectLists WHERE ([Project_Status] LIKE '%' + @Project_Status + '%')  Order By Companyname , Project_Id desc ">
            <SelectParameters>
              <asp:ControlParameter ControlID="TreeViewMenu" DefaultValue="%" Name="Project_Status"
                PropertyName="SelectedValue" />
            </SelectParameters>
          </asp:SqlDataSource>
          <p />
          Country Manager :
          <asp:DropDownList ID="DropDownListCM" runat="server" AppendDataBoundItems="True"
            DataSourceID="SqlDataSourceCM" DataTextField="fname" DataValueField="id" AutoPostBack="True">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
          <asp:SqlDataSource ID="SqlDataSourceCM" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            SelectCommand="SELECT [id], [fname] + ' ' + [lname] as fname FROM [employee] where status='Active'">
          </asp:SqlDataSource>
          <p />
          <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
          <asp:GridView ID="GridViewProjectTarget" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceTarget" PageSize="20"
            Width="100%" AllowSorting="True" OnSelectedIndexChanged="GridViewProjectTarget_SelectedIndexChanged"
            OnRowDataBound="GridViewProjectTarget_RowDataBound">
            <Columns>
              <asp:CommandField SelectText="Details" ShowSelectButton="True" />
              <asp:TemplateField HeaderText="ID" InsertVisible="False">
                <EditItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("Quotation_Target_Id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="LabelTargetID" runat="server" Text='<%# Bind("Quotation_Target_Id") %>' />
                  <asp:Label ID="LabelCountryID" runat="server" Text='<%# Bind("country_id") %>' Visible="false" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="country_name" HeaderText="Country" SortExpression="country_name" />
              <asp:BoundField DataField="authority_name" HeaderText="Authority" SortExpression="authority_name" />
              <asp:BoundField DataField="target_description" HeaderText="T.Description" />
              <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
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
              <asp:TemplateField HeaderText="Country Manager">
                <EditItemTemplate>
                  <asp:Label ID="LabelCM" runat="server" Text='<%# Eval("CountryManager") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="LabelCM" runat="server" Text='<%# Bind("CountryManager") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id"
            InsertCommand="INSERT INTO [Quotation_Target] ([quotation_id], [target_id], [target_description], [country_id], [product_type_id], [authority_id], [technology_id], [target_rate], [unit], [unit_price], [discount_type], [discValue1], [discValue2], [discPrice], [FinalPrice], [PayTo], [Status], [Bill], [option1], [option2], [advance1], [advance2], [balance1], [balance2], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time]) VALUES (@quotation_id, @target_id, @target_description, @country_id, @product_type_id, @authority_id, @technology_id, @target_rate, @unit, @unit_price, @discount_type, @discValue1, @discValue2, @discPrice, @FinalPrice, @PayTo, @Status, @Bill, @option1, @option2, @advance1, @advance2, @balance1, @balance2, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time)"
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, country.country_name,authority_name 
, (Select fname + ' ' + lname as [fname] from employee where employee.id = Country_Manager ) as CountryManager 
, Quotation_Target.Status
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
WHERE Quotation_Target.quotation_id in 
(Select Quotation_Version_Id from Quotation_Version 
INNER JOIN Project ON [Project].Quotation_No = Quotation_Version.Quotation_No
Where  Quotation_Status=5 AND Project.Project_Id=@Project_Id) 
AND Country_Manager like @CM 
AND Quotation_Target.Status LIKE '%' + @Status + '%' " UpdateCommand="UPDATE [Quotation_Target] SET [quotation_id] = @quotation_id, [target_id] = @target_id, [target_description] = @target_description, [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_id] = @authority_id, [technology_id] = @technology_id, [target_rate] = @target_rate, [unit] = @unit, [unit_price] = @unit_price, [discount_type] = @discount_type, [discValue1] = @discValue1, [discValue2] = @discValue2, [discPrice] = @discPrice, [FinalPrice] = @FinalPrice, [PayTo] = @PayTo, [Status] = @Status, [Bill] = @Bill, [option1] = @option1, [option2] = @option2, [advance1] = @advance1, [advance2] = @advance2, [balance1] = @balance1, [balance2] = @balance2, [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
            <DeleteParameters>
              <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
              <asp:Parameter Name="quotation_id" Type="Int32" />
              <asp:Parameter Name="target_id" Type="Int32" />
              <asp:Parameter Name="target_description" Type="String" />
              <asp:Parameter Name="country_id" Type="Int32" />
              <asp:Parameter Name="product_type_id" Type="Int32" />
              <asp:Parameter Name="authority_id" Type="Int32" />
              <asp:Parameter Name="technology_id" Type="Int32" />
              <asp:Parameter Name="target_rate" Type="Decimal" />
              <asp:Parameter Name="unit" Type="Double" />
              <asp:Parameter Name="unit_price" Type="Decimal" />
              <asp:Parameter Name="discount_type" Type="String" />
              <asp:Parameter Name="discValue1" Type="Int32" />
              <asp:Parameter Name="discValue2" Type="Decimal" />
              <asp:Parameter Name="discPrice" Type="Decimal" />
              <asp:Parameter Name="FinalPrice" Type="Decimal" />
              <asp:Parameter Name="PayTo" Type="String" />
              <asp:Parameter Name="Status" Type="String" />
              <asp:Parameter Name="Bill" Type="String" />
              <asp:Parameter Name="option1" Type="Boolean" />
              <asp:Parameter Name="option2" Type="Boolean" />
              <asp:Parameter Name="advance1" Type="String" />
              <asp:Parameter Name="advance2" Type="Decimal" />
              <asp:Parameter Name="balance1" Type="String" />
              <asp:Parameter Name="balance2" Type="Decimal" />
              <asp:Parameter Name="test_started" Type="DateTime" />
              <asp:Parameter Name="test_completed" Type="DateTime" />
              <asp:Parameter Name="certification_submit_to_authority" Type="DateTime" />
              <asp:Parameter Name="certification_completed" Type="DateTime" />
              <asp:Parameter Name="Estimated_Lead_time" Type="String" />
              <asp:Parameter Name="Actual_Lead_time" Type="String" />
            </InsertParameters>
            <SelectParameters>
              <asp:ControlParameter ControlID="DropDownListProject" Name="Project_Id" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="DropDownListCM" DefaultValue="%" Name="CM" PropertyName="SelectedValue" />
              <asp:ControlParameter ControlID="TreeViewStatus" DefaultValue="%" Name="Status" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
              <asp:Parameter Name="quotation_id" Type="Int32" />
              <asp:Parameter Name="target_id" Type="Int32" />
              <asp:Parameter Name="target_description" Type="String" />
              <asp:Parameter Name="country_id" Type="Int32" />
              <asp:Parameter Name="product_type_id" Type="Int32" />
              <asp:Parameter Name="authority_id" Type="Int32" />
              <asp:Parameter Name="technology_id" Type="Int32" />
              <asp:Parameter Name="target_rate" Type="Decimal" />
              <asp:Parameter Name="unit" Type="Double" />
              <asp:Parameter Name="unit_price" Type="Decimal" />
              <asp:Parameter Name="discount_type" Type="String" />
              <asp:Parameter Name="discValue1" Type="Int32" />
              <asp:Parameter Name="discValue2" Type="Decimal" />
              <asp:Parameter Name="discPrice" Type="Decimal" />
              <asp:Parameter Name="FinalPrice" Type="Decimal" />
              <asp:Parameter Name="PayTo" Type="String" />
              <asp:Parameter Name="Status" Type="String" />
              <asp:Parameter Name="Bill" Type="String" />
              <asp:Parameter Name="option1" Type="Boolean" />
              <asp:Parameter Name="option2" Type="Boolean" />
              <asp:Parameter Name="advance1" Type="String" />
              <asp:Parameter Name="advance2" Type="Decimal" />
              <asp:Parameter Name="balance1" Type="String" />
              <asp:Parameter Name="balance2" Type="Decimal" />
              <asp:Parameter Name="test_started" Type="DateTime" />
              <asp:Parameter Name="test_completed" Type="DateTime" />
              <asp:Parameter Name="certification_submit_to_authority" Type="DateTime" />
              <asp:Parameter Name="certification_completed" Type="DateTime" />
              <asp:Parameter Name="Estimated_Lead_time" Type="String" />
              <asp:Parameter Name="Actual_Lead_time" Type="String" />
              <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
            </UpdateParameters>
          </asp:SqlDataSource>
          <asp:DetailsView ID="DetailsViewTarget" runat="server" AutoGenerateRows="False" Caption="Target Details"
            DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceModifyTarget" DefaultMode="Edit"
            Width="100%" OnItemUpdated="DetailsViewTarget_ItemUpdated" OnItemUpdating="DetailsViewTarget_ItemUpdating"
            OnDataBound="DetailsViewTarget_DataBound">
            <Fields>
              <asp:BoundField DataField="Quotation_Target_Id" HeaderText="ID" InsertVisible="False"
                ReadOnly="True" SortExpression="Quotation_Target_Id" />
              <asp:BoundField DataField="world_region_name" HeaderText="Region" ReadOnly="True" />
              <asp:BoundField DataField="country_name" HeaderText="Country" ReadOnly="True" />
              <asp:TemplateField HeaderText="Authority" SortExpression="authority_id">
                <EditItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
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
                  <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBox3"
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
,[CMB1],[CMB2],[CMB3],[CMB4],[CMB5],[CMB6],[CMB7],[CMB8],[original_certificate_received_date]
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
              <asp:ControlParameter ControlID="GridViewProjectTarget" Name="Quotation_Target_Id"
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
              <asp:Parameter Name="customer_request_sample_returned" Type="Boolean" />
              <asp:Parameter Name="sample_returned_to_client_date" Type="DateTime" />
              <asp:Parameter Name="sample_shipping_tracking_no" Type="String" />
              <asp:Parameter Name="customer_request_original_certificate_returned" Type="Boolean" />
              <asp:Parameter Name="original_certificate_mailed_to_client_date" Type="DateTime" />
              <asp:Parameter Name="Certificate_shipping_tracking_no" Type="String" />
              <asp:Parameter Name="sample_can_be_returned_from_authority" Type="Boolean" />
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
              <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
            </UpdateParameters>
          </asp:SqlDataSource>
          <asp:HiddenField ID="HidProjectID" runat="server" />
          <asp:HiddenField ID="HidCountryID" runat="server" />
          <asp:HiddenField ID="HidTargetID" runat="server" />
        </div>
      </td>
    </tr>
  </table>
  <center>
      <asp:LinkButton ID="LinkButtonFooter" runat="server" 
        onclick="LinkButtonTop_Click">Setting Working Status</asp:LinkButton>
    </center>
</asp:Content>
