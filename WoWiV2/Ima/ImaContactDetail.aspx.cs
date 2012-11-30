using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaContactDetail : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //設定業務人員不可進入編輯Page
            imau.CheckIsSales();
            BindItem();
            LoadData();
        }
    }

    //載入選項
    protected void BindItem()
    {
        
    }

    //取得General資料
    protected void LoadData()
    {
        //Ima_Contact   

        SqlCommand cmd = new SqlCommand("select * from Ima_Contact where ContactID=@ContactID");
        cmd.Parameters.AddWithValue("@ContactID", Request["ContactID"]);
        DataSet ds = SQLUtil.QueryDS(cmd);
        DataTable dtContact = ds.Tables[0];
        if (dtContact.Rows.Count > 0)
        {
            lblFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
            lblLastName.Text = dtContact.Rows[0]["LastName"].ToString();
            lblTitle.Text = dtContact.Rows[0]["Title"].ToString();
            lblWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
            lblFax.Text = dtContact.Rows[0]["Fax"].ToString();
            lblExt.Text = dtContact.Rows[0]["Ext"].ToString();
            lblCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
            lblEmail.Text = dtContact.Rows[0]["Email"].ToString();
            lblAdress.Text = dtContact.Rows[0]["Adress"].ToString();
            ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
            lblLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            lblRemark.Text = dtContact.Rows[0]["Remark"].ToString();
        }
    }
}