using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for PRUtils
/// </summary>
public class PRUtils
{
    public const String PRApproval_URL = "http://wowiv2.wowiapproval.com/Accounting/UpdatePR.aspx?id=";
    static QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    static WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    public static void Mail(string[] mailto, string[] mailcc,string mailSubject, string mailContent)
    {
        string mailfrom = "System@gmail.com";
        Panel panel = new Panel();
        Literal ltlMail = new Literal();
        ltlMail.Text = mailContent;
        panel.Controls.Add(ltlMail);
        MailUtil.SendHTMLMail(mailfrom, mailto, mailcc, null, mailSubject, panel);
    }

    private static String GetPRMailSubject(WoWiModel.PR_authority_history auth)
    {
        return GetPRMailSubject(auth, "request for approval");
    }
    private static String GetPRMailSubject(WoWiModel.PR_authority_history auth,String message)
    {
        int prid = auth.pr_id;
        WoWiModel.PR obj = (from p in wowidb.PRs where p.pr_id == prid select p).First();
        WoWiModel.vendor ven = (from v in wowidb.vendors where v.id == obj.vendor_id select v).First();
        String venderName = String.IsNullOrEmpty(ven.name) ? ven.c_name : ven.name;
        String quotaion_no = (from d in db.Quotation_Version where d.Quotation_Version_Id == obj.quotaion_id select d.Quotation_No).First();
        var list = from q in db.Quotation_Version
                       where q.Quotation_No.Equals(quotaion_no)
                       select new
                       {
                           No = q.Quotation_No,
                           Version = q.Vername,
                           Id = q.Quotation_Version_Id
                       };
        var data = (from t in wowidb.Target_Rates from qt in wowidb.Quotation_Target from q in list where qt.quotation_id == q.Id & qt.target_id == t.Target_rate_id select new { Code = t.authority_name, Desc = qt.target_description }).First();
        String templateStr = "PR No.#{0} / {1} / {2} / {3}  is "+message;
        return String.Format(templateStr, prid, venderName, data.Desc,data.Code);
    }

    private static String GetPRMailContent(String subject,String sender)
    {
        return String.Format("{0} by {1}", subject, sender);
    }

    private static String GetEmail(int empId)
    {
        return (from c in wowidb.employees where c.id == empId select c.email).First();
    }

    public static void WaitingForSupervisorApprove(WoWiModel.PR_authority_history auth)
    {
        try
        {
            string mailSubject = GetPRMailSubject(auth);
            string sender = auth.requisitioner + "<br />" + PRApproval_URL + auth.pr_id;
            string mailContent = GetPRMailContent(mailSubject, sender);
            string to = GetEmail((int)auth.supervisor_id);
            if (to != null)
            {
                string cc = GetEmail((int)auth.requisitioner_id);
                Mail(new String[] { to }, new String[] { cc }, mailSubject, mailContent);
            }
        }
        catch (Exception)
        {

            //throw;
        }
        
    }

    public static void WaitingForVPApprove(WoWiModel.PR_authority_history auth)
    {
        try
        {
            string mailSubject = GetPRMailSubject(auth);
            string sender = auth.supervisor + "<br />" + PRApproval_URL + auth.pr_id;
            string mailContent = GetPRMailContent(mailSubject, sender);
            string to = GetEmail((int)auth.vp_id);
            if (to != null)
            {
                string cc1 = GetEmail((int)auth.requisitioner_id);
                string cc2 = GetEmail((int)auth.supervisor_id);
                Mail(new String[] { to }, new String[] { cc1, cc2 }, mailSubject, mailContent);
            }
        }
        catch (Exception)
        {

            //throw;
        }
       
    }

    public static void WaitingForPresidentApprove(WoWiModel.PR_authority_history auth)
    {
        try
        {
            string mailSubject = GetPRMailSubject(auth);
            string sender = auth.vp + "<br />" + PRApproval_URL + auth.pr_id;
            string mailContent = GetPRMailContent(mailSubject, sender);
            string to = GetEmail((int)auth.president_id);
            if (to != null)
            {
                string cc1 = GetEmail((int)auth.requisitioner_id);
                string cc2 = GetEmail((int)auth.supervisor_id);
                string cc3 = GetEmail((int)auth.vp_id);
                Mail(new String[] { to }, new String[] { cc1, cc2, cc3 }, mailSubject, mailContent);
            }
        }
        catch (Exception)
        {

            //throw;
        }
        
    }

    public static void SupervisorDisapprove(WoWiModel.PR_authority_history auth)
    {
        try
        {
            string mailSubject = GetPRMailSubject(auth, "disapprove");
            string sender = auth.supervisor_id + "<br />" + PRApproval_URL + auth.pr_id;
            string mailContent = GetPRMailContent(mailSubject, sender);
            string to = GetEmail((int)auth.requisitioner_id);
            if (to != null)
            {
                string cc = GetEmail((int)auth.supervisor_id);
                Mail(new String[] { to }, new String[] { cc }, mailSubject, mailContent);
            }
        }
        catch (Exception)
        {

            //throw;
        }
       
    }

    public static void VPDisapprove(WoWiModel.PR_authority_history auth)
    {
        try
        {

        }
        catch (Exception)
        {

            //throw;
        }
        string mailSubject = GetPRMailSubject(auth, "disapprove");
        string sender = auth.vp + "<br />" + PRApproval_URL + auth.pr_id;
        string mailContent = GetPRMailContent(mailSubject, sender);
        string to = GetEmail((int)auth.requisitioner_id);
        if (to != null)
        {
            string cc1 = GetEmail((int)auth.supervisor_id);
            string cc2 = GetEmail((int)auth.vp_id);
            Mail(new String[] { to }, new String[] { cc1, cc2}, mailSubject, mailContent);
        }



    }

