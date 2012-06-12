<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">

    
    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.clientapplicant obj = (WoWiModel.clientapplicant)e.Entity;
            if (!obj.department_id.HasValue)
            {
                obj.department_id = -1;
            }
            if (!obj.employee_id.HasValue)
            {
                obj.employee_id = -1;
            }
   
            obj.code = "";
            if ((bool)ViewState["IsApplication"])
            {
                obj.clientapplicant_type = 3;
            }
            else
            {
                obj.clientapplicant_type = 1;
            }
            obj.create_date = DateTime.Now;
            obj.create_user = User.Identity.Name;
            wowidb.SaveChanges();
            List<int> industry = (List<int>)ViewState[ClientApplicantUtils.Key_ViewState_Industry];
            if (industry.Count != 0)
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_clientappliant_industry;
                    foreach (int id in industry)
                    {
                        var d = new WoWiModel.m_clientappliant_industry()
                        {
                            clientappliant_id = obj.id,
                            industry_id = id
                        };
                        data.AddObject(d);
                    }
                    try
                    {
                        db.SaveChanges();
                    }
                    catch
                    {
                    }
                }
            }
            List<int> technoloyies = (List<int>)ViewState[ClientApplicantUtils.Key_ViewState_Technologies];
            if (technoloyies.Count != 0)
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_clientappliant_technology;
                    foreach (int id in technoloyies)
                    {
                        var d = new WoWiModel.m_clientappliant_technology()
                        {
                            clientappliant_id = obj.id,
                            technology_id = id
                        };
                        data.AddObject(d);
                    }
                    try
                    {
                        db.SaveChanges();
                    }
                    catch
                    {
                    }
                }
            }
            Response.Redirect("~/Common/SelectExistContact.aspx?id=" + obj.id + "&type=client");
        }
        
    }

    protected void lbMessage_Load(object sender, EventArgs e)
    {
        Utils.Message_Load((Label)sender, ViewState, VenderUtils.Key_ViewState_InsertMessage);
    }

    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.clientapplicant obj = (WoWiModel.clientapplicant)e.Entity;
        if (obj == null)
        {
            return;
        }
        obj.code = "";
        if ((bool)ViewState["IsApplication"])
        {
            obj.clientapplicant_type = 3;
        }
        else
        {
            obj.clientapplicant_type = 1;
        }
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

   
    //Store Industry, Technology in ViewState
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_IndustryList, ViewState,  ClientApplicantUtils.Key_ViewState_Industry);
        ClientApplicantUtils.StoreDatasInViewState((FormView)sender, ClientApplicantUtils.Name_CheckBox_TechnologyList, ViewState, ClientApplicantUtils.Key_ViewState_Technologies);
        ViewState["IsApplication"] = (this.FormView1.FindControl("cbApplican") as CheckBox).Checked;
    }

    //Copy Client Info to Billing
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

    protected void cbApplican_CheckedChanged(object sender, EventArgs e)
    {
        ViewState["IsApplication"] = cbApplican.Checked;
    }
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void ddlDeptList_SelectedIndexChanged(object sender, EventArgs ea)
    {
        try
        {
            DropDownList ddl = sender as DropDownList;
            (FormView1.FindControl("lblDept") as Label).Text = ddl.SelectedValue;
        }
        catch (Exception)
        {

            (FormView1.FindControl("lblDept") as Label).Text = "-1";
        }

    }


    protected void ddlEmployeeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DropDownList ddl = sender as DropDownList;
            (FormView1.FindControl("lblEmp") as Label).Text = ddl.SelectedValue;
        }
        catch (Exception)
        {

            (FormView1.FindControl("lblEmp") as Label).Text = "-1";
        }
    }

    protected void ddlEmployeeList_Load(object sender, EventArgs ea)
    {

        if (Page.IsPostBack) return;
        var list = EmployeeUtils.GetEmployeeList(wowidb);
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "name";
        (sender as DropDownList).DataValueField = "id";
        (FormView1.FindControl("lblDept") as Label).Text = "-1";

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        try
        {
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).SelectedValue = Utils.GetEmployeeID(User.Identity.Name) + "";
            (FormView1.FindControl("lblEmp") as Label).Text = (FormView1.FindControl("ddlEmployeeList") as DropDownList).SelectedValue;
        }
        catch (Exception)
        {
            //(FormView1.FindControl("lblEmp") as Label).Text = "-1";
            //throw;
        }
    }
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        
        .style7
        {
            width: 20%;
        }
        .style9
        {
            width: 20%;
        }
        
        .style10
        {
            width: 20%;
            height: 24px;
        }
        .style11
        {
            height: 24px;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id"  oniteminserting="FormView1_ItemInserting" SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Insert" Width="100%" >
           
            <InsertItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Client Information 
                  Creation&nbsp; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/ClientList.aspx">Client List</asp:HyperLink>&#160;<asp:Label 
                           ID="lbMessage" runat="server" ForeColor="Red" onload="lbMessage_Load"></asp:Label></th></tr>
                            
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4"><%--Load from : <asp:DropDownList ID="dlClientList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   ></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" />&nbsp;--%>
                                   <%--Client Code :&nbsp;
                                   <asp:TextBox ID="tbClientCode" runat="server" Text='<%# Bind("code") %>' 
                                       Width="80px"></asp:TextBox>--%>
                                   <asp:CheckBox 
                              ID="cbApplican" runat="server" Text="Is Applicant Also" AutoPostBack="True" 
                                       oncheckedchanged="cbApplican_CheckedChanged" />
                          <%--<asp:CheckBox ID="cbpotential" runat="server" Text="Potential Client" 
                                       Checked='<%# Bind("potential_client") %>' />--%>
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Client Contact Information</th>
                        </tr>
                         <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                            <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="id" 
                                                onselectedindexchanged="ddlDeptList_SelectedIndexChanged" AppendDataBoundItems="True"><%--SelectedValue='<%# Bind("department_id") %>'>--%>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                ControlToValidate="ddlDeptList" ErrorMessage="Please select access level." 
                                                Font-Bold="True" ForeColor="Red" InitialValue="-1" >*</asp:RequiredFieldValidator><asp:ValidationSummary
                                                  ShowMessageBox="True" ShowSummary="False"  ID="ValidationSummary1" runat="server" />
                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlEmployeeList_SelectedIndexChanged" 
                                                onload="ddlEmployeeList_Load" AppendDataBoundItems="True">
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEmp" runat="server" Text='<%# Bind("employee_id") %>'  CssClass="hidden"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="ddlEmployeeList" 
                                                ErrorMessage="Please select created by which user." Font-Bold="True" 
                                                ForeColor="Red" InitialValue="-1">*</asp:RequiredFieldValidator>
                                        </td></tr>
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
                                  <asp:ListItem Value="0">Manufacturer</asp:ListItem>
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
                                    SelectCommand="SELECT [country_id], [country_name] FROM [country] order by country_name">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; <b>Annual Number Project</b>:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("grant_rank") %>'>
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
                                 DataTextField="country_name"  DataSourceID="SqlDataSource8" AppendDataBoundItems="true"
                                  DataValueField="country_id" SelectedValue='<%# Bind("billcountry_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]"/>
                                   </td>
                                   <th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server" 
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
                                       <asp:TextBox ID="tbAcctNo" runat="server" Text='<%# Bind("acctno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; AE:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlAcctMgr" runat="server" AppendDataBoundItems="True" 
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
                                       <asp:TextBox ID="tbCreditLimit" runat="server" 
                                           Text='<%# Bind("creditlimit") %>'></asp:TextBox>
                                   </td>
                                   <th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td colspan="3">
                                             <asp:DropDownList ID="ddlPaymentDays" runat="server" 
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
                                       <asp:TextBox ID="tbFedexAcct" runat="server" Text='<%# Bind("fedex_acct") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Client Status:&nbsp;</th>
                                   <td class="style11" width="30%">
                                       <asp:DropDownList ID="dlClientStatus" runat="server" 
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
                                       <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("ups_accountno") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; DHL Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbDhlAcct" runat="server" Text='<%# Bind("dhl_acct") %>'></asp:TextBox>
                                   </td>
                               </tr>
                               <tr>
                                  <th align="left" class="style7">
                                       &nbsp; 統一編號:&nbsp;</th>
                                   <td colspan="3">
                                       <asp:TextBox ID="tbBusinessRN" runat="server" Text='<%# Bind("business_registration_number") %>' 
                                           Width="211px"></asp:TextBox>
                                   </td>
                               </tr>
                            
                               <tr>
                                   
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp;&nbsp;Bank Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankName" runat="server" Text='<%# Bind("ups_bankname") %>'></asp:TextBox>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Bank Branch:&nbsp;</th>
                                   <td width="30%">
                                       <asp:TextBox ID="tbBankBranch" runat="server" Text='<%# Bind("ups_bankbranch") %>'></asp:TextBox>
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
                                       &nbsp;&nbsp;&nbsp;Beneficiary Name:&nbsp;</th>
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
                                       Accounting Contact Information</th>
                               </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Name:</th><td 
                                   width="30%"><asp:TextBox ID="tbcontactname" runat="server" 
                                       Text='<%# Bind("contact_name") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Email:</th><td width="30%">
                                                <asp:TextBox 
                                       ID="TextBox5" runat="server" Text='<%# Bind("contact_email") %>'></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   colspan="3"><asp:TextBox ID="tbaccttel" runat="server" 
                                       Text='<%# Bind("contact_tel") %>'></asp:TextBox>&nbsp;Ext : &nbsp;<asp:TextBox ID="TextBox7" 
                                                   runat="server" Height="21px" Text='<%# Bind("contact_ext") %>' Width="30px"></asp:TextBox>
                                               &nbsp;&nbsp;&nbsp;</td>
                  </tr>
                   <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                   <th colspan="4">
                                       Remark</th>
                               </tr>
                               
                  <tr>
                                   <td colspan="4">
                                       <asp:TextBox ID="tbRemarks" runat="server" Height="70" TextMode="MultiLine" Text='<%# Bind("remark") %>'
                                           Width="100%"></asp:TextBox>
                                   </td>
                               </tr>
                  <tr align="center"><td class="style4" colspan="4">
                      <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr align="center">
                              <td>
                                  <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                      CommandName="Insert" Text="Create" />
                                  &nbsp;&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                      CommandName="Cancel" Text="Cancel" />
                                  &nbsp;</td>
                          </tr>
                      </table>
                      </td></tr>
                               </table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="InsertButton" />
                  </Triggers>
                </asp:UpdatePanel>
            </InsertItemTemplate>
        </asp:FormView>
   
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableInsert="True" EntitySetName="clientapplicants" 
        oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting">
        </asp:EntityDataSource >

</asp:Content>

