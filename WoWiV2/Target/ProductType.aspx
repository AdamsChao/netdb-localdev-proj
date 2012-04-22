<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
      if (e.Exception != null)
      {
        Message.Text = e.Exception.Message + " , Please try again!";
        e.ExceptionHandled = true;
        e.KeepInEditMode = true;
      }
      else
      {
        Message.Text = "Certification Type Update Successful!";
      }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Certification Type Lists :
        <asp:HyperLink ID="HyperLink1" runat="server" 
          NavigateUrl="~/Target/CreateProductType.aspx">Create</asp:HyperLink>
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
          DataKeyNames="wowi_product_type_id" DataSourceID="SqlDataSource1" 
          onrowupdated="GridView1_RowUpdated" Width="100%">
          <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="wowi_product_type_id" HeaderText="ID" 
              InsertVisible="False" ReadOnly="True" SortExpression="wowi_product_type_id" />
            <asp:BoundField DataField="wowi_product_type_name" 
              HeaderText="Certification Type Name" SortExpression="wowi_product_type_name" />
            <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
              SortExpression="publish" />
          </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
          ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
          DeleteCommand="DELETE FROM [wowi_product_type] WHERE [wowi_product_type_id] = @wowi_product_type_id" 
          InsertCommand="INSERT INTO [wowi_product_type] ([wowi_product_type_name], [publish]) VALUES (@wowi_product_type_name, @publish)" 
          SelectCommand="SELECT [wowi_product_type_id], [wowi_product_type_name], [publish] FROM [wowi_product_type]" 
          UpdateCommand="UPDATE [wowi_product_type] SET [wowi_product_type_name] = @wowi_product_type_name, [publish] = @publish WHERE [wowi_product_type_id] = @wowi_product_type_id">
          <DeleteParameters>
            <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
          </DeleteParameters>
          <InsertParameters>
            <asp:Parameter Name="wowi_product_type_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
          </InsertParameters>
          <UpdateParameters>
            <asp:Parameter Name="wowi_product_type_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
            <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
          </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

