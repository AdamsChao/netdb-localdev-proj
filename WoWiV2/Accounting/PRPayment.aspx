<%@ Page Language="C#" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script  runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            selectionChanged();
        }
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            
            try
            {
                int id = int.Parse(Request.QueryString["id"]);
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                lblPRNo.Text = obj.pr_id.ToString();
                
                QuotationModel.Project proj = (from pj in db.Project where  pj.Project_Id == obj.project_id select pj).First();
                lblProjNo.Text = proj.Project_No;
                int vender_id = (int)obj.vendor_id;
                WoWiModel.vendor vendor = (from v in wowidb.vendors where v.id == vender_id select v).First();
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
                int bank_id = (int)obj.vendor_banking_id;
                WoWiModel.venderbanking bank = (from b in wowidb.venderbankings where b.bank_id == bank_id select b).First();
                lblAcctNo.Text = bank.bank_account_no;
                int contact_id = (int)obj.vendor_contact_id;
                WoWiModel.contact_info contact = (from con in wowidb.contact_info where con.id == contact_id select con).First();
                lblContact.Text = String.IsNullOrEmpty(contact.fname) ? "" : contact.fname + "" + contact.lname;
                if (String.IsNullOrEmpty(lblContact.Text))
                {
                    lblContact.Text = String.IsNullOrEmpty(contact.c_fname) ? "" : contact.c_lname+contact.c_fname;
                }
                else
                {
                    lblContact.Text += String.IsNullOrEmpty(contact.c_fname) ? "" : " / " + contact.c_lname + contact.c_fname;
                }

                lblClientEmail.Text = contact.email;
                lblClientPhone.Text = contact.workphone;

                int auth_id = (int)obj.pr_auth_id;
                WoWiModel.PR_authority_history auth = (from a in wowidb.PR_authority_history where a.pr_auth_id == auth_id select a).First();
                tbInstruction.Text = auth.instruction;
                if (auth.president_date != null)
                {
                    lblApprove.Text = ((DateTime)auth.president_date).ToString("yyyy/MM/dd");
                    int idx = auth.president.IndexOf(" ");
                    imgApprove.ImageUrl = "../Images/sign/" + GetNameById((int)auth.president_id) + ".bmp";
                }
                else
                {
                    imgApprove.Visible = false;
                    lblApprove.Visible = false;
                }
                if (auth.vp_date != null)
                {
                    lblReview.Text = ((DateTime)auth.vp_date).ToString("yyyy/MM/dd");
                    int idx = auth.vp.IndexOf(" ");
                    imgReview.ImageUrl = "../Images/sign/" + GetNameById((int)auth.vp_id) + ".bmp";
                }
                else
                {
                    imgReview.Visible = false;
                    lblReview.Visible = false;
                }
                if (auth.supervisor_date != null)
                {
                    lblPreview.Text = ((DateTime)auth.supervisor_date).ToString("yyyy/MM/dd");
                    imgPreview.ImageUrl = "../Images/sign/" + GetNameById((int)auth.supervisor_id) + ".bmp";
                }
                if (auth.requisitioner_date != null)
                {
                    lblRequisite.Text = ((DateTime)auth.requisitioner_date).ToString("yyyy/MM/dd");
                    imgRequisite.ImageUrl = "../Images/sign/" + GetNameById((int)auth.requisitioner_id) + ".bmp";
                }
                WoWiModel.PR_item item = (from i in wowidb.PR_item where i.pr_id == id select i).First();
                int tid = (item.quotation_target_id);
                try
                {
                    String currency = (from h in db.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select h.Currency).First();
                    var idata = from t in db.Target from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.target_id select new { /*QuotataionID = qt.quotation_id, Quotation_Target_Id = qt.Quotation_Target_Id,*/ ItemDescription = t.target_description, ModelNo = t.target_code, Currency = currency, Price = qt.unit_price, Qty = qt.unit, FinalPrice = qt.FinalPrice };
                    lblOCurrency.Text = idata.First().Currency;
                    lblOtotal.Text = (decimal)idata.First().FinalPrice +"";
                    lblTotal.Text = lblOtotal.Text;
                    TargetList.DataSource = idata;
                    TargetList.DataBind();

                }
                catch (Exception ex)
                {
                    //throw ex;//Show Message In Javascript
                }   
                
            }
            catch
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
        lblFinalCurrency.Text = curr.Text;
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

        lblTotal.Text = "" + total;
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
                WoWiModel.PR_Payment payment = new WoWiModel.PR_Payment()
                {
                    pr_id = id,
                    fromcurrency = lblOCurrency.Text,
                    tocurrency = tbCurrency.Text,
                    rate_operator = ddlOperate.SelectedValue,
                    adjust_operator = ddlAdjustOperate.SelectedValue,
                    modify_date = DateTime.Now,
                    status = (byte)PRStatus.Paid,
                    original_amount = decimal.Parse(lblOtotal.Text)
                };
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

                decimal total;
                if (ddlOperate.SelectedValue == "*")
                {
                    total = decimal.Parse(lblOtotal.Text) * rate;
                }
                else
                {
                    total = decimal.Parse(lblOtotal.Text) / rate;
                }

                if (ddlAdjustOperate.SelectedValue == "+")
                {
                    total += adj;
                }
                else
                {
                    total -= adj;
                }
                payment.total_amount = total;
                
                wowidb.PR_Payment.AddObject(payment);
                wowidb.SaveChanges();
                int payid = payment.pr_pay_id;
                try
                {
                    var list = from p in wowidb.PR_Payment where p.pr_id == id & p.pr_pay_id != payid select p;
                    foreach (var pitem in list)
                    {
                        if (pitem.status != (byte)PRStatus.PayHistory)
                        {
                            pitem.status = (byte)PRStatus.PayHistory;
                        }
                        
                    }
                    wowidb.SaveChanges();
                }
                catch (Exception)
                {
                    
                    //throw;
                }

                Response.Redirect("~/Accounting/PRPaymentDetails.aspx?id=" + id);
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
        <asp:LinkButton ID="Button2"
            runat="server" Text="PR Payment List" 
                    PostBackUrl="~/Accounting/Payment4Vender.aspx" />
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
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="ccstextboxh" valign="top">
                <u>Vender Infomation </u><br />
                Name:
                <asp:Label ID="lblName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address:
                    <asp:Label ID="lblAddress" runat="server" Text="lblAddress"></asp:Label></p>
                <p>
                    Project No.:
                    <asp:Label ID="lblProjNo" runat="server" Text="lblProjNo"></asp:Label></p>
            </td>
            <td align="right" class="ccstextboxh">
                <table border="0" cellpadding="0" cellspacing="0">
                 <tr>
                        <td align="left" class="ccstextboxh" colspan="2">
                Account No.:
                    <asp:Label ID="lblAcctNo" runat="server" Text="lblAcctNo"></asp:Label>
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
                            <asp:Label ID="lblClientPhone" runat="server" Text="lblClientPhone"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Email:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblClientEmail" runat="server" Text="lblClientEmail"></asp:Label>
                        </td>
                    </tr>
                    <tr>
      &nbsp;</td>
                        <td align="left" class="ccstextboxh">
                            <br />
                        </td>
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
                            <asp:GridView ID="TargetList" runat="server" AutoGenerateColumns="true" width="100%">
                             
                            </asp:GridView>
                         
                        </td>
                    </tr>
                </table>
                <!-- end target -->
            </td>
        </tr>
       <tr>
            <td class="ccstextboxh" valign="top">
                <u>Instruction</u><br />
                <asp:TextBox ID="tbInstruction" runat="server" Width="400px" Height="100px"></asp:TextBox>
                <br />
            </td>
            <td align="right" class="ccstextboxh">
                <table border="0" cellpadding="0" cellspacing="0" Width="100%">
                 <tr>
                        <td align="right" class="ccstextboxh" >
                Original Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                    <asp:Label ID="lblOCurrency" runat="server" Text="lblOCurrency"></asp:Label>
                    </td>
                    <td align="right" class="ccstextboxh" >
                Original Total :
                    </td>
                    <td align="left" class="ccstextboxh" >
               $ <asp:Label ID="lblOtotal" runat="server" Text="lblOtotal"></asp:Label>
                    </td>
                    </tr>
                   <tr>
                        <td align="right" class="ccstextboxh" >
                Exchange Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                    <asp:TextBox ID="tbCurrency" runat="server" ontextchanged="tbCurrency_TextChanged" 
                            AutoPostBack="True"></asp:TextBox>
                    </td>
                    <td align="right" class="ccstextboxh" >
                Exchange Rate :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        <asp:DropDownList ID="ddlOperate" runat="server" 
                            onselectedindexchanged="ddlOperate_SelectedIndexChanged" 
                            AutoPostBack="True">
                            <asp:ListItem>*</asp:ListItem>
                            <asp:ListItem>/</asp:ListItem>
                        </asp:DropDownList>
               <asp:TextBox ID="tbRate" runat="server" AutoPostBack="True" 
                            ontextchanged="tbRate_TextChanged"></asp:TextBox>
                    </td>
                    </tr>
                     <tr>
                        <td align="right" class="ccstextboxh" >
               
                    </td>
                    <td align="left" class="ccstextboxh" >
                  
                    </td>
                    <td align="right" class="ccstextboxh" >
                Adjust Amount :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        <asp:DropDownList ID="ddlAdjustOperate" runat="server" 
                            onselectedindexchanged="ddlAdjustOperate_SelectedIndexChanged" 
                            AutoPostBack="True">
                            <asp:ListItem>+</asp:ListItem>
                            <asp:ListItem>-</asp:ListItem>
                        </asp:DropDownList>
               <asp:TextBox ID="tbAdjustAmount" runat="server" AutoPostBack="True" 
                            ontextchanged="tbAdjustAmount_TextChanged"></asp:TextBox>
                    </td>
                    </tr>
                    <tr>
                        <td align="right" class="ccstextboxh" >
                Final Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                    <asp:Label ID="lblFinalCurrency" runat="server"></asp:Label>
                    </td>
                    <td align="right" class="ccstextboxh" >
                        Balance Total :
                    </td>
                    <td align="left" class="ccstextboxh" >
               $ <asp:Label ID="lblTotal" runat="server" Text="lblTotal"></asp:Label>
                    </td>
                    </tr>
                    <tr>
                    <td align="right" class="ccstextboxh" colspan="4" >
                        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                            Text="Preview" Visible="False" />
                        <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
                    </td>
                    </tr>
                </table>
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
           
           
            
            
            <!-- end cost summary service -->
            <tr>
                <td colspan="2">
                    <!-- Start Signature Section -->
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                             <th class="ccstexth" width="25%">
                               Approve /  Date
                            </th>
                            <th class="ccstexth" width="25%">
                               Review /  Date
                            </th>
                             <th class="ccstexth" width="25%">
                               Preview /  Date
                            </th>
                             <th class="ccstexth" width="25%">
                               Requisite / Date
                            </th>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgApprove" runat="server" Height="31" Width="114" /> <asp:Label ID="lblApprove" runat="server"
                                        Text="lblApprove"></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgReview" runat="server" Height="31" Width="114" /> <asp:Label ID="lblReview" runat="server"
                                        Text="lblReview"></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgPreview" runat="server" Height="31" Width="114" /> <asp:Label ID="lblPreview" runat="server"
                                        Text="lblPreview"></asp:Label>
&nbsp;</td>
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgRequisite" runat="server" Height="31" Width="114" /> <asp:Label ID="lblRequisite" runat="server"
                                        Text="lblRequisite"></asp:Label>
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
    </p>
    </form>
</body>
</html>
