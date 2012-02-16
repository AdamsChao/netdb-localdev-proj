<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void ListView1_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            Message.Text = e.Exception.Message + " , Please try again!";
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else
        {
            Message.Text = "ProductType Update Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Certification Type Lists</p>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="wowi_product_type_id" 
            DataSourceID="SqlDataSourceProductType" InsertItemPosition="LastItem" 
            onitemupdated="ListView1_ItemUpdated">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <%--<asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Delete" />--%>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_idLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_nameLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="publishLabel" runat="server" Text='<%# Eval("publish") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Cancel" />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_idLabel1" runat="server" 
                            Text='<%# Eval("wowi_product_type_id") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="wowi_product_type_nameTextBox" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>' />
                    </td>
                    <td>                       
                           <asp:DropDownList ID="DropDownListYN" runat="server" 
                            SelectedValue='<%# Bind("publish") %>'>
                            <asp:ListItem>Y</asp:ListItem>
                            <asp:ListItem>N</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>
                            No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                            Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="Clear" />
                    </td>
                    <td>
                       <%-- <asp:TextBox ID="wowi_product_type_idTextBox" runat="server" 
                            Text='<%# Bind("wowi_product_type_id") %>' />--%>
                    </td>
                    <td>
                        <asp:TextBox ID="wowi_product_type_nameTextBox" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>' />
                    </td>
                    <td>
                        <asp:DropDownList ID="DropDownListYN" runat="server" 
                            SelectedValue='<%# Bind("publish") %>'>
                            <asp:ListItem>Y</asp:ListItem>
                            <asp:ListItem Value="N"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <%--<asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Delete" />--%>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_idLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_nameLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="publishLabel" runat="server" Text='<%# Eval("publish") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                <tr runat="server" style="">
                                    <th runat="server">
                                    </th>
                                    <th runat="server">
                                        wowi_product_type_id</th>
                                    <th runat="server">
                                        wowi_product_type_name</th>
                                    <th runat="server">
                                        publish</th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="">
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                            Text="Delete" />
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_idLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="wowi_product_type_nameLabel" runat="server" 
                            Text='<%# Eval("wowi_product_type_name") %>' />
                    </td>
                    <td>
                        <asp:Label ID="publishLabel" runat="server" Text='<%# Eval("publish") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        
        <asp:SqlDataSource ID="SqlDataSourceProductType" runat="server" 
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
                <asp:Parameter Name="publish" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="wowi_product_type_name" Type="String" />
                <asp:Parameter Name="publish" Type="String" />
                <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

