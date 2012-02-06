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
    public static void Mail(string[] mailto, string[] mailcc,string mailSubject, string mailContent)
    {
        string mailfrom = "System@gmail.com";
        Panel panel = new Panel();
        Literal ltlMail = new Literal();
        ltlMail.Text = mailContent;
        panel.Controls.Add(ltlMail);
        MailUtil.SendHTMLMail(mailfrom, mailto, mailcc, null, mailSubject, panel);
    }

    public static void WaitingSupervisorApproval(WoWiModel.PR_authority_history auth)
    {
        QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
        WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
        string mailSubject = String.Format("PR No.#{0} / {1} / {2} / {3} / {4}  is request for approval", auth.pr_id, "Vender", "Item Description", "Part", "M#");
        string mailContent = String.Format("{0} by {1}", mailSubject, auth.requisitioner + "<br />" + PRApproval_URL + auth.pr_id);

        


    }
}