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
        employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
        ddlClient.DataSource = CodeTableController.GetClientApplicantList(emp.id);
        ddlClient.DataTextField = "Value";
        ddlClient.DataValueField = "Key";
        ddlClient.DataBind();
    }

    protected void ButtonSearch_Click(object sender, EventArgs e)
    {
        SqlDataSourceQuot.SelectParameters.Clear();

        string mySQLstr = "";
        if (ddlClient.SelectedValue != "")
        {
            SqlDataSourceQuot.SelectParameters.Add("Client_Id", ddlClient.SelectedValue);
            mySQLstr = " AND Client_Id=@Client_Id ";
        }
        if (ddlEmp.SelectedValue != "")
        {
            SqlDataSourceQuot.SelectParameters.Add("SalesId", ddlEmp.SelectedValue);
            mySQLstr = " AND SalesId=@SalesId ";
        }
        if (txtProductName.Text != "")
        {
            SqlDataSourceQuot.SelectParameters.Add("Product_Name", txtProductName.Text);
            mySQLstr = " AND ([Product_Name] LIKE '%' + @Product_Name + '%')";
        }
        if (txtModelNo.Text != "")
        {
            SqlDataSourceQuot.SelectParameters.Add("Model_No", txtModelNo.Text);
            mySQLstr = " AND ([Model_No] LIKE '%' + @Model_No + '%')";
        }


        SqlDataSourceQuot.SelectCommand = "SELECT * FROM [vw_Quotation] WHERE 1=1 " + mySQLstr;
        GridViewQuotation.DataBind();
    }
    protected void ddlClient_DataBound(object sender, EventArgs e)
    {
        ddlClient.Items.Insert(0, new ListItem("--select--", ""));
    }
    protected void ddlEmp_DataBound(object sender, EventArgs e)
    {
        ddlEmp.Items.Insert(0, new ListItem("--select--", ""));
    }
}