<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ProjectTargetList.aspx.cs" Inherits="Project_ProjectTargetList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Project :
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSourceProject" DataTextField="Project_No" 
            DataValueField="Quotation_Id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceProject" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            SelectCommand="SELECT [Quotation_Id], [Project_No], [Project_Id] FROM [Project]">
        </asp:SqlDataSource>
        <asp:GridView ID="GridViewProjectTarget" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" DataKeyNames="Quotation_Target_Id" 
            DataSourceID="SqlDataSourceTarget" PageSize="20" Width="100%">
            <Columns>
                <asp:CommandField SelectText="Details" ShowSelectButton="True" />
                <asp:BoundField DataField="Quotation_Target_Id" 
                    HeaderText="Id" InsertVisible="False" ReadOnly="True" 
                    SortExpression="Quotation_Target_Id" />
                <asp:BoundField DataField="authority_name" HeaderText="authority_name" 
                    SortExpression="authority_name" />
                <asp:BoundField DataField="country_name" HeaderText="country_name" 
                    SortExpression="country_name" />
                <asp:BoundField DataField="test_started" HeaderText="test_started" 
                    SortExpression="test_started" />
                <asp:BoundField DataField="test_completed" HeaderText="test_completed" 
                    SortExpression="test_completed" />
                <asp:BoundField DataField="certification_submit_to_authority" 
                    HeaderText="certification_submit_to_authority" 
                    SortExpression="certification_submit_to_authority" />
                <asp:BoundField DataField="certification_completed" 
                    HeaderText="certification_completed" SortExpression="certification_completed" />
                <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated_Lead_time" 
                    SortExpression="Estimated_Lead_time" />
                    <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual_Lead_time" 
                    SortExpression="Actual_Lead_time" />
                     <asp:BoundField DataField="Agent" HeaderText="Agent" 
                    SortExpression="Agent" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id" 
            InsertCommand="INSERT INTO [Quotation_Target] ([quotation_id], [target_id], [target_description], [country_id], [product_type_id], [authority_id], [technology_id], [target_rate], [unit], [unit_price], [discount_type], [discValue1], [discValue2], [discPrice], [FinalPrice], [PayTo], [Status], [Bill], [option1], [option2], [advance1], [advance2], [balance1], [balance2], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@quotation_id, @target_id, @target_description, @country_id, @product_type_id, @authority_id, @technology_id, @target_rate, @unit, @unit_price, @discount_type, @discValue1, @discValue2, @discPrice, @FinalPrice, @PayTo, @Status, @Bill, @option1, @option2, @advance1, @advance2, @balance1, @balance2, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)" 
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, country.country_name,authority_name 
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
WHERE (Quotation_Target.quotation_id = @quotation_id)" 
            
            
            
            
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
                <asp:ControlParameter ControlID="DropDownList1" Name="quotation_id" 
                    PropertyName="SelectedValue" Type="Int32" />
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
            DataSourceID="SqlDataSourceModifyTarget" DefaultMode="Edit" Width="100%">
            <Fields>
                <asp:BoundField DataField="Quotation_Target_Id" 
                    HeaderText="Quotation_Target_Id" InsertVisible="False" ReadOnly="True" 
                    SortExpression="Quotation_Target_Id" />
                <asp:TemplateField HeaderText="authority_id" SortExpression="authority_id">
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
                <asp:BoundField DataField="test_started" HeaderText="test_started" 
                    SortExpression="test_started" />
                <asp:BoundField DataField="test_completed" HeaderText="test_completed" 
                    SortExpression="test_completed" />
                <asp:BoundField DataField="certification_submit_to_authority" 
                    HeaderText="certification_submit_to_authority" 
                    SortExpression="certification_submit_to_authority" />
                <asp:BoundField DataField="certification_completed" 
                    HeaderText="certification_completed" SortExpression="certification_completed" />
                <asp:BoundField DataField="Estimated_Lead_time" 
                    HeaderText="Estimated_Lead_time" SortExpression="Estimated_Lead_time" />
                <asp:TemplateField HeaderText="Actual_Lead_time" 
                    SortExpression="Actual_Lead_time">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("Actual_Lead_time") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("Actual_Lead_time") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Actual_Lead_time") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Agent" SortExpression="Agent">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            DataSourceID="SqlDataSourceVender" DataTextField="name" DataValueField="id" 
                            SelectedValue='<%# Bind("Agent") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceVender" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                            SelectCommand="SELECT [id], [name] FROM [vendor] Where Publish=0">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Agent") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceModifyTarget" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @Quotation_Target_Id" 
            InsertCommand="INSERT INTO [Quotation_Target] ([authority_id], [test_started], [test_completed], [certification_submit_to_authority], [certification_completed], [Estimated_Lead_time], [Actual_Lead_time], [Agent]) VALUES (@authority_id, @test_started, @test_completed, @certification_submit_to_authority, @certification_completed, @Estimated_Lead_time, @Actual_Lead_time, @Agent)" 
            SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.authority_id, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent, Authority.authority_name FROM Quotation_Target INNER JOIN Authority ON Quotation_Target.country_id = Authority.country_id WHERE (Quotation_Target.Quotation_Target_Id = @Quotation_Target_Id)"             
            UpdateCommand="UPDATE [Quotation_Target] SET [authority_id] = @authority_id, [test_started] = @test_started, [test_completed] = @test_completed, [certification_submit_to_authority] = @certification_submit_to_authority, [certification_completed] = @certification_completed, [Estimated_Lead_time] = @Estimated_Lead_time, [Actual_Lead_time] = @Actual_Lead_time, [Agent] = @Agent WHERE [Quotation_Target_Id] = @Quotation_Target_Id">
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
                <asp:Parameter Name="Quotation_Target_Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

