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
            if (rate == 1)
            {
                rate = 30;
            }
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
                                &nbsp;</th>
                            <td width="20%">
                                &nbsp;</td>
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
                            
                            <asp:BoundField DataField="TDescription" HeaderText="TDescription" />
                            <asp:BoundField DataField="Qty" HeaderText="Qty" />
                            <asp:BoundField DataField="UOM" HeaderText="UOM" />
                            <asp:TemplateField HeaderText="UnitPrice">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="F. Price" >
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblFPrice" runat="server" Text='<%# Bind("FPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                </EditItemTemplate>
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblBill" runat="server" Text='<%# Bind("Bill") %>'></asp:Label>
                                    &nbsp;<asp:Label ID="lblPayType" runat="server" Text='<%# Bind("PayType") %>'></asp:Label>
                                    &nbsp;$<asp:Label ID="lblPayAmount" runat="server" Text='<%# Bind("PayAmount") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
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