    public static void PresidentDisapprove(WoWiModel.PR_authority_history auth)
    {
        try
        {

        }
        catch (Exception)
        {
            
            //throw;
        }
        string mailSubject = GetPRMailSubject(auth, "disapprove");
        string sender = auth.vp + "<br />" + PRApproval_URL + auth.pr_id;
        string mailContent = GetPRMailContent(mailSubject, sender);
        string to = GetEmail((int)auth.requisitioner_id);
        if (to != null)
        {
            string cc1 = GetEmail((int)auth.supervisor_id);
            string cc2 = GetEmail((int)auth.vp_id);
            string cc3 = GetEmail((int)auth.president_id);
            Mail(new String[] { to }, new String[] { cc1, cc2, cc3 }, mailSubject, mailContent);
        }


    }

    public static String statusByteToString(byte b)
    {

        String ret = "";

        if (b == (byte)PRStatus.Init)
        {
            ret = PRStatus.Init.ToString();
        }
        else if (b == (byte)PRStatus.Done)
        {
            ret = "PR Approved";
        }
        else if (b == (byte)PRStatus.Cancel)
        {
            ret = PRStatus.Cancel.ToString();
        }
        else if (b == (byte)PRStatus.History)
        {
            ret = PRStatus.History.ToString();
        }
        else if (b == (byte)PRStatus.Paid)
        {
            ret = PRStatus.Paid.ToString();
        }
        else if (b == (byte)PRStatus.PayHistory)
        {
            ret = PRStatus.PayHistory.ToString();
        }
        else if (b == (byte)PRStatus.President)
        {
            ret = PRStatus.President.ToString();
        }
        else if (b == (byte)PRStatus.Requisitioner)
        {
            ret = PRStatus.Requisitioner.ToString();
        }
        else if (b == (byte)PRStatus.Supervisor)
        {
            ret = PRStatus.Supervisor.ToString();
        }
        else if (b == (byte)PRStatus.VicePresident)
        {
            ret = PRStatus.VicePresident.ToString();
        }
        
        return ret;
    }

    public static void PRStatusDone(WoWiModel.PR_authority_history auth)
    {
        try
        {
            string mailSubject = GetPRMailSubject(auth, "approved");
            string sender = "Approver <br />" + PRApproval_URL + auth.pr_id;
            string mailContent = GetPRMailContent(mailSubject, sender);
            string to = GetEmail((int)auth.requisitioner_id);
            if (to != null)
            {
                string cc = GetEmail((int)auth.finance_id);
                Mail(new String[] { to }, new String[] { cc }, mailSubject, mailContent);
            }
        }
        catch (Exception)
        {
            
            //throw;
        }
       

    }

    public static void PRInfoLabel_Load(object sender, EventArgs e)
    {
        Label lbl = sender as Label;
        try
        {
            if (!String.IsNullOrEmpty(HttpContext.Current.Request.QueryString["id"]))
            {
                int id = int.Parse(HttpContext.Current.Request.QueryString["id"]);
                WoWiModel.PR obj = (from pr in wowidb.PRs where pr.pr_id == id select pr).First();
                WoWiModel.PR_authority_history Auth = wowidb.PR_authority_history.First(c => c.pr_auth_id == obj.pr_auth_id);

                String Name = Auth.requisitioner;
                WoWiModel.employee emp = wowidb.employees.First(c => c.id == Auth.requisitioner_id);
                if (lbl.ID == "lblDept")
                {
                    lbl.Text = (from d in wowidb.departments where d.id == emp.department_id select d.name).First();
                }
                else if (lbl.ID == "lblEmp")
                {
                    lbl.Text = emp.fname + " " + emp.lname;
                }
                else if (lbl.ID == "lblCDate")
                {
                    lbl.Text = ((DateTime)obj.create_date).ToString("yyyy/MM/dd");

                }
            }

        }
        catch (Exception)
        {

            //throw;
        }
    }

    public static String GetString(byte pt)
    {
        String str = "";
        switch (pt)
        {
            case (byte)PRPaymentTerms.PrePaid1:
                str = "Prepayment 1";
                break;
            case (byte)PRPaymentTerms.PrePaid2:
                str = "Prepayment 2";
                break;
            case (byte)PRPaymentTerms.PrePaid3:
                str = "Prepayment 3";
                break;
            case (byte)PRPaymentTerms.FinalPaid:
                str = "Final Payment";
                break;
        }
        return str;
    }

    public static void ddlVenderList_Load(object sender, EventArgs e)
    {
        ddlVenderList_Load(sender, e, "- Select -");
    }
    public static void ddlVenderList_Load(object sender, EventArgs e,String  msg)
    {
        try
        {
            (sender as DropDownList).AppendDataBoundItems = false;
            (sender as DropDownList).Items.Clear();
            (sender as DropDownList).Items.Add(new ListItem(msg, "-1"));
            (sender as DropDownList).AppendDataBoundItems = true;
            int eid = Utils.GetEmployeeID();
            var data = from a in wowidb.m_employee_accesslevel where a.employee_id == eid select a.accesslevel_id;
            if (data.Count() != 0)
            {
                var list = (from c in wowidb.vendors from country in wowidb.countries from a in wowidb.access_level where c.country == country.country_id && data.Contains((int)c.department_id) && c.department_id == a.id orderby c.name, c.c_name select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name + " - [ " + country.country_name + " ]" : c.name + " - [ " + country.country_name + " ] - [ Access Level = " + a.name + " ]" });
                (sender as DropDownList).DataSource = list;
                (sender as DropDownList).DataTextField = "Text";
                (sender as DropDownList).DataValueField = "Id";
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
}