<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
    Access Level List&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateAccessLevel.aspx">Create</asp:HyperLink>
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"
        AutoGenerateColumns="False" DataKeyNames="id" PageSize="50"
        DataSourceID="SqlDataSource1" 
        AllowSorting="True" Width="100%">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField InsertVisible="False" SortExpression="id" Visible="False">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Eval("id","~/Admin/UpdateAccessLevel.aspx?id={0}") %>'>Edit</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
            <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                SortExpression="publish" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [access_level] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [access_level] ([name], [publish]) VALUES (@name, @publish)" 
        SelectCommand="SELECT * FROM [access_level]" 
        UpdateCommand="UPDATE [access_level] SET [name] = @name, [publish] = @publish WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>

