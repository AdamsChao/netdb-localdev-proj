using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Project_CertificateMail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Cache["IsMailCertificateRenewalAlert"] == null)
        {
            if (GridViewProjectTarget.Rows.Count > 0)
            {
                string[] mailto = { "ima1@wowiapproval.com", "ima2@wowiapproval.com", "ima3@wowiapproval.com", "ima4@wowiapproval.com", "sales-1@wowiapproval.com", "sales-2@wowiapproval.com", "sales-3@wowiapproval.com", "sales-4@wowiapproval.com", "sales-5@wowiapproval.com", "sales-6@wowiapproval.com" };
                string[] mailcc = { "Shirley.Kang@WoWiApproval.com", "Scott.Wang@WoWiApproval.com", "Miranda.Chen@WoWiApproval.com" };
                string[] mailbcc = { "adams@netdb.com.tw" };
                MailUtil.SendHTMLMail("dbservice@wowiapproval.com", mailto, mailcc, mailbcc, "Certificate Renewal Alert", PanelMail);
                Cache.Insert("IsMailCertificateRenewalAlert", "1", null
               , DateTime.Now.AddDays(1)
               , System.Web.Caching.Cache.NoSlidingExpiration);
            }
        }
    }

    protected void GridViewProjectTarget_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl_certificate_issue_date = e.Row.FindControl("lbl_certificate_issue_date") as Label;
            Label lbl_certificate_expiry_date = e.Row.FindControl("lbl_certificate_expiry_date") as Label;

            Label lbl_certificate_duration = e.Row.FindControl("lbl_certificate_duration") as Label;
            Label lbl_time_until_expiration = e.Row.FindControl("lbl_time_until_expiration") as Label;
            Label lbl_today_date = e.Row.FindControl("lbl_today_date") as Label;
            lbl_today_date.Text = DateTime.Now.ToString("yyyy/MM/dd");
            //計算certificate_duration
            if (!string.IsNullOrEmpty(lbl_certificate_issue_date.Text) && !string.IsNullOrEmpty(lbl_certificate_expiry_date.Text))
            {
                DateTime dt_issue = DateTime.Parse(lbl_certificate_issue_date.Text);
                DateTime dt_expiry = DateTime.Parse(lbl_certificate_expiry_date.Text);
                int year = dt_expiry.Year - dt_issue.Year; //相差的年份
                int month = dt_expiry.Month - dt_issue.Month;  //相差的月份 
                int day = dt_expiry.Day - dt_issue.Day;//相差的天數 
                lbl_certificate_duration.Text = year.ToString() + " years , "
                  + month.ToString() + " months , "
                  + day.ToString() + " days.";
            }
            //計算time_until_expiration
            if (!string.IsNullOrEmpty(lbl_certificate_expiry_date.Text))
            {
                DateTime dt_expiry = DateTime.Parse(lbl_certificate_expiry_date.Text);
                int year = dt_expiry.Year - DateTime.Now.Year; //相差的年份
                int month = dt_expiry.Month - DateTime.Now.Month;  //相差的月份 
                int day = dt_expiry.Day - DateTime.Now.Day;//相差的天數 
                lbl_time_until_expiration.Text = year.ToString() + " years , "
                  + month.ToString() + " months , "
                  + day.ToString() + " days.";
            }

            Label lbl_renewal_confirmation_check = e.Row.FindControl("lbl_renewal_confirmation_check") as Label;
            switch (lbl_renewal_confirmation_check.Text)
            {
                case "1":
                    lbl_renewal_confirmation_check.Text = "Automatic Renewal Service provided by WoWi(WoWi 提供自動更新服務)";
                    break;
                case "2":
                    lbl_renewal_confirmation_check.Text = "Renewal Confirmed(更新確認)";
                    break;
                case "3":
                    lbl_renewal_confirmation_check.Text = "No Need(無須更新)";
                    break;
                default:
                    lbl_renewal_confirmation_check.Text = "Not Setup(未設定)";
                    break;
            }
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void SqlDataSourceTarget_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (Cache["IsMailCertificateRenewalAlert"] != null)
        {
            e.Cancel = true;
        }
    }
}