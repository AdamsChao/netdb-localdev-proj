<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        
    }

        
    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.vendor obj = (WoWiModel.vendor)e.Entity;
            String WestUintQueryString = "";
            if (obj.payment_type == 5)
            {
                WestUintQueryString = "&iswu=1";
            }

            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + obj.id + WestUintQueryString);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        
    }
   

    protected void EntityDataSource1_Updating(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.vendor obj = (WoWiModel.vendor)e.Entity;
        obj.modify_date = DateTime.Now;
        obj.modify_user = User.Identity.Name;
        obj.payment_balance = (short)(obj.payment_term1 + obj.payment_term2 + obj.payment_term3 + obj.payment_term_final);
    }


    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        DropDownList list = (DropDownList)sender;
        int[] data = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
        list.DataSource = data;//Enumerable.Range(0, 101);
    }

   
    protected void dlPaymentTerm1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl1 = FormView1.FindControl("dlPaymentTerm1") as DropDownList;
        DropDownList ddl2 = FormView1.FindControl("dlPaymentTerm2") as DropDownList;
        DropDownList ddl3 = FormView1.FindControl("dlPaymentTerm3") as DropDownList;
        DropDownList ddl4 = FormView1.FindControl("dlPaymentTermF") as DropDownList;
        Label lbl = FormView1.FindControl("tbPaymentBal") as Label;
        lbl.Text = int.Parse(ddl1.SelectedValue) + int.Parse(ddl2.SelectedValue) + int.Parse(ddl3.SelectedValue) + int.Parse(ddl4.SelectedValue) + "";
      
    }


    protected void FormView1_DataBound(object sender, EventArgs e)
    {
        DropDownList ddl1 = FormView1.FindControl("dlPaymentTerm1") as DropDownList;
        DropDownList ddl2 = FormView1.FindControl("dlPaymentTerm2") as DropDownList;
        DropDownList ddl3 = FormView1.FindControl("dlPaymentTerm3") as DropDownList;
        DropDownList ddl4 = FormView1.FindControl("dlPaymentTermF") as DropDownList;
        Label lbl = FormView1.FindControl("tbPaymentBal") as Label;
        lbl.Text = int.Parse(ddl1.SelectedValue) + int.Parse(ddl2.SelectedValue) + int.Parse(ddl3.SelectedValue) + int.Parse(ddl4.SelectedValue) + "";
      
    }

    

    protected void ddlDeptList_Load(object sender, EventArgs e )
    {
        if(Page.IsPostBack) return;
        (sender as DropDownList).SelectedValue = (FormView1.FindControl("lblDept") as Label).Text;
    }

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
        var list = from e in wowidb.employees select new { id = e.id, name = String.IsNullOrEmpty(e.fname) ? e.c_lname + " " + e.c_fname : e.fname + " " + e.lname };
        if (list.Count() == 0) return;
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "name";
        (sender as DropDownList).DataValueField = "id";
        (FormView1.FindControl("lblDept") as Label).Text = "-1";

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
            DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="100%" 
        onitemupdating="FormView1_ItemUpdating" ondatabound="FormView1_DataBound" >
            
            <EditItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  width="100%"><tr><th 
                           align="left" class="style10"><font size="+1">Vender Information Modification&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                            <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id" 
                                                onselectedindexchanged="ddlDeptList_SelectedIndexChanged" AppendDataBoundItems="True"><%--SelectedValue='<%# Bind("department_id") %>'>--%>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true'"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" 
                                                onselectedindexchanged="ddlEmployeeList_SelectedIndexChanged" 
                                                OnPreRender="ddlEmployeeList_Load" >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEmp" runat="server" Text='<%# Bind("employee_id") %>' CssClass="hidden"></asp:Label>
                                        </td></tr>
                              <tr><th 
                                   align="left" class="style11"><font color="red">*&#160;</font>Company:&#160;&#160;</th><td 
                                   class="style12" width="30%"><asp:TextBox ID="tbCompany" runat="server" 
                                       Text='<%# Bind("name") %>'></asp:TextBox></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%"><asp:TextBox 
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_name") %>'></asp:TextBox></td></tr><tr><th 
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
                              <asp:DropDownList ID="dlCountry" runat="server" 
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
                                   align="left" class="style7">&nbsp; Vender Type:&nbsp;</th><td width="30%"><asp:DropDownList DataSourceID="SqlDataSource3"   DataTextField="name" DataValueField="id"
                                       ID="dlContractType" runat="server" SelectedValue='<%# Bind("contract_type") %>' AppendDataBoundItems="true">
                                        <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                   ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                   SelectCommand="SELECT [id], [name] FROM [vendor_type] WHERE [publish] = 'true'" ></asp:SqlDataSource></td></tr>
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
                                                 <asp:ListItem Value="-1">Please select</asp:ListItem>
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
                                   <tr><td
                                   align="left" colspan="4">
                                  
                                   <table  border="0" cellpadding="2" cellspacing="0"  width="100%">
                                   <tr>
                                   <td width="40%" align="right">1st Prepayment : </td>
                                   <td width="10%" > </td>
                                   <td width="50%" > 
                                       <asp:DropDownList ID="dlPaymentTerm1" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           SelectedValue='<%# Bind("payment_term1") %>' 
                                           onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged" >
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox1" runat="server" Visible="false" /></td>
                                       
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right">2nd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="dlPaymentTerm2" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           SelectedValue='<%# Bind("payment_term2") %>' onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged">
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right" >3rd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="dlPaymentTerm3" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           SelectedValue='<%# Bind("payment_term3") %>' onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged">
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox3" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   
                                   <td width="40%" align="right" >Final Payment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                   <asp:DropDownList ID="dlPaymentTermF" runat="server" onload="DropDownList1_Load" AutoPostBack="true"
                                           SelectedValue='<%# Bind("payment_term_final") %>' onselectedindexchanged="dlPaymentTerm1_SelectedIndexChanged">
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox4" runat="server" Visible="false" /></td>
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

                            <%--  <tr><td 
                               align="left" colspan="4"><b>&#160; Vender Type: </b><br /><asp:CheckBoxList 
                               ID="clVenderTypeList" runat="server" AutoPostBack="False" 
                               DataSourceID="EntityDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList><asp:EntityDataSource 
                               ID="EntityDataSource2" runat="server" ConnectionString="name=WoWiEntities" 
                               DefaultContainerName="WoWiEntities" EnableFlattening="False" 
                               EntitySetName="vendor_type" Select="it.[id], it.[name]"></asp:EntityDataSource></td></tr>--%></table></td></tr>
                                             <tr>
            <td>
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
                        <td class="style4">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr align="center">
                                    <td>
                                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Update"  onclientclick="return checkPercetage();" />
                                        &nbsp;
                                        <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" 
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
            EnableFlattening="False" EnableInsert="False" EntitySetName="vendors" 
     onupdated="EntityDataSource1_Updated" Where="it.id == @id" 
                    onupdating="EntityDataSource1_Updating" EnableUpdate="True" 
        >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
         
               
   
</asp:Content>

