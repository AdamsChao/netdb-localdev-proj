<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

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
            Width="125px">
            <Fields>
                <asp:BoundField DataField="country_name" HeaderText="country_name" 
                    SortExpression="country_name" />
                <asp:BoundField DataField="country_3_code" HeaderText="country_3_code" 
                    SortExpression="country_3_code" />
                <asp:BoundField DataField="country_2_code" HeaderText="country_2_code" 
                    SortExpression="country_2_code" />
                <asp:TemplateField HeaderText="world_region_id" 
                    SortExpression="Rsgion">
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
            InsertCommand="INSERT INTO [country] ( [country_name], [country_3_code], [country_2_code], [world_region_id]) VALUES ( @country_name, @country_3_code, @country_2_code, @world_region_id)" 
            SelectCommand="SELECT country.country_id, country.country_name, country.country_3_code, country.country_2_code, country.world_region_id, world_region.world_region_name FROM country INNER JOIN world_region ON country.world_region_id = world_region.world_region_id" 
            
            
            UpdateCommand="UPDATE [country] SET [country_name] = @country_name, [country_3_code] = @country_3_code, [country_2_code] = @country_2_code, [world_region_id] = @world_region_id WHERE [country_id] = @country_id">
            <DeleteParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_name" Type="String" />
                <asp:Parameter Name="country_3_code" Type="String" />
                <asp:Parameter Name="country_2_code" Type="String" />
                <asp:Parameter Name="world_region_id" Type="Byte" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="country_name" Type="String" />
                <asp:Parameter Name="country_3_code" Type="String" />
                <asp:Parameter Name="country_2_code" Type="String" />
                <asp:Parameter Name="world_region_id" Type="Byte" />
                <asp:Parameter Name="country_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

