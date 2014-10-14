using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;

public partial class Sales_Quotation : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
      ddlClient.DataSource = CodeTableController.GetClientApplicantList(emp.id);
      ddlClient.DataTextField = "Value";
      ddlClient.DataValueField = "Key";
      ddlClient.DataBind();
      txtCurrentEmployee_id.Text = emp.id.ToString();

      //Delete function
      if (User.Identity.Name == "Shirley" || User.Identity.Name == "Scott")
      {
        GridViewQuotation.Columns[0].Visible = true;
      }
    }
  }

  protected void ButtonSearch_Click(object sender, EventArgs e)
  {
    if (!string.IsNullOrEmpty(txtCountry.Text))
    {
      SqlDataSourceQuot.SelectCommand = "SELECT vw_Quotation.Quotation_Version_Id, vw_Quotation.Quotation_No, vw_Quotation.Vername,vw_Quotation.Quotation_Status_Name, vw_Quotation.code, vw_Quotation.companyname, vw_Quotation.Product_Name, vw_Quotation.Model_No, vw_Quotation.username, vw_Quotation.Quotation_OpenDate, vw_Quotation.Client_Id, vw_Quotation.fname, vw_Quotation.SalesId , quotation_country FROM vw_Quotation LEFT OUTER JOIN m_employee_accesslevel ON vw_Quotation.Access_Level_ID = m_employee_accesslevel.accesslevel_id WHERE ((m_employee_accesslevel.employee_id = @employee_id) OR (vw_Quotation.Access_Level_ID IS NULL)) AND Client_Id like @Client_Id AND SalesId like @SalesId AND ([Product_Name] LIKE '%' + @Product_Name + '%') AND ([Model_No] LIKE '%' + @Model_No + '%') AND vw_Quotation.Quotation_Version_Id in (Select quotation_id from Quotation_Target,Country Where Quotation_Target.country_id = dbo.country.country_id and country_name like '%' + @quotation_country + '%') ORDER BY vw_Quotation.Quotation_No DESC, vw_Quotation.Vername, vw_Quotation.Model_No ";      
    }
    
    //SqlDataSourceQuot.SelectParameters.Clear();
    //SqlDataSourceQuot.SelectParameters.Add("employee_id", txtCurrentEmployee_id.Text);

    //string mySQLstr = "";
    //if (ddlClient.SelectedValue != "")
    //{
    //  SqlDataSourceQuot.SelectParameters.Add("Client_Id", ddlClient.SelectedValue);
    //  mySQLstr = " AND Client_Id=@Client_Id ";
    //}
    //if (ddlEmp.SelectedValue != "")
    //{
    //  SqlDataSourceQuot.SelectParameters.Add("SalesId", ddlEmp.SelectedValue);
    //  mySQLstr = " AND SalesId=@SalesId ";
    //}
    //if (txtProductName.Text != "")
    //{
    //  SqlDataSourceQuot.SelectParameters.Add("Product_Name", txtProductName.Text);
    //  mySQLstr = " AND ([Product_Name] LIKE '%' + @Product_Name + '%')";
    //}
    //if (txtModelNo.Text != "")
    //{
    //  SqlDataSourceQuot.SelectParameters.Add("Model_No", txtModelNo.Text);
    //  mySQLstr = " AND ([Model_No] LIKE '%' + @Model_No + '%')";
    //}


    //SqlDataSourceQuot.SelectCommand = "SELECT * FROM [vw_Quotation] WHERE 1=1 " + mySQLstr +
    //    " ORDER BY  vw_Quotation.Quotation_No DESC, vw_Quotation.Vername, vw_Quotation.Model_No ";
    //SqlDataSourceQuot.Select(DataSourceSelectArguments.Empty);
    //GridViewQuotation.DataBind();
  }
  protected void ddlClient_DataBound(object sender, EventArgs e)
  {
    ddlClient.Items.Insert(0, new ListItem("- All -", "%"));
  }
  protected void ddlEmp_DataBound(object sender, EventArgs e)
  {
    ddlEmp.Items.Insert(0, new ListItem("- All -", "%"));
  }
  protected void GridViewQuotation_PageIndexChanging(object sender, GridViewPageEventArgs e)
  {
    if (!string.IsNullOrEmpty(txtCountry.Text))
    {
      SqlDataSourceQuot.SelectCommand = "SELECT vw_Quotation.Quotation_Version_Id, vw_Quotation.Quotation_No, vw_Quotation.Vername,vw_Quotation.Quotation_Status_Name, vw_Quotation.code, vw_Quotation.companyname, vw_Quotation.Product_Name, vw_Quotation.Model_No, vw_Quotation.username, vw_Quotation.Quotation_OpenDate, vw_Quotation.Client_Id, vw_Quotation.fname, vw_Quotation.SalesId , quotation_country FROM vw_Quotation LEFT OUTER JOIN m_employee_accesslevel ON vw_Quotation.Access_Level_ID = m_employee_accesslevel.accesslevel_id WHERE ((m_employee_accesslevel.employee_id = @employee_id) OR (vw_Quotation.Access_Level_ID IS NULL)) AND Client_Id like @Client_Id AND SalesId like @SalesId AND ([Product_Name] LIKE '%' + @Product_Name + '%') AND ([Model_No] LIKE '%' + @Model_No + '%') AND vw_Quotation.Quotation_Version_Id in (Select quotation_id from Quotation_Target,Country Where Quotation_Target.country_id = dbo.country.country_id and country_name like '%' + @quotation_country + '%') ORDER BY vw_Quotation.Quotation_No DESC, vw_Quotation.Vername, vw_Quotation.Model_No ";
    }
  }
}