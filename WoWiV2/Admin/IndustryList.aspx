<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
    Industry List&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateIndustry.aspx">Create</asp:HyperLink>
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"
        AutoGenerateColumns="False" DataKeyNames="id" 
        DataSourceID="SqlDataSource1" 
        AllowSorting="True"  Width="100%">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField InsertVisible="True" SortExpression="name" Visible="True" 
                HeaderText="Name">
                <EditItemTemplate>
                    
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("id") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                SortExpression="publish" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [clientapplicant_industry] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [clientapplicant_industry] ([name], [publish]) VALUES (@name, @publish)" 
        SelectCommand="SELECT * FROM [clientapplicant_industry]" 
        UpdateCommand="UPDATE [clientapplicant_industry] SET [name] = @name, [publish] = @publish WHERE [id] = @id">
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

