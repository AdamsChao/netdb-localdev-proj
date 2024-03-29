﻿<%@ Page Language="C#"  EnableTheming="false"%>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>
<script  runat="server">
    //QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            selectionChanged();
            return;
        }
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            
            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                if (obj.create_date.HasValue)
                {
                    lblCreateDate.Text = ((DateTime)obj.create_date).ToString("yyyy/MM/dd");
                }
                else
                {
                    lblCreateDate.Text = "";
                }
                try
                {
                    int aid = (int)obj.department_id;
                    lblDept.Text = wowidb.access_level.First(c => c.id == aid).name;
                }
                catch (Exception)
                {

                    lblDept.Text = "Not set yet";
                }
                try
                {
                    int eid = (int)obj.employee_id;
                    var info = wowidb.employees.First(c => c.id == eid);
                    lblEmp.Text = info.fname + " " + info.lname;
                }
                catch (Exception)
                {

                    lblEmp.Text = "Not set yet";
                }
                try
                {
                    //lblToday.Text = DateTime.Now.ToString("yyyy/MM/dd");
                    lblTargetPDate.Text = ((DateTime)obj.target_payment_date).ToString("yyyy/MM/dd");
                    
                }
                catch (Exception)
                {

                    lblTargetPDate.Text = "Not set yet";
                }
                if (Page.IsPostBack)
                {
                   return;
                }
                try
                {
                    WoWiModel.PR_Payment pay = wowidb.PR_Payment.First(c => c.pr_id == obj.pr_id);
                    //if (pay.payment_term.HasValue)
                    //{
                    //    lblPaymentTerm.Text = PRUtils.GetPaymentTermString((byte)pay.payment_term);
                    //}
                    //else
                    //{
                    //    lblPaymentTerm.Text = "Not set yet.";
                    //}
                    ddlAdjustOperate.SelectedValue = pay.adjust_operator;
                    ddlOperate.SelectedValue = pay.rate_operator;
                    tbAdjustAmount.Text = ((decimal)pay.adjust_amount).ToString();
                    tbRate.Text = ((decimal)pay.exchange_rate).ToString();
                    tbReason.Text = pay.reason;
                    tbPayRemarks.Text = pay.remarks;
                    tbToCurrency.Text = pay.tocurrency;
                    tbTotal.Text = ((decimal)pay.total_amount).ToString("F2");
                    lblTotal.Text = ((decimal)pay.adjust_total).ToString("F2");
                    dcPaidDate.setText(((DateTime)pay.pay_date).ToString("yyyy/MM/dd"));
                    if (pay.status == (byte)PRStatus.ClosePaid)
                    {
                        Response.Redirect("~/Accounting/PRPaymentDetails.aspx?id=" + id,false);
                        return;
                    }
                }
                catch (Exception)
                {
                    
                    //throw;
                }
                
                
                lblPRNo.Text = obj.pr_id.ToString();
                lblOCurrency1.Text = obj.currency;
                lblOtotal.Text = ((decimal)obj.total_cost).ToString("F2");
                WoWiModel.Project proj = (from pj in wowidb.Projects where pj.Project_Id == obj.project_id select pj).First();
                lblProjNo.Text = proj.Project_No;
                lblProjectStatus.Text = proj.Project_Status;
                //lblProjectDate.Text = proj.Create_Date.ToString("yyyy/MM/dd");
                WoWiModel.Quotation_Version quo = wowidb.Quotation_Version.First(c => c.Quotation_Version_Id == proj.Quotation_Id);
                lblQuoNo.Text = quo.Quotation_No;
                lblClient.Text = (from aa in wowidb.clientapplicants where quo.Applicant_Id == aa.id select aa.companyname).FirstOrDefault(); 
                
                int vender_id = (int)obj.vendor_id;
                WoWiModel.vendor vendor = (from v in wowidb.vendors where v.id == vender_id select v).First();
                lblBankCharge.Text = VenderUtils.GetBankCharge((int)vendor.bank_charge);
                lblName.Text = String.IsNullOrEmpty(vendor.name) ? "" : vendor.name;
                if (String.IsNullOrEmpty(lblName.Text))
                {
                    lblName.Text = String.IsNullOrEmpty(vendor.c_name) ? "" : vendor.c_name;
                }
                else
                {
                    lblName.Text += String.IsNullOrEmpty(vendor.c_name) ? "" : " / "+vendor.c_name;
                }

                lblAddress.Text = String.IsNullOrEmpty(vendor.address) ? "" : vendor.address;
                if (String.IsNullOrEmpty(lblAddress.Text))
                {
                    lblAddress.Text = String.IsNullOrEmpty(vendor.c_address) ? "" : vendor.c_address;
                }
                else
                {
                    lblAddress.Text += String.IsNullOrEmpty(vendor.c_address) ? "" : " / " + vendor.c_address;
                }
                try
                {
                    lblPaymentTerm.Text = PRUtils.GetPaymentTermString(byte.Parse(vendor.paymentdays));
                }
                catch (Exception)
                {

                    lblPaymentTerm.Text = "Not set yet";
                }
                
               
                try
                {
                    int bank_id = (int)obj.vendor_banking_id;
                    var bank = (from b in wowidb.venderbankings where b.bank_id == bank_id select b);
                    //lblAcctNo.Text = bank.bank_account_no;
                    GridView bgv1 = BankGridView1 ;
                    GridView bgv2 = BankGridView2;
                    GridView wgv = WUBGridView;
                    if ((bool)bank.First().isWestUnit)
                    {
                        lblWUB.Visible = true;
                        wgv.Visible = true;
                        bgv1.Visible = false;
                        bgv2.Visible = false;
                        wgv.DataSource = bank;
                        wgv.DataBind();
                    }
                    else
                    {
                        lblWUB.Visible = false;
                        wgv.Visible = false;
                        bgv1.Visible = true;
                        bgv2.Visible = true;
                        bgv1.DataSource = bank;
                        bgv1.DataBind();
                        bgv2.DataSource = bank;
                        bgv2.DataBind();
                    }
                }
                catch(Exception ex)
                {
                }
                if (obj.vendor_contact_id.HasValue)
                {
                    int contact_id = (int)obj.vendor_contact_id;
                    WoWiModel.contact_info contact = (from con in wowidb.contact_info where con.id == contact_id select con).First();
                    lblContact.Text = String.IsNullOrEmpty(contact.fname) ? "" : contact.fname + "" + contact.lname;
                    if (String.IsNullOrEmpty(lblContact.Text))
                    {
                        lblContact.Text = String.IsNullOrEmpty(contact.c_fname) ? "" : contact.c_lname + contact.c_fname;
                    }
                    else
                    {
                        lblContact.Text += String.IsNullOrEmpty(contact.c_fname) ? "" : " / " + contact.c_lname + contact.c_fname;
                    }

                    lblClientEmail.Text = contact.email;
                    lblClientPhone.Text = contact.workphone;
                }
                int auth_id = (int)obj.pr_auth_id;
                WoWiModel.PR_authority_history auth = (from a in wowidb.PR_authority_history where a.pr_auth_id == auth_id select a).First();
                
                if (String.IsNullOrEmpty(auth.instruction))
                {
                    tbInstruction.Text = "N/A";
                }
                else
                {
                    tbInstruction.Text = auth.instruction.Replace("\n", "<br>");
            
                }

                if (String.IsNullOrEmpty(auth.remark))
                {
                    tbRemarks.Text = "N/A";
                }
                else
                {
                    tbRemarks.Text = auth.remark.Replace("\n", "<br>");
                }
                
                if (auth.president_date.HasValue)
                {
                    try
                    {
                        lblApprove.Text = ((DateTime)auth.president_date).ToString("yyyy/MM/dd");
                    }
                    catch (Exception)
                    {
                        
                        //throw;
                    }
                    
                    imgApprove.ImageUrl = "../Images/sign/" + GetNameById((int)auth.president_id) + ".bmp";
                    imgApprove.Visible = true;
                    lblApprove.Visible = true;
                }

                if (auth.vp_date.HasValue)
                {
                    try
                    {
                        lblReview.Text = ((DateTime)auth.vp_date).ToString("yyyy/MM/dd");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    
      
                    imgReview.ImageUrl = "../Images/sign/" + GetNameById((int)auth.vp_id) + ".bmp";
                    imgReview.Visible = true;
                    lblReview.Visible = true;
                }
               
                if (auth.supervisor_date.HasValue)
                {
                    try
                    {
                        lblPreview.Text = ((DateTime)auth.supervisor_date).ToString("yyyy/MM/dd");
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    imgPreview.ImageUrl = "../Images/sign/" + GetNameById((int)auth.supervisor_id) + ".bmp";
                }
                if (auth.requisitioner_date.HasValue)
                {
                    lblRequisite.Text = ((DateTime)auth.requisitioner_date).ToString("yyyy/MM/dd");
                    imgRequisite.ImageUrl = "../Images/sign/" + GetNameById((int)auth.requisitioner_id) + ".bmp";
                }
                WoWiModel.PR_item item = (from i in wowidb.PR_item where i.pr_id == id select i).First();
                int tid = (item.quotation_target_id);
                try
                {
                    var quot =  (from h in wowidb.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select new{ h.Currency, h.Model_No, h.CModel_No}).First();
                    String currency = quot.Currency;
                    String ModelNo = String.IsNullOrEmpty(quot.Model_No) ? quot.CModel_No : quot.Model_No;

                    var idata = from t in wowidb.Target_Rates from qt in wowidb.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.Target_rate_id select new { /*QuotataionID = qt.quotation_id, Quotation_Target_Id = qt.Quotation_Target_Id,*/ ItemDescription = qt.target_description, ModelNo = ModelNo, /*Currency = currency,*/  Qty = qt.unit, date = qt.certification_completed, status = qt.Status };

                    lblTotal.Text = lblOtotal.Text;
                    TargetList.DataSource = idata;
                    TargetList.DataBind();

                    try
                    {
                        lblProjectStatus.Text = idata.First().status;
                        if (idata.First().date.HasValue)
                        {
                            lblProjectDate.Text = ((DateTime)idata.First().date).ToString("yyyy/MM/dd");
                        }
                        else
                        {
                            lblProjectDate.Text = "";
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    
                }
                catch (Exception ex)
                {
                    //throw ex;//Show Message In Javascript
                }
                try
                {
                    selectionChanged();
                }
                catch
                {
                }
                    
                
            }
            catch (Exception ex)
            {
                
            }
            
           
        }

    }
    protected String GetNameById(int id)
    {
        String name = "";
        WoWiModel.employee emp = (from e in wowidb.employees where e.id == id select e).First();
        name = emp.fname.Trim() + "." + emp.lname.Trim();
        return name;

    }
    protected void tbCurrency_TextChanged(object sender, EventArgs e)
    {
        TextBox curr = sender as TextBox;
    }

    protected void ddlOperate_SelectedIndexChanged(object sender, EventArgs e)
    {

        selectionChanged();
        
    }

    private void selectionChanged()
    {
        decimal total;
        decimal rate = 1;
        try
        {
            rate = decimal.Parse(tbRate.Text);
            
        }
        catch
        {
        }
        if (ddlOperate.SelectedValue == "*")
        {
            total = decimal.Parse(lblOtotal.Text) * rate;
        }
        else
        {
            total = decimal.Parse(lblOtotal.Text) / rate;
        }

        decimal adj = 0;
        try
        {
            adj = decimal.Parse(tbAdjustAmount.Text);

        }
        catch
        {
        }

        if (ddlAdjustOperate.SelectedValue == "+")
        {
            total += adj;
        }
        else
        {
            total -= adj;
        }

        lblTotal.Text = total.ToString("F2");
        //GridView1_PreRender(BankGridView1, null);
    }
    protected void ddlAdjustOperate_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectionChanged();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        selectionChanged();
    }

    protected void tbRate_TextChanged(object sender, EventArgs e)
    {
        selectionChanged();
    }

    protected void tbAdjustAmount_TextChanged(object sender, EventArgs e)
    {
        selectionChanged();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            try
            {

                try
                {
                    var list = (from p in wowidb.PR_Payment where p.pr_id == id select p);
                    foreach (var dd in list)
                    {
                        wowidb.PR_Payment.DeleteObject(dd);
                    }
                    wowidb.SaveChanges();
                }
                catch
                {

                }
                WoWiModel.PR_Payment payment = new WoWiModel.PR_Payment()
                {
                    pr_id = id,
                    fromcurrency = lblOCurrency1.Text,
                    tocurrency = tbToCurrency.Text,
                    rate_operator = ddlOperate.SelectedValue,
                    adjust_operator = ddlAdjustOperate.SelectedValue,
                    //adjust_amount = decimal.Parse(lblTotal.Text),
                    modify_date = DateTime.Now,
                    status = (byte)PRStatus.Paid,
                    
                };

          

                try
                {
                    payment.original_amount = decimal.Parse(lblOtotal.Text);
                }
                catch (Exception)
                {

                    //throw;
                }
                decimal rate = 1;
                if (!String.IsNullOrEmpty(tbRate.Text))
                {
                    try
                    {

                        rate = decimal.Parse(tbRate.Text);
                        payment.exchange_rate = (double)rate;
                    }
                    catch (Exception)
                    {
                        payment.exchange_rate = (double)rate;

                    }

                }
                else
                {
                    payment.exchange_rate = (double)rate;
                }
                decimal adj = 0;
                if (!String.IsNullOrEmpty(tbAdjustAmount.Text))
                {
                    try
                    {

                        adj = decimal.Parse(tbAdjustAmount.Text);
                        payment.adjust_amount = (decimal)adj;
                    }
                    catch (Exception)
                    {

                        payment.adjust_amount = (decimal)adj;
                    }

                }
                else
                {
                    payment.adjust_amount = (decimal)adj;
                }

                decimal total;
                payment.rate_operator = ddlOperate.SelectedValue;
                if (ddlOperate.SelectedValue == "*")
                {
                    total = decimal.Parse(lblOtotal.Text) * rate;
                }
                else
                {
                    total = decimal.Parse(lblOtotal.Text) / rate;
                }
                payment.adjust_operator = ddlAdjustOperate.SelectedValue;
                if (ddlAdjustOperate.SelectedValue == "+")
                {
                    total += adj;
                }
                else
                {
                    total -= adj;
                }
                try
                {
                    payment.adjust_total = total;
                }
                catch (Exception)
                {
                    
                    //throw;
                }
               
                payment.modify_date = DateTime.Now;
                try
                {
                    payment.pay_date = dcPaidDate.GetDate();
                }
                catch (Exception)
                {
                    
                    //throw;
                }
                payment.reason = tbReason.Text;//adjust reason
                payment.remarks = tbPayRemarks.Text;//pay remarks
                try
                {
                    payment.total_amount = decimal.Parse(tbTotal.Text);
                }
                catch (Exception)
                {
                    
                    //throw;
                }
                wowidb.PR_Payment.AddObject(payment);
                wowidb.SaveChanges();
                int payid = payment.pr_pay_id;
                //try
                //{
                //    var list = from p in wowidb.PR_Payment where p.pr_id == id & p.pr_pay_id != payid select p;
                //    foreach (var pitem in list)
                //    {
                //        if (pitem.status != (byte)PRStatus.PayHistory)
                //        {
                //            pitem.status = (byte)PRStatus.PayHistory;
                //        }

                //    }
                //    wowidb.SaveChanges();
                //}
                //catch (Exception ex)
                //{

                //    //throw;
                //}

                Response.Redirect("~/Accounting/PRPaymentDetails.aspx?id=" + id+"&payid="+payid);
            }
            catch (Exception)
            {
                
                //throw;
            }
        }
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        GridView GridView1 = sender as GridView;
        foreach (GridViewRow row in GridView1.Rows)
        {

            String paymentType = row.Cells[0].Text;
            try
            {
                row.Cells[0].Text = VenderUtils.GetPaymentType(paymentType);
            }
            catch (Exception)
            {

                //throw;
            }

        }
    }

    protected void tbToCurrency_TextChanged(object sender, EventArgs e)
    {
        TextBox tc = sender as TextBox;
        lblPayCurrency.Text = tc.Text;
    }


    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (tbReason.Text.Trim().Length == 0)
        {
            tbReason.Text = "受款人匯差";
        }
        if (dcPaidDate.GetText().Trim().Length == 0)
        {
            dcPaidDate.setText(DateTime.Now.ToString("yyyy/MM/dd"));
        }
        lblPayCurrency.Text = tbToCurrency.Text;
    }


    protected void WUBGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e.Row.RowType == DataControlRowType.DataRow)
      { 
        String paymentType = e.Row.Cells[0].Text;
        try
        {
          e.Row.Cells[0].Text = VenderUtils.GetPaymentType(paymentType);
        }
        catch (Exception)
        {
          //throw;
        }
      }
    }
