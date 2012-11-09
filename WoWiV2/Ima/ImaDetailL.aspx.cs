using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailL : System.Web.UI.Page
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
        if (Request["fsid"] != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select wowi_product_type_id,wowi_tech_id from Ima_FeeSchedule where FeeScheduleID=@FeeScheduleID";
            cmd.Parameters.AddWithValue("@FeeScheduleID", Request["fsid"]);
            DataTable dtFS = SQLUtil.QueryDS(cmd).Tables[0];
            if (dtFS.Rows.Count > 0)
            {
                lblProType.Text = dtFS.Rows[0]["wowi_product_type_id"].ToString();
                ddlTech.SelectedValue = dtFS.Rows[0]["wowi_tech_id"].ToString();
            }
        }
        else
        {
            lblProType.Text = Request["pt"];
        }
        ddlTech.DataBind();
        SetFee();
    }

    protected void SetFee()
    {
        SqlCommand cmd = new SqlCommand("STP_GetImaFeeSchedule");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@wowi_product_type_id", lblProType.Text.Trim());
        DataSet ds = SQLUtil.QueryDS(cmd);
        //LocalAgent
        ddlLocalAgent.DataSource = ds.Tables[0];
        ddlLocalAgent.DataTextField = "Name";
        ddlLocalAgent.DataValueField = "LocalAgentID";
        ddlLocalAgent.DataBind();
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlLocalAgent.Items.Insert(0, new ListItem("-Select-", "-1"));
        } 
        //Authority
        ddlAuthority.DataSource = ds.Tables[1];
        ddlAuthority.DataTextField = "AbbreviatedAuthorityName";
        ddlAuthority.DataValueField = "GovernmentAuthorityID";
        ddlAuthority.DataBind();
        if (ds.Tables[1].Rows.Count > 0)
        {
            ddlAuthority.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
        //Certification Body
        ddlCertification.DataSource = ds.Tables[2];
        ddlCertification.DataTextField = "Name";
        ddlCertification.DataValueField = "CertificationBodiesID";
        ddlCertification.DataBind();
        if (ds.Tables[2].Rows.Count > 0)
        {
            ddlCertification.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
        //Accredited Test Lab
        ddlAccredited.DataSource = ds.Tables[3];
        ddlAccredited.DataTextField = "AccreditedLab";
        ddlAccredited.DataValueField = "AccreditedTestID";
        ddlAccredited.DataBind();
        if (ds.Tables[3].Rows.Count > 0)
        {
            ddlAccredited.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Fee schedule Detail";
        string strID = Request["fsid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_FeeSchedule where FeeScheduleID=@FeeScheduleID";
            cmd.Parameters.AddWithValue("@FeeScheduleID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                ddlTech.SelectedValue = dt.Rows[0]["wowi_tech_id"].ToString();
                if (dt.Rows[0]["wowi_tech_id"].ToString().Length > 0) { lblTechName.Text = ddlTech.SelectedItem.Text; }
                ddlLocalAgent.SelectedValue = dt.Rows[0]["LocalAgentID"].ToString();
                if (dt.Rows[0]["LocalAgentID"].ToString() != "0" && dt.Rows[0]["LocalAgentID"].ToString() != "-1") { lblLocalAgent.Text = ddlLocalAgent.SelectedItem.Text; }
                ddlAuthority.SelectedValue = dt.Rows[0]["GovernmentAuthorityID"].ToString();
                if (dt.Rows[0]["GovernmentAuthorityID"].ToString() != "0" && dt.Rows[0]["GovernmentAuthorityID"].ToString() != "-1") { lblAuthority.Text = ddlAuthority.SelectedItem.Text; }
                ddlCertification.SelectedValue = dt.Rows[0]["CertificationBodiesID"].ToString();
                if (dt.Rows[0]["CertificationBodiesID"].ToString() != "0" && dt.Rows[0]["CertificationBodiesID"].ToString() != "-1") { lblCertification.Text = ddlCertification.SelectedItem.Text; }
                ddlAccredited.SelectedValue = dt.Rows[0]["AccreditedTestID"].ToString();
                if (dt.Rows[0]["AccreditedTestID"].ToString() != "0" && dt.Rows[0]["AccreditedTestID"].ToString() != "-1") { lblAccredited.Text = ddlAccredited.SelectedItem.Text; }
                if (dt.Rows[0]["AgentFee"].ToString().Trim().Length > 0) { lblAgentFee.Text = dt.Rows[0]["AgentFee"].ToString() + " USD"; }
                if (dt.Rows[0]["AuthorityFee"].ToString().Trim().Length > 0) { lblAuthorityFee.Text = dt.Rows[0]["AuthorityFee"].ToString() + " USD"; }
                if (dt.Rows[0]["CertificationBodyFee"].ToString().Trim().Length > 0) { lblCertificationBodyFee.Text = dt.Rows[0]["CertificationBodyFee"].ToString() + " USD"; }
                if (dt.Rows[0]["LabTestFee"].ToString().Trim().Length > 0) { lblLabTestFee.Text = dt.Rows[0]["LabTestFee"].ToString() + " USD"; }
                if (dt.Rows[0]["DocTranslationFee"].ToString().Trim().Length > 0) { lblDocTranslationFee.Text = dt.Rows[0]["DocTranslationFee"].ToString() + " USD"; }
                if (dt.Rows[0]["BankFee"].ToString().Trim().Length > 0) { lblBankFee.Text = dt.Rows[0]["BankFee"].ToString() + " USD"; }
                if (dt.Rows[0]["ClearanceFee"].ToString().Trim().Length > 0) { lblClearanceFee.Text = dt.Rows[0]["ClearanceFee"].ToString() + " USD"; }
                if (dt.Rows[0]["SampleReturnFee"].ToString().Trim().Length > 0) { lblSampleReturnFee.Text = dt.Rows[0]["SampleReturnFee"].ToString() + " USD"; }
                if (dt.Rows[0]["LabelPurchaseFee"].ToString().Trim().Length > 0) { lblLabelPurchaseFee.Text = dt.Rows[0]["LabelPurchaseFee"].ToString() + " USD"; }
                if (dt.Rows[0]["OtherFee"].ToString().Trim().Length > 0) { lblOtherFee.Text = dt.Rows[0]["OtherFee"].ToString() + " USD"; }
                if (dt.Rows[0]["DocumentFee"].ToString().Trim().Length > 0) { lblDocumentFee.Text = "Document Inspection Fee：" + dt.Rows[0]["DocumentFee"].ToString() + " USD"; }
                if (dt.Rows[0]["OneTimeFee"].ToString().Trim().Length > 0) { lblOneTimeFee.Text = "One-time on-site Inspection Fee：" + dt.Rows[0]["OneTimeFee"].ToString() + " USD"; }
                if (dt.Rows[0]["PeriodicFee"].ToString().Trim().Length > 0) { lblPeriodicFee.Text = "Periodic on-site Inspection Fee：" + dt.Rows[0]["PeriodicFee"].ToString() + " USD"; }

                if (dt.Rows[0]["RenewalWTest"].ToString().Trim().Length > 0) { lblRenewalWTest.Text = "W/Test：" + dt.Rows[0]["RenewalWTest"].ToString() + " USD"; }
                if (dt.Rows[0]["RenewalWOTest"].ToString().Trim().Length > 0) { lblRenewalWOTest.Text = " W/O Test：" + dt.Rows[0]["RenewalWOTest"].ToString() + " USD"; }
                if (dt.Rows[0]["TotalCostFee"].ToString().Trim().Length > 0) { lblTotalCostFee.Text = dt.Rows[0]["TotalCostFee"].ToString() + " USD"; }
                lblLeadTime.Text = dt.Rows[0]["LeadTime"].ToString().Trim();
                if (dt.Rows[0]["RenewalRemark"].ToString().Trim().Length > 0) { lblRenewalRemark.Text = "Remark：" + dt.Rows[0]["RenewalRemark"].ToString().Trim(); }

                if (dt.Rows[0]["TotalCostFeeNA"].ToString().Trim().Length > 0) { lblTotalCostFeeNA.Text = dt.Rows[0]["TotalCostFeeNA"].ToString() + " USD"; }
                lblLeadTimeNA.Text = dt.Rows[0]["LeadTimeNA"].ToString().Trim();
                //lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                //lblProTypeName1.Text = lblProTypeName.Text + "：";
                //if (Request.Params["copy"] != null)
                //{
                //    trCopyTo.Visible = true;
                //    btnSaveCopy.Visible = true;
                //    lblTitle.Text = "Fee schedule Copy";
                //    gvImaFiles1.Columns[1].Visible = true;
                //    gvFile2.Columns[1].Visible = true;
                //    gvFile3.Columns[1].Visible = true;
                //    gvFile4.Columns[1].Visible = true;
                //    gvFile5.Columns[1].Visible = true;
                //}
                //else
                //{
                //    btnUpd.Visible = true;
                //    trProductType.Visible = true;
                //    gvImaFiles1.Columns[0].Visible = true;
                //    gvFile2.Columns[0].Visible = true;
                //    gvFile3.Columns[0].Visible = true;
                //    gvFile4.Columns[0].Visible = true;
                //    gvFile5.Columns[0].Visible = true;
                //}
            }
        }
    }
}