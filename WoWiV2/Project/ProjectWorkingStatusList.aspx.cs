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
          SqlDataSourceTarget.SelectCommand +=
            " AND ((SELECT fname FROM employee AS employee_1 WHERE (id = Quotation_Target.Country_Manager)) LIKE '%"
            + DropDownListCM.SelectedItem.Text + "%')";
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
    //protected void GridViewProjectTarget_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //  if (e.Row.RowType==DataControlRowType.DataRow)
    //  {
    //    Label LabelTarget = (Label)e.Row.FindControl("LabelTarget");
    //    Label LabelNo = (Label)e.Row.FindControl("LabelNo");
    //    HiddenField HFCountry = (HiddenField)e.Row.FindControl("HFCountry");

    //    LinkButton LB = (LinkButton)e.Row.FindControl("LBSetting");
    //    LB.PostBackUrl = "~/Project/ProjectWorkingStatus.aspx?ProjectNO=" + LabelNo.Text
    //      + "&CountryID=" + HFCountry.Value
    //      + "&TargetID=" + LabelTarget.Text;
    //  }
    //}
}