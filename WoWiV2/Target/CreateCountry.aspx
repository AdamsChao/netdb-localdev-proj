<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            Message.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
        else
        {
            Message.Text = "Country Creation Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Country Creation :
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/Country.aspx">Country Lists</asp:HyperLink>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
            DataSourceID="SqlDataSourceCountry" DefaultMode="Insert" Height="50px" 
            oniteminserted="DetailsView1_ItemInserted">
            <Fields>
                <asp:TemplateField HeaderText="country_name" SortExpression="country_name">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("country_name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("country_name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox5" Display="Dynamic" 
                            ErrorMessage="country name cant be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="country_3_code" 
                    SortExpression="country_3_code">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("country_3_code") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("country_3_code") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" MaxLength="3" 
                              Text='<%# Bind("country_3_code") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="country_2_code" SortExpression="country_2_code">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("country_2_code") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("country_2_code") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="2" 
                            Text='<%# Bind("country_2_code") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="country_telephone_code" 
                    SortExpression="country_telephone_code">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" 
                            Text='<%# Bind("country_telephone_code") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" 
                            Text='<%# Bind("country_telephone_code") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" 
                            Text='<%# Bind("country_telephone_code") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="country_currency_type" 
                    SortExpression="country_currency_type">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" 
                            Text='<%# Bind("country_currency_type") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" 
                            Text='<%# Bind("country_currency_type") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" 
                            Text='<%# Bind("country_currency_type") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="World Region" SortExpression="Rsgion">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("world_region_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("world_region_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceRegion" DataTextField="world_region_name" 
                            DataValueField="world_region_id" SelectedValue='<%# Bind("world_region_id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                            SelectCommand="SELECT * FROM [world_region]"></asp:SqlDataSource>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [country] WHERE [country_id] = @country_id" 
            InsertCommand="INSERT INTO [country] ( [country_name], [country_3_code], [country_2_code], [world_region_id],[country_telephone_code] , [country_currency_type]) VALUES ( @country_name, @country_3_code, @country_2_code, @world_region_id,@country_telephone_code , @country_currency_type)" 
            SelectCommand="SELECT country.country_id, country.country_name, country.country_3_code, country.country_2_code, country.world_region_id, world_region.world_region_name,[country_telephone_code] , [country_currency_type] FROM country INNER JOIN world_region ON country.world_region_id = world_region.world_region_id" 
            
            
            
            UpdateCommand="UPDATE [country] SET [country_name] = @country_name, [country_3_code] = @country_3_code, [country_2_code] = @country_2_code, [world_region_id] = @world_region_id WHERE [country_id] = @country_id">
            <DeleteParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_name" Type="String" />
                <asp:Parameter Name="country_3_code" Type="String" />
                <asp:Parameter Name="country_2_code" Type="String" />
                <asp:Parameter Name="world_region_id" Type="Byte" />
                <asp:Parameter Name="country_telephone_code" />
                <asp:Parameter Name="country_currency_type" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="country_name" Type="String" />
                <asp:Parameter Name="country_3_code" Type="String" />
                <asp:Parameter Name="country_2_code" Type="String" />
                <asp:Parameter Name="world_region_id" Type="Byte" />
                <asp:Parameter Name="country_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

