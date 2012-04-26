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
      if (Request["ProjectNO"] !=null)
      {
        lblProject.Text = Request["ProjectNO"].ToString();
      }
      if (Request["CountryID"] != null)
      {
        lblCountry.Text = Request["CountryID"].ToString();
      }
      if (Request["TargetID"] != null)
      {
        lblTarget.Text = Request["TargetID"].ToString();
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
        foreach (ListItem item in ddlWorkingStatusProject.Items)
        {
          if (item.Text == lblProject.Text)
          {
            item.Selected = true;
          }
        }
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

        foreach (ListItem item in ddlWorkingStatusCountry.Items)
        {
          if (item.Value == lblCountry.Text)
          {
            item.Selected = true;
          }
        }
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
        foreach (ListItem item in ddlWorkingStatusTarget.Items)
        {
          if (item.Value == lblTarget.Text)
          {
            item.Selected = true;
            dvWorkingStatus.Visible = true;
          }
        }
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
    }

    protected void ddlworkingStatusTemplate1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlTemplate = (DropDownList)dvWorkingStatus.Rows[3].FindControl("ddlWorkingStatusTemplate1");

        if (ddlTemplate.SelectedValue.ToString() != "")
        {
            TextBox txtContent = (TextBox)dvWorkingStatus.Rows[3].FindControl("txtLogContent");
            txtContent.Text += ddlTemplate.SelectedValue.ToString();
        }
    }

    protected void ddlworkingStatusTemplate2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlTemplate = (DropDownList)dvWorkingStatus.Rows[3].FindControl("ddlWorkingStatusTemplate2");

        if (ddlTemplate.SelectedValue.ToString() != "")
        {
            TextBox txtContent = (TextBox)dvWorkingStatus.Rows[3].FindControl("txtLogContent");
            txtContent.Text += ddlTemplate.SelectedValue.ToString();
        }
    }

    protected void ddlworkingStatusTemplate3_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlTemplate = (DropDownList)dvWorkingStatus.Rows[3].FindControl("ddlWorkingStatusTemplate3");

        if (ddlTemplate.SelectedValue.ToString() != "")
        {
            TextBox txtContent = (TextBox)dvWorkingStatus.Rows[3].FindControl("txtLogContent");
            txtContent.Text += ddlTemplate.SelectedValue.ToString();
        }
    }

    protected void ddlworkingStatusTemplate4_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddlTemplate = (DropDownList)dvWorkingStatus.Rows[3].FindControl("ddlWorkingStatusTemplate4");

        if (ddlTemplate.SelectedValue.ToString() != "")
        {
            TextBox txtContent = (TextBox)dvWorkingStatus.Rows[3].FindControl("txtLogContent");
            txtContent.Text += ddlTemplate.SelectedValue.ToString();
        }
    }
}