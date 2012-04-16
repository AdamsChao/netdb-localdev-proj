<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">

    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.vendor obj = (WoWiModel.vendor)e.Entity;
            List<int> types = (List<int>)ViewState[VenderUtils.Key_ViewState_VenderTypes];
            if (types.Count != 0)
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_vender_type;
                    foreach (int id in types)
                    {
                        var d = new WoWiModel.m_vender_type()
                        {
                           vender_id = obj.id,
                           vender_type_id = id
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
            String WestUintQueryString = "";
            if (obj.payment_type == 5)
            {
                WestUintQueryString = "&iswu=1";
            }
            WestUintQueryString += "&paymenttype=" + obj.payment_type;
            Response.Redirect("~/Admin/CreateVenderBankAccount.aspx?id=" + obj.id+WestUintQueryString);
            //Response.Redirect("~/Common/SelectExistContact.aspx?id="+obj.id+"&type=vender");
        }
    }

    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        VenderUtils.StoreVenderTypesInViewState((FormView)sender, VenderUtils.Name_CheckBox_VenderTypeList, ViewState, VenderUtils.Key_ViewState_VenderTypes);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
       

    }

    
    protected void lbMessage_Load(object sender, EventArgs e)
    {
        Utils.Message_Load((Label)sender, ViewState, VenderUtils.Key_ViewState_InsertMessage);
    }

    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.vendor obj = (WoWiModel.vendor)e.Entity;
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
        obj.payment_balance = (short)(obj.payment_term1 + obj.payment_term2 + obj.payment_term3 + obj.payment_term_final);
    }

    protected void btnLoad_Click(object sender, EventArgs e)
    {
        
        FormView fv = this.FormView1;
        DropDownList list = (DropDownList)fv.FindControl(VenderUtils.Name_DropdownList_VenderList);
        int id = int.Parse(list.SelectedValue);
        if (id == 0)
        {
            return;
        }
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
            WoWiModel.vendor data = db.vendors.Where(c => c.id == id).First();
            SetValueFromVenderEntity(fv,data);
        }
        VenderUtils.InitVenderTypes(id, FormView1, VenderUtils.Name_CheckBox_VenderTypeList);
    }

    private void SetValueFromVenderEntity(FormView fv, WoWiModel.vendor data)
    {
        (FormView1.FindControl("tbPaymentBal") as Label).Text = "";
        Utils.SetTextBoxValue(fv, "tbCompany", data.name);
        Utils.SetTextBoxValue(fv, "tbcCompany", data.c_name);
        Utils.SetTextBoxValue(fv, "tbFax1", data.fax1);
        Utils.SetTextBoxValue(fv, "tbFax2", data.fax2);
        Utils.SetTextBoxValue(fv, "tbTel1", data.tel1);
        Utils.SetTextBoxValue(fv, "tbTel2", data.tel2);
        Utils.SetTextBoxValue(fv, "tbAddress", data.address);
        Utils.SetTextBoxValue(fv, "tbcAddress", data.c_address);
        //Utils.SetTextBoxValue(fv, "tbPaymentBal", data.payment_balance+"");

        Utils.SetDropDownListValue(fv, "dlQualification", data.qualification);
        Utils.SetDropDownListValue(fv, "dlContractType", data.contract_type);
        Utils.SetDropDownListValue(fv, "ddlCountry", data.country + "");
        Utils.SetDropDownListValue(fv, "ddlBankCharge", data.bank_charge + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentType", data.payment_type + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentTerm1", data.payment_term1 + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentTerm2", data.payment_term2 + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentTerm3", data.payment_term3 + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentTermF", data.payment_term_final + "");
        Utils.SetDropDownListValue(fv, "ddlPaymentDays", data.paymentdays + "");
        (FormView1.FindControl("lblDept") as Label).Text = data.department_id.HasValue ? data.department_id + "" : "-1";
        (FormView1.FindControl("lblEmp") as Label).Text = data.employee_id.HasValue ? data.employee_id + "" : "-1";
        int depid = data.department_id.HasValue ? (int)data.department_id : -1;
        try
        {
            var list = from e in wowidb.employees where e.department_id == depid select new { id = e.id, name = String.IsNullOrEmpty(e.fname) ? e.c_lname + " " + e.c_fname : e.fname + " " + e.lname };
            cleanEmployeeList();
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).Items.Clear();
            ListItem item = new ListItem("- Select -", "-1");
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).Items.Add(item);
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).AppendDataBoundItems = true;
            if (list.Count() == 0) return;
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataSource = list;
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataTextField = "name";
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataValueField = "id";
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataBind();
        }
        catch (Exception)
        {
            (FormView1.FindControl("lblDept") as Label).Text = "-1";

        }

        Utils.SetDropDownListValue(fv, "ddlEmployeeList", data.employee_id.HasValue ? data.employee_id + "" : "-1");
        Utils.SetDropDownListValue(fv, "ddlDeptList", data.department_id.HasValue ? data.department_id + "" : "-1");

        if (data.payment_balance!=null)
        {
            (FormView1.FindControl("tbPaymentBal") as Label).Text = data.payment_balance.ToString();
        }
        else
        {
            Label lbl = FormView1.FindControl("tbPaymentBal") as Label;
            lbl.Text = data.payment_term1+data.payment_term2+data.payment_term3+data.payment_term_final + "";
        }
    }

    protected void dlVenderList_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            DropDownList dl = (DropDownList)sender;
            dl.Items.Clear();
            dl.Items.Add(new ListItem("", "0"));
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                var data = db.vendors;
                foreach (WoWiModel.vendor ven in data)
                {
                    dl.Items.Add(new ListItem(String.Format("{0,20}", String.IsNullOrEmpty(ven.name) ? ven.c_name : ven.name), ven.id + ""));
                }

            }
        }
        
    }

    protected void dlPaymentTerm1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl1 = FormView1.FindControl("ddlPaymentTerm1") as DropDownList;
        DropDownList ddl2 = FormView1.FindControl("ddlPaymentTerm2") as DropDownList;
        DropDownList ddl3 = FormView1.FindControl("ddlPaymentTerm3") as DropDownList;
        DropDownList ddl4 = FormView1.FindControl("ddlPaymentTermF") as DropDownList;
        Label lbl = FormView1.FindControl("tbPaymentBal") as Label;
        lbl.Text = int.Parse(ddl1.SelectedValue) + int.Parse(ddl2.SelectedValue) + int.Parse(ddl3.SelectedValue) + int.Parse(ddl4.SelectedValue) + "";

    }


    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        DropDownList list = (DropDownList)sender;
        int[] data = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
        list.DataSource = data;//Enumerable.Range(0, 101);
    }


    protected void ddlDeptList_SelectedIndexChanged(object sender, EventArgs ea)
    {
        DropDownList ddl = sender as DropDownList;
        if (ddl.SelectedValue != "-1")
        {
            int depid = int.Parse(ddl.SelectedValue);
            try
            {
                var list = from e in wowidb.employees where e.department_id == depid select new { id = e.id, name = String.IsNullOrEmpty(e.fname) ? e.c_lname + " " + e.c_fname : e.fname + " " + e.lname };
                cleanEmployeeList();
                if (list.Count() == 0) return;
                (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataSource = list;
                (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataTextField = "name";
                (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataValueField = "id";
                (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataBind();
                (FormView1.FindControl("lblDept") as Label).Text = depid + "";
            }
            catch (Exception)
            {
                (FormView1.FindControl("lblDept") as Label).Text = "-1";

            }
        }
        else
        {
            (FormView1.FindControl("lblEmp") as Label).Text = "-1";
        }
            
    }

    private void cleanEmployeeList()
    {
        try
        {
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).Items.Clear();
            ListItem item = new ListItem("- Select -", "-1");
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).Items.Add(item);
            (FormView1.FindControl("ddlEmployeeList") as DropDownList).AppendDataBoundItems = true;
            (FormView1.FindControl("lblEmp") as Label).Text = "-1";
        }
        catch (Exception)
        {
            
            //throw;
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
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Insert" Width="100%" 
                    oniteminserting="FormView1_ItemInserting" >
           
            <InsertItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Vender Information Creation&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;<asp:Label 
                           ID="lbMessage" runat="server" ForeColor="Red" onload="lbMessage_Load"></asp:Label></th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4">Load from : <asp:DropDownList ID="dlVenderList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   onload="dlVenderList_Load"></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" /></td></tr>
                                    <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Department:</th><td 
                                   width="30%">
                                            <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id" 
                                                onselectedindexchanged="ddlDeptList_SelectedIndexChanged" AppendDataBoundItems="True"><%--SelectedValue='<%# Bind("department_id") %>'>--%>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [department]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Employee:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlEmployeeList_SelectedIndexChanged" >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEmp" runat="server" Text='<%# Bind("employee_id") %>'  CssClass="hidden"></asp:Label>
                                        </td></tr>
                                   <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%"><asp:TextBox ID="tbCompany" runat="server" 
                                       Text='<%# Bind("name") %>'></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%"><asp:TextBox 
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_name") %>'></asp:TextBox></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel1:</th><td 
                                   width="30%"><asp:TextBox ID="tbTel1" runat="server" 
                                       Text='<%# Bind("tel1") %>'></asp:TextBox>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Fax1:</th><td width="30%"><asp:TextBox 
                                       ID="tbFax1" runat="server" Text='<%# Bind("fax1") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Tel2:</th><td width="30%"><asp:TextBox 
                                       ID="tbTel2" runat="server" Text='<%# Bind("tel2") %>'></asp:TextBox></td><th 
                                   align="left" class="style7">&#160;&#160; Fax2:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbFax2" runat="server" Text='<%# Bind("fax2") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Address:&#160;</th><td 
                                   width="30%"><asp:TextBox ID="tbAddress" runat="server" 
                                       Text='<%# Bind("address") %>' Width="211px"></asp:TextBox></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' Width="211px"></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9"><font color="red">* </font>Country:&#160;</th>
                                   <td 
                                   width="30%">
                              <asp:DropDownList ID="ddlCountry" runat="server" 
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" SelectedValue='<%# Bind("country") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; 統一編號:</th><td width="30%">
                              <asp:TextBox ID="tbcLU" 
                                       runat="server" Text='<%# Bind("ub_license_number") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="dlQualification" runat="server" 
                                       SelectedValue='<%# Bind("qualification") %>'><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></asp:DropDownList></td>
                                       <th 
                                   align="left" class="style7">&nbsp; Authority / Local Agent:&nbsp;</th><td width="30%"><asp:DropDownList 
                                       ID="dlContractType" runat="server" SelectedValue='<%# Bind("contract_type") %>'>
                                        <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                       <asp:ListItem Value="0">Authroity</asp:ListItem>
                                       <asp:ListItem Value="1">Local Agent</asp:ListItem></asp:DropDownList></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlBankCharge" runat="server" 
                                                   SelectedValue='<%# Bind("bank_charge") %>' >
                                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                                   <asp:ListItem Value="2">BEN</asp:ListItem>
                                               </asp:DropDownList>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server" 
                                                   SelectedValue='<%# Bind("payment_type") %>'>
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                    <asp:ListItem Value="0">支票 Check</asp:ListItem>
                                                   <asp:ListItem Value="1">國內匯款 Domestic Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="6">國外匯款 Foreign  Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="2">匯票 Cashier Check</asp:ListItem>
                                                   <asp:ListItem Value="3">信用卡 Credit Card</asp:ListItem>
                                                   <asp:ListItem Value="4">現金 Cash</asp:ListItem>
                                                   <asp:ListItem Value="5">西聯匯款 Westerm Union</asp:ListItem>
                                               </asp:DropDownList>
                                           </td>
                                   </tr>
                                   <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td colspan="3">
                                             <asp:DropDownList ID="ddlPaymentDays" runat="server" 
                                                 SelectedValue='<%# Bind("paymentdays") %>'>
                                                 <asp:ListItem Value="0">Please select</asp:ListItem>
                                                 <asp:ListItem>ASAP</asp:ListItem>
                                                 <asp:ListItem>  7 days</asp:ListItem>
                                                 <asp:ListItem> 15 days</asp:ListItem>
                                                 <asp:ListItem> 30 days</asp:ListItem>
                                                 <asp:ListItem> 45 days</asp:ListItem>
                                                 <asp:ListItem> 60 days</asp:ListItem>
                                                 <asp:ListItem> 90 days</asp:ListItem>
                                                 <asp:ListItem>120 days</asp:ListItem>
                                             </asp:DropDownList>
                                           </td>
                                   </tr>
                                   <tr><td
                                   align="left" class="style2" colspan="4">
                                  
                                   <table  border="0" cellpadding="2" cellspacing="0"  style="width:100%">
                                   <tr>
                                   <td width="40%" align="right">1st Prepayment : </td>
                                   <td width="10%" > </td>
                                   <td width="50%" > 
                                       <asp:DropDownList ID="ddlPaymentTerm1" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged"
                                           SelectedValue='<%# Bind("payment_term1") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox1" runat="server" Visible="false"  /></td>
                                       
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right">2nd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm2" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged"
                                           SelectedValue='<%# Bind("payment_term2") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right" >3rd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm3" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged"
                                           SelectedValue='<%# Bind("payment_term3") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox3" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   
                                   <td width="40%" align="right" >Final Payment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTermF" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged"
                                           SelectedValue='<%# Bind("payment_term_final") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox5" runat="server" Visible="false" />
                                   </td>
                                  
                                   </tr>
                                   <tr>
                         
                                   <td width="40%" align="right" >Balance of Payment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                       <asp:Label ID="tbPaymentBal" runat="server" Text='<%# Bind("payment_balance") %>'></asp:Label> %
                                   </td>
                                   
                                   </tr>

                                   </table>
                                   
                                   </td>
                                   </tr>
                            
                            
                            <tr><td 
                               align="left" colspan="4"><b>&#160; Vender Type: </b><br /><asp:CheckBoxList 
                               ID="clVenderTypeList" runat="server" AutoPostBack="False" 
                               DataSourceID="EntityDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList><asp:EntityDataSource 
                               ID="EntityDataSource2" runat="server" ConnectionString="name=WoWiEntities" 
                               DefaultContainerName="WoWiEntities" EnableFlattening="False" 
                               EntitySetName="vendor_type" Select="it.[id], it.[name]"></asp:EntityDataSource></td></tr></table></td></tr><tr><td class="style4"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"><tr align="center"><td>
                      <asp:Button ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Create" 
                          onclientclick="return checkPercetage();" />&#160;&nbsp;<asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />&#160;</td></tr></table></td></tr></table>
                </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="InsertButton" />
                  </Triggers>
                </asp:UpdatePanel>
            </InsertItemTemplate>
        </asp:FormView>
   
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="True" EntitySetName="vendors" 
        oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting">
        </asp:EntityDataSource >

</asp:Content>

