<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                int id = int.Parse(e.Row.Cells[3].Text);
                if (id == -1)
                {
                    e.Row.Cells[3].Text = "None";
                }
                else
                {
                    var data = db.departments.Where(c => c.id == id).First();
                    e.Row.Cells[3].Text = data.name;
                }
            }
            catch (Exception)
            {
                
                
            }

            try
            {
                int vid = int.Parse(e.Row.Cells[4].Text);
                if (vid == -1)
                {
                    e.Row.Cells[4].Text = "";
                }
                else
                {
                    var data = db.vendors.Where(c => c.id == vid).First();
                    e.Row.Cells[4].Text = data.name;
                }
            }
            catch (Exception)
            {
                
                
            }


            
        }

    }
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
            DataKeyNames="pr_no" DataSourceID="SqlDataSourceClient" AllowPaging="True" 
            AllowSorting="True" onrowdatabound="GridView1_RowDataBound">
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("pr_no","~/Accounting/UpdatePR.aspx?id={0}") %>'>Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("pr_no","~/Accounting/PRDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="pr_no" HeaderText="PR No" SortExpression="pr_no" 
                    ReadOnly="True" />
                <asp:BoundField DataField="status" HeaderText="Status" 
                    SortExpression="status" />
                <asp:BoundField DataField="expense_department" HeaderText="Dept." 
                    SortExpression="expense_department" ReadOnly="True" />
                <asp:BoundField DataField="vendor_id" HeaderText="Vendor Name" 
                    SortExpression="vendor_id" />
                <asp:BoundField DataField="total_cost" HeaderText="Total Cost" 
                    SortExpression="total_cost" />
                <asp:BoundField DataField="quotation_no" HeaderText="Quotation No" 
                    SortExpression="quotation_no" />
                <asp:BoundField DataField="requisitioner" HeaderText="Requisitioner" 
                    SortExpression="requisitioner" />
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [PR] WHERE [pr_no] = @pr_no" 
            InsertCommand="INSERT INTO [PR] ([pr_no], [status], [vendor_id], [total_cost], [quotation_no], [requisitioner]) VALUES (@pr_no, @status, @vendor_id, @total_cost, @quotation_no, @requisitioner)" 
            SelectCommand="SELECT [pr_no], [status], [expense_department], [vendor_id], [total_cost], [quotation_no], [requisitioner] FROM [PR]" 
            
            UpdateCommand="UPDATE [PR] SET [status] = @status, [profit_center] = @profit_center, [vendor_id] = @vendor_id, [total_cost] = @total_cost, [quotation_no] = @quotation_no, [requisitioner] = @requisitioner WHERE [pr_no] = @pr_no">
            <DeleteParameters>
                <asp:Parameter Name="pr_no" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="pr_no" Type="Int32" />
                <asp:Parameter Name="status" Type="Byte" />
                <asp:Parameter Name="vendor_id" Type="Int32" />
                <asp:Parameter Name="total_cost" Type="Decimal" />
                <asp:Parameter Name="quotation_no" Type="String" />
                <asp:Parameter Name="requisitioner" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="status" Type="Byte" />
                <asp:Parameter Name="profit_center" Type="Byte" />
                <asp:Parameter Name="vendor_id" Type="Int32" />
                <asp:Parameter Name="total_cost" Type="Decimal" />
                <asp:Parameter Name="quotation_no" Type="String" />
                <asp:Parameter Name="requisitioner" Type="String" />
                <asp:Parameter Name="pr_no" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

