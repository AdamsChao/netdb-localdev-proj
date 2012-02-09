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
        var data = (from t in db.Target from qt in db.Quotation_Target from q in list where qt.quotation_id == q.Id & qt.target_id == t.target_id select new { Code = t.target_code, Desc = t.target_description }).First();
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

        string mailSubject = GetPRMailSubject(auth);
        string sender = auth.requisitioner + "<br />" + PRApproval_URL + auth.pr_id;
        string mailContent = GetPRMailContent(mailSubject,sender);
        string to = GetEmail((int)auth.supervisor_id);
        if (to != null)
        {
            string cc = GetEmail((int)auth.requisitioner_id);
            Mail(new String[]{to},new String[]{cc},mailSubject,mailContent);
        }
    }

    public static void WaitingForVPApprove(WoWiModel.PR_authority_history auth)
    {
        string mailSubject = GetPRMailSubject(auth);
        string sender = auth.supervisor + "<br />" + PRApproval_URL + auth.pr_id;
        string mailContent = GetPRMailContent(mailSubject, sender);
        string to = GetEmail((int)auth.vp_id);
        if (to != null)
        {
            string cc1 = GetEmail((int)auth.requisitioner_id);
            string cc2 = GetEmail((int)auth.supervisor_id);
            Mail(new String[] { to }, new String[] { cc1,cc2 }, mailSubject, mailContent);
        }
    }

    public static void WaitingForPresidentApprove(WoWiModel.PR_authority_history auth)
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

    public static void SupervisorDisapprove(WoWiModel.PR_authority_history auth)
    {
        string mailSubject = GetPRMailSubject(auth,"disapprove");
        string sender = auth.supervisor_id + "<br />" + PRApproval_URL + auth.pr_id;
        string mailContent = GetPRMailContent(mailSubject, sender);
        string to = GetEmail((int)auth.requisitioner_id);
        if (to != null)
        {
            string cc = GetEmail((int)auth.supervisor_id);
            Mail(new String[] { to }, new String[] { cc }, mailSubject, mailContent);
        }
    }

    public static void VPDisapprove(WoWiModel.PR_authority_history auth)
    {
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

    public static void PRStatusDone(WoWiModel.PR_authority_history auth)
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
}