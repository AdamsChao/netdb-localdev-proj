<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>
<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);//invoiceid
            WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == id select i).First();
            
            tbIssueInvoice.Text = invoice.issue_invoice_no;
            tbIssueInvoiceDate.Text = ((DateTime)invoice.issue_invoice_date).ToString("yyyy/MM/dd");
            
            lblProjNo.Text = invoice.project_no;
            SetData(lblProjNo.Text);
            decimal rate = (decimal)invoice.exchange_rate;
            currency = invoice.currency;
            lblCurrency.Text = currency;
            if (invoice.currency == "USD")
            {
                
                lblUSD.Text = "$"+ ((decimal)invoice.final_total).ToString("F2");
                lblUSD.ForeColor = System.Drawing.Color.Blue;
                lblNTD.Text = "$" + ((decimal)invoice.final_total * rate).ToString("F2");
            }
            else
            {
                lblNTD.Text = "$" + ((decimal)invoice.final_total).ToString("F2");
                lblNTD.ForeColor = System.Drawing.Color.Blue;
                lblUSD.Text = "$" + ((decimal)invoice.final_total / rate).ToString("F2");
            }
            GetAllItems(id);
        }

       
        
    }

    protected void SetData(String projNo)
    {
        
        try
        {
            int qid = (from p in db.Project where p.Project_No == projNo select p.Quotation_Id).First();
            QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == qid select d).First();
            lblQuotationNo.Text = quotation.Quotation_No;
            lblModel.Text = quotation.Model_No;
            try
            {

                int sid = (int)quotation.SalesId;
                WoWiModel.employee sales = (from c in wowidb.employees where c.id == sid select c).First();
                lblSales.Text = sales.fname + " " + sales.lname;
                

            }
            catch (Exception)
            {


            }
            try
            {

                int clientid = (int)quotation.Client_Id;
                WoWiModel.clientapplicant client = (from c in wowidb.clientapplicants where c.id == clientid select c).First();
                lblClient.Text = String.IsNullOrEmpty(client.companyname) ? client.c_companyname : client.companyname;
                lblAddress.Text = String.IsNullOrEmpty(client.address) ? client.c_address : client.address;
                int cid = (int)client.country_id;
                WoWiModel.country country = (from cou in wowidb.countries where cou.country_id == cid select cou).First();
                lblCountry.Text = country.country_name;
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

    double tot;
    String currency;
    public string GetTotal()
    {

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%'><tr><td align='right' class='Total'>Currency$Total</td></tr></table>");
        sb.Replace("Total", tot.ToString("F2"));
        sb.Replace("Currency", currency);
        return sb.ToString();
    }

    protected void GetAllItems(int id)
    {
        try
        {
            WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == id select i).First();
            decimal btotal = (decimal)invoice.final_total;
            List<ReceivedData> data = new List<ReceivedData>();
            var list = from rd in wowidb.invoice_received where rd.invoice_id == id select rd;
            ReceivedData temp;
            foreach (var item in list)
            {
                temp = new ReceivedData()
                {
                    InvoiceID = item.id.ToString(),
                    ReceivedDate = (DateTime)item.received_date,
                    Amount = ((decimal)item.amount).ToString("F2"),
                    IVNo = item.iv_no,
                    Note = item.note
                };
                tot += ((double)item.amount);
                btotal -= ((decimal)item.amount);
                temp.Balance = btotal.ToString("F2");
                data.Add(temp);
            }
            invoice.ar_balance = btotal;
            wowidb.SaveChanges();
            iGridView2.DataSource = data;
            iGridView2.DataBind();
        }
        catch (Exception)
        {
            
            //throw;
        }
    }
    protected void btndel_Click(object sender, EventArgs e)
    { 
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);//invoiceid
            try
            {
                WoWiModel.invoice_received recevivedData = new WoWiModel.invoice_received()
                {
                    invoice_id = id,
                    received_date = dcReceivedDate.GetDate(),
                    amount = decimal.Parse(tbAmount.Text),
                    iv_no = tbIVNo.Text,
                    note = tbNote.Text,
                    create_date = DateTime.Now,
                    modify_date = DateTime.Now
                };
                wowidb.invoice_received.AddObject(recevivedData);
                WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == id select i).First();
                invoice.ar_balance -= recevivedData.amount;
                wowidb.SaveChanges();
                dcReceivedDate.ClearText();
                tbAmount.Text= "";
                tbIVNo.Text= "";
                tbNote.Text = "";
            }
            catch (Exception)
            {
                
                //throw;
            }
            GetAllItems(id);
        }
    }

    protected void iGridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyDelete")
        {
            try
            {
                int rid = int.Parse(e.CommandArgument.ToString());
                WoWiModel.invoice_received re = wowidb.invoice_received.First(c => c.id == rid);
                wowidb.invoice_received.DeleteObject(re);
                wowidb.SaveChanges();
                if (!String.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    int id = int.Parse(Request.QueryString["id"]);//invoiceid
                    GetAllItems(id);
                }
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
    Received Information&nbsp;&nbsp;<asp:HyperLink 
                           ID="HyperLink1" runat="server" 
        NavigateUrl="~/Accounting/AR.aspx">AR List</asp:HyperLink>
                     <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th align="left" width="13%">
                            Issue Invoice :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="tbIssueInvoice" runat="server" Enabled="False"></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <asp:Label ID="tbIssueInvoiceDate" runat="server" Enabled="False"></asp:Label>
                            </td>
                             <th align="left" width="13%">
                                 Sales :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="lblSales" runat="server" MaxLength="10"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="lblProjNo" runat="server"></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                Currency : </th>
                            <td width="20%">
                                <asp:Label ID="lblCurrency" runat="server" Text="lblCurrency"></asp:Label>
                            </td>
                             <th align="left" width="13%">
                                Inv USD$. : </th>
                            <td width="20%">
                                <asp:Label ID="lblUSD" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Qutation No. : </th>
                            <td width="20%">
                                <asp:Label ID="lblQuotationNo" runat="server"></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                Model : </th>
                            <td width="20%">
                                <asp:Label ID="lblModel" runat="server" Text=""></asp:Label>
                             </td>
                             <th align="left" width="13%">
                                 Inv NTD$. : </th>
                            <td width="20%">
                                <asp:Label ID="lblNTD" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Client : </th>
                            <td width="20%">
                                <asp:Label ID="lblClient" runat="server" Text=""></asp:Label>
                            </td>
                            <th align="left" width="13%">
                                 Attn&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="lblContact" runat="server" Text=""></asp:Label>
                            </td>
                             <th align="left" width="13%">
                                 Country&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:Label ID="lblCountry" runat="server" Text=""></asp:Label>
                            </td>
                            </tr>
                             <tr>
                          
                            <th align="left" width="13%">
                                Address : </th>
                            <td colspan="5">
                                <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                             </td>
                        </tr>
                 <tr>
                 <td colspan="6" >
                 Received Add
                 <table align="right" border="1" cellpadding="0" cellspacing="0" width="100%">
                  <tr><th></th><th>Received Date</th><th>Amount</th><th>IV/ NO.</th><th>Note</th></tr>
                 <tr>
                     <td><asp:Button ID="Button1" runat="server" Text="+" onclick="Button1_Click" /></td>
                      <td>
                         <uc1:DateChooser ID="dcReceivedDate" runat="server" />
                     </td> <td>
                         $
                         <asp:TextBox ID="tbAmount" runat="server"></asp:TextBox>
                     </td> <td>
                         <asp:TextBox ID="tbIVNo" runat="server" MaxLength="10"></asp:TextBox>
                     </td> <td>
                         <asp:TextBox ID="tbNote" runat="server" Width="300px"></asp:TextBox>
                     </td></tr>
                 </table>
                 </td>
                 </tr>
                          <tr >
                            <td colspan="6"  >
                            Received History
                            <asp:Gridview ID="iGridView2" runat="server"  Width="100%" 
                         AutoGenerateColumns="False" CssClass="Gridview"  ShowFooter="True" 
                                    onrowcommand="iGridView2_RowCommand"  >
                        <Columns>
                       
                            <asp:TemplateField HeaderText="">
                            <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReceivedDate") %>'></asp:TextBox>
                                </EditItemTemplate>

                                <ItemTemplate>
                                <asp:Button ID="btndel" runat="server" Text="-" CommandName="MyDelete"  CommandArgument='<%# Eval("InvoiceID") %>' />
                                    <asp:Label ID="lblinvid" runat="server" CssClass="hidden"
                                        Text='<%# Bind("InvoiceID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Received Date">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReceivedDate") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td align="right">
                                                Total :
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" 
                                        Text='<%# Bind("ReceivedDate", "{0:yyyy/MM/dd}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td align="right">
                                                <asp:Literal ID="Literal1" runat="server" Text="<%# GetTotal()%>"></asp:Literal>
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Balance" HeaderText="Balance" />
                            <asp:BoundField DataField="IVNo" HeaderText="IVNo" />
                            <asp:BoundField DataField="Note" HeaderText="Note" />
                           
                        </Columns>
                    </asp:Gridview>
                             </td>
                        </tr>
                        <tr align="center">
                            <td align="center"colspan="6"  >
      
                                
                             </td>
                        </tr>
                              </table>

</asp:Content>

