<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        //var list = from p in wowidb.PRs from au in wowidb.PR_authority_history where p.pr_auth_id == au.pr_auth_id & au.status == (byte)PRStatus.Done select p;
        //GridView1.DataSource = list;
        //GridView1.DataBind();
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
            String venderIDStr = row.Cells[4].Text;
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
                    row.Cells[4].Text = String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name;
                }
                catch (Exception)
                {

                    //throw;
                }
            }
            if (row.Cells[6].Text.Trim() != "&nbsp;")
            {
                row.Cells[6].Text = "$" + row.Cells[6].Text;
            }
            String quoIDStr = row.Cells[3].Text;
            try
            {
                int qid = int.Parse(quoIDStr);
                row.Cells[3].Text = (from q in db.Quotation_Version where q.Quotation_Version_Id == qid select q.Quotation_No).First();
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
    Target Payment Date From :
    <uc1:DateChooser ID="dcFrom" runat="server" />
&nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcTo" runat="server" />
&nbsp;Pay Date From :
    <uc1:DateChooser ID="dcPFrom" runat="server" />
&nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcPTo" runat="server" />
&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
    <br>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            SkinID="GridView" Width="100%"
            DataKeyNames="pr_id"  
            AllowSorting="True" onprerender="GridView1_PreRender" 
        DataSourceID="SqlDataSource1" >
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
                <asp:BoundField DataField="quotaion_id" HeaderText="Quotation Id" 
                    SortExpression="quotaion_id" />
                <asp:BoundField DataField="vendor_id" HeaderText="Vendor Id" 
                    SortExpression="vendor_id" />
                <asp:BoundField DataField="currency" HeaderText="Currency" 
                    SortExpression="currency" />
                <asp:BoundField DataField="total_cost" HeaderText="Total Cost" 
                    SortExpression="total_cost" />
               <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date" 
                    SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="pay_date" HeaderText="Paid Date" 
                    SortExpression="pay_date" DataFormatString="{0:yyyy/MM/dd}"/>
                
               
            </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        SelectCommand="SELECT P.total_cost,P.currency,P.pr_id, P.project_id, P.vendor_id, P.quotaion_id, P.target_payment_date, (SELECT Top 1 PP.pay_date FROM PR AS P1, PR_Payment AS PP WHERE P1.pr_id = PP.pr_id and PP.pr_id = P.pr_id and PP.Status = 10) AS pay_date FROM PR AS P, PR_authority_history AS AU  where P.pr_auth_id = AU.pr_auth_id and AU.status = 6">
    </asp:SqlDataSource>
    </p>
    
</asp:Content>

