<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ProjectWorkingStatusList.aspx.cs" Inherits="Project_ProjectWorkingStatusList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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
      .Arraw {color:#0000BB; cursor:hand; font-family:Webdings; font-size:9pt}      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <table border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
			<tr>
				<td  id="frmLeft" valign="top">
					<table   cellPadding="0" cellSpacing="0">
						<tr>
							<td >Target Status : 
                                <asp:TreeView ID="TreeViewStatus" runat="server" ImageSet="WindowsHelp" 
                                    ShowLines="True">
                                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                    <Nodes>
                                        <asp:TreeNode Text="案件管理" Value="案件管理">
                                            <asp:TreeNode Text="新開案的案子(Open)" Value="Open"></asp:TreeNode>
                                            <asp:TreeNode Text="申請中的案子(In-Progress)" Value="In-Progress"></asp:TreeNode>
                                            <asp:TreeNode Text="暫停的案子(On-Hold)" Value="On-Hold"></asp:TreeNode>
                                            <asp:TreeNode Text="完成的案子(Done)" Value="Done"></asp:TreeNode>
                                            <asp:TreeNode Text="取消的案子(Cancelled)" Value="Cancelled"></asp:TreeNode>
                                            <asp:TreeNode Text="逾時案件(Delay)" Value="Delay"></asp:TreeNode>
                                        </asp:TreeNode>
                                        <asp:TreeNode Text="案件總覽" Value="%"></asp:TreeNode>
                                    </Nodes>
                                    <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" 
                                        HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="1px" />
                                    <ParentNodeStyle Font-Bold="False" />
                                    <SelectedNodeStyle BackColor="#B5B5B5" Font-Underline="False" 
                                        HorizontalPadding="0px" VerticalPadding="0px" />
                                </asp:TreeView>
							</td>
						</tr>
            <tr>
              <td>
                <br />
                <br />
              </td>
            </tr>
					</table>
				</td>
				<td bgColor="#c3dcf1" style="WIDTH: 5pt" height="100%">
					<table border="0" cellpadding="0" cellspacing="0" height="100%">
						<tr>
							<td onClick="switchMenu()" style="HEIGHT: 100%">
								<span class="Arraw" id="SwitchArraw" title="顯示/隱藏選單">3</span></td>
						</tr>
					</table>
				</td>
				<td valign="top" cellPadding="10" cellSpacing="10" style="WIDTH: 100%" height="100%" >

          <asp:Panel ID="PanelSearch" runat="server" 
            GroupingText="Project Target Search Condition">
            Project No:
            <asp:DropDownList ID="DropDownListPO" runat="server" 
            DataSourceID="SqlDataSourceProject" DataTextField="Project_No" 
            DataValueField="Project_Id" AppendDataBoundItems="True">
              <asp:ListItem Value="%">- All -</asp:ListItem>
            </asp:DropDownList>
            &nbsp;Country Manager :
            <asp:DropDownList ID="DropDownListCM" runat="server" 
            AppendDataBoundItems="True" DataSourceID="SqlDataSourceCM" 
            DataTextField="fname" DataValueField="id">
              <asp:ListItem Value="0">- All -</asp:ListItem>
            </asp:DropDownList>
            &nbsp;AE :
            <asp:DropDownList ID="DropDownListAE" runat="server" 
            AppendDataBoundItems="True" DataSourceID="SqlDataSourceAE" 
            DataTextField="fname" DataValueField="id">
              <asp:ListItem Value="%">- All -</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceAE" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
  SelectCommand="SELECT [id], [fname] FROM [employee] where status='Active'">
            </asp:SqlDataSource>
            <br />
            <br />
            Region :
            <asp:DropDownList ID="DropDownListRegion" runat="server" 
            AppendDataBoundItems="True" AutoPostBack="True" 
            DataSourceID="SqlDataSourceRegion" DataTextField="world_region_name" 
            DataValueField="world_region_id">
              <asp:ListItem Value="0">- All -</asp:ListItem>
            </asp:DropDownList>
            Country :
            <asp:DropDownList ID="DropDownListCountry" runat="server" 
            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
            DataValueField="country_name" 
  ondatabound="DropDownListCountry_DataBound">
            </asp:DropDownList>
            &nbsp;<br />
            <br />
            Client :
            <asp:DropDownList ID="DropDownListClient" runat="server" AppendDataBoundItems="True" 
  DataSourceID="SqlDataSourceClient" DataTextField="companyname" 
  DataValueField="id">
              <asp:ListItem Value="%">- All -</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
  
              SelectCommand="SELECT [id], [companyname] FROM [clientapplicant] Where clientapplicant_type = 1 or clientapplicant_type = 3">
            </asp:SqlDataSource>
            &nbsp;<asp:Button ID="ButtonSearch" runat="server" onclick="ButtonSearch_Click" 
            Text="Search" />
          </asp:Panel>
  <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
          <br />
  <asp:GridView ID="GridViewProjectTarget" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" DataKeyNames="Quotation_Target_Id" 
            DataSourceID="SqlDataSourceTarget" PageSize="20" Width="100%" 
            AllowSorting="True" EmptyDataText="Project下沒有可設定的相關資料!">
    <Columns>
      <asp:HyperLinkField DataNavigateUrlFields="Project_Id,country_id,Quotation_Target_Id" 
        DataNavigateUrlFormatString="~/Project/ProjectWorkingStatus.aspx?ProjectID={0}&amp;CountryID={1}&amp;TargetID={2}" 
        HeaderText="Working Status" Target="_blank" Text="Setting" />
      <asp:TemplateField HeaderText="ID" InsertVisible="False">
        <ItemTemplate>
          <asp:Label ID="LabelTarget" runat="server" 
            Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="Project No" SortExpression="Project_No">       
        <ItemTemplate>
          <asp:Label ID="LabelNo" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
          <asp:HiddenField ID="HFCountry" runat="server" 
            Value='<%# Bind("country_id") %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:BoundField DataField="Client" HeaderText="Client" 
        SortExpression="Client" />
      <asp:BoundField DataField="Model_No" 
                    HeaderText="Model No" />
      <asp:BoundField DataField="world_region_name" HeaderText="Region" 
        SortExpression="world_region_name" />
      <asp:BoundField DataField="country_name" HeaderText="Country" 
                    SortExpression="country_name" />
      <asp:BoundField DataField="authority_name" HeaderText="Authority" 
                    SortExpression="authority_name" />
      <asp:BoundField DataField="Status" HeaderText="Status" 
        SortExpression="Status" />
      <asp:BoundField DataField="target_description" HeaderText="T.Description" />
      <asp:BoundField DataField="test_started" HeaderText="Test Started" 
                    SortExpression="test_started" DataFormatString="{0:d}" />
      <asp:BoundField DataField="test_completed" HeaderText="Test Completed" 
                    SortExpression="test_completed" DataFormatString="{0:d}" />
      <asp:BoundField DataField="certification_submit_to_authority" 
                    HeaderText="Certification Submit To Authority" 
                    SortExpression="certification_submit_to_authority" 
                    DataFormatString="{0:d}" />
      <asp:BoundField DataField="certification_completed" 
                    HeaderText="Certification Completed" 
                    SortExpression="certification_completed" DataFormatString="{0:d}" />
      <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated Lead Time" 
                    SortExpression="Estimated_Lead_time" Visible="False" />
      <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" 
                    SortExpression="Actual_Lead_time" Visible="False" />
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
  <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent
, country.country_name, Authority.authority_name ,world_region.world_region_name
,(Select fname from employee where id = Country_Manager ) as CountryManager
,Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No
, SalesId , Employee.fname as 'AE'
, Client_Id , clientapplicant.companyname as 'Client'
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
AND (country.country_name LIKE '%' + @country_name + '%') 
AND (SalesId  LIKE @SalesId) 
AND (Client_Id  LIKE @Client_Id) 
ORDER BY Project.Project_Id Desc">
    <SelectParameters>
      <asp:ControlParameter ControlID="DropDownListPO" DefaultValue="%" 
        Name="Project_ID" PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="TreeViewStatus" DefaultValue="%" 
        Name="Status" PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListCountry" DefaultValue="%" 
        Name="country_name" PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListAE" DefaultValue="%" 
        Name="SalesId" PropertyName="SelectedValue" />
      <asp:ControlParameter ControlID="DropDownListClient" DefaultValue="%" 
        Name="Client_Id" PropertyName="SelectedValue" />
    </SelectParameters>
  </asp:SqlDataSource>

				  <asp:SqlDataSource ID="SqlDataSourceCM" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [fname] FROM [employee] where status='Active'">
          </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
          
            SelectCommand="SELECT [Project].[Quotation_Id], [Project].[Quotation_No],[Project_Id], [Project_No] +' [' + Model_NO + ']' as [Project_No]
FROM [Project]
INNER JOIN Quotation_Version ON [Project].Quotation_Id = Quotation_Version.Quotation_Version_Id">
  </asp:SqlDataSource>

          <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [world_region_id], [world_region_name] FROM [world_region]">
          </asp:SqlDataSource>
          <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [country_id], [country_name] FROM [country] WHERE ([world_region_id] = @world_region_id)">
            <SelectParameters>
              <asp:ControlParameter ControlID="DropDownListRegion" Name="world_region_id" 
                PropertyName="SelectedValue" Type="Byte" />
            </SelectParameters>
          </asp:SqlDataSource>

				</td>
			</tr>
		</table>




        
</asp:Content>

