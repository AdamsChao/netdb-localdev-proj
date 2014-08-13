using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

public partial class Project_CertificateMail : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    //if (Cache["IsMailCertificateRenewalAlert"] == null)
    if (IsAlertMailExist() == false)
    {
      if (GridViewProjectTarget.Rows.Count > 0)
      {
        string[] mailto = { "ima1@wowiapproval.com", "ima2@wowiapproval.com", "ima3@wowiapproval.com", "ima4@wowiapproval.com", "sales-1@wowiapproval.com", "sales-2@wowiapproval.com", "sales-3@wowiapproval.com", "sales-4@wowiapproval.com", "sales-5@wowiapproval.com", "sales-6@wowiapproval.com" };
        string[] mailcc = { "Shirley.Kang@WoWiApproval.com", "Scott.Wang@WoWiApproval.com", "Miranda.Chen@WoWiApproval.com" };
        //string[] mailto = { "adams@netdb.com.tw" };
        //string[] mailcc = { "adams@netdb.com.tw" };
        string[] mailbcc = { "adams@netdb.com.tw" };
        MailUtil.SendHTMLMail("dbservice@wowiapproval.com", mailto, mailcc, mailbcc, "Certificate Renewal Alert", PanelMail);
        // Cache.Insert("IsMailCertificateRenewalAlert", "1", null
        //, DateTime.Now.AddDays(1)
        //, System.Web.Caching.Cache.NoSlidingExpiration);        
      }

      //另外傳送一封MAIL給IMA PM
      SqlDataSourceTarget.SelectCommand = @"SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager 
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent 
, country.country_name, Authority.authority_name ,world_region.world_region_name 
, (Select fname + ' ' + lname as cmname from employee where id = Country_Manager ) as CountryManager 
, Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No 
, SalesId , Employee.fname + ' ' + lname  as 'AE' 
, Client_Id , clientapplicant.companyname as 'Client' 
, [certificate_type],[certificate_issue_date],[certificate_expiry_date]
, [email_renewal_notice_date],[renewal_confirmation_check],[conduct_renewal_action_date]
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN world_region ON world_region.world_region_id = country.world_region_id
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN Quotation_Version ON Quotation_Version.Quotation_Version_Id = Quotation_Target.quotation_id AND Quotation_Status=5
INNER JOIN Project ON Project.Quotation_No = Quotation_Version.Quotation_No
INNER JOIN Employee ON Employee.id = Quotation_Version.SalesId
INNER JOIN clientapplicant ON Quotation_Version.Client_Id = clientapplicant.id 
WHERE  (Quotation_Target.Status = 'Done' OR Quotation_Target.Status = 'Delay')
AND (renewal_confirmation_check = '1' or renewal_confirmation_check = '2')
AND (Quotation_Target.conduct_renewal_action_date < getdate()) ";
      SqlDataSourceTarget.Select(DataSourceSelectArguments.Empty);
      GridViewProjectTarget.DataBind();
      if (GridViewProjectTarget.Rows.Count > 0)
      {
        lbl_msg.Text = "這是由系統自動發出的 Certificate Renewal Action Alert，請相關負責人員注意下列表中 Target 之 Renewal Action 時間";
        string[] mailto = { "ima1@wowiapproval.com", "ima2@wowiapproval.com", "ima3@wowiapproval.com", "ima4@wowiapproval.com"};
        string[] mailcc = { "Shirley.Kang@WoWiApproval.com", "Scott.Wang@WoWiApproval.com", "Miranda.Chen@WoWiApproval.com" };
        string[] mailbcc = { "adams@netdb.com.tw" };
        MailUtil.SendHTMLMail("dbservice@wowiapproval.com", mailto, mailcc, mailbcc, "Certificate Renewal Action Alert", PanelMail);                
      }

      //設定已經傳送MAIL FLAG
      SetAlertMail();
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
    //if (Cache["IsMailCertificateRenewalAlert"] != null)
    if (IsAlertMailExist())
    {
      e.Cancel = true;
    }
  }

  protected bool IsAlertMailExist()
  {
    int counter = 0;
    using (SqlConnection cn =
      new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString))
    {
      cn.Open();
      SqlCommand cmd = new SqlCommand("Select count(*) from AlertMail Where alertmail_date = @alertmail_date", cn);
      cmd.Parameters.AddWithValue("@alertmail_date", DateTime.Now.ToShortDateString());
      counter = (int)cmd.ExecuteScalar();
    }

    if (counter == 0)
    {
      return false;
    }
    else
    {
      return true;
    }
  }

  protected void SetAlertMail()
  {
    try
    {
      using (SqlConnection cn =
       new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString))
      {
        cn.Open();
        SqlCommand cmd =
          new SqlCommand("Insert into AlertMail(alertmail_date,IsMailCertificateRenewalAlert) values(@alertmail_date,@IsMailCertificateRenewalAlert)", cn);
        cmd.Parameters.AddWithValue("@alertmail_date", DateTime.Now.ToShortDateString());
        cmd.Parameters.AddWithValue("@IsMailCertificateRenewalAlert", true);
        cmd.ExecuteNonQuery();
      }
    }
    catch (Exception)
    {

    }
  }

}
