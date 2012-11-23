<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>
<%@ Register src="../UserControls/DateChooser2.ascx" tagname="DateChooser2" tagprefix="uc1" %>
<%@ Register src="../UserControls/UploadFileView.ascx" tagname="UploadFileView" tagprefix="uc2" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    int id;
 
    protected void ddlVenderList_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["type"]) && Request.QueryString["type"]=="payment")
        {
            (sender as DropDownList).Enabled = false;
        }
        PRUtils.ddlVenderList_Load(sender, e);
        (sender as DropDownList).DataBind();
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            try
            {
                (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser2_ascx).setText(((DateTime)obj.target_payment_date).ToString("yyyy/MM/dd"));
                if (!obj.total_cost.HasValue)
                {
                    obj.total_cost = 0;
                }
            }
            catch (Exception)
            {
                
                //throw;
            }
            if (ViewState["INIT"] != null && (bool)ViewState["INIT"])
            {
                return;
            }
            if (obj.vendor_id.HasValue && (int)obj.vendor_id != -1)
            {
                int vid = (int)obj.vendor_id;
                (sender as DropDownList).SelectedValue = vid.ToString();
                SetVenderDetails(vid);
                //init contact
                if (obj.vendor_contact_id != null && obj.vendor_contact_id != -1)
                {
                    try
                    {
                        int ci = (int)obj.vendor_contact_id;
                        (FormView1.FindControl("ddlContact") as DropDownList).SelectedValue = ci.ToString();
                        GridView gv = (FormView1.FindControl("GridView1") as GridView);
                        gv.DataSource = from v in wowidb.contact_info where v.id == ci select v;
                        gv.DataBind();
                    }
                    catch (Exception)
                    {

                        //throw;

                    }
                    
                }
                //init banking
                if (obj.vendor_banking_id.HasValue && obj.vendor_banking_id != -1)
                {
                    try
                    {
                        int bi = (int)obj.vendor_banking_id;
                        (FormView1.FindControl("ddlBankAccount") as DropDownList).SelectedValue = bi.ToString();
                        var bankAcct = (from c in wowidb.venderbankings where c.bank_id == bi select c);
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
                    catch (Exception)
                    {
                        
                        //throw;
                    }
                    
                }
                ViewState["INIT"] = true;
               
                
            }
            else
            {
               
               
            }
        }
        
    }

    protected void ddlTarget_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["type"]) && Request.QueryString["type"] == "payment")
        {
            (sender as DropDownList).Enabled = false;
        }
        (sender as DropDownList).Enabled = false;
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
                           Version = q.Vername,
                           Id = q.Quotation_Version_Id
                       };
            try
            {
                //var data = from t in db.Target_Rates from qt in db.Quotation_Target from q in list from c in db.country where qt.quotation_id == q.Id & qt.target_id == t.Target_rate_id & t.country_id == c.country_id select new { Text = "" + "(" + q.No + ") - [" + c.country_name + "]", Id = qt.Quotation_Target_Id, Version = q.Version };
                var data = PRUtils.GetList(quotaion_no);
                if (data.Count() != 0)
                {
                    (sender as DropDownList).DataSource = data;
                    (sender as DropDownList).DataTextField = "Text";
                    (sender as DropDownList).DataValueField = "Id";
                    (sender as DropDownList).DataBind();
                }
            }
            catch (Exception)
            {
                
                //throw;
            }
            
            try
            {
                WoWiModel.PR_item item = (from i in wowidb.PR_item where i.pr_id == id select i).First();
                int tid = (item.quotation_target_id);
                
                try
                {
                    (sender as DropDownList).SelectedValue = tid.ToString();
                    String currency = (from h in db.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select h.Currency).First();
                    var idata = from t in db.Target_Rates from q in db.Quotation_Version from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.Target_rate_id && q.Quotation_Version_Id == obj.quotaion_id select new { QuotataionNo = q.Quotation_No, QuotataionID = q.Quotation_Version_Id, TargetName = ((from c in db.Authority where c.authority_id == qt.authority_id select c.authority_name).FirstOrDefault()), Quotation_Target_Id = qt.Quotation_Target_Id, ItemDescription = qt.target_description, ModelNo = t.authority_name, Currency = currency, Qty = qt.unit };
                    GridView gv = (FormView1.FindControl("GridView4") as GridView);
                    if (idata.Count() != 0)
                    {
                        gv.DataSource = idata;
                        gv.DataBind();
                    }

                }
                catch (Exception ex)
                {
                    //throw ex;//Show Message In Javascript
                }
            }
            catch (Exception ex)
            {
                //throw ex;//Show Message In Javascript
            }
        }
        
    }

    protected void ddlVenderList_SelectedIndexChanged(object sender, EventArgs e)
    {
        int vid = int.Parse((sender as DropDownList).SelectedValue);

        SetVenderDetails(vid);
    }

    public void SetVenderDetails(int vid)
    {
        //if (Page.IsPostBack) return;
        try
        {
            Panel VenderPanel = FormView1.FindControl("VenderPanel") as Panel;
            if (vid == -1)
            {
                VenderPanel.Visible = true;
                (FormView1.FindControl("btnShow") as Button).Visible = false;
                return;
            }
            else
            {
                VenderPanel.Visible = true;
                (FormView1.FindControl("btnShow") as Button).Visible = false;
                WoWiModel.vendor data = (from s in wowidb.vendors where s.id == vid select s).First();
                (FormView1.FindControl("lbCompany") as Label).Text = data.name;
                (FormView1.FindControl("lbcCompany") as Label).Text = data.c_name;
                (FormView1.FindControl("lbFax1") as Label).Text = data.fax1;
                (FormView1.FindControl("lbFax2") as Label).Text = data.fax2;
                (FormView1.FindControl("lbTel1") as Label).Text = data.tel1;
                (FormView1.FindControl("lbTel2") as Label).Text = data.tel2;
                (FormView1.FindControl("lbAddress") as Label).Text = data.address;
                (FormView1.FindControl("lbcAddress") as Label).Text = data.c_address;
                (FormView1.FindControl("lbLU") as Label).Text = data.ub_license_number;
                try
                {
                    (FormView1.FindControl("ddlPaymentDays") as DropDownList).SelectedValue = data.paymentdays;
                    (FormView1.FindControl("ddlCountry") as DropDownList).SelectedValue = data.country.ToString();
                    (FormView1.FindControl("ddlQualification") as DropDownList).SelectedValue = data.qualification;
                    (FormView1.FindControl("ddlContractType") as DropDownList).SelectedValue = data.contract_type;
                    (FormView1.FindControl("ddlBankCharge") as DropDownList).SelectedValue = data.bank_charge.ToString();
                    (FormView1.FindControl("ddlPaymentType") as DropDownList).SelectedValue = data.payment_type.ToString();
                    (FormView1.FindControl("ddlPaymentTerm1") as DropDownList).SelectedValue = data.payment_term1.HasValue?data.payment_term1.ToString():"0";
                    (FormView1.FindControl("ddlPaymentTerm2") as DropDownList).SelectedValue = data.payment_term2.HasValue ? data.payment_term2.ToString() : "0";
                    (FormView1.FindControl("ddlPaymentTerm3") as DropDownList).SelectedValue = data.payment_term3.HasValue ? data.payment_term3.ToString() : "0";
                    (FormView1.FindControl("ddlPaymentTermF") as DropDownList).SelectedValue = data.payment_term_final.ToString();
                }
                catch (Exception ex)
                {

                    //throw;
                }

                (FormView1.FindControl("lbPaymentBal") as Label).Text = data.payment_balance.ToString();
                initContact(vid);
                initBankingAccount(vid);
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    protected void initContact(int id)
    {
        //if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["type"]) && Request.QueryString["type"] == "payment")
        {
            (FormView1.FindControl("ddlContact") as DropDownList).Enabled = false;
        }
        DropDownList ddl = (FormView1.FindControl("ddlContact") as DropDownList);
        Label lbl = FormView1.FindControl("lblC") as Label;
        GridView gv = (FormView1.FindControl("GridView1") as GridView);
        try
        {


            var ids = from c in wowidb.m_vender_contact where c.vender_id == id select c.contact_id;
            if (ids.Count() != 0)
            {

                lbl.Visible = true;
                try
                {
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
                    if (data.Count() != 0)
                    {
                        ddl.DataSource = data;
                        ddl.DataTextField = "text";
                        ddl.DataValueField = "id";
                        ddl.DataBind();
                        ddl.Visible = true;
                        int i = data.First().id;
                        gv.DataSource = from v in wowidb.contact_info where v.id == i select v;
                        gv.DataBind();
                    }

                }
                catch (Exception)
                {

                    //throw;
                }

            }
            else
            {
                ddl.Visible = false;
                lbl.Visible = false;
                gv.Visible = false;
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }

    protected void initBankingAccount(int id)
    {
        //if (Page.IsPostBack) return;
        try
        {
            DropDownList ddl = (FormView1.FindControl("ddlBankAccount") as DropDownList);
            Label lblWUB = FormView1.FindControl("lblWUB") as Label;
            Label lblAccount = FormView1.FindControl("lblAccount") as Label;
            Label lblB = FormView1.FindControl("lblB") as Label;
            GridView bgv = (FormView1.FindControl("GridView2") as GridView);
            GridView wgv = (FormView1.FindControl("GridView3") as GridView);
            var ids = from c in wowidb.venderbankings
                      where c.vender_id == id
                      select new
                      {
                          id = c.bank_id,
                          text = (bool
                              )c.isWestUnit ? c.wu_first_name + " " + c.wu_last_name : c.bank_name + " " + c.bank_branch_name
                      };
            if (ids.Count() != 0)
            {
                lblAccount.Visible = true;
                ddl.DataSource = ids;
                ddl.DataTextField = "text";
                ddl.DataValueField = "id";
                ddl.DataBind();
                ddl.Visible = true;

                var bankAcct = (from c in wowidb.venderbankings where c.vender_id == id select c);
                int ii = bankAcct.First().bank_id;
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
        catch (Exception)
        {
            
            //throw;
        }
         
        
    }

    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        DropDownList list = (DropDownList)sender;
        int[] data = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
        list.DataSource = data;//Enumerable.Range(0, 101);
        list.DataBind();
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        Panel VenderPanel = FormView1.FindControl("VenderPanel") as Panel;
        if (btn.Text == "Hide")
        {
            btn.Text = "Show";
        }else{

            btn.Text = "Hide";
        }
        VenderPanel.Visible = !VenderPanel.Visible;
    }


   
    protected void ddlContact_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int i = int.Parse((sender as DropDownList).SelectedValue);
            GridView gv = (FormView1.FindControl("GridView1") as GridView);
            gv.DataSource = from v in wowidb.contact_info where v.id == i select v;
            gv.DataBind();
        }
        catch (Exception)
        {

            //throw;
        }
        
    }

    protected void ddlBankAccount_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
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
        catch (Exception)
        {
            
            //throw;
        }
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        lbljs.Text = "";
        if (Page.IsPostBack)
        {
            //PlaceHolder1_Load(null, null);
            return;
        }
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            try
            {
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                WoWiModel.PR_authority_history auth = wowidb.PR_authority_history.First(c => c.pr_auth_id == obj.pr_auth_id);
                try
                {
                    WoWiModel.PR_Payment pay = wowidb.PR_Payment.First(c => c.pr_id == id);
                    if (pay.status == (byte) PRStatus.ClosePaid)
                    {
                        Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
                    }
                }
                catch (Exception)
                {
                    
                    //throw;
                }
                
                //(FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser_ascx).isEnabled(false);
                if (auth.status == (byte)PRStatus.Init)
                {
                    en = true;
                    Load();
                }
                else
                {
                    en = false;
                }
            }
            catch (Exception)
            {
                
                //throw;
            }
            
        }

    }
    protected void PlaceHolder1_Load(object sender, EventArgs e)
    {
        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        if (System.IO.Directory.Exists(UpPath))
        {
            try
            {
                (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Clear();
                Control con = Page.LoadControl("~/UserControls/UploadFileView.ascx");
                (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Add(con);
                (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Visible = true;
            }
            catch (Exception)
            {
                
                //throw;
            }
            

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
        obj.modify_date = DateTime.Now;
        obj.modify_user = User.Identity.Name;
        try
        {
            DropDownList ddlContact = (FormView1.FindControl("ddlContact") as DropDownList);
            if (!String.IsNullOrEmpty(ddlContact.SelectedValue))
            {
                obj.vendor_contact_id = int.Parse(ddlContact.SelectedValue);
            }
            
        }
        catch (Exception)
        {
            
            //throw;
        }

        try
        {
            DropDownList ddlVenderList = (FormView1.FindControl("ddlVenderList") as DropDownList);
            if (!String.IsNullOrEmpty(ddlVenderList.SelectedValue))
            {
                obj.vendor_id = int.Parse(ddlVenderList.SelectedValue);
            }
        }
        catch (Exception)
        {

            //throw;
        }

        try
        {
            DropDownList ddlBankAccount = (FormView1.FindControl("ddlBankAccount") as DropDownList);
            if (!String.IsNullOrEmpty(ddlBankAccount.SelectedValue))
            {
                obj.vendor_banking_id = int.Parse(ddlBankAccount.SelectedValue);
            }

        }
        catch (Exception)
        {

            //throw;
        }

        try
        {
            usercontrols_datechooser2_ascx con = (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser2_ascx);
            obj.target_payment_date = con.GetDate();
        }
        catch (Exception)
        {

            //throw;
        }
        try
        {
            WoWiModel.PR pr = wowidb.PRs.First(p => p.pr_id == obj.pr_id);
            int auid = (int)pr.pr_auth_id;
            WoWiModel.PR_authority_history  auth = wowidb.PR_authority_history.First(a => a.pr_auth_id == auid);
            String remark = (FormView1.FindControl("tbInternalMarks") as TextBox).Text;
            String inst = (FormView1.FindControl("tbInstruction") as TextBox).Text;
            WoWiModel.employee emp = wowidb.employees.First(c => c.username == User.Identity.Name);
            String owner = emp.fname + emp.lname;
            if (remark.Trim() != "")
            {
                auth.remark += remark + " by " + owner + " \n";
            }
            if (inst.Trim() != "")
            {
                auth.instruction += inst + " by " + owner + " \n";
            }
            wowidb.SaveChanges();
        }
        catch (Exception)
        {

            //throw;
        }
        
        
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
    }

    
    protected void lblProjectNo_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            int project_id = (int)obj.project_id;
            (sender as Label).Text = (from p in db.Project where p.Project_Id == project_id select p.Project_No + " - [" + ((from qq in db.Quotation_Version where qq.Quotation_No == p.Quotation_No select qq.Model_No).FirstOrDefault()) + "]").First();
        }
    }

    protected void lblQuotationNo_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            int quotaion_id = (int)obj.quotaion_id;
            (sender as Label).Text = (from d in db.Quotation_Version where d.Quotation_Version_Id == quotaion_id select d.Quotation_No).First();
        }
    }

    protected void AuthLabel_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        try
        {


            if (!String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                int id = int.Parse(Request.QueryString["id"]);
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                if (obj.pr_auth_id == null) return;
                int authid = (int)obj.pr_auth_id;
                WoWiModel.PR_authority_history auth = (from au in wowidb.PR_authority_history where au.pr_auth_id == authid select au).First();
                Label lbl = sender as Label;
                TextBox tb = sender as TextBox;
                String text = "";
                if (lbl != null)
                {
                    text = lbl.ID;
                }
                else
                {
                    text = tb.ID;
                }
                bool init = false;
                switch (text)
                {
                    case "lblRequisitioner":
                        lbl.Text = auth.requisitioner;
                        break;
                    case "lblRequisitionerDate":
                        lbl.Text = auth.requisitioner_date == null ? "" : String.Format("{0:yyyy/MM/dd}", (DateTime)auth.requisitioner_date);
                        break;
                    case "lblFinance":
                        lbl.Text = auth.finance;
                        break;
                    case "lblFinanceDate":
                        lbl.Text = auth.finance_date == null ? "" : String.Format("{0:yyyy/MM/dd}", (DateTime)auth.finance_date);
                        break;
                    case "lblPresident":
                        lbl.Text = auth.president;
                        break;
                    case "lblPresidentDate":
                        lbl.Text = auth.president_date == null ? "" : String.Format("{0:yyyy/MM/dd}", (DateTime)auth.president_date);
                        break;
                    case "lblVP":
                        lbl.Text = auth.vp;
                        break;
                    case "lblVPDate":
                        lbl.Text = auth.vp_date == null ? "" : String.Format("{0:yyyy/MM/dd}", (DateTime)auth.vp_date);
                        break;
                    case "lblSupervisor":
                        lbl.Text = auth.supervisor;
                        break;
                    case "lblSupervisorDate":
                        lbl.Text = auth.supervisor_date == null ? "" : String.Format("{0:yyyy/MM/dd}", (DateTime)auth.supervisor_date);
                        break;
                    case "lblStatus":
                        lbl.Text = ((PRStatus)auth.status).ToString();
                        if (auth.status == (byte)PRStatus.Done)
                        {
                            lbl.Text = "PR Approved";
                        }
                        break;
                    case "tbInternalMarksHis":
                        init = true;
                        tb.Text = auth.remark;
                        break;
                    case "tbInstructionHis":
                        init = true;
                        tb.Text = auth.instruction;
                        break;
                }
                 PRStatus st = (PRStatus)auth.status;
                string username = User.Identity.Name;
                try
                {

                    int empid = (from emp in wowidb.employees where emp.username == username select emp.id).First();
                    switch (st)
                    {

                        case PRStatus.Requisitioner:

                            if (empid == auth.supervisor_id)
                            {
                                tb.Enabled = true;

                            }

                            break;
                        case PRStatus.Supervisor:

                            if (empid == auth.vp_id)
                            {
                                tb.Enabled = true;

                            }

                            break;
                        case PRStatus.VicePresident:

                            if (empid == auth.president_id)
                            {
                                tb.Enabled = true;
                            }

                            break;

                    }

                }
                catch
                {
                }
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }

 
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            if (obj.pr_auth_id == null) return;
            int authid = (int)obj.pr_auth_id;
            WoWiModel.PR_authority_history auth = (from au in wowidb.PR_authority_history where au.pr_auth_id == authid select au).First();
            auth.status = (byte)PRStatus.Cancel;
            obj.modify_date = DateTime.Now;
            auth.modify_date = DateTime.Now;
            wowidb.SaveChanges();
            Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
        }
    }

    protected void btnSendReq_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            if (obj.pr_auth_id == null) return;
            int authid = (int)obj.pr_auth_id;
            WoWiModel.PR_authority_history auth = (from au in wowidb.PR_authority_history where au.pr_auth_id == authid select au).First();
            auth.status = (byte)PRStatus.Requisitioner;
            auth.requisitioner_date = DateTime.Now;
            (FormView1.FindControl("lblRequisitionerDate") as Label).Text = String.Format("{0:yyyy/MM/dd}",DateTime.Now);
            (FormView1.FindControl("lblStatus") as Label).Text = (PRStatus.Requisitioner).ToString();
            auth.requisitioner_approval = "y";
            String remark = (FormView1.FindControl("tbInternalMarks") as TextBox).Text;
            String inst = (FormView1.FindControl("tbInstruction") as TextBox).Text;
            if (remark.Trim() != "")
            {
                auth.remark = remark + " by " + auth.requisitioner + " \n";
            }
            (FormView1.FindControl("tbInternalMarks") as TextBox).Enabled = false;

            if (inst.Trim() != "")
            {
                auth.instruction = inst + " by " + auth.requisitioner + " \n";
            }
            (FormView1.FindControl("tbInstruction") as TextBox).Enabled = false;
            wowidb.SaveChanges();
            //Send Email
            PRUtils.WaitingForSupervisorApprove(wowidb,auth);//Not Yet
            (sender as Button).Enabled = false;
            Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id,false);
        }
    }
    private void EnableInput(bool en1)
    {
        try
        {
            (FormView1.FindControl("tbInternalMarks") as TextBox).Enabled = en1;
            (FormView1.FindControl("tbInstruction") as TextBox).Enabled = en1;
        }
        catch (Exception)
        {
            
            //throw;
        }
               
            
        
    }
    protected void btn_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            if (obj.pr_auth_id == null) return;
            int authid = (int)obj.pr_auth_id;
            const byte hisStatus = (byte)PRStatus.History;
            try
            {
                //EnableInput(false);
                WoWiModel.PR_authority_history auth = (from au in wowidb.PR_authority_history where au.pr_auth_id == authid & ((byte)au.status) != hisStatus select au).First();
                PRStatus st = (PRStatus)auth.status;
                Button btn = (Button)sender;
                btn.Enabled = false;


                String btnID = btn.ID;
                string username = User.Identity.Name;
                try
                {
                   
                    int empid = (from emp in wowidb.employees where emp.username == username select emp.id).First();
                    switch (st)
                    {
                        case PRStatus.Init:
                            if (btnID == "btnSendReq" || btnID == "btnCancel")
                            {
                                if (empid == auth.requisitioner_id)
                                {
                                    btn.Enabled = true;
                                    EnableInput(true);
                                }
                            }

                            break;
                        case PRStatus.Requisitioner:
                            if (btnID == "btnSupervisorApprove" || btnID == "btnSupervisorDisapprove")
                            {
                                if (empid == auth.supervisor_id)
                                {
                                    btn.Enabled = true;
                                    EnableInput(true);
                                }
                            }
                            break;
                        case PRStatus.Supervisor:
                            if (btnID == "btnVPApprove" || btnID == "btnVPDisapprove")
                            {
                                if (empid == auth.vp_id)
                                {
                                    btn.Enabled = true;
                                    EnableInput(true);
                                }
                            }
                            break;
                        case PRStatus.VicePresident:
                            if (btnID == "btnPresidentApprove" || btnID == "btnPresidentDisapprove")
                            {
                                if (empid == auth.president_id)
                                {
                                    btn.Enabled = true;
                                    EnableInput(true);
                                }
                            }
                            break;
                        case PRStatus.Done:
                            if (Request.QueryString["type"] == "payment")
                            {
                                if (btnID == "btnPay")
                                {
                                    if (empid == auth.finance_id)
                                    {
                                        btn.Enabled = true;
                                        EnableInput(true);
                                    }
                                }
                            }
                            break;
                    }
                }
                catch
                {
                }

            }

            catch (Exception)
            {

                //throw;
            }
        }
    }

    protected void btn_Click(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            int id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            if (obj.pr_auth_id == null) return;
            int authid = (int)obj.pr_auth_id;
            try
            {


                WoWiModel.PR_authority_history auth = (from au in wowidb.PR_authority_history where au.pr_auth_id == authid select au).First();
                Button btn = (Button)sender;
                String btnID = btn.ID;
                string username = User.Identity.Name;
                try
                {
                    int empid = (from em in wowidb.employees where em.username == username select em.id).First();
                    WoWiModel.employee emp = (from c in wowidb.employees where c.id == empid select c).First();
                    String remark = (FormView1.FindControl("tbInternalMarks") as TextBox).Text;
                    String inst = (FormView1.FindControl("tbInstruction") as TextBox).Text;
                    //Use shipping_cost as authorization total cost
                    if (!obj.shipping_cost.HasValue)
                    {
                        obj.shipping_cost = 0;
                    }
                    if (!emp.pr_authorize_amt.HasValue)
                    {
                        emp.pr_authorize_amt = 0;
                    }
                    switch (btnID)
                    {
                        case "btnSupervisorApprove":
                            if (emp.pr_authorize_amt >= obj.shipping_cost)
                            {
                                auth.status = (byte)PRStatus.Done;
                                auth.modify_date = DateTime.Now;
                            }
                            else
                            {
                                auth.status = (byte)PRStatus.Supervisor;
                            }
                            auth.supervisor_date = DateTime.Now;
                            (FormView1.FindControl("lblSupervisorDate") as Label).Text = String.Format("{0:yyyy/MM/dd}", DateTime.Now);
                            auth.supervisor_approval = "y";
                            if (remark.Trim() != "")
                            {
                                auth.remark += remark + " by " + auth.supervisor + " \n";
                            }
                            if (inst.Trim() != "")
                            {
                                auth.instruction += inst + " by " + auth.supervisor + " \n";
                            }
                            wowidb.SaveChanges();
                            //Send Email To
                            if (auth.status == (byte)PRStatus.Supervisor)
                            {
                                PRUtils.WaitingForVPApprove(wowidb,auth);//Not Yet
                            }
                            else
                            {
                                PRUtils.PRStatusDone(wowidb, auth);
                            }
                            SetValue("btnSupervisorApprove", "btnSupervisorDisapprove", (byte)auth.status);
                            break;
                        case "btnSupervisorDisapprove":
                            disapprove(obj, auth, "lblSupervisorDate", auth.supervisor);
                            //Send Email To Requisitioner
                            PRUtils.SupervisorDisapprove(wowidb,auth);//Not Yet
                            SetValue("btnSupervisorApprove", "btnSupervisorDisapprove", (byte)PRStatus.Init);
                            break;
                        case "btnVPApprove":
                            if (emp.pr_authorize_amt >= obj.shipping_cost)
                            {
                                auth.status = (byte)PRStatus.Done;
                                auth.modify_date = DateTime.Now;
                            }
                            else
                            {
                                auth.status = (byte)PRStatus.VicePresident;
                            }
                            auth.vp_date = DateTime.Now;
                            (FormView1.FindControl("lblVPDate") as Label).Text = String.Format("{0:yyyy/MM/dd}", DateTime.Now);
                            auth.vp_approval = "y";
                            if (!String.IsNullOrEmpty(remark.Trim()))
                            {
                                auth.remark += remark + " by " + auth.vp + " \n";
                            }
                            if (!String.IsNullOrEmpty(inst.Trim()))
                            {
                                auth.instruction += inst + " by " + auth.vp + " \n";
                            }
                            wowidb.SaveChanges();
                            //Send Email To
                            if (auth.status == (byte)PRStatus.VicePresident)
                            {
                                PRUtils.WaitingForPresidentApprove(wowidb,auth);//Not Yet
                            }
                            else
                            {
                                PRUtils.PRStatusDone(wowidb, auth);
                            }
                            SetValue("btnVPApprove", "btnVPDisapprove", (byte)auth.status);
                            break;
                        case "btnVPDisapprove":
                            disapprove(obj, auth, "lblVPDate", auth.vp);
                            //Send Email To Requisitioner
                            PRUtils.VPDisapprove(wowidb,auth);//Not Yet
                            SetValue("btnVPApprove", "btnVPDisapprove", (byte)PRStatus.Init);
                            break;
                        case "btnPresidentApprove":
                            auth.status = (byte)PRStatus.Done;
                            auth.modify_date = DateTime.Now;
                            auth.president_date = DateTime.Now;
                            (FormView1.FindControl("lblPresidentDate") as Label).Text = String.Format("{0:yyyy/MM/dd}", DateTime.Now);
                            auth.president_approval = "y";
                            if (!String.IsNullOrEmpty(remark.Trim()))
                            {
                                auth.remark += remark + " by " + auth.president + " \n";
                            }
                            if (!String.IsNullOrEmpty(inst.Trim()))
                            {
                                auth.instruction += inst + " by " + auth.president + " \n";
                            }
                            wowidb.SaveChanges();
                            PRUtils.PRStatusDone(wowidb,auth);
                            SetValue("btnPresidentApprove", "btnPresidentApprove", (byte)PRStatus.Done);
                            break;
                        case "btnPresidentDisapprove":
                            disapprove(obj, auth, "lblPresidentDate", auth.president);
                            //Send Email To Requisitioner
                            PRUtils.PresidentDisapprove(wowidb,auth);//Not Yet
                            break;
                        case "btnPay":
                            Response.Redirect("~/Accounting/PRPayment.aspx?id=" + obj.pr_id);
                            break;
                    }
                    Response.Redirect("~/Accounting/PRDetails.aspx?id=" + id, false);
                }
                catch (Exception ex)
                {

                }
            }
            catch (Exception)
            {

                //throw;
            }
        }
    }

    private void SetValue(String label1, String label2, byte status)
    {
        try
        {
            (FormView1.FindControl(label1) as Button).Enabled = false;
            (FormView1.FindControl(label2) as Button).Enabled = false;
            String s = "Done";
            if( status == (byte)PRStatus.Init){
                s = "Init";
            } else if ( status == (byte)PRStatus.Requisitioner){
                s = "Requisitioner";
            }else if ( status == (byte)PRStatus.Supervisor){
                s = "Supervisor";
            }
            else if ( status == (byte)PRStatus.VicePresident){
                s = "VicePresident";
            }
            else if (status == (byte)PRStatus.Done)
            {
                s = "PR Approved";
            }
            (FormView1.FindControl("lblStatus") as Label).Text = s;
        }
        catch (Exception)
        {
            
            //throw;
        }
        
    }
    
    public void disapprove(WoWiModel.PR obj,WoWiModel.PR_authority_history auth, String labelId,String owner)
    {
        (FormView1.FindControl(labelId) as Label).Text = String.Format("{0:yyyy/MM/dd}", DateTime.Now);
        String remark = (FormView1.FindControl("tbInternalMarks") as TextBox).Text;
        String inst = (FormView1.FindControl("tbInstruction") as TextBox).Text;
        if (!String.IsNullOrEmpty(remark.Trim()))
        {
            auth.remark += remark + " by " + owner + " \n";
        }
        if (!String.IsNullOrEmpty(inst.Trim()))
        {
            auth.instruction += inst + " by " + owner + " \n";
        }
        auth.status = (byte)PRStatus.History;//Become History
        (FormView1.FindControl("lblStatus") as Label).Text = PRStatus.History.ToString();
        wowidb.SaveChanges();
        //New Auth
        WoWiModel.PR_authority_history newauth = new WoWiModel.PR_authority_history();
        newauth.pr_id = obj.pr_id;
        newauth.requisitioner_id = auth.requisitioner_id;
        newauth.requisitioner = auth.requisitioner;
        newauth.supervisor_id = auth.supervisor_id;
        newauth.supervisor = auth.supervisor;
        newauth.vp_id = auth.vp_id;
        newauth.vp = auth.vp;
        newauth.president_id = auth.president_id;
        newauth.president = auth.president;
        newauth.create_date = DateTime.Now;
        newauth.create_user = auth.requisitioner;
        newauth.status = (byte)PRStatus.Init;
        wowidb.PR_authority_history.AddObject(newauth);
        wowidb.SaveChanges();
        WoWiModel.PR pr = wowidb.PRs.Where(n => n.pr_id == obj.pr_id).First();
        pr.pr_auth_id = newauth.pr_auth_id;
        wowidb.SaveChanges();
        //Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
    }
    protected void lbl_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        PRUtils.PRInfoLabel_Load(sender, e);
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        GridView GridView1 = sender as GridView;
        foreach (GridViewRow row in GridView1.Rows)
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
    bool en = true;
    protected void Load()
    {

        (FormView1.FindControl("Button1") as Button).Enabled = en;
        (FormView1.FindControl("btnShow") as Button).Enabled = en;
        (FormView1.FindControl("btnAddItem") as Button).Enabled = en;
        (FormView1.FindControl("tbInternalMarks") as TextBox).Enabled = en;
        (FormView1.FindControl("tbInstruction") as TextBox).Enabled = en;
        try
        {
            ((FormView1.FindControl("PlaceHolder1") as PlaceHolder).FindControl("FileGV") as usercontrols_datechooser2_ascx).isEnabled(true);
        }
        catch (Exception)
        {
            
            //throw;
        }
       
        (FormView1.FindControl("ddlTarget") as DropDownList).Enabled = en;
        (FormView1.FindControl("tbVenderQuoNo") as TextBox).Enabled = en;
        (FormView1.FindControl("tbVenderInvoNo") as TextBox).Enabled = en;
        (FormView1.FindControl("tbCurrency") as TextBox).Enabled = en;
        (FormView1.FindControl("tbTotalAmount") as TextBox).Enabled = en;
        (FormView1.FindControl("ddlVenderList") as DropDownList).Enabled = en;
        try
        {
            (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser2_ascx).isEnabled(true);
        }
        catch (Exception)
        {
            
            //throw;
        }
        
        try
        {
            (FormView1.FindControl("ddlContact") as DropDownList).Enabled = en;
        }
        catch (Exception)
        {

            //throw;
        }
        try
        {
            (FormView1.FindControl("ddlBankAccount") as DropDownList).Enabled = en;
        }
        catch (Exception)
        {

            //throw;
        }


    }
    protected void ddlTarget_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void AddItem_Click(object sender, EventArgs e)
    {
        DropDownList ddlTarget = (FormView1.FindControl("ddlTarget") as DropDownList);
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {

            int id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            if (!String.IsNullOrEmpty(ddlTarget.SelectedValue))
            {
                int tid = int.Parse(ddlTarget.SelectedValue);
                if (tid == -1) return;
                try
                {
                    String currency = (from h in db.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select h.Currency).First();
                    var data = from t in db.Target_Rates from q in db.Quotation_Version from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.Target_rate_id && q.Quotation_Version_Id == obj.quotaion_id select new { QuotataionNo = q.Quotation_No, QuotataionID = q.Quotation_Version_Id, TargetName = t.authority_name, Quotation_Target_Id = qt.Quotation_Target_Id, ItemDescription = qt.target_description, ModelNo = t.authority_name, Currency = currency, Qty = qt.unit };
                    GridView gv = (FormView1.FindControl("GridView4") as GridView);
                    gv.DataSource = data;
                    gv.DataBind();
                    var d = data.First();
                    //obj.total_cost = d.FinalPrice;
                    //obj.currency = currency;
                    //(FormView1.FindControl("tbCurrency") as TextBox).Text = obj.currency;
                    //(FormView1.FindControl("tbTotalAmount") as TextBox).Text = obj.total_cost.ToString();
                    try
                    {
                        var delList = from del in wowidb.PR_item where del.pr_id == obj.pr_id select del;
                        foreach (var deli in delList)
                        {
                            wowidb.PR_item.DeleteObject(deli);
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                    WoWiModel.PR_item item = new WoWiModel.PR_item() { pr_id = id, model_no = d.ModelNo, item_desc = d.ItemDescription, quantity = (int)d.Qty, quotation_id = (int)d.QuotataionID, quotation_target_id = (int)d.Quotation_Target_Id };
                    wowidb.PR_item.AddObject(item);
                    wowidb.SaveChanges();
                    //Response.Redirect("~/Accounting/UpdatePR.aspx?id=" + obj.pr_id,false);
                }
                catch (Exception ex)
                {
                    //throw ex;//Show Message In Javascript
                }

            }
        }
    }
    protected void ddlDeptList_Load(object sender, EventArgs e)
    {

    }

    protected void ddlDeptList_SelectedIndexChanged(object sender, EventArgs ea)
    {

    }


    protected void ddlEmployeeList_SelectedIndexChanged(object sender, EventArgs e)
    {


    }

    protected void ddlEmployeeList_Load(object sender, EventArgs ea)
    {

        if (Page.IsPostBack) return;
        var list = EmployeeUtils.GetEmployeeList(wowidb);
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "name";
        (sender as DropDownList).DataValueField = "id";
        //(sender as DropDownList).DataBind();

    }

    protected void btnAddItem_Load(object sender, EventArgs e)
    {
        (sender as Button).Enabled = false;
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //lbljs.Text = "<script type=\"text/javascript\">openAttachWin()</"+"script"+">";
    }

    protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

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
        
        .style12
        {
            color: #000000;
        }
        
    </style>
    <script type="text/javascript">
        function openAttachWin() {
            window.open('<%= "MultiFileUpload.aspx?id=" + Request.QueryString["id"] %>', 'new', 'scrollbars=no,menubar=no,height=300,width=700,resizable=no,toolbar=no,location=no,status=no,menubar=no');
        }

        function postBack() {
            __doPostBack('FormView1', '');
            //window.location.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
 
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="pr_id"  
           SkinID="FormView"  DataSourceID="EntityDataSource1" DefaultMode="Edit" 
            Width="100%" >
           
            <EditItemTemplate>
       <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional"><ContentTemplate>--%>
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
                          
                              <tr><td align="right" 
                                   class="style11" colspan="4"><%--Access Level : <asp:Label ID="lblDept" runat="server" Text="" 
                                         onload="lbl_Load" />&nbsp;&nbsp;&nbsp;&nbsp;Created by : 
                                     <asp:Label ID="lblEmp" runat="server" Text="" 
                                         onload="lbl_Load" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;--%>Create Date : 
                                     <asp:Label ID="lblCDate" runat="server" Text="" 
                                         onload="lbl_Load"></asp:Label>
                            </td></tr>
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                PR&nbsp; Information</th>
                        </tr>
                                            <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                            <netdb:DropDownList2 ID="ddlDeptList" runat="server" AppendDataBoundItems="true"
                                                DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="id"  ValidationGroup="VenderGroup" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </netdb:DropDownList2>

                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                ControlToValidate="ddlDeptList" ErrorMessage="Please select access level." 
                                                Font-Bold="True" ForeColor="Red" InitialValue="-1" 
                                                ValidationGroup="VenderGroup">*</asp:RequiredFieldValidator>

                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                           
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                         <netdb:DropDownList2 ID="ddlEmployeeList" runat="server" AppendDataBoundItems="true"
                                                SelectedValue='<%# Bind("employee_id") %>'  DataSourceID="SqlDataSource7" DataTextField="name" DataValueField="id"  >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </netdb:DropDownList2>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="ddlEmployeeList" 
                                                ErrorMessage="Please select created by which user." Font-Bold="True" 
                                                ForeColor="Red" InitialValue="-1" ValidationGroup="VenderGroup">*</asp:RequiredFieldValidator>
                                                   <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], ([fname]+[lname] )as name FROM [employee] WHERE [status] = 'Active'"></asp:SqlDataSource>
                                        </td></tr>
                        <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp; <span class="style12">Project No.:&nbsp;</span>&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:Label ID="lblProjectNo" runat="server" Text="Label" 
                                         onload="lblProjectNo_Load" Font-Bold="True" ></asp:Label>
                            </td><th align="left" 
                                   class="style11">&nbsp; Quotation No.:&nbsp;</th><td class="style12" width="30%">
                                     <asp:Label ID="lblQuotationNo" runat="server" Text="Label" 
                                         onload="lblQuotationNo_Load" ></asp:Label>
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp; Vender Quotation No.:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                   <asp:TextBox ID="tbVenderQuoNo" runat="server" Text='<%# Bind("vendor_quotation_no")%>'
                                         ></asp:TextBox>
                            </td><th align="left" 
                                   class="style11">&nbsp; Vender Invoice No.:&nbsp;</th><td class="style12" width="30%">
                                     <asp:TextBox ID="tbVenderInvoNo" runat="server" Text='<%# Bind("vendor_invoice_no")%>'
                                         ></asp:TextBox>
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; <span class="style12">Payment Term:&nbsp;</span>&nbsp;</th><td 
                                   class="style12" colspan="3">
                                       <netdb:DropDownList2 ID="ddlPaymentTerm" runat="server" 
                                                   SelectedValue='<%# Bind("payment_term") %>' Font-Bold="True" >
                                                   <asp:ListItem Value="0">Prepayment 1</asp:ListItem>
                                                   <asp:ListItem Value="1">Prepayment 2</asp:ListItem>
                                                   <asp:ListItem Value="2">Prepayment 3</asp:ListItem>
                                                   <asp:ListItem Value="3">Final Payment</asp:ListItem>
                                               </netdb:DropDownList2>
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Attachments:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                       <asp:Button ID="Button1" runat="server" Text="Attach Files" Enabled="true" OnClientClick="openAttachWin()"/>
                                     <%--  <asp:Button ID="Button2" runat="server" Text="Reload" />--%>
                                       <br>
                                       <asp:PlaceHolder ID="PlaceHolder1" runat="server" OnLoad="PlaceHolder1_Load"></asp:PlaceHolder>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;<span class="style12">&nbsp; Target:&nbsp;</span>&nbsp;</th><td 
                                   class="style12" colspan="3">
                               <netdb:DropDownList2 ID="ddlTarget" runat="server" 
                                      OnLoad="ddlTarget_Load" AppendDataBoundItems="true"                
                                        ValidationGroup="VenderGroupT" Font-Bold="True">
                                     <asp:ListItem Value="-1">- Select -</asp:ListItem>
                               </netdb:DropDownList2>&nbsp;<asp:Button ID="btnAddItem" runat="server" Text="Add" 
                                        onclick="AddItem_Click" CausesValidation="False"  Visible="false"
                                        ValidationGroup="VenderGroupT" onload="btnAddItem_Load" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ControlToValidate="ddlTarget" ErrorMessage="Please select vender!" 
                                        ForeColor="Red" InitialValue="-1" ValidationGroup="VenderGroupT">*</asp:RequiredFieldValidator>
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                        ShowMessageBox="True" ShowSummary="False" ValidationGroup="VenderGroupT" /></td></tr>
                            <tr><td colspan="4">
                                
                            <asp:GridView ID="GridView4" runat="server" Width="100%" AutoGenerateColumns="False">
                                  <Columns>
      <asp:BoundField DataField="QuotataionNo" HeaderText="Quotation No" 
                SortExpression="QuotataionNo" />
            <asp:BoundField DataField="TargetName" HeaderText="Target Name" 
                SortExpression="TargetName" />
                <asp:BoundField DataField="ItemDescription" HeaderText="Item Description" 
                SortExpression="ItemDescription" />
                 <%-- <asp:BoundField DataField="ModelNo" HeaderText="Mode lNo" 
                SortExpression="ModelNo" />
                  <asp:BoundField DataField="Currency" HeaderText="Currency" 
                SortExpression="Currency" />--%>
                  <asp:BoundField DataField="Qty" HeaderText="Qty" 
                SortExpression="Qty" />
        </Columns>
       
                                </asp:GridView>
                                
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp;<span class="Currency">Original Currency:&nbsp;</span>&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:TextBox ID="tbCurrency" runat="server" Text='<%# Bind("currency")%>' ForeColor="Blue" 
                                         ></asp:TextBox>
                            </td><th align="left" 
                                   class="style11">&nbsp; <span class="Currency">Total:</span>&nbsp;</th><td class="style12" width="30%">
                                    <asp:TextBox ID="tbTotalAmount" runat="server"  Text='<%# Bind("total_cost")%>' ForeColor="Blue" 
                                         ></asp:TextBox>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp;<span class="Currency">Authorization 
                                Currency:&nbsp;</span>&nbsp;</th><td 
                                   class="style12" width="30%">
                                    <span class="Currency">USD</span>
                            </td><th align="left" 
                                   class="style11"><font color="red">*&#160;</font><span class="Currency">Authorization 
                                    Total:</span>&nbsp;</th><td class="style12" width="30%">
                                    <asp:TextBox ID="TextBox4" runat="server"  Text='<%# Bind("shipping_cost")%>' ForeColor="Blue"
                                         ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                        ControlToValidate="TextBox4" 
                                        ErrorMessage="Please provide USD Authoriaztion Total" Font-Bold="True" 
                                        ForeColor="Red" ValidationGroup="VenderGroup">*</asp:RequiredFieldValidator>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Vender:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                <netdb:DropDownList2 ID="ddlVenderList" runat="server" 
                                    AppendDataBoundItems="True" AutoPostBack="True" onload="ddlVenderList_Load" 
                                        onselectedindexchanged="ddlVenderList_SelectedIndexChanged"
                                        ValidationGroup="VenderGroup">
                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                </netdb:DropDownList2>&nbsp;<asp:Button ID="btnShow" runat="server" Text="Show" 
                                        Visible="false" onclick="btnShow_Click" ValidationGroup="VenderGroup" CausesValidation="false"  />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="ddlVenderList" ErrorMessage="Please select vender!" 
                                        ForeColor="Red" InitialValue="-1" ValidationGroup="VenderGroup">*</asp:RequiredFieldValidator>
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                        ShowMessageBox="True" ShowSummary="False" ValidationGroup="VenderGroup" />
                            </td></tr>
                             
                   <asp:Panel ID="VenderPanel" runat="server" Visible="true">

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
                              <netdb:DropDownList2 ID="ddlCountry" runat="server"  Enabled="false"
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" >
                              </netdb:DropDownList2>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]">
                              </asp:SqlDataSource>
                          </td>
                          <th align="left" 
                                   class="style7">&nbsp; 統一編號:</th><td width="30%">
                              <asp:Label ID="lbLU" 
                                       runat="server" ></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><netdb:DropDownList2 
                                       ID="ddlQualification" runat="server" Enabled="false"
                                      ><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></netdb:DropDownList2></td>
                                      <th 
                                   align="left" class="style7">&nbsp; Vender Type:&nbsp;</th><td width="30%"><netdb:DropDownList2 DataSourceID="SqlDataSource3"   DataTextField="name" DataValueField="id" Enabled="false"
                                       ID="ddlContractType" runat="server" AppendDataBoundItems="true">
                                        <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                        </netdb:DropDownList2><asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                                   ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                   SelectCommand="SELECT [id], [name] FROM [vendor_type] WHERE [publish] = 'true'" ></asp:SqlDataSource></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <netdb:DropDownList2 ID="ddlBankCharge" runat="server"  Enabled="false"
                                                   >
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                                   <asp:ListItem Value="2">BEN</asp:ListItem>
                                               </netdb:DropDownList2>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <netdb:DropDownList2 ID="ddlPaymentType" runat="server"  Enabled="false"
                                                  >
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">支票 Check</asp:ListItem>
                                                   <asp:ListItem Value="1">國內匯款 Domestic Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="6">國外匯款 Foreign Wire Transfer</asp:ListItem>
                                                   <asp:ListItem Value="2">匯票 Cashier Check</asp:ListItem>
                                                   <asp:ListItem Value="3">信用卡 Credit Card</asp:ListItem>
                                                   <asp:ListItem Value="4">現金 Cash</asp:ListItem>
                                                   <asp:ListItem Value="5">西聯匯款 Westerm Union</asp:ListItem>
                                               </netdb:DropDownList2>
                                           </td>
                                   </tr>
                                   <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td >
                                             <netdb:DropDownList2 ID="ddlPaymentDays" runat="server" Enabled="false"
                                               >
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                 <asp:ListItem Value="0">ASAP</asp:ListItem>
                                                 <asp:ListItem Value="7">  7 days</asp:ListItem>
                                                 <asp:ListItem Value="15"> 15 days</asp:ListItem>
                                                 <asp:ListItem Value="30"> 30 days</asp:ListItem>
                                                 <asp:ListItem Value="45"> 45 days</asp:ListItem>
                                                 <asp:ListItem Value="60"> 60 days</asp:ListItem>
                                                 <asp:ListItem Value="90"> 90 days</asp:ListItem>
                                                 <asp:ListItem Value="120">120 days</asp:ListItem>
                                             </netdb:DropDownList2>
                                           </td>
                                           <th 
                                   align="left" class="style11"><font color="red">*&nbsp;</font>Target Payment Day:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                  <uc1:DateChooser2 ID="dcPaymentDate" runat="server" />
                            </td>
                                   </tr>
                                   <tr><td
                                   align="left" class="style2" colspan="4">
                                  
                                   <table  border="0" cellpadding="2" cellspacing="0"  style="width:100%">
                                   <tr>
                                   <td width="40%" align="right">1st Prepayment : </td>
                                   <td width="10%" > </td>
                                   <td width="50%" > 
                                       <netdb:DropDownList2 ID="ddlPaymentTerm1" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                      >
                                       </netdb:DropDownList2> % 
                                       <asp:CheckBox ID="CheckBox1" runat="server" Visible="false" /></td>
                                       
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right">2nd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <netdb:DropDownList2 ID="ddlPaymentTerm2" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                           >
                                       </netdb:DropDownList2> % 
                                       <asp:CheckBox ID="CheckBox2" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   <td width="40%" align="right" >3rd Prepayment : </td>
                                   <td width="10%" > </td>

                                   <td width="50%" >
                                   <netdb:DropDownList2 ID="ddlPaymentTerm3" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                         >
                                       </netdb:DropDownList2> % 
                                       <asp:CheckBox ID="CheckBox3" runat="server" Visible="false" /></td>
                                   </tr>
                                   <tr>
                                   
                                   <td width="40%" align="right" >Final Prepayment : </td><td width="10%" > </td>
                                   <td width="50%" >
                                   <netdb:DropDownList2 ID="ddlPaymentTermF" runat="server" onload="DropDownList1_Load"  Enabled="false"
                                          >
                                       </netdb:DropDownList2> % 
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
                                 <asp:Label runat="server" ID="lblC" Text="Contact :"></asp:Label><netdb:DropDownList2 AutoPostBack="True"
                                     ID="ddlContact" runat="server" onselectedindexchanged="ddlContact_SelectedIndexChanged" >

                                 </netdb:DropDownList2>
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
                                    <netdb:DropDownList2 AutoPostBack="True" 
                                     ID="ddlBankAccount" runat="server" onselectedindexchanged="ddlBankAccount_SelectedIndexChanged">
                                 </netdb:DropDownList2>
              </td></tr>
               <tr><td align="left" colspan="4">
               <asp:Label runat="server" ID="lblB" Text="Banking Information :" Visible="false"></asp:Label>
                                     <asp:GridView ID="GridView2" runat="server" Width="100%" AutoGenerateColumns="False"  Visible="false" onprerender="GridView1_PreRender">
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
                            <tr>
                          <td align="right">
                                     Internal Remarks:</td><td>
                          <td align="right">
                                 External Instruction:</td><td>
                                 </td>
                                 
                          </tr>
                            <tr align="center">
                          <td align="right">History:</td><td>
                                     <asp:TextBox ID="tbInternalMarksHis" runat="server" TextMode="MultiLine" 
                                         Width="510px" Height="100px" ReadOnly="true" OnLoad="AuthLabel_Load"></asp:TextBox><br/>
                                     
                                 </td>
                         <td align="right">History:</td><td>
                                     <asp:TextBox ID="tbInstructionHis" runat="server" TextMode="MultiLine" Width="510" ReadOnly="true"
                                         Height="100px" OnLoad="AuthLabel_Load" ></asp:TextBox><br/>
                                     
                                 </td>
                                 
                          </tr>
                          </tr>
                            <tr align="center">
                          <td ></td><td>
                                    <asp:TextBox ID="tbInternalMarks" runat="server" Height="50px" 
                                         TextMode="MultiLine" Width="510px" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>
                          <td ></td><td>
                                     <asp:TextBox ID="tbInstruction" runat="server" Height="50px" 
                                         TextMode="MultiLine" Width="510" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>
                                 
                          </tr>
                          <tr >
                                 <td>
                                    Requisitioner
                                 </td>
                                 <td>
                                     <asp:Button ID="btnSendReq" runat="server" Text="SendRequest"
                                         onclick="btnSendReq_Click" onload="btn_Load" />
                                 </td>
                                 <td>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblRequisitioner" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblRequisitionerDate" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <%--<td rowspan="3">
                                     Internal Remarks:<br/>
                                     <asp:TextBox ID="tbInternalMarksHis" runat="server" TextMode="MultiLine" 
                                         Width="200px" Height="55px" ReadOnly="true" OnLoad="AuthLabel_Load"></asp:TextBox><br/>
                                     <asp:TextBox ID="tbInternalMarks" runat="server" Height="36px" 
                                         TextMode="MultiLine" Width="200px" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>--%>
                          </tr>
                           <tr >
                                 <td>
                                    Supervisor
                                 </td>
                                 <td>
                                     <asp:Button ID="btnSupervisorApprove" runat="server" Text="Approve"  onload="btn_Load" onclick="btn_Click"/>
                                 </td>
                                 <td>
                                    <asp:Button ID="btnSupervisorDisapprove" runat="server" Text="Disapprove"  onload="btn_Load" onclick="btn_Click"/>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblSupervisor" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblSupervisorDate" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                          </tr>
                           <tr >
                                 <td>
                                    VP
                                 </td>
                                 <td>
                                     <asp:Button ID="btnVPApprove" runat="server" Text="Approve"  onload="btn_Load" onclick="btn_Click"/>
                                 </td>
                                 <td>
                                    <asp:Button ID="btnVPDisapprove" runat="server" Text="Disapprove"  onload="btn_Load"  onclick="btn_Click"/>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblVP" runat="server" Text=""  OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblVPDate" runat="server" Text=""  OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                          </tr>
                          <tr >
                                 <td>
                                    President
                                 </td>
                                 <td>
                                     <asp:Button ID="btnPresidentApprove" runat="server" Text="Approve"  onload="btn_Load" onclick="btn_Click"/>
                                 </td>
                                 <td>
                                    <asp:Button ID="btnPresidentDisapprove" runat="server" Text="Disapprove"  onload="btn_Load" onclick="btn_Click"/>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblPresident" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblPresidentDate" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <%--<td rowspan="3">
                                 External Instruction:<br/>
                                     <asp:TextBox ID="tbInstructionHis" runat="server" TextMode="MultiLine" Width="200" ReadOnly="true"
                                         Height="55px" OnLoad="AuthLabel_Load" ></asp:TextBox><br/>
                                     <asp:TextBox ID="tbInstruction" runat="server" Height="36px" 
                                         TextMode="MultiLine" Width="200" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>--%>
                          </tr>
                        <%--  <tr >
                                 <td>
                                    Finance Dept:
                                 </td>
                                 <td>
                                     
                                 </td>
                                 <td>
                                     <asp:Button ID="btnPay" runat="server" Text="Payment"  onload="btn_Load" onclick="btn_Click" enabled="false"/>
                                 </td>
                                 <td>
                                     <asp:Label ID="lblFinance" runat="server" Text=""  OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                                 <td>
                                    Date : <asp:Label ID="lblFinanceDate" runat="server" Text="" OnLoad="AuthLabel_Load"></asp:Label>
                                 </td>
                          </tr>--%>
                          <tr >
                                 <td>
                                    Cancel:
                                 </td>
                                 <td>
                                     <asp:Button ID="btnCancel" runat="server" Text="Withdraw" onload="btn_Load"
                                         onclick="btnCancel_Click" />
                                 </td>
                                 <td>
                                    
                                 </td>
                                 <td>
                                    
                                     Status</td>
                                  <td>
                                   <asp:Label ID="lblStatus" runat="server" OnLoad="AuthLabel_Load" Font-Bold="True" ForeColor="Black"></asp:Label>
                                 </td>
                          </tr>
                         
                      </table>

                            </td></tr>

                                <tr align="center"><td class="style4" colspan="4">
                      <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                          <tr align="center">
                              <td>
                                  <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                                            CommandName="Update" Text="Finish" ValidationGroup="VenderGroup" />
                                        &nbsp;
                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                                            CommandName="Cancel" Text="Cancel" />
                                        &nbsp;</td>
                          </tr>
                      </table>
                      </td></tr>
                             </table>
                           <%--  </ContentTemplate>
                             <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="UpdateButton" />
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
    <asp:Label ID="lbljs" runat="server" Text=""></asp:Label>
  
                           
</asp:Content>

