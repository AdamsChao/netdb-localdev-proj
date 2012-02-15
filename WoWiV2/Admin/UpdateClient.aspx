<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_IndustryList, ViewState, ClientApplicantUtils.Key_ViewState_Industry);
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_TechnologyList, ViewState, ClientApplicantUtils.Key_ViewState_Technologies);
        ViewState["IsApplication"] = (this.FormView1.FindControl("cbApplican") as CheckBox).Checked;
    }

        
    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.clientapplicant obj = (WoWiModel.clientapplicant)e.Entity;
            List<int> industry = (List<int>)ViewState[ClientApplicantUtils.Key_ViewState_Industry];
            List<int> technology = (List<int>)ViewState[ClientApplicantUtils.Key_ViewState_Technologies];
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                var data = db.m_clientappliant_industry;
                try
                {
                    var delList = from c in data where c.clientappliant_id == obj.id select c;
                    foreach (WoWiModel.m_clientappliant_industry item in delList)
                    {
                        data.DeleteObject(item);
                    }
                }
                catch (Exception ex)
                {
                }
                if (industry.Count != 0)
                {
                    
                    foreach (int id in industry)
                    {
                        var d = new WoWiModel.m_clientappliant_industry()
                        {
                            clientappliant_id = obj.id,
                            industry_id = id
                        };
                        data.AddObject(d);
                    }
                }
                var tdata = db.m_clientappliant_technology;
                try
                {
                    var delList = from c in tdata where c.clientappliant_id == obj.id select c;
                    foreach (WoWiModel.m_clientappliant_technology item in delList)
                    {
                        tdata.DeleteObject(item);
                    }
                }
                catch (Exception ex)
                {
                }
                if (technology.Count != 0)
                {

                    foreach (int id in technology)
                    {
                        var d = new WoWiModel.m_clientappliant_technology()
                        {
                            clientappliant_id = obj.id,
                            technology_id = id
                        };
                        tdata.AddObject(d);
                    }
                }
                
                try
                {
                    db.SaveChanges();
                }
                catch
                {
                }
            }

            ViewState.Remove(ClientApplicantUtils.Key_ViewState_Industry);
            ViewState.Remove(ClientApplicantUtils.Key_ViewState_Technologies);
            Response.Redirect("~/Common/SelectExistContact.aspx?id=" + obj.id + "&type=client&mode=update");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        InitIndustryTechnology();
    }


    private void InitIndustryTechnology()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            ClientApplicantUtils.InitIndustryData(id, FormView1, ClientApplicantUtils.Name_CheckBox_IndustryList);
            ClientApplicantUtils.InitTechnologyData(id, FormView1, ClientApplicantUtils.Name_CheckBox_TechnologyList);
        }
        catch
        {
        }
    }
   

    protected void EntityDataSource1_Updating(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.clientapplicant obj = (WoWiModel.clientapplicant)e.Entity;
        if ((bool)ViewState["IsApplication"])
        {
            obj.clientapplicant_type = 3;
        }
        else
        {
            obj.clientapplicant_type = 1;
        }
        obj.modify_date = DateTime.Now;
        obj.modify_user = User.Identity.Name;
    }



    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            InitIndustryTechnology();
        }
    }

    protected void cbAsClient_CheckedChanged(object sender, EventArgs e)
    {
        FormView fv = this.FormView1;
        CopyContent(fv, "tbCompany", "tbBillCompany");
        CopyContent(fv, "tbcCompany", "tbcBillCompany");
        CopyContent(fv, "tbTel", "tbBillTel");
        CopyContent(fv, "tbFax", "tbBillFax");
        CopyContent(fv, "tbAddress", "tbBillAddress");
        CopyContent(fv, "tbcAddress", "tbcBillAddress");
        (fv.FindControl("dlBillCountry") as DropDownList).SelectedValue = (fv.FindControl("dlCountry") as DropDownList).SelectedValue;
    }
    private void CopyContent(FormView fv, String fromID, String toID)
    {
        (fv.FindControl(toID) as TextBox).Text = (fv.FindControl(fromID) as TextBox).Text;
    } 
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            height: 25px;
        }
        .style7
        {
            width: 15%;
        }
        .style9
        {
            width: 15%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="100%" onitemupdating="FormView1_ItemUpdating" >
            
            <EditItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Client Information Modification&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/ClientList.aspx">Client List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               
                               
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4"><%--Load from : <asp:DropDownList ID="dlClientList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   ></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" />&nbsp;--%>
                                   Client Code :&nbsp;
                                   <asp:TextBox ID="tbClientCode" runat="server" Text='<%# Bind("code") %>' 
                                       Width="80px"></asp:TextBox>
                                   <asp:CheckBox 
                              ID="cbApplican" runat="server" Text="Is Applicant Also" />
                          <asp:CheckBox ID="cbpotential" runat="server" Text="Potential Client" 
                                       Checked='<%# Bind("potential_client") %>' />
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Client Contact Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%">
                                <asp:TextBox ID="tbCompany" runat="server" 
                                       Text='<%# Bind("companyname") %>'></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                <asp:TextBox 
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Company URI:</th><td 
                                   width="30%">
                              <asp:TextBox ID="tbCompanyURL" runat="server" 
                                       Text='<%# Bind("website") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Business Type:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList1" runat="server" 
                                           SelectedValue='<%# Bind("businesstype") %>'>
                                  <asp:ListItem Value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:ListItem>
                                  <asp:ListItem Value="1">Company</asp:ListItem>
                                  <asp:ListItem Value="2">Lab</asp:ListItem>
                                  <asp:ListItem Value="3">Consultant</asp:ListItem>
                              </asp:DropDownList>
                          </td></tr>
                          
                          <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Main Phone:</th><td width="30%">
                                  <asp:TextBox 
                                       ID="tbTel" runat="server" Text='<%# Bind("main_tel") %>'></asp:TextBox></td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Main Fax:&nbsp;</th><td width="30%">
                                  <asp:TextBox 
                                       ID="tbFax" runat="server" Text='<%# Bind("main_fax") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Address:&#160;</th><td 
                                   width="30%"><asp:TextBox ID="tbAddress" runat="server" 
                                       Text='<%# Bind("address") %>' Width="211px"></asp:TextBox></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' Width="211px"></asp:TextBox></td></tr>
                                       
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">* </font>Country:&#160;</th>
                                   <td 
                                   width="30%">
                              <asp:DropDownList ID="dlCountry" runat="server" 
                                 DataTextField="country_name"  DataSourceID="SqlDataSource1"
                                  DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; <b>Annual Number Grants</b>:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("grant_rank") %>'>
                                  <asp:ListItem Value="0">&nbsp; 0 -&nbsp; 5 grants</asp:ListItem>
                                  <asp:ListItem Value="1">&nbsp;  6 - 10 grants</asp:ListItem>
                                  <asp:ListItem Value="2"> 11 - 15 grants</asp:ListItem>
                                  <asp:ListItem Value="3"> 16 - 20 grants</asp:ListItem>
                                  <asp:ListItem Value="4">&nbsp; &gt;&nbsp;&nbsp; 20 grants</asp:ListItem>

                              </asp:DropDownList>
                          </td></tr>
                      
                                            
                                             <tr><td 
                               align="left" colspan="4"><b>&#160; Industry: </b><br />
                                                 <asp:CheckBoxList 
                               ID="clIndustryList" runat="server" 
                               DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                                 <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                     ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                     SelectCommand="SELECT [id], [name] FROM [clientapplicant_industry]"></asp:SqlDataSource>
                                                 </td></tr>
                               <tr><td 
                               align="left" colspan="4"><b>&#160; Technologies: </b><br />
                                   <asp:CheckBoxList 
                               ID="clTechnologyList" runat="server" 
                               DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="id" 
                               RepeatColumns="5" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                       ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                       SelectCommand="SELECT [id], [name] FROM [clientapplicant_technology]"></asp:SqlDataSource>
                                   </td></tr>
                               

                                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Billing Information
                                <asp:CheckBox ID="cbAsClient" runat="server" AutoPostBack="True" 
                                    oncheckedchanged="cbAsClient_CheckedChanged" Text="Same As Client" />
                                    </th>
                        </tr>
                                 <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%">
                                         <asp:TextBox ID="tbBillCompany" runat="server" 
                                       Text='<%# Bind("bill_companyname") %>'></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                         <asp:TextBox 
                                       ID="tbcBillCompany" runat="server" Text='<%# Bind("bill_ccompanyname") %>'></asp:TextBox></td></tr>
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>First Name:</th><td 
                                   width="30%"><asp:TextBox ID="tbTel1" runat="server" 
                                       Text='<%# Bind("bill_firstname") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>姓:</th><td width="30%">
                                               <asp:TextBox 
                                       ID="tbFax1" runat="server" Text='<%# Bind("c_bill_lastname") %>'></asp:TextBox></td></tr>
                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Last Name:</th><td 
                                   width="30%"><asp:TextBox ID="TextBox1" runat="server" 
                                       Text='<%# Bind("bill_lastname") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>名:</th><td width="30%">
                                               <asp:TextBox 
                                       ID="TextBox2" runat="server" Text='<%# Bind("c_bill_firstname") %>'></asp:TextBox></td></tr>


                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Title:</th><td 
                                   width="30%"><asp:TextBox ID="tbEmail" runat="server" 
                                       Text='<%# Bind("bill_title") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:TextBox 
                                       ID="tbBillEmail" runat="server" Text='<%# Bind("bill_email") %>'></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   width="30%"><asp:TextBox ID="tbBillTel" runat="server" 
                                       Text='<%# Bind("bill_workphone") %>'></asp:TextBox>&nbsp;Ext : &nbsp;<asp:TextBox ID="tbBillExt" 
                                                   runat="server" Height="21px" Text='<%# Bind("bill_ext") %>' Width="30px"></asp:TextBox>
                                               &nbsp;&nbsp;&nbsp;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Fax:</th><td width="30%">
                                               <asp:TextBox 
                                       ID="tbBillFax" runat="server" Text='<%# Bind("bill_fax") %>'></asp:TextBox></td></tr>
                               <tr>
                                   <th align="left" class="style9">
                                       <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBillAddress" runat="server" Text='<%# Bind("bill_address") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; 地址:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbCBillAddress" runat="server" Text='<%# Bind("bill_caddress") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                               </tr>
                              <tr>
                                   <th align="left" class="style9">
                                       &nbsp; Country:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlBillCountry" runat="server" 
                                           DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                           DataValueField="country_id">
                                       </asp:DropDownList>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Payment days:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbPaymentDays" runat="server" Text='<%# Bind("paymentdays") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                                  
                               </tr>
                               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Client Accounting Information</th>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp; Owner:</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlOwner" runat="server" AppendDataBoundItems="True" 
                                           datasourceid="SqlDataSource5" DataTextField="un" DataValueField="id" 
                                           SelectedValue='<%# Bind("owner") %>'>
                                           <asp:ListItem Value="-1">None</asp:ListItem>
                                       </asp:DropDownList>
                                       <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                           ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                           SelectCommand="SELECT [id], [fname]+[lname] As [un]  FROM [employee]">
                                       </asp:SqlDataSource>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; Acct Manager:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlAcctMgr" runat="server" AppendDataBoundItems="True" 
                                           datasourceid="SqlDataSource5" DataTextField="un" DataValueField="id" 
                                           SelectedValue='<%# Bind("acct_manager") %>'>
                                           <asp:ListItem Value="-1">None</asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Account No.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbAcctNo" runat="server" Text='<%# Bind("acctno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlPaymentTerm" runat="server" 
                                           SelectedValue='<%# Bind("paymentterm") %>'>
                                           <asp:ListItem  Value="0" >Net 30</asp:ListItem>
                                           <asp:ListItem  Value="1" >Cash</asp:ListItem>
                                           <asp:ListItem Value="2">Advance payment</asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Credit Limit:</th>
                                   <td class="style11" width="30%">
                                       <asp:TextBox ID="tbCreditLimit" runat="server" 
                                           Text='<%# Bind("creditlimit") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Client Status:&nbsp;</th>
                                   <td class="style11" width="30%">
                                       <asp:DropDownList ID="dlClientStatus" runat="server" 
                                           SelectedValue='<%# Bind("clientstatus") %>'>
                                           <asp:ListItem>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          </asp:ListItem>
                                           <asp:ListItem>Active</asp:ListItem>
                                           <asp:ListItem>In-Active</asp:ListItem>
                                           <asp:ListItem>On Hold</asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Fedex Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbFedexAcct" runat="server" Text='<%# Bind("fedex_acct") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; DHL Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbDhlAcct" runat="server" Text='<%# Bind("dhl_acct") %>'></asp:TextBox>
                                   </td>
                               </tr>
                             <%--  <tr align="center">
                                   <th colspan="4">
                                       UPS Accounting Information</th>
                               </tr>--%>
                                <tr >
                                  
                                        <th align="left" class="style7">
                                       &nbsp; 統一編號:&nbsp;</th>
                                   <td colspan="3">
                                       <asp:TextBox ID="Label5" runat="server" Text='<%# Bind("business_registration_number") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;UPS Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("ups_accountno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Bank Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankName" runat="server" Text='<%# Bind("ups_bankname") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Bank Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankAddress" runat="server" 
                                           Text='<%# Bind("ups_bankaddress") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Swift Code:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbSwiftCode" runat="server" 
                                           Text='<%# Bind("ups_swiftcode") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Banefucuany Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBanefucuanyName" runat="server" 
                                           Text='<%# Bind("ups_banefucuanyname") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Passby Bank:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbPassbyBank" runat="server" 
                                           Text='<%# Bind("ups_passbybank") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Remark</th>
                               </tr>
                               <tr>
                                   <td colspan="4">
                                       <asp:TextBox ID="tbRemarks" runat="server" Height="70" TextMode="MultiLine" 
                                           Width="100%"></asp:TextBox>
                                   </td>
                               </tr>

                                             <tr>
            <td colspan="4">
                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                    <tr align="center">
                        <th width="25%">
                            Create Date</th>
                        <th width="25%">
                            Create User</th>
                        <th width="25%">
                            Last Modified Date</th>
                        <th width="25%">
                            Modify User</th>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("create_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("create_user") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("modify_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("modify_user") %>'></asp:Label>
                        </td>
                    </tr>
                       
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="style4" colspan="4" >
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Update" />
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;</td>
                                </tr>
                </table>
            </td>
        </tr>
                                            
                                            
                                            </table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="UpdateButton" />
                  </Triggers>
                </asp:UpdatePanel>
            </EditItemTemplate>
        </asp:FormView>
                    <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="False" EntitySetName="clientapplicants"
              onupdated="EntityDataSource1_Updated" Where="it.id == @id" 
                    onupdating="EntityDataSource1_Updating" EnableUpdate="True" >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
         
         
               
   
</asp:Content>

