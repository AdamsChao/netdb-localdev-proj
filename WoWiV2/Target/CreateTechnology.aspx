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
            Message.Text = "Technology Creation Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Technology Creation :
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/Technology.aspx">Technology Lists</asp:HyperLink>
        <br />
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
            DataSourceID="SqlDataSourceTechnology" DefaultMode="Insert" 
            oniteminserted="DetailsView1_ItemInserted" 
          DataKeyNames="wowi_tech_id">
            <Fields>
              <asp:BoundField DataField="wowi_tech_id" HeaderText="ID" InsertVisible="False" 
                ReadOnly="True" SortExpression="wowi_tech_id" />
              <asp:TemplateField HeaderText="Technology Name" SortExpression="wowi_tech_name">
                <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="TextBox1" Display="Dynamic" 
                    ErrorMessage="Technology Name cant be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Certification Type" 
                SortExpression="wowi_product_type_id">
                <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" 
                    Text='<%# Bind("wowi_product_type_id") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                  <asp:DropDownList ID="DropDownList1" runat="server" 
                  DataSourceID="SqlDataSource1" DataTextField="wowi_product_type_name" 
                  DataValueField="wowi_product_type_id" 
                  SelectedValue='<%# Bind("wowi_product_type_id") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                  SelectCommand="SELECT [wowi_product_type_id], [wowi_product_type_name] FROM [wowi_product_type] Where Publish=1">
                </asp:SqlDataSource>
                </InsertItemTemplate>
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" 
                    Text='<%# Bind("wowi_product_type_id") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                SortExpression="publish" />
              <asp:BoundField DataField="create_user" HeaderText="create_user" 
                SortExpression="create_user" Visible="False" />
              <asp:BoundField DataField="create_date" HeaderText="create_date" 
                SortExpression="create_date" Visible="False" />
              <asp:BoundField DataField="modify_user" HeaderText="modify_user" 
                SortExpression="modify_user" Visible="False" />
              <asp:BoundField DataField="modify_date" HeaderText="modify_date" 
                SortExpression="modify_date" Visible="False" />
              <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceTechnology" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [wowi_tech] WHERE [wowi_tech_id] = @wowi_tech_id" 
            InsertCommand="INSERT INTO [wowi_tech] ([wowi_tech_name], [wowi_product_type_id], [publish], [create_user], [create_date], [modify_user], [modify_date]) VALUES (@wowi_tech_name, @wowi_product_type_id, @publish, @create_user, @create_date, @modify_user, @modify_date)" 
            SelectCommand="SELECT * FROM [wowi_tech]" 
            
            
            
          UpdateCommand="UPDATE [wowi_tech] SET [wowi_tech_name] = @wowi_tech_name, [wowi_product_type_id] = @wowi_product_type_id, [publish] = @publish, [create_user] = @create_user, [create_date] = @create_date, [modify_user] = @modify_user, [modify_date] = @modify_date WHERE [wowi_tech_id] = @wowi_tech_id">
            <DeleteParameters>
                <asp:Parameter Name="wowi_tech_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>                
                <asp:Parameter Name="wowi_tech_name" Type="String" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="publish" Type="Boolean" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="wowi_tech_name" Type="String" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="publish" Type="Boolean" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
                <asp:Parameter Name="wowi_tech_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

