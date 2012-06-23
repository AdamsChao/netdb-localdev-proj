<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_IndustryList, ViewState, ClientApplicantUtils.Key_ViewState_Industry);
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_TechnologyList, ViewState, ClientApplicantUtils.Key_ViewState_Technologies);
        ViewState["IsClient"] = (this.FormView1.FindControl("cbClient") as CheckBox).Checked;
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
            Response.Redirect("~/Common/SelectExistContact.aspx?id=" + obj.id + "&type=applicant&mode=update");
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
        if ((bool)ViewState["IsClient"])
        {
            obj.clientapplicant_type = 3;
        }
        else
        {
            obj.clientapplicant_type = 2;
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
        (fv.FindControl(toID) as Label).Text = (fv.FindControl(fromID) as Label).Text;
    }

    protected void cbApplican_CheckedChanged(object sender, EventArgs e)
    {
        ViewState["IsClient"] = cbClient.Checked;
        Panel1.Visible = cbClient.Checked;
    }

    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void GridView1_Load(object sender, EventArgs e)
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            var data = from c in db.m_clientappliant_contact where c.clientappliant_id == id select c.contact_id;
            var result = db.contact_info.Where(c => data.Contains(c.id));
            GridView gv = (GridView)sender;
            gv.DataSource = result;
            gv.DataBind();
        }
        catch (Exception)
        {
            
            //throw;
        }
        
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
            DataSourceID="EntityDataSource1" DefaultMode="ReadOnly" Width="100%" onitemupdating="FormView1_ItemUpdating" >
            
            <ItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Applicant Details Information&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/ApplicantList.aspx">Applicant List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               
                               
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4"><%--Load from : <asp:DropDownList ID="dlClientList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   ></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" />&nbsp;--%>
                                   <asp:CheckBox 
                              ID="cbClient" runat="server" Text="Is Client Also" AutoPostBack="True" Enabled="false"
                                       oncheckedchanged="cbApplican_CheckedChanged" Checked='<%# (int.Parse(Eval("clientapplicant_type").ToString()) == 3 ? true : false) %>' />
                          </td></tr>
                               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Applicant Contact Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                            <asp:DropDownList ID="ddlDeptList" runat="server" Enabled="false"
                                                DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="id" 
                                                 AppendDataBoundItems="True" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                ControlToValidate="ddlDeptList" ErrorMessage="Please select access level." 
                                                Font-Bold="True" ForeColor="Red" InitialValue="-1" >*</asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                           <asp:DropDownList ID="ddlEmployeeList" runat="server" AppendDataBoundItems="true" Enabled="false"
                                                SelectedValue='<%# Bind("employee_id") %>'  DataSourceID="SqlDataSource7" DataTextField="name" DataValueField="id"  >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="ddlEmployeeList" 
                                                ErrorMessage="Please select created by which user." Font-Bold="True" 
                                                ForeColor="Red" InitialValue="-1" ValidationGroup="VenderGroup">*</asp:RequiredFieldValidator>
                                                   <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], ([fname]+[lname] )as name FROM [employee] WHERE [status] = 'Active'"></asp:SqlDataSource>
                                        </td></tr>
                        <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%">
                                <asp:TextBox Enabled="false" ID="tbCompany" runat="server"
                                       Text='<%# Bind("companyname") %>' Width="300px"></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                <asp:TextBox Enabled="false"
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>' 
                                    Width="300px"></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Company URI:</th><td 
                                   width="30%">
                              <asp:TextBox Enabled="false" ID="tbCompanyURL" runat="server" 
                                       Text='<%# Bind("website") %>' Width="360px"></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Business Type:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList1" runat="server" Enabled="false"
                                           SelectedValue='<%# Bind("businesstype") %>'>
                                     <asp:ListItem Value="0">Manufacturer</asp:ListItem>
                                  <asp:ListItem Value="1">Company</asp:ListItem>
                                  <asp:ListItem Value="2">Lab</asp:ListItem>
                                  <asp:ListItem Value="3">Consultant</asp:ListItem>
                              </asp:DropDownList>
                          </td></tr>
                          
                          <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Main Phone:</th><td width="30%">
                                  <asp:TextBox Enabled="false" 
                                       ID="tbTel" runat="server" Text='<%# Bind("main_tel") %>'></asp:TextBox></td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Main Fax:&nbsp;</th><td width="30%">
                                  <asp:TextBox Enabled="false" 
                                       ID="tbFax" runat="server" Text='<%# Bind("main_fax") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Address:&#160;</th><td 
                                   width="30%">
                                       <asp:TextBox Enabled="false" ID="tbAddress" runat="server" 
                                       Text='<%# Bind("address") %>' Width="360px"></asp:TextBox></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%">
                                       <asp:TextBox Enabled="false" 
                                       ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' Width="360px"></asp:TextBox></td></tr>
                                       
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">* </font>Country:&#160;</th>
                                   <td 
                                   width="30%">
                              <asp:DropDownList Enabled="false" ID="dlCountry" runat="server" 
                                 DataTextField="country_name"  DataSourceID="SqlDataSource1"
                                  DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; <b>Annual Number Grants</b>:</th><td width="30%">
                              <asp:DropDownList Enabled="false" ID="DropDownList2" runat="server" SelectedValue='<%# Bind("grant_rank") %>'>
                                   <asp:ListItem Value="0">&nbsp; 0 -&nbsp; 5 </asp:ListItem>
                                  <asp:ListItem Value="1">&nbsp;  6 - 10</asp:ListItem>
                                  <asp:ListItem Value="2"> 11 - 20</asp:ListItem>
                                  <asp:ListItem Value="3"> 21 - 30</asp:ListItem>
                                  <asp:ListItem Value="4"> 31 - 40</asp:ListItem>
                                  <asp:ListItem Value="5"> 41 - 50</asp:ListItem>

                              </asp:DropDownList>
                          </td></tr>
                      
                                <asp:Panel ID="Panel1" runat="server" Visible='<%# (int.Parse(Eval("clientapplicant_type").ToString()) == 3 ? true : false) %>'>
                                              
                                             <tr><td 
                               align="left" colspan="4"><b>&#160; Industry: </b><br />
                                                 <asp:CheckBoxList 
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
                               ID="clTechnologyList" runat="server" 
                               DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="id" 
                               RepeatColumns="5" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                       ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                       SelectCommand="SELECT [id], [name] FROM [clientapplicant_technology] where [publish] = 'true'"></asp:SqlDataSource>
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
                                         <asp:TextBox Enabled="false" ID="tbBillCompany" runat="server" 
                                       Text='<%# Bind("bill_companyname") %>' Width="300px"></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%">
                                         <asp:TextBox Enabled="false" 
                                       ID="tbcBillCompany" runat="server" Text='<%# Bind("bill_ccompanyname") %>' Width="300px"></asp:TextBox></td></tr>
                                       
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>First Name:</th><td 
                                   width="30%"><asp:TextBox Enabled="false" ID="tbTel1" runat="server" 
                                       Text='<%# Bind("bill_firstname") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>姓:</th><td width="30%">
                                               <asp:TextBox Enabled="false" 
                                       ID="tbFax1" runat="server" Text='<%# Bind("c_bill_lastname") %>'></asp:TextBox></td></tr>
                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Last Name:</th><td 
                                   width="30%"><asp:TextBox Enabled="false" ID="TextBox1" runat="server" 
                                       Text='<%# Bind("bill_lastname") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>名:</th><td width="30%">
                                               <asp:TextBox Enabled="false" 
                                       ID="TextBox2" runat="server" Text='<%# Bind("c_bill_firstname") %>'></asp:TextBox></td></tr>


                                        <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Title:</th><td 
                                   width="30%"><asp:TextBox Enabled="false" ID="tbEmail" runat="server" 
                                       Text='<%# Bind("bill_title") %>' Width="250px"></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:TextBox Enabled="false" 
                                       ID="tbBillEmail" runat="server" Text='<%# Bind("bill_email") %>' Width="250px"></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   width="30%"><asp:TextBox Enabled="false" ID="tbBillTel" runat="server" 
                                       Text='<%# Bind("bill_workphone") %>'></asp:TextBox>&nbsp;Ext : &nbsp;<asp:TextBox Enabled="false" ID="tbBillExt" 
                                                   runat="server" Height="21px" Text='<%# Bind("bill_ext") %>' Width="30px"></asp:TextBox>
                                               &nbsp;&nbsp;&nbsp;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Fax:</th><td width="30%">
                                               <asp:TextBox Enabled="false" 
                                       ID="tbBillFax" runat="server" Text='<%# Bind("bill_fax") %>'></asp:TextBox></td></tr>
                               <tr>
                                   <th align="left" class="style9">
                                       <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbBillAddress" runat="server" Text='<%# Bind("bill_address") %>' 
                                           Width="360px"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; 地址:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbCBillAddress" runat="server" Text='<%# Bind("bill_caddress") %>' 
                                           Width="360px"></asp:TextBox>
                                   </td>
                               </tr>
                              <tr>
                                   <th align="left" class="style9">
                                       &nbsp; Country:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlBillCountry" runat="server" Enabled="false"
                                 DataTextField="country_name"  DataSourceID="SqlDataSource8" AppendDataBoundItems="true"
                                  DataValueField="country_id" SelectedValue='<%# Bind("billcountry_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]"/>
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
                                       Appliant Accounting Information</th>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Account No.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbAcctNo" runat="server" Text='<%# Bind("acctno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; AE:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList Enabled="false" ID="dlAcctMgr" runat="server" AppendDataBoundItems="True" 
                                           datasourceid="SqlDataSource5" DataTextField="un" DataValueField="id" 
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
                                       <asp:TextBox Enabled="false" ID="tbCreditLimit" runat="server" 
                                           Text='<%# Bind("creditlimit") %>'></asp:TextBox>
                                   </td>
                                   <th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td colspan="3">
                                             <asp:DropDownList Enabled="false" ID="ddlPaymentDays" runat="server" 
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
                                       <asp:TextBox Enabled="false" ID="tbFedexAcct" runat="server" Text='<%# Bind("fedex_acct") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Client Status:&nbsp;</th>
                                   <td class="style11" width="30%">
                                       <asp:DropDownList Enabled="false" ID="dlClientStatus" runat="server" 
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
                                       <asp:TextBox Enabled="false" ID="TextBox8" runat="server" Text='<%# Bind("ups_accountno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; DHL Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbDhlAcct" runat="server" Text='<%# Bind("dhl_acct") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                  <th align="left" class="style7">
                                       &nbsp; 統一編號:&nbsp;</th>
                                   <td colspan="3">
                                       <asp:TextBox Enabled="false" ID="tbBusinessRN" runat="server" Text='<%# Bind("business_registration_number") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                               </tr>
                            
                               <tr>
                                   
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp;&nbsp;Bank Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbBankName" runat="server" Text='<%# Bind("ups_bankname") %>' Width="250px"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Bank Branch:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbBankBranch" runat="server" Text='<%# Bind("ups_bankbranch") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Bank Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbBankAddress" runat="server" 
                                           Text='<%# Bind("ups_bankaddress") %>' Width="360px"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Swift Code:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbSwiftCode" runat="server" 
                                           Text='<%# Bind("ups_swiftcode") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Beneficiary Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbBanefucuanyName" runat="server" 
                                           Text='<%# Bind("ups_banefucuanyname") %>' Width="300px"></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Passby Bank:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox Enabled="false" ID="tbPassbyBank" runat="server" 
                                           Text='<%# Bind("ups_passbybank") %>'></asp:TextBox>
                                   </td>
                               </tr>
                                  <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Accounting Contact Information</th>
                               </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Name:</th><td 
                                   width="30%"><asp:TextBox Enabled="false" ID="tbcontactname" runat="server" 
                                       Text='<%# Bind("contact_name") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:TextBox Enabled="false" 
                                       ID="TextBox5" runat="server" Text='<%# Bind("contact_email") %>' Width="250px"></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   colspan="3"><asp:TextBox Enabled="false" ID="tbaccttel" runat="server" 
                                       Text='<%# Bind("contact_tel") %>'></asp:TextBox>&nbsp;Ext : &nbsp;<asp:TextBox Enabled="false" ID="TextBox7" 
                                                   runat="server" Height="21px" Text='<%# Bind("contact_ext") %>' Width="30px"></asp:TextBox>
                                               &nbsp;&nbsp;&nbsp;</td>
                  </tr>
                          
  
                                </asp:Panel>

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
                    <asp:TextBox Enabled="false" ID="TextBox1" runat="server" Text='<%# Bind("fname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    &nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Eval("fname") %>'></asp:Label>
                    &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Eval("lname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="姓名" SortExpression="lname">
                <EditItemTemplate>
                    <asp:TextBox Enabled="false" ID="TextBox2" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
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
                                       <asp:Label ID="tbRemarks" runat="server" Height="70" TextMode="MultiLine" Text='<%# Bind("remark") %>'
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

