<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">


    private void InitIndustryTechnology()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
            var data = db.clientapplicants.First(c => c.id == id);
            CheckBox cb = FormView1.FindControl("cbApplican") as CheckBox;
            if (data.clientapplicant_type == 3)
            {
                cb.Checked = true;
            }
            ClientApplicantUtils.InitIndustryData(id, FormView1, ClientApplicantUtils.Name_CheckBox_IndustryList);
            ClientApplicantUtils.InitTechnologyData(id, FormView1, ClientApplicantUtils.Name_CheckBox_TechnologyList);
        }
        catch
        {
        }
    }
  

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            InitIndustryTechnology();
        }
    }
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void GridView1_Load(object sender, EventArgs e)
    {
        String str = Request.QueryString["id"];
        int id = int.Parse(str);
        var data = from c in db.m_clientappliant_contact where c.clientappliant_id == id select c.contact_id;
        var result = db.contact_info.Where(c => data.Contains(c.id));
        GridView gv = (GridView)sender;
        gv.DataSource = result;
        gv.DataBind();
    }
   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 174px;
            height: 18px;
        }
        .style3
        {
            height: 18px;
        }
        .style4
        {
            height: 25px;
        }
        .style7
        {
            width: 20%;
        }
        .style9
        {
            width: 20%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="SqlDataSource6" DefaultMode="ReadOnly" Width="100%"  >
            <ItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Client Details Information &#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/ClientList.aspx">Client List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               
                               
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4"><%--Load from : <asp:DropDownList ID="dlClientList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   ></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" />&nbsp;--%>
                                  <%-- Client Code :&nbsp;
                                   <asp:Label ID="tbClientCode" runat="server" Text='<%# Bind("code") %>' 
                                       Width="80px"></asp:Label>--%>
                                   <asp:CheckBox Enabled="false"
                              ID="cbApplican" runat="server" Text="Is Applicant Also" />
                        <%--  <asp:CheckBox ID="cbpotential" runat="server" Text="Potential Client" Enabled="false"
                                       Checked='<%# Bind("potential_client") %>' />--%>
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Client Contact Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                           <asp:DropDownList ID="ddlDeptList" runat="server" Enabled="false"
                                                DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="id"  AppendDataBoundItems="True" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true'"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AppendDataBoundItems="true"  Enabled="false"
                                                SelectedValue='<%# Bind("employee_id") %>'  DataSourceID="SqlDataSource7" DataTextField="name" DataValueField="id"  >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                                   <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], ([fname]+[lname] )as name FROM [employee] WHERE [status] = 'Active'"></asp:SqlDataSource>

                                        </td></tr>
                        <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%">
                                <asp:Label ID="tbCompany" runat="server" 
                                       Text='<%# Bind("companyname") %>'></asp:Label></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                <asp:Label 
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Company URI:</th><td 
                                   width="30%">
                              <asp:Label ID="tbCompanyURL" runat="server" 
                                       Text='<%# Bind("website") %>'></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Business Type:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList1" runat="server"  Enabled="false"
                                           SelectedValue='<%# Bind("businesstype") %>'>
                                 <asp:ListItem Value="0">Manufacturer</asp:ListItem>
                                  <asp:ListItem Value="1">Company</asp:ListItem>
                                  <asp:ListItem Value="2">Lab</asp:ListItem>
                                  <asp:ListItem Value="3">Consultant</asp:ListItem>
                              </asp:DropDownList>
                          </td></tr>
                          
                          <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Main Phone:</th><td width="30%">
                                  <asp:Label 
                                       ID="tbTel" runat="server" Text='<%# Bind("main_tel") %>'></asp:Label></td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Main Fax:&nbsp;</th><td width="30%">
                                  <asp:Label 
                                       ID="tbFax" runat="server" Text='<%# Bind("main_fax") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Address:&#160;</th><td 
                                   width="30%"><asp:Label ID="tbAddress" runat="server" 
                                       Text='<%# Bind("address") %>' Width="211px"></asp:Label></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%"><asp:Label 
                                       ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' Width="211px"></asp:Label></td></tr>
                                       
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">* </font>Country:&#160;</th>
                                   <td 
                                   width="30%">
                              <asp:DropDownList ID="dlCountry" runat="server" Enabled="false"
                                 DataTextField="country_name"  DataSourceID="SqlDataSource1"
                                  DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; <b>Annual Number project</b>:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("grant_rank") %>' Enabled="false">
                                 <asp:ListItem Value="0">&nbsp; 0 -&nbsp; 5 </asp:ListItem>
                                  <asp:ListItem Value="1">&nbsp;  6 - 10</asp:ListItem>
                                  <asp:ListItem Value="2"> 11 - 20</asp:ListItem>
                                  <asp:ListItem Value="3"> 21 - 30</asp:ListItem>
                                  <asp:ListItem Value="4"> 31 - 40</asp:ListItem>
                                  <asp:ListItem Value="5"> 41 - 50</asp:ListItem>

                              </asp:DropDownList>
                          </td></tr>
                      
                                            
                                             <tr><td 
                               align="left" colspan="4"><b>&#160; Industry: </b><br />
                                                 <asp:CheckBoxList Enabled="false"
                               ID="clIndustryList" runat="server" 
                               DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                                 <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                     ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                     SelectCommand="SELECT [id], [name] FROM [clientapplicant_industry] where [publish] = 'true'"></asp:SqlDataSource>
                                                 </td></tr>
                               <tr><td 
                               align="left" colspan="4"><b>&#160; Technologies: </b><br />
                                   <asp:CheckBoxList 
                               ID="clTechnologyList" runat="server" Enabled="false"
                               DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="id" 
                               RepeatColumns="5" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                       ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                       SelectCommand="SELECT [id], [name] FROM [clientapplicant_technology] where [publish] = 'true'"></asp:SqlDataSource>
                                   </td></tr>
                               

                                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Billing Information
                               
                                    </th>
                        </tr>
                                 <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%">
                                         <asp:Label ID="tbBillCompany" runat="server" 
                                       Text='<%# Bind("bill_companyname") %>'></asp:Label></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                         <asp:Label 
                                       ID="tbcBillCompany" runat="server" Text='<%# Bind("bill_ccompanyname") %>'></asp:Label></td></tr>
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>First Name:</th><td 
                                   width="30%"><asp:Label ID="tbTel1" runat="server" 
                                       Text='<%# Bind("bill_firstname") %>'></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>姓:</th><td width="30%">
                                               <asp:Label 
                                       ID="tbFax1" runat="server" Text='<%# Bind("c_bill_lastname") %>'></asp:Label></td></tr>
                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Last Name:</th><td 
                                   width="30%"><asp:Label ID="Label11" runat="server" 
                                       Text='<%# Bind("bill_lastname") %>'></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>名:</th><td width="30%">
                                               <asp:Label
                                       ID="Label2" runat="server" Text='<%# Bind("c_bill_firstname") %>'></asp:Label></td></tr>


                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Title:</th><td 
                                   width="30%"><asp:Label ID="tbEmail" runat="server" 
                                       Text='<%# Bind("bill_title") %>'></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:Label 
                                       ID="tbBillEmail" runat="server" Text='<%# Bind("bill_email") %>' Enabled="false"></asp:Label></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   width="30%"><asp:Label ID="tbBillTel" runat="server" 
                                       Text='<%# Bind("bill_workphone") %>'></asp:Label>&nbsp;Ext : &nbsp;<asp:Label ID="tbBillExt" Enabled="false"
                                                   runat="server" Height="21px" Text='<%# Bind("bill_ext") %>' Width="30px"></asp:Label>
                                               &nbsp;&nbsp;&nbsp;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Fax:</th><td width="30%">
                                               <asp:Label 
                                       ID="tbBillFax" runat="server" Text='<%# Bind("bill_fax") %>' Enabled="false"></asp:Label></td></tr>
                               <tr>
                                   <th align="left" class="style9">
                                       <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbBillAddress" runat="server" Text='<%# Bind("bill_address") %>' Enabled="false"
                                           Width="211px"></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; 地址:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbCBillAddress" runat="server" Text='<%# Bind("bill_caddress") %>' Enabled="false"
                                           Width="211px"></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp; Country:&nbsp;</th>
                                   <td  width="30%">
                                       <asp:DropDownList ID="dlBillCountry" runat="server" Enabled="false"                                      DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                           DataValueField="country_id">
                                       </asp:DropDownList>
                                   </td>
                                   <th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server" Enabled="false"
                                                   SelectedValue='<%# Bind("paymentterm") %>' >
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                    <asp:ListItem Value="0">支票 Check</asp:ListItem>
                                                   <asp:ListItem Value="1">國內匯款 Domestic Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="6">國外匯款 Foreign Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="2">匯票 Cashier Check</asp:ListItem>
                                                   <asp:ListItem Value="3">信用卡 Credit Card</asp:ListItem>
                                                   <asp:ListItem Value="4">現金 Cash</asp:ListItem>
                                                   <asp:ListItem Value="5">西聯匯款 Westerm Union</asp:ListItem>
                                               </asp:DropDownList>
                                               
                                           </td>
                                 
                               </tr>
                               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                 <th colspan="4">
                                       Client Accounting Information</th>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Account No.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbAcctNo" runat="server" Text='<%# Bind("acctno") %>' Enabled="false"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; AE:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlAcctMgr" runat="server" AppendDataBoundItems="True" 
                                           datasourceid="SqlDataSource5" DataTextField="un" DataValueField="id" Enabled="false"
                                           SelectedValue='<%# Bind("acct_manager") %>'>
                                           <asp:ListItem Value="-1">None</asp:ListItem>
                                       </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                                           ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                           SelectCommand="SELECT [id], [fname]+[lname] As [un]  FROM [employee]">
                                       </asp:SqlDataSource>
                                   </td>
                               </tr>
                               <tr>
                                  <th align="left" class="style10">
                                       &nbsp;&nbsp; Credit Limit:</th>
                                   <td class="style11" width="30%">
                                       <asp:TextBox ID="tbCreditLimit" runat="server" Enabled="false"
                                           Text='<%# Bind("creditlimit") %>'></asp:TextBox>
                                   </td>
                                   <th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td colspan="3">
                                             <asp:DropDownList ID="ddlPaymentDays" runat="server" Enabled="false"
                                                 SelectedValue='<%# Bind("paymentdays") %>'>
                                                 <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                 <asp:ListItem Value="0">ASAP</asp:ListItem>
                                                 <asp:ListItem Value="7">  7 days</asp:ListItem>
                                                 <asp:ListItem Value="15"> 15 days</asp:ListItem>
                                                 <asp:ListItem Value="30"> 30 days</asp:ListItem>
                                                 <asp:ListItem Value="45"> 45 days</asp:ListItem>
                                                 <asp:ListItem Value="60"> 60 days</asp:ListItem>
                                                 <asp:ListItem Value="90"> 90 days</asp:ListItem>
                                                 <asp:ListItem Value="120">120 days</asp:ListItem>
                                             </asp:DropDownList>
                                           </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Fedex Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbFedexAcct" runat="server" Text='<%# Bind("fedex_acct") %>' Enabled="false"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Client Status:&nbsp;</th>
                                   <td class="style11" width="30%">
                                       <asp:DropDownList ID="dlClientStatus" runat="server" Enabled="false"
                                           SelectedValue='<%# Bind("clientstatus") %>'>
                                          <asp:ListItem Value="0">- Select -</asp:ListItem>
                                           <asp:ListItem Value="1">Active</asp:ListItem>
                                           <asp:ListItem Value="2">In-Active</asp:ListItem>
                                           <asp:ListItem Value="3">On Hold</asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;UPS Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("ups_accountno") %>' Enabled="false"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; DHL Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbDhlAcct" runat="server" Text='<%# Bind("dhl_acct") %>' Enabled="false"></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                  <th align="left" class="style7">
                                       &nbsp; 統一編號:&nbsp;</th>
                                   <td colspan="3">
                                       <asp:TextBox ID="tbBusinessRN" runat="server" Text='<%# Bind("business_registration_number") %>' Enabled="false"
                                           Width="211px"></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp;&nbsp;Bank Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankName" runat="server" Text='<%# Bind("ups_bankname") %>' Enabled="false"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Bank Branch:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankBranch" runat="server" Text='<%# Bind("ups_bankbranch") %>' Enabled="false"></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Bank Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankAddress" runat="server" Enabled="false"
                                           Text='<%# Bind("ups_bankaddress") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Swift Code:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbSwiftCode" runat="server" Enabled="false"
                                           Text='<%# Bind("ups_swiftcode") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Beneficiary Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBanefucuanyName" runat="server" Enabled="false"
                                           Text='<%# Bind("ups_banefucuanyname") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Passby Bank:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbPassbyBank" runat="server" Enabled="false"
                                           Text='<%# Bind("ups_passbybank") %>'></asp:TextBox>
                                   </td>
                               </tr>
                                  <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Accounting Contact Information</th>
                               </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Name:</th><td 
                                   width="30%"><asp:TextBox ID="tbcontactname" runat="server" Enabled="false"
                                       Text='<%# Bind("contact_name") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:TextBox Enabled="false"
                                       ID="TextBox5" runat="server" Text='<%# Bind("contact_email") %>'></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   colspan="3"><asp:TextBox ID="tbaccttel" runat="server" Enabled="false"
                                       Text='<%# Bind("contact_tel") %>'></asp:TextBox>&nbsp;Ext : &nbsp;<asp:TextBox ID="TextBox7" Enabled="false"
                                                   runat="server" Height="21px" Text='<%# Bind("contact_ext") %>' Width="30px"></asp:TextBox>
                                               &nbsp;&nbsp;&nbsp;</td>
                  </tr>
                  <%-- <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Remark</th>
                               </tr>
                               
                  <tr>
                                   <td colspan="4">
                                       <asp:TextBox ID="TextBox3" runat="server" Height="70" TextMode="MultiLine" Text='<%# Bind("remark") %>'
                                           Width="100%"></asp:TextBox>
                                   </td>
                               </tr>
