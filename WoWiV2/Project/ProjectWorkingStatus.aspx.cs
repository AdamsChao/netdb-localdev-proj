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
    }
    protected void ddlWorkingStatusProject_SelectedIndexChanged(object sender, EventArgs e)
    {      
        ddlWorkingStatusCountry.DataBind();
        ddlWorkingStatusTarget.DataBind();
        gvWorkingStatus.EditIndex = -1;
        gvWorkingStatus.DataBind();
        dvWorkingStatus.Visible = false;
    }
    protected void ddlWorkingStatusProject_DataBound(object sender, EventArgs e)
    {
        ddlWorkingStatusProject.Items.Insert(0, new ListItem()
        {
            Text = "Please select a project...",
            Value = "0"
        });       
    }
    protected void ddlWorkingStatusCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvWorkingStatus.EditIndex = -1;
        dvWorkingStatus.Visible = false;
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
        if (ddlWorkingStatusTarget.SelectedValue.ToString() == "0")
        {
            dvWorkingStatus.Visible = false;
        }
        else
        {
            dvWorkingStatus.Visible = true;
        }

        gvWorkingStatus.EditIndex = -1;
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
        }
    }
    protected void dvWorkingStatus_DataBound(object sender, EventArgs e)
    {
        TextBox tmp = (TextBox)dvWorkingStatus.FindControl("txtLogDate");
        tmp.Text = System.DateTime.Now.ToShortDateString();
        Label lbl = (Label)dvWorkingStatus.FindControl("LabelCreateBy");
        lbl.Text = User.Identity.Name;
        Label date = (Label)dvWorkingStatus.FindControl("LabelCertificationDate");
        if (ddlWorkingStatusTarget.SelectedValue != "0" )
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
    }
}