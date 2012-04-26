<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void DetailsViewAuthority_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
    {
        if (e.Exception!=null)
        {
            DropDownList country = (DropDownList)DetailsViewAuthority.FindControl("DropDownList1");
            DropDownList product_type = (DropDownList)DetailsViewAuthority.FindControl("DropDownList2");
            Message.Text = "The Authority of " + product_type.SelectedItem.Text + " in " + country.SelectedItem.Text + " already Exists! Please try again.";
            
            //Message.Text = e.Exception.Message;
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
        <asp:DetailsView ID="DetailsViewAuthority" runat="server" AutoGenerateRows="False" 
          DataKeyNames="authority_id" DataSourceID="SqlDataSourceAuthrity" 
          DefaultMode="Insert" Width="100%" 
          oniteminserted="DetailsViewAuthority_ItemInserted">
          <Fields>
            <asp:BoundField DataField="authority_id" HeaderText="ID" InsertVisible="False" 
              ReadOnly="True" SortExpression="authority_id" />
            <asp:TemplateField HeaderText="Country" SortExpression="country_id">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("country_id") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                 <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                        </asp:DropDownList>
              </InsertItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_id") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Certification Type" 
              SortExpression="wowi_product_type_id">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" 
                  Text='<%# Bind("wowi_product_type_id") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
               <asp:DropDownList ID="DropDownList2" runat="server" 
                            DataSourceID="SqlDataSourceProduct_type" DataTextField="wowi_product_type_name" 
                            DataValueField="wowi_product_type_id" 
                            SelectedValue='<%# Bind("wowi_product_type_id") %>'>
                        </asp:DropDownList>
              </InsertItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label2" runat="server" 
                  Text='<%# Bind("wowi_product_type_id") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Authority Name" SortExpression="authority_name">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                <asp:TextBox ID="TextBox_authority_name" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="TextBox_authority_name" Display="Dynamic" 
                            ErrorMessage="Authority Name cant be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
              </InsertItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Authority Fullname" 
              SortExpression="authority_fullname">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" 
                  Text='<%# Bind("authority_fullname") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Width="90%" 
                  Text='<%# Bind("authority_fullname") %>'></asp:TextBox>
              </InsertItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_fullname") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Target Description" 
              SortExpression="Target_Description">
              <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" 
                  Text='<%# Bind("Target_Description") %>'></asp:TextBox>
              </EditItemTemplate>
              <InsertItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server"  Width="90%" 
                  Text='<%# Bind("Target_Description") %>'></asp:TextBox>

              </InsertItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Target_Description") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Publish" SortExpression="Publish">
              <EditItemTemplate>
                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Publish") %>' />
              </EditItemTemplate>
              <InsertItemTemplate>
                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Publish") %>' />
              </InsertItemTemplate>
              <ItemTemplate>
                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Publish") %>' 
                  Enabled="false" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowInsertButton="True" />
          </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSourceAuthrity" runat="server" 
          ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
          DeleteCommand="DELETE FROM [Authority] WHERE [authority_id] = @authority_id" 
          InsertCommand="INSERT INTO [Authority] ([country_id], [wowi_product_type_id], [authority_name], [authority_fullname], [Target_Description], [Publish]) VALUES (@country_id, @wowi_product_type_id, @authority_name, @authority_fullname, @Target_Description, @Publish)" 
          SelectCommand="SELECT [authority_id], [country_id], [wowi_product_type_id], [authority_name], [authority_fullname], [Target_Description], [Publish] FROM [Authority]" 
          
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
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSourceProduct_type" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
          SelectCommand="SELECT [wowi_product_type_id], [wowi_product_type_name] FROM [wowi_product_type] Where publish = 1">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
          SelectCommand="SELECT [country_id], [country_name] FROM [country] Order by country.country_id">
        </asp:SqlDataSource>
    </p>
</asp:Content>

