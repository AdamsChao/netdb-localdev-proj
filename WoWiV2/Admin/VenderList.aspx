<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <p>
    Vender List&nbsp;
    <%--<asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateVender.aspx">Create</asp:HyperLink>--%><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateVender.aspx" />
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate> 
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    SkinID="GridView" Width="100%"
                    DataKeyNames="id" DataSourceID="SqlDataSource1" AllowPaging="True" 
                    AllowSorting="True">
                    <Columns>
                        <asp:TemplateField InsertVisible="False" SortExpression="id" Visible="true">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Bind("id","~/Admin/UpdateVender.aspx?id={0}") %>' >Edit</asp:HyperLink>
                                &nbsp;<asp:HyperLink ID="HyperLink3" NavigateUrl='<%# Bind("id","~/Admin/VenderDetails.aspx?id={0}") %>' runat="server">Details</asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="id" HeaderText="Vender#" SortExpression="id" />
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="c_name" HeaderText="名稱" SortExpression="c_name" />
                        <asp:BoundField DataField="tel1" HeaderText="Tel" SortExpression="tel1" />
                        <asp:BoundField DataField="fax1" HeaderText="Fax" SortExpression="fax1" />
                        <asp:BoundField DataField="address" HeaderText="Address" 
                            SortExpression="address" />
                             <asp:BoundField DataField="c_address" HeaderText="地址" 
                            SortExpression="c_address" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
                    SelectCommand="SELECT [id], [name], [c_name], [tel1], [fax1], [address], [c_address] FROM [vendor]">
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p><br />
    </asp:Content>

