﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Contact Title List&nbsp;<asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateContactRole.aspx" />
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"  Width="100%"
        AutoGenerateColumns="False" DataKeyNames="contact_id" PageSize="50"
        DataSourceID="SqlDataSource1" 
        AllowSorting="True" >
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:TemplateField InsertVisible="False" SortExpression="contact_id" Visible="False">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("contact_id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Eval("contact_id","~/Admin/UpdateContactRole.aspx?id={0}") %>'>Edit</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="contact_name" HeaderText="Name" SortExpression="contact_name" />
            <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                SortExpression="publish" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [contact_role] WHERE [contact_id] = @contact_id" 
        InsertCommand="INSERT INTO [contact_role] ([contact_name], [publish]) VALUES (@contact_name, @publish)" 
        SelectCommand="SELECT [contact_id], [contact_name], [publish] FROM [contact_role]" 
        
                    UpdateCommand="UPDATE [contact_role] SET [contact_name] = @contact_name, [publish] = @publish WHERE [contact_id] = @contact_id">
        <DeleteParameters>
            <asp:Parameter Name="contact_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="contact_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="contact_name" Type="String" />
            <asp:Parameter Name="publish" Type="Boolean" />
            <asp:Parameter Name="contact_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource> </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>

