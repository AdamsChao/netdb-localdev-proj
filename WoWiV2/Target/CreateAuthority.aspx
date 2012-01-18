<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void DetailsViewAuthority_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if (e.Exception!=null)
        {
            Message.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
        else
        {
            Message.Text = "Authority Creation Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Authority Creation :
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/Authority.aspx">Authority List</asp:HyperLink>
        <br />
        <asp:DetailsView ID="DetailsViewAuthority" runat="server" 
            AutoGenerateRows="False" DataSourceID="SqlDataSourceAuthority" 
            DefaultMode="Insert" Height="50px" Width="125px" 
            oniteminserted="DetailsViewAuthority_ItemInserted">
            <Fields>
                <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_id") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("country_id") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Product Type" 
                    SortExpression="wowi_product_type_id">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("wowi_product_type_id") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Eval("wowi_product_type_id") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            DataSourceID="SqlDataSourceProduct_type" DataTextField="wowi_product_type_name" 
                            DataValueField="wowi_product_type_id" 
                            SelectedValue='<%# Bind("wowi_product_type_id") %>'>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Authority" SortExpression="authority_name">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Width="90%" Text='<%# Bind("authority_name") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Authority_Fullname" 
                    SortExpression="authority_fullname">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("authority_fullname") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("authority_fullname") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Width="90%"
                            Text='<%# Bind("authority_fullname") %>'></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSourceAuthority" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Authority] WHERE [country_id] = @country_id AND [wowi_product_type_id] = @wowi_product_type_id" 
            InsertCommand="INSERT INTO [Authority] ([country_id], [wowi_product_type_id], [authority_name],[authority_fullname], [create_user], [create_date], [modify_user], [modify_date]) VALUES (@country_id, @wowi_product_type_id, @authority_name,@authority_fullname, @create_user, @create_date, @modify_user, @modify_date)" 
            SelectCommand="SELECT * FROM [Authority]" 
            
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
        <asp:SqlDataSource ID="SqlDataSourceProduct_type" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [wowi_product_type_id], [wowi_product_type_name] FROM [wowi_product_type] Where publish = 'Y'">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [country_id], [country_name] FROM [country]">
        </asp:SqlDataSource>
    </p>
</asp:Content>