</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
       /* .CCSTextBoxH
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
        }*/
        B
        {
            font-weight: bold;
        }
        
        .alignRight
        {
            text-align:right;
        }
        .CCSTextBoxRD
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #dddddd;
            font-size: 9pt;
        }
        
        .style3
        {
            font-size:13px;
        }
        </style>
</head>
<body style="font-size:13px;">
    <form id="form1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                       <ContentTemplate>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
            </td>
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
        <asp:LinkButton ID="Button2"
            runat="server" Text="PR Payment List" 
                    PostBackUrl="~/Accounting/Payment4Vender.aspx" CausesValidation="False" />
    </p>
                <img border="0" height="56" src="../Images/Quotation/transparent.gif" width="168" />
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                Purchase Request #
                <asp:Label ID="lblPRNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
                        <td colspan="3" >
                            <hr color="#003300"  />
                        </td>
                    </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="ccstextboxh" valign="top">
           <%-- <p>
                    Today:
                    <asp:Label ID="lblToday" runat="server" Text="lblToday"></asp:Label></p>--%>
                <p>
                    Project No.:
                    <asp:Label ID="lblProjNo" runat="server" Text="lblProjNo"></asp:Label></p>
                    Qutation No.:
                    <asp:Label ID="lblQuoNo" runat="server" Text="lblQuoNo"></asp:Label></p>
                    Client:
                    <asp:Label ID="lblClient" runat="server" Text="lblClient"></asp:Label></p>
                    <u>Vender Infomation </u><br />
                Name:
                <asp:Label ID="lblName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address:
                    <asp:Label ID="lblAddress" runat="server" Text="lblAddress"></asp:Label></p>
                <p>Contact:
                            <asp:Label ID="lblContact" runat="server"></asp:Label><%--/nobr>--%></p>
                  
                             <p>Phone:
                            <asp:Label ID="lblClientPhone" runat="server"></asp:Label><%--</nobr>--%></p>
                    
                             <p>Email:
                            <asp:Label ID="lblClientEmail" runat="server"></asp:Label></p>
            </td>  <td align="left" class="ccstextboxh"  valign="top" style="width:20%">

            </td>
            <td align="left" class="ccstextboxh"  valign="top">
                    <p>
                    Access level:
                    <asp:Label ID="lblDept" runat="server" Text="lblDepartment"></asp:Label></p>
                    <p>
                    Created by:
                    <asp:Label ID="lblEmp" runat="server" Text="lblEmployee"></asp:Label></p>
                    <p>
                    Create date:
                    <asp:Label ID="lblCreateDate" runat="server" Text="lblCreateDate"></asp:Label></p>
                    <p>
                        Target status:
                    <asp:Label ID="lblProjectStatus" runat="server" Text="lblProjectStatus"></asp:Label></p>
                    <p>
                        Target date:
                    <asp:Label ID="lblProjectDate" runat="server" Text="lblProjectDate"></asp:Label></p>
                    <p>
                    Payment term:
                    <asp:Label ID="lblPaymentTerm" runat="server" Text="lblPaymentTerm"></asp:Label></p>
                    <p>
                    Target payment date:
                    <asp:Label ID="lblTargetPDate" runat="server" Text="lblTargetPDate"></asp:Label></p>
                    <p>
                    Bank charge:
                    <asp:Label ID="lblBankCharge" runat="server" Text="lblBankCharge"></asp:Label></p>
                    <p>
                    
                        </td>
                    </tr>
        <tr>
            <td colspan="3">
                <!-- start target -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <hr color="#003300" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                     <asp:GridView ID="BankGridView1" runat="server" Width="100%" AutoGenerateColumns="False"  onprerender="GridView1_PreRender">
                                       <Columns>
           <asp:BoundField DataField="payment_type" HeaderText="Payment Type" 
                SortExpression="payment_type" />
            <asp:BoundField DataField="bank_name" HeaderText="Bank Name" 
                SortExpression="bank_name" />
            <asp:BoundField DataField="bank_branch_name" HeaderText="Branch Name" 
                SortExpression="bank_branch_name" />
            <asp:BoundField DataField="bank_address" HeaderText="Bank Address" 
                SortExpression="bank_address" />
            <asp:BoundField DataField="bank_telephone" HeaderText="Bank Telephone" 
                SortExpression="bank_telephone" />
        </Columns>
                                    </asp:GridView>
                                    <asp:GridView ID="BankGridView2" runat="server" Width="100%" AutoGenerateColumns="False"  >
                                       <Columns>
            <asp:BoundField DataField="bank_account_no" HeaderText="Account No.(IBAN)" 
                SortExpression="bank_account_no" />
            <asp:BoundField DataField="bank_swifcode" HeaderText="Swif Code" 
                SortExpression="bank_swifcode" />
            <asp:BoundField DataField="bank_beneficiary_name" 
                HeaderText="Beneficiary Name" SortExpression="bank_beneficiary_name" />
            <asp:BoundField DataField="bank_routing_no" HeaderText="Routing No." 
                SortExpression="bank_routing_no" />
        </Columns>
                                    </asp:GridView>
              <asp:Label runat="server" ID="lblWUB" Text="Vender Bank Account Information :"  
                            Visible="False"></asp:Label>
                                    <asp:GridView ID="WUBGridView" runat="server" Width="100%" 
                            AutoGenerateColumns="False" onrowdatabound="WUBGridView_RowDataBound"  >
                                       <Columns>
                                         <asp:BoundField DataField="payment_type" HeaderText="Payment Type" />
      <asp:BoundField DataField="wu_first_name" HeaderText="First Name" 
                SortExpression="wu_first_name" />
            <asp:BoundField DataField="wu_last_name" HeaderText="Last Name" 
                SortExpression="wu_last_name" />
                <asp:BoundField DataField="wu_destination" HeaderText="Destination" 
                SortExpression="wu_destination" />
        </Columns>
                                    </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="TargetList" runat="server" AutoGenerateColumns="true" width="100%">
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <!-- end target -->
            </td>
        </tr>
    
             <tr>
             
            <td align="right" class="ccstextboxh" colspan="4" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                        <td align="right" class="ccstextboxh" style="width: 20%" >
              <%--  Original Currency :--%>
                    </td>
                    <td align="left" class="ccstextboxh" style="width: 35%" >
                     &nbsp;&nbsp;&nbsp;
                       
                    </td>
                    <td align="right" class="ccstextboxh" style="width: 20%" >
                Total :
                    </td>
                    <td align="right" class="ccstextboxh" style="width: 15%" >
                &nbsp;&nbsp;&nbsp;<asp:Label ID="lblOCurrency1" runat="server" Text="lblOCurrency"></asp:Label>$ </td><td align="right" class="ccstextboxh" style="width: 10%"  ><asp:Label ID="lblOtotal" runat="server" Text="lblOtotal"></asp:Label>
                    </td>
                    </tr>
                   <tr>
                        <td align="right" class="ccstextboxh" >
               
                            Adjust&nbsp;Reason :
               
                    </td>
                    <td align="left" class="ccstextboxh" >
                   &nbsp;&nbsp;&nbsp; <asp:TextBox ID="tbReason" runat="server"
                            AutoPostBack="True" Width="300"></asp:TextBox>
                  
                    </td>
                    <td align="right" class="ccstextboxh" >
                Exchange Rate :
                    </td>
                    <td align="right" class="ccstextboxh" >
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlOperate" runat="server" 
                            onselectedindexchanged="ddlOperate_SelectedIndexChanged" 
                            AutoPostBack="True">
                            <asp:ListItem>*</asp:ListItem>
                            <asp:ListItem>/</asp:ListItem>
                        </asp:DropDownList></td><td align="right" class="ccstextboxh" >
               <asp:TextBox ID="tbRate" runat="server" AutoPostBack="True" 
                            ontextchanged="tbRate_TextChanged" CssClass="alignRight"></asp:TextBox>
                    </td>
                    </tr>
                     <tr>
                        <td align="right" class="ccstextboxh" >
                            Pay Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;&nbsp; &nbsp;<asp:TextBox ID="tbToCurrency" 
                            runat="server" Text="" ontextchanged="tbToCurrency_TextChanged" 
                            AutoPostBack="True"></asp:TextBox></td>
                    <td align="right" class="ccstextboxh" >
                Adjust Amount :
                    </td>
                    <td align="right" class="ccstextboxh" >
                       &nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlAdjustOperate" runat="server" 
                            onselectedindexchanged="ddlAdjustOperate_SelectedIndexChanged" 
                            AutoPostBack="True">
                            <asp:ListItem>+</asp:ListItem>
                            <asp:ListItem>-</asp:ListItem>
                        </asp:DropDownList></td><td align="right" class="ccstextboxh" >
               <asp:TextBox ID="tbAdjustAmount" runat="server" AutoPostBack="True" 
                            ontextchanged="tbAdjustAmount_TextChanged" CssClass="alignRight"></asp:TextBox>
                    </td>
                    </tr>
                    <tr>
                    <td align="right" class="ccstextboxh" >
                         Paid Date : 
                    </td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;&nbsp;&nbsp;
                        <%-- <uc1:DateChooser ID="DateChooser1" runat="server" />--%>
                        <uc1:DateChooser ID="dcPaidDate" runat="server" />
                </td>
                    <td align="right" class="ccstextboxh" >
                        Balance Total :
                    </td>
                    <td align="right" class="ccstextboxh" >
                 &nbsp;&nbsp;&nbsp;<asp:Label ID="lblPayCurrency" runat="server" Text="lblCurrency"></asp:Label>$ </td><td align="right" class="ccstextboxh" ><asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                    </td>
                    </tr>
                    <tr>
                    <td align="right" class="ccstextboxh" align="left" >
                       Remarks : 
                    </td>
                    <td align="left" class="ccstextboxh" rowspan="2" >
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbPayRemarks" runat="server" Text=""  Width="300" TextMode="MultiLine" Height="80"></asp:TextBox></td>
                <td align="right" class="ccstextboxh" >
                       Convert To : 
                    </td>
                    <td align="right" class="ccstextboxh" >
                &nbsp;&nbsp;&nbsp;USD$ </td><td align="right" class="ccstextboxh" > 
                            <asp:TextBox ID="tbTotal" runat="server" Text="" CssClass="alignRight"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="tbTotal" ErrorMessage="Have to provide Concert to USD!" 
                            ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                            ShowMessageBox="True" ShowSummary="False" />
                        </td>
                        
                    </tr>
                    
                    <tr>
                   
                    <td align="left" class="ccstextboxh" >
                        &nbsp;</td>
                    <td align="right" class="ccstextboxh" colspan="3" align="right" >
                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
                    </td>
                    </tr>
                    
                     <tr>
             <td class="ccstextboxh" colspan="5" width="100%">
                    <hr />
                </td>
                </tr>
           <tr><td class="ccstextboxh" colspan="5" width="100%">
                           <table border="0" cellpadding="0" cellspacing="0" width="100%"><tr>
            <td class="ccstextboxh" valign="top"  width="48%" align="left" style="font-size: 13px;" >
                <u>Internal Remarks</u><br />
               <%-- <asp:TextBox ID="tbRemarks" runat="server" Width="400px" Height="100px"   TextMode="MultiLine"
                   ReadOnly="true"></asp:TextBox>--%>
                   <asp:Label ID="tbRemarks" runat="server" 
                    ></asp:Label>
            </td>
            <td class="ccstextboxh" valign="top"  width="4%" align="left" style="font-size: 12px;" >
                &nbsp;
            </td>
            <td class="ccstextboxh" valign="top" width="48%" align="left" style="font-size: 13px;"  >
                <u>External Instruction</u><br />
                <%--<asp:TextBox ID="tbInstruction" runat="server" Width="400px" Height="100px"  TextMode="MultiLine"
                   ReadOnly="true"></asp:TextBox>--%>
                   <asp:Label ID="tbInstruction" runat="server" 
                    ></asp:Label>
            </td>

             </tr>
              </table></td></tr>
                    
                </table>
            </td>
        </tr>
        <!-- end cost summary service -->
    </table>
 
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="ccstextboxh" colspan="2" width="100%">
                    <hr />
                </td>
            </tr>
           
           
            
            
            <!-- end cost summary service -->
            <tr>
                <td colspan="2" class="ccstextboxh">
                    <!-- Start Signature Section -->PR Approval : 
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">

                        <tr>
                             <th class="ccstexth" width="25%">
                               President / Date
                            </th>
                            <th class="ccstexth" width="25%">
                               VP / Date
                            </th>
                             <th class="ccstexth" width="25%">
                               Supervisor / Date
                            </th>
                             <th class="ccstexth" width="25%">
                               Requisite / Date
                            </th>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgApprove" runat="server" Height="31" Width="114" Visible="false" /> <asp:Label ID="lblApprove" runat="server"
                                        Text=""></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgReview" runat="server" Height="31" Width="114" Visible="false"/> <asp:Label ID="lblReview" runat="server"
                                        Text=""></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgPreview" runat="server" Height="31" Width="114"  /> <asp:Label ID="lblPreview" runat="server"
                                        Text=""></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgRequisite" runat="server" Height="31" Width="114"  /> <asp:Label ID="lblRequisite" runat="server"
                                        Text=""></asp:Label>
