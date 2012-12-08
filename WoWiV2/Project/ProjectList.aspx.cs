using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Project_ProjectList : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      if (User.Identity.Name == "Shirley" || User.Identity.Name == "Scott")
      {
        GridViewProject.Columns[0].Visible = true;
      }
    }

  }
  protected void btnSearch_Click(object sender, EventArgs e)
  {
    try
    {
      //SqlDataSourceProject.SelectParameters.Clear();
      //SqlDataSourceProject.SelectCommand = SqlDataSourceProject.SelectCommand
      //    + " Where Quotation_Version.Client_Id=@clientID and Quotation_Version.Model_Difference like @Desc";

      //SqlDataSourceProject.SelectCommand = SqlDataSourceProject.SelectCommand
      //     + " Where Quotation_Version.Client_Id=" + DropDownListClient.SelectedValue
      //     + " and Quotation_Version.Model_Difference like '%" + TextBoxDesc.Text + "%'";    

      //SqlDataSourceProject.SelectParameters.Add("@clientID", DropDownListClient.SelectedValue);
      //SqlDataSourceProject.SelectParameters.Add("@Desc","%" + TextBoxDesc.Text + "%");
      //SqlDataSourceProject.Select(
    }
    catch (Exception ex)
    {
      Message.Text = ex.Message;
    }


  }
  protected void GridViewProject_RowUpdated(object sender, GridViewUpdatedEventArgs e)
  {
    if (e.Exception != null)
    {
      Message.Text = e.Exception.Message + " , Please try again!";
      e.ExceptionHandled = true;
      e.KeepInEditMode = true;
    }
    else
    {
      Message.Text = "Project Update Successful!";
    }
  }
}