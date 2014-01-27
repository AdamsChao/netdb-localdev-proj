using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Project_CertificateExpirationTrackerAndExport : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack)
    {
      if (DropDownListCM.SelectedValue != "0")
      {
        SqlDataSourceTarget.SelectCommand +=
          " AND (Quotation_Target.Country_Manager LIKE " + DropDownListCM.SelectedValue + ") ";
      }

      if (DropDownListRegion.SelectedValue != "0")
      {
        SqlDataSourceTarget.SelectCommand +=
          " AND (world_region_name LIKE '%" + DropDownListRegion.SelectedItem.Text + "%') ";
      }

      if (!string.IsNullOrEmpty(txt_certificate_issue_date.Text))
      {
        SqlDataSourceTarget.SelectCommand += " AND (certificate_issue_date >= '" + txt_certificate_issue_date.Text + "') ";
      }

      if (!string.IsNullOrEmpty(txt_certificate_expiry_date.Text))
      {
        SqlDataSourceTarget.SelectCommand += " AND (certificate_issue_date <= '" + txt_certificate_expiry_date.Text + "') ";
      }
    }
  }

  protected void DropDownListCountry_DataBound(object sender, EventArgs e)
  {
    DropDownListCountry.Items.Insert(0, new ListItem()
    {
      Text = "- All -",
      Value = "%"
    });
  }

  protected void ButtonSearch_Click(object sender, EventArgs e)
  {
    SqlDataSourceTarget.SelectCommand += " ORDER BY Project.Project_Id Desc ";
    GridViewProjectTarget.DataBind();
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

      //Lifetime
      CheckBox cb = e.Row.FindControl("cb_Lifetime") as CheckBox;
      if (cb.Checked)
      {
        lbl_certificate_expiry_date.Text = "N/A";
        lbl_certificate_duration.Text = "Lifetime";
        lbl_time_until_expiration.Text = "N/A";
      }
    }
  }
  protected void SqlDataSourceTarget_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
  {
    if (!Page.IsPostBack)
    {
      e.Cancel = true;
    }
  }
  protected void btn_export_Click(object sender, EventArgs e)
  {
    if (GridViewProjectTarget.Rows.Count > 0)
    {
      GridViewProjectTarget.AllowPaging = false;
      GridViewProjectTarget.AllowSorting = false;
      GridViewProjectTarget.DataBind();

      HttpContext.Current.Response.Clear();
      HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
      HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=Certificate Expiration Tracker.xls");
      HttpContext.Current.Response.Charset = "utf-8";
      HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
      StringWriter sw = new StringWriter();
      HtmlTextWriter hw = new HtmlTextWriter(sw);
      PanelReport.RenderControl(hw);
      HttpContext.Current.Response.Write(sw.ToString());
      HttpContext.Current.Response.Flush();
      HttpContext.Current.Response.End();
    }
  }

  public override void VerifyRenderingInServerForm(Control control)
  {

  }
}