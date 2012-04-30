using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Project_ProjectTargetList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }

    protected void DetailsViewTarget_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        TextBox test_started = (TextBox)DetailsViewTarget.FindControl("TextBox3");
        TextBox test_completed = (TextBox)DetailsViewTarget.FindControl("TextBox4");
        TextBox certification_submit_to_authority = (TextBox)DetailsViewTarget.FindControl("TextBox5");
        TextBox certification_completed = (TextBox)DetailsViewTarget.FindControl("TextBox6");
        TextBox TextBox_Actual_Lead_time = (TextBox)DetailsViewTarget.FindControl("TextBox_Actual_Lead_time");
        TextBox textBoxEstimated = (TextBox)DetailsViewTarget.FindControl("TextBoxEstimated");

        decimal wk = 0;
        if (!string.IsNullOrEmpty(test_started.Text) && !string.IsNullOrEmpty(certification_completed.Text))
        {
            DateTime dt_test_started = DateTime.Parse(test_started.Text);
            DateTime dt_certification_completed = DateTime.Parse(certification_completed.Text);            
            wk = Math.Ceiling(decimal.Parse(dt_certification_completed.Subtract(dt_test_started).Days.ToString()) / 7);
            TextBox_Actual_Lead_time.Text = wk.ToString();
        }
        else if (!string.IsNullOrEmpty(test_started.Text) && !string.IsNullOrEmpty(test_completed.Text))
        {
            DateTime dt_test_started = DateTime.Parse(test_started.Text);
            DateTime dt_test_completed = DateTime.Parse(test_completed.Text);            
            wk = Math.Ceiling(decimal.Parse(dt_test_completed.Subtract(dt_test_started).Days.ToString()) / 7);
            TextBox_Actual_Lead_time.Text = wk.ToString();            
        }
        else if (!string.IsNullOrEmpty(certification_submit_to_authority.Text) && !string.IsNullOrEmpty(certification_completed.Text))
        {
            DateTime dt_certification_submit_to_authority = DateTime.Parse(certification_submit_to_authority.Text);
            DateTime dt_certification_completed = DateTime.Parse(certification_completed.Text);
            wk = Math.Ceiling(decimal.Parse(dt_certification_completed.Subtract(dt_certification_submit_to_authority).Days.ToString()) / 7);
            TextBox_Actual_Lead_time.Text = wk.ToString();   
        }
        SqlDataSourceModifyTarget.UpdateParameters["Actual_Lead_time"].DefaultValue = wk.ToString();        

        DropDownList ddlAgent = (DropDownList)DetailsViewTarget.FindControl("DropDownListAgent");
        SqlDataSourceModifyTarget.UpdateParameters["Agent"].DefaultValue = ddlAgent.SelectedValue;   

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
    }

    protected void DetailsViewTarget_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (e.Exception==null)
        { 
            GridViewProjectTarget.DataBind();            
            Message.Text = "Target Details Update Successful!";
        }
        else
        {               
            Message.Text = e.Exception.Message;
        }
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
    protected void DropDownListAgent_DataBound(object sender, EventArgs e)
    {
      DropDownList ddlAgent = (DropDownList)sender;
      ddlAgent.Items.Insert(0, new ListItem()
      {
        Text = "Please select a Agent...",
        Value = "0"
      });
    }
    protected void DetailsViewTarget_DataBound(object sender, EventArgs e)
    {      
      //處理CM
      DropDownList ddlEmp = (DropDownList)DetailsViewTarget.FindControl("DropDownListEmp");
      TextBox txtCM = (TextBox)DetailsViewTarget.FindControl("TextBoxCM");
      if (ddlEmp != null)
      {
        ddlEmp.SelectedValue = txtCM.Text;
      }
      //處理Agent(Vender)
      TextBox txtAgent = (TextBox)DetailsViewTarget.FindControl("TextBoxAgent");
      DropDownList ddlAgent = (DropDownList)DetailsViewTarget.FindControl("DropDownListAgent");
      if (ddlAgent != null)
      {
        ddlAgent.SelectedValue = txtAgent.Text;
      }

      //處理Status
      TextBox txtStatus = (TextBox)DetailsViewTarget.FindControl("TextBoxStatus");
      DropDownList ddlStatus = (DropDownList)DetailsViewTarget.FindControl("ddlStatus");
      if (ddlStatus != null)
      {
        ddlStatus.SelectedValue = txtStatus.Text;
      }
    }

    protected void LinkButtonTop_Click(object sender, EventArgs e)
    {
      Response.Redirect("~/Project/ProjectWorkingStatus.aspx?ProjectNo="
        + DropDownList1.SelectedItem.Text);
    }
}