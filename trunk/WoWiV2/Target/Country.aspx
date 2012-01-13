﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master"%>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Country Lists :
        <asp:Button ID="Button1" runat="server" 
            PostBackUrl="~/Target/CreateCountry.aspx" Text="Create Country" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="country_id" DataSourceID="SqlDataSourceCountry" 
            AllowSorting="True">
            <Columns>
                <asp:CommandField ShowEditButton="True">
                <ItemStyle Wrap="False" />
                </asp:CommandField>
                <asp:BoundField DataField="country_id" HeaderText="country_id" ReadOnly="True" 
                    SortExpression="country_id" Visible="False" />
                <asp:BoundField DataField="country_name" HeaderText="Country Name" 
                    SortExpression="country_name" />
                <asp:BoundField DataField="country_3_code" HeaderText="Country 3 Code" 
                    SortExpression="country_3_code" />
                <asp:BoundField DataField="country_2_code" HeaderText="Country 2 Code" 
                    SortExpression="country_2_code" />
                <asp:TemplateField HeaderText="Region" SortExpression="world_region_id">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceRegion" DataTextField="world_region_name" 
                            DataValueField="world_region_id" SelectedValue='<%# Bind("world_region_id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                            SelectCommand="SELECT * FROM [world_region]"></asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("world_region_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [country] WHERE [country_id] = @country_id" 
            InsertCommand="INSERT INTO [country] ([country_id], [country_name], [country_3_code], [country_2_code], [world_region_id]) VALUES (@country_id, @country_name, @country_3_code, @country_2_code, @world_region_id)" 
            SelectCommand="SELECT country.country_id, country.country_name, country.country_3_code, country.country_2_code, country.world_region_id, world_region.world_region_name FROM country INNER JOIN world_region ON country.world_region_id = world_region.world_region_id" 
            
            UpdateCommand="UPDATE [country] SET [country_name] = @country_name, [country_3_code] = @country_3_code, [country_2_code] = @country_2_code, [world_region_id] = @world_region_id WHERE [country_id] = @country_id">
            <DeleteParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
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
