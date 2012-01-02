using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaB : System.Web.UI.Page
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
        string strID = Request["gaid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID";
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblFullAuthorityName.Text = dt.Rows[0]["FullAuthorityName"].ToString();
                lblAbbreviatedAuthorityName.Text = dt.Rows[0]["AbbreviatedAuthorityName"].ToString();
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblMandatory.Text = dt.Rows[0]["Mandatory"].ToString();
                rblCertificateValid.SelectedValue = dt.Rows[0]["CertificateValid"].ToString();
                rblTransfer.SelectedValue = Convert.ToInt32(dt.Rows[0]["IsTransfer"]).ToString();
                lblDescription.Text = dt.Rows[0]["Description"].ToString();                
                trProductType.Visible = true;
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(dt.Rows[0]["wowi_product_type_id"].ToString());
            }
        }
    }
}