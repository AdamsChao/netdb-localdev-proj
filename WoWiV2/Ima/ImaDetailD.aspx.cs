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
            BindItem();
            LoadData();
        }
    }

    //載入選項
    protected void BindItem()
    {
        ////載入幣別
        //string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        //if (strFeeUnit != "") { ddlFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Certification bodies Detail";
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
                rblAccreditedTest.SelectedValue = dt.Rows[0]["AccreditedTest"].ToString();
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
                lblRFRemark.Text = dt.Rows[0]["RFRemark"].ToString();
                lblEMCRemark.Text = dt.Rows[0]["EMCRemark"].ToString();
                lblSafetyRemark.Text = dt.Rows[0]["SafetyRemark"].ToString();
                lblTelecomRemark.Text = dt.Rows[0]["TelecomRemark"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Certification bodies Copy";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }

            //Technology
            cmd = new SqlCommand();
            cmd.CommandText = "select count(DID) from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            int intCount = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));            
            if (intCount > 0)
            {
                if (lblProTypeName.Text.Trim() == "RF") { trTechRF.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "EMC") { trTechEMC.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "Safety") { trTechSafety.Visible = true; }
                else { trTechTelecom.Visible = true; }
            }
        }
    }
}