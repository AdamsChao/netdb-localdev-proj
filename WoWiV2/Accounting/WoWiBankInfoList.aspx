<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        WoWi Bank Info List&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Accounting/CreateWoWiBankInfo.aspx">Create</asp:HyperLink>
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"
        AutoGenerateColumns="False" DataKeyNames="id" 
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
                        NavigateUrl='<%# Eval("id","~/Accounting/UpdateWowiBankInfo.aspx?id={0}") %>'>Edit</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Display Name" SortExpression="display_name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("display_name") %>' 
                        Width="320px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("display_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Info" SortExpression="info">
                <EditItemTemplate>
                     <asp:TextBox ID="tbbankAccount" runat="server" Font-Size="12px"
                        Text='<%# Bind("info") %>' TextMode="MultiLine"  Height="180" Width="530px" ></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="tbbankAccount" runat="server" Enabled="False" Font-Size="12px"
                        Text='<%# Bind("info") %>' TextMode="MultiLine"  Height="180" 
                        Width="530px" ></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [wowi_bankinfo] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [wowi_bankinfo] ([name], [publish]) VALUES (@name, @publish)" 
        SelectCommand="SELECT * FROM [wowi_bankinfo]" 
        UpdateCommand="UPDATE [wowi_bankinfo] SET [display_name] = @display_name, [info] = @info WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="display_name" Type="String" />
            <asp:Parameter Name="info" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>

