<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        var list = from p in wowidb.PRs from au in wowidb.PR_authority_history where p.pr_auth_id == au.pr_auth_id & au.status == (byte)PRStatus.Done select p;
        GridView1.DataSource = list;
        GridView1.DataBind();
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {

            String projIDStr = row.Cells[2].Text;
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
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    PR Payment Lists 
    <br />
    PayDate From :
    <uc1:DateChooser ID="dcFrom" runat="server" />
&nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcTo" runat="server" />
&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
    <br>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            SkinID="GridView" Width="100%"
            DataKeyNames="pr_id"  
            AllowSorting="True" onprerender="GridView1_PreRender" >
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/PRPayment.aspx?id={0}&type=payment") %>' >Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("pr_id","~/Accounting/PRPaymentDetails.aspx?id={0}") %>' >Details</asp:HyperLink>
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
       <%-- <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            SelectCommand="SELECT [pr_id], [project_id], [quotaion_id], [vendor_id], [total_cost] FROM [PR]">
        </asp:SqlDataSource>--%>
    </p>
</asp:Content>

