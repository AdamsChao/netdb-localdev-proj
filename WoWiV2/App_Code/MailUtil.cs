/*************************************************   
'* 模組: SendHTMLMail
'* 作者: Adams <adamschao@gmail.com>
'* 修改: 2011-11-2
'* 目的: 
'* 參數: 
'* 註解: 
'*************************************************/

using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Text;

using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI;

/// <summary>
/// Summary description for MailUtil
/// </summary>
public class MailUtil
{
    public static void SendHTMLMail(string mailfrom, string mailto, string mailSubject, Panel panel)
    {
        try
        {
            MailMessage mail = new MailMessage(mailfrom, mailto);
            
            mail.IsBodyHtml = true;
            mail.Subject = mailSubject;            
            mail.BodyEncoding = Encoding.UTF8;

            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            panel.RenderControl(hw);
            mail.Body = sw.ToString();

            //SmtpClient client = new SmtpClient("smtp.supreme.com.tw");
            //client.Credentials = new System.Net.NetworkCredential("itest", "zaq1@WSX", "supreme.com.tw");
            //client.Send(mail);

            SmtpClient smtpClient = new SmtpClient("msa.hinet.net", 25);//設定E-mail Server和port
            smtpClient.Send(mail);
        }
        catch (Exception ex)
        {            
            throw ex;
        }       
    }

    public static void SendHTMLMail(string mailfrom, string[] mailto,string[] mailcc , string[] mailbcc , string mailSubject, Panel panel)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(mailfrom);

            if (mailto != null)
            {
                foreach (string to in mailto)
                {
                    mail.To.Add(new MailAddress(to));
                }                                
            }

            if (mailcc  != null)
            {

                foreach (string cc in mailcc)
                {
                    mail.CC.Add(new MailAddress(cc));
                }                 
            }

            if (mailbcc != null)
            {
                foreach (string bcc in mailbcc)
                {
                    mail.Bcc.Add(new MailAddress(bcc));
                }                
            }
          
            
            mail.IsBodyHtml = true;
            mail.Subject = mailSubject;
            mail.BodyEncoding = Encoding.UTF8;

            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            panel.RenderControl(hw);
            mail.Body = sw.ToString();

            //SmtpClient client = new SmtpClient("smtp.supreme.com.tw");
            //client.Credentials = new System.Net.NetworkCredential("itest", "zaq1@WSX", "supreme.com.tw");
            SmtpClient smtpClient = new SmtpClient("msa.hinet.net", 25);//設定E-mail Server和port
            smtpClient.Send(mail);
            smtpClient.Send(mail);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}