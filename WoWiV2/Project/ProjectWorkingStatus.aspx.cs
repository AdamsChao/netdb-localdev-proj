using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Project_ProjectWorkingStatus : System.Web.UI.Page
{

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!Page.IsPostBack)
    {
      if (Request["ProjectID"] != null)
      {
        lblProject.Text = Request["ProjectID"].ToString();
        ddlWorkingStatusProject.DataBind();
        ddlWorkingStatusProject.SelectedValue = lblProject.Text;
      }
      if (Request["CountryID"] != null)
      {
        lblCountry.Text = Request["CountryID"].ToString();
        ddlWorkingStatusCountry.DataBind();
        ddlWorkingStatusCountry.SelectedValue = lblCountry.Text;
      }
      if (Request["TargetID"] != null)
      {
        if (!string.IsNullOrEmpty(Request["TargetID"]))
        {
          lblTarget.Text = Request["TargetID"].ToString();
          ddlWorkingStatusTarget.DataBind();
          ddlWorkingStatusTarget.SelectedValue = lblTarget.Text;
          dvWorkingStatus.Visible = true;
        }
      }
    }
    if (DropDownListRegion.SelectedValue != "0")
    {
      SqlDataSourceTarget.SelectCommand +=
        " AND (world_region_name LIKE '%" + DropDownListRegion.SelectedItem.Text + "')";
    }
  }

  // Accordion 0

  //Project 一開始預設值
  protected void DropDownListPO_DataBound(object sender, EventArgs e)
  { 
    DropDownListPO.Items.Insert(0, new ListItem()
    {
      Text = "- All -",
      Value = "%"
    });
  }

  protected void DropDownListCountry_DataBound(object sender, EventArgs e)
  {
    DropDownListCountry.Items.Insert(0, new ListItem()
    {
      Text = "- All -",
      Value = "%"
    });
  }


  protected void SqlDataSourceTarget_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
  {
    if (!Page.IsPostBack)
    {
      //第一次網頁載入時，預設不載入資料
      e.Cancel = true;
    }
  }

  protected void ButtonSearch_Click(object sender, EventArgs e)
  {
    SqlDataSourceTarget.SelectCommand += " ORDER BY Project.Project_Id Desc ";
    GridViewProjectTarget.DataBind();
    GridViewProjectTarget.SelectedIndex = -1;
    if (GridViewProjectTarget.Rows.Count > 0)
    {
      PanelReport.Visible = true;      
    }
    else
    {
      PanelReport.Visible = false;      
    }
    HFAccordionStatus.Value = "0"; //控制accordion
  }


  protected void tvProject_SelectedNodeChanged(object sender, EventArgs e)
  {
    SqlDataSourceProject.SelectParameters.Clear();
    SqlDataSourceProject.SelectParameters.Add("Project_Status", tvProject.SelectedValue);
    DropDownListPO.DataBind();
    HFAccordionStatus.Value = "0";
  }

  //點選設定各別Target的 Working Status 時 
  protected void GridViewProjectTarget_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
  {
    GridViewRow row = (sender as GridView).Rows[e.NewSelectedIndex] as GridViewRow;
    lblProject.Text = (row.FindControl("HFProjectID") as HiddenField).Value;
    ddlWorkingStatusProject.DataBind();
    ddlWorkingStatusProject.SelectedValue = lblProject.Text;


    lblCountry.Text = (row.FindControl("HFCountry") as HiddenField).Value;
    ddlWorkingStatusCountry.DataBind();
    ddlWorkingStatusCountry.SelectedValue = lblCountry.Text;

    lblTarget.Text = (row.FindControl("LabelTarget") as Label).Text;
    ddlWorkingStatusTarget.DataBind();
    ddlWorkingStatusTarget.SelectedValue = lblTarget.Text;
    dvWorkingStatus.Visible = true;

    HFAccordionStatus.Value = "1";//控制accordion

    //Setting Target Report    
    //LabelProject.Text = (row.FindControl("LabelProjectNo") as Label).Text;
    //LabelClient.Text = (row.FindControl("HFClient") as HiddenField).Value;
    //LabelModel.Text = (row.FindControl("HFModelNo") as HiddenField).Value;
    //LabelProduct.Text = (row.FindControl("HFProductName") as HiddenField).Value;
    //PanelReport.Visible = true;
  }

  protected void GridViewProjectTarget_PageIndexChanging(object sender, GridViewPageEventArgs e)
  {
    HFAccordionStatus.Value = "0";//控制accordion
  }

  protected void GridViewProjectTarget_Sorting(object sender, GridViewSortEventArgs e)
  {
    HFAccordionStatus.Value = "0";//控制accordion
  }

  // Accordion 1

  protected void ddlWorkingStatusProject_SelectedIndexChanged(object sender, EventArgs e)
  {
    ddlWorkingStatusCountry.DataBind();
    ddlWorkingStatusTarget.DataBind();
    gvWorkingStatus.EditIndex = -1;
    gvWorkingStatus.DataBind();
    dvWorkingStatus.Visible = false;

    DropDownList ddl = sender as DropDownList;

    if (ddl.SelectedValue != "0")
    {
      int pid = int.Parse(ddl.SelectedValue);
      txtAction.Visible = true;
      SaveClientAction.Visible = true;
      QuotationModel.QuotationEntities dc = new QuotationModel.QuotationEntities();
      var project = (from p in dc.Project
                     where p.Project_Id == pid
                     select p).SingleOrDefault();
      if (project != null)
      {
        txtAction.Text = project.Client_Action;
        //PanelReport.Visible = true;
      }
    }
    else
    {
      txtAction.Visible = false;
      SaveClientAction.Visible = false;
      //PanelReport.Visible = false;
    }

    HFAccordionStatus.Value = "1";//控制accordion    
  }
  protected void ddlWorkingStatusProject_DataBound(object sender, EventArgs e)
  {
    DropDownList ddl = (sender as DropDownList);
    ddl.Items.Insert(0, new ListItem()
    {
      Text = "Please select a project...",
      Value = "0"
    });

    txtAction.Visible = false;
    SaveClientAction.Visible = false;

    //if (ddl.Items.Count > 0 && ddl.SelectedValue != "0")
    //{
    //  PanelReport.Visible = true;
    //}
  }
  protected void ddlWorkingStatusCountry_SelectedIndexChanged(object sender, EventArgs e)
  {
    gvWorkingStatus.EditIndex = -1;
    dvWorkingStatus.Visible = false;

    HFAccordionStatus.Value = "1";//控制accordion
  }
  protected void ddlWorkingStatusCountry_DataBound(object sender, EventArgs e)
  {
    ddlWorkingStatusCountry.Items.Insert(0, new ListItem()
    {
      Text = "Please select country...",
      Value = "0"
    });
  }
  protected void ddlWorkingStatusTarget_SelectedIndexChanged(object sender, EventArgs e)
  {
    if ((sender as DropDownList).SelectedValue.ToString() == "0")
    {
      dvWorkingStatus.Visible = false;
    }
    else
    {
      dvWorkingStatus.Visible = true;
    }

    gvWorkingStatus.EditIndex = -1;

    HFAccordionStatus.Value = "1";//控制accordion
  }

  protected void ddlWorkingStatusTarget_DataBound(object sender, EventArgs e)
  {
    ddlWorkingStatusTarget.Items.Insert(0, new ListItem()
    {
      Text = "Please select target...",
      Value = "0"
    });
  }

  protected void gvWorkingStatus_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowIndex > -1 && e.Row.RowType == DataControlRowType.DataRow)
    {
      e.Row.Cells[2].Text = e.Row.Cells[2].Text.Replace("\n", "<br />");

      CheckBox LogVoided = (CheckBox)e.Row.FindControl("chkVoided");
      if (LogVoided.Checked)
      {
        Style VoidedStyle = new Style();
        VoidedStyle.ForeColor = System.Drawing.Color.BurlyWood;
        VoidedStyle.Font.Strikeout = true;
        for (int i = 0; i < e.Row.Cells.Count - 1; i++)
        {
          e.Row.Cells[i].ApplyStyle(VoidedStyle);
        }
      }
    }
  }

  protected void dvWorkingStatus_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
  {
    if (e.Exception == null)
    {
      gvWorkingStatus.DataBind();

      HFAccordionStatus.Value = "1";//控制accordion
    }
  }

  protected void dvWorkingStatus_DataBound(object sender, EventArgs e)
  {
    TextBox tmp = (TextBox)dvWorkingStatus.FindControl("txtLogDate");
    tmp.Text = System.DateTime.Now.ToShortDateString();
    Label lbl = (Label)dvWorkingStatus.FindControl("LabelCreateBy");
    lbl.Text = User.Identity.Name;
    Label date = (Label)dvWorkingStatus.FindControl("LabelCertificationDate");
    if (ddlWorkingStatusTarget.SelectedValue != "0")
    {
      int targetid = int.Parse(ddlWorkingStatusTarget.SelectedValue);
      QuotationModel.QuotationEntities dc = new QuotationModel.QuotationEntities();
      var result = (from t in dc.Quotation_Target
                    where t.Quotation_Target_Id == targetid
                    select new { t.certification_completed }).First().certification_completed;
      if (string.IsNullOrEmpty(result.ToString()))
      {
        date.Text = "N/A";
      }
      else
      {
        date.Text = result.Value.ToShortDateString();
      }
    }

  }

  protected void ddlworkingStatusTemplate_SelectedIndexChanged(object sender, EventArgs e)
  {
    DropDownList ddlTemplate = (DropDownList)sender;
    if (ddlTemplate.SelectedValue.ToString() != "")
    {
      TextBox txtContent = (TextBox)dvWorkingStatus.Rows[3].FindControl("txtLogContent");
      txtContent.Text += ddlTemplate.SelectedValue.ToString();
    }

    HFAccordionStatus.Value = "1";//控制accordion
  }

  protected void DropDownListEmp_DataBound(object sender, EventArgs e)
  {
    DropDownList ddlEmp = (DropDownList)sender;
    ddlEmp.Items.Insert(0, new ListItem()
    {
      Text = "Please select a CM...",
      Value = "0"
    });
  }

  protected void gvWorkingStatus_Sorting(object sender, GridViewSortEventArgs e)
  {
    HFAccordionStatus.Value = "1";//控制accordion
  }

  // Accordion 2

  protected void DetailsViewTarget_DataBound(object sender, EventArgs e)
  {
    //處理CM
    DropDownList ddlEmp = (DropDownList)DetailsViewTarget.FindControl("DropDownListEmp");
    TextBox txtCM = (TextBox)DetailsViewTarget.FindControl("TextBoxCM");
    if (ddlEmp != null)
    {
      ddlEmp.SelectedValue = txtCM.Text;
    }
    //處理Status
    TextBox txtStatus = (TextBox)DetailsViewTarget.FindControl("TextBoxStatus");
    DropDownList ddlStatus = (DropDownList)DetailsViewTarget.FindControl("ddlStatus");
    if (ddlStatus != null)
    {
      ddlStatus.SelectedValue = txtStatus.Text;
    }
  }

  protected void DetailsViewTarget_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
  {
    TextBox test_started = (TextBox)DetailsViewTarget.FindControl("TextBox3");
    TextBox test_completed = (TextBox)DetailsViewTarget.FindControl("TextBox4");
    TextBox certification_submit_to_authority = (TextBox)DetailsViewTarget.FindControl("TextBox5");
    TextBox certification_completed = (TextBox)DetailsViewTarget.FindControl("TextBox6");
    TextBox TextBox_Actual_Lead_time = (TextBox)DetailsViewTarget.FindControl("TextBox_Actual_Lead_time");
    TextBox textBoxEstimated = (TextBox)DetailsViewTarget.FindControl("TextBoxEstimated");
    TextBox txtProcess = (TextBox)DetailsViewTarget.FindControl("txtProcess"); //2013/5/6 新增需求

    decimal wk = 0;

    if (!string.IsNullOrEmpty(txtProcess.Text) && !string.IsNullOrEmpty(certification_completed.Text))
    {
      DateTime dt_txtProcess = DateTime.Parse(txtProcess.Text);
      DateTime dt_certification_completed = DateTime.Parse(certification_completed.Text);
      wk = Math.Ceiling(decimal.Parse(dt_certification_completed.Subtract(dt_txtProcess).Days.ToString()) / 7);
      TextBox_Actual_Lead_time.Text = wk.ToString();
    }
    SqlDataSourceModifyTarget.UpdateParameters["Actual_Lead_time"].DefaultValue = wk.ToString();

    DropDownList ddlEmp = (DropDownList)DetailsViewTarget.FindControl("DropDownListEmp");
    SqlDataSourceModifyTarget.UpdateParameters["Country_Manager"].DefaultValue = ddlEmp.SelectedValue;

    if (!string.IsNullOrEmpty(textBoxEstimated.Text))
    {
      // Actual > Estimated 則屬逾時
      if (int.Parse(wk.ToString()) > int.Parse(textBoxEstimated.Text))
      {
        SqlDataSourceModifyTarget.UpdateParameters["Status"].DefaultValue = "Delay";
      }
      else
      {
        DropDownList ddlStatus = (DropDownList)DetailsViewTarget.FindControl("ddlStatus");
        SqlDataSourceModifyTarget.UpdateParameters["Status"].DefaultValue = ddlStatus.SelectedValue;
      }
    }
    else
    {
      DropDownList ddlStatus = (DropDownList)DetailsViewTarget.FindControl("ddlStatus");
      SqlDataSourceModifyTarget.UpdateParameters["Status"].DefaultValue = ddlStatus.SelectedValue;
    }

    HFAccordionStatus.Value = "2";//控制accordion
  }

  protected void DetailsViewTarget_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
  {
    if (e.Exception == null)
    {
      Message.Text = "Target Details Update Successful!";      
    }
    else
    {
      Message.Text = e.Exception.Message;
    }
    HFAccordionStatus.Value = "2";
  }

  // Accordion 3
  protected void GridViewReport_PreRender(object sender, EventArgs e)
  {
    //int i = 1;
    //foreach (GridViewRow wkItem in GridViewReport.Rows)
    //{
    //  if (wkItem.RowIndex != 0)
    //  {
    //    GridViewReport.Rows[(wkItem.RowIndex - i)].Cells[12].RowSpan += 1;
    //    wkItem.Cells[12].Visible = false;
    //    i = i + 1;
    //  }
    //  else
    //  {
    //    wkItem.Cells[12].RowSpan = 1;
    //  }
    //}
  }

  protected void ButtonExcel_Click(object sender, EventArgs e)
  {
    if (GridViewReport.Rows.Count > 0)
    {
      GridViewReport.AllowPaging = false;
      GridViewReport.AllowSorting = false;
      GridViewReport.DataBind();

      ButtonExcel.Visible = false;
      HttpContext.Current.Response.Clear();
      HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
      HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename="
          + DateTime.Now.ToString("yyyyMMdd-mmhhss") + "WorkingStatus.xls");
      HttpContext.Current.Response.Charset = "utf-8";
      HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
      System.IO.StringWriter sw = new System.IO.StringWriter();
      HtmlTextWriter hw = new HtmlTextWriter(sw);
      PanelReport.RenderControl(hw);
      HttpContext.Current.Response.Write(sw.ToString());
      HttpContext.Current.Response.Flush();
      HttpContext.Current.Response.End();
      ButtonExcel.Visible = true;

    }    
  }

  public override void VerifyRenderingInServerForm(Control control)
  {

  }
  protected void BulletedListStatus_DataBound(object sender, EventArgs e)
  {
    BulletedList bullStatus = (BulletedList)sender;

    foreach (ListItem item in bullStatus.Items)
    {
      if (item.Value.ToLower() == "true")
      {
        item.Text = item.Text + " (Voided)";
        Style VoidedStyle = new Style();
        VoidedStyle.ForeColor = System.Drawing.Color.BurlyWood;
        VoidedStyle.Font.Strikeout = true;
        item.Attributes.Add("class", "td-linethrough");
        item.Attributes.Add("color", "red");
      }
    }
  }


  protected void gvWorkingStatus_RowEditing(object sender, GridViewEditEventArgs e)
  {
    HFAccordionStatus.Value = "1";//控制accordion
  }
  protected void GridViewReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
  {
    HFAccordionStatus.Value = "3";//控制accordion
  }
}