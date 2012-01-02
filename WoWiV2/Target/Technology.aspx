<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Technology Lists :
        <asp:Button ID="Button1" runat="server" 
            PostBackUrl="~/Target/CreateTechnology.aspx" Text="Create Technology" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
            AutoGenerateColumns="False" DataKeyNames="wowi_tech_id" 
            DataSourceID="SqlDataSourceTechnology">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="wowi_tech_id" HeaderText="wowi_tech_id" 
                    ReadOnly="True" SortExpression="wowi_tech_id" Visible="False" />
                <asp:BoundField DataField="wowi_tech_name" HeaderText="Technology" 
                    SortExpression="wowi_tech_name" />
                <asp:TemplateField HeaderText="Product Type" 
                    SortExpression="wowi_product_type_id">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownListPT" runat="server" 
                            DataSourceID="SqlDataSourcePT" DataTextField="wowi_product_type_name" 
                            DataValueField="wowi_product_type_id" 
                            SelectedValue='<%# Bind("wowi_product_type_id") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSourcePT" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                            SelectCommand="SELECT [wowi_product_type_id], [wowi_product_type_name] FROM [wowi_product_type] WHERE ([publish] = @publish)">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="Y" Name="publish" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Publish" SortExpression="publish">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownListYN" runat="server" 
                            SelectedValue='<%# Bind("publish") %>'>
                            <asp:ListItem>Y</asp:ListItem>
                            <asp:ListItem>N</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("publish") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceTechnology" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [wowi_tech] WHERE [wowi_tech_id] = @wowi_tech_id" 
            InsertCommand="INSERT INTO [wowi_tech] ([wowi_tech_id], [wowi_tech_name], [wowi_product_type_id], [publish]) VALUES (@wowi_tech_id, @wowi_tech_name, @wowi_product_type_id, @publish)" 
            SelectCommand="SELECT wowi_tech.wowi_tech_id, wowi_tech.wowi_tech_name, wowi_tech.wowi_product_type_id, wowi_tech.publish, wowi_tech.create_user, wowi_tech.create_date, wowi_tech.modify_user, wowi_tech.modify_date, wowi_product_type.wowi_product_type_name FROM wowi_tech INNER JOIN wowi_product_type ON wowi_tech.wowi_product_type_id = wowi_product_type.wowi_product_type_id" 
            
            
            UpdateCommand="UPDATE [wowi_tech] SET [wowi_tech_name] = @wowi_tech_name, [wowi_product_type_id] = @wowi_product_type_id, [publish] = @publish WHERE [wowi_tech_id] = @wowi_tech_id">
            <DeleteParameters>
                <asp:Parameter Name="wowi_tech_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="wowi_tech_id" Type="Int32" />
                <asp:Parameter Name="wowi_tech_name" Type="String" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="publish" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="wowi_tech_name" Type="String" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="publish" Type="String" />
                <asp:Parameter Name="wowi_tech_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

