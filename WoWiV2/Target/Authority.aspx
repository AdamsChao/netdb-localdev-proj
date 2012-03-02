<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p> 
        Authority List :
        <asp:Button ID="Button1" runat="server" 
            PostBackUrl="~/Target/CreateAuthority.aspx" Text="Create Authority" />
        <br />
        <asp:GridView ID="GridViewAuthority" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" 
            DataKeyNames="country_id,wowi_product_type_id" 
            DataSourceID="SqlDataSourceAuthority" Width="100%" PageSize="20">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_id") %>' 
                            Visible="False"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("country_id") %>' 
                            Visible="False"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Certification Type" 
                    SortExpression="wowi_product_type_id">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("wowi_product_type_id") %>' Visible="False"></asp:Label>
                        <asp:Label ID="Label5" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("wowi_product_type_id") %>' Visible="False"></asp:Label>
                        <asp:Label ID="Label6" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Authority Name" SortExpression="authority_name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox1" Display="Dynamic" 
                            ErrorMessage="Authority Name cant be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="authority_fullname" HeaderText="Authority_Fullname" 
                    SortExpression="authority_fullname" />
                <asp:BoundField DataField="create_user" HeaderText="create_user" 
                    SortExpression="create_user" Visible="False" />
                <asp:BoundField DataField="create_date" HeaderText="create_date" 
                    SortExpression="create_date" Visible="False" />
                <asp:BoundField DataField="modify_user" HeaderText="modify_user" 
                    SortExpression="modify_user" Visible="False" />
                <asp:BoundField DataField="modify_date" HeaderText="modify_date" 
                    SortExpression="modify_date" Visible="False" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceAuthority" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Authority] WHERE [country_id] = @country_id AND [wowi_product_type_id] = @wowi_product_type_id" 
            InsertCommand="INSERT INTO [Authority] ([country_id], [wowi_product_type_id], [authority_name],[authority_fullname], [create_user], [create_date], [modify_user], [modify_date]) VALUES (@country_id, @wowi_product_type_id, @authority_name,@authority_fullname, @create_user, @create_date, @modify_user, @modify_date)" 
            SelectCommand="SELECT Authority.country_id, Authority.wowi_product_type_id, Authority.authority_name, Authority.authority_fullname,Authority.create_user, Authority.create_date, Authority.modify_user, Authority.modify_date, country.country_name, wowi_product_type.wowi_product_type_name FROM Authority INNER JOIN country ON Authority.country_id = country.country_id INNER JOIN wowi_product_type ON Authority.wowi_product_type_id = wowi_product_type.wowi_product_type_id" 
            
            UpdateCommand="UPDATE [Authority] SET [authority_name] = @authority_name,[authority_fullname]=@authority_fullname, [create_user] = @create_user, [create_date] = @create_date, [modify_user] = @modify_user, [modify_date] = @modify_date WHERE [country_id] = @country_id AND [wowi_product_type_id] = @wowi_product_type_id">
            <DeleteParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="authority_fullname" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="authority_fullname" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

