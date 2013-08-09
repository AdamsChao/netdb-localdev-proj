using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailQ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindItem();
            LoadData();
            SetKW();
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
        lblTitle.Text = "Accredited Test Lab Detail";
        string strID = Request["atid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_AccreditedTestLab where AccreditedTestID=@AccreditedTestID";
            cmd.Parameters.AddWithValue("@AccreditedTestID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblAccreditedLab.Text = dt.Rows[0]["AccreditedLab"].ToString();
                lblVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                lblPublish.Text = dt.Rows[0]["Publish"].ToString();
                if (dt.Rows[0]["Website"].ToString().Trim().Length > 0) { lblWebsite.Text = "<br>Website：" + dt.Rows[0]["Website"].ToString(); }
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                if (dt.Rows[0]["RFRemark"].ToString().Trim().Length > 0) { lblRFRemark.Text = "Remark：" + dt.Rows[0]["RFRemark"].ToString(); }
                if (dt.Rows[0]["EMCRemark"].ToString().Trim().Length > 0) { lblEMCRemark.Text = "Remark：" + dt.Rows[0]["EMCRemark"].ToString(); }
                if (dt.Rows[0]["SafetyRemark"].ToString().Trim().Length > 0) { lblSafetyRemark.Text = "Remark：" + dt.Rows[0]["SafetyRemark"].ToString(); }
                if (dt.Rows[0]["TelecomRemark"].ToString().Trim().Length > 0) { lblTelecomRemark.Text = "Remark：" + dt.Rows[0]["TelecomRemark"].ToString(); }
                if (dt.Rows[0]["LeadTime"].ToString().Trim().Length > 0) { lblLeadT.Text = dt.Rows[0]["LeadTime"].ToString() + "&nbsp;Weeks"; }
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                trProductType.Visible = true;
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