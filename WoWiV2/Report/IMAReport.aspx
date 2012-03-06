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
        iGridView1.AddMergedColumns("Status", 7, 2);
        iGridView1.AddMergedColumns("WoWi Sub Contract", 13, 2);
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


    protected void ddlVender_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var venders = from c in wowidb.vendors select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_name) ? c.name : c.c_name };
        (sender as DropDownList).DataSource = venders;
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
        Utils.ExportExcel(iGridView1, "IMAReport");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void iGridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in iGridView1.Rows)
        {
            if ((row.FindControl("lblCurrency") as Label).Text == "USD")
            {
                row.Cells[14].BackColor = System.Drawing.Color.Yellow;
            }
            else
            {
                row.Cells[13].BackColor = System.Drawing.Color.Yellow;
            }
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<IMAReportData> list = new List<IMAReportData>();
        IMAReportData temp;
        try
        {
            var datas = from pr in wowidb.PRs select pr;


            foreach (var item in datas)
            {
                int prid = item.pr_id;


                temp = new IMAReportData()
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

                    if (item.currency == "USD")
                    {
                        temp.SubCostUSD = ((decimal)item.total_cost).ToString("F2");
                        usdissuetotal += (decimal)item.total_cost;
                        usdtotal += (decimal)item.total_cost;
                        temp.SubCostNTD = ((decimal)item.total_cost *30).ToString("F2");
                        ntdtotal += (decimal)item.total_cost * 30;
                    }
                    else
                    {
                        //Temp need to modify!
                        temp.SubCostNTD = ((decimal)item.total_cost).ToString("F2");
                        ntdissuetotal += (decimal)item.total_cost;
                        ntdtotal += (decimal)item.total_cost;
                        temp.SubCostUSD = ((decimal)item.total_cost / 30).ToString("F2");
                        usdtotal += (decimal)item.total_cost / 30;
                    }
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
                    int qid = proj.Quotation_Id;
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
                    WoWiModel.Quotation_Version quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == qid select q).First();
                    temp.QutationNo = quo.Quotation_No;
                    temp.Model = quo.Model_No;
                    temp.Version = ((int)quo.Vername).ToString();
                    int cid = (int)quo.Client_Id;
                    WoWiModel.clientapplicant cli = (from c in wowidb.clientapplicants where c.id == cid select c).First();
                    temp.Client = String.IsNullOrEmpty(cli.c_companyname) ? cli.companyname : cli.c_companyname;
                    try
                    {
                        DateTime fromDate = dcProjFrom.GetDate();
                        if ((fromDate - proj.Create_Date).TotalDays >= 0)
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
                    var country = (from cou in wowidb.countries where cou.country_id == cli.country_id select cou).First();
                    temp.Country = country.country_name;
                    if (ddlCountry.SelectedValue != "-1")
                    {
                        if (country.country_id != int.Parse(ddlCountry.SelectedValue))
                        {
                            continue;
                        }
                    }
                    bool flag = false;
                    try
                    {
                        int tid = (from pri in wowidb.PR_item where pri.pr_id == item.pr_id select pri.quotation_target_id).First();

                        var invs = (from inv in wowidb.invoices from invt in wowidb.invoice_target where invt.quotation_target_id == tid && invt.quotation_id == qid && inv.invoice_id == invt.invoice_id select inv);

                        decimal tempTot = 0;
                        foreach (var ii in invs)
                        {
                            tempTot += (decimal)ii.total;

                            var res = from r in wowidb.invoice_received where r.invoice_id == ii.invoice_id select r;
                            foreach (var kk in res)
                            {
                                temp.PaymentDate += ((DateTime)kk.received_date).ToString("yyyy/MM/dd ");
                            }
                        }
                        if (flag)
                        {
                            continue;
                        }
                    }
                    catch
                    {
                    }
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
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  IMA Report(認證人員下單總表)
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                      
                        <tr>
                             <th align="left" width="13%">
                                IMA :&nbsp;</th>
                            <td width="20%">
                                  <asp:DropDownList ID="ddlIMA" runat="server"  AppendDataBoundItems="True" 
                                    onload="ddlIMA_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Project Date : </th>
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
                                Vender Name : </th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlVender" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlVender_Load">
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
                               <%-- Keyword Search :&nbsp;&nbsp;--%></th>
                            <td width="20%">
                               <%-- <asp:TextBox ID="TextBox5" runat="server" Text=""></asp:TextBox>--%>
                            </td>
                          
                            <td colspan="2" align="center">
                               <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    onclick="btnSearch_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnExport" runat="server" Text="Excel" 
                                    onclick="btnExport_Click" Enabled="False" />
                            </td>
                        </tr>
                       
                       
                   <tr><td colspan="6">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server"  Width="100%" 
                           isMergedHeader="True" ShowFooter="true"
                       AutoGenerateColumns="False" CssClass="Gridview" 
                           onprerender="iGridView1_PreRender"  >
                        <Columns>
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Version" HeaderText="Version" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA" />
                            <asp:BoundField DataField="VenderNo" HeaderText="No" />
                            <asp:BoundField DataField="VenderName" HeaderText="Name" />
                            <asp:TemplateField HeaderText="IMACost">
                                <ItemTemplate>
                                <asp:Label ID="lblCurrency" runat="server" Text='<%# Bind("IMACostCurrency") %>'></asp:Label>$
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IMACost") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IMACost") %>'></asp:TextBox>
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
                            <asp:TemplateField HeaderText="Cost NTD">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SubCostNTD") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SubCostNTD") %>'></asp:TextBox>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text="<%# GetNTD()%>"></asp:Literal>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cost USD">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("SubCostUSD") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SubCostUSD") %>'></asp:TextBox>
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text="<%# GetUSD()%>"></asp:Literal>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PaymentDate" HeaderText="Payment Date" />     
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

