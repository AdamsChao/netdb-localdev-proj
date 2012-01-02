<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    protected void LinkButtonCreate_Click(object sender, EventArgs e)
    {
        LinkButtonList.Visible = true;
        LinkButtonCreate.Visible = false;
        DetailsViewCreate.Visible = true;
        GridViewRate.Visible = false; 
    }

    protected void LinkButtonList_Click(object sender, EventArgs e)
    {
        LinkButtonList.Visible = false;
        LinkButtonCreate.Visible = true;
        DetailsViewCreate.Visible = false;
        GridViewRate.Visible = true;
        GridViewRate.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Target Rate Lists :
        <asp:LinkButton ID="LinkButtonCreate" runat="server" 
            onclick="LinkButtonCreate_Click" CausesValidation="False">Create</asp:LinkButton>
        <asp:LinkButton ID="LinkButtonList" runat="server" Visible="False" 
            onclick="LinkButtonList_Click" CausesValidation="False">Target List</asp:LinkButton>
        <br />
        <asp:DetailsView ID="DetailsViewCreate" runat="server" AutoGenerateRows="False" 
            DataKeyNames="Target_rate_id" DataSourceID="SqlDataSourceRate" 
            DefaultMode="Insert" Height="50px" Width="125px" Visible="False">
            <Fields>
                <asp:BoundField DataField="Target_rate_id" HeaderText="Target_rate_id" 
                    InsertVisible="False" ReadOnly="True" SortExpression="Target_rate_id" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_id") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("country_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownListCountry" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Technology" SortExpression="Technology_id">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Technology_id") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Technology_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceTech" DataTextField="wowi_tech_name" 
                            DataValueField="wowi_tech_id" SelectedValue='<%# Bind("Technology_id") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate" SortExpression="rate">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Please Input Rate" 
                            SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                            ControlToValidate="TextBox3" Display="Dynamic" 
                            ErrorMessage="Rate Must be money value" MaximumValue="99999999" 
                            MinimumValue="0" SetFocusOnError="True" Type="Currency">*</asp:RangeValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <br />
        <asp:GridView ID="GridViewRate" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Target_rate_id" 
            DataSourceID="SqlDataSourceRate">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Target_rate_id" HeaderText="Target_Rate" 
                    InsertVisible="False" ReadOnly="True" SortExpression="Target_rate_id" 
                    Visible="False" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownListCountry" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Technology" SortExpression="Technology_id">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceTech" DataTextField="wowi_tech_name" 
                            DataValueField="wowi_tech_id" SelectedValue='<%# Bind("Technology_id") %>'>
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate" SortExpression="rate">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Target_Rates] WHERE [Target_rate_id] = @Target_rate_id" 
            InsertCommand="INSERT INTO [Target_Rates] ([country_id], [Technology_id], [rate]) VALUES (@country_id, @Technology_id, @rate)" 
            SelectCommand="SELECT Target_Rates.Target_rate_id, Target_Rates.country_id, Target_Rates.Technology_id, Target_Rates.rate, country.country_name, wowi_tech.wowi_tech_name FROM Target_Rates INNER JOIN country ON Target_Rates.country_id = country.country_id INNER JOIN wowi_tech ON Target_Rates.Technology_id = wowi_tech.wowi_tech_id" 
            UpdateCommand="UPDATE [Target_Rates] SET [country_id] = @country_id, [Technology_id] = @Technology_id, [rate] = @rate WHERE [Target_rate_id] = @Target_rate_id">
            <DeleteParameters>
                <asp:Parameter Name="Target_rate_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="Technology_id" Type="Int32" />
                <asp:Parameter Name="rate" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="Technology_id" Type="Int32" />
                <asp:Parameter Name="rate" Type="Decimal" />
                <asp:Parameter Name="Target_rate_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [country_id], [country_name] FROM [country]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceTech" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [wowi_tech_id], [wowi_tech_name] FROM [wowi_tech] Where publish='Y'">
        </asp:SqlDataSource>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" />
</asp:Content>

