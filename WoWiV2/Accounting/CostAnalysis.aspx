<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumns(iGridView1);
        }   
    }

    private void SetMergedHerderColumns(iRowSpanGridView iGridView1)
    {
        iGridView1.AddMergedColumns("Status", 6, 2);
        iGridView1.AddMergedColumns("Vender", 15, 2);
        iGridView1.AddMergedColumns("IMA Cost", 17, 2);
        iGridView1.AddMergedColumns("Prepayment", 20, 2);
        iGridView1.AddMergedColumns("Payment", 25, 2);
    }
    
    
    private int i = 0;
    int count = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        row.Cells[19].CssClass = "HighLight";
        if (count !=0 &&i == count - 1)
        {
            for (int k = 19 ; k <= 25; k++)
            {
                row.Cells[k].CssClass = "HighLight1";
            }
            row.Cells[8].CssClass = "HighLight1";
            row.Cells[10].CssClass = "HighLight1";
        }
        i++;
    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<CostAnalysisData> list = new List<CostAnalysisData>();
        CostAnalysisData temp;
        try
        {
            var datas = from pr in wowidb.PRs select pr;


            decimal profit = 0, invusd = 0, imausd = 0, prepay = 0, preunpay = 0, unpay = 0, payable = 0, payment = 0, totpay = 0;
            foreach (var item in datas)
            {
                int prid = item.pr_id;


                temp = new CostAnalysisData()
                {
                    IMACostCurrency = item.currency,
                    IMA = item.create_user,
                    PRNo = item.pr_id.ToString(),

                };
                
                if (ddlIMA.SelectedValue != "-1")
                {
                    try
                    {
                        int imaid = (from emp in wowidb.employees where emp.username == temp.IMA select emp.id).First(); 
        
                        if (imaid != int.Parse(ddlIMA.SelectedValue))
                        {
                            continue;
                        }
                    }
                    catch (Exception)
                    {
                        
                        //throw;
                    }
                    
                }
                if (item.total_cost.HasValue)
                {
                    temp.IMACost = ((decimal)item.total_cost).ToString("F2");
                    imausd += (decimal)item.total_cost;
                    temp.IMACostCurrency = item.currency;
                    try
                    {
                        WoWiModel.PR_Payment p = (from pa in wowidb.PR_Payment where pa.pr_id == item.pr_id select pa).First();
                        temp.SubCostUSD = ((decimal)p.total_amount).ToString("F2");
                    }
                    catch (Exception)
                    {
                        
                        //throw;
                    }
                    
                    //temp.SubCostUSD
                    //if (item.currency == "USD")
                    //{
                    //    temp.SubCostUSD = ((decimal)item.total_cost).ToString("F2");
                    //}
                    //else
                    //{
                    //    //Temp need to modify!
                    //    temp.SubCostUSD = ((decimal)item.total_cost).ToString("F2");
                    //}
                    
                    
                }

                if (item.vendor_id != -1)
                {
                    temp.VenderNo = item.vendor_id.ToString();
                    try
                    {
                        var vender = (from ven in wowidb.vendors where ven.id == item.vendor_id select ven).First();
                        temp.VenderName = String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name;
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                }

                int pid = (int)item.project_id;
                try
                {
                    WoWiModel.Project proj = (from p in wowidb.Projects where p.Project_Id == pid select p).First();
                    temp.ProjectNo = proj.Project_No;
                    temp.Status = proj.Project_Status;
                    if (DropDownList3.SelectedValue != "All")
                    {
                        if (temp.Status != DropDownList3.SelectedValue)
                        {
                            continue;
                        }
                    }
                    if (ddlProj.SelectedValue != "-1")
                    {
                        String projID = ddlProj.SelectedValue;
                        if (proj.Project_Id != int.Parse(projID))
                        {
                            continue;
                        }
                    }
                    try
                    {
                        DateTime fromDate = dcProjFrom.GetDate();
                        if ((fromDate-proj.Create_Date).TotalDays >=0)
                        {
                            continue;
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    try
                    {
                        DateTime toDate = dcProjTo.GetDate();
                        if ((toDate - proj.Create_Date).TotalDays <= 0)
                        {
                            continue;
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    temp.OpenDate = proj.Create_Date.ToString("yyyy/MM/dd");


                    try
                    {
                        int qid = proj.Quotation_Id;
                        WoWiModel.Quotation_Version quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == qid select q).First();
                        temp.QutationNo = quo.Quotation_No;
                        temp.QutationId = qid;
                        if(quo.modify_date.HasValue){
                            temp.StatusDate = ((DateTime)quo.modify_date).ToString("yyyy/MM/dd");
                        }
                        temp.Model = quo.Model_No;
                        int cid = (int)quo.Client_Id;
                        WoWiModel.clientapplicant cli = (from c in wowidb.clientapplicants where c.id == cid select c).First();
                        if (ddlClient.SelectedValue != "-1")
                        {
                            if (cid != int.Parse(ddlClient.SelectedValue))
                            {
                                continue;
                            }
                        }
                        temp.Client = String.IsNullOrEmpty(cli.c_companyname) ? cli.companyname : cli.c_companyname;
                        var country =  (from cou in wowidb.countries where cou.country_id == cli.country_id select cou).First();
                        temp.Country = country.country_name;
                        if (ddlCountry.SelectedValue != "-1")
                        {
                            if (country.country_id != int.Parse(ddlCountry.SelectedValue))
                            {
                                continue;
                            }
                        }
                        int sid = (int)quo.SalesId;
                        if (ddlSales.SelectedValue != "-1")
                        {
                            if (sid != int.Parse(ddlSales.SelectedValue))
                            {
                                continue;
                            }
                        }
                        WoWiModel.employee sales = (from s in wowidb.employees where s.id == sid select s).First();
                        temp.Sales = String.IsNullOrEmpty(sales.c_fname) ? sales.fname + " " + sales.lname : sales.c_lname + " " + sales.c_fname;
                        bool flag = false;
                        try
                        {
                            int tid = (from pri in wowidb.PR_item where pri.pr_id == item.pr_id select pri.quotation_target_id).First();

                            var invs = (from inv in wowidb.invoices from invt in wowidb.invoice_target where invt.quotation_target_id == tid && invt.quotation_id == qid && inv.invoice_id == invt.invoice_id select inv);

                            decimal tempTot = 0;
                            foreach (var ii in invs)
                            {
                                tempTot += (decimal)ii.total;
                                temp.InvNo += ii.issue_invoice_no + " ";
                                temp.InvDate += ((DateTime)ii.issue_invoice_date).ToString("yyyy/MM/dd ");
                                try
                                {
                                    DateTime fromDate =  dcInvoiceFrom.GetDate();
                                    if ((fromDate - (DateTime)ii.issue_invoice_date).TotalDays >= 0)
                                    {
                                        flag = true;
                                        break;
                                    }
                                }
                                catch (Exception)
                                {

                                    //throw;
                                }
                                try
                                {
                                    DateTime toDate = dcInvoiceTo.GetDate();
                                    if ((toDate - (DateTime)ii.issue_invoice_date).TotalDays <= 0)
                                    {
                                        flag = true;
                                        break;
                                    }
                                }
                                catch (Exception)
                                {

                                    //throw;
                                }
                                var res = from r in wowidb.invoice_received where r.invoice_id == ii.invoice_id select r;
                                foreach (var kk in res)
                                {
                                    temp.ReceiveDate += ((DateTime)kk.received_date).ToString("yyyy/MM/dd ");
                                }
                            }
                            if (flag)
                            {
                                continue;
                            }
                            temp.InvUSD = tempTot.ToString("F2");
                            invusd += tempTot;
                            try
                            {
                                WoWiModel.PR_item pritem = wowidb.PR_item.First(c => c.pr_id == item.pr_id);
                                WoWiModel.Quotation_Target qti = wowidb.Quotation_Target.First(d => d.Quotation_Target_Id == pritem.quotation_target_id);
                                profit += ((decimal)qti.unit_price * (decimal)qti.unit - decimal.Parse(temp.SubCostUSD));
                                temp.GrossProfitUS = ((decimal)qti.unit_price * (decimal)qti.unit-decimal.Parse(temp.SubCostUSD)).ToString("F2");
                            }
                            catch (Exception)
                            {
                                
                                //throw;
                            }
                            
                           
                            try
                            {
                                WoWiModel.PR_Payment pay = (from pr in wowidb.PR_Payment where pr.pr_id == prid select pr).First();
                                if (pay.total_amount.HasValue)
                                {
                                    if (temp.Status == "Done")
                                    {
                                        //已結案已付款
                                        temp.Payment = ((decimal)pay.total_amount).ToString("F2");
                                        payment += (decimal)pay.total_amount;
                                    }
                                    else
                                    {
                                        //未結案已付款
                                        temp.Prepay = ((decimal)pay.total_amount).ToString("F2");
                                        prepay += (decimal)pay.total_amount;
                                    }
                                    temp.TotalPayment = ((decimal)pay.total_amount).ToString("F2");
                                    totpay += (decimal)pay.total_amount;
                                    if (pay.pay_date.HasValue)
                                    {
                                        temp.PaymentDate = ((DateTime)pay.pay_date).ToString("yyyy/MM/dd");
                                    }
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                                if (temp.Status == "Done")
                                {
                                    //已結案未付款
                                    temp.Payable = temp.SubCostUSD;
                                    payable += decimal.Parse(temp.SubCostUSD);
                                }
                                else
                                {
                                    //未結案未付款
                                    temp.Unpay = temp.SubCostUSD;
                                    unpay += decimal.Parse(temp.SubCostUSD);
                                }
                            }
                        }
                        catch (Exception)
                        {

                            //throw;
                        }


                    }
                    catch (Exception)
                    {

                        //throw;
                    }

                }
                catch (Exception)
                {

                    //throw;
                }

                list.Add(temp);
            }

            if (list.Count != 0)
            {
                temp = new CostAnalysisData()
                {
                    GrossProfitUS = profit.ToString("F2"),
                    InvUSD = invusd.ToString("F2"),
                    SubCostUSD = "US$"+imausd.ToString("F2"),
                    Prepay = prepay.ToString("F2"),
                    Preunpay = preunpay.ToString("F2"),
                    Payable = payable.ToString("F2"),
                    Unpay = unpay.ToString("F2"),
                    Payment = payment.ToString("F2"),
                    TotalPayment = totpay.ToString("F2")
                };
                list.Add(temp);
            }
        }
        catch (Exception)
        {

            //throw;
        }
        count = list.Count();
        iGridView1.DataSource = list;
        iGridView1.DataBind();
        if (list.Count == 0)
        {
            btnExport.Enabled = false;
        }
        else
        {
            btnExport.Enabled = true;                         
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        Utils.ExportExcel(iGridView1, "CostAnalysis");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void ddlSales_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name == "Sales" && s.department_id == d.id select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlIMA_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name.Contains("IMA") && s.department_id == d.id select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlProj_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = db.Project;
        (sender as DropDownList).DataTextField = "Project_No";
        (sender as DropDownList).DataValueField = "Project_Id";
        (sender as DropDownList).DataBind();
    }


    protected void ddlClient_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3 select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
        (sender as DropDownList).DataSource = clients;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlCountry_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = db.country;
        (sender as DropDownList).DataTextField = "country_name";
        (sender as DropDownList).DataValueField = "country_id";
        (sender as DropDownList).DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:UpdatePanel runat="server">
  <ContentTemplate>
  毛利分析
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
                            <th align="left" width="13%">
                                Sales :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlSales" runat="server"  AppendDataBoundItems="True" 
                                    onload="ddlSales_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                IMA :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlIMA" runat="server"  AppendDataBoundItems="True" 
                                    onload="ddlIMA_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlProj_Load">
                                     <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlClient_Load">
                                     <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Open Project Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcProjFrom" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcProjTo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Country :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlCountry_Load">
                                     <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcInvoiceFrom" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcInvoiceTo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project Status :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Open</asp:ListItem>
                                    <asp:ListItem>In-Progress</asp:ListItem>
                                    <asp:ListItem>On-Hand</asp:ListItem>
                                    <asp:ListItem>Done</asp:ListItem>
                                    <asp:ListItem>Cancelled</asp:ListItem>
                                    <asp:ListItem>Lost</asp:ListItem>
                                    <asp:ListItem>Void</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Status Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcStatusFromDate" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcStatusToDate" runat="server" Visible="False" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                               <%-- Keyword Search :&nbsp;--%></th>
                            <td width="20%">
                               <%-- <asp:TextBox ID="tbkey" runat="server" Text="" 
                                    ></asp:TextBox>--%>
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    onclick="btnSearch_Click" />
                                
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="btnExport" runat="server" Text="Excel" 
                                    onclick="btnExport_Click" Enabled="False" />
                                
                            </td>
                        </tr>
                        
                       
                   <tr><td colspan="6">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server"  Width="100%" isMergedHeader="True" SkinID="GridView"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass">
                        <Columns>
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:BoundField DataField="GrossProfitUS" HeaderText="Gross Profit US" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="InvUSD" HeaderText="Inv USD" />
                            <asp:BoundField DataField="InvDate" HeaderText="Inv Date" />
                            <asp:BoundField DataField="InvNo" HeaderText="Inv No" />
                            <asp:BoundField DataField="ReceiveDate" HeaderText="Received Date" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA" />
                            <asp:BoundField DataField="VenderNo" HeaderText="No" />
                            <asp:BoundField DataField="VenderName" HeaderText="Name" />
                            <asp:BoundField DataField="IMACostCurrency" HeaderText="幣別" />
                            <asp:BoundField DataField="IMACost" HeaderText="$" />
                            <asp:BoundField DataField="SubCostUSD" HeaderText="SubCost USD" />
                            <asp:BoundField DataField="Prepay" HeaderText="Prepay" />
                            <asp:BoundField DataField="Preunpay" HeaderText="Preunpay" />
                            <asp:BoundField DataField="Unpay" HeaderText="Unpay" />
                            <asp:BoundField DataField="Payable" HeaderText="Payable" />
                            <asp:BoundField DataField="Payment" HeaderText="Payment" />
                            <asp:BoundField DataField="TotalPayment" HeaderText="$" />
                            <asp:BoundField DataField="PaymentDate" HeaderText="Date" />
                            <asp:BoundField DataField="PRNo" HeaderText="PR No" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExport" />
        </Triggers>
   </asp:UpdatePanel>
</asp:Content>

