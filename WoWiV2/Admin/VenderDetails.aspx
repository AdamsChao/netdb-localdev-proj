<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>


<script runat="server">

    int id;
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Page.IsPostBack == false)
        {
            
            String str = Request.QueryString["id"];
            id = int.Parse(str);
            
        }
    }

    private void InitVenderTypes()
    {
        try
        {
            String str = Request.QueryString["id"];
            id = int.Parse(str);
            VenderUtils.InitVenderTypes(id, FormView1, VenderUtils.Name_CheckBox_VenderTypeList);
        }
        catch
        {
        }
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
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

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
        InitVenderTypes();
    }

    protected void GridView1_Load(object sender, EventArgs e)
    {
        var data = from c in db.m_vender_contact where c.vender_id == id select c.contact_id;
        var result = db.contact_info.Where(c => data.Contains(c.id));
        if (result.Count() == 0)
        {
            Label lbl = FormView1.FindControl("lblC") as Label;
            lbl.Visible = false;
        }
        GridView gv = (GridView)sender;
        gv.DataSource = result;
        gv.DataBind();
    }
    protected void GridView2_Load(object sender, EventArgs e)
    {

        var result = from c in db.venderbankings where c.vender_id == id & !(bool)c.isWestUnit select c;
        if (result.Count() == 0)
        {
            Label lbl = FormView1.FindControl("lblB") as Label;
            lbl.Visible = false;
        }
        GridView gv = (GridView)sender;
        gv.DataSource = result;
        gv.DataBind();
    }

    protected void GridView3_Load(object sender, EventArgs e)
    {

        var result = db.venderbankings.Where(c => c.vender_id == id & (bool)c.isWestUnit);
        if (result.Count() == 0)
        {
            Label lbl = FormView1.FindControl("lblWUB") as Label;
            lbl.Visible = false;
        }
        GridView gv = (GridView)sender;
        gv.DataSource = result;
        gv.DataBind();
    }

    protected void ddlEmployeeList_Load(object sender, EventArgs ea)
    {
        var list = EmployeeUtils.GetEmployeeList(db);
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataSource = list;
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataTextField = "name";
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataValueField = "id";
        
    }

    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in (sender as GridView).Rows)
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
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" Width="100%" SkinID="FormView" ondatabound="FormView1_DataBound"
            DataSourceID="SqlDataSource2">
                    
          
            <ItemTemplate>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%"><tr><th 
                           align="left" class="style10"><font size="+1">Vender Information &nbsp; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;</th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                               <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                           <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" Enabled="false"
                                                DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id"  AppendDataBoundItems="True" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" 
                                                Enabled="false" AppendDataBoundItems="True" onload="ddlEmployeeList_Load" SelectedValue='<%# Bind("employee_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                        </td></tr>
                               <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Company:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%"><asp:Label ID="tbCompany" runat="server" 
                                       Text='<%# Bind("name") %>'></asp:Label></td><th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%"><asp:Label 
                                       ID="tbcCompany" runat="server" Text='<%# Bind("c_name") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Tel1:</th><td 
                                   width="30%"><asp:Label ID="tbTel1" runat="server" 
                                       Text='<%# Bind("tel1") %>'></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7">&nbsp;&nbsp; Fax1:</th><td width="30%"><asp:Label 
                                       ID="tbFax1" runat="server" Text='<%# Bind("fax1") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Tel2:</th><td width="30%"><asp:Label 
                                       ID="tbTel2" runat="server" Text='<%# Bind("tel2") %>'></asp:Label></td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Fax2:&nbsp;</th><td width="30%"><asp:Label 
                                       ID="tbFax2" runat="server" Text='<%# Bind("fax2") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Address:&nbsp;</th><td 
                                   width="30%"><asp:Label ID="tbAddress" runat="server" 
                                       Text='<%# Bind("address") %>' Width="211px"></asp:Label></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%"><asp:Label 
                                       ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' Width="211px"></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Country:&nbsp;</th>
                                    <td 
                                   width="30%">
                              <asp:DropDownList ID="ddlCountry" runat="server"  Enabled="false"
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" SelectedValue='<%# Bind("country") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; 統一編號:</th><td width="30%">
                              <asp:Label ID="lbLU" 
                                       runat="server" Text='<%# Bind("ub_license_number") %>'></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="dlQualification" runat="server" Enabled="false"
                                       SelectedValue='<%# Bind("qualification") %>'><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></asp:DropDownList></td>
                                        <th 
                                   align="left" class="style7">&nbsp; Vender Type:&nbsp;</th><td width="30%"><asp:DropDownList DataSourceID="SqlDataSource3"   DataTextField="name" DataValueField="id" Enabled="false"
                                       ID="dlContractType" runat="server" SelectedValue='<%# Bind("contract_type") %>' AppendDataBoundItems="true">
                                        <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                   ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                   SelectCommand="SELECT [id], [name] FROM [vendor_type] WHERE [publish] = 'true'" ></asp:SqlDataSource></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlBankCharge" runat="server" Enabled="false"
                                                   SelectedValue='<%# Bind("bank_charge") %>' >
                                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                                   <asp:ListItem Value="2">BEN</asp:ListItem>
                                               </asp:DropDownList>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server" Enabled="false"
                                                   SelectedValue='<%# Bind("payment_type") %>' >
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
                                   <tr><th 
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
                                   <tr><td
                                   align="left" class="style2" colspan="4">
                                   <table  border="0" cellpadding="2" cellspacing="0"  style="width:100%">
                                   <tr>
                                   <td width="40%" align="right">1st Prepayment : </td>
                                   <td width="10%" > </td>
                                   <td width="50%" > 
                                       <asp:DropDownList ID="ddlPaymentTerm1" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                           SelectedValue='<%# Bind("payment_term1") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox1" runat="server" Visible="false" /></td>
                                       
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right">2nd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm2" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                           SelectedValue='<%# Bind("payment_term2") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right" >3rd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm3" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                           SelectedValue='<%# Bind("payment_term3") %>'>
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox3" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   
                                   <td width="40%" align="right" >Final Payment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTermF" runat="server" onload="DropDownList1_Load"  Enabled="false"
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
                                   <%--<tr><td 
                               align="left" colspan="4"><b>&nbsp;&nbsp; Vender Type: </b><br /><asp:CheckBoxList 
                               ID="clVenderTypeList" runat="server" AutoPostBack="False"  Enabled="false"
                               DataSourceID="EntityDataSource2" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList><asp:EntityDataSource 
                               ID="EntityDataSource2" runat="server" ConnectionString="name=WoWiEntities" 
                               DefaultContainerName="WoWiEntities" EnableFlattening="False" 
                               EntitySetName="vendor_type" Select="it.[id], it.[name]"></asp:EntityDataSource></td></tr>--%>
                                <tr><td align="left" colspan="4">
                                 <asp:Label runat="server" ID="lblC" Text="Contact :"></asp:Label>
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
               <tr><td align="left" colspan="4">
               <asp:Label runat="server" ID="lblB" Text="Banking Information :"></asp:Label>
                                    <asp:GridView ID="GridView2" runat="server" Width="100%" OnPreRender="GridView2_PreRender"
                                        onload="GridView2_Load" AutoGenerateColumns="False" >
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
                                   
              </td>
              <tr><td align="left" colspan="4">
              <asp:Label runat="server" ID="lblWUB" Text="Western Union Banking Information :"></asp:Label>
                                    <asp:GridView ID="GridView3" runat="server" Width="100%"
                                        onload="GridView3_Load" AutoGenerateColumns="False" >
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
                               <tr><td colspan="4">
                                      <table align="center" border="0" cellpadding="2" cellspacing="0" width="100%">
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
                               
                               
                               </table></td></tr>
                               
                
             
              
                </table>
        
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [vendor] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
         
        </asp:Content>

