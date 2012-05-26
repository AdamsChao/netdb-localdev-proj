<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        String newCriteria = "";
        int eid = Utils.GetEmployeeID(User.Identity.Name);
        newCriteria += " and P.department_id in (Select accesslevel_id from m_employee_accesslevel where employee_id =" + eid + ")";
        
        if (ddlVenderList.SelectedValue != "-1")
        {
            newCriteria += " and P.vendor_id = " + ddlVenderList.SelectedValue;
        }
        try
        {
            DateTime fromDate = dcFrom.GetDate();
            newCriteria += " and P.target_payment_date >= '" + dcFrom.GetText()+"' ";
        }
        catch (Exception)
        {


        }

        try
        {
            DateTime toDate = dcTo.GetDate();
            newCriteria += " and P.target_payment_date <= '" + dcTo.GetText() + "' ";
        }
        catch (Exception)
        {
            //throw;
        }
       
        bool append = false;
        try
        {
            DateTime fromDate = dcPFrom.GetDate();
            append = true;
            newCriteria = "select * from (" + SqlDataSource1.SelectCommand+  newCriteria + ") AS u where u.pay_date >= '" + dcPFrom.GetText() + "' ";
        }
        catch (Exception)
        {


        }

        try
        {
            
            DateTime toDate = dcPTo.GetDate();
            if (append)
            {
                newCriteria += " and u.pay_date <= '" + dcPTo.GetText() + "' ";
            }
            else
            {
                append = true;
                newCriteria = " select * from ( " + SqlDataSource1.SelectCommand + newCriteria + " ) AS u where u.pay_date <= '" + dcPTo.GetText() + "' ";
            }
        }
        catch (Exception)
        {
            //throw;
        }

        if (cbNotPay.Checked)
        {
            
        }
        
        if (append)
        {
            if (cbNotPay.Checked)
            {
                newCriteria += " and u.pay_date IS NULL Order by u.pr_id desc ";
            }
            SqlDataSource1.SelectCommand = newCriteria;
        }
        else
        {
            if (cbNotPay.Checked)
            {
                newCriteria = "select * from (" + SqlDataSource1.SelectCommand + newCriteria + ") AS u where u.pay_date IS NULL Order by u.pr_id desc ";
                SqlDataSource1.SelectCommand = newCriteria;
            }
            else
            {
                SqlDataSource1.SelectCommand += newCriteria + " Order by P.pr_id desc ";
            }
        }
        
        GridView1.DataBind();
        if (GridView1.Rows.Count == 0)
        {
            lblMsg.Visible = true;

        }
        else
        {
            lblMsg.Visible = false;
        }

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
            if (row.Cells[5].Text.Trim() != "&nbsp;")
            {
                row.Cells[5].Text =  row.Cells[5].Text +"$";
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

    protected void ddlVenderList_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var list = (from c in wowidb.vendors from country in wowidb.countries where c.country == country.country_id  orderby c.name, c.c_name select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name + " - [ " + country.country_name + " ]" : c.name + " - [ " + country.country_name + " ]" });
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    PR Payment Lists 
    <br />
    Vender :
    <asp:DropDownList ID="ddlVenderList" runat="server" AppendDataBoundItems="True" 
        onload="ddlVenderList_Load">
        <asp:ListItem Value="-1">- All -</asp:ListItem>
    </asp:DropDownList>
&nbsp;Target Payment Date From :
    <uc1:DateChooser ID="dcFrom" runat="server" />
&nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcTo" runat="server" />
&nbsp;<br>Pay Date From :
    <uc1:DateChooser ID="dcPFrom" runat="server" />
&nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcPTo" runat="server" />
    <asp:CheckBox ID="cbNotPay" runat="server" Text="未付" />
&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
   <br>
                    <asp:Label ID="lblMsg" runat="server" 
        Text="No match data found." ></asp:Label>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            SkinID="GridView" Width="100%"
            DataKeyNames="pr_id"  PageSize="50"
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
                <asp:BoundField DataField="quotaion_id" HeaderText="Quotation No" 
                    SortExpression="quotaion_id" />
                <asp:BoundField DataField="vendor_id" HeaderText="Vender" 
                    SortExpression="vendor_id" />
                <asp:BoundField DataField="currency" HeaderText="Currency" ItemStyle-HorizontalAlign="Right"
                    SortExpression="currency" />
                <asp:BoundField DataField="total_cost" HeaderText="Total Cost" ItemStyle-HorizontalAlign="Right"
                    SortExpression="total_cost" />
               <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date" 
                    SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
                <asp:BoundField DataField="pay_date" HeaderText="Paid Date" 
                    SortExpression="pay_date" DataFormatString="{0:yyyy/MM/dd}"/>
                
               
            </Columns>
        </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        SelectCommand="SELECT P.total_cost,P.currency,P.pr_id, P.project_id, P.vendor_id, P.quotaion_id, P.target_payment_date, (SELECT Top 1 PP.pay_date FROM PR AS P1, PR_Payment AS PP WHERE P1.pr_id = PP.pr_id and PP.pr_id = P.pr_id and PP.Status = 10) AS pay_date FROM PR AS P, PR_authority_history AS AU  where P.pr_auth_id = AU.pr_auth_id and AU.status = 6 ">
    </asp:SqlDataSource>
    </p>
    
</asp:Content>

