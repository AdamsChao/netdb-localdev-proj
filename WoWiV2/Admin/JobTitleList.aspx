<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
    JobTitle List&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateJobTitle.aspx">Create</asp:HyperLink>
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"
        AutoGenerateColumns="False" DataKeyNames="jobtitle_id" PageSize="50"
        DataSourceID="SqlDataSource1" 
        AllowSorting="True" Width="100%">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField InsertVisible="False" SortExpression="jobtitle_id" Visible="False">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("jobtitle_id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Eval("jobtitle_id","~/Admin/UpdateJobTitle.aspx?id={0}") %>'>Edit</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="jobtitle_name" HeaderText="Name" SortExpression="jobtitle_name" />
            <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                SortExpression="publish" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        
        DeleteCommand="DELETE FROM [employee_jobtitle] WHERE [jobtitle_id] = @jobtitle_id" 
        InsertCommand="INSERT INTO [employee_jobtitle] ([jobtitle_name], [publish]) VALUES (@jobtitle_name, @publish)" 
       SelectCommand="SELECT * FROM [employee_jobtitle]" 
        UpdateCommand="UPDATE [employee_jobtitle] SET [jobtitle_name] = @jobtitle_name, [publish] = @publish WHERE [jobtitle_id] = @jobtitle_id">
        <DeleteParameters>
            <asp:Parameter Name="jobtitle_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="jobtitle_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="jobtitle_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
            <asp:Parameter Name="jobtitle_id" Type="Int32" />
        </UpdateParameters>   
    </asp:SqlDataSource>
     </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>

