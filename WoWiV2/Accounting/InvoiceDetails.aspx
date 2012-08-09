<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>
<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>
<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    static String Prepayment1 = "Prepayment1";
    static String Prepayment2 = "Prepayment2";
    static String Prepayment3 = "Prepayment3";
    static String Finalpayment = "FinalPayment";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);//invoiceid
            int iid = Math.Abs(id);
            WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == iid select i).First();
            lblInvoiceID.Text = iid.ToString();
            tbIssueInvoice.Text = invoice.issue_invoice_no;
            tbIssueInvoiceDate.Text = ((DateTime)invoice.issue_invoice_date).ToString("yyyy/MM/dd");
            if (invoice.invoice_date.HasValue)
            {
                dcinvdate.setText(((DateTime)invoice.issue_invoice_date).ToString("yyyy/MM/dd"));
                dcinvdate.isEnabled(false);
            }
            tbivno.Text = invoice.invoice_no;
            InvoicePaymentStatus status;
            if (invoice.status.HasValue)
            {
                if (invoice.status == (byte)InvoicePaymentStatus.Received)
                {
                    status = InvoicePaymentStatus.Received;
                }
                else if (invoice.status == (byte)InvoicePaymentStatus.WithDraw)
                {
                    status = InvoicePaymentStatus.WithDraw;
                }
                else
                {
                    status = InvoicePaymentStatus.Init;
                }
                lblStatus.Text = status.ToString();
            }
            String projNo = invoice.project_no;
            String qidStr;
            foreach (ListItem item in ddlProj.Items)
            {
                if (item.Text == projNo)
                {
                    item.Selected = true;
                    qidStr = item.Value;
                    break;
                }
            }
        }
        
    }

    protected void ddlProj_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        Utils.ProjectNoDescDropDownList_Load(sender, e);
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);//invoiceid
            int iid = Math.Abs(id);
            WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == iid select i).First();
            String projNo = invoice.project_no;
            String qidStr;
            foreach (ListItem item in ddlProj.Items)
            {
                if (item.Text == projNo)
                {
                    item.Selected = true;
                    qidStr = item.Value;
                    break;
                }
            }
            ddlProj_SelectedIndexChanged(sender, null);
            try
            {
                (iGridView2.FooterRow.FindControl("lblOCurrency") as Label).Text = invoice.ocurrency;
                (iGridView2.FooterRow.FindControl("lblOCurrency1") as Label).Text = invoice.ocurrency;
                (iGridView2.FooterRow.FindControl("lblOCurrency2") as Label).Text = invoice.ocurrency;
                (iGridView2.FooterRow.FindControl("lblOCurrency3") as Label).Text = invoice.ocurrency;
                (iGridView2.FooterRow.FindControl("lblOTotal") as Label).Text = ((decimal)invoice.ototal).ToString("F2");
                (iGridView2.FooterRow.FindControl("tbTax") as TextBox).Text = ((decimal)invoice.tax).ToString("F2");
                (iGridView2.FooterRow.FindControl("tbdiscount") as TextBox).Text = ((decimal)invoice.adjust).ToString("F2");
                (iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text = ((decimal)invoice.total).ToString("F2");
                (iGridView2.FooterRow.FindControl("ddloperate") as DropDownList).SelectedValue = invoice.exchange_operate;
                (iGridView2.FooterRow.FindControl("ddlCurrency") as DropDownList).SelectedValue = invoice.currency;
                (iGridView2.FooterRow.FindControl("tbTotal") as TextBox).Text = ((decimal)invoice.final_total).ToString("F2");
                (iGridView2.FooterRow.FindControl("tbRemarks") as TextBox).Text = invoice.remarks;
                (iGridView2.FooterRow.FindControl("tbExchangeRate") as TextBox).Text = ((decimal)invoice.exchange_rate).ToString("F2");
                //(iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = InvoiceUtils.WoWi_Bank_Info1;
            }
            catch (Exception)
            {
                
                //throw;
            }
           
        }
    }

    protected void ddlProj_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int qid = int.Parse((sender as DropDownList).SelectedValue);
            QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == qid select d).First();
            lblQuotationNo.Text = quotation.Quotation_No;
            GetAllItems(lblQuotationNo.Text);
            lblModel.Text = quotation.Model_No;
           
            try
            {

                int clientid = (int)quotation.Client_Id;
                WoWiModel.clientapplicant client = (from c in wowidb.clientapplicants where c.id == clientid select c).First();
                lblClient.Text = String.IsNullOrEmpty(client.companyname) ? client.c_companyname : client.companyname;
                lblAddress.Text = String.IsNullOrEmpty(client.address) ? client.c_address : client.address;
                
            }
            catch (Exception)
            {
                
                
            }
            
          
            try
            {
                WoWiModel.contact_info contact;
                int contactid;
                if (quotation.Client_Contact != null)
                {
                    contactid = (int)quotation.Client_Contact;
                }
                else
                {
                    contactid = (from c in wowidb.m_clientappliant_contact where c.clientappliant_id  == quotation.Client_Id select c.contact_id).First();
                }
                contact= (from c in wowidb.contact_info where c.id == contactid select c).First();
                lblContact.Text = String.IsNullOrEmpty(contact.fname) ? contact.c_lname + " " + contact.c_fname : contact.fname + " " + contact.lname;
            }
            catch (Exception)
            {


            }
            
        }
        catch (Exception)
        {
            
            //throw;
        }
        
    }

    private void GetAllItems(String qno)
    {
        try
        {
            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int id = int.Parse(Request.QueryString["id"]);//invoiceid
                List<ProjectInvoiceData> items = new List<ProjectInvoiceData>();
                ProjectInvoiceData temp;
            
                var targets = from c in wowidb.invoice_target where c.invoice_id == id select c;
                foreach (var i in targets)
                {
                    temp = new ProjectInvoiceData()
                    {
                        No = qno,
                        //FPrice = (decimal)i.amount,
                        PayAmount = i.amount+""
                    };
                    
                    int tid = Math.Abs(i.quotation_target_id);
                    var quoTarget = (from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid select qt).First();
                    temp.Bill = quoTarget.Bill;
                    temp.Status = quoTarget.Status;
                    temp.TDescription = quoTarget.target_description;
                    temp.Qty = (double)quoTarget.unit;
                    temp.UOM = ((double)quoTarget.unit).ToString("F0");
                    temp.UnitPrice = (decimal)quoTarget.unit_price;
                    temp.FPrice = (decimal)temp.Qty * temp.UnitPrice;
                    int quoid = (int)quoTarget.quotation_id;
                    var quo = (from q in db.Quotation_Version where q.Quotation_Version_Id == quoid select q).First();
                    temp.VersionNo = (int)quo.Vername;
                    temp.Date = (DateTime)quo.create_date;
                    if (i.bill_status == (byte)InvoicePaymentStatus.PrePaid1)
                    {
                        temp.PayType = Prepayment1;
                    }
                    else if (i.bill_status == (byte)InvoicePaymentStatus.PrePaid2)
                    {
                        temp.PayType = Prepayment2;
                    }
                    else if (i.bill_status == (byte)InvoicePaymentStatus.PrePaid3)
                    {
                        temp.PayType = Prepayment3;
                    }
                    else if (i.bill_status == (byte)InvoicePaymentStatus.FinalPaid)
                    {
                        temp.PayType = Finalpayment ;
                    }
                    items.Add(temp);
                }

                iGridView2.DataSource = items;
                iGridView2.DataBind();
                try
                {
                    int iid = Math.Abs(id);
                    WoWiModel.invoice invoice = wowidb.invoices.First(d => d.invoice_id == iid);
                    int bid = (int)invoice.bankacct_info_id;
                    ddlwowibankinfo.SelectedValue = bid.ToString();
                    WoWiModel.wowi_bankinfo b = wowidb.wowi_bankinfo.First(c => c.id == bid);
                    (iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = b.info;
                }
                catch (Exception)
                {

                    //throw;
                }
            }
         
        }
        catch (Exception ex)
        {

            throw ex;
        }
       
        
    }

    protected void ddlwowibankinfo_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        ddlwowibankinfo.DataSource = wowidb.wowi_bankinfo;
        ddlwowibankinfo.DataValueField = "id";
        ddlwowibankinfo.DataTextField = "display_name";
        ddlwowibankinfo.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script type="text/javascript">
    function openPrintWin() {
        window.open('<%= "InvoicePrint.aspx?id=" + Request.QueryString["id"] %>', 'new', 'scrollbars=yes,menubar=yes,height=800,width=800,resizable=no,toolbar=no,location=no,status=no');
    }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Invoice ID = 
    <asp:Label ID="lblInvoiceID" runat="server" Text=""></asp:Label>,&nbsp;&nbsp;Status = <asp:Label ID="lblStatus" runat="server" Text=""></asp:Label>&nbsp;&nbsp;<asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Accounting/Invoice.aspx">Invoice List</asp:HyperLink>
                     &nbsp;<asp:Button ID="Button1" runat="server" 
        onclientclick="openPrintWin();" Text="View/Print" />
