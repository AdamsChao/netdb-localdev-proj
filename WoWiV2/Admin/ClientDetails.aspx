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
                                   Client Code :&nbsp;
                                   <asp:Label ID="tbClientCode" runat="server" Text='<%# Bind("code") %>' 
                                       Width="80px"></asp:Label>
                                   <asp:CheckBox Enabled="false"
                              ID="cbApplican" runat="server" Text="Is Applicant Also" />
                          <asp:CheckBox ID="cbpotential" runat="server" Text="Potential Client" Enabled="false"
                                       Checked='<%# Bind("potential_client") %>' />
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Client Contact Information</th>
                        </tr>
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
                                  <asp:ListItem Value="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          </asp:ListItem>
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
                                   class="style7">&nbsp; <b>Annual Number Grants</b>:</th><td width="30%">
                              <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("grant_rank") %>' Enabled="false">
                                  <asp:ListItem Value="0">&nbsp; 0 -&nbsp; 5 grants</asp:ListItem>
                                  <asp:ListItem Value="1">&nbsp;  6 - 10 grants</asp:ListItem>
                                  <asp:ListItem Value="2"> 11 - 15 grants</asp:ListItem>
                                  <asp:ListItem Value="3"> 16 - 20 grants</asp:ListItem>
                                  <asp:ListItem Value="4">&nbsp; &gt;&nbsp;&nbsp; 20 grants</asp:ListItem>

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
                                                     SelectCommand="SELECT [id], [name] FROM [clientapplicant_industry]"></asp:SqlDataSource>
                                                 </td></tr>
                               <tr><td 
                               align="left" colspan="4"><b>&#160; Technologies: </b><br />
                                   <asp:CheckBoxList 
                               ID="clTechnologyList" runat="server" Enabled="false"
                               DataSourceID="SqlDataSource3" DataTextField="name" DataValueField="id" 
                               RepeatColumns="5" RepeatDirection="Horizontal"></asp:CheckBoxList>
                                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                       ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                       SelectCommand="SELECT [id], [name] FROM [clientapplicant_technology]"></asp:SqlDataSource>
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
                                       ID="tbBillEmail" runat="server" Text='<%# Bind("bill_email") %>'></asp:Label></td></tr>
                                       <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Tel:</th><td 
                                   width="30%"><asp:Label ID="tbBillTel" runat="server" 
                                       Text='<%# Bind("bill_workphone") %>'></asp:Label>&nbsp;Ext : &nbsp;<asp:Label ID="tbBillExt" 
                                                   runat="server" Height="21px" Text='<%# Bind("bill_ext") %>' Width="30px"></asp:Label>
                                               &nbsp;&nbsp;&nbsp;</td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Fax:</th><td width="30%">
                                               <asp:Label 
                                       ID="tbBillFax" runat="server" Text='<%# Bind("bill_fax") %>'></asp:Label></td></tr>
                               <tr>
                                   <th align="left" class="style9">
                                       <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbBillAddress" runat="server" Text='<%# Bind("bill_address") %>' 
                                           Width="211px"></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; 地址:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbCBillAddress" runat="server" Text='<%# Bind("bill_caddress") %>' 
                                           Width="211px"></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp; Country:&nbsp;</th>
                                   <td  width="30%">
                                       <asp:DropDownList ID="dlBillCountry" runat="server" Enabled="false"
                                           DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                           DataValueField="country_id">
                                       </asp:DropDownList>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Payment days:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbPaymentDays" runat="server" Text='<%# Bind("paymentdays") %>' 
                                           Width="211px"></asp:Label>
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
                                       <asp:DropDownList ID="dlOwner" runat="server" AppendDataBoundItems="True" Enabled="false"
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
                                       <asp:DropDownList ID="dlAcctMgr" runat="server" AppendDataBoundItems="True" Enabled="false"
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
                                       <asp:Label ID="tbAcctNo" runat="server" Text='<%# Bind("acctno") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td width="30%">
                                       <asp:DropDownList ID="dlPaymentTerm" runat="server" Enabled="false"
                                           SelectedValue='<%# Bind("paymentterm") %>'>
                                           <asp:ListItem  Value="0" >Net 30</asp:ListItem>
                                           <asp:ListItem  Value="1" >Cache</asp:ListItem>
                                       </asp:DropDownList>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Credit Limit:</th>
                                   <td class="style11" width="30%">
                                       <asp:Label ID="tbCreditLimit" runat="server" 
                                           Text='<%# Bind("creditlimit") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style10">
                                       &nbsp;&nbsp; Client Status:&nbsp;</th>
                                   <td class="style11" width="30%">
                                       <asp:DropDownList ID="dlClientStatus" runat="server" Enabled="false"
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
                                       <asp:Label ID="tbFedexAcct" runat="server" Text='<%# Bind("fedex_acct") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp;&nbsp; DHL Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbDhlAcct" runat="server" Text='<%# Bind("dhl_acct") %>'></asp:Label>
                                   </td>
                               </tr>
                               <tr >
                                  
                                        <th align="left" class="style7">
                                       &nbsp; 統一編號:&nbsp;</th>
                                   <td colspan="3">
                                       <asp:Label ID="Label5" runat="server" Text='<%# Bind("business_registration_number") %>' 
                                           Width="211px"></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;UPS Acct.:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="Label8" runat="server" Text='<%# Bind("ups_accountno") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Bank Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbBankName" runat="server" Text='<%# Bind("ups_bankname") %>'></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Bank Address:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbBankAddress" runat="server" 
                                           Text='<%# Bind("ups_bankaddress") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Swift Code:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbSwiftCode" runat="server" 
                                           Text='<%# Bind("ups_swiftcode") %>'></asp:Label>
                                   </td>
                               </tr>
                               <tr>
                                   <th align="left" class="style9">
                                       &nbsp;&nbsp;&nbsp;Banefucuany Name:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbBanefucuanyName" runat="server" 
                                           Text='<%# Bind("ups_banefucuanyname") %>'></asp:Label>
                                   </td>
                                   <th align="left" class="style7">
                                       &nbsp; Passby Bank:&nbsp;</th>
                                   <td width="30%">
                                       <asp:Label ID="tbPassbyBank" runat="server" 
                                           Text='<%# Bind("ups_passbybank") %>'></asp:Label>
                                   </td>
                               </tr>
                              
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
                                       <asp:Label ID="tbRemarks" runat="server" Height="70" TextMode="MultiLine" 
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

