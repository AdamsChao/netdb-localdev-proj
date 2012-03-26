<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {

            String projIDStr= row.Cells[2].Text;
            try
            {
                int pid = int.Parse(projIDStr);
                row.Cells[2].Text = (from p in db.Project where p.Project_Id == pid select p.Project_No).First();
            }
            catch (Exception)
            {
                
                //throw;
            }
            String venderIDStr = row.Cells[3].Text;
            if (venderIDStr == "-1")
            {
                row.Cells[3].Text = "Not set yet";
            }
            else
            {
                try
                {
                    int vid = int.Parse(venderIDStr);
                    var vender = (from v in wowidb.vendors where v.id == vid select v).First();
                    row.Cells[3].Text = String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name;
                }
                catch (Exception)
                {

                    //throw;
                }
            }
            if (row.Cells[4].Text.Trim() != "&nbsp;")
            {
                row.Cells[4].Text = "$" + row.Cells[4].Text;
            }
            String quoIDStr = row.Cells[5].Text;
            try
            {
                int qid = int.Parse(quoIDStr);
                row.Cells[5].Text = (from q in db.Quotation_Version where q.Quotation_Version_Id == qid select q.Quotation_No).First();
            }
            catch (Exception)
            {

                //throw;
            }

            String Str = row.Cells[8].Text;
            try
            {
                byte status = byte.Parse(Str);
                row.Cells[8].Text = PRUtils.statusByteToString(status);
                
            }
            catch (Exception)
            {

                //throw;
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
            DataKeyNames="pr_id" DataSourceID="SqlDataSourceClient" AllowPaging="True" 
            AllowSorting="True" onprerender="GridView1_PreRender" >
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/UpdatePR.aspx?id={0}") %>' >Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/PRDetails.aspx?id={0}") %>' >Details</asp:HyperLink>
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
                <asp:BoundField DataField="create_date" HeaderText="Createtion Date" 
                    SortExpression="create_date" DataFormatString="{0:yyyy/MM/dd}" />
                     <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date" 
                    SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="pr_auth_id" HeaderText="Status" 
                    SortExpression="pr_auth_id" />
               
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            SelectCommand="SELECT P.pr_id, P.project_id, P.quotaion_id, P.vendor_id, P.total_cost,P.create_date,P.target_payment_date,R.status AS pr_auth_id FROM PR AS P , PR_authority_history AS R WHERE P.pr_auth_id = R.pr_auth_id">
        </asp:SqlDataSource>
    </p>
</asp:Content>

