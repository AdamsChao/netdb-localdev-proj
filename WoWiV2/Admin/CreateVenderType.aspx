<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        VenderType Creation&nbsp;
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Admin/VenderTypeList.aspx">VenderType List</asp:HyperLink>
        <asp:DetailsView ID="DetailsView1" runat="server" SkinID="DetailsView"
            AutoGenerateRows="False" DataKeyNames="id" 
            DataSourceID="SqlDataSource1" Height="50px" 
            Width="451px" DefaultMode="Insert" 
           >
            <Fields>
                <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" 
                    InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
                    SortExpression="publish" />
                <asp:BoundField DataField="create_date" HeaderText="create_date" 
                    SortExpression="create_date" Visible="False" />
                <asp:BoundField DataField="create_user" HeaderText="create_user" 
                    SortExpression="create_user" Visible="False" />
                <asp:BoundField DataField="modify_date" HeaderText="modify_date" 
                    SortExpression="modify_date" Visible="False" />
                <asp:BoundField DataField="modify_user" HeaderText="modify_user" 
                    SortExpression="modify_user" Visible="False" />
                <asp:CommandField ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [vendor_type]" 
            DeleteCommand="DELETE FROM [vendor_type] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [vendor_type] ([name], [publish], [create_date], [create_user], [modify_date], [modify_user]) VALUES (@name, @publish, @create_date, @create_user, @modify_date, @modify_user)" 
            UpdateCommand="UPDATE [vendor_type] SET [name] = @name, [publish] = @publish, [create_date] = @create_date, [create_user] = @create_user, [modify_date] = @modify_date, [modify_user] = @modify_user WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="publish" Type="Boolean" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="publish" Type="Boolean" />
                <asp:Parameter Name="create_date" Type="DateTime" />
                <asp:Parameter Name="create_user" Type="String" />
                <asp:Parameter Name="modify_date" Type="DateTime" />
                <asp:Parameter Name="modify_user" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

