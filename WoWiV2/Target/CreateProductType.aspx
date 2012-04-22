<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

  protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
  {
    if (e.Exception != null)
    {
      Message.Text = e.Exception.Message + " , Please try again!";
      e.ExceptionHandled = true;
    }
    else
    {
      Message.Text = "Certification Type Insert  Successful!";
    }
  }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
Certification Type Creation : 
  <asp:HyperLink ID="HyperLink1" runat="server" 
    NavigateUrl="~/Target/ProductType.aspx">Certification Type Lists</asp:HyperLink>
  <br />
  <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
    DataKeyNames="wowi_product_type_id" DataSourceID="SqlDataSource1" 
    DefaultMode="Insert" oniteminserted="DetailsView1_ItemInserted">
    <Fields>
      <asp:BoundField DataField="wowi_product_type_id" HeaderText="ID" 
        InsertVisible="False" ReadOnly="True" SortExpression="wowi_product_type_id" />
      <asp:BoundField DataField="wowi_product_type_name" 
        HeaderText="Certification Type Name" SortExpression="wowi_product_type_name" />
      <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
        SortExpression="publish" />
      <asp:CommandField ShowInsertButton="True" />
    </Fields>
  </asp:DetailsView>
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
    </asp:Content>

