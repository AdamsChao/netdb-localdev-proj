<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="ProjectWorkingStatus.aspx.cs" Inherits="Project_ProjectWorkingStatus" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <asp:Panel ID="pnlWorkingStatusManagement" runat="server">
    <center>
          <asp:Label ID="lblProject" runat="server" Visible="False"></asp:Label>
          <asp:Label ID="lblCountry" runat="server" Visible="False"></asp:Label>
          <asp:Label ID="lblTarget" runat="server" Visible="False"></asp:Label>
    </center>
    <fieldset>
      <legend>Working Status</legend>
      <table>
        <tr>
          <td>
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
          </td>
          <td>
            <p />
            Project：<asp:DropDownList ID="ddlWorkingStatusProject" runat="server" AutoPostBack="True"
              DataSourceID="GetProjectsHasTargetSqlDataSource" DataTextField="Project_No" DataValueField="Project_Id"
              EnableTheming="False" OnSelectedIndexChanged="ddlWorkingStatusProject_SelectedIndexChanged"
              OnDataBound="ddlWorkingStatusProject_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="GetProjectsHasTargetSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
              SelectCommand="SELECT [Project_Id], [Project_No] +' [' + Model_NO + ']' as [Project_No]
FROM [Project]
INNER JOIN Quotation_Version ON [Project].Quotation_Id = Quotation_Version.Quotation_Version_Id
WHERE ([Project_Status] LIKE '%' + @Project_Status + '%') ">
              <SelectParameters>
                <asp:ControlParameter ControlID="TreeViewMenu" DefaultValue="%" Name="Project_Status"
                  PropertyName="SelectedValue" Type="String" />
              </SelectParameters>
            </asp:SqlDataSource>
            <p />
            Country：<asp:DropDownList ID="ddlWorkingStatusCountry" runat="server" AutoPostBack="True"
              DataSourceID="ProjectCountrySqlDataSource" DataTextField="country_name" DataValueField="country_id"
              EnableTheming="False" OnDataBound="ddlWorkingStatusCountry_DataBound" OnSelectedIndexChanged="ddlWorkingStatusCountry_SelectedIndexChanged">
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
              OnSelectedIndexChanged="ddlWorkingStatusTarget_SelectedIndexChanged">
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
          </td>
        </tr>
      </table>
      <p />
      <asp:GridView ID="gvWorkingStatus" runat="server" DataSourceID="gvWorkingStatusSqlDataSource"
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4"
        DataKeyNames="log_id" EmptyDataText="沒有資料可以顯示。" ForeColor="#333333" HorizontalAlign="Center"
        RowHeaderColumn="id" ShowHeaderWhenEmpty="True" Width="100%" EnablePersistedSelection="True"
        EnableTheming="False" OnRowDataBound="gvWorkingStatus_RowDataBound" PageSize="30">
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
              <asp:CalendarExtender ID="txtLogDate_CalendarExtender" runat="server" Enabled="True"
                Format="yyyy/MM/dd" TargetControlID="txtLogDate" TodaysDateFormat="yyyy/MM/dd">
              </asp:CalendarExtender>
              <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtLogDate"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Please enter a valid date."
                ForeColor="Red" Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" ValidationGroup="AddWorkingStatus">
              </asp:CompareValidator>
              <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" Enabled="True"
                HighlightCssClass="RequiredFieldHighlight" TargetControlID="CompareValidator1"
                Width="250px" PopupPosition="Right">
              </asp:ValidatorCalloutExtender>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLogDate"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Date is required."
                ForeColor="Red" SetFocusOnError="True" ValidationGroup="AddWorkingStatus">
              </asp:RequiredFieldValidator>
              <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" Enabled="True"
                HighlightCssClass="RequiredFieldHighlight" TargetControlID="RequiredFieldValidator2"
                Width="250px" PopupPosition="Right">
              </asp:ValidatorCalloutExtender>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("log_date") %>'></asp:Label>
            </ItemTemplate>
            <HeaderStyle Width="10%" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Working Status">
            <%--<EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("log_content") %>'></asp:TextBox>
                        </EditItemTemplate>--%>
            <InsertItemTemplate>
              <table width="100%">
                <tr>
                  <td width="14%" style="font-weight: bold">
                    Application in preparation：
                  </td>
                  <td>
                    <asp:DropDownList ID="ddlworkingStatusTemplate1" runat="server" AutoPostBack="True"
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate1_SelectedIndexChanged">
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
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate2_SelectedIndexChanged">
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
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate3_SelectedIndexChanged">
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
                      EnableTheming="False" OnSelectedIndexChanged="ddlworkingStatusTemplate4_SelectedIndexChanged">
                      <asp:ListItem Value="">Select a template....</asp:ListItem>
                      <asp:ListItem>Application rejected by Authority.</asp:ListItem>
                      <asp:ListItem>Certificate received. Project closed.</asp:ListItem>
                      <asp:ListItem>Project cancelled by Client.</asp:ListItem>
                      <asp:ListItem>Project resumed at Client's request.</asp:ListItem>
                      <asp:ListItem>Revision rejected by Authority.</asp:ListItem>
                    </asp:DropDownList>
                  </td>
                </tr>
              </table>
              <br />
              <asp:TextBox ID="txtLogContent" runat="server" EnableTheming="False" Rows="5" TextMode="MultiLine"
                Width="450" ValidationGroup="AddWorkingStatus" Text='<%# Bind("log_content") %>'>
              </asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLogContent"
                Display="None" EnableTheming="False" ErrorMessage="<strong>Required Field Missing</strong><br />&nbsp;&nbsp;Working Status is required."
                ForeColor="Red" SetFocusOnError="True" ValidationGroup="AddWorkingStatus">
              </asp:RequiredFieldValidator>
              <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" Enabled="True"
                HighlightCssClass="RequiredFieldHighlight" TargetControlID="RequiredFieldValidator3"
                Width="250px" PopupPosition="BottomLeft">
              </asp:ValidatorCalloutExtender>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label2" runat="server" Text='<%# Bind("log_content") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Create By">
            <%--<EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("create_by") %>'></asp:TextBox>
                        </EditItemTemplate>--%>
            <InsertItemTemplate>
              <asp:Label ID="LabelCreateBy" runat="server" Text='<%# Bind("create_by") %>'></asp:Label>
            </InsertItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelCreateBy" runat="server" Text='<%# Bind("create_by") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:CheckBoxField DataField="external_use" HeaderText="External" />
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
    </fieldset>
  </asp:Panel>
</asp:Content>