&nbsp;</td>
                        </tr>
                     
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="ccstextboxh">
                    <!-- Start Signature Section -->Payment Approval : 
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">

                        <tr>
                             <th class="ccstexth" width="20%">
                               President / Date
                            </th>
                            <th class="ccstexth" width="20%">
                               VP / Date
                            </th>
                            <th class="ccstexth" width="20%">
                               Accounting / Date
                            </th>
                             <th class="ccstexth" width="20%">
                               Supervisor / Date
                            </th>
                             <th class="ccstexth" width="20%">
                               Requisite / Date
                            </th>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" align="center">

                               <br>
                               <br>
&nbsp;</td>
 <td class="ccstextboxh" align="center">

                               <br>
                               <br>
&nbsp;</td><td class="ccstextboxh" align="center">

                               <br>
                               <br>
&nbsp;</td><td class="ccstextboxh" align="center">

                               <br>
                               <br>
&nbsp;</td><td class="ccstextboxh" align="center">

                               <br>
                               <br>
&nbsp;</td>
                        </tr>
                     
                    </table>
                </td>
            </tr>
            <!-- End Signature Section -->
            <tr>
                <td colspan="2" width="100%">
                    &nbsp;
                </td>
            </tr>
           
        </table>
        <!-- end body -->

   </ContentTemplate>
                       <Triggers>
                           <asp:PostBackTrigger ControlID="btnSave" />
                       </Triggers>
                     </asp:UpdatePanel>
   
     </form>
</body>
</html>
