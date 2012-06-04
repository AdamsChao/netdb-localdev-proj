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
            SetKW();
        }
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
                if (Convert.ToInt32(dt.Rows[0]["Authority"]) == 1) { lblAuthority.Text = "Yes"; }
                else { lblAuthority.Text = "No"; }
                lblAccreditedTest.Text = dt.Rows[0]["AccreditedTest"].ToString();
                if (Convert.ToInt32(dt.Rows[0]["CertificationBody"]) == 1) { lblCB.Text = "Yes"; }
                else { lblCB.Text = "No"; }
                lblVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                if (Convert.ToInt32(dt.Rows[0]["Publish"]) == 1) { lblPublish.Text = "Yes"; }
                else { lblPublish.Text = "No"; }
                lblAccredidedLab.Text = dt.Rows[0]["AccredidedLab"].ToString();
                lblVolumePerYear1.Text = dt.Rows[0]["VolumePerYear1"].ToString();
                if (dt.Rows[0]["Website"].ToString().Trim().Length > 0) { lblWebsite.Text = "<br>Website：" + dt.Rows[0]["Website"].ToString(); }
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                if (dt.Rows[0]["RFRemark"].ToString().Trim().Length > 0) { lblRFRemark.Text = "Remark：" + dt.Rows[0]["RFRemark"].ToString(); }
                if (dt.Rows[0]["EMCRemark"].ToString().Trim().Length > 0) { lblEMCRemark.Text = "Remark：" + dt.Rows[0]["EMCRemark"].ToString(); }
                if (dt.Rows[0]["SafetyRemark"].ToString().Trim().Length > 0) { lblSafetyRemark.Text = "Remark：" + dt.Rows[0]["SafetyRemark"].ToString(); }
                if (dt.Rows[0]["TelecomRemark"].ToString().Trim().Length > 0) { lblTelecomRemark.Text = "Remark：" + dt.Rows[0]["TelecomRemark"].ToString(); }
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

    //替換關鍵字查詢的顏色
    protected void SetKW()
    {
        new IMAUtil().RepKW(this.Form.Controls);
    }

    //Contact 替換關鍵字查詢的顏色
    protected void dlContact_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            new IMAUtil().RepKW(e.Item.Controls);
        }
    }
}