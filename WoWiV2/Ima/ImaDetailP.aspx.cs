using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailP : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SetControlVisible();
            LoadData();
            SetKW();
        }
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        //設定為業務或其他使用者可以看的Detail項
        if (!IMAUtil.IsEditOn())
        {
            plDetailSales.Visible = true;
        }
        else
        {
            plDetail.Visible = true;
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Label and Renewal Detail";
        string strID = Request["pcid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Post where PostID=@PostID";
            cmd.Parameters.AddWithValue("@PostID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                //rblRequirement.SelectedValue = dt.Rows[0]["Requirement"].ToString();
                lblRequirement.Text = dt.Rows[0]["Requirement"].ToString();
                if (dt.Rows[0]["RequirementDesc"].ToString().Trim().Length > 0) { lblRequirementDesc.Text = "Remark：" + dt.Rows[0]["RequirementDesc"].ToString(); }
                //cbPrint.Checked = Convert.ToBoolean(dt.Rows[0]["Print"]);
                //cbPurchase.Checked = Convert.ToBoolean(dt.Rows[0]["Purchase"]);
                //cbManufacturer.Checked = Convert.ToBoolean(dt.Rows[0]["Manufacturer"]);
                //cbImportation.Checked = Convert.ToBoolean(dt.Rows[0]["Importation"]);
                if (Convert.ToBoolean(dt.Rows[0]["Print"])) { lblPrint.Text = "Labels can be self-printed"; }
                if (Convert.ToBoolean(dt.Rows[0]["Purchase"])) 
                {
                    if (lblPrint.Text.Trim().Length == 0) { lblPrint.Text = "Labels need to be purchase from authority"; }
                    else { lblPrint.Text += "、Labels need to be purchase from authority"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Manufacturer"]))
                {
                    if (lblPrint.Text.Trim().Length == 0) { lblPrint.Text = "Affixed in Manufacturer"; }
                    else { lblPrint.Text += "、Affixed in Manufacturer"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Importation"]))
                {
                    if (lblPrint.Text.Trim().Length == 0) { lblPrint.Text = "Affixed after Importation"; }
                    else { lblPrint.Text += "、Affixed after Importation"; }
                }
                if (dt.Rows[0]["LabelsDesc"].ToString().Trim().Length > 0) 
                {
                    if (lblPrint.Text.Trim().Length == 0) { lblLabelsDesc.Text = dt.Rows[0]["LabelsDesc"].ToString(); }
                    else { lblLabelsDesc.Text = "Remark：" + dt.Rows[0]["LabelsDesc"].ToString(); }
                }
                
                //rbtnYes.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                //rbtnNo.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                //lblYear.Text = dt.Rows[0]["Year"].ToString();
                //lblMonth.Text = dt.Rows[0]["Month"].ToString();
                lblRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                //rblProduct.SelectedValue = Convert.ToInt32(dt.Rows[0]["Product"]).ToString();
                if (Convert.ToInt32(dt.Rows[0]["Product"]) == 1) { lblProduct.Text = "Yes"; }
                else { lblProduct.Text = "No"; }

                //cbEUT1.Checked = Convert.ToBoolean(dt.Rows[0]["EUT1"]);
                //cbEUT2.Checked = Convert.ToBoolean(dt.Rows[0]["EUT2"]);
                //cbEUT3.Checked = Convert.ToBoolean(dt.Rows[0]["EUT3"]);
                //cbEUT4.Checked = Convert.ToBoolean(dt.Rows[0]["EUT4"]);
                //cbEUT5.Checked = Convert.ToBoolean(dt.Rows[0]["EUT5"]);
                //cbEUT6.Checked = Convert.ToBoolean(dt.Rows[0]["EUT6"]);
                //cbEUT7.Checked = Convert.ToBoolean(dt.Rows[0]["EUT7"]);
                //cbEUT8.Checked = Convert.ToBoolean(dt.Rows[0]["EUT8"]);
                if (Convert.ToBoolean(dt.Rows[0]["EUT1"])) { lblEUT.Text = "EUT(module) or Manual or Package"; }
                if (Convert.ToBoolean(dt.Rows[0]["EUT2"])) 
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) or End Product"; }
                    else { lblEUT.Text += "<br>EUT(module) or End Product"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT3"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) or End Product or Manual"; }
                    else { lblEUT.Text += "<br>EUT(module) or End Product or Manual"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT4"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) or End Product or Manual or Package"; }
                    else { lblEUT.Text += "<br>EUT(module) or End Product or Manual or Package"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT5"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) and End Product"; }
                    else { lblEUT.Text += "<br>EUT(module) and End Product"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT6"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) and End Product and Manual"; }
                    else { lblEUT.Text += "<br>EUT(module) and End Product and Manual"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT7"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) and End Product and Manual and Package"; }
                    else { lblEUT.Text += "<br>EUT(module) and End Product and Manual and Package"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUT8"]))
                {
                    if (lblEUT.Text.Trim().Length == 0) { lblEUT.Text = "EUT(module) and End Product and Package"; }
                    else { lblEUT.Text += "<br>EUT(module) and End Product and Package"; }
                }
                //rblRenewal.SelectedValue = Convert.ToInt32(dt.Rows[0]["Renewal"]).ToString();
                if (Convert.ToInt32(dt.Rows[0]["Renewal"]) == 1) { lblRenewal.Text = "Yes"; }
                else { lblRenewal.Text = "No"; }
                //rblRequired.SelectedValue = Convert.ToInt32(dt.Rows[0]["Required"]).ToString();
                if (Convert.ToInt32(dt.Rows[0]["Required"]) == 1) { lblRequired.Text = "Yes"; }
                else { lblRequired.Text = "No"; }
                if (dt.Rows[0]["CostTest1"].ToString() != "")
                {
                    lblCost1.Text = dt.Rows[0]["CostTest1"].ToString() + "&nbsp;&nbsp;USD";
                }
                if (lblCost1.Text.Trim() == "")
                {
                    if (dt.Rows[0]["LeadTime1"].ToString() != "") { lblCost1.Text = "Lead-Time：" + dt.Rows[0]["LeadTime1"].ToString() + "&nbsp;&nbsp;weeks"; }
                }
                else { if (dt.Rows[0]["LeadTime1"].ToString() != "") { lblCost1.Text += "；Lead-Time：" + dt.Rows[0]["LeadTime1"].ToString() + "&nbsp;&nbsp;weeks"; } }
                if (dt.Rows[0]["CostTest2"].ToString() != "")
                {
                    lblCost2.Text = dt.Rows[0]["CostTest2"].ToString() + "&nbsp;&nbsp;USD";
                }
                if (lblCost2.Text.Trim() == "")
                {
                    if (dt.Rows[0]["LeadTime2"].ToString() != "") { lblCost2.Text = "Lead-Time：" + dt.Rows[0]["LeadTime2"].ToString() + "&nbsp;&nbsp;weeks"; }
                }
                else { if (dt.Rows[0]["LeadTime2"].ToString() != "") { lblCost2.Text += "；Lead-Time：" + dt.Rows[0]["LeadTime2"].ToString() + "&nbsp;&nbsp;weeks"; } }
                if (dt.Rows[0]["Year"].ToString() != "")
                {
                    lblYearMonth.Text = dt.Rows[0]["Year"].ToString() + "&nbsp;&nbsp;year(s)";
                }
                if (lblYearMonth.Text.Trim() == "")
                {
                    if (dt.Rows[0]["Month"].ToString() != "") { lblYearMonth.Text = dt.Rows[0]["Month"].ToString() + "&nbsp;&nbsp;month(s)"; }
                }
                else { if (dt.Rows[0]["Month"].ToString() != "") { lblYearMonth.Text += "，" + dt.Rows[0]["Month"].ToString() + "&nbsp;&nbsp;month(s)"; } }                
                lblRemark.Text = dt.Rows[0]["Remark"].ToString();
                lblRequiredDoc.Text = dt.Rows[0]["RequiredDoc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                trProductType.Visible = true;

                //業務人員可以檢視的欄位
                lblCountryS.Text = lblCountry.Text;
                lblProTypeNameS.Text = lblProTypeName.Text;
                lblRequirementS.Text = lblRequirement.Text;
                lblProductS.Text = lblProduct.Text;
                lblEUTS.Text = lblEUT.Text;
                lblRenewalS.Text = lblRenewal.Text;
                lblYearMonthS.Text = lblYearMonth.Text;
                lblRequiredDocS.Text = lblRequiredDoc.Text;
            }
            ////Technology
            //cmd = new SqlCommand();
            //cmd.CommandText = "select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            //cmd.Parameters.AddWithValue("@DID", strID);
            //cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            //DataSet ds = SQLUtil.QueryDS(cmd);
            //DataTable dtTechnology = ds.Tables[0];
            //if (dtTechnology.Rows.Count > 0)
            //{
            //    CheckBoxList cbl;
            //    if (lblProTypeName.Text.Trim() == "RF") { cbTechRF.DataBind(); cbl = cbTechRF; trTechRF.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "EMC") { cbTechEMC.DataBind(); cbl = cbTechEMC; trTechEMC.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "Safety") { cbTechSafety.DataBind(); cbl = cbTechSafety; trTechSafety.Visible = true; }
            //    else { cbTechTelecom.DataBind(); cbl = cbTechTelecom; trTechTelecom.Visible = true; }

            //    foreach (DataRow dr in dtTechnology.Rows)
            //    {
            //        foreach (ListItem li in cbl.Items)
            //        {
            //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
            //        }
            //    }
            //}
        }
    }

    //替換關鍵字查詢的顏色
    protected void SetKW()
    {
        new IMAUtil().RepKW(this.Form.Controls);
    }
}