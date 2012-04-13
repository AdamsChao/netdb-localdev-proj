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
    }

    protected void DetailsViewTarget_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (e.Exception==null)
        { 
            GridViewProjectTarget.DataBind();
            DetailsViewTarget.DataBind();
            Message.Text = "";
        }
        else
        {               
            Message.Text = e.Exception.Message;
        }
    }

    
    //protected void GridViewProjectTarget_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    //{
    //    TextBox cm = (TextBox)DetailsViewTarget.FindControl("TextBoxCM");
    //    DropDownList ddl = (DropDownList)DetailsViewTarget.FindControl("DropDownListEmp");        
    //    Response.Write("xxx" + cm.Text);
    //    if (!string.IsNullOrEmpty(cm.Text))
    //    {
    //        ddl.SelectedValue = "5";
    //        //ddl.DataBind();
    //    }
    //}
    //protected void DetailsViewTarget_DataBound(object sender, EventArgs e)
    //{
    //    Label lblCM =  (Label)GridViewProjectTarget.SelectedRow.FindControl("LabelCM");
    //    DropDownList ddl = (DropDownList)DetailsViewTarget.FindControl("DropDownListEmp");
    //    if (!string.IsNullOrEmpty(lblCM.Text))
    //    {
    //        ddl.SelectedValue = lblCM.Text;
    //    }
    //}
}