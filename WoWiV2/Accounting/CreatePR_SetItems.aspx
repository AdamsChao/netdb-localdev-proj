<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    int id;
 
    protected void ddlVenderList_Load(object sender, EventArgs e)
    {
        var list = (from c in wowidb.vendors select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name : c.name });

        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
    }

    protected void ddlTarget_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            int quotaion_id = (int)obj.quotaion_id;
            String quotaion_no = (from d in db.Quotation_Version where d.Quotation_Version_Id == quotaion_id select d.Quotation_No).First();
            var list = from q in db.Quotation_Version
                       where q.Quotation_No.Equals(quotaion_no)
                       select new
                       {
                           No = q.Quotation_No,
                           Version = q.Vername
                           ,
                           Id = q.Quotation_Version_Id
                       };
            var data = from t in db.Target from qt in db.Quotation_Target from q in list from c in db.country where qt.quotation_id == q.Id & qt.target_id == t.target_id & t.country_id == c.country_id select new { Text = t.target_code + "(" + q.No + ") - [" + c.country_name + "]", Id = qt.Quotation_Target_Id, Version = q.Version };
            (sender as DropDownList).DataSource = data;
            (sender as DropDownList).DataTextField = "Text";
            (sender as DropDownList).DataValueField = "Id";
            (sender as DropDownList).DataBind();
        }
        
    }

    protected void ddlVenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = int.Parse((sender as DropDownList).SelectedValue);
        Panel VenderPanel = FormView1.FindControl("VenderPanel") as Panel;
        VenderPanel.Visible = true;
        (FormView1.FindControl("btnShow") as Button).Visible = true;
        WoWiModel.vendor data = (from s in wowidb.vendors where s.id == id select s).First();
        (FormView1.FindControl("lbCompany") as Label).Text = data.name;
        (FormView1.FindControl("lbcCompany") as Label).Text = data.c_name;
        (FormView1.FindControl("lbFax1") as Label).Text = data.fax1;
        (FormView1.FindControl("lbFax2") as Label).Text = data.fax2;
        (FormView1.FindControl("lbTel1") as Label).Text = data.tel1;
        (FormView1.FindControl("lbTel2") as Label).Text = data.tel2;
        (FormView1.FindControl("lbAddress") as Label).Text = data.address;
        (FormView1.FindControl("lbcAddress") as Label).Text = data.c_address;
        (FormView1.FindControl("lbLU") as Label).Text = data.ub_license_number;
        (FormView1.FindControl("ddlCountry") as DropDownList).SelectedValue = data.country.ToString();
        (FormView1.FindControl("ddlQualification") as DropDownList).SelectedValue = data.qualification;
        (FormView1.FindControl("ddlContractType") as DropDownList).SelectedValue = data.contract_type;
        (FormView1.FindControl("ddlBankCharge") as DropDownList).SelectedValue = data.bank_charge.ToString();
        (FormView1.FindControl("ddlPaymentType") as DropDownList).SelectedValue = data.payment_type.ToString();
        (FormView1.FindControl("ddlPaymentDays") as DropDownList).SelectedValue = data.paymentdays;
        (FormView1.FindControl("ddlPaymentTerm1") as DropDownList).SelectedValue = data.payment_term1.ToString();
        (FormView1.FindControl("ddlPaymentTerm2") as DropDownList).SelectedValue = data.payment_term2.ToString();
        (FormView1.FindControl("ddlPaymentTerm3") as DropDownList).SelectedValue = data.payment_term3.ToString();
        (FormView1.FindControl("ddlPaymentTermF") as DropDownList).SelectedValue = data.payment_term_final.ToString();
        (FormView1.FindControl("lbPaymentBal") as Label).Text = data.payment_balance.ToString() ;
        initContact(id);
        initBankingAccount(id);
    }
    protected void initContact(int id)
    {
        DropDownList ddl = (FormView1.FindControl("ddlContact") as DropDownList);
        Label lbl = FormView1.FindControl("lblC") as Label;
        GridView gv = (FormView1.FindControl("GridView1") as GridView);
        var ids = from c in wowidb.m_vender_contact where c.vender_id == id select c.contact_id;
        if (ids.Count() != 0)
        {
           
            lbl.Visible = true;
            ddl.Visible = true;
            gv.Visible = true;
            var data = from v in wowidb.contact_info
                       from idx in ids
                       where v.id == idx
                       select new
                       {
                           text = String.IsNullOrEmpty(v.fname) ? v.c_lname
                               + " " + v.c_fname : v.fname + " " + v.lname,
                           id = v.id
                       };
            ddl.DataSource = data;
            ddl.DataTextField = "text";
            ddl.DataValueField = "id";
            ddl.DataBind();
            int i = data.First().id;
            gv.DataSource = from v in wowidb.contact_info where v.id== i select v;
            gv.DataBind();
        }
        else
        {
            ddl.Visible = false;
            lbl.Visible = false;
            gv.Visible = false;
        }
        
    }

    protected void initBankingAccount(int id)
    {
        DropDownList ddl = (FormView1.FindControl("ddlBankAccount") as DropDownList);
        Label lblWUB = FormView1.FindControl("lblWUB") as Label;
        Label lblAccount = FormView1.FindControl("lblAccount") as Label;
        Label lblB = FormView1.FindControl("lblB") as Label;
        GridView bgv = (FormView1.FindControl("GridView2") as GridView);
        GridView wgv = (FormView1.FindControl("GridView3") as GridView);
        var ids = from c in wowidb.venderbankings where c.vender_id == id select new {id=c.bank_id,text= (bool
            )c.isWestUnit?c.wu_first_name+ " "+c.wu_last_name:c.bank_name+" "+c.bank_branch_name};
        if (ids.Count() != 0)
        {
            lblAccount.Visible = true;
            ddl.DataSource = ids;
            ddl.DataTextField = "text";
            ddl.DataValueField = "id";
            ddl.DataBind();
            ddl.Visible = true;
        
            var bankAcct =  (from c in wowidb.venderbankings where c.vender_id == id select c);
            int ii= bankAcct.First().bank_id;
            bankAcct = bankAcct.Where(n => n.bank_id == ii);
            if ((bool)bankAcct.First().isWestUnit)
            {
                lblWUB.Visible = true;
                wgv.Visible = true;
                lblB.Visible = false;
                bgv.Visible = false;
                wgv.DataSource = bankAcct;
                wgv.DataBind();
            }
            else
            {
                lblWUB.Visible = false;
                wgv.Visible = false;
                lblB.Visible = true;
                bgv.Visible = true;
                bgv.DataSource = bankAcct;
                bgv.DataBind();
            }
            
        }
        else
        {
            lblAccount.Visible = false;
            ddl.Visible = false;
            lblWUB.Visible = false;
            lblB.Visible = false;
            bgv.Visible = false;
            wgv.Visible = false;
        }
    }

    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        DropDownList list = (DropDownList)sender;
        int[] data = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
        list.DataSource = data;//Enumerable.Range(0, 101);
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Panel VenderPanel = FormView1.FindControl("VenderPanel") as Panel;
        if (VenderPanel.Visible)
        {
            btn.Text = "Show";
        }else{

            btn.Text = "Hide";
        }
        VenderPanel.Visible = !VenderPanel.Visible;
    }


    protected void ddlTarget_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void ddlContact_SelectedIndexChanged(object sender, EventArgs e)
    {
        int i =  int.Parse((sender as DropDownList).SelectedValue);
        GridView gv = (FormView1.FindControl("GridView1") as GridView);
        gv.DataSource = from v in wowidb.contact_info where v.id == i select v;
        gv.DataBind();
    }

    protected void ddlBankAccount_SelectedIndexChanged(object sender, EventArgs e)
    {
        int i = int.Parse((sender as DropDownList).SelectedValue);
        var bankAcct = (from c in wowidb.venderbankings where c.bank_id == i select c);
        Label lblWUB = FormView1.FindControl("lblWUB") as Label;
        Label lblB = FormView1.FindControl("lblB") as Label;
        GridView bgv = (FormView1.FindControl("GridView2") as GridView);
        GridView wgv = (FormView1.FindControl("GridView3") as GridView);
        if ((bool)bankAcct.First().isWestUnit)
        {
            lblWUB.Visible = true;
            wgv.Visible = true;
            lblB.Visible = false;
            bgv.Visible = false;
            wgv.DataSource = bankAcct;
            wgv.DataBind();
        }
        else
        {
            lblWUB.Visible = false;
            wgv.Visible = false;
            lblB.Visible = true;
            bgv.Visible = true;
            bgv.DataSource = bankAcct;
            bgv.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
        }
        
    }

    protected void PlaceHolder1_Load(object sender, EventArgs e)
    {
        (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Clear();
        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        if (System.IO.Directory.Exists(UpPath))
        {
            String[] list = System.IO.Directory.GetFiles(UpPath);
            foreach (String item in list)
            {
                HyperLink link = new HyperLink();
                int idx = item.LastIndexOf("\\");
                String fileName = item.Substring(idx + 1);
                link.NavigateUrl = "~/Accounting/FileListHandler.ashx?id=" + prid + "&fn=" + fileName;
                link.Text = fileName;
                (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Add(link);
                Label lb = new Label();
                lb.Text = "<br>";
                (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Add(lb);
            }
            (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Visible = true;
        }
    }

    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.PR obj = (WoWiModel.PR)e.Entity;

            Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
        }
    }

    protected void EntityDataSource1_Updating(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.PR obj = (WoWiModel.PR)e.Entity;
        DropDownList ddlContact = (FormView1.FindControl("ddlContact") as DropDownList);
        if (!String.IsNullOrEmpty(ddlContact.SelectedValue))
        {
            obj.vendor_contact_id = int.Parse(ddlContact.SelectedValue);
        }
        DropDownList ddlVenderList = (FormView1.FindControl("ddlVenderList") as DropDownList);
        if (!String.IsNullOrEmpty(ddlVenderList.SelectedValue))
        {
            obj.vendor_id = int.Parse(ddlVenderList.SelectedValue);
        }
        DropDownList ddlBankAccount = (FormView1.FindControl("ddlBankAccount") as DropDownList);
        if (!String.IsNullOrEmpty(ddlBankAccount.SelectedValue))
        {
            obj.vendor_banking_id = int.Parse(ddlBankAccount.SelectedValue);
        }

        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

    
    protected void lblProjectNo_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            int project_id = (int)obj.project_id;
            (sender as Label).Text = (from p in db.Project where p.Project_Id == project_id select p.Project_No).First();
        }
    }

    protected void lblQuotationNo_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            int quotaion_id = (int)obj.quotaion_id;
            (sender as Label).Text = (from d in db.Quotation_Version where d.Quotation_Version_Id == quotaion_id select d.Quotation_No).First();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        
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
    <script type="text/javascript">
        function openAttachWin() {
            window.open('<%= "MultiFileUpload.aspx?id=" + Request.QueryString["id"] %>', 'new', 'scrollbars=no,menubar=no,height=300,width=600,resizable=no,toolbar=no,location=no,status=no,menubar=no');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="pr_id"  
           SkinID="FormView"
            DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="900px"  >
           
            <EditItemTemplate>
             <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>--%>
               <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%">
             <tr><th 
                           align="left" class="style10"><font size="+1">&nbsp;Purchase Request 
                  Id = <asp:Label ID="lblPRNo" runat="server" Text='<%# Eval("pr_id") %>'></asp:Label> 
                 &nbsp;</font><%--<asp:HyperLink 
                           ID="HyperLink1" runat="server" NavigateUrl="~/Accounting/PRList.aspx">PR List</asp:HyperLink>--%>&#160;</th></tr>
                            
                           <tr><td><table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><td 
                                   align="left" colspan="4">
                          </td></tr>
                          
                          
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                PR&nbsp; Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp; Project No.:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:Label ID="lblProjectNo" runat="server" Text="Label" 
                                         onload="lblProjectNo_Load"></asp:Label>
                            </td><th align="left" 
                                   class="style11">&nbsp; Qutation No.:&nbsp;</th><td class="style12" width="30%">
                                     <asp:Label ID="lblQuotationNo" runat="server" Text="Label" 
                                         onload="lblQuotationNo_Load"></asp:Label>
                            </td></tr>
                            
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Attachments:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                       <asp:Button ID="Button1" runat="server" Text="Attach Files" OnClientClick="openAttachWin()" /><br>
                                       <asp:PlaceHolder ID="PlaceHolder1" runat="server" OnLoad="PlaceHolder1_Load"></asp:PlaceHolder>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Target:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                <asp:DropDownList ID="ddlTarget" runat="server" 
                                    AutoPostBack="True"  OnLoad="ddlTarget_Load"
                                        onselectedindexchanged="ddlTarget_SelectedIndexChanged">
                                    <asp:ListItem Value="-1">Select one</asp:ListItem>
                               </asp:DropDownList>&nbsp;<asp:Button ID="Button2" runat="server" Text="Add" />
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp;Currency:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:TextBox ID="tbCurrency" runat="server" 
                                         ></asp:TextBox>
                            </td><th align="left" 
                                   class="style11">&nbsp; Total:&nbsp;</th><td class="style12" width="30%">
                                    <asp:TextBox ID="tbTotalAmount" runat="server" 
                                         ></asp:TextBox>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Vender:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                <asp:DropDownList ID="ddlVenderList" runat="server" 
                                    AppendDataBoundItems="True" AutoPostBack="True" onload="ddlVenderList_Load" 
                                        onselectedindexchanged="ddlVenderList_SelectedIndexChanged">
                                    <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>&nbsp;<asp:Button ID="btnShow" runat="server" Text="Hide" 
                                        Visible="false" onclick="btnShow_Click" />
                            </td></tr>
                             
                   <asp:Panel ID="VenderPanel" runat="server" Visible="false">

                                 <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Vender&nbsp; Information</th>
                        </tr>
                                <tr ><td class="style4" colspan="4">
                      <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr >
                              <td>
                              <table 
                               align="center" border="1" cellpadding="0" cellspacing="0" width="100%"><tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Company:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%"><asp:Label ID="lbCompany" runat="server" ></asp:Label></td>
                                   <th align="left" 
                                   class="style11">&#160; 公司:&#160;</th><td class="style12" width="30%"><asp:Label 
                                       ID="lbcCompany" runat="server" ></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Tel1:</th><td 
                                   width="30%"><asp:Label ID="lbTel1" runat="server" 
                                      ></asp:Label>&#160;&#160;&#160;&#160;&#160;</td><th align="left" 
                                   class="style7">&nbsp;&nbsp; Fax1:</th><td width="30%"><asp:Label 
                                       ID="lbFax1" runat="server"></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Tel2:</th><td width="30%"><asp:Label 
                                       ID="lbTel2" runat="server"></asp:Label></td><th 
                                   align="left" class="style7">&nbsp;&nbsp; Fax2:&nbsp;</th><td width="30%"><asp:Label 
                                       ID="lbFax2" runat="server" ></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Address:&nbsp;</th><td 
                                   width="30%"><asp:Label ID="lbAddress" runat="server" 
                                     Width="211px"></asp:Label></td><th 
                                   align="left" class="style7">&#160; 地址:&#160;</th><td width="30%"><asp:Label 
                                       ID="lbcAddress" runat="server" Width="211px"></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&nbsp;&nbsp;&nbsp;Country:&nbsp;</th>
                                    <td 
                                   width="30%">
                              <asp:DropDownList ID="ddlCountry" runat="server"  Enabled="false"
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" >
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td><th align="left" 
                                   class="style7">&nbsp; Unified Business License Number:</th><td width="30%">
                              <asp:Label ID="lbLU" 
                                       runat="server" ></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="ddlQualification" runat="server" Enabled="false"
                                      ><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></asp:DropDownList></td><th 
                                   align="left" class="style7">&#160; Contract Type:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="ddlContractType"  Enabled="false" runat="server" ><asp:ListItem>- Select Contract Type</asp:ListItem><asp:ListItem>Sub-Contractor</asp:ListItem><asp:ListItem>Contracted Employee</asp:ListItem></asp:DropDownList></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlBankCharge" runat="server"  Enabled="false"
                                                   >
                                                   <asp:ListItem Value="-1">- Select Charge Type</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                               </asp:DropDownList>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server"  Enabled="false"
                                                  >
                                                   <asp:ListItem Value="-1">- Select&nbsp; Payment Type</asp:ListItem>
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
                                             <asp:DropDownList ID="ddlPaymentDays" runat="server" Enabled="false"
                                               >
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
                                   align="left" class="style2" colspan="4"><b>&nbsp;&nbsp; Payment Term: </b><br>
                                  
                                   <table  border="0" cellpadding="2" cellspacing="0"  style="width:100%">
                                   <tr>
                                   <td width="40%" align="right">1st Prepayment : </td>
                                   <td width="10%" > </td>
                                   <td width="50%" > 
                                       <asp:DropDownList ID="ddlPaymentTerm1" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                      >
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox1" runat="server" Visible="false" /></td>
                                       
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right">2nd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm2" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                           >
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right" >3rd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTerm3" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                         >
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox3" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   
                                   <td width="40%" align="right" >Final Prepayment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                   <asp:DropDownList ID="ddlPaymentTermF" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                          >
                                       </asp:DropDownList> % 
                                       <asp:CheckBox ID="CheckBox5" runat="server" Visible="false" />
                                   </td>
                                  
                                   </tr>
                                   <tr>
                         
                                   <td width="40%" align="right" >Balance of Payment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                       <asp:Label ID="lbPaymentBal" runat="server"></asp:Label> %
                                   </td>
                                   
                                   </tr>


                                   </table>
                                   
                                   </td>
                                   </tr>
                                  </td>
                          </tr>
                      </table>
                      </td></tr>     
                      <tr><td align="left" colspan="4">
                                 <asp:Label runat="server" ID="lblC" Text="Contact :"></asp:Label><asp:DropDownList AutoPostBack="True"
                                     ID="ddlContact" runat="server" onselectedindexchanged="ddlContact_SelectedIndexChanged">
                                 </asp:DropDownList>
                                    <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False" >
                                        <Columns>
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
              </tr> <tr><td align="left" colspan="4">
               <asp:Label runat="server" ID="lblAccount" Text="Banking Account :"></asp:Label>
                                    <asp:DropDownList AutoPostBack="True"
                                     ID="ddlBankAccount" runat="server" onselectedindexchanged="ddlBankAccount_SelectedIndexChanged">
                                 </asp:DropDownList>
              </td></tr>
               <tr><td align="left" colspan="4">
               <asp:Label runat="server" ID="lblB" Text="Banking Information :" Visible="false"></asp:Label>
                                    <asp:GridView ID="GridView2" runat="server" Width="100%" AutoGenerateColumns="False"  Visible="false">
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
                                   
              </td></tr>
              <tr><td align="left" colspan="4">
              <asp:Label runat="server" ID="lblWUB" Text="Western Union Banking Information :"  Visible="false"></asp:Label>
                                    <asp:GridView ID="GridView3" runat="server" Width="100%" AutoGenerateColumns="False"  Visible="false" >
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
              </tr>              </asp:Panel>
               <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Authority Owner</th>
                        </tr>
                            <tr><td colspan="4">
                            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr >
                                 <td>
                                    Requisitioner
                                 </td>
                                 <td>
                                     <asp:Button ID="btnSendReq" runat="server" Text="SendRequest" />
                                 </td>
                                 <td>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblRequisitioner" runat="server" Text="lblRequisitioner"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblRequisitionerDate" runat="server" Text="lblRequisitionerDate"></asp:Label>
                                 </td>
                                 <td rowspan="3">
                                 Internal Marks:<br/>
                                     <asp:TextBox ID="tbInternalMarks" runat="server" TextMode="MultiLine" Width="200" Height="100"></asp:TextBox>
                                 </td>
                          </tr>
                           <tr >
                                 <td>
                                    Supervisor
                                 </td>
                                 <td>
                                     <asp:Button ID="btnSupervisorApprove" runat="server" Text="Approve" />
                                 </td>
                                 <td>
                                    <asp:Button ID="btnSupervisorDisapprove" runat="server" Text="Disapprove" />
                                 </td>
                                 <td>
                                     <asp:Label ID="lblSupervisor" runat="server" Text="lblSupervisor"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblSupervisorDate" runat="server" Text="lblSupervisorDate"></asp:Label>
                                 </td>
                          </tr>
                           <tr >
                                 <td>
                                    VP
                                 </td>
                                 <td>
                                     <asp:Button ID="btnVPApprove" runat="server" Text="Approve" />
                                 </td>
                                 <td>
                                    <asp:Button ID="btnVPDisapprove" runat="server" Text="Disapprove" />
                                 </td>
                                 <td>
                                     <asp:Label ID="lblVP" runat="server" Text="lblVP"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblVPDate" runat="server" Text="lblVPDate"></asp:Label>
                                 </td>
                          </tr>
                          <tr >
                                 <td>
                                    President
                                 </td>
                                 <td>
                                     <asp:Button ID="btnPresidentApprove" runat="server" Text="Approve" />
                                 </td>
                                 <td>
                                    <asp:Button ID="btnPresidentDisapprove" runat="server" Text="Disapprove" />
                                 </td>
                                 <td>
                                     <asp:Label ID="lblPresident" runat="server" Text="lblPresident"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblPresidentDate" runat="server" Text="lblPresidentDate"></asp:Label>
                                 </td>
                                 <td rowspan="3">
                                 Instruction:<br/>
                                     <asp:TextBox ID="tbInstruction" runat="server" TextMode="MultiLine" Width="200" Height="100"></asp:TextBox>
                                 </td>
                          </tr>
                          <tr >
                                 <td>
                                    Finance Dept:
                                 </td>
                                 <td>
                                     
                                 </td>
                                 <td>
                                    
                                 </td>
                                 <td>
                                     <asp:Label ID="lblFinance" runat="server" Text="lblFinance"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblFinanceDate" runat="server" Text="lblFinanceDate"></asp:Label>
                                 </td>
                          </tr>
                          <tr >
                                 <td>
                                    Cancel:
                                 </td>
                                 <td>
                                     <asp:Button ID="btnCancel" runat="server" Text="Withdraw" />
                                 </td>
                                 <td>
                                    
                                 </td>
                                 <td>
                                    
                                 </td>
                                 <td>
                                   
                                 </td>
                          </tr>
                      </table>

                            </td></tr>

                                <tr align="center"><td class="style4" colspan="4">
                      <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr align="center">
                              <td>
                                  <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Finish" />
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;</td>
                          </tr>
                      </table>
                      </td></tr>
                             </table>
               <%-- </ContentTemplate>
                  <Triggers>
                      <asp:PostBackTrigger ControlID="UpdateButton" />
                  </Triggers>
                </asp:UpdatePanel>--%>
           </EditItemTemplate>
        </asp:FormView>
   
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
            EnableInsert="True" EntitySetName="PRs" 
            onupdated="EntityDataSource1_Updated" Where="it.pr_id == @id" 
                    onupdating="EntityDataSource1_Updating" EnableUpdate="True"  >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource >
  
                           
</asp:Content>

