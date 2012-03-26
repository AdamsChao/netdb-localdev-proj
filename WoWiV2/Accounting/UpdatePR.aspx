<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>
<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>
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
        var list = (from c in wowidb.vendors from country in wowidb.countries where c.country == country.country_id select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name + " - [ " + country.country_name+" ]" : c.name + " - [ " + country.country_name+" ]" });

        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
            try
            {
                (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser_ascx).setText(((DateTime)obj.target_payment_date).ToString("yyyy/MM/dd"));
            
            }
            catch (Exception)
            {
                
                //throw;
            }
            if (obj.vendor_id != null && obj.vendor_id != -1)
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
                (FormView1.FindControl("VenderPanel") as Panel).Visible = false;
            }
            else
            {
                (FormView1.FindControl("VenderPanel") as Panel).Visible = false;
            }
        }
        
    }

    protected void ddlTarget_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        if (!String.IsNullOrEmpty(Request.QueryString["type"]) && Request.QueryString["type"] == "payment")
        {
            (sender as DropDownList).Enabled = false;
        }
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
            var data = from t in db.Target from qt in db.Quotation_Target from q in list from c in db.country where qt.quotation_id == q.Id & qt.target_id == t.target_id & t.country_id == c.country_id select new { Text = t.target_code + "(" + q.No + ") - [" + c.country_name + "]", Id = qt.Quotation_Target_Id, Version = q.Version };
            (sender as DropDownList).DataSource = data;
            (sender as DropDownList).DataTextField = "Text";
            (sender as DropDownList).DataValueField = "Id";
            (sender as DropDownList).DataBind();
            try
            {
                WoWiModel.PR_item item = (from i in wowidb.PR_item where i.pr_id == id select i).First();
                int tid = (item.quotation_target_id);
                (sender as DropDownList).SelectedValue = tid.ToString();
                try
                {
                    String currency = (from h in db.Quotation_Version where h.Quotation_Version_Id == obj.quotaion_id select h.Currency).First();
                    //var idata = from t in db.Target from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.target_id select new { QuotataionID = qt.quotation_id, Quotation_Target_Id = qt.Quotation_Target_Id, ItemDescription = t.target_description, ModelNo = t.target_code, Currency = currency, Price = qt.unit_price, Qty = qt.unit, FinalPrice = qt.FinalPrice };
                    var idata = from t in db.Target from q in db.Quotation_Version from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.target_id && q.Quotation_Version_Id == obj.quotaion_id select new { QuotataionNo = q.Quotation_No, QuotataionID = q.Quotation_Version_Id, TargetName = t.target_code, Quotation_Target_Id = qt.Quotation_Target_Id, ItemDescription = t.target_description, ModelNo = t.target_code, Currency = currency, Qty = qt.unit };
                    GridView gv = (FormView1.FindControl("GridView4") as GridView);
                    gv.DataSource = idata;
                    gv.DataBind();

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
        Panel VenderPanel = FormView1.FindControl("VenderPanel") as Panel;
        if (vid == -1)
        {
            VenderPanel.Visible = false;
            (FormView1.FindControl("btnShow") as Button).Visible = false;
            return;
        }
        else
        {
            VenderPanel.Visible = true;
            (FormView1.FindControl("btnShow") as Button).Visible = true;
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
                (FormView1.FindControl("ddlPaymentTerm1") as DropDownList).SelectedValue = data.payment_term1.ToString();
                (FormView1.FindControl("ddlPaymentTerm2") as DropDownList).SelectedValue = data.payment_term2.ToString();
                (FormView1.FindControl("ddlPaymentTerm3") as DropDownList).SelectedValue = data.payment_term3.ToString();
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
    protected void initContact(int id)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["type"]) && Request.QueryString["type"] == "payment")
        {
            (FormView1.FindControl("ddlContact") as DropDownList).Enabled = false;
        }
        DropDownList ddl = (FormView1.FindControl("ddlContact") as DropDownList);
        Label lbl = FormView1.FindControl("lblC") as Label;
        GridView gv = (FormView1.FindControl("GridView1") as GridView);
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
                ddl.DataSource = data;
                ddl.DataTextField = "text";
                ddl.DataValueField = "id";
                ddl.DataBind();
                ddl.Visible = true;
                int i = data.First().id;
                gv.DataSource = from v in wowidb.contact_info where v.id == i select v;
                gv.DataBind();
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

    protected void initBankingAccount(int id)
    {
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
        DropDownList list = (DropDownList)sender;
        int[] data = { 0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
        list.DataSource = data;//Enumerable.Range(0, 101);
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
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            id = int.Parse(Request.QueryString["id"]);
            try
            {
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                WoWiModel.PR_authority_history auth = wowidb.PR_authority_history.First(c => c.pr_auth_id == obj.pr_auth_id);
                if (auth.status == (byte)PRStatus.Done)
                {
                    Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
                }
                (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser_ascx).isEnabled(false);
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
        (FormView1.FindControl("PlaceHolder1") as PlaceHolder).Controls.Clear();
        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        if (System.IO.Directory.Exists(UpPath))
        {
            try
            {
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
            usercontrols_datechooser_ascx con = (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser_ascx);
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

    protected void AuthLabel_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
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
                            lbl.Text = "Ready to Pay";
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
            db.SaveChanges();
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
            PRUtils.WaitingForSupervisorApprove(auth);//Not Yet
            (sender as Button).Enabled = false;
            Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
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
        if (Page.IsPostBack) return;
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
                    switch (btnID)
                    {
                        case "btnSupervisorApprove":
                            if (emp.pr_authorize_amt >= obj.total_cost)
                            {
                                auth.status = (byte)PRStatus.Done;

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
                                PRUtils.WaitingForVPApprove(auth);//Not Yet
                            }
                            else
                            {
                                PRUtils.PRStatusDone(auth);
                            }
                            SetValue("btnSupervisorApprove", "btnSupervisorDisapprove", (byte)auth.status);
                            break;
                        case "btnSupervisorDisapprove":
                            disapprove(obj, auth, "lblSupervisorDate", auth.supervisor);
                            //Send Email To Requisitioner
                            PRUtils.SupervisorDisapprove(auth);//Not Yet
                            SetValue("btnSupervisorApprove", "btnSupervisorDisapprove", (byte)PRStatus.Init);
                            break;
                        case "btnVPApprove":
                            if (emp.pr_authorize_amt >= obj.total_cost)
                            {
                                auth.status = (byte)PRStatus.Done;
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
                                PRUtils.WaitingForPresidentApprove(auth);//Not Yet
                            }
                            else
                            {
                                PRUtils.PRStatusDone(auth);
                            }
                            SetValue("btnVPApprove", "btnVPDisapprove", (byte)auth.status);
                            break;
                        case "btnVPDisapprove":
                            disapprove(obj, auth, "lblVPDate", auth.vp);
                            //Send Email To Requisitioner
                            PRUtils.VPDisapprove(auth);//Not Yet
                            SetValue("btnVPApprove", "btnVPDisapprove", (byte)PRStatus.Init);
                            break;
                        case "btnPresidentApprove":
                            auth.status = (byte)PRStatus.Done;
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
                            PRUtils.PRStatusDone(auth);
                            SetValue("btnPresidentApprove", "btnPresidentApprove", (byte)PRStatus.Done);
                            break;
                        case "btnPresidentDisapprove":
                            disapprove(obj, auth, "lblPresidentDate", auth.president);
                            //Send Email To Requisitioner
                            PRUtils.PresidentDisapprove(auth);//Not Yet
                            break;
                        case "btnPay":
                            Response.Redirect("~/Accounting/PRPayment.aspx?id=" + obj.pr_id);
                            break;
                    }
                    //(FormView1.FindControl("tbInternalMarks") as TextBox).Enabled = false;
                    //(FormView1.FindControl("tbInstruction") as TextBox).Enabled = false;
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
                s = "Ready to Pay";
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
        Response.Redirect("~/Accounting/PRDetails.aspx?id=" + obj.pr_id);
    }
    protected void lbl_Load(object sender, EventArgs e)
    {
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
            ((FormView1.FindControl("PlaceHolder1") as PlaceHolder).FindControl("FileGV") as usercontrols_datechooser_ascx).isEnabled(true);
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
            (FormView1.FindControl("dcPaymentDate") as usercontrols_datechooser_ascx).isEnabled(true);
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
                    var data = from t in db.Target from q in db.Quotation_Version from qt in db.Quotation_Target where qt.Quotation_Target_Id == tid & qt.target_id == t.target_id && q.Quotation_Version_Id == obj.quotaion_id select new { QuotataionNo = q.Quotation_No, QuotataionID = q.Quotation_Version_Id, TargetName = t.target_code, Quotation_Target_Id = qt.Quotation_Target_Id, ItemDescription = t.target_description, ModelNo = t.target_code, Currency = currency, Qty = qt.unit };
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
                }
                catch (Exception ex)
                {
                    throw ex;//Show Message In Javascript
                }

            }
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
           SkinID="FormView"  DataSourceID="EntityDataSource1" DefaultMode="Edit" Width="100%"  >
           
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
                          
                              <tr><td align="right" 
                                   class="style11" colspan="4">Department : <asp:Label ID="lblDept" runat="server" Text="" 
                                         onload="lbl_Load" />&nbsp;&nbsp;&nbsp;&nbsp;Employee : 
                                     <asp:Label ID="lblEmp" runat="server" Text="" 
                                         onload="lbl_Load" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;Create Date : 
                                     <asp:Label ID="lblCDate" runat="server" Text="" 
                                         onload="lbl_Load"></asp:Label>
                            </td></tr>
                          <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                PR&nbsp; Information</th>
                        </tr>
                        <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp; Project No.:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:Label ID="lblProjectNo" runat="server" Text="Label" 
                                         onload="lblProjectNo_Load" ></asp:Label>
                            </td><th align="left" 
                                   class="style11">&nbsp; Qutation No.:&nbsp;</th><td class="style12" width="30%">
                                     <asp:Label ID="lblQuotationNo" runat="server" Text="Label" 
                                         onload="lblQuotationNo_Load" ></asp:Label>
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp; Vender Quotaiton No.:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                   <asp:TextBox ID="tbVenderQuoNo" runat="server" Text='<%# Bind("vendor_quotation_no")%>'
                                        Enabled="false"  ></asp:TextBox>
                            </td><th align="left" 
                                   class="style11">&nbsp; Vender Invoice No.:&nbsp;</th><td class="style12" width="30%">
                                     <asp:TextBox ID="tbVenderInvoNo" runat="server" Text='<%# Bind("vendor_invoice_no")%>'
                                         Enabled="false" ></asp:TextBox>
                            </td></tr>
                             <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Attachments:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                       <asp:Button ID="Button1" runat="server" Text="Attach Files" OnClientClick="openAttachWin()" Enabled="false" /><br>
                                       <asp:PlaceHolder ID="PlaceHolder1" runat="server" OnLoad="PlaceHolder1_Load"></asp:PlaceHolder>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Target:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                               <asp:DropDownList ID="ddlTarget" runat="server" 
                                    AutoPostBack="True"  OnLoad="ddlTarget_Load" AppendDataBoundItems="true"
                                        onselectedindexchanged="ddlTarget_SelectedIndexChanged" Enabled="false"
                                        ValidationGroup="VenderGroupT">
                                    <asp:ListItem Value="-1">Select one</asp:ListItem>
                               </asp:DropDownList>&nbsp;<asp:Button ID="btnAddItem" runat="server" Text="Add" 
                                        onclick="AddItem_Click" CausesValidation="False" Enabled="false"
                                        ValidationGroup="VenderGroupT" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ControlToValidate="ddlTarget" ErrorMessage="Please select vender!" 
                                        ForeColor="Red" InitialValue="-1" ValidationGroup="VenderGroupT">*</asp:RequiredFieldValidator>
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
                                        ShowMessageBox="True" ShowSummary="False" ValidationGroup="VenderGroupT" /></td></tr>
                            <tr><td colspan="4">
                                
                            <asp:GridView ID="GridView4" runat="server" Width="100%" AutoGenerateColumns="False">
                                  <Columns>
      <asp:BoundField DataField="QuotataionNo" HeaderText="Quotataion No" 
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
                                   align="left" class="style11">&nbsp;&nbsp;&nbsp;Original Currency:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                     <asp:TextBox ID="tbCurrency" runat="server" Text='<%# Bind("currency")%>' Enabled="False"
                                         ></asp:TextBox>
                            </td><th align="left" 
                                   class="style11">&nbsp; Total:&nbsp;</th><td class="style12" width="30%">
                                    <asp:TextBox ID="tbTotalAmount" runat="server"  Text='<%# Bind("total_cost")%>' Enabled="False"
                                         ></asp:TextBox>
                            </td></tr>
                            <tr><th 
                                   align="left" class="style11">&nbsp;&nbsp; Vender:&nbsp;&nbsp;</th><td 
                                   class="style12" colspan="3">
                                <asp:DropDownList ID="ddlVenderList" runat="server" 
                                    AppendDataBoundItems="True" AutoPostBack="True" onload="ddlVenderList_Load" 
                                        onselectedindexchanged="ddlVenderList_SelectedIndexChanged" Enabled="false"
                                        ValidationGroup="VenderGroup">
                                    <asp:ListItem Value="-1">Select one</asp:ListItem>
                                </asp:DropDownList>&nbsp;<asp:Button ID="btnShow" runat="server" Text="Show" 
                                        Visible="true" onclick="btnShow_Click" ValidationGroup="VenderGroup" CausesValidation="false" Enabled="false" />
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
                              <asp:DropDownList ID="ddlCountry" runat="server"  Enabled="false"
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" >
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country]">
                              </asp:SqlDataSource>
                          </td>
                          <th align="left" 
                                   class="style7">&nbsp; 統一編號:</th><td width="30%">
                              <asp:Label ID="lbLU" 
                                       runat="server" ></asp:Label></td></tr><tr><th 
                                   align="left" class="style9">&#160;&#160; Qualification:&#160;</th><td width="30%"><asp:DropDownList 
                                       ID="ddlQualification" runat="server" Enabled="false"
                                      ><asp:ListItem>Qualified</asp:ListItem><asp:ListItem>General</asp:ListItem></asp:DropDownList></td><th 
                                   align="left" class="style7">&nbsp; Authority / Local Agent:&nbsp;</th><td width="30%"><asp:DropDownList 
                                       ID="dlContractType" runat="server" Enabled="false">
                                       <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                       <asp:ListItem Value="0">Authroity</asp:ListItem>
                                       <asp:ListItem Value="1">Local Agent</asp:ListItem></asp:DropDownList></td></tr>
                                       <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Bank Charge:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlBankCharge" runat="server"  Enabled="false"
                                                   >
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">OUR</asp:ListItem>
                                                   <asp:ListItem Value="1">SHA</asp:ListItem>
                                                   <asp:ListItem Value="2">BEN</asp:ListItem>
                                               </asp:DropDownList>
                                           </td><th 
                                   align="left" class="style7">&nbsp; Payment Type:&nbsp;</th><td width="30%">
                                               <asp:DropDownList ID="ddlPaymentType" runat="server"  Enabled="false"
                                                  >
                                                   <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                   <asp:ListItem Value="0">支票</asp:ListItem>
                                                   <asp:ListItem Value="1">國內匯款</asp:ListItem>
                                                   <asp:ListItem Value="6">國外匯款</asp:ListItem>
                                                   <asp:ListItem Value="2">匯票</asp:ListItem>
                                                   <asp:ListItem Value="3">信用卡</asp:ListItem>
                                                   <asp:ListItem Value="4">現金</asp:ListItem>
                                                   <asp:ListItem Value="5">西聯匯款</asp:ListItem>
                                               </asp:DropDownList>
                                           </td>
                                   </tr>
                                   <tr><th 
                                   align="left" class="style9">&nbsp;&nbsp; Payment Term:&nbsp;</th>
                                   <td >
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
                                           <th 
                                   align="left" class="style11">&nbsp; Target Payment Day:&nbsp;&nbsp;</th><td 
                                   class="style12" width="30%">
                                   <uc1:DateChooser ID="dcPaymentDate" runat="server" />
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
                                     ID="ddlContact" runat="server" onselectedindexchanged="ddlContact_SelectedIndexChanged" Enabled="false">

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
                                    <asp:DropDownList AutoPostBack="True" Enabled="false"
                                     ID="ddlBankAccount" runat="server" onselectedindexchanged="ddlBankAccount_SelectedIndexChanged">
                                 </asp:DropDownList>
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
                                 <td rowspan="3">
                                     Internal Remarks:<br/>
                                     <asp:TextBox ID="tbInternalMarksHis" runat="server" TextMode="MultiLine" 
                                         Width="200px" Height="55px" Enabled="False" OnLoad="AuthLabel_Load"></asp:TextBox><br/>
                                     <asp:TextBox ID="tbInternalMarks" runat="server" Height="36px" 
                                         TextMode="MultiLine" Width="200px" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>
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
                                 <td rowspan="3">
                                 External Instruction:<br/>
                                     <asp:TextBox ID="tbInstructionHis" runat="server" TextMode="MultiLine" Width="200" Enabled="false"
                                         Height="55px" OnLoad="AuthLabel_Load" ></asp:TextBox><br/>
                                     <asp:TextBox ID="tbInstruction" runat="server" Height="36px" 
                                         TextMode="MultiLine" Width="200" OnLoad="AuthLabel_Load"></asp:TextBox>
                                 </td>
                          </tr>
                          <tr >
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
                          </tr>
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

