﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" EnableEventValidation = "false" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //System.Diagnostics.Debug.Listeners.Add(new System.Diagnostics.ConsoleTraceListener());
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumns(iGridView1);
        }   
    }

    private void SetMergedHerderColumns(iRowSpanGridView iGridView1)
    {
        iGridView1.AddMergedColumns("Status", 6, 2);
        //iGridView1.AddMergedColumns("Vender", 15, 2);
        //iGridView1.AddMergedColumns("IMA Cost", 16, 2);
        //iGridView1.AddMergedColumns("Prepayment", 20, 2);
        //iGridView1.AddMergedColumns("Payment", 25, 2);
    }
    
    
    private int i = 0;
    int count = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        //row.Cells[19].CssClass = "HighLight";
        //if (count !=0 &&i == count - 1)
        //{
        //    for (int k = 19 ; k <= 25; k++)
        //    {
        //        row.Cells[k].CssClass = "HighLight1";
        //    }
        //    row.Cells[8].CssClass = "HighLight1";
        //    row.Cells[10].CssClass = "HighLight1";
        //}
        i++;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search(null);
    }
    protected void Search(String str)
    {
        
        List<CostAnalysisData> list = new List<CostAnalysisData>();
        CostAnalysisData temp = new CostAnalysisData();
        try
        {
            //var datas = from pr in wowidb.PRs from a in wowidb.PR_authority_history where pr.pr_auth_id == a.pr_auth_id && (a.status == (byte)PRStatus.Done ) select pr;
            var projs = from pro in wowidb.Projects orderby pro.Project_Id descending  select pro;
            
            foreach (var proj in projs)
            {
                decimal projDisTotal = 0;
                temp.ProjectNo = proj.Project_No;
                temp.Status = proj.Project_Status;
                String targetDesc = "";
                if (DropDownList3.SelectedValue != "- All -")
                {
                    if (temp.Status != DropDownList3.SelectedValue)
                    {
                        continue;
                    }
                }
                if (ddlProj.SelectedValue != "-1")
                {
                    String projID = ddlProj.SelectedValue;
                    if (proj.Project_Id != int.Parse(projID))
                    {
                        continue;
                    }
                }
                try
                {
                    DateTime fromDate = dcProjFrom.GetDate();
                    if ((fromDate - proj.Create_Date).TotalDays > 0)
                    {
                        continue;
                    }
                }
                catch (Exception)
                {

                    //throw;
                }
                try
                {
                    DateTime toDate = dcProjTo.GetDate();
                    if ((toDate - proj.Create_Date).TotalDays < 0)
                    {
                        continue;
                    }
                }
                catch (Exception)
                {

                    //throw;
                }
                temp.OpenDate = proj.Create_Date.ToString("yyyy/MM/dd");


                try
                {
                    int qid = proj.Quotation_Id;
                    WoWiModel.Quotation_Version quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == qid select q).First();
                   
                    //temp.QutationNo = quo.Quotation_No + " - V" + quo.Vername;
                    temp.QutationId = qid;
                    
                    temp.Model = quo.Model_No;
                    int cid = (int)quo.Client_Id;
                    WoWiModel.clientapplicant cli = (from c in wowidb.clientapplicants where c.id == cid select c).First();
                    if (ddlClient.SelectedValue != "-1")
                    {
                        if (cid != int.Parse(ddlClient.SelectedValue))
                        {
                            continue;
                        }
                    }
                    temp.Client = String.IsNullOrEmpty(cli.c_companyname) ? cli.companyname : cli.c_companyname;

                    int sid = (int)quo.SalesId;
                    if (ddlSales.SelectedValue != "-1")
                    {
                        if (sid != int.Parse(ddlSales.SelectedValue))
                        {
                            continue;
                        }
                    }
                    WoWiModel.employee sales = (from s in wowidb.employees where s.id == sid select s).First();
                        temp.Sales = String.IsNullOrEmpty(sales.c_fname) ? sales.fname + " " + sales.lname : sales.c_lname + " " + sales.c_fname;
                    var qids = wowidb.Quotation_Version.Where(c => c.Quotation_No == proj.Quotation_No & c.Quotation_Status == 5);
                    var targets = from qt in wowidb.Quotation_Target from qid1 in qids where qt.quotation_id == qid1.Quotation_Version_Id  select qt;
                    String disIVNo = "";
                    String disIVDate = "";
                    HashSet<int> hs = new HashSet<int>();
                    bool disflag = false;
                    bool dflag = false;
                    bool dstate = false;
                    foreach (var t in targets)
                    {
                        if (ddlCountry.SelectedValue != "-1")
                        {
                            if (ddlCountry.SelectedValue != t.target_description)
                            {
                                continue;
                            }
                        }
                        CostAnalysisData temp2 = new CostAnalysisData();
                       
                        temp2.ProjectNo = temp.ProjectNo;
                        temp.Status = t.Status;
                        temp2.Status = t.Status;
                        temp2.OpenDate = temp.OpenDate;

                        if (t.certification_completed.HasValue)
                        {
                            try
                            {
                                temp.StatusDate = ((DateTime)t.certification_completed).ToString("yyyy-MM-dd");
                                temp2.StatusDate = ((DateTime)t.certification_completed).ToString("yyyy-MM-dd");
                            }
                            catch (Exception)
                            {

                                //throw;
                            }


                            try
                            {
                                DateTime fromDate = dcStatusFromDate.GetDate();
                                if ((fromDate - (DateTime)t.certification_completed).TotalDays > 0)
                                {
                                    continue;
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                            try
                            {
                                DateTime toDate = dcStatusToDate.GetDate();
                                if ((toDate - (DateTime)t.certification_completed).TotalDays < 0)
                                {
                                    continue;
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                        }
                        else
                        {
                            try
                            {
                                DateTime fromDate = dcStatusFromDate.GetDate();
                                continue;
                                
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                            try
                            {
                                DateTime toDate = dcStatusToDate.GetDate();
                                continue;
                                
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                        }
                        try
                        {
                            var d = wowidb.Quotation_Version.First(c => c.Quotation_Version_Id == (int)t.quotation_id);
                            temp2.QutationNo = d.Quotation_No + "-V"+d.Vername;
                        }
                        catch (Exception)
                        {

                        }
                        
                        temp2.QutationId = (int)t.quotation_id;
                        temp2.Model = temp.Model;
                        temp2.Client = temp.Client;
                        temp2.Sales = temp.Sales;
                        targetDesc = t.target_description;
                        temp2.Country = t.target_description;
                        //continue;
                        //Get all invoices
                        decimal tarTotal = 0;
                        bool isflag = false;
                        bool flag = false;
                        bool state = false;
                        
                        try
                        {
                            var invList = from inv in wowidb.invoices where inv.project_no == temp2.ProjectNo select inv;
                            
                            
                            foreach (var inv in invList)
                            {
                                try
                                {
                                    if (!hs.Contains(inv.invoice_id))
                                    {
                                        hs.Add(inv.invoice_id);
                                        if (inv.adjust.HasValue && (decimal)inv.adjust != 0)
                                        {
                                            if (inv.ocurrency != "USD")
                                            {
                                                projDisTotal += (decimal)inv.adjust / (decimal)inv.exchange_rate;
                                            }
                                            else
                                            {
                                                projDisTotal += (decimal)inv.adjust;
                                            }
                                            disIVNo += inv.issue_invoice_no + " ";
                                            try
                                            {
                                                disIVDate += ((DateTime)inv.issue_invoice_date).ToString("yyyy-MM-dd") + " ";
                                            }
                                            catch (Exception)
                                            {

                                                //throw;
                                            }
                                            try
                                            {


                                                DateTime fromDate = dcInvoiceFrom.GetDate();
                                                if ((fromDate - (DateTime)inv.issue_invoice_date).TotalDays > 0)
                                                {
                                                    //flag = true;
                                                    //continue;

                                                }
                                                else
                                                {
                                                    disflag = true;
                                                }


                                            }
                                            catch (Exception)
                                            {


                                                disflag = true;

                                            }
                                            try
                                            {
                                                DateTime toDate = dcInvoiceTo.GetDate();
                                                if ((toDate - (DateTime)inv.issue_invoice_date).TotalDays < 0)
                                                {

                                                }
                                                else
                                                {
                                                    dflag = true;
                                                }

                                            }
                                            catch (Exception)
                                            {


                                                dflag = true;

                                            }

                                            dstate = dflag & disflag;
                                        }
                                    }
                                    if (inv.issue_invoice_date.HasValue)
                                    {
                                        try
                                        {


                                            DateTime fromDate = dcInvoiceFrom.GetDate();
                                            if ((fromDate - (DateTime)inv.issue_invoice_date).TotalDays > 0)
                                            {
                                                //flag = true;
                                                //continue;

                                            }
                                            else
                                            {
                                                isflag = true;
                                            }


                                        }
                                        catch (Exception)
                                        {


                                            isflag = true;

                                        }
                                        try
                                        {
                                            DateTime toDate = dcInvoiceTo.GetDate();
                                            if ((toDate - (DateTime)inv.issue_invoice_date).TotalDays < 0)
                                            {

                                            }
                                            else
                                            {
                                                flag = true;
                                            }

                                        }
                                        catch (Exception)
                                        {


                                            flag = true;

                                        }
                                    }
                                    //state = flag & isflag;
                                    //System.Diagnostics.Debug.WriteLine("INV {0} : {1} : {2} = {3}", inv.issue_invoice_date, flag, isflag, state);
                                    var invtargets = wowidb.invoice_target.Where(c => c.invoice_id == inv.invoice_id);
                                    foreach (var intar in invtargets)
                                    {
                                        if (intar.quotation_target_id == t.Quotation_Target_Id)
                                        {
                                            
                                            try
                                            {
                                                if (inv.ocurrency != "USD")
                                                {
                                                    tarTotal += intar.amount / (decimal)inv.exchange_rate;
                                                }
                                                else
                                                {
                                                    tarTotal += intar.amount;
                                                }
                                                temp2.InvNo += inv.issue_invoice_no + " ";

                                                temp2.InvDate += ((DateTime)inv.issue_invoice_date).ToString("yyyy-MM-dd") + " ";

                                                
                                                foreach (var invr in wowidb.invoice_received.Where(c => c.invoice_id == inv.invoice_id))
                                                {
                                                    bool isflag2 = false;
                                                    bool flag2 = false;
                                                    try
                                                    {
                                                        temp2.InvNo += invr.iv_no + " ";
                                                        if (invr.received_date.HasValue)
                                                        {
                                                            temp2.InvDate += ((DateTime)invr.received_date).ToString("yyyy-MM-dd") + " ";
                                                            if (!state)
                                                            {
                                                                try
                                                                {
                                                                    DateTime fromDate = dcInvoiceFrom.GetDate();
                                                                    if ((fromDate - (DateTime)invr.received_date).TotalDays > 0)
                                                                    {


                                                                    }
                                                                    else
                                                                    {
                                                                        isflag2 = true;
                                                                    }

                                                                }
                                                                catch (Exception)
                                                                {

                                                                    isflag2 = true;
                                                                }
                                                                try
                                                                {
                                                                    DateTime toDate = dcInvoiceTo.GetDate();

                                                                    if ((toDate - (DateTime)invr.received_date).TotalDays < 0)
                                                                    {

                                                                    }
                                                                    else
                                                                    {
                                                                        flag2 = true;
                                                                    }
                                                                }
                                                                catch (Exception)
                                                                {
                                                                    flag2 = true;
                                                                }
                                                                state |= (flag2 && isflag2);
                                                                //System.Diagnostics.Debug.WriteLine("INVR {0} : {1} : {2} = {3}", invr.received_date, flag2, isflag2, state);
                                                            }                                   
                                                        }
                                                        
                                                    }
                                                    catch (Exception)
                                                    {

                                                        //isflag = true;
                                                    }
                                                }
                                               
                                            }
                                            catch (Exception)
                                            {

                                                //isflag = true;
                                            }

                                        }
                                    }
                                }
                                catch (Exception)
                                {

                                    //isflag = true;
                                }
                            }//end of invoice
                            
                            temp2.InvUSD = tarTotal.ToString("F2");
                        }
                        catch (Exception)
                        {

                            //throw;
                        }

                        
                        decimal prtot = 0;
                        try
                        {
                            
                            try
                            {
                                int eid = (int)t.Country_Manager;
                                var e = wowidb.employees.First(c => c.id == eid);
                                temp2.IMA = e.fname + " " + e.lname;
                                if (ddlIMA.SelectedValue != "-1")
                                {
                                    try
                                    {

                                        if (eid != int.Parse(ddlIMA.SelectedValue))
                                        {
                                            continue;
                                        }
                                    }
                                    catch (Exception)
                                    {
                                        continue;
                                    }

                                }
                            }
                            catch (Exception)
                            {
                                
                                //throw;
                            }
                            
                            
                        }
                        catch (Exception)
                        {
              
                            continue;
                        }
                        
                        try
                        {
                            //var prs = wowidb.PRs.Where(c => c.project_id == proj.Project_Id);

                            var prs = from pp in wowidb.PRs from aa in wowidb.PR_authority_history where pp.project_id == proj.Project_Id & pp.pr_auth_id == aa.pr_auth_id & (aa.status == 6 || aa.status == 8) select pp;
                            foreach (var pr in prs)
                            {
                                //temp2.IMA = pr.create_user;
                                temp2.IMACostCurrency = pr.currency;

                                try
                                {
                                    var item = wowidb.PR_item.First(c => c.pr_id == pr.pr_id);
                                    if (t.Quotation_Target_Id == item.quotation_target_id)
                                    {
                                        if (pr.vendor_id != -1)
                                        {
                                            temp2.VenderNo = pr.vendor_id.ToString();
                                            try
                                            {
                                                var vender = (from ven in wowidb.vendors where ven.id == pr.vendor_id select ven).First();
                                                temp2.VenderName +=  ( (String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name) +"/ ");
                                            }
                                            catch (Exception)
                                            {

                                                //throw;
                                            }
                                        }
                                        temp2.PRNo += pr.pr_id + " ";
                                        foreach (var prr in wowidb.PR_Payment.Where(c => c.pr_id == item.pr_id))
                                        {
                                            prtot += (decimal)prr.total_amount;
                                            if (prr.pay_date.HasValue)
                                            {
                                                temp2.PaymentDate += ((DateTime)prr.pay_date).ToString("yyyy-MM-dd") + " ";
                                            }
                                        }
                                        //break;
                                    }
                                }
                                catch (Exception)
                                {
                                    
                                    //throw;
                                }
                                
                            }
                            
                        }
                        catch
                        {
                        }
                        if (!state)
                        {
                            continue;
                        }
                        temp2.IMACost = prtot.ToString("F2");
                        temp2.GrossProfitUS = (tarTotal - prtot).ToString("F2");
                        invusd += tarTotal;
                        imausd += prtot;
                        profit += (tarTotal - prtot);
                        list.Add(temp2);
                        
                    }//end of targets
                    if (projDisTotal != 0 && dstate )
                    {
                        CostAnalysisData tempD = new CostAnalysisData();
                        tempD.ProjectNo = temp.ProjectNo;
                        //tempD.Status = temp.Status;
                        //tempD.OpenDate = temp.OpenDate;
                        //tempD.StatusDate = temp.StatusDate;
                        tempD.QutationNo = temp.QutationNo;
                        tempD.QutationId = temp.QutationId;
                        tempD.InvNo = disIVNo;
                        tempD.InvDate = disIVDate;
                        //tempD.Model = temp.Model;
                        //tempD.Client = temp.Client;
                        //tempD.Sales = temp.Sales;
                        tempD.Country = "Discount";
                        tempD.IMACostCurrency = "USD";
                        tempD.IMACost = 0.0.ToString("F2");
                        tempD.GrossProfitUS = (0.0).ToString("F2");
                        tempD.InvUSD = (-1 * projDisTotal).ToString("F2");
                        invusd -= projDisTotal;
                        profit -= projDisTotal;
                        list.Add(tempD);
                    }
                    projDisTotal = 0;
                    disIVNo = "";
                    disIVDate = "";
                }
                catch
                {
                }
                
            }//end of project
        
            
        }
        catch (Exception)
        {

            //throw;
        }
        

        if (str == null)
        {
            iGridView1.DataSource = list;
            count = list.Count();
        }
        else
        {
            var slist = from i in list select i;
            switch (str)
            {
                case "Sales":
                    slist = slist.OrderBy(c => c.Sales);
                    break;
                case "IMA":
                    slist = slist.OrderBy(c => c.IMA);
                    break;
                case "QutationNo":
                    slist = slist.OrderBy(c => c.QutationNo);
                    break;
                case "Country":
                    slist = slist.OrderBy(c => c.Country);
                    break;
                case "Model":
                    slist = slist.OrderBy(c => c.Model);
                    break;
                case "ProjectNo":
                    slist = slist.OrderBy(c => c.ProjectNo);
                    break;
                case "Client":
                    slist = slist.OrderBy(c => c.Client);
                    break;
            }
            iGridView1.DataSource = slist;
            count = slist.Count();
        }
        iGridView1.AllowSorting = true;
        iGridView1.DataBind();
        if (iGridView1.Rows.Count == 0)
        {
            btnExport.Enabled = false;
            lblMsg.Visible = true;
            
        }
        else
        {
            btnExport.Enabled = true;
            lblMsg.Visible = false;            
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        Utils.ExportExcel(iGridView1, "CostAnalysis");
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void ddlSales_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name.Contains("Sales")  && s.department_id == d.id orderby s.fname, s.c_fname select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlIMA_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name.Contains("IMA") && s.department_id == d.id orderby s.fname, s.c_fname  select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlProj_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = from c in wowidb.Projects orderby c.Project_No descending select new { Project_No = c.Project_No + " - [" + ((from qq in wowidb.Quotation_Version where qq.Quotation_No == c.Quotation_No select qq.Model_No).FirstOrDefault()) + "]", Project_Id = c.Project_Id };
        (sender as DropDownList).DataTextField = "Project_No";
        (sender as DropDownList).DataValueField = "Project_Id";
        (sender as DropDownList).DataBind();
    }


    protected void ddlClient_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3 orderby c.companyname,c.c_companyname select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
        (sender as DropDownList).DataSource = clients;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void ddlCountry_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = GetTargetList();
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }
   
    protected void iGridView1_PreRender(object sender, EventArgs e)
    {
        RowSpanHandeler(0);
    }
       

    private void RowSpanHandeler(int idx)
    {
        int i = 1;
        int AlternatingRowStyle_i = 0;
        int AlternatingRowStyle_j = 0;
        int[] indexs = { 0, 3, 4 };
        //Get all rows
        foreach (GridViewRow wkItem in iGridView1.Rows)
        {
            
            AlternatingRowStyle_j += 1;
            if (idx > -1)
            {

                if (wkItem.RowIndex == 0)
                {
                    wkItem.Cells[idx].RowSpan = 1;
                    foreach (var j in indexs)
                    {
                        wkItem.Cells[j].RowSpan = 1;
                    }
                    
                }
                else
                {
                    TableCell t1 = (wkItem.Cells[idx]);
                    TableCell t2 = iGridView1.Rows[wkItem.RowIndex - i].Cells[idx];
                    bool flag = false;
                    if (t1.Controls.Count == 0)//Label
                    {
                        flag = t1.Text.Trim() == t2.Text.Trim();

                    }
                    
                    
                    if (flag)
                    {
                        //rowspan
                        foreach (var j in indexs)
                        {
                            iGridView1.Rows[wkItem.RowIndex - i].Cells[j].RowSpan += 1;
                            wkItem.Cells[j].Visible = false;
                        }
                        i = i + 1;
                        
                    }
                    else
                    {
        
                        AlternatingRowStyle_i += 1;
                        
                        foreach (var j in indexs)
                        {
                            iGridView1.Rows[wkItem.RowIndex].Cells[j].RowSpan = 1;
                        }
                       
                        i = 1;

                    }
                }
               
            }

           

        }
    }
    public List<Display> GetTargetList()
    {
        List<Display> list = new List<Display>();
        var tlist = (from c in wowidb.Quotation_Target select c.target_description).Distinct().OrderBy(c => c);
        foreach (var t in tlist)
        {
            Display dis = new Display();
            try
            {
            var country_id = wowidb.Quotation_Target.First(c=> c.target_description==t).country_id;
            var cName = wowidb.countries.First(c => c.country_id == country_id).country_name;
            dis.Text = t + " - [ " + cName + " ]";
            dis.Id = t;
            list.Add(dis);
            }
            catch (Exception)
            {

                //throw;
            }

        }
        return list;
    }
    protected void iGridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        Search(e.SortExpression);
    }

    decimal profit = 0, invusd = 0, imausd = 0;
    public string GetInvUSD()
    {
        return invusd.ToString("F2");
    }
    public string GetIMACost()
    {
        return imausd.ToString("F2");
    }
    public string GetGrossProfitUS()
    {
        return profit.ToString("F2");
    }


    protected void iGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       if(e.Row.RowType == DataControlRowType.Footer){
           e.Row.Cells[8].CssClass = "HighLight1";
           e.Row.Cells[10].CssClass = "HighLight1";
           e.Row.Cells[16].CssClass = "HighLight1";
       }

    }


   
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
  <ContentTemplate>
  毛利分析
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                       <tr>
                            <th align="left" width="13%">
                                AE :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlSales" runat="server"  AppendDataBoundItems="True" 
                                    onload="ddlSales_Load">
                                    <asp:ListItem Value="-1">- All -</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                IMA :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlIMA" runat="server"  AppendDataBoundItems="True" 
                                    onload="ddlIMA_Load">
                                    <asp:ListItem Value="-1">- All -</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlProj_Load">
                                     <asp:ListItem Value="-1">- All -</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlClient_Load">
                                     <asp:ListItem Value="-1">- All -</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Open Project Date From : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcProjFrom" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcProjTo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Target :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" 
                                    onload="ddlCountry_Load">
                                     <asp:ListItem Value="-1">- All -</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date From : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcInvoiceFrom" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcInvoiceTo" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project Status :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>- All -</asp:ListItem>
                                    <asp:ListItem>Open</asp:ListItem>
                                    <asp:ListItem>In-Progress</asp:ListItem>
                                    <asp:ListItem>On-Hand</asp:ListItem>
                                    <asp:ListItem>Done</asp:ListItem>
                                    <asp:ListItem>Cancelled</asp:ListItem>
                                    <asp:ListItem>Lost</asp:ListItem>
                                    <asp:ListItem>Void</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Status Date From : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcStatusFromDate" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="dcStatusToDate" runat="server" Visible="True" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                               <%-- Keyword Search :&nbsp;--%></th>
                            <td width="20%">
                               <%-- <asp:TextBox ID="tbkey" runat="server" Text="" 
                                    ></asp:TextBox>--%>
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                    onclick="btnSearch_Click" />
                                
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="btnExport" runat="server" Text="Excel" 
                                    onclick="btnExport_Click" Enabled="False" />
                                
                            </td>
                        </tr>
                        
                       
                   <tr><td colspan="6">
                       <asp:Label ID="lblMsg" runat="server" Text="No matched data found." ></asp:Label>
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server"  Width="100%" 
                           isMergedHeader="True" SkinID="GridView"
                        AutoGenerateColumns="False" CssClass="Gridview" ShowFooter="true"
                         onsorting="iGridView1_Sorting" 
                           SkipColNum="0" onrowdatabound="iGridView1_RowDataBound" onprerender="iGridView1_PreRender" 
                           >
                        <Columns>
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" SortExpression="ProjectNo"/>
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" SortExpression="QutationNo"/>
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client"/>
                            <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model"/>
                            <asp:BoundField DataField="Country" HeaderText="Target" SortExpression="Country"/>
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:TemplateField HeaderText="Gross Profit US" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("GrossProfitUS") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("GrossProfitUS") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                   <table width="100%"><tr><td align="right">
                                   <asp:Literal ID="Literal1" runat="server" Text="<%# GetGrossProfitUS()%>"></asp:Literal>
                                    </td></tr></table>
                                     </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Sales" HeaderText="AE" SortExpression="Sales" />
                            <asp:TemplateField HeaderText="Inv USD" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("InvUSD") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("InvUSD") %>'></asp:Label>
                                </ItemTemplate>
                                 <FooterTemplate>
                                 <table width="100%"><tr><td align="right">
                                    <asp:Literal ID="Literal1" runat="server" Text="<%# GetInvUSD()%>"></asp:Literal>
                                    </td></tr></table>
                                     </FooterTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="InvDate" HeaderText="Inv Date" />
                            <asp:BoundField DataField="InvNo" HeaderText="Inv No" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA" SortExpression="IMA"/>
                            <%--<asp:BoundField DataField="VenderNo" HeaderText="No" />--%>
                            <asp:BoundField DataField="VenderName" HeaderText="VenderName" />
                            <asp:BoundField DataField="IMACostCurrency" HeaderText="幣別" />
                            <asp:TemplateField HeaderText="Cost$" ItemStyle-HorizontalAlign="Right">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("IMACost") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("IMACost") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <table width="100%"><tr><td align="right">
                                   <asp:Literal ID="Literal1" runat="server" Text="<%# GetIMACost()%>"></asp:Literal>
                                    </td></tr></table>
                                     </FooterTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="SubCostUSD" HeaderText="SubCost USD" />
                            <asp:BoundField DataField="Prepay" HeaderText="Prepay" />
                            <asp:BoundField DataField="Preunpay" HeaderText="Preunpay" />
                            <asp:BoundField DataField="Unpay" HeaderText="Unpay" />
                            <asp:BoundField DataField="Payable" HeaderText="Payable" />
                            <asp:BoundField DataField="Payment" HeaderText="Payment" />
                            <asp:BoundField DataField="TotalPayment" HeaderText="$" />
                            <asp:BoundField DataField="PaymentDate" HeaderText="Date" />--%>
                            <asp:BoundField DataField="PaymentDate" HeaderText="Paid Date" />
                            <asp:BoundField DataField="PRNo" HeaderText="PR No" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExport" />
        </Triggers>
   </asp:UpdatePanel>
</asp:Content>

