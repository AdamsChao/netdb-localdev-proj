<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script  runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    public String Format(String s)
    {
        return ("$"+s.PadLeft(7,'u').Replace("u","&nbsp;"));
    }
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            
            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == id select i).First();
                OTotal = ((decimal)invoice.ototal).ToString("F2");
                OriginalCurrency = invoice.ocurrency;
                PayCurrency = invoice.currency;
                Tax = ((decimal)invoice.tax).ToString("F2");
                AmountDue = ((decimal)invoice.total).ToString("F2");
                ExchangeRate = ((decimal)invoice.exchange_rate).ToString("F2");
                Total = ((decimal)invoice.final_total).ToString("F2");
                Adjust = ((decimal)invoice.adjust).ToString("F2");
                lblInvoiceNo.Text = "#"+invoice.invoice_no;
                lblInvoiceDate.Text = ((DateTime)invoice.issue_invoice_date).ToString("yyyy/MM/dd");
                OTotal = Format(OTotal);
                Tax = Format(Tax);
                AmountDue = Format(AmountDue);
                Total = PayCurrency+Format(Total);
               
                String pNo = invoice.project_no;
                var pro = (from p in db.Project where p.Project_No == pNo select p).First();

                

                try
                {
                    int qid = pro.Quotation_Id;
                    QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == qid select d).First();
                    lblModelNo.Text = quotation.Model_No;
                    int clientid = (int)quotation.Client_Id;
                    WoWiModel.clientapplicant client = (from c in wowidb.clientapplicants where c.id == clientid select c).First();
                    lblName.Text = String.IsNullOrEmpty(client.companyname) ? client.c_companyname : client.companyname;
                    lblAddress.Text = String.IsNullOrEmpty(client.address) ? client.c_address : client.address;
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
                            contactid = (from c in wowidb.m_clientappliant_contact where c.clientappliant_id == quotation.Client_Id select c.contact_id).First();
                        }
                        contact = (from c in wowidb.contact_info where c.id == contactid select c).First();
                        lblContact.Text = String.IsNullOrEmpty(contact.fname) ? contact.c_lname + " " + contact.c_fname : contact.fname + " " + contact.lname;
                        lblContactEmail.Text = contact.email;
                        lblContactPhone.Text = contact.workphone;
                    }
                    catch (Exception)
                    {


                    }
                }
                catch (Exception)
                {


                }

                List<ProjectInvoiceData> items = new List<ProjectInvoiceData>();
                ProjectInvoiceData temp;

                var targets = from c in wowidb.invoice_target where c.invoice_id == id select c;
                foreach (var i in targets)
                {
                    temp = new ProjectInvoiceData()
                    {
                      
                        FPrice = (decimal)i.amount,
                        PayAmount = i.amount + ""
                    };
                    int tid = i.quotation_target_id;
                    var quoTarget = (from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid select qt).First();
                    temp.Bill = quoTarget.Bill;
                    temp.Status = quoTarget.Status;
                    temp.TDescription = quoTarget.target_description;
                    temp.Qty = (double)quoTarget.unit;
                    temp.UnitPrice = (decimal)quoTarget.unit_price;
                    int quoid = (int)quoTarget.quotation_id;
                    var quo = (from q in db.Quotation_Version where q.Quotation_Version_Id == quoid select q).First();
                    temp.VersionNo = (int)quo.Vername;
                    temp.Date = (DateTime)quo.create_date;
                    if (i.bill_status == (byte)InvoicePaymentStatus.PrePaid1)
                    {
                        temp.PayType = "PrePayment";
                    }
                    else
                    {
                        temp.PayType = "FinalPayment";
                    }
                    items.Add(temp);
                }

                iGridView.DataSource = items;
                iGridView.DataBind();
            
            }
            catch
            {
            }
            
           
        }

    }
    String OTotal, Tax, OriginalCurrency, AmountDue, ExchangeRate, PayCurrency, Total, Adjust;
    public string GetPrice()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table align='right'><tr><td align='right'>Original Currency</td></tr>" +
                                    "<tr><td align='right'>OTotal</td></tr><tr><td align='right'>" +
                                            "Tax</td></tr><tr><td align='right'>" +
                                            "Amount Due</td></tr><tr><td align='right'>" +
                                            "Pay Currency</td></tr><tr><td align='right'>" +
                                            "Exchange Rate</td></tr><tr><td align='right'>" +
                                            //"Adjust</td></tr><tr><td align='right'>" +
                                            "<u>Total</u></td></td></tr></table>");
        sb.Replace("OTotal", OTotal);
        sb.Replace("Tax", Tax);
        sb.Replace("Original Currency",OriginalCurrency);
        sb.Replace("Amount Due", AmountDue);
        sb.Replace("Exchange Rate", ExchangeRate);
        sb.Replace("Pay Currency", PayCurrency);
        sb.Replace("Adjust", Adjust);
        sb.Replace("Total", Total);
        return sb.ToString();
    }
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .CCSTextBoxH
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 7pt;
            font-weight: 600;
        }
        .CCSH1
        {
            font-style: normal;
            font-family: Times New Roman;
            color: rgb(0,0,0);
            font-size: 14pt;
            font-weight: 700;
        }
        .CCSTextH
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 500;
        }
        .CCSItemText
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 7pt;
        }
        B
        {
            font-weight: bold;
        }
        .CCSTextBoxRD
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #dddddd;
            font-size: 9pt;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
 
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left">
                <img border="0" height="90" src="../Images/Quotation/WoWilogoname.jpg" />
            </td>
            <td align="middle" class="ccsh1">
                <font face="verdana" size="3">WoWi Approval Services Inc.</font><br />
                <font face="verdana" size="1">3F., No.79, Zhouzi St., Neihu Dist.,<br />
                    Taipei City 114, Taiwan (R.O.C.)<br />
                    T: 886-2-2799-8382 &nbsp; F: 886-2-2799-8387<br />
                    Http://www.WoWiApproval.com</font>
            </td>
            <td align="right">
            <p>
                &nbsp;</p>
                <img border="0" height="56" src="../Images/Quotation/transparent.gif" width="168" />
            </td>
        </tr>
         <tr>
                        <td colspan="3">
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                Invoice
                <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
   
        <tr>
            <td class="ccstextboxh" valign="top">
               <u>Client Infomation </u><br />
                Name:
                <asp:Label ID="lblName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address:
                    <asp:Label ID="lblAddress" runat="server" Text="lblAddress"></asp:Label></p>
                <p>
                    Model No.:
                    <asp:Label ID="lblModelNo" runat="server" Text="lblModelNo"></asp:Label></p>
            </td>
            <td align="right" class="ccstextboxh">
                <table border="0" cellpadding="0" cellspacing="0">
                 <tr>
                        <td align="left" class="ccstextboxh" colspan="2">
                            Date :                     <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label>
                    </td></tr>
                    <tr>
                        <td align="left" class="ccstextboxh" colspan="2">
                            <nobr>
                            <u>Contact Information</u></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Contact:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblContact" runat="server" Text="lblContact"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Phone:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblContactPhone" runat="server" Text="lblClientPhone"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Email:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblContactEmail" runat="server" Text="lblClientEmail"></asp:Label>
                        </td>
                    </tr>
                    <caption>
                        &nbsp;</caption>
            </td>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                <br />
                            </td>
            </tr>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <!-- start target -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <asp:Gridview ID="iGridView" runat="server"  Width="100%" 
                         AutoGenerateColumns="False" CssClass="Gridview"  
                         ShowFooter="True"  >
                        <Columns>
                       
                            <asp:BoundField DataField="TDescription" HeaderText="TDescription" />
                            <asp:BoundField DataField="Qty" HeaderText="Qty" />
                          <%--  <asp:BoundField DataField="UOM" HeaderText="UOM" />--%>
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
                               <FooterTemplate  >
                                    <table align='right'>
                                        <tr>
                                            <td align='right'>
                                                Original Currency : 
                                                </td>
                                             
                                        </tr>
                                        <tr>
                                             <td align='right'>
                                                Total : </td>
                                              
                                        </tr>
                                        <tr>
                                             <td align='right'>
                                                Tax : </td>
                                            
                                        </tr>
                                        <tr>
                                            <td align='right'>
                                                Amount Due : </td>
                                             
                                        </tr>
                                        <tr>
                                             <td align='right'>
                                                Pay Currency :</td>
                                               
                                        </tr>
                                        <tr>
                                             <td align='right'>
                                                Exchange Rate : </td>
                                             
                                        </tr>
                                        <%--<tr>
                                             <td align='right'>
                                              Adj. </td>
                                             
                                        </tr>--%>
                                        <tr>
                                            <td align='right'>
                                                Total : </td>
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <ItemTemplate>
                                   <asp:Label ID="lblPayType" runat="server" Text='<%# Bind("PayType") %>'></asp:Label>
                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill Amount">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                       <asp:Literal ID="Literal1" runat="server" Text="<%# GetPrice()%>"></asp:Literal>
                                </FooterTemplate>
                                <ItemTemplate>
                                    &nbsp;$<asp:Label ID="lblPayAmount" runat="server" Text='<%# Bind("PayAmount") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:Gridview>
                         
                        </td>
                    </tr>
                </table>
                <!-- end target -->
            </td>
        </tr>
        <!-- end cost summary service -->
    </table>
    <p style="page-break-before: always">
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="ccstextboxh" colspan="2" width="100%">
                    <hr />
                </td>
            </tr>
          
            <tr>
                <td colspan="2" width="100%">
                    &nbsp;
                </td>
            </tr>
           
        </table>
        <!-- end body -->
    </p>
   
   
     </form>
</body>
</html>
