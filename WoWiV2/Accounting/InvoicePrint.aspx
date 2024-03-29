﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Assembly="iServerControls" Namespace="iControls.Web" TagPrefix="cc1" %>
<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    static String Prepayment1 = "Prepayment1";
    static String Prepayment2 = "Prepayment2";
    static String Prepayment3 = "Prepayment3";
    static String Finalpayment = "Finalpayment";
    public String Format(String s)
    {
        return ("$" + s.PadLeft(7, 'u').Replace("u", "&nbsp;"));
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {

            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                int aid = Math.Abs(id);
                WoWiModel.invoice invoice = (from i in wowidb.invoices where i.invoice_id == aid select i).First();
                OTotal = ((decimal)invoice.ototal).ToString("N2");
                OriginalCurrency = invoice.ocurrency;
                PayCurrency = invoice.currency;
                Tax = ((decimal)invoice.tax).ToString("N2");
                AmountDue = ((decimal)invoice.total).ToString("N2");
                ExchangeRate = ((decimal)invoice.exchange_rate).ToString("N2");
                Total = ((decimal)invoice.final_total).ToString("N2");
                Adjust = ((decimal)invoice.adjust).ToString("N2");
                lblInvNo.Text = invoice.issue_invoice_no;
                lblDate.Text = ((DateTime)invoice.issue_invoice_date).ToString("yyyy/MM/dd");
                Tax = Format(Tax);
                AmountDue = Format(AmountDue);
                lblOCurrency.Text = invoice.ocurrency;
                lblOCurrency1.Text = invoice.ocurrency;
                lblOCurrency2.Text = invoice.ocurrency;
                lblOTotal.Text = OTotal;
                if (invoice.adjust != 0)
                {
                    DisPanel.Visible = true;
                    lblOCurrency3.Text = invoice.ocurrency;
                    lblDiscount.Text = ((decimal)invoice.adjust).ToString("N2");
                }
                else
                {
                    DisPanel.Visible = false;
                }
                tbTax.Text = ((decimal)invoice.tax).ToString("N2");
                lblAmountDue.Text = ((decimal)invoice.total).ToString("N2");
                //tbbankAcct.Text = InvoiceUtils.WoWi_Bank_Info1;                
                //lblbankAcct.Text = Regex.Replace(InvoiceUtils.WoWi_Bank_Info1, "[\r\n\t]", "<br/>", RegexOptions.IgnoreCase); 

                Total = PayCurrency + Format(Total);

                String pNo = invoice.project_no;
                lblprojno.Text = pNo;
                var pro = (from p in db.Project where p.Project_No == pNo select p).First();
                //修改抓取quotation_id要從invoice_target才正確 by Adams 2013/7/3
                var invoice_target = (from t in db.invoice_target where t.invoice_id == invoice.invoice_id select t).FirstOrDefault();
                try
                {
                    int qid = invoice_target.quotation_id;
                    QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == qid select d).First();
                    lblmodelno.Text = quotation.Model_No;
                    lblpono.Text = quotation.pocheckno;
                    lblquono.Text = quotation.Quotation_No;
                    lblBillName.Text = quotation.Bill_Companyname;
                    lblBillAddress.Text = quotation.Bill_Address;
                    lblBillCountry.Text = quotation.Bill_Country;
                    lblBillContact.Text = quotation.Bill_Name;
                    int sid = (int)quotation.SalesId;
                    try
                    {
                        WoWiModel.employee se = wowidb.employees.First(c => c.id == sid);
                        lblSales.Text = se.fname + " " + se.lname;//String.IsNullOrEmpty(se.fname) ? se.c_lname + " " + se.c_fname : se.fname + " " + se.lname;
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    int clientid = (int)quotation.Client_Id;
                    WoWiModel.clientapplicant client = (from c in wowidb.clientapplicants where c.id == clientid select c).First();
                    lblName.Text = String.IsNullOrEmpty(client.companyname) ? client.c_companyname : client.companyname;
                    //lblBillName.Text = String.IsNullOrEmpty(client.bill_companyname) ? client.bill_ccompanyname : client.bill_companyname;
                    lblAddress.Text = String.IsNullOrEmpty(client.address) ? client.c_address : client.address;
                    var countryname = wowidb.countries.Where(c => c.country_id == client.country_id).FirstOrDefault().country_name;
                    lblCountry.Text = countryname;
                    //lblBillAddress.Text = String.IsNullOrEmpty(client.bill_address) ? client.bill_caddress : client.bill_address;
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
                        //lblBillContact.Text = String.IsNullOrEmpty(client.bill_firstname) ? client.c_bill_lastname + " " + client.c_bill_firstname : client.bill_firstname + " " + client.bill_lastname;
                        //lblContactEmail.Text = contact.email;
                        //lblContactPhone.Text = contact.workphone;
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
                    tid = Math.Abs(tid);
                    var quoTarget = (from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid select qt).First();
                    temp.Bill = quoTarget.Bill;
                    temp.Status = quoTarget.Status;
                    temp.TDescription = quoTarget.target_description;
                    temp.Qty = (double)quoTarget.unit;
                    temp.UnitPrice = (decimal)quoTarget.unit_price;
                    if (quoTarget.unit.HasValue)
                    {
                        temp.UOM = ((double)quoTarget.unit).ToString("F0");
                    }
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
                        temp.PayType = Finalpayment;
                    }
                    items.Add(temp);
                }

                iGridView.DataSource = items;
                iGridView.DataBind();

                try
                {

                    int bid = (int)invoice.bankacct_info_id;

                    WoWiModel.wowi_bankinfo b = wowidb.wowi_bankinfo.First(c => c.id == bid);
                    //lblbankAcct.Text = b.info;                    
                    //lblbankAcct.Text = Regex.Replace(b.info, "[\r\n\t]", "<br/>", RegexOptions.IgnoreCase);
                    lblbankAcct.Text = Regex.Replace(b.info, "[\r\n\t]", "<p/>", RegexOptions.IgnoreCase);
                }
                catch (Exception)
                {

                    //throw;
                }
                try
                {
                    String f;
                    WoWiModel.employee emp =
                        (from e1 in wowidb.employees
                         from j in wowidb.employee_jobtitle
                         from d in wowidb.m_employee_accesslevel
                         from a in wowidb.access_level
                         where e1.id == d.employee_id & d.accesslevel_id == a.id
                         & e1.jobtitle_id == j.jobtitle_id & a.name == "Accounting"
                         & (j.jobtitle_name == "Accounting" || j.jobtitle_name == "Finance")
                         select e1).First();
                    f = emp.fname.Trim() + "." + emp.lname.Trim();
                    imgF.ImageUrl = "../Images/sign/" + f + ".bmp";
                }
                catch (Exception)
                {
                    //throw;
                }
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
        sb.Replace("Original Currency", OriginalCurrency);
        sb.Replace("Amount Due", AmountDue);
        sb.Replace("Exchange Rate", ExchangeRate);
        sb.Replace("Pay Currency", PayCurrency);
        sb.Replace("Adjust", Adjust);
        sb.Replace("Total", Total);
        return sb.ToString();
    }
    int counter = 0;
    protected void iGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            counter += 1;
            //Label lblbr = (Label)e.Row.FindControl("lblbr");
            if (counter == 32 || counter == 80)
            {
                GridViewRow gv_row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Normal);
                TableCell tc = new TableCell();
                tc.Text = @"<div style='page-break-before: always' />";
                tc.ColumnSpan = 6;
                gv_row.Cells.Add(tc);
                e.Row.Parent.Controls.AddAt(counter + 1, gv_row);
            }
        }
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
            font-family: Verdana, Arial, Helvetica, sans-serif;
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
        .noscrollBar
        {
            overflow-y: hidden;
            font-style: normal;
            font-size: 9pt;
            font-weight: bold;
        }
        .TotalPrice
        {
            font-style: normal;
            font-size: 8pt;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="left">
                <img border="0" height="90" src="../Images/Quotation/WoWilogoname.jpg" />
            </td>
            <td align="right" valign="top" width="35%">
            </td>
            <td align="right" class="ccsh1">
                <font face="verdana" size="1">3F., No.79, Zhouzi St., Neihu Dist.,<br />
                    Taipei City 114, Taiwan (R.O.C.)<br />
                    T: 886-2-2799-8382 &nbsp; F: 886-2-2799-8387<br />
                    Http://www.WoWiApproval.com<br />
                    <p />
                    <b>Number:<asp:Label ID="lblInvNo" runat="server"></asp:Label></b><br />
                    <b>Date:<asp:Label ID="lblDate" runat="server" Text="lblDate"></asp:Label></b>
                </font>
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                <h2>
                    INVOICE</h2>
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                <br />
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td valign="top" style="height: 130px;">
                <b><u>Bill Information </u></b>
                <br />
                Name :
                <asp:Label ID="lblBillName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address :
                    <asp:Label ID="lblBillAddress" runat="server" ></asp:Label>&nbsp;<asp:Label 
                      ID="lblBillCountry" runat="server" ></asp:Label></p>
                <p>
                    Contact :
                    <asp:Label ID="lblBillContact" runat="server" Text="lblContact"></asp:Label></p>
            </td>
            <td style="width: 20px;">
            </td>
            <td valign="top" style="height: 130px;">
                <b><u>Client Information </u></b>
                <br />
                Name :
                <asp:Label ID="lblName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address :
                    <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    &nbsp;<asp:Label ID="lblCountry" runat="server"></asp:Label></p>
                <p>
                    Contact :
                    <asp:Label ID="lblContact" runat="server" Text="lblContact"></asp:Label></p>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" style="font-size: small;
                    border-style: solid; border-width: 1px;">
                    <tr>
                        <th width="20%">
                            Reference - P.O. #
                        </th>
                        <th width="20%">
                            Sales Person
                        </th>
                        <th width="20%">
                            WoWi Quotation No.
                        </th>
                        <th width="20%">
                            WoWi Project No.
                        </th>
                        <th width="20%">
                            Model No.
                        </th>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Label ID="lblpono" runat="server" Text="Label" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblSales" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblquono" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblprojno" runat="server" Text="Label"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblmodelno" runat="server" Text="Label"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
            </td>
        </tr>
        <tr>
            <td colspan="3">
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <!-- start target -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td colspan="2">
                            <cc1:iRowSpanGridView ID="iGridView" runat="server" Width="100%" AutoGenerateColumns="False"
                                ShowFooter="False" Font-Size="Small" OnRowDataBound="iGridView_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Description/Comments">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TDescription") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="tbbankAccount" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("TDescription") %>'></asp:Label>
                                            <%--<asp:Label ID="lblbr" runat="server"></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty" ItemStyle-HorizontalAlign="Right">
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="UOM" HeaderText="Unit" ItemStyle-HorizontalAlign="Right">
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Unit Price" ItemStyle-HorizontalAlign="Right">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="F. Price" >
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblFPrice" runat="server" Text='<%# Bind("FPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Bill" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <table align='right'>
                                                <tr>
                                                    <td align='right'>
                                                        Original Currency :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Subtotal before tax :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Total tax :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Amount Due :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Currency :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Exchange Rate :
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align='right'>
                                                        Total :
                                                    </td>
                                                    </td>
                                                </tr>
                                            </table>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPayType" runat="server" Text='<%# Bind("PayType") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:Literal ID="Literal1" runat="server" Text="<%# GetPrice()%>"></asp:Literal>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            &nbsp;$<asp:Label ID="lblPayAmount" runat="server" Text='<%# Bind("PayAmount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </asp:TemplateField>
                                </Columns>
                            </cc1:iRowSpanGridView>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 65%" valign="top">
                            <asp:Label ID="lblbankAcct" runat="server" Font-Size="10pt"></asp:Label>
                        </td>
                        <td style="width: 35%; font-size: x-small;" valign="top">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size: small"
                                class="TotalPrice">
                                <tr>
                                    <td align="right">
                                        Subtotal before tax :
                                    </td>
                                    <td>
                                        <asp:Label ID="lblOCurrency" runat="server" Text="" />$
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="lblOTotal" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <asp:Panel ID="DisPanel" runat="server">
                                    <tr>
                                        <td align="right">
                                            (-) Discount :
                                        </td>
                                        <td>
                                            <asp:Label ID="lblOCurrency3" runat="server" Text="" />$
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblDiscount" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </asp:Panel>
                                <tr>
                                    <td align="right">
                                        Total tax :
                                    </td>
                                    <td>
                                        <asp:Label ID="lblOCurrency1" runat="server" Text="" />$
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="tbTax" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Amount due :
                                    </td>
                                    <td>
                                        <asp:Label ID="lblOCurrency2" runat="server" Text="" />$
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="lblAmountDue" runat="server" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="3">
                                        &nbsp
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="3">
                                        &nbsp
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="3">
                                        &nbsp
                                    </td>
                                </tr>
                                <tr>
                                    <td class="ccstextboxh" align="center" colspan="2">
                                        Issued by Accounting
                                        <p />
                                        <asp:Image ID="imgF" runat="server" Height="31" Width="114" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <!-- end target -->
            </td>
        </tr>
        <!-- end cost summary service -->
    </table>
    </form>
</body>
</html>
