using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Periodic Factory inspection Detail";
        string strID = Request["pfiid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Periodic where PeriodicID=@PeriodicID";
            cmd.Parameters.AddWithValue("@PeriodicID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblFactoryInspection.SelectedValue = dt.Rows[0]["FactoryInspection"].ToString();
                lblYear.Text = dt.Rows[0]["Year"].ToString();
                lblMonth.Text = dt.Rows[0]["Month"].ToString();
                lblPeriodicDesc.Text = dt.Rows[0]["PeriodicDesc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
        }
    }
}