&nbsp;<table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th align="left" width="13%">
                            Issue Invoice :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbIssueInvoice" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbIssueInvoiceDate" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                             <th align="left" width="13%">
                                 I/V No. :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbivno" runat="server" MaxLength="10" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    AutoPostBack="true" onload="ddlProj_Load" 
                                    onselectedindexchanged="ddlProj_SelectedIndexChanged" Enabled="False">
                                   <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                           
                            <th align="left" width="13%">
                                WoWi Bank Info :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlwowibankinfo" runat="server" AppendDataBoundItems="True" 
                                    AutoPostBack="true"  Enabled="False" onload="ddlwowibankinfo_Load" >
                                   <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 I/V Date :&nbsp;</th>
                            <td width="20%">
                                 <uc1:DateChooser ID="dcinvdate" runat="server" Enabled="False" />
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Qutation No. : </th>
                            <td width="20%">
                                <asp:Label ID="lblQuotationNo" runat="server" Text=""></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                Model : </th>
                            <td width="20%">
                                <asp:Label ID="lblModel" runat="server" Text=""></asp:Label>
                             </td>
                             <th align="left" width="13%">
                                 Attn&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="lblContact" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Client : </th>
                            <td width="20%">
                                <asp:Label ID="lblClient" runat="server" Text=""></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                Address : </th>
                            <td colspan="3">
                                <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                             </td>
                        </tr>
                 
                          <tr >
                            <td colspan="6"  >
                                <asp:Gridview ID="iGridView2" runat="server"  Width="100%" 
                         AutoGenerateColumns="False" CssClass="Gridview"  
                           SkipColNum="0" ShowFooter="True"  >
                        <Columns>
                       
                            <asp:BoundField DataField="Version" HeaderText="Version" />
                           <%-- <asp:BoundField DataField="Status" HeaderText="Status" />--%>
                            <asp:BoundField DataField="Date" HeaderText="Date" 
                                DataFormatString="{0:yyyy/MM/dd}" />
                            
                            <asp:TemplateField HeaderText="TDescription">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TDescription") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbbankAccount" runat="server" Height="180" Width="480" TextMode="MultiLine" Enabled="false"  ></asp:TextBox>
                                  <%--  <br>
                                    <asp:Label ID="lblmsg" runat="server" Text="Label"></asp:Label>
                                    <br />--%>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("TDescription") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Qty" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"  />
                            <asp:BoundField DataField="UOM" HeaderText="Unit"  ItemStyle-HorizontalAlign="Right" />
                            <asp:TemplateField HeaderText="UnitPrice"  ItemStyle-HorizontalAlign="Right" >
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="F. Price"  ItemStyle-HorizontalAlign="Right" >
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate  >
                                    <table align="right">
                                        <tr>
                                            <td align="right">
                                               <%-- Original Currency : --%> &nbsp;
                                                </td>
                                                <td>
                                             &nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Subtotal before tax : </td>
                                                <td><asp:Label ID="lblOCurrency" runat="server" Text=""></asp:Label>$ <asp:Label ID="lblOTotal" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                (-)Discount : </td>
                                                <td><asp:Label ID="lblOCurrency1" runat="server" Text=""></asp:Label>$ <asp:TextBox ID="tbdiscount" runat="server" Enabled="false"
                                                        AutoPostBack="True" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Total tax : </td>
                                                <td><asp:Label ID="lblOCurrency2" runat="server" Text=""></asp:Label>$ <asp:TextBox ID="tbTax" runat="server" Enabled="false"
                                                        AutoPostBack="True" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Amount due: </td>
                                                <td><asp:Label ID="lblOCurrency3" runat="server" Text=""></asp:Label>$ <asp:Label ID="lblAmountDue" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Currency :</td>
                                                <td>&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlCurrency" runat="server" Enabled="false">
                                    <asp:ListItem>USD</asp:ListItem>
                                    <asp:ListItem>NTD</asp:ListItem>
                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Exchange Rate : </td>
                                                <td>&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddloperate" runat="server" Enabled="false"
                                                        AutoPostBack="True">
                                                    <asp:ListItem>*</asp:ListItem>
                                                    <asp:ListItem>/</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="tbExchangeRate" runat="server" Width="100px" Enabled="false" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Total : </td>
                                                <td>$ <asp:TextBox ID="tbTotal" runat="server"  Enabled="false" ></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblFPrice" runat="server" Text='<%# Bind("FPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill" ItemStyle-HorizontalAlign="Right" >
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbRemarks" runat="server" Height="170px" TextMode="MultiLine" Enabled="false"
                                        Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("Bill") %>'></asp:Label>
                                    &nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Bind("PayType") %>'></asp:Label>
                                    &nbsp;$<asp:Label ID="Label5" runat="server" Text='<%# Bind("PayAmount") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:Gridview>
                             </td>
                        </tr>
                       <%-- <tr align="center">
                            <td align="center"colspan="6"  >
                                
                                <asp:Button ID="BtnAdd" runat="server" Text="Add" onclick="BtnAdd_Click" />
                                
                             </td>
                        </tr>--%>
                              </table>

</asp:Content>

