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
            Width="100%" AllowSorting="True" 
              OnSelectedIndexChanged="GridViewProjectTarget_SelectedIndexChanged" 
              onrowdatabound="GridViewProjectTarget_RowDataBound">
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
                  <asp:Label ID="LabelCM" runat="server" Text='<%# Bind("CountryManager") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
          <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id"
            InsertCommand="INSERT INTO [Quotation_Target] ([quotation_id], [target_id], [target_description], [country_id], [product_type_id], [authority_id], [technology_id], [target_rate], [unit], [unit_price], [discount_type], [discValue1], [discValue2], [discPrice], [FinalPrice], [PayTo], [Status], [Bill], [option1], [option2], [advance1], [advance2], [balance1], [balance2], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@quotation_id, @target_id, @target_description, @country_id, @product_type_id, @authority_id, @technology_id, @target_rate, @unit, @unit_price, @discount_type, @discValue1, @discValue2, @discPrice, @FinalPrice, @PayTo, @Status, @Bill, @option1, @option2, @advance1, @advance2, @balance1, @balance2, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)"
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, country.country_name,authority_name 
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
AND Quotation_Target.Status LIKE '%' + @Status + '%' " UpdateCommand="UPDATE [Quotation_Target] SET [quotation_id] = @quotation_id, [target_id] = @target_id, [target_description] = @target_description, [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_id] = @authority_id, [technology_id] = @technology_id, [target_rate] = @target_rate, [unit] = @unit, [unit_price] = @unit_price, [discount_type] = @discount_type, [discValue1] = @discValue1, [discValue2] = @discValue2, [discPrice] = @discPrice, [FinalPrice] = @FinalPrice, [PayTo] = @PayTo, [Status] = @Status, [Bill] = @Bill, [option1] = @option1, [option2] = @option2, [advance1] = @advance1, [advance2] = @advance2, [balance1] = @balance1, [balance2] = @balance2, [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Agent] = @Agent WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
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
              <asp:Parameter Name="Agent" Type="Int32" />
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
              <asp:Parameter Name="Agent" Type="Int32" />
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
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("authority_id") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("authority_id") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Document & Sample are ready to be process" SortExpression="document_ready_to_process">
                <EditItemTemplate>
                  <asp:TextBox ID="txtProcess" runat="server" Text='<%# Bind("document_ready_to_process","{0:d}") %>'/>
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
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("test_started") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Bind("test_started") %>'></asp:Label>
                </ItemTemplate>
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
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("certification_submit_to_authority") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label6" runat="server" Text='<%# Bind("certification_submit_to_authority") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Estimated Lead Time" SortExpression="Estimated_Lead_time">
                <EditItemTemplate>
                  <asp:TextBox ID="TextBoxEstimated" runat="server" Text='<%# Bind("Estimated_Lead_time") %>'></asp:TextBox>
                  (Weeks)
                  <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBoxEstimated"
                    ErrorMessage="Must be Numeric Format" ForeColor="Red" MaximumValue="10000" MinimumValue="0"
                    SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("Estimated_Lead_time") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label8" runat="server" Text='<%# Bind("Estimated_Lead_time") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Actual Lead Time" SortExpression="Actual_Lead_time">
                <EditItemTemplate>
                  <asp:TextBox ID="TextBox_Actual_Lead_time" runat="server" ReadOnly="true" Enabled="false"
                    Text='<%# Eval("Actual_Lead_time") %>'></asp:TextBox>
                  <asp:Label ID="Label_Actual_Lead_time" runat="server"></asp:Label>
                  (Weeks)
                  [Certification Completed - Document & Sample are ready to be process]
                </EditItemTemplate>
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox_Actual_Lead_time" runat="server" Text='<%# Eval("Actual_Lead_time") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("Actual_Lead_time") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Agent" SortExpression="Agent">
                <EditItemTemplate>
                  <asp:TextBox ID="TextBoxAgent" runat="server" Text='<%# Eval("Agent") %>' Visible="false"></asp:TextBox>
                  <asp:DropDownList ID="DropDownListAgent" runat="server" DataSourceID="SqlDataSourceVender"
                    DataTextField="name" DataValueField="id" OnDataBound="DropDownListAgent_DataBound">
                  </asp:DropDownList>
                  <asp:SqlDataSource ID="SqlDataSourceVender" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                    SelectCommand="SELECT [id], [name] FROM [vendor] Where Publish=0 Order by name">
                  </asp:SqlDataSource>
                </EditItemTemplate>
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Bind("Agent") %>'></asp:Label>
                </ItemTemplate>
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
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Country_Manager") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Bind("Country_Manager") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Target Status">
                <ItemTemplate>
                  <asp:Label ID="Label7" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                </ItemTemplate>
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
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                </InsertItemTemplate>
              </asp:TemplateField>
              <asp:CommandField ShowEditButton="True" />
            </Fields>
          </asp:DetailsView>
          <asp:SqlDataSource ID="SqlDataSourceModifyTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id"
            InsertCommand="INSERT INTO [Quotation_Target] ([authority_id], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@authority_id, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)"
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.authority_id, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, country.country_name , Authority.authority_name,Country_Manager,world_region_name , Quotation_Target.Status , Quotation_Target.document_ready_to_process 
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.Authority_id = Authority.Authority_id 
LEFT JOIN world_region ON country.world_region_id = world_region.world_region_id
WHERE (Quotation_Target.Quotation_Target_Id = @Quotation_Target_Id)" UpdateCommand="UPDATE [Quotation_Target] SET [authority_id] = @authority_id,[document_ready_to_process] = @document_ready_to_process , [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Agent] = @Agent, [Country_Manager] =@Country_Manager , [Status] = @Status WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
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
              <asp:Parameter Name="Agent" Type="Int32" />
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
              <asp:Parameter Name="Agent" Type="Int32" />
              <asp:Parameter Name="Country_Manager" />
              <asp:Parameter Name="Status" Type="String" />
              <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
               <asp:Parameter Name="document_ready_to_process" Type="DateTime" />
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
