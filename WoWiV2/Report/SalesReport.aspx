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

    protected void iGridView1_SetCSSClass(GridViewRow row)
    {

        if (row.Cells[14].Text == "USD")
        {
            row.Cells[10].CssClass = "HighLight";
        }
        else
        {
            row.Cells[9].CssClass = "HighLight";
        }
    }
    private void SetMergedHerderColumns(iRowSpanGridView iGridView1)
    {
        iGridView1.AddMergedColumns("Status", 6, 2);
        iGridView1.AddMergedColumns("WoWi", 9, 5);
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

    protected void btnExport_Click(object sender, EventArgs e)
    {
        Utils.ExportExcel(iGridView1, "SalesReport");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<SalesReportData> list = new List<SalesReportData>();
        SalesReportData temp;
        try
        {
            var datas = from p in db.Project select p;
            foreach (var item in datas)
            {
                temp = new SalesReportData()
                {
                    ProjectNo = item.Project_No
                };
                int pid = item.Project_Id;
                temp.Status = item.Project_Status;
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
                    if (item.Project_Id != int.Parse(projID))
                    {
                        continue;
                    }
                }
                try
                {
                    DateTime fromDate = dcProjFrom.GetDate();
                    if ((fromDate - item.Create_Date).TotalDays >= 0)
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
                    if ((toDate - item.Create_Date).TotalDays <= 0)
                    {
                        continue;
                    }
                }
                catch (Exception)
                {

                    //throw;
                }
                temp.OpenDate = item.Create_Date.ToString("yyyy/MM/dd");
                try
                {
                    int qid = item.Quotation_Id;
                    WoWiModel.Quotation_Version quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == qid select q).First();
                    temp.QutationNo = quo.Quotation_No;
                    temp.Currency = quo.Currency;
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
                    var country = (from cou in wowidb.countries where cou.country_id == cli.country_id select cou).First();
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

                    if (quo.Currency == "USD")
                    {
                        temp.InvUSD = ((decimal)quo.FinalTotalPrice).ToString("F2");
                        usdtotal += (decimal)quo.FinalTotalPrice;
                        usdissuetotal += (decimal)quo.FinalTotalPrice;
                        temp.InvNTD = (((decimal)quo.FinalTotalPrice) * 30).ToString("F2");
                        ntdtotal += ((decimal)quo.FinalTotalPrice) * 30;
                    }
                    else
                    {
                        temp.InvNTD = ((decimal)quo.FinalTotalPrice).ToString("F2");
                        ntdtotal += (decimal)quo.FinalTotalPrice;
                        ntdissuetotal += (decimal)quo.FinalTotalPrice;
                        temp.InvUSD = (((decimal)quo.FinalTotalPrice) / 30).ToString("F2");
                        usdtotal += ((decimal)quo.FinalTotalPrice) / 30;
                    }

                    var invoices = from inv in wowidb.invoices where inv.project_no == item.Project_No select inv;
                    bool flag = false;
                    foreach(var invo in invoices){
                        temp.InvNo += invo.issue_invoice_no + " ";
                        temp.InvoiceDate += ((DateTime)invo.issue_invoice_date).ToString("yyyy/MM/dd ");
                        try
                        {
                            DateTime fromDate = dcInvoiceFrom.GetDate();
                            if ((fromDate - (DateTime)invo.issue_invoice_date).TotalDays >= 0)
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
                            if ((toDate - (DateTime)invo.issue_invoice_date).TotalDays <= 0)
                            {
                                flag = true;
                                break;
                            }
                        }
                        catch (Exception)
                        {

                            //throw;
                        }
                    }
                    if (flag)
                    {
                        continue;
                    }
                    int days = 1;
                    if (cli.paymentdays.HasValue)
                    {
                        days = (int)cli.paymentdays;
                    }
                    temp.ReceivedDate = ((DateTime)quo.Request_approval_date).AddDays(days).ToString("yyyy/MM/dd");
                }
                catch (Exception)
                {

                    //throw;
                }
                list.Add(temp);
            }
            
        }
        catch (Exception)
        {

            //throw;
        }
     
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
    decimal usdtotal = 0;
    decimal usdissuetotal = 0;
    decimal ntdtotal = 0;
    decimal ntdissuetotal = 0;
    public string GetUSD()
    {
        return GetTotal(usdtotal, usdissuetotal);
    }
    public string GetNTD()
    {
        return GetTotal(ntdtotal, ntdissuetotal);
    }
    public string GetTotal(decimal tot, decimal issuetot)
    {

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' class='HighLight1'><tr><td align='right' class='Total'>Totall</td></tr><tr><td align='right' class='Total'>IssueTotal</tr></table>");
        sb.Replace("Totall", tot.ToString("F2"));
        sb.Replace("IssueTotal", issuetot.ToString("F2"));
        return sb.ToString();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
      Sales Report
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
                                Project No. :&nbsp;</th>
                            <td width="20%">
                               <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlProj_Load">
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
                                Client : </th>
                            <td width="20%">
                                 <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlClient_Load">
                                     <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 Country :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlCountry_Load">
                                     <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            
                            <th align="left" width="13%">
                             <%--   Keyword Search :&nbsp;&nbsp;--%></th>
                            <td width="20%">
                              <%--  <asp:TextBox ID="TextBox5" runat="server" ></asp:TextBox>--%>
                                </td>
                                <td colspan="4"  align="right">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" onclick="btnSearch_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnExport" runat="server" Text="Excel" Enabled="False" 
                                        onclick="btnExport_Click" />
                            </td>
                        </tr>
                       
                       
                   <tr><td colspan="6">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server" Width="100%" 
                           isMergedHeader="True" AutoGenerateColumns="False" CssClass="Gridview" 
                            ShowFooter="True" onsetcssclass="iGridView1_SetCSSClass" SkipColNum="0">

                        <Columns>
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Status Date">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("StatusDate") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("StatusDate") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <table width="100%" class="HighLight1">
                                        <tr>
                                            <td align="right">
                                                Total :
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Issue Invoice Total :</td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sales">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("Sales") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Sales") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <table width="100%" class="HighLight1">
                                        <tr>
                                            <td align="right">
                                              &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Inv NT$">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("InvNTD") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("InvNTD") %>'></asp:TextBox>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text="<%# GetNTD()%>"></asp:Literal>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Inv US$">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("InvUSD") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("InvUSD") %>'></asp:TextBox>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text="<%# GetUSD()%>"></asp:Literal>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                            <asp:BoundField DataField="InvNo" HeaderText="Inv #" />
                            <asp:BoundField DataField="ReceivedDate" HeaderText="Received Date" />
                            <asp:BoundField DataField="Currency" HeaderText="幣別" />
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

