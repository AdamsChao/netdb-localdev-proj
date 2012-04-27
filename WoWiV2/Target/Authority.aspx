<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" MaintainScrollPositionOnPostback="true" %>

<script runat="server">

  protected void GridViewAuthority_RowUpdated(object sender, GridViewUpdatedEventArgs e)
  {
    if (e.Exception != null)
    {
      Message.Text = e.Exception.Message + " , Please try again!";
      e.ExceptionHandled = true;
      e.KeepInEditMode = true;
    }
    else
    {
      Message.Text = "Authority Update Successful!";
    }
  }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p> 
        Authority List :
        <asp:LinkButton ID="LinkButton1" runat="server" 
          PostBackUrl="~/Target/CreateAuthority.aspx">Create</asp:LinkButton>
        <br />
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        <br />
        <asp:GridView ID="GridViewAuthority" runat="server" 
            AllowSorting="True" AutoGenerateColumns="False" 
            DataKeyNames="authority_id" 
            DataSourceID="SqlDataSourceAuthority" Width="100%" PageSize="20" 
          onrowupdated="GridViewAuthority_RowUpdated">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="authority_id" HeaderText="ID" 
                    SortExpression="authority_id" InsertVisible="False" ReadOnly="True" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_id" >
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("country_id") %>' Visible="false"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Certification Type" 
                  SortExpression="wowi_product_type_id">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Visible="false" 
                      Text='<%# Bind("wowi_product_type_id") %>'></asp:TextBox>
                       <asp:Label ID="Label2" runat="server" 
                      Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                      Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="authority_name" HeaderText="Authority Name" 
                    SortExpression="authority_name" />
                <asp:TemplateField HeaderText="Authority Fullname" 
                  SortExpression="authority_fullname">
                  <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server"  Width="90%"
                      Text='<%# Bind("authority_fullname") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_fullname") %>'></asp:Label>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Target_Description" HeaderText="Target Description" 
                  SortExpression="Target_Description" />
                <asp:CheckBoxField DataField="Publish" HeaderText="Publish" 
                  SortExpression="Publish" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceAuthority" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Authority] WHERE [authority_id] = @authority_id" 
            InsertCommand="INSERT INTO [Authority] ([country_id], [wowi_product_type_id], [authority_name], [authority_fullname], [Target_Description], [Publish]) VALUES (@country_id, @wowi_product_type_id, @authority_name, @authority_fullname, @Target_Description, @Publish)" 
            SelectCommand="SELECT Authority.authority_id, Authority.country_id, Authority.wowi_product_type_id, Authority.authority_name, Authority.authority_fullname, Authority.Target_Description, Authority.Publish, country.country_name, wowi_product_type.wowi_product_type_name FROM Authority INNER JOIN country ON Authority.country_id = country.country_id INNER JOIN wowi_product_type ON Authority.wowi_product_type_id = wowi_product_type.wowi_product_type_id order by  country.country_name" 
            
            
          
          
          UpdateCommand="UPDATE [Authority] SET [country_id] = @country_id, [wowi_product_type_id] = @wowi_product_type_id, [authority_name] = @authority_name, [authority_fullname] = @authority_fullname, [Target_Description] = @Target_Description, [Publish] = @Publish WHERE [authority_id] = @authority_id">
            <DeleteParameters>
                <asp:Parameter Name="authority_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="authority_fullname" Type="String" />
                <asp:Parameter Name="Target_Description" Type="String" />
                <asp:Parameter Name="Publish" Type="Boolean" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="authority_fullname" Type="String" />
                <asp:Parameter Name="Target_Description" Type="String" />
                <asp:Parameter Name="Publish" Type="Boolean" />
                <asp:Parameter Name="authority_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

