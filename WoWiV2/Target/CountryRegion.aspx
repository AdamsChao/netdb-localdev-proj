<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void ListView1_ItemInserted(object sender, ListViewInsertedEventArgs e)
    {
        if (e.Exception != null)
        {
            Message.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
        else
        {
            Message.Text = "Country Region Creation Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Country Region List
    </p>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="world_region_id" 
            DataSourceID="SqlDataSourceRegion" InsertItemPosition="LastItem" 
            oniteminserted="ListView1_ItemInserted">
            <AlternatingItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="編輯" />
                    </td>
                    <td>
                        <asp:Label ID="world_region_idLabel" runat="server" 
                            Text='<%# Eval("world_region_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="world_region_nameLabel" runat="server" 
                            Text='<%# Eval("world_region_name") %>' />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="更新" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="取消" />
                    </td>
                    <td>
                        <asp:Label ID="world_region_idLabel1" runat="server" 
                            Text='<%# Eval("world_region_id") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="world_region_nameTextBox" runat="server" 
                            Text='<%# Bind("world_region_name") %>' />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>
                            未傳回資料。</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                            Text="插入" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="清除" />
                    </td>
                    <td>
                        
                    </td>
                    <td>
                        <asp:TextBox ID="world_region_nameTextBox" runat="server" 
                            Text='<%# Bind("world_region_name") %>' />
                    </td>
                </tr>
            </InsertItemTemplate>
            <ItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="編輯" />
                    </td>
                    <td>
                        <asp:Label ID="world_region_idLabel" runat="server" 
                            Text='<%# Eval("world_region_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="world_region_nameLabel" runat="server" 
                            Text='<%# Eval("world_region_name") %>' />
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
                                        world_region_id</th>
                                    <th runat="server">
                                        world_region_name</th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="">
                            <asp:DataPager ID="DataPager1" runat="server">
                                <Fields>
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>
                            </asp:DataPager>
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" 
                            Text="編輯" />
                    </td>
                    <td>
                        <asp:Label ID="world_region_idLabel" runat="server" 
                            Text='<%# Eval("world_region_id") %>' />
                    </td>
                    <td>
                        <asp:Label ID="world_region_nameLabel" runat="server" 
                            Text='<%# Eval("world_region_name") %>' />
                    </td>
                </tr>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSourceRegion" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [world_region] WHERE [world_region_id] = @world_region_id" 
            InsertCommand="INSERT INTO [world_region] ([world_region_name]) VALUES (@world_region_name)" 
            SelectCommand="SELECT [world_region_id], [world_region_name] FROM [world_region]" 
            
            UpdateCommand="UPDATE [world_region] SET [world_region_name] = @world_region_name WHERE [world_region_id] = @world_region_id">
            <DeleteParameters>
                <asp:Parameter Name="world_region_id" Type="Byte" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="world_region_name" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="world_region_name" Type="String" />
                <asp:Parameter Name="world_region_id" Type="Byte" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

