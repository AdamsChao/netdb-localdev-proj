using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Project_ProjectWorkingStatusList : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
      if (Page.IsPostBack)
      {
        if (DropDownListCM.SelectedValue != "0")
        {
          //SqlDataSourceTarget.SelectCommand +=
          //  " AND ((SELECT fname FROM employee AS employee_1 WHERE (id = Quotation_Target.Country_Manager)) LIKE '%"
          //  + DropDownListCM.SelectedItem.Text + "%')";
          SqlDataSourceTarget.SelectCommand +=
            " AND (Quotation_Target.Country_Manager LIKE " + DropDownListCM.SelectedValue + ")";
        }

        if (DropDownListRegion.SelectedValue != "0")
        {
          SqlDataSourceTarget.SelectCommand +=
            " AND (world_region_name LIKE '%" + DropDownListRegion.SelectedItem.Text + "%')";
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
        if (string.IsNullOrEmpty(e.Row.Cells[10].Text) || e.Row.Cells[10].Text == "&nbsp;")
          e.Row.Cells[10].Text = "N/A";
        if (string.IsNullOrEmpty(e.Row.Cells[11].Text) || e.Row.Cells[11].Text == "&nbsp;")
          e.Row.Cells[11].Text = "N/A";
        if (string.IsNullOrEmpty(e.Row.Cells[12].Text) || e.Row.Cells[12].Text == "&nbsp;")
          e.Row.Cells[12].Text = "N/A";
        if (string.IsNullOrEmpty(e.Row.Cells[13].Text) || e.Row.Cells[13].Text == "&nbsp;")
          e.Row.Cells[13].Text = "N/A";       
        //Label LabelTarget = (Label)e.Row.FindControl("LabelTarget");
        //Label LabelNo = (Label)e.Row.FindControl("LabelNo");
        //HiddenField HFCountry = (HiddenField)e.Row.FindControl("HFCountry");

        //LinkButton LB = (LinkButton)e.Row.FindControl("LBSetting");
        //LB.PostBackUrl = "~/Project/ProjectWorkingStatus.aspx?ProjectNO=" + LabelNo.Text
        //  + "&CountryID=" + HFCountry.Value
        //  + "&TargetID=" + LabelTarget.Text;
      }
    }
}