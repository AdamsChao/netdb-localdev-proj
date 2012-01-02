using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaGeneralDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetGeneralData();
        }
    }

    //取得General資料
    protected void GetGeneralData()
    {
        string strGeneralID = Request["gid"];
        if (strGeneralID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_General where GeneralID=@GeneralID";
            cmd.Parameters.AddWithValue("@GeneralID", strGeneralID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblVoltage.Text = dt.Rows[0]["Voltage"].ToString();
                lblFrequency.Text = dt.Rows[0]["Frequency"].ToString();
                lblPlugType.Text = dt.Rows[0]["Plug_Type"].ToString();
                lblCurrency_Code.Text = dt.Rows[0]["Currency_Code"].ToString();
                lblExchange_rate_USD.Text = dt.Rows[0]["Exchange_rate_USD"].ToString();
                lblExchange_rate_EUR.Text = dt.Rows[0]["Exchange_rate_EUR"].ToString();
                lblCountry_Code.Text = dt.Rows[0]["Country_Code"].ToString();
                lblCulture_Taboos.Text = dt.Rows[0]["Culture_Taboos"].ToString();
                lblTitle.Text = IMAUtil.GetCountryName(Request.Params["cid"]) + " General Detail";
            }
        }
    }
}