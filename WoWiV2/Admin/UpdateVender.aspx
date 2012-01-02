<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        VenderUtils.StoreVenderTypesInViewState((FormView)sender, VenderUtils.Name_CheckBox_VenderTypeList, ViewState, VenderUtils.Key_ViewState_VenderTypes);
        
    }

        
    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.vendor obj = (WoWiModel.vendor)e.Entity;
            List<int> types = (List<int>)ViewState[VenderUtils.Key_ViewState_VenderTypes];
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                var data = db.m_vender_type;
                try
                {
                    var delList = from c in data where c.vender_id == obj.id select c;
                    foreach (WoWiModel.m_vender_type item in delList)
                    {
                        data.DeleteObject(item);
                    }
                }
                catch (Exception ex)
                {
                }
                if (types.Count != 0)
                {
                    foreach (int id in types)
                    {
                        var d = new WoWiModel.m_vender_type()
                        {
                            vender_id = obj.id,
                            vender_type_id = id
                        };
                        data.AddObject(d);
                    }
                }
                db.SaveChanges();
            }
            String WestUintQueryString = "";
            if (obj.payment_type == 5)
            {
                WestUintQueryString = "&iswu=1";
            }
            //ViewState.Remove(VenderUtils.Key_ViewState_VenderTypes);
            //Response.Redirect("~/Common/SelectExistContact.aspx?id=" + obj.id + "&type=vender&mode=update");
            Response.Redirect("~/Admin/UpdateVenderBankAccount.aspx?id=" + obj.id + WestUintQueryString);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        
    }


    private void InitVenderTypes()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            VenderUtils.InitVenderTypes(id, FormView1, VenderUtils.Name_CheckBox_VenderTypeList);
        }
        catch
        {
        }
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

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            InitVenderTypes();
        }
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
            DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="900px" 
        onitemupdating="FormView1_ItemUpdating" ondatabound="FormView1_DataBound" >
            
            <EditItemTemplate>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  width="100%"><tr><th 
                           align="left" class="style10"><font size="+1">Vender Information Modification&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               
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
                                   class="style7">&nbsp; Unified Business License Number:</th><td width="30%">
                              <asp:TextBox ID="tbcLU" 
                                       runat="server" Text='<%# Bind("ub_license_number") %>'></asp:TextBox></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="dlQualification" runat="server" 
                                       SelectedValue='<%# Bind("qualification") %>'><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></asp:DropDownList></td><th 
                                   align="left" class="style7">&#160; Contract Type:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="dlContractType" runat="server" SelectedValue='<%# Bind("contract_type") %>'><asp:ListItem>- Select Contract Type</asp:ListItem><asp:ListItem>Sub-Contractor</asp:ListItem><asp:ListItem>Contracted Employee</asp:ListItem></asp:DropDownList></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="dlBankCharge" runat="server" 
                                                   SelectedValue='<%# Bind("bank_charge") %>' >
                                                   <asp:ListItem Value="-1">- Select Charge Type</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                               </asp:DropDownList>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="dlPaymentType" runat="server" 
                                                   SelectedValue='<%# Bind("payment_type") %>'>
                                                   <asp:ListItem Value="-1">- Select  Payment Type</asp:ListItem>
                                                   <asp:ListItem Value="0">支票</asp:ListItem>
                                                   <asp:ListItem Value="1">匯款</asp:ListItem>
                                                   <asp:ListItem Value="2">匯票</asp:ListItem>
                                                   <asp:ListItem Value="3">信用卡</asp:ListItem>
                                                   <asp:ListItem Value="4">現金</asp:ListItem>
                                                   <asp:ListItem Value="5">西聯匯款</asp:ListItem>
                                               </asp:DropDownList>
                                           </td>
                                   </tr>
                                    <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Days:&nbsp;</th>
                                   <td colspan="3">
                                             <asp:DropDownList ID="DropDownList1" runat="server" 
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
                                   align="left" colspan="4"><b>&nbsp;&nbsp; Payment Term: </b><br>
                                  
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
                                   
                                   <td width="40%" align="right" >Final Prepayment : </td><td width="10%" > </td>
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

                              <tr><td 
                               align="left" colspan="4"><b>&#160; Vender Type: </b><br /><asp:CheckBoxList 
                               ID="clVenderTypeList" runat="server" AutoPostBack="False" 
                               DataSourceID="EntityDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList><asp:EntityDataSource 
                               ID="EntityDataSource2" runat="server" ConnectionString="name=WoWiEntities" 
                               DefaultContainerName="WoWiEntities" EnableFlattening="False" 
                               EntitySetName="vendor_type" Select="it.[id], it.[name]"></asp:EntityDataSource></td></tr></table></td></tr>
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
            EnableFlattening="False" EnableInsert="False" EntitySetName="vendors" 
     onupdated="EntityDataSource1_Updated" Where="it.id == @id" 
                    onupdating="EntityDataSource1_Updating" EnableUpdate="True" 
        >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
         
               
   
</asp:Content>

