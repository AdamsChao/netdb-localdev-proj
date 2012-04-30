<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" EnableEventValidation="false" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        //var data = from i in wowidb.invoices where ((DateTime)i.issue_invoice_date).Year == DateTime.Now.Year && ((DateTime)i.issue_invoice_date).Month == DateTime.Now.Month select i;
        //List<InvoiceData> list = new List<InvoiceData>();
        //InvoiceData temp;
        //foreach (var item in data)
        //{
        //    temp = new InvoiceData();
        //    temp.id = item.invoice_id+"";
        //    temp.InvoiceNo = item.issue_invoice_no;
        //    if (item.issue_invoice_date.HasValue)
        //    {
        //        temp.InvoiceDate = ((DateTime)item.issue_invoice_date).ToString("yyyy/MM/dd");
        //    }
        //    try
        //    {
        //        String username = item.create_user;
        //        WoWiModel.employee emp = wowidb.employees.First(c => c.username == username);
        //        temp.Owner = emp.fname + " " + emp.lname;
        //    }
        //    catch (Exception)
        //    {

        //        //throw;
        //    }
        //    temp.ProjectNo = item.project_no;
        //    try
        //    {
        //        QuotationModel.Quotation_Version quo = (from q in db.Quotation_Version where q.Quotation_No == item.quotaion_no select q).First();
        //        temp.Model = quo.Model_No;
                
        //        int cid = (int)quo.Client_Id;
        //        try
        //        {
        //            var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
        //            temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;

        //            int countryid = (int)client.country_id;
        //            var country = (from con in wowidb.countries where con.country_id == countryid select con).First();
        //            temp.Country = country.country_name;
        //            WoWiModel.contact_info contact;
        //            int contactid;
        //            if (quo.Client_Contact != null)
        //            {
        //                contactid = (int)quo.Client_Contact;
        //            }
        //            else
        //            {
        //                contactid = (from c in wowidb.m_clientappliant_contact where c.clientappliant_id == quo.Client_Id select c.contact_id).First();
        //            }
        //            contact = (from c in wowidb.contact_info where c.id == contactid select c).First();
        //            temp.Attn = String.IsNullOrEmpty(contact.fname) ? contact.c_lname + " " + contact.c_fname : contact.fname + " " + contact.lname;
           
        //        }

        //        catch (Exception)
        //        {

        //            //throw;
        //        }
        //        int salesid = (int)quo.SalesId;
        //        //temp.Sales
        //        var sales = (from emp in wowidb.employees where emp.id == salesid select emp).First();
        //        temp.Sales = sales.fname + " " + sales.lname; 
        //    }
        //    catch (Exception)
        //    {
                
        //        //throw;
        //    }
            
        //    temp.Currency = item.ocurrency;
        //    if (temp.Currency == "USD")
        //    {
        //        //temp.USD = ((double)item.final_total);
        //        //temp.NTD = temp.USD / (double)item.exchange_rate;
        //        temp.USD = ((double)item.total);
        //        temp.NTD = ((double)item.final_total);
        //        usdtotal += temp.USD;
        //        usdissuetotal += temp.USD;
        //        ntdtotal += temp.NTD;
        //    }
        //    else
        //    {
        //        //temp.NTD = ((double)item.final_total);
        //        //temp.USD = temp.NTD * (double)item.exchange_rate;
        //        temp.USD = ((double)item.final_total);
        //        temp.NTD = ((double)item.total);
        //        ntdtotal += temp.NTD;
        //        ntdissuetotal += temp.NTD;
        //        usdtotal += temp.USD;
        //    }

        //    if (item.invoice_date.HasValue)
        //    {
        //        temp.IVDate = ((DateTime)item.invoice_date).ToString("yyyy/MM/dd");
        //    }
        //    temp.IVNo = item.invoice_no;
            
        //    temp.QutationNo = item.quotaion_no;
        //    list.Add(temp);
        //}
        //iGridView1.AllowSorting = true;
        //iGridView1.DataSource = list;
        //iGridView1.DataBind();

        //if (iGridView1.Rows.Count == 0)
        //{
        //    Button2.Enabled = false;
        //}
        //else
        //{
        //    Button2.Enabled = true;
        //}
        
        
    }
  
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        Response.Redirect("~/Accounting/CreateInvoice.aspx");
    }

    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name == "Sales" && s.department_id == d.id orderby s.fname, s.c_fname select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void DropDownList2_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = db.Project;
        (sender as DropDownList).DataTextField = "Project_No";
        (sender as DropDownList).DataValueField = "Quotation_Id";
        (sender as DropDownList).DataBind();
    }

    protected void DropDownList3_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return; 
        var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3  orderby c.companyname, c.c_companyname select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
        (sender as DropDownList).DataSource = clients;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {

        Utils.ExportExcel(iGridView1, "InvoiceList");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);
    }

    protected void iGridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in iGridView1.Rows)
        {
            if ((row.FindControl("lblCurrency") as Label).Text == "USD")
            {
                row.Cells[6].CssClass = "HighLight";
            }
            else
            {
                row.Cells[7].CssClass = "HighLight";
            }
        }
    }
    double usdtotal = 0;
    double usdissuetotal = 0;
    double ntdtotal = 0;
    double ntdissuetotal = 0;
    public string GetUSD()
    {
        return GetTotal(usdtotal, usdissuetotal);
    }
    public string GetNTD()
    {
        return GetTotal(ntdtotal, ntdissuetotal);
    }
    public string GetTotal(double tot,double issuetot)
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
        var data = from i in wowidb.invoices select i;
        if (ddlProj.SelectedValue != "-1")
        {
            String projNo = ddlProj.SelectedItem.Text;
            data = data.Where(d => d.project_no == projNo);
        }

        try
        {
            DateTime openDate = dcOpenDate.GetDate();
            data = data.Where(d => ((DateTime)d.invoice_date).Year == openDate.Year && ((DateTime)d.invoice_date).Month == openDate.Month && ((DateTime)d.invoice_date).Day == openDate.Day );
        }
        catch (Exception)
        {
            
            //throw;
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
        List<InvoiceData> list = new List<InvoiceData>();
        InvoiceData temp;
        if (data.Count() != 0)
        {
            usdissuetotal = usdtotal = ntdtotal = ntdissuetotal = 0;
        }
        foreach (var item in data)
        {
            temp = new InvoiceData();
            temp.id = item.invoice_id + "";
            temp.InvoiceNo = item.issue_invoice_no;
            try
            {
                String username = item.create_user;
                WoWiModel.employee emp = wowidb.employees.First(c => c.username == username);
                temp.Owner = emp.fname + " " + emp.lname;
            }
            catch (Exception)
            {

                //throw;
            }
           
            if (item.issue_invoice_date.HasValue)
            {
                temp.InvoiceDate = ((DateTime)item.issue_invoice_date).ToString("yyyy/MM/dd");
            }
            temp.ProjectNo = item.project_no;
            try
            {
                QuotationModel.Quotation_Version quo = (from q in db.Quotation_Version where q.Quotation_No == item.quotaion_no select q).First();
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

                    int countryid = (int)client.country_id;
                    var country = (from con in wowidb.countries where con.country_id == countryid select con).First();
                    temp.Country = country.country_name;
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
                //temp.Sales
                var sales = (from emp in wowidb.employees where emp.id == salesid select emp).First();
                temp.Sales = sales.fname + " " + sales.lname;
            }
            catch (Exception)
            {

                //throw;
            }

            temp.Currency = item.ocurrency;
            if (temp.Currency == "USD")
            {
                temp.USD = ((double)item.final_total);
                temp.NTD = temp.USD / (double)item.exchange_rate;
                usdtotal += temp.USD;
                usdissuetotal += temp.USD;
                ntdtotal += temp.NTD;
            }
            else
            {
                temp.NTD = ((double)item.final_total);
                temp.USD = temp.NTD * (double)item.exchange_rate;
                ntdtotal += temp.NTD;
                ntdissuetotal += temp.NTD;
                usdtotal += temp.USD;
            }

            if (item.invoice_date.HasValue)
            {
                temp.IVDate = ((DateTime)item.invoice_date).ToString("yyyy/MM/dd");
            }
            temp.IVNo = item.invoice_no;

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
                case "Owner":
                    slist = slist.OrderBy(c => c.Owner);
                    break;
                case "QutationNo":
                    slist = slist.OrderBy(c => c.QutationNo);
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
            }
            iGridView1.DataSource = slist;
        }
        iGridView1.AllowSorting = true;
        iGridView1.DataBind();
        if (iGridView1.Rows.Count == 0)
        {
            Button2.Enabled = false;
        }
        else
        {
            Button2.Enabled = true;
        }
        
    }

    protected void iGridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        Search(e.SortExpression);
        // obj = null;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
   <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
       <tr>
           <td align="left" width="50%">
               Invoice Management</td>
           <td align="right" width="50%">
               Date : <%= DateTime.Now.ToString("yyyy/MM/dd") %>
           </td>
       </tr>
  </table>
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th align="left" width="13%">
                                AE :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlSales" runat="server" 
                                    AppendDataBoundItems="True" 
                                    onload="DropDownList1_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date From: </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcFromDate" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcToDate" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    onload="DropDownList2_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Open Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcOpenDate" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" 
                                    onload="DropDownList3_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                               <%-- Keyword Search :&nbsp;--%></th>
                            <td width="20%">
                              <%--  <asp:TextBox ID="TextBox5" runat="server" Text="" Enabled="False" 
                                    ></asp:TextBox>--%>
                            </td>
                            <td align="right" colspan="2">
                                
                               
                                
                            </td>
                            <td align="right" colspan="2">
                                 <asp:Button ID="Button3" runat="server" Text="Search" onclick="Button3_Click" />&nbsp;&nbsp;
                                <asp:Button ID="Button1" runat="server" Text="New" onclick="Button1_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button2" runat="server" Text="Print List" 
                                     onclick="Button2_Click" />
                                
                            </td>
                        </tr>
                       
                    </table>
                    <asp:GridView ID="iGridView1" runat="server" Height="150px" 
          Width="100%" SkinID="GridView"
                         AutoGenerateColumns="False" 
          onprerender="iGridView1_PreRender" ShowFooter="True" AllowSorting="True" onsorting="iGridView1_Sorting" 
                       >
                        <Columns>
                            <asp:TemplateField HeaderText="">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" 
                                        NavigateUrl='<%# Bind("id","~/Accounting/UpdateInvoice.aspx?id={0}") %>' Text='Edit/View'></asp:HyperLink>
                                    <asp:Label ID="lblCurrency" runat="server" Text='<%# Bind("Currency") %>' CssClass="hidden"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" />
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
                                                Issue Invoice Total :</td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Client") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Attn" HeaderText="Attn" SortExpression="Attn" />
                            <asp:TemplateField HeaderText="Inv USD$" ItemStyle-HorizontalAlign="Right">
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
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Inv NT$" ItemStyle-HorizontalAlign="Right">
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
                            </asp:TemplateField>
                            <asp:BoundField DataField="IVDate" HeaderText="I/V Date"  />
                            <asp:BoundField DataField="IVNo" HeaderText="I/V No" />
                            <asp:BoundField DataField="Sales" HeaderText="AE" SortExpression="Sales"/>
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" SortExpression="QutationNo"/>
                            <asp:BoundField DataField="Owner" HeaderText="Issued By" SortExpression="Owner"/>
                        </Columns>
                    </asp:GridView>
      
      </ContentTemplate>
      <Triggers>
          <asp:PostBackTrigger ControlID="Button2" />
      </Triggers>
      
   </asp:UpdatePanel>
</asp:Content>

