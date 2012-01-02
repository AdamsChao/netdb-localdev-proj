using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailG : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    //取得資料
    protected void LoadData()
    {
        lblTitle.Text = "Products Control Detail";
        string strID = Request["fid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_ProductsControl where ProductControlID=@ProductControlID";
            cmd.Parameters.AddWithValue("@ProductControlID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)            {
                lblControlList.Text = dt.Rows[0]["ControlList"].ToString();                
                trProductType.Visible = true;
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(dt.Rows[0]["wowi_product_type_id"].ToString());
            }
        }
    }
}