--%>
                                             <tr>

                               
                                <tr><td align="left" colspan="4">
                                Contact :
                                    <asp:GridView ID="GridView1" runat="server" Width="100%"
                                        onload="GridView1_Load" AutoGenerateColumns="False" >
                                        <Columns>
                                           <asp:TemplateField InsertVisible="False" SortExpression="id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                        NavigateUrl='<%# Bind("id","~/Common/ContactDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" SortExpression="fname">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("fname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Eval("fname") %>'></asp:Label>
                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Eval("lname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="姓名" SortExpression="lname">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("c_lname") %>'></asp:Label>
                    &nbsp;<asp:Label ID="Label4" runat="server" Text='<%# Eval("c_fname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="title" SortExpression="title" HeaderText="Title" />
            <asp:BoundField DataField="email" HeaderText="Email" 
                SortExpression="email" />
            <asp:BoundField DataField="workphone" HeaderText="Work Phone" 
                SortExpression="workphone" />
            <asp:BoundField DataField="ext" HeaderText="Ext" 
                SortExpression="ext" />
            <asp:BoundField DataField="cellphone" HeaderText="Cellphone" 
                SortExpression="cellphone" />
                                        </Columns>
                                    </asp:GridView>
                                   
              </td>
              </tr>
               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Remark</th>
                               </tr>
                               <tr>
                                   <td colspan="4">
                                       <asp:Label ID="tbRemarks" runat="server" Height="70" TextMode="MultiLine" Text='<%# Bind("remark") %>' Enabled="false"
                                           Width="100%"></asp:Label>
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
                            <asp:Label ID="Label21" runat="server" Text='<%# Bind("create_user") %>'></asp:Label>
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
                   
                </table>
            </td>
        </tr>
                                            
                                            
                                            </table>
                </ContentTemplate>
                 
                </asp:UpdatePanel>
            </ItemTemplate>
        </asp:FormView>
         <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        SelectCommand="SELECT * FROM [clientapplicant] WHERE ([id] = @id)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
                        </SelectParameters>
    </asp:SqlDataSource>           
               
   
</asp:Content>

