<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" EnableEventValidation="false" %>

<%@ Register Src="../UserControls/DateChooser.ascx" TagName="DateChooser" TagPrefix="uc1" %>
<script runat="server">
  QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
  WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();


  protected void DropDownList1_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    var sales = (from i in wowidb.invoices
                 from p in wowidb.Projects
                 from q in wowidb.Quotation_Version
                 from s in wowidb.employees
                 where i.project_no == p.Project_No && p.Quotation_No == q.Quotation_No && s.id == q.SalesId
                 orderby s.fname, s.c_fname
                 select new { Id = s.id, Name = s.fname + " " + s.lname }).Distinct();
    //var sales = from s in wowidb.employees from d in wowidb.departments where d.name.Contains("Sales") && s.department_id == d.id select new { Id = s.id, Name = s.fname + " " + s.lname };
    (sender as DropDownList).DataSource = sales;
    (sender as DropDownList).DataTextField = "Name";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }


  protected void DropDownList2_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    Utils.ProjectDropDownList_Load(sender, e);
  }

  protected void DropDownList3_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    ////var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3 orderby c.companyname, c.c_companyname select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
    //var clients =
    //  (from i in wowidb.invoices
    //   from p in wowidb.Projects
    //   from q in wowidb.Quotation_Version
    //   from c in wowidb.clientapplicants
    //   where i.project_no == p.Project_No && p.Quotation_No == q.Quotation_No && c.id == q.Client_Id
    //   orderby c.companyname, c.c_companyname
    //   select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname })
    //  .Distinct();
    //(sender as DropDownList).DataSource = clients;
    //(sender as DropDownList).DataTextField = "Name";
    //(sender as DropDownList).DataValueField = "Id";
    //(sender as DropDownList).DataBind();s
    var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3 orderby c.companyname, c.c_companyname select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
    (sender as DropDownList).DataSource = clients;
    (sender as DropDownList).DataTextField = "Name";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }

  protected void Button2_Click(object sender, EventArgs e)
  {
    Utils.ExportExcel(iGridView1, "ARList");
  }

  public override void VerifyRenderingInServerForm(Control control)
  {

  }

  protected void iGridView1_PreRender(object sender, EventArgs e)
  {

    foreach (GridViewRow row in iGridView1.Rows)
    {
      if ((row.Cells[17].FindControl("Label5") as Label).Text == "USD")
      //if (row.Cells[17].Text == "USD")
      {
        row.Cells[5].CssClass = "HighLight";
      }
      else
      {
        row.Cells[6].CssClass = "HighLight";
      }
      if (!Page.IsPostBack)
        row.Cells[18].Text = "$" + row.Cells[18].Text;
    }
  }
  double usdtotal = 0;
  double usdissuetotal = 0;
  double ntdtotal = 0;
  double ntdissuetotal = 0;
  double arusdtotal = 0;
  double arntdtotal = 0;
  public string GetUSD()
  {
    return GetTotal(usdtotal, usdissuetotal);
  }
  public string GetNTD()
  {
    return GetTotal(ntdtotal, ntdissuetotal);
  }

  public string GetAR()
  {
    return GetTotal(arusdtotal, arntdtotal);
  }
  public string GetTotal(double tot, double issuetot)
  {

    StringBuilder sb = new StringBuilder();
    sb.Append("<table width='100%'><tr><td align='right' class='Total'>Totall</td></tr><tr><td align='right' class='Total'>IssueTotal</tr></table>");
    sb.Replace("Totall", tot.ToString("F2"));
    sb.Replace("IssueTotal", issuetot.ToString("F2"));

    return sb.ToString();
  }

  protected void Button3_Click(object sender, EventArgs e)
  {
    Search(null);
  }

  protected void Search(String str)
  {
    var data = from i in wowidb.invoices where i.status != (byte)InvoicePaymentStatus.WithDraw select i;
    if (ddlProj.SelectedValue != "-1")
    {
      String projNo = ddlProj.SelectedValue;
      data = data.Where(d => d.project_no == projNo);
    }

    try
    {
      DateTime fromDate = dcFromDate.GetDate();
      data = data.Where(d => ((DateTime)d.issue_invoice_date) >= fromDate);
    }
    catch (Exception)
    {

      //throw;
    }

    try
    {
      DateTime toDate = dcToDate.GetDate();
      data = data.Where(d => ((DateTime)d.issue_invoice_date) <= toDate);
    }
    catch (Exception)
    {

      //throw;
    }

    if (cbARBalance0.Checked && cbARBalance1.Checked || !cbARBalance0.Checked && !cbARBalance1.Checked)
    {

    }
    else
    {
      if (cbARBalance0.Checked)
      {
        data = data.Where(d => d.ar_balance == 0);
      }
      else
      {
        data = data.Where(d => d.ar_balance != 0);
      }
    }
    List<ARInvoiceData> list = new List<ARInvoiceData>();
    ARInvoiceData temp;
    if (data.Count() != 0)
    {
      usdissuetotal = usdtotal = ntdtotal = ntdissuetotal = 0;
    }
    foreach (var item in data.OrderByDescending(c => c.invoice_no))
    {
      temp = new ARInvoiceData();
      temp.id = item.invoice_id + "";
      temp.InvoiceNo = item.issue_invoice_no;
      //temp.ARBalance = ((decimal)item.ar_balance).ToString("F2");
      if (item.issue_invoice_date.HasValue)
      {
        temp.InvoiceDate = ((DateTime)item.issue_invoice_date).ToString("yyyy/MM/dd");
      }
      temp.IVNo = item.invoice_no;
      if (item.invoice_date.HasValue)
      {
        temp.IVDate = ((DateTime)item.invoice_date).ToString("yyyy/MM/dd");
      }
      try
      {
        var rlist = (from radd in wowidb.invoice_received where radd.invoice_id == item.invoice_id select radd);
        foreach (var ritem in rlist)
        {
          temp.IVNo += " " + ritem.iv_no;
          if (ritem.received_date.HasValue)
          {
            temp.IVDate += " " + ((DateTime)ritem.received_date).ToString("yyyy/MM/dd");
          }
        }
      }
      catch (Exception)
      {

        //throw;
      }
      temp.ProjectNo = item.project_no;
      try
      {
        QuotationModel.Project proj = (from pp in db.Project where pp.Project_No == item.project_no select pp).First();
        QuotationModel.Quotation_Version quo = (from q in db.Quotation_Version where q.Quotation_Version_Id == proj.Quotation_Id select q).First();
        temp.Model = quo.Model_No;

        int cid = (int)quo.Client_Id;
        try
        {
          var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
          if (ddlClient.SelectedValue != "-1")
          {
            int clientID = int.Parse(ddlClient.SelectedValue);
            if (clientID != client.id)
            {
              continue;
            }
          }
          temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;
          temp.PlanDueDate = ((DateTime)item.due_date).ToString("yyyy/MM/dd");
          int days = 0;
          //if (client.paymentterm.HasValue)
          //{
          //    temp.PaymentTerms = ((byte)client.paymentterm).ToString();
          //    days = (int)((DateTime)item.due_date - DateTime.Now).TotalDays;
          //}
          if (client.paymentdays.HasValue)
          {
            temp.PaymentTerms = client.paymentdays + "";
            days = (int)((DateTime)item.due_date - DateTime.Now).TotalDays;
          }
          if (days != 0)
          {
            temp.OverDueDays = days.ToString();
            temp.OverDueInterval = ARUtils.GetARInterval(-1 * days);
          }
          //int countryid = (int)client.country_id;
          //var country = (from con in wowidb.countries where con.country_id == countryid select con).First();
          //temp.Country = country.country_name;
          try
          {
            var itlist = wowidb.invoice_target.Where(c => c.invoice_id == item.invoice_id);
            foreach (var kk in itlist)
            {
              var ddd = wowidb.Quotation_Target.First(c => c.Quotation_Target_Id == kk.quotation_target_id);
              int countryid = (int)ddd.country_id;
              var country = (from con in wowidb.countries where con.country_id == countryid select con).First();
              temp.Country += country.country_name + "/ ";
            }
          }
          catch (Exception)
          {

            //throw;
          }
          WoWiModel.contact_info contact;
          int contactid;
          if (quo.Client_Contact != null)
          {
            contactid = (int)quo.Client_Contact;
          }
          else
          {
            contactid = (from c in wowidb.m_clientappliant_contact where c.clientappliant_id == quo.Client_Id select c.contact_id).First();
          }
          contact = (from c in wowidb.contact_info where c.id == contactid select c).First();
          temp.Attn = String.IsNullOrEmpty(contact.fname) ? contact.c_lname + " " + contact.c_fname : contact.fname + " " + contact.lname;

        }

        catch (Exception)
        {

          //throw;
        }
        if (ddlSales.SelectedValue != "-1")
        {
          int salesID = int.Parse(ddlSales.SelectedValue);
          if (salesID != (int)quo.SalesId)
          {
            continue;
          }
        }
        int salesid = (int)quo.SalesId;


        //Add by Adams for AR Access Level
        var user = wowidb.employees.Where(e => e.username == User.Identity.Name).First();
        var access = wowidb.m_employee_accesslevel.Where(a => a.employee_id == user.id);
        var isaccess = access.Where(a => a.accesslevel_id == quo.Access_Level_ID);
        if (isaccess.Count() == 0)
        {
          continue;
        }

        //temp.Sales
        var sales = (from emp in wowidb.employees where emp.id == salesid select emp).First();
        temp.Sales = sales.fname + " " + sales.lname;
      }
      catch (Exception)
      {

        //throw;
      }

      temp.OCurrency = item.ocurrency;
      temp.Currency = item.ocurrency;
      decimal ARBalance = ((decimal)item.ar_balance);
      //if (item.ocurrency != item.currency)
      //{
      //    //if (temp.Currency == "USD")
      //    //{
      //    //    temp.NTD = ((double)item.total / (double)item.exchange_rate);
      //    //    temp.USD = ((double)item.final_total);
      //    //    usdtotal += temp.USD;
      //    //    usdissuetotal += temp.USD;
      //    //    ntdtotal += temp.NTD;
      //    //    arusdtotal += (double)ARBalance /(double)item.exchange_rate;
      //    //    temp.ARBalance = ((decimal)ARBalance/(decimal)item.exchange_rate).ToString("F2");
      //    //}
      //    //else
      //    //{
      //    //    temp.NTD = ((double)item.total);
      //    //    temp.USD = ((double)item.final_total);
      //    //    ntdtotal += temp.NTD;
      //    //    ntdissuetotal += temp.NTD;
      //    //    usdtotal += temp.USD;
      //    //    arntdtotal += (double)ARBalance * (double)item.exchange_rate;
      //    //    temp.ARBalance = ((decimal)ARBalance * (decimal)item.exchange_rate).ToString("F2");
      //    //}
      //}
      //else
      {
        if (temp.Currency == "USD")
        {
          temp.USD = ((double)item.total);
          temp.NTD = ((double)item.total * (double)item.exchange_rate);
          usdtotal += temp.USD;
          usdissuetotal += temp.USD;
          ntdtotal += temp.NTD;
          arusdtotal += (double)ARBalance;
          temp.ARBalance = ((decimal)ARBalance).ToString("F2");
        }
        else
        {
          temp.NTD = ((double)item.total);
          temp.USD = ((double)item.total / (double)item.exchange_rate);
          ntdtotal += temp.NTD;
          ntdissuetotal += temp.NTD;
          usdtotal += temp.USD;
          arntdtotal += (double)ARBalance;
          temp.ARBalance = ((decimal)ARBalance).ToString("F2");
        }
      }

      //if (item.invoice_date.HasValue)
      //{
      //    temp.IVDate = ((DateTime)item.invoice_date).ToString("yyyy/MM/dd");
      //}
      //temp.IVNo = item.invoice_no;

      temp.QutationNo = item.quotaion_no;
      list.Add(temp);
    }
    if (str == null)
    {
      iGridView1.DataSource = list;
    }
    else
    {
      var slist = from i in list select i;
      switch (str)
      {
        case "Sales":
          slist = slist.OrderBy(c => c.Sales);
          break;
        case "OverDueDays":
          slist = slist.OrderBy(c => int.Parse(c.OverDueDays));
          break;
        case "OverDueInterval":
          slist = slist.OrderByDescending(c => c.OverDueInterval);
          break;
        case "Attn":
          slist = slist.OrderBy(c => c.Attn);
          break;
        case "ProjectNo":
          slist = slist.OrderBy(c => c.ProjectNo);
          break;
        case "Client":
          slist = slist.OrderBy(c => c.Client);
          break;
        case "Model":
          slist = slist.OrderBy(c => c.Model);
          break;
        case "Currency":
          slist = slist.OrderBy(c => c.Currency);
          break;
        case "OCurrency":
          slist = slist.OrderBy(c => c.OCurrency);
          break;
      }
      iGridView1.DataSource = slist;
    }
    iGridView1.AllowSorting = true;
    iGridView1.DataBind();
    if (iGridView1.Rows.Count == 0)
    {
      Button2.Enabled = false;
      lblMsg.Visible = true;

    }
    else
    {
      Button2.Enabled = true;
      lblMsg.Visible = false;
    }

  }

  protected void iGridView1_Sorting(object sender, GridViewSortEventArgs e)
  {
    Search(e.SortExpression);
    //obj = null;
  }

  protected void Page_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    //Search(null);
    lblMsg.Visible = false;
    Button2.Enabled = false;
  }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
      AR Management
      <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
        <tr>
          <th align="left" width="13%">
            AE :&nbsp;
          </th>
          <td width="20%">
            <asp:DropDownList ID="ddlSales" runat="server" AppendDataBoundItems="True" OnLoad="DropDownList1_Load">
              <asp:ListItem Value="-1">- All -</asp:ListItem>
            </asp:DropDownList>
          </td>
          <th align="left" width="13%">
            Issue Invoice Date From :
          </th>
          <td width="20%">
            <uc1:DateChooser ID="dcFromDate" runat="server" />
          </td>
          <th align="left" width="13%">
            To :&nbsp;
          </th>
          <td width="20%">
            <uc1:DateChooser ID="dcToDate" runat="server" />
          </td>
        </tr>
        <tr>
          <th align="left" width="13%">
            Project No. :&nbsp;
          </th>
          <td width="20%">
            <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" OnLoad="DropDownList2_Load">
              <asp:ListItem Value="-1">- All -</asp:ListItem>
            </asp:DropDownList>
          </td>
          <th align="left" width="13%">
            Client :
          </th>
          <td width="20%">
            <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" OnLoad="DropDownList3_Load">
              <asp:ListItem Value="-1">- All -</asp:ListItem>
            </asp:DropDownList>
          </td>
          <th align="left" width="13%">
            AR Balance
          </th>
          <td width="20%">
            <asp:CheckBox ID="cbARBalance0" runat="server" Text="等於0" />
            <asp:CheckBox ID="cbARBalance1" runat="server" Text="不等於0" />
          </td>
        </tr>
        <tr>
          <th align="left" width="13%">
            <%-- Keyword Search :&nbsp;--%>
          </th>
          <td width="20%">
            <%--  <asp:TextBox ID="TextBox5" runat="server" Text="" Enabled="False" 
                                    ></asp:TextBox>--%>
          </td>
          <td align="right" colspan="2">
          </td>
          <td align="right" colspan="2">
            <asp:Button ID="Button3" runat="server" Text="Search" OnClick="Button3_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="Excel" OnClick="Button2_Click" />
          </td>
        </tr>
      </table>
      <asp:Label ID="lblMsg" runat="server" Text="No match data found."></asp:Label>
      <asp:GridView ID="iGridView1" runat="server" Height="150px" SkinID="GridView" PageSize="50"
        AutoGenerateColumns="False" OnPreRender="iGridView1_PreRender" ShowFooter="True"
        OnSorting="iGridView1_Sorting">
        <HeaderStyle Wrap="false" />
        <Columns>
          <asp:TemplateField HeaderText="Invoice No">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Bind("id","~/Accounting/ReceivedAdd.aspx?id={0}") %>'
                Text='<%# Bind("InvoiceNo") %>'></asp:HyperLink>
              <%--   <asp:Label ID="lblCurrency" runat="server" Text='<%# Bind("Currency") %>' CssClass="hidden"></asp:Label>--%>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
          <asp:BoundField DataField="ProjectNo" HeaderText="Project No" SortExpression="ProjectNo" />
          <asp:TemplateField HeaderText="Client" SortExpression="Client">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Client") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
              <table width="100%">
                <tr>
                  <td align="right">
                    Total :
                  </td>
                </tr>
                <tr>
                  <td align="right">
                    Issue Invoice Total :
                  </td>
                </tr>
              </table>
            </FooterTemplate>
            <ItemTemplate>
              <asp:Label ID="Label1" runat="server" Text='<%# Bind("Client") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="Attn" HeaderText="Attn" SortExpression="Attn" />
          <asp:TemplateField HeaderText="AR Inv USD$" ItemStyle-HorizontalAlign="Right">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("USD") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label2" runat="server" Text='<%# Bind("USD", "{0:F2}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
              <asp:Literal ID="Literal1" runat="server" Text="<%# GetUSD()%>"></asp:Literal>
            </FooterTemplate>
            <ControlStyle CssClass="Currency" />
            <ItemStyle HorizontalAlign="Right" />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="AR Inv NT$" ItemStyle-HorizontalAlign="Right">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("NTD") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label3" runat="server" Text='<%# Bind("NTD", "{0:F2}") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
              <asp:Literal ID="Literal1" runat="server" Text="<%# GetNTD()%>"></asp:Literal>
            </FooterTemplate>
            <ControlStyle CssClass="Currency" />
            <ItemStyle HorizontalAlign="Right" />
          </asp:TemplateField>
          <asp:BoundField DataField="IVDate" HeaderText="I/V Date" />
          <asp:BoundField DataField="IVNo" HeaderText="I/V No" />
          <asp:BoundField DataField="Sales" HeaderText="AE" SortExpression="Sales" />
          <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
          <asp:BoundField DataField="Country" HeaderText="Country" />
          <asp:BoundField DataField="QutationNo" HeaderText="Quotation No" />
          <asp:BoundField DataField="PaymentTerms" HeaderText="收款天數" ItemStyle-HorizontalAlign="Right" />
          <asp:BoundField DataField="PlanDueDate" HeaderText="預計收款日" ItemStyle-HorizontalAlign="Right" />
          <asp:BoundField DataField="OverDueDays" HeaderText="逾期天數" SortExpression="OverDueDays"
            ItemStyle-HorizontalAlign="Right" />
          <asp:BoundField DataField="OverDueInterval" HeaderText="逾期區間" SortExpression="OverDueInterval" />
          <%-- <asp:BoundField DataField="OCurrency" HeaderText="Currency" SortExpression="OCurrency" ItemStyle-HorizontalAlign="Right"/>
          --%>
          <asp:TemplateField HeaderText="Currency" ItemStyle-HorizontalAlign="Right" SortExpression="Currency">
            <EditItemTemplate>
              <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Currency") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="Label5" runat="server" Text='<%# Bind("Currency") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
              <table width="100%">
                <tr>
                  <td align="right">
                    US$
                  </td>
                </tr>
                <tr>
                  <td align="right">
                    NT$
                  </td>
                </tr>
              </table>
            </FooterTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="AR Balance">
            <ItemTemplate>
              <asp:Label ID="Label4" runat="server" Text='<%# Bind("ARBalance") %>'></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ARBalance") %>'></asp:TextBox>
            </EditItemTemplate>
            <FooterTemplate>
              <asp:Literal ID="Literal1" runat="server" Text="<%# GetAR()%>"></asp:Literal>
            </FooterTemplate>
            <ItemStyle HorizontalAlign="Right" />
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="Button2" />
    </Triggers>
  </asp:UpdatePanel>
</asp:Content>
