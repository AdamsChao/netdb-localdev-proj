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
            if (row.Cells[5].Text.Trim() != "&nbsp;")
            {
                row.Cells[5].Text = "$" + row.Cells[5].Text;
            }
            String quoIDStr = row.Cells[6].Text;
            try
            {
                int qid = int.Parse(quoIDStr);
                row.Cells[6].Text = (from q in db.Quotation_Version where q.Quotation_Version_Id == qid select q.Quotation_No).First();
            }
            catch (Exception)
            {

                //throw;
            }

            String Str = row.Cells[9].Text;
            try
            {
                byte status = byte.Parse(Str);
                row.Cells[9].Text = PRUtils.statusByteToString(status);
                
            }
            catch (Exception)
            {

                //throw;
            }
        }
    }

    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        ddlProjectNo.DataSource = db.Project;
        ddlProjectNo.DataTextField = "Project_No";
        ddlProjectNo.DataValueField = "Project_Id";
        ddlProjectNo.DataBind();
    }

    protected void ddlVenderList_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var list = (from c in wowidb.vendors from country in wowidb.countries where c.country == country.country_id select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name + " - [ " + country.country_name + " ]" : c.name + " - [ " + country.country_name + " ]" });
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //String newCriteria = "";
        //if (ddlProjectNo.SelectedValue != "-1")
        //{
        //    newCriteria += " and P.project_id = " + ddlProjectNo.SelectedValue ;
        //}

        //if (ddlVenderList.SelectedValue != "-1")
        //{
        //    newCriteria += " and P.vendor_id = " + ddlVenderList.SelectedValue;
        //}

        //if (ddlStatus.SelectedValue != "-1")
        //{
        //    newCriteria += " and R.status = " + ddlStatus.SelectedValue;
        //}
        
        //SqlDataSourceClient.SelectCommand += newCriteria;
        //GridView1.DataBind();
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        String newCriteria = "";
        if (ddlProjectNo.SelectedValue != "-1")
        {
            newCriteria += " and P.project_id = " + ddlProjectNo.SelectedValue;
        }

        if (ddlVenderList.SelectedValue != "-1")
        {
            newCriteria += " and P.vendor_id = " + ddlVenderList.SelectedValue;
        }

        if (ddlStatus.SelectedValue != "-1")
        {
            newCriteria += " and R.status = " + ddlStatus.SelectedValue;
        }

        SqlDataSourceClient.SelectCommand += newCriteria;
        GridView1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   PR Lists : <br />
    Project :
    <asp:DropDownList ID="ddlProjectNo" runat="server" AppendDataBoundItems="True" 
        onload="DropDownList1_Load">
        <asp:ListItem Value="-1">- All -</asp:ListItem>
    </asp:DropDownList>
&nbsp;Vender :
    <asp:DropDownList ID="ddlVenderList" runat="server" AppendDataBoundItems="True" 
        onload="ddlVenderList_Load">
        <asp:ListItem Value="-1">- All -</asp:ListItem>
    </asp:DropDownList>
&nbsp;Status :
    <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True">
        <asp:ListItem Value="-1">- All -</asp:ListItem>
        <asp:ListItem Value="0">Init</asp:ListItem>
        <asp:ListItem Value="1">Requisitioner</asp:ListItem>
        <asp:ListItem Value="2">Supervisor</asp:ListItem>
        <asp:ListItem Value="3">VicePresident</asp:ListItem>
        <asp:ListItem Value="4">President</asp:ListItem>
        <asp:ListItem Value="5">Cancel</asp:ListItem>
        <asp:ListItem Value="6">Ready to Pay</asp:ListItem>
    </asp:DropDownList>
&nbsp;
    <asp:Button ID="btnSearch" runat="server" Text="Search" 
        onclick="btnSearch_Click" />
   <br /><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Accounting/CreatePR.aspx" />

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
                <asp:BoundField DataField="currency" HeaderText="Currency" 
                    SortExpression="currency" />
                <asp:BoundField DataField="total_cost" HeaderText="Total Cost" ItemStyle-HorizontalAlign="Right"
                    SortExpression="total_cost" />
                <asp:BoundField DataField="quotaion_id" HeaderText="Quotation Id" 
                    SortExpression="quotaion_id" />
                <asp:BoundField DataField="create_date" HeaderText="Createtion Date" 
                    SortExpression="create_date" DataFormatString="{0:yyyy/MM/dd}" />
                     <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date" 
                    SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="pr_auth_id" HeaderText="Status" 
                    SortExpression="pr_auth_id" />
                <asp:BoundField DataField="status_date" HeaderText="Status Date" 
                    SortExpression="status_date"  DataFormatString="{0:yyyy/MM/dd}" />
               
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
            SelectCommand="SELECT P.currency, P.pr_id, P.project_id, P.quotaion_id, P.vendor_id, P.total_cost,P.create_date,P.target_payment_date,R.status AS pr_auth_id , (CASE R.status WHEN 0 THEN R.create_date WHEN 1 THEN  R.requisitioner_date WHEN 2 THEN supervisor_date WHEN 3 THEN  R.vp_date WHEN 4 THEN  R.president_date  WHEN 6 THEN R.modify_date END) as status_date FROM PR AS P , PR_authority_history AS R WHERE P.pr_auth_id = R.pr_auth_id">
        </asp:SqlDataSource>
    </p>
</asp:Content>

