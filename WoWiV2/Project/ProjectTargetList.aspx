<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ProjectTargetList.aspx.cs" Inherits="Project_ProjectTargetList" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxcontroltoolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <center>
      <asp:LinkButton ID="LinkButtonTop" runat="server" onclick="LinkButtonTop_Click">Setting Working Status</asp:LinkButton>
    </center>
    <p>
        Project No:
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSourceProject" DataTextField="Project_No" 
            DataValueField="Quotation_No">
        </asp:DropDownList>
        <br />
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            
          
            SelectCommand="SELECT [Project].[Quotation_Id], [Project].[Quotation_No],[Project_Id], [Project_No] +' [' + Model_NO + ']' as [Project_No]
FROM [Project]
INNER JOIN Quotation_Version ON [Project].Quotation_Id = Quotation_Version.Quotation_Version_Id">
        </asp:SqlDataSource>
        <asp:GridView ID="GridViewProjectTarget" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" DataKeyNames="Quotation_Target_Id" 
            DataSourceID="SqlDataSourceTarget" PageSize="20" Width="100%" 
            AllowSorting="True">
            <Columns>
                <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                <asp:BoundField DataField="Quotation_Target_Id" 
                    HeaderText="ID" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="country_name" HeaderText="Country" 
                    SortExpression="country_name" />
                <asp:BoundField DataField="authority_name" HeaderText="Authority" 
                    SortExpression="authority_name" />
                <asp:BoundField DataField="target_description" HeaderText="T.Description" />
                <asp:BoundField DataField="Status" HeaderText="Status" 
                  SortExpression="Status" />
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
                     <asp:TemplateField HeaderText="Agent" SortExpression="Agent" 
                    Visible="False">
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
        <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id" 
            InsertCommand="INSERT INTO [Quotation_Target] ([quotation_id], [target_id], [target_description], [country_id], [product_type_id], [authority_id], [technology_id], [target_rate], [unit], [unit_price], [discount_type], [discValue1], [discValue2], [discPrice], [FinalPrice], [PayTo], [Status], [Bill], [option1], [option2], [advance1], [advance2], [balance1], [balance2], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@quotation_id, @target_id, @target_description, @country_id, @product_type_id, @authority_id, @technology_id, @target_rate, @unit, @unit_price, @discount_type, @discValue1, @discValue2, @discPrice, @FinalPrice, @PayTo, @Status, @Bill, @option1, @option2, @advance1, @advance2, @balance1, @balance2, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)" 
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, country.country_name,authority_name , (Select fname + ' ' + lname as [fname] from employee where id = Country_Manager ) as CountryManager , Quotation_Target.Status
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
WHERE (Quotation_Target.quotation_id in 
(Select Quotation_Version_Id from Quotation_Version Where  Quotation_Status=5 AND Quotation_No=@Quotation_No))" 
            
            
          
          
          UpdateCommand="UPDATE [Quotation_Target] SET [quotation_id] = @quotation_id, [target_id] = @target_id, [target_description] = @target_description, [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_id] = @authority_id, [technology_id] = @technology_id, [target_rate] = @target_rate, [unit] = @unit, [unit_price] = @unit_price, [discount_type] = @discount_type, [discValue1] = @discValue1, [discValue2] = @discValue2, [discPrice] = @discPrice, [FinalPrice] = @FinalPrice, [PayTo] = @PayTo, [Status] = @Status, [Bill] = @Bill, [option1] = @option1, [option2] = @option2, [advance1] = @advance1, [advance2] = @advance2, [balance1] = @balance1, [balance2] = @balance2, [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Agent] = @Agent WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
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
                <asp:ControlParameter ControlID="DropDownList1" Name="Quotation_No" 
                    PropertyName="SelectedValue" />
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
        <asp:DetailsView ID="DetailsViewTarget" runat="server" AutoGenerateRows="False" 
            Caption="Target Details" DataKeyNames="Quotation_Target_Id" 
            DataSourceID="SqlDataSourceModifyTarget" DefaultMode="Edit" Width="100%" 
            onitemupdated="DetailsViewTarget_ItemUpdated" 
            onitemupdating="DetailsViewTarget_ItemUpdating" 
          ondatabound="DetailsViewTarget_DataBound">
            <Fields>
                <asp:BoundField DataField="Quotation_Target_Id" 
                    HeaderText="ID" InsertVisible="False" ReadOnly="True" 
                    SortExpression="Quotation_Target_Id" />
                <asp:BoundField DataField="world_region_name" HeaderText="Region" 
                  ReadOnly="True" />
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
                <asp:TemplateField HeaderText="Test Started<br/>Test Completed" SortExpression="test_started">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" 
                            Text='<%# Bind("test_started","{0:d}") %>'></asp:TextBox>                        
                          <ajaxcontroltoolkit:calendarextender ID="TextBox3_CalendarExtender" 
                            runat="server" Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image1" 
                            TargetControlID="TextBox3">
                          </ajaxcontroltoolkit:calendarextender>
                          <asp:Image ID="Image1" runat="server" 
                            ImageUrl="~/Images/Calendar_scheduleHS.png" />
                          <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="日期格式有誤" 
                            Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" 
                            ForeColor="Red"></asp:CompareValidator>
                            <br/>
                             <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("test_completed","{0:d}") %>'></asp:TextBox>
                         <ajaxcontroltoolkit:calendarextender ID="TextBox4_CalendarExtender" 
                            runat="server" Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image2" 
                            TargetControlID="TextBox4">
                          </ajaxcontroltoolkit:calendarextender>
                          <asp:Image ID="Image2" runat="server" 
                            ImageUrl="~/Images/Calendar_scheduleHS.png" />
                          <asp:CompareValidator ID="CompareValidator2" runat="server" 
                            ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="日期格式有誤" 
                            Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" 
                            ForeColor="Red"></asp:CompareValidator>
                        <asp:CompareValidator ID="CompareValidator7" runat="server" 
                            ControlToCompare="TextBox4" ControlToValidate="TextBox3" Display="Dynamic" 
                            ErrorMessage="test started 日期不得大於 test completed，請重新輸入!" ForeColor="Red" 
                            Operator="LessThan" Type="Date"></asp:CompareValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("test_started") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("test_started") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:TemplateField HeaderText="test_completed" SortExpression="test_completed">
                    <EditItemTemplate>
                       
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("test_completed") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("test_completed") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Certification Submit To Authority<br/>Certification Completed" 
                    SortExpression="certification_submit_to_authority">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" 
                            Text='<%# Bind("certification_submit_to_authority","{0:d}") %>'></asp:TextBox>
                            <ajaxcontroltoolkit:calendarextender ID="TextBox5_CalendarExtender" 
                            runat="server" Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image5" 
                            TargetControlID="TextBox5">
                          </ajaxcontroltoolkit:calendarextender>
                          <asp:Image ID="Image5" runat="server" 
                            ImageUrl="~/Images/Calendar_scheduleHS.png" />
                          <asp:CompareValidator ID="CompareValidator5" runat="server" 
                            ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="日期格式有誤" 
                            Operator="DataTypeCheck" SetFocusOnError="True" Type="Date"></asp:CompareValidator>
                            <br/>
                             <asp:TextBox ID="TextBox6" runat="server" 
                            Text='<%# Bind("certification_completed","{0:d}") %>'></asp:TextBox>
                            <ajaxcontroltoolkit:calendarextender ID="TextBox6_CalendarExtender" 
                            runat="server" Enabled="True" Format="yyyy/MM/dd" PopupButtonID="Image6" 
                            TargetControlID="TextBox6">
                          </ajaxcontroltoolkit:calendarextender>
                          <asp:Image ID="Image6" runat="server" 
                            ImageUrl="~/Images/Calendar_scheduleHS.png" />
                          <asp:CompareValidator ID="CompareValidator6" runat="server" 
                            ControlToValidate="TextBox6" Display="Dynamic" ErrorMessage="日期格式有誤" 
                            Operator="DataTypeCheck" SetFocusOnError="True" Type="Date"></asp:CompareValidator>
                        <asp:CompareValidator ID="CompareValidator8" runat="server" 
                            ControlToCompare="TextBox6" ControlToValidate="TextBox5" Display="Dynamic" 
                            ErrorMessage="certification_submit_to_authority 日期不得大於 certification_completed，請重新輸入!" 
                            ForeColor="Red" Operator="LessThan" Type="Date"></asp:CompareValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" 
                            Text='<%# Bind("certification_submit_to_authority") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" 
                            Text='<%# Bind("certification_submit_to_authority") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:TemplateField HeaderText="certification_completed" 
                    SortExpression="certification_completed">
                    <EditItemTemplate>
                       
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" 
                            Text='<%# Bind("certification_completed") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" 
                            Text='<%# Bind("certification_completed") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <asp:TemplateField HeaderText="Estimated Lead Time" 
                    SortExpression="Estimated_Lead_time">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxEstimated" runat="server" 
                            Text='<%# Bind("Estimated_Lead_time") %>'></asp:TextBox> (Weeks)
                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                          ControlToValidate="TextBoxEstimated" ErrorMessage="Must be Numeric Format" 
                          ForeColor="Red" MaximumValue="10000" MinimumValue="0" SetFocusOnError="True" 
                          Type="Integer"></asp:RangeValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" 
                            Text='<%# Bind("Estimated_Lead_time") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("Estimated_Lead_time") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actual Lead Time" 
                    SortExpression="Actual_Lead_time">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox_Actual_Lead_time" runat="server" ReadOnly="true" Enabled="false"
                           Text='<%# Eval("Actual_Lead_time") %>' ></asp:TextBox> 
                        <asp:Label ID="Label_Actual_Lead_time" runat="server"></asp:Label>
                        (Weeks)
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox_Actual_Lead_time" runat="server" 
                            Text='<%# Eval("Actual_Lead_time") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Actual_Lead_time") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Agent" SortExpression="Agent">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxAgent" runat="server" Text='<%# Eval("Agent") %>' Visible="false"></asp:TextBox>
                        <asp:DropDownList ID="DropDownListAgent" runat="server" 
                            DataSourceID="SqlDataSourceVender" DataTextField="name" 
                            DataValueField="id" ondatabound="DropDownListAgent_DataBound">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceVender" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                            
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
                <asp:TemplateField HeaderText="Country Manager" 
                    SortExpression="Country_Manager">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBoxCM" runat="server" Text='<%# Eval("Country_Manager") %>' Visible="false"></asp:TextBox>
                        <asp:DropDownList ID="DropDownListEmp" runat="server" 
                          DataSourceID="SqlDataSourceEmp" DataTextField="fname" DataValueField="id" 
                          ondatabound="DropDownListEmp_DataBound" 
                          >
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                            
                          SelectCommand="SELECT [id], [fname] + ' ' + [lname] as [fname] FROM [employee]  where status='Active'"></asp:SqlDataSource>
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
                    <asp:TextBox ID="TextBoxStatus" runat="server" Text='<%# Eval("Status") %>' 
                      Visible="False"></asp:TextBox>
                  </EditItemTemplate>
                  <InsertItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                  </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />               
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceModifyTarget" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id" 
            InsertCommand="INSERT INTO [Quotation_Target] ([authority_id], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@authority_id, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)" 
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.authority_id, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, country.country_name , Authority.authority_name,Country_Manager,world_region_name , Quotation_Target.Status
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.Authority_id = Authority.Authority_id 
LEFT JOIN world_region ON country.world_region_id = world_region.world_region_id
WHERE (Quotation_Target.Quotation_Target_Id = @Quotation_Target_Id)"
          
          UpdateCommand="UPDATE [Quotation_Target] SET [authority_id] = @authority_id, [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Agent] = @Agent, [Country_Manager] =@Country_Manager , [Status] = @Status WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
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
                <asp:ControlParameter ControlID="GridViewProjectTarget" 
                    Name="Quotation_Target_Id" PropertyName="SelectedValue" Type="Int32" />
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
                <asp:Parameter Name="Status"  Type="String"/>
                <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <center>
      <asp:LinkButton ID="LinkButtonFooter" runat="server" 
        onclick="LinkButtonTop_Click">Setting Working Status</asp:LinkButton>
    </center>
</asp:Content>

