<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    protected void GridViewRegion_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.Exception != null)
      {
        Message.Text = e.Exception.Message;
        e.KeepInEditMode = true;
        e.ExceptionHandled = true;
      }
      else
      {
        Message.Text = "Country Region Update Successful!";
      }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Country Region List
        :
        <asp:LinkButton ID="LinkButton1" runat="server" 
          PostBackUrl="~/Target/CreateCountryRegion.aspx">Create</asp:LinkButton>
        <br />
        <asp:GridView ID="GridViewRegion" runat="server" AllowSorting="True" 
          AutoGenerateColumns="False" DataKeyNames="world_region_id" 
          DataSourceID="SqlDataSourceRegion" Width="100%" 
          onrowupdated="GridViewRegion_RowUpdated">
          <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="world_region_id" HeaderText="ID" ReadOnly="True" 
              SortExpression="world_region_id" />
            <asp:TemplateField HeaderText="World Region Name" 
              SortExpression="world_region_name">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" 
                  Text='<%# Bind("world_region_name") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("world_region_name") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="create_user" HeaderText="create_user" 
              SortExpression="create_user" Visible="False" />
            <asp:BoundField DataField="create_date" HeaderText="create_date" 
              SortExpression="create_date" Visible="False" />
            <asp:BoundField DataField="modify_user" HeaderText="modify_user" 
              SortExpression="modify_user" Visible="False" />
            <asp:BoundField DataField="modify_date" HeaderText="modify_date" 
              SortExpression="modify_date" Visible="False" />
            <asp:TemplateField HeaderText="Access Level" SortExpression="access_level_id">
              <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                  DataSourceID="SqlDataSourceAL" DataTextField="name" DataValueField="id" 
                  SelectedValue='<%# Bind("access_level_id") %>' >
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceAL" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                  SelectCommand="SELECT [id], [name] FROM [access_level] Where Publish=1">
                </asp:SqlDataSource>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("access_level_name") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" 
          ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
          DeleteCommand="DELETE FROM [world_region] WHERE [world_region_id] = @world_region_id" 
          InsertCommand="INSERT INTO [world_region] ([world_region_name], [create_user], [create_date], [modify_user], [modify_date], [access_level_id]) VALUES (@world_region_name, @create_user, @create_date, @modify_user, @modify_date, @access_level_id)" 
          SelectCommand="SELECT world_region.world_region_id, world_region.world_region_name, world_region.create_user, world_region.create_date, world_region.modify_user, world_region.modify_date, world_region.access_level_id, access_level.name AS 'access_level_name' FROM world_region LEFT OUTER JOIN access_level ON world_region.access_level_id = access_level.id" 
          UpdateCommand="UPDATE [world_region] SET [world_region_name] = @world_region_name, [create_user] = @create_user, [create_date] = @create_date, [modify_user] = @modify_user, [modify_date] = @modify_date, [access_level_id] = @access_level_id WHERE [world_region_id] = @world_region_id">
          <DeleteParameters>
            <asp:Parameter Name="world_region_id" Type="Byte" />
          </DeleteParameters>
          <InsertParameters>
            <asp:Parameter Name="world_region_name" Type="String" />
            <asp:Parameter Name="create_user" Type="String" />
            <asp:Parameter Name="create_date" Type="DateTime" />
            <asp:Parameter Name="modify_user" Type="String" />
            <asp:Parameter Name="modify_date" Type="DateTime" />
            <asp:Parameter Name="access_level_id" Type="Int32" />
          </InsertParameters>
          <UpdateParameters>
            <asp:Parameter Name="world_region_name" Type="String" />
            <asp:Parameter Name="create_user" Type="String" />
            <asp:Parameter Name="create_date" Type="DateTime" />
            <asp:Parameter Name="modify_user" Type="String" />
            <asp:Parameter Name="modify_date" Type="DateTime" />
            <asp:Parameter Name="access_level_id" Type="Int32" />
            <asp:Parameter Name="world_region_id" Type="Byte" />
          </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

