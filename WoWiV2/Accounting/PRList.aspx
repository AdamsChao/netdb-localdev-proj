<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        PR Lists : <asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Accounting/CreatePR.aspx" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            SkinID="GridView" Width="100%"
            DataKeyNames="pr_id" DataSourceID="SqlDataSourceClient" AllowPaging="True" 
            AllowSorting="True" >
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/UpdatePR.aspx?id={0}") %>' Enabled="false">Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/PRDetails.aspx?id={0}") %>' Enabled="false">Details</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="pr_id" HeaderText="PR No" SortExpression="pr_id" 
                    ReadOnly="True" />
                <asp:BoundField DataField="project_id" HeaderText="Project Id" 
                    SortExpression="project_id" ReadOnly="True" />
                <asp:BoundField DataField="vendor_id" HeaderText="Vendor Id" 
                    SortExpression="vendor_id" />
                <asp:BoundField DataField="total_cost" HeaderText="Total Cost" 
                    SortExpression="total_cost" />
                <asp:BoundField DataField="quotaion_id" HeaderText="Quotation Id" 
                    SortExpression="quotaion_id" />
               
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            SelectCommand="SELECT [pr_id], [project_id], [quotaion_id], [vendor_id], [total_cost] FROM [PR]">
        </asp:SqlDataSource>
    </p>
</asp:Content>

