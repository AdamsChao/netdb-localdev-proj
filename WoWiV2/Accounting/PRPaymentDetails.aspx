<%@ Page Language="C#" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>
<script  runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {

            try
            {
                int id = int.Parse(Request.QueryString["id"]);

                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                try
                {
                    lblToday.Text = DateTime.Now.ToString("yyyy/MM/dd");
                    lblTargetPDate.Text = ((DateTime)obj.target_payment_date).ToString("yyyy/MM/dd");
                }
                catch (Exception)
                {

                    lblTargetPDate.Text = "Not set yet";
                }
                lblPRNo.Text = obj.pr_id.ToString();
                lblOCurrency.Text = obj.currency;
                lblOtotal.Text = ((decimal)obj.total_cost).ToString("F2");
                QuotationModel.Project proj = (from pj in db.Project where  pj.Project_Id == obj.project_id select pj).First();
                lblProjNo.Text = proj.Project_No;
                QuotationModel.Quotation_Version quo = db.Quotation_Version.First(c => c.Quotation_Version_Id == proj.Quotation_Id);
                lblQuoNo.Text = quo.Quotation_No;
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
                try
                {
                    int bank_id = (int)obj.vendor_banking_id;
                    var bank = (from b in wowidb.venderbankings where b.bank_id == bank_id select b);
                    GridView bgv = BankGridView;
                    GridView wgv = WUBGridView;
                    if ((bool)bank.First().isWestUnit)
                    {
                        lblWUB.Visible = true;
                        wgv.Visible = true;
                        bgv.Visible = false;
                        wgv.DataSource = bank;
                        wgv.DataBind();
                    }
                    else
                    {
                        lblWUB.Visible = false;
                        wgv.Visible = false;
                        bgv.Visible = true;
                        bgv.DataSource = bank;
                        bgv.DataBind();
                    }
                }
                catch (Exception ex)
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
                tbInstruction.Text = auth.instruction;
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
                    String currency = (from h in db.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select h.Currency).First();
                    var idata = from t in db.Target from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.target_id select new { /*QuotataionID = qt.quotation_id, Quotation_Target_Id = qt.Quotation_Target_Id,*/ ItemDescription = t.target_description, ModelNo = t.target_code /*, Currency = currency*/, Qty = qt.unit};
                    
                    //lblTotal.Text = lblOtotal.Text;
                    TargetList.DataSource = idata;
                    TargetList.DataBind();

                }
                catch (Exception ex)
                {
                    //throw ex;//Show Message In Javascript
                }


                try
                {
                    
                    WoWiModel.PR_Payment pay = (from p in wowidb.PR_Payment where p.pr_id == obj.pr_id select p).First();
                    if (pay.status == (byte)PRStatus.ClosePaid)
                    {
                        btnSave.Enabled = false;
                        tbPayRemarks.Enabled = false;
                        Button3.Visible = false;
                    }
                    ddlAdjustOperate.SelectedValue = pay.adjust_operator;
                    ddlOperate.SelectedValue = pay.adjust_operator;
                    tbAdjustAmount.Text = ((decimal)pay.adjust_amount).ToString("F2");
                    tbRate.Text = ((decimal)pay.exchange_rate).ToString("F2");
                    tbReason.Text = pay.reason;
                    tbPayRemarks.Text = pay.remarks;
                    tbToCurrency.Text = pay.tocurrency;
                    tbTotal.Text = ((decimal)pay.total_amount).ToString("F2");
                    lblTotal.Text = ((decimal)pay.adjust_total).ToString("F2");
                    dcPaidDate.isEnabled(false);
                    dcPaidDate.setText(((DateTime)pay.pay_date).ToString("yyyy/MM/dd"));
                    lblF.Text = ((DateTime)pay.pay_date).ToString("yyyy/MM/dd");
                    try 
	                {	        
		                String f ;
                        WoWiModel.employee emp = (from e1 in wowidb.employees from d in wowidb.employee_jobtitle where e1.jobtitle_id== d.jobtitle_id & d.jobtitle_name=="Finance" select e1).First();
                        f = emp.fname.Trim() + "." + emp.lname.Trim();
                        imgF.ImageUrl = "../Images/sign/" + f + ".bmp";
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


    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            try
            {

                WoWiModel.PR_Payment pay = (from p in wowidb.PR_Payment where p.pr_id == id select p).First();
                pay.remarks = tbPayRemarks.Text;
                pay.status = (byte)PRStatus.ClosePaid;
                (sender as Button).Enabled = false;
                tbPayRemarks.Enabled = false;
                wowidb.SaveChanges();
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

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            Response.Redirect("~/Accounting/PRPayment.aspx?id=" + Request.QueryString["id"], false);
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
        .style1
        {
            height: 15px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
 
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
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="ccstextboxh" valign="top">
                <p>
                    Today:
                    <asp:Label ID="lblToday" runat="server" Text="lblToday"></asp:Label></p> <p>
                    Project No.:
                    <asp:Label ID="lblProjNo" runat="server" Text="lblProjNo"></asp:Label></p>
                    <u>Vender Infomation </u><br />
                Name:
                <asp:Label ID="lblName" runat="server" Text="lblName"></asp:Label>
                <p>
                    Address:
                    <asp:Label ID="lblAddress" runat="server" Text="lblAddress"></asp:Label></p>
            </td>  <td align="left" class="ccstextboxh"  valign="top" style="width:20%">
            </td>
            <td align="left" class="ccstextboxh"  valign="top">
                           <p>
                    Target Payment Date:
                    <asp:Label ID="lblTargetPDate" runat="server" Text="lblTargetPDate"></asp:Label></p> <p>
                    Qutation No.:
                    <asp:Label ID="lblQuoNo" runat="server" Text="lblQuoNo"></asp:Label></p>
                    <p><u>Vender Infomation </u><br />Contact:
                    
                            <asp:Label ID="lblContact" runat="server"></asp:Label><%--/nobr>--%></p>
                  
                             <p>Phone:
                     
                            <asp:Label ID="lblClientPhone" runat="server"></asp:Label><%--</nobr>--%></p>
                    
                             <p>Email:
             
                            <asp:Label ID="lblClientEmail" runat="server"></asp:Label></p>
                        </td>
                    </tr>
        <tr>
            <td colspan="3">
                <!-- start target -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                     <asp:GridView ID="BankGridView" runat="server" Width="100%" AutoGenerateColumns="False"  onprerender="GridView1_PreRender">
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
              <asp:Label runat="server" ID="lblWUB" Text="Western Union Banking Information :"  Visible="false"></asp:Label>
                                    <asp:GridView ID="WUBGridView" runat="server" Width="100%" AutoGenerateColumns="False"  >
                                       <Columns>
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
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
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
            <td class="ccstextboxh" valign="top"colspan="2" >
                <u>Internal Remarks</u><br />
                <asp:TextBox ID="tbRemarks" runat="server" Width="400px" Height="100px" 
                    Enabled="False"></asp:TextBox>
            </td>
            <td class="ccstextboxh" valign="top"colspan="2" >
                <u>External Instruction</u><br />
                <asp:TextBox ID="tbInstruction" runat="server" Width="400px" Height="100px" 
                    Enabled="False"></asp:TextBox>
            </td>
             </tr>
             <td class="ccstextboxh" colspan="4" width="100%">
                    <hr />
                </td>
             <tr>
            <td align="right" class="ccstextboxh" colspan="4" valign="top">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                 <tr>
                        <td align="right" class="ccstextboxh" >
                Original Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                     &nbsp;&nbsp;&nbsp;<asp:Label ID="lblOCurrency" runat="server" Text="lblOCurrency"></asp:Label>
                    </td>
                    <td align="right" class="ccstextboxh" >
                Original Total :
                    </td>
                    <td align="left" class="ccstextboxh" >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$ <asp:Label ID="lblOtotal" runat="server" Text="lblOtotal"></asp:Label>
                    </td>
                    </tr>
                   <tr>
                        <td align="right" class="ccstextboxh" >
                &nbsp;</td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;</td>
                    <td align="right" class="ccstextboxh" >
                Exchange Rate :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;&nbsp;<asp:DropDownList ID="ddlOperate" runat="server" Enabled="false"
                            AutoPostBack="True">
                            <asp:ListItem>*</asp:ListItem>
                            <asp:ListItem>/</asp:ListItem>
                        </asp:DropDownList>
               <asp:TextBox ID="tbRate" runat="server" AutoPostBack="True" Enabled="false"
                           ></asp:TextBox>
                    </td>
                    </tr>
                     <tr>
                        <td align="right" class="ccstextboxh" >
               
                            Adjust&nbsp;Reason :
               
                    </td>
                    <td align="left" class="ccstextboxh" >
                   &nbsp;&nbsp;&nbsp; <asp:TextBox ID="tbReason" runat="server" Enabled="false"
                            AutoPostBack="True" Width="300"></asp:TextBox>
                  
                    </td>
                    <td align="right" class="ccstextboxh" >
                Adjust Amount :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;<asp:DropDownList ID="ddlAdjustOperate" runat="server" Enabled="false"
                            AutoPostBack="True">
                            <asp:ListItem>+</asp:ListItem>
                            <asp:ListItem>-</asp:ListItem>
                        </asp:DropDownList>
               <asp:TextBox ID="tbAdjustAmount" runat="server" AutoPostBack="True" Enabled="false"
                            ></asp:TextBox>
                    </td>
                    </tr>
                    <tr>
                        <td align="right" class="ccstextboxh" >
                            Pay Currency :
                    </td>
                    <td align="left" class="ccstextboxh" >
                        &nbsp;&nbsp; &nbsp;<asp:TextBox ID="tbToCurrency" runat="server" Text="" Enabled="false"></asp:TextBox></td>
                    <td align="right" class="ccstextboxh" >
                        Balance Total :
                    </td>
                    <td align="left" class="ccstextboxh" >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$ <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
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
                       Convert To USD : 
                    </td>
                    <td align="left" class="ccstextboxh" >
                &nbsp;$ <asp:TextBox ID="tbTotal" runat="server" Text="" Enabled="false"></asp:TextBox>
                        </td>
                    
                    </tr>
                    <tr>
                    <td align="right" class="ccstextboxh" >
                       Remarks : 
                    </td>
                    <td align="left" class="ccstextboxh" >
                &nbsp;&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbPayRemarks" runat="server" Text="" ></asp:TextBox></td>
                    <td align="right" class="ccstextboxh" colspan="2" >
                        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" 
                            Text="Back to Modify" />
&nbsp;<asp:Button ID="btnSave" runat="server" Text="Paid" onclick="btnSave_Click" />
                    </td>
                    </tr>
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
                <td colspan="2">
                    <!-- Start Signature Section -->
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                             <th class="style1" width="20%">
                               Approve / Date
                            </th>
                            <th class="style1" width="20%">
                               Review / Date
                            </th>
                             <th class="style1" width="20%">
                               Preview / Date
                            </th>
                             <th class="style1" width="20%">
                               Requisite / Date
                            </th>
                            <th class="style1" width="20%">
                               Paid / Date
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
 <td class="ccstextboxh" align="center">
                                By <br><asp:Image 
                                    ID="imgF" runat="server" Height="31" Width="114"  /> <asp:Label ID="lblF" runat="server"
                                        Text=""></asp:Label>
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

   
   
     </form>
</body>
</html>
