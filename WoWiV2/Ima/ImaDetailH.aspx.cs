using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailH : System.Web.UI.Page
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
        lblTitle.Text = "Standards Detail";
        string strID = Request["sid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;   
        lblFCCTitle.Text = "";
        lblRequiredTitle.Text = "";
        cbFCC.Visible = false;
        cbIEC.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Standard where StandardID=@StandardID";
            cmd.Parameters.AddWithValue("@StandardID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblRequired.Text = dt.Rows[0]["Required"].ToString();
                lblStandardDesc.Text = dt.Rows[0]["StandardDesc"].ToString();
                lblLocalStandards.Text = dt.Rows[0]["LocalStandards"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                rblProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (lblProTypeName.Text.Trim() != "Safety")
                {
                    lblFCCTitle.Text = "Harmonized with FCC or CE";
                    cbFCC.Visible = true;
                    lblRequiredTitle.Text = "Safety Required";
                }
                else
                {
                    lblFCCTitle.Text = "Harmonized with IEC or CE";
                    cbIEC.Visible = true;
                    lblRequiredTitle.Text = "EMC Required";
                }

                if (Convert.ToBoolean(dt.Rows[0]["FCC"]) && cbFCC.Visible) { lblFCCorIECorCE.Text = "FCC"; }
                else if (Convert.ToBoolean(dt.Rows[0]["FCC"]) && cbIEC.Visible) { lblFCCorIECorCE.Text = "IEC"; }

                if (Convert.ToBoolean(dt.Rows[0]["CE"]) && lblFCCorIECorCE.Text.Trim().Length == 0) { lblFCCorIECorCE.Text = "CE"; }
                else if (Convert.ToBoolean(dt.Rows[0]["CE"]) && lblFCCorIECorCE.Text.Trim().Length > 0) { lblFCCorIECorCE.Text += "；CE"; }

                cbFCC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbIEC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbCE.Checked = Convert.ToBoolean(dt.Rows[0]["CE"]);

                if (dt.Rows[0]["Others"].ToString().Trim().Length > 0 && lblFCCorIECorCE.Text.Trim().Length > 0) { lblOthers.Text = "<br>Others：" + dt.Rows[0]["Others"].ToString(); }
                else if (dt.Rows[0]["Others"].ToString().Trim().Length > 0 && lblFCCorIECorCE.Text.Trim().Length == 0) { lblOthers.Text = "Others：" + dt.Rows[0]["Others"].ToString(); }

                if (dt.Rows[0]["RFRemark"].ToString().Trim().Length > 0) { lblRFRemark.Text = "Remark：" + dt.Rows[0]["RFRemark"].ToString(); }
                if (dt.Rows[0]["EMCRemark"].ToString().Trim().Length > 0) { lblEMCRemark.Text = "Remark：" + dt.Rows[0]["EMCRemark"].ToString(); }
                if (dt.Rows[0]["SafetyRemark"].ToString().Trim().Length > 0) { lblSafetyRemark.Text = "Remark：" + dt.Rows[0]["SafetyRemark"].ToString(); }
                if (dt.Rows[0]["TelecomRemark"].ToString().Trim().Length > 0) { lblTelecomRemark.Text = "Remark：" + dt.Rows[0]["TelecomRemark"].ToString(); }
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Standards Detail";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
            //Technology
            cmd = new SqlCommand();
            cmd.CommandText = "select count(DID) from Ima_Tech where DID=@DID and Categroy=@Categroy";
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
        else
        {
            lblProTypeName.Text = IMAUtil.GetProductType(Request.Params["pt"]);
        }

        cbFCC.Visible = false;
        cbIEC.Visible = false;
        cbCE.Visible = false;
        //if (lblProTypeName.Text.Trim() != "Safety")
        //{
        //    lblFCCTitle.Text = "Harmonized with FCC or CE";
        //    cbFCC.Visible = true;
        //    lblRequiredTitle.Text = "Safety Required";
        //}
        //else
        //{
        //    lblFCCTitle.Text = "Harmonized with IEC or CE";
        //    cbIEC.Visible = true;
        //    lblRequiredTitle.Text = "EMC Required";
        //}

    }
}