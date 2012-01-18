<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ProjectWorkingStatusReport.aspx.cs" Inherits="Project_ProjectWorkingStatusReport" %>

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
    <style type="text/css"> .Arraw {color:#0000BB; cursor:hand; font-family:Webdings; font-size:9pt} 
        .style1
        {
            width: 100%;
        }
        
        .style2
        {
            text-decoration: underline;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

       <table border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
			<tr>
				<td  id="frmLeft" valign="top">
					<table   cellPadding="0" cellSpacing="0">
						<tr>
							<td >
                                <asp:TreeView ID="TreeViewMenu" runat="server" ImageSet="WindowsHelp" 
                                    ShowLines="True" onselectednodechanged="TreeViewMenu_SelectedNodeChanged">
                                    <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                                    <Nodes>
                                        <asp:TreeNode Text="案件管理" Value="案件管理">
                                            <asp:TreeNode Text="未完成的案子(Open)" Value="Open"></asp:TreeNode>
                                            <asp:TreeNode Text="申請中的案子(In-Progress)" Value="In-Progress"></asp:TreeNode>
                                            <asp:TreeNode Text="暫停的案子(On-Hand)" Value="On-Hand"></asp:TreeNode>
                                            <asp:TreeNode Text="完成的案子(Done)" Value="Done"></asp:TreeNode>
                                            <asp:TreeNode Text="取消的案子(Cancelled)" Value="Cancelled"></asp:TreeNode>
                                            <asp:TreeNode Text="逾時案件(Lost)" Value="Lost"></asp:TreeNode>
                                            <asp:TreeNode Text="待刪除案件(Void)" Value="Void"></asp:TreeNode>
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
					Sales (AE) :
                    <asp:DropDownList ID="DropDownListAE" runat="server" 
                        AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSourceAE" 
                        DataTextField="fname" DataValueField="id" 
                        onselectedindexchanged="DropDownListAE_SelectedIndexChanged">
                        <asp:ListItem Value="%">Please Select One Sales (Default All)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceAE" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT [id], [fname] FROM [employee]"></asp:SqlDataSource>
                    <asp:GridView ID="GridViewProject" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="Project_Id" DataSourceID="SqlDataSourceProject" 
                        EmptyDataText="未有相對應之案件管理條件資料，以及指定Sales所負責之Project資料" Width="100%" 
                        onselectedindexchanging="GridViewProject_SelectedIndexChanging">
                        <Columns>
                            <asp:CommandField SelectText="View Report" ShowSelectButton="True" />
                            <asp:BoundField DataField="Project_Id" HeaderText="Project Id" 
                                InsertVisible="False" ReadOnly="True" SortExpression="Project_Id" />
                            <asp:BoundField DataField="Project_No" HeaderText="Project No" 
                                SortExpression="Project_No" />
                            <asp:BoundField DataField="Project_Status" HeaderText="Project Status" 
                                SortExpression="Project_Status" />
                            <asp:BoundField DataField="companyname" HeaderText="Client" 
                                SortExpression="companyname" />
                            <asp:BoundField DataField="Model_No" HeaderText="Model No" 
                                SortExpression="Model_No" />
                            <asp:BoundField DataField="Product_Name" HeaderText="Product Name" 
                                SortExpression="Product_Name" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT Project.Project_Id, Project.Project_No, Project.Project_Status, clientapplicant.companyname, Quotation_Version.Model_No, Quotation_Version.Product_Name FROM Project INNER JOIN Quotation_Version ON Project.Quotation_Id = Quotation_Version.Quotation_Version_Id INNER JOIN clientapplicant ON Quotation_Version.Client_Id = clientapplicant.id WHERE (Quotation_Version.SalesId LIKE  @SalesID) AND (Project.Project_Status LIKE @Project_Status)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListAE" DefaultValue="%" 
                                Name="SalesID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TreeViewMenu" DefaultValue="%" 
                                Name="Project_Status" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
				    <br />
				    <asp:Panel ID="PanelReport" runat="server" Visible="False">
                        <asp:Button ID="ButtonExcel" runat="server" Text="Export Report To Excel" 
                            onclick="ButtonExcel_Click" />
                        <br />
                        <table cellspacing="1" class="style1">
                            <tr>
                                <td>
                                    <asp:Image ID="ImageLogo" runat="server" ImageUrl="~/Images/logo.gif" 
                                        Visible="False" />
                                        <table border="1" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="style2">
                                                <strong>Product Name</strong></td>
                                            <td class="style2">
                                                <strong>Model No</strong></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="LabelProduct" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="LabelModel" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2">
                                                <strong>Client</strong></td>
                                            <td>
                                                <asp:Label ID="LabelClient" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style2">
                                                <strong>Project No</strong></td>
                                            <td>
                                                <asp:Label ID="LabelProject" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                                <td>
                                    Add. 3F., No.79, Zhouzi St., Neihu Dist., Taipei City 114, Taiwan (R.O.C.)
                                    <br />
                                    Tel. +886-2799-8382 Fax. +886-2799-8387
                                    <br />
                                    地址. 台北市內湖區洲子街79號3樓 
                                    <br />
                                    http://www.WoWiApproval.com</td>
                            </tr>                           
                            <tr>
                                <td colspan="2">
                                    <br />
                                    <asp:GridView ID="GridViewReport" runat="server" AutoGenerateColumns="False" 
                                        DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceReport" 
                                        onprerender="GridViewReport_PreRender" Width="100%" 
                                        Caption="Project Working Status" EmptyDataText="此案件尚未有相關的Project Status紀錄!">
                                        <Columns>
                                            <asp:BoundField DataField="country_name" HeaderText="Country" 
                                                SortExpression="country_name" />
                                            <asp:BoundField DataField="authority_name" HeaderText="Authority(Target)" 
                                                SortExpression="authority_name" />
                                            <asp:BoundField DataField="companyname" HeaderText="Applicant" 
                                                SortExpression="companyname" />
                                            <asp:BoundField DataField="test_started" HeaderText="test_started" 
                                                SortExpression="test_started" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="test_completed" HeaderText="Est. completed" 
                                                SortExpression="test_completed" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="certification_submit_to_authority" 
                                                HeaderText="submit to authority" 
                                                SortExpression="certification_submit_to_authority" 
                                                DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="certification_completed" HeaderText="Est. completed" 
                                                SortExpression="certification_completed" DataFormatString="{0:d}" />
                                            <asp:BoundField DataField="Estimated_Lead_time" 
                                                HeaderText="Estimated Lead Time" SortExpression="Estimated_Lead_time" />
                                            <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" 
                                                SortExpression="Actual_Lead_time" />
                                            <asp:TemplateField HeaderText="Project Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label_Quotation_Target_Id" runat="server" Visible="false" 
                                                        Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
                                                    <asp:BulletedList ID="BulletedListStatus" runat="server" 
                                                        DataSourceID="SqlDataSourceStatus" DataTextField="Status" 
                                                        DataValueField="Status">
                                                    </asp:BulletedList>
                                                    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" 
                                                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                        
                                                        SelectCommand="SELECT Substring(CONVERT(char(10), log_date, 111) , 6,10) + ':' + log_content  AS 'Status' FROM Project_working_log WHERE (target_id = @Quotation_Version_Id)">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="Label_Quotation_Target_Id" 
                                                                Name="Quotation_Version_Id" PropertyName="Text" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Client_Action" HeaderText="Action" 
                                                SortExpression="Client_Action" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSourceReport" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="SELECT     Quotation_Target.Quotation_Target_Id,country.country_name, Authority.authority_name, clientapplicant.companyname, Quotation_Target.test_started, Quotation_Target.test_completed, 
                      Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, 
                      Quotation_Target.Actual_Lead_time, Project.Client_Action
FROM         Project INNER JOIN
                      Quotation_Target ON Project.Quotation_Id = Quotation_Target.Quotation_Id INNER JOIN
                      Authority ON Quotation_Target.authority_id = Authority.authority_id INNER JOIN
                      country ON Quotation_Target.country_id = country.country_id INNER JOIN
                      Quotation_Version ON Quotation_Target.quotation_id = Quotation_Version.Quotation_Version_Id INNER JOIN
                      clientapplicant ON Quotation_Version.Applicant_Id = clientapplicant.id
Where Project.Project_ID=@Project_ID">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="GridViewProject" Name="Project_ID" 
                                                PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <br />
				</td>
			</tr>
		</table>

</asp:Content>

