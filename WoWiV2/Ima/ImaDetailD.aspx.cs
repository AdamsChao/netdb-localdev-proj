using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailD : System.Web.UI.Page
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
        lblTitle.Text = "Certification bodies and websites Detail";
        string strID = Request["cbwid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_CertificationBodies where CertificationBodiesID=@CertificationBodiesID";
            cmd.Parameters.AddWithValue("@CertificationBodiesID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblName.Text = dt.Rows[0]["Name"].ToString();
                rblAuthority.SelectedValue = Convert.ToInt32(dt.Rows[0]["Authority"]).ToString();
                rblCB.SelectedValue = Convert.ToInt32(dt.Rows[0]["CertificationBody"]).ToString();
                lblVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                rblPublish.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish"]).ToString();
                lblAccredidedLab.Text = dt.Rows[0]["AccredidedLab"].ToString();
                lblVolumePerYear1.Text = dt.Rows[0]["VolumePerYear1"].ToString();
                rblPublish1.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish1"]).ToString();
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblWebsite1.Text = dt.Rows[0]["Website1"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Certification bodies and websites Copy";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
        }
    }
}