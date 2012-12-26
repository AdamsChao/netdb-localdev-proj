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

  QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
  WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

  protected void GridViewProject_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    //針對AE Sales去控管報價單的檢視權
    HiddenField hidQuotation = (HiddenField)e.Row.FindControl("HidQuotationId");
    if (hidQuotation!=null)
    {
      int qid = int.Parse(hidQuotation.Value);
      var quo = (from q in db.Quotation_Version
                 where q.Quotation_Version_Id == qid
                 select q).First();
      var user = wowidb.employees.Where(emp => emp.username == User.Identity.Name).First();
      var access = wowidb.m_employee_accesslevel.Where(a => a.employee_id == user.id);
      var isaccess = access.Where(a => a.accesslevel_id == quo.Access_Level_ID);
      if (isaccess.Count() == 0)
      {
        HyperLink link = (HyperLink)e.Row.FindControl("LinkQuotation");
        link.NavigateUrl = string.Empty;
      }    
    }
    
   
  }
}