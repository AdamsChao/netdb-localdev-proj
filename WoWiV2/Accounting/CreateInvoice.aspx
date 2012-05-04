<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    static String Prepayment1 = "預收1";
    static String Prepayment2 = "預收2";
    static String Prepayment3 = "預收3";
    static String Finalpayment = "尾款";
    protected void Page_Load(object sender, EventArgs e)
    {
        int sid = 1;
        try
        {
            var list = from c in wowidb.invoices where ((DateTime)c.create_date).Month == DateTime.Now.Month select c.issue_invoice_no;
            sid = list.Count() + 1;
        }
        catch (Exception)
        {
            
            
        }
        tbIssueInvoice.Text = String.Format("W{0}{1}", DateTime.Now.ToString("yyyyMM"), sid.ToString().PadLeft(3,'0'));
        dcissueinvdate.setText( DateTime.Now.ToString("yyyy/MM/dd"));
    }

    protected void ddlProj_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = db.Project;
        (sender as DropDownList).DataTextField = "Project_No";
        (sender as DropDownList).DataValueField = "Quotation_Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlProj_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int quoid = int.Parse((sender as DropDownList).SelectedValue);
            QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == quoid select d).First();
            lblQuotationNo.Text = quotation.Quotation_No;
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
            GetAllItems(quotation.Quotation_No);
            try
            {
                (iGridView2.FooterRow.FindControl("lblOCurrency") as Label).Text = quotation.Currency;
                (iGridView2.FooterRow.FindControl("lblOCurrency1") as Label).Text = quotation.Currency;
                (iGridView2.FooterRow.FindControl("lblOCurrency2") as Label).Text = quotation.Currency;
                (iGridView2.FooterRow.FindControl("lblOCurrency3") as Label).Text = quotation.Currency;
           
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
    decimal total = 0; 
    private void GetAllItems(String no)
    {
        try
        {
            var qnos = from q in db.Quotation_Version where q.Quotation_No == no select q;
            var item = from qt in db.Quotation_Target
                       from qu in qnos
                       where qt.quotation_id == qu.Quotation_Version_Id && (qt.PR_Flag == "1" || qt.PR_Flag == "2" || qt.PR_Flag == "3" || qt.PR_Flag == "E")
                       select new 
                       {
                           tid = qt.Quotation_Target_Id,
                           qId = qu.Quotation_Version_Id,
                           No = no,
                           VersionNo = (int)qu.Vername, 
                           Status = qt.Status,
                           Date = (DateTime)qu.create_date,
                           TDescription = qt.target_description,
                           Qty = (double)qt.unit,
                           UnitPrice = (decimal)qt.unit_price,
                           FPrice = (decimal)qt.FinalPrice,
                           Bill = qt.Bill,
                           Bill1 = qt.Bill1,
                           Bill2 = qt.Bill2,
                           Bill3 = qt.Bill3,
                           BillE = qt.BillE,
                           Unit = qt.unit,
                           PrePayment = qt.advance2,
                           FinalPayment = qt.balance2,
                           Qutation_Target_Id = qt.Quotation_Target_Id,
                           PR_Flag = qt.PR_Flag
                       };
            List<ProjectInvoiceData> items = new List<ProjectInvoiceData>();
            ProjectInvoiceData temp;
            total = 0; 
            foreach (var i in item)
            {

                
                if (i.PR_Flag == "1" )
                {
                    if (i.Bill1.HasValue && (decimal)i.Bill1 != 0)
                    {
                        try
                        {
                            var invoiceTarget = from it in wowidb.invoice_target where it.quotation_target_id == i.tid && it.bill_status == (byte)InvoicePaymentStatus.PrePaid1 select it;
                            if (invoiceTarget.Count() != 0)
                            {
                                continue;
                            }
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                        temp = new ProjectInvoiceData()
                        {
                            No = no,
                            VersionNo = i.VersionNo,
                            Status = i.Status,
                            Date = i.Date,
                            TDescription = i.TDescription,
                            Qty = i.Qty,
                            UnitPrice = i.UnitPrice,
                            FPrice = (decimal)i.Qty * i.UnitPrice,
                            Bill = ((decimal)i.Bill1).ToString("F0"),
                            PayType = Prepayment1,
                            UOM = ((double)i.Unit).ToString("F0"),
                            PayAmount = i.Bill1.ToString(),
                            Qutation_Target_Id = i.Qutation_Target_Id,
                            Qutation_Id = i.qId,
                        };
                        total += (decimal)i.Bill1;
                        items.Add(temp);
                    }
                }
                else if (i.PR_Flag == "2")
                {
                    if (i.Bill2.HasValue && (decimal)i.Bill2 != 0)
                    {
                        try
                        {
                            var invoiceTarget = from it in wowidb.invoice_target where it.quotation_target_id == i.tid && it.bill_status == (byte)InvoicePaymentStatus.PrePaid2 select it;
                            if (invoiceTarget.Count() != 0)
                            {
                                continue;
                            }
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                        temp = new ProjectInvoiceData()
                        {
                            No = no,
                            VersionNo = i.VersionNo,
                            Status = i.Status,
                            Date = i.Date,
                            TDescription = i.TDescription,
                            Qty = i.Qty,
                            UnitPrice = i.UnitPrice,
                            FPrice = (decimal)i.Qty * i.UnitPrice,
                            Bill = ((decimal)i.Bill2).ToString("F0"),
                            PayType = Prepayment2,
                            UOM = ((double)i.Unit).ToString("F0"),
                            PayAmount = i.Bill2.ToString(),
                            Qutation_Target_Id = i.Qutation_Target_Id,
                            Qutation_Id = i.qId
                        };
                        total += (decimal)i.Bill2;
                        items.Add(temp);
                    }
                }
                else if (i.PR_Flag == "3")
                {
                    if (i.Bill3.HasValue && (decimal)i.Bill3 != 0)
                    {
                        try
                        {
                            var invoiceTarget = from it in wowidb.invoice_target where it.quotation_target_id == i.tid && it.bill_status == (byte)InvoicePaymentStatus.PrePaid3 select it;
                            if (invoiceTarget.Count() != 0)
                            {
                                continue;
                            }
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                        temp = new ProjectInvoiceData()
                        {
                            No = no,
                            VersionNo = i.VersionNo,
                            Status = i.Status,
                            Date = i.Date,
                            TDescription = i.TDescription,
                            Qty = i.Qty,
                            UnitPrice = i.UnitPrice,
                            FPrice = (decimal)i.Qty * i.UnitPrice,
                            Bill = ((decimal)i.Bill3).ToString("F0"),
                            PayType = Prepayment3,
                            UOM = ((double)i.Unit).ToString("F0"),
                            PayAmount = i.Bill3.ToString(),
                            Qutation_Target_Id = i.Qutation_Target_Id,
                            Qutation_Id = i.qId
                        };
                        total += (decimal)i.Bill3;
                        items.Add(temp);
                    }
                }
                else if (i.PR_Flag == "E")
                {
                    if (i.BillE.HasValue && (decimal)i.BillE != 0)
                    {
                        try
                        {
                            var invoiceTarget = from it in wowidb.invoice_target where it.quotation_target_id == i.tid && it.bill_status == (byte)InvoicePaymentStatus.FinalPaid select it;
                            if (invoiceTarget.Count() != 0)
                            {
                                continue;
                            }
                        }
                        catch (Exception)
                        {
                            continue;
                        }
                        temp = new ProjectInvoiceData()
                        {
                            No = no,
                            VersionNo = i.VersionNo,
                            Status = i.Status,
                            Date = i.Date,
                            TDescription = i.TDescription,
                            Qty = i.Qty,
                            UnitPrice = i.UnitPrice,
                            FPrice = (decimal)i.Qty * i.UnitPrice,
                            Bill = ((decimal)i.BillE).ToString("F0"),
                            PayType = Finalpayment+ "&nbsp;" + "&nbsp;",
                            PayAmount = i.BillE.ToString(),
                            Qutation_Target_Id = i.Qutation_Target_Id,
                            Qutation_Id = i.qId
                        };
                        total += (decimal)i.BillE;
                        items.Add(temp);
                    }
                    //else
                    //{
                    //    temp = new ProjectInvoiceData()
                    //    {
                    //        No = no,
                    //        VersionNo = i.VersionNo,
                    //        Status = i.Status,
                    //        Date = i.Date,
                    //        TDescription = i.TDescription,
                    //        Qty = i.Qty,
                    //        UnitPrice = i.UnitPrice,
                    //        FPrice = (decimal)i.Qty * i.UnitPrice,
                    //        Bill = i.Bill,
                    //        PayType = "FinalPayment",
                    //        PayAmount = i.FPrice.ToString(),
                    //        Qutation_Target_Id = i.Qutation_Target_Id,
                    //        Qutation_Id = i.qId
                    //    };
                    //    total += decimal.Parse(temp.PayAmount);
                    //    items.Add(temp);
                    //}
                }
            }

            iGridView2.DataSource = items;
            iGridView2.DataBind();
            try
            {
                (iGridView2.FooterRow.FindControl("lblOTotal") as Label).Text = total.ToString("F2");
                (iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text = total.ToString("F2");
                (iGridView2.FooterRow.FindControl("tbTotal") as TextBox).Text = total.ToString("F2");
            }
            catch (Exception)
            {
                
                //throw;
            }
            
            try
            {
                (iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = "";
                int id = int.Parse(ddlwowibankinfo.SelectedValue);
                WoWiModel.wowi_bankinfo b = wowidb.wowi_bankinfo.First(c => c.id == id);
                (iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = b.info;
            }
            catch (Exception)
            {

                //throw;
            }
        }
        catch (Exception ex)
        {

            //throw ex;
        }
       
        
    }

    protected void delBtn_Click(object sender, EventArgs e)
    {
        List<int> removeList = new List<int>();
        int rowIndex = 0;
        decimal tot = 0;
        foreach (GridViewRow row in iGridView2.Rows)
        {

            if ((row.FindControl("cbDel") as CheckBox).Checked)
            {
                
                removeList.Add(rowIndex);
                row.Visible = false;
            }
            else
            {
                tot += decimal.Parse((row.FindControl("lblPayAmount") as Label).Text);
            }
            rowIndex++;
        }

        (iGridView2.FooterRow.FindControl("lblOTotal") as Label).Text = tot.ToString("F2");
        tbTax_TextChanged(iGridView2.FooterRow.FindControl("tbTax") as TextBox, null);
        tbExchangeRate_TextChanged(iGridView2.FooterRow.FindControl("tbExchangeRate") as TextBox, null);
    }

    protected void tbTax_TextChanged(object sender, EventArgs e)
    {
        String str = (iGridView2.FooterRow.FindControl("lblOTotal") as Label).Text;
        decimal d = decimal.Parse(str);
        try
        {

            TextBox tb = (iGridView2.FooterRow.FindControl("tbTax") as TextBox);
            d += decimal.Parse(tb.Text);  
        }
        catch (Exception)
        {
            
            //throw;
        }
        try
        {

            TextBox tb = (iGridView2.FooterRow.FindControl("tbdiscount") as TextBox);
            d -= decimal.Parse(tb.Text);
        }
        catch (Exception)
        {

            //throw;
        }
        (iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text = d.ToString("F2");
        (iGridView2.FooterRow.FindControl("tbTotal") as TextBox).Text = d.ToString("F2");
        tbExchangeRate_TextChanged(iGridView2.FooterRow.FindControl("tbExchangeRate") as TextBox, null);
    }


   
    protected void ddloperate_SelectedIndexChanged(object sender, EventArgs e)
    {
        decimal rate = 1;
        try
        {
            TextBox tb = (iGridView2.FooterRow.FindControl("tbExchangeRate") as TextBox);
            rate = decimal.Parse(tb.Text);
        }
        catch (Exception)
        {
            
            //throw;
        }
        TextBox tbTotal = (iGridView2.FooterRow.FindControl("tbTotal") as TextBox);
        decimal tot = decimal.Parse((iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text);
        if ((sender as DropDownList).SelectedValue == "*")
        {
            tot *= rate;
        }
        else
        {
            tot /= rate;
        }
        tbTotal.Text = tot.ToString("F2");
    }

    protected void tbExchangeRate_TextChanged(object sender, EventArgs e)
    {
        decimal rate = 1;
        try
        {
            TextBox tb = (sender as TextBox);
            rate = decimal.Parse(tb.Text);
        }
        catch (Exception)
        {

            //throw;
        }
        TextBox tbTotal = (iGridView2.FooterRow.FindControl("tbTotal") as TextBox);
        decimal tot = decimal.Parse((iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text);
        if ((iGridView2.FooterRow.FindControl("ddloperate") as DropDownList).SelectedValue == "*")
        {
            tot *= rate;
        }
        else
        {
            tot /= rate;
        }
        tbTotal.Text = tot.ToString("F2");
    }

    protected void BtnAdd_Click(object sender, EventArgs e)
    {
        try
        {

            WoWiModel.invoice invoice = new WoWiModel.invoice()
            {
                
                issue_invoice_no = tbIssueInvoice.Text,
                invoice_no = tbivno.Text,
                project_no = ddlProj.SelectedItem.Text,
                quotaion_no = lblQuotationNo.Text,
                ocurrency = (iGridView2.FooterRow.FindControl("lblOCurrency") as Label).Text,
                ototal = decimal.Parse((iGridView2.FooterRow.FindControl("lblOTotal") as Label).Text),
                exchange_operate = (iGridView2.FooterRow.FindControl("ddloperate") as DropDownList).SelectedValue,
                create_date= DateTime.Now,
                create_user = User.Identity.Name,
                status = (byte)InvoicePaymentStatus.Init
            };
            try
            {
                invoice.bankacct_info_id = int.Parse(ddlwowibankinfo.SelectedValue);
            }
            catch (Exception)
            {
                
                //throw;
            }
            try
            {
                invoice.invoice_date = dcinvdate.GetDate();
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                invoice.issue_invoice_date = dcissueinvdate.GetDate();
            }
            catch (Exception)
            {

                //throw;
            }
            try
            {
                
                invoice.total = decimal.Parse((iGridView2.FooterRow.FindControl("lblAmountDue") as Label).Text);
                invoice.final_total = decimal.Parse((iGridView2.FooterRow.FindControl("tbTotal") as TextBox).Text);
                invoice.ar_balance = invoice.final_total;
                invoice.adjust = invoice.final_total - (decimal)invoice.total;
            }
            catch (Exception)
            {
                
                //throw;
            }
            String exchangeRate = (iGridView2.FooterRow.FindControl("tbExchangeRate") as TextBox).Text;
            if (String.IsNullOrEmpty(exchangeRate))
            {
                invoice.exchange_rate = 1;
            }
            else
            {
                invoice.exchange_rate = decimal.Parse(exchangeRate);
            }

            String currency = (iGridView2.FooterRow.FindControl("ddlCurrency") as DropDownList).SelectedValue;
            if (String.IsNullOrEmpty(currency))
            {
                invoice.currency = invoice.ocurrency;
            }
            else
            {
                invoice.currency = currency;
            }

            String tax = (iGridView2.FooterRow.FindControl("tbtax") as TextBox).Text;
            if (String.IsNullOrEmpty(tax))
            {
                invoice.tax = 0;
            }
            else
            {
                try
                {
                    invoice.tax = decimal.Parse(tax); ;
                }
                catch (Exception)
                {

                    invoice.tax = 0;
                }
               
            }

            String discount = (iGridView2.FooterRow.FindControl("tbdiscount") as TextBox).Text;
            if (String.IsNullOrEmpty(discount))
            {
                invoice.adjust = 0;
            }
            else
            {
               
                try
                {
                    invoice.adjust = decimal.Parse(discount);
                }
                catch (Exception)
                {

                    invoice.adjust = 0;
                }
            }
            
            invoice.remarks = (iGridView2.FooterRow.FindControl("tbRemarks") as TextBox).Text;
        
            try
            {
                int qid = int.Parse(ddlProj.SelectedValue);
                QuotationModel.Quotation_Version quotation = (from d in db.Quotation_Version where d.Quotation_Version_Id == qid select d).First();
                int clientid = (int)quotation.Client_Id;
                WoWiModel.clientapplicant client = (from c in wowidb.clientapplicants where c.id == clientid select c).First();
                int days = 1;
                if (client.paymentdays.HasValue)
                {
                    days = (int)client.paymentdays;
                }
                invoice.due_date = ((DateTime)invoice.issue_invoice_date).AddDays(days);
                
            }
            catch (Exception)
            {
                
                
            }
            wowidb.invoices.AddObject(invoice);
            wowidb.SaveChanges();

            int invoiceid = invoice.invoice_id;
            foreach (GridViewRow row in iGridView2.Rows)
            {

                if (!(row.FindControl("cbDel") as CheckBox).Checked)
                {
                    //add to invoice targets
                    WoWiModel.invoice_target itarget = new WoWiModel.invoice_target();
                    itarget.invoice_id = invoiceid;
                    String str = (row.FindControl("lblTid") as Label).Text;
                    itarget.quotation_target_id = int.Parse(str);
                    itarget.modify_date = DateTime.Now;
                    itarget.invoice_no = invoice.issue_invoice_no;
                    if ((row.FindControl("lblPayType") as Label).Text == Prepayment1)
                    {

                        itarget.bill_status = (byte)InvoicePaymentStatus.PrePaid1;
                    } 
                    else if ((row.FindControl("lblPayType") as Label).Text == Prepayment2)
                    {

                        itarget.bill_status = (byte)InvoicePaymentStatus.PrePaid2;
                    }
                    else if ((row.FindControl("lblPayType") as Label).Text == Prepayment3)
                    {

                        itarget.bill_status = (byte)InvoicePaymentStatus.PrePaid3;
                    }
                    else //if ((row.FindControl("lblPayType") as Label).Text == Finalpayment)
                    {
                        itarget.bill_status = (byte)InvoicePaymentStatus.FinalPaid;
                    }
                    
                    try
                    {
                        itarget.amount = decimal.Parse((row.FindControl("lblPayAmount") as Label).Text);
                        itarget.quotation_id = int.Parse((row.FindControl("lblQuotationId") as Label).Text);
                    }
                    catch (Exception)
                    {
                        
                        //throw;
                    }
                    
                    wowidb.invoice_target.AddObject(itarget);
                }
            }

            wowidb.SaveChanges();
            Response.Redirect("~/Accounting/InvoiceDetails.aspx?id=" + invoiceid);
        }
        catch(Exception ex)
        {
        }
    }


    protected void ddlwowibankinfo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            (iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = "";
            int id = int.Parse(ddlwowibankinfo.SelectedValue);
            WoWiModel.wowi_bankinfo b = wowidb.wowi_bankinfo.First(c => c.id == id);
            (iGridView2.FooterRow.FindControl("tbbankAccount") as TextBox).Text = b.info;
        }
        catch (Exception)
        {
            
            //throw;
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Issued New&nbsp;&nbsp;<asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Accounting/Invoice.aspx">Invoice List</asp:HyperLink>
                     <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th align="left" width="13%">
                            Issue Invoice :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbIssueInvoice" runat="server"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcissueinvdate" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 I/V No. :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbivno" runat="server" MaxLength="10"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    AutoPostBack="true" onload="ddlProj_Load" 
                                    onselectedindexchanged="ddlProj_SelectedIndexChanged">
                                   <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                           
                            <th align="left" width="13%">
                                WoWi Bank Info :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlwowibankinfo" runat="server" AppendDataBoundItems="True" 
                                    AutoPostBack="true" 
                                    onselectedindexchanged="ddlwowibankinfo_SelectedIndexChanged" 
                                    onload="ddlwowibankinfo_Load" >
                                <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 I/V Date :&nbsp;</th>
                            <td width="20%">
                                 <uc1:DateChooser ID="dcinvdate" runat="server" />
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
                        <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <HeaderTemplate>
                                    <asp:Button ID="delBtn" runat="server" Text="Delete" onclick="delBtn_Click" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbDel" runat="server" CssClass="cbDel" /><asp:Label ID="lblTid" runat="server" Text='<%# Eval("Qutation_Target_Id") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Version" HeaderText="Version" />
                            <asp:BoundField DataField="Date" HeaderText="Date" 
                                DataFormatString="{0:yyyy/MM/dd}" />
                            
                            <asp:TemplateField HeaderText="TDescription">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("TDescription") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="tbbankAccount" runat="server" Height="180" Width="480" TextMode="MultiLine" ReadOnly="true" ></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("TDescription") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Qty" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="UOM" HeaderText="Unit" ItemStyle-HorizontalAlign="Right" />
                            <asp:TemplateField HeaderText="UnitPrice" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("UnitPrice") %>'></asp:Label>
                                    <asp:Label ID="lblQuotationId" runat="server"  Text='<%# Bind("Qutation_Id") %>' CssClass="hidden"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="F. Price" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate  >
                                    <table align="right">
                                        <tr>
                                            <td align="right">
                                               &nbsp;
                                                </td>
                                                <td>
                                             &nbsp;&nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Subtotal before taxes : </td>
                                                <td><asp:Label ID="lblOCurrency" runat="server" Text=""></asp:Label>$ <asp:Label ID="lblOTotal" runat="server" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                (-)Discount : </td>
                                                <td><asp:Label ID="lblOCurrency1" runat="server" Text=""></asp:Label>$ <asp:TextBox ID="tbdiscount" runat="server" ontextchanged="tbTax_TextChanged" 
                                                        AutoPostBack="True" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Total taxes : </td>
                                                <td><asp:Label ID="lblOCurrency2" runat="server" Text=""></asp:Label>$ <asp:TextBox ID="tbTax" runat="server" ontextchanged="tbTax_TextChanged" 
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
                                                <td>&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlCurrency" runat="server">
                                    <asp:ListItem>USD</asp:ListItem>
                                    <asp:ListItem>NTD</asp:ListItem>
                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td align="right">
                                                Exchange Rate : </td>
                                                <td>&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddloperate" runat="server" 
                                                        onselectedindexchanged="ddloperate_SelectedIndexChanged" 
                                                        AutoPostBack="True">
                                                    <asp:ListItem>*</asp:ListItem>
                                                    <asp:ListItem>/</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="tbExchangeRate" runat="server" Width="100px" 
                                                        ontextchanged="tbExchangeRate_TextChanged" AutoPostBack="True" ></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                Total : </td>
                                                <td>$ <asp:TextBox ID="tbTotal" runat="server" ></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblFPrice" runat="server" Text='<%# Bind("FPrice") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Bill") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="tbRemarks" runat="server" Height="170px" TextMode="MultiLine" 
                                        Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
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
                                
                                <asp:Button ID="BtnAdd" runat="server" Text="Add" onclick="BtnAdd_Click" 
                                    style="width: 37px" />
                                
                             </td>
                        </tr>
                              </table>

</asp:Content>

