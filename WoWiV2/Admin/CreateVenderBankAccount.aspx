<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">

    
   

    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            Response.Redirect("~/Admin/CreateVenderBankAccount.aspx?id=" + id+isWestUnitStr);
        }
    }

    
    int id;
    bool isWestUnit;
    String isWestUnitStr ;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            id = int.Parse(Request.QueryString["id"]);
        }
        catch
        {
        }

        try
        {
            String isWUStr = Request.QueryString["iswu"];
            if (!String.IsNullOrEmpty(isWUStr) && isWUStr == "1")
            {
                isWestUnit = true;
                isWestUnitStr = "&iswu=1";
                FormView1.Visible = false;
                FormView2.Visible = true;
                GridView1.Visible = false;
                GridView2.Visible = true;
            }
            else
            {
                isWestUnitStr = "";
                FormView1.Visible = true;
                FormView2.Visible = false;
                GridView1.Visible = true;
                GridView2.Visible = false;
            }
        }
        catch
        {
        }
    }

    
    protected void lbMessage_Load(object sender, EventArgs e)
    {
        //Utils.Message_Load((Label)sender, ViewState, VenderUtils.Key_ViewState_InsertMessage);
    }

    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.venderbanking obj = (WoWiModel.venderbanking)e.Entity;
        obj.isWestUnit = isWestUnit;
        obj.vender_id = id;
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/SelectExistContact.aspx?id=" + id + "&type=vender");
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
            DataSourceID="EntityDataSource1" DefaultMode="Insert" Width="100%" >
           
            <InsertItemTemplate>
             <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>--%>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
              <tr><th 
                           align="left" class="style10"><font size="+1">Vender Bank Account Information Creation&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;<asp:Label 
                           ID="lbMessage" runat="server" ForeColor="Red" onload="lbMessage_Load"></asp:Label></th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><%--<tr><td 
                                   align="left" colspan="4">Load from : <asp:DropDownList ID="dlVenderList" 
                                   runat="server" AppendDataBoundItems="False" AutoPostBack="True" 
                                   onload="dlVenderList_Load"></asp:DropDownList><asp:Button ID="btnLoad" 
                                   runat="server" onclick="btnLoad_Click" Text="Load" /></td></tr>--%>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Bank Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankName" runat="server" Text='<%# Bind("bank_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="tbBankName" ErrorMessage="Have to provide Bank Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Branch Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBranchName" runat="server" 
                                Text='<%# Bind("bank_branch_name") %>'></asp:TextBox></td></tr>
                                <tr>
                                <th 
                                   align="left" class="style2"><font color="red">*&nbsp;</font> Swif Code:&#160;</th><td class="style3" 
                                   width="30%">
                            <asp:TextBox ID="tbSwif" runat="server" 
                                       Text='<%# Bind("bank_swifcode") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="tbSwif" ErrorMessage="Have to provide Swift Code" 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Address:&nbsp;</th><td width="30%">
                            <asp:TextBox ID="tbBankAddress" runat="server" 
                                Text='<%# Bind("bank_address") %>' Width="211px"></asp:TextBox>
                        </td></tr>
                                <tr>
                                <th 
                                   align="left" class="style7"><font color="red">*&nbsp;</font> Account No.(IBAN):&#160;&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbBankAccountNo" runat="server" 
                                Text='<%# Bind("bank_account_no") %>' MaxLength="31"  Width="211px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="tbBankAccountNo" ErrorMessage="Have to provide Account No." 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                        <th align="left" 
                                   class="style7"><font color="red">*&nbsp;</font> Beneficiary Name:</th><td class="style3" width="30%">
                            <asp:TextBox ID="tbBeneficiaryName" runat="server" 
                                Text='<%# Bind("bank_beneficiary_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                            ControlToValidate="tbBeneficiaryName" 
                                            ErrorMessage="Have to provide Beneficiary Name" ForeColor="Red">*</asp:RequiredFieldValidator>
                        </td></tr>
                        <tr>
                                <th 
                                   align="left" class="style7">&#160;&nbsp;&nbsp;Routing No.:&#160;&#160;</th><td  colspan="3"><asp:TextBox 
                                       ID="tbBankRoutingNo" runat="server" 
                                Text='<%# Bind("bank_routing_no") %>' MaxLength="50"  Width="211px"></asp:TextBox>
                                    </td></tr>
                            <tr><th 
                                   align="left" class="style2">&nbsp;&nbsp; Comments:&#160;</th><td class="style3" colspan="3"
                                   width="30%">
                          
                                    <asp:TextBox ID="TextBox1" runat="server" Width="600px" Text='<%# Bind("bank_comments") %>' TextMode="MultiLine" Height="100"></asp:TextBox>
                          
                        </td></tr>
                            </table></td></tr><tr><td class="style4"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"><tr align="center"><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Create" />&#160;&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />&#160;
                                            &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                           Text="Next" onclick="LinkButton1_Click" />
                      <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                          ShowMessageBox="True" ShowSummary="False" />
                      </td></tr></table></td></tr>
             
    </table>    
                
            </InsertItemTemplate>
        </asp:FormView>
          <asp:FormView ID="FormView2" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Insert" Width="100%" >
           
            <InsertItemTemplate>
             <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>--%>
              <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
              <tr><th 
                           align="left" class="style10"><font size="+1">Vender Western Union Bank Account Information Creation&#160; </font><asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Admin/VenderList.aspx">Vender List</asp:HyperLink>&#160;<asp:Label 
                           ID="lbMessage" runat="server" ForeColor="Red" onload="lbMessage_Load"></asp:Label></th></tr><tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> First Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuFirstName" runat="server" Text='<%# Bind("wu_first_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                            ControlToValidate="tbWuFirstName" ErrorMessage="Have to provide First Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    <th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Last Name:&#160;</th><td width="30%"><asp:TextBox 
                                       ID="tbWuLastName" runat="server" Text='<%# Bind("wu_last_name") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ControlToValidate="tbWuLastName" ErrorMessage="Have to provide Last Name " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    </tr>
                                <tr><th 
                                   align="left" class="style9"><font color="red">*&nbsp;</font> Destination:&#160;</th><td colspan="3"><asp:TextBox 
                                       ID="tbWuDestination" runat="server" Text='<%# Bind("wu_destination") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ControlToValidate="tbWuDestination" ErrorMessage="Have to provide Destination " 
                                            ForeColor="Red">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    
                                    </tr>
                                
                            
                            </table></td></tr><tr><td class="style4"><table align="center" border="0" cellpadding="0" cellspacing="0" width="100%"><tr align="center"><td><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                            CommandName="Insert" Text="Create" />&#160;&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />&#160;
                                            &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                           Text="Next" onclick="LinkButton1_Click" />
                      <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                          ShowMessageBox="True" ShowSummary="False" />
                      </td></tr></table></td></tr>
             
    </table>    
                
            </InsertItemTemplate>
        </asp:FormView>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" width="100%">                             
        <Columns>
            <asp:BoundField DataField="bank_name" HeaderText="Bank Name" 
                SortExpression="bank_name" />
            <asp:BoundField DataField="bank_branch_name" HeaderText="Branch Name" 
                SortExpression="bank_branch_name" />
            <asp:BoundField DataField="bank_address" HeaderText="Bank Address" 
                SortExpression="bank_address" />
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
  
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [venderbanking] WHERE (([vender_id] = @vender_id) AND ([isWestUnit] = @isWestUnit))">
            <SelectParameters>
                <asp:QueryStringParameter Name="vender_id" QueryStringField="id" Type="Int32" />
                <asp:Parameter DefaultValue="False" Name="isWestUnit" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT * FROM [venderbanking] WHERE (([vender_id] = @vender_id) AND ([isWestUnit] = @isWestUnit))">
            <SelectParameters>
                <asp:QueryStringParameter Name="vender_id" QueryStringField="id" Type="Int32" />
                <asp:Parameter DefaultValue="True" Name="isWestUnit" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableFlattening="False" EnableInsert="True" EntitySetName="venderbankings" 
        oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting" EnableDelete="False" 
            EnableUpdate="False">
        </asp:EntityDataSource >

        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource2" width="100%">                             
        <Columns>
            <asp:BoundField DataField="wu_first_name" HeaderText="First Name" 
                SortExpression="wu_first_name" />
            <asp:BoundField DataField="wu_last_name" HeaderText="Last Name" 
                SortExpression="wu_last_name" />
                <asp:BoundField DataField="wu_destination" HeaderText="Destination" 
                SortExpression="wu_destination" />
        </Columns>
    </asp:GridView>
  
        

</asp:Content>

