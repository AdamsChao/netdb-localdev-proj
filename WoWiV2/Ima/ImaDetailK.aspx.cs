using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailK : System.Web.UI.Page
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
        lblTitle.Text = "Testing and submission preparation Detail";
        string strID = Request["tid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Testing where TestingID=@TestingID";
            cmd.Parameters.AddWithValue("@TestingID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                //rblLanguage.SelectedValue = dt.Rows[0]["Language"].ToString();
                if (dt.Rows[0]["Language"].ToString() == "All") { lblLanguage.Text = "All English"; }
                else if (dt.Rows[0]["Language"].ToString() == "Other") { lblLanguage.Text = "Other or Partial"; }
                else { lblLanguage.Text = dt.Rows[0]["Language"].ToString(); }
                if (dt.Rows[0]["LanguageDesc"].ToString().Trim().Length > 0) { lblLanguageDesc.Text = "Remark：" + dt.Rows[0]["LanguageDesc"].ToString(); }
                if (Convert.ToBoolean(dt.Rows[0]["BW"])) { lblEUTInfo.Text = "Sales Brochure (B/W)"; }
                if (Convert.ToBoolean(dt.Rows[0]["Color"])) 
                {
                    if (lblEUTInfo.Text.Trim().Length == 0) { lblEUTInfo.Text = "Sales Brochure (Color)"; }
                    else { lblEUTInfo.Text += "、Sales Brochure (Color)"; }
                }
                //cbBW.Checked = Convert.ToBoolean(dt.Rows[0]["BW"]);
                //cbColor.Checked = Convert.ToBoolean(dt.Rows[0]["Color"]);
                if (dt.Rows[0]["Manual"].ToString().Trim().Length > 0) 
                {
                    if (lblEUTInfo.Text.Trim().Length == 0) { lblManual.Text = "User Manual In " + dt.Rows[0]["Manual"].ToString() + " Language"; }
                    else { lblManual.Text = "<br>User Manual In " + dt.Rows[0]["Manual"].ToString() + " Language"; }
                    
                }
                lblEUTInfoS.Text = lblEUTInfo.Text;
                //cbFCCTest.Checked = Convert.ToBoolean(dt.Rows[0]["FCCTest"]);
                //cbFCCCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["FCCCertificate"]);
                //cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                //cbNBEO.Checked = Convert.ToBoolean(dt.Rows[0]["NBEO"]);
                //cbEUDoC.Checked = Convert.ToBoolean(dt.Rows[0]["EUDoC"]);
                //cbConformance.Checked = Convert.ToBoolean(dt.Rows[0]["Conformance"]);

                if (Convert.ToBoolean(dt.Rows[0]["FCCTest"])) { lblCertification.Text = "FCC Test Report"; }
                if (Convert.ToBoolean(dt.Rows[0]["FCCCertificate"])) 
                {
                    if (lblCertification.Text.Trim().Length == 0) { lblCertification.Text = "FCC Certificate"; }
                    else { lblCertification.Text += "、FCC Certificate"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["CETest"]))
                {
                    if (lblCertification.Text.Trim().Length == 0) { lblCertification.Text = "CE Test Report"; }
                    else { lblCertification.Text += "、CE Test Report"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["NBEO"]))
                {
                    if (lblCertification.Text.Trim().Length == 0) { lblCertification.Text = "NBEO"; }
                    else { lblCertification.Text += "、NBEO"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["EUDoC"]))
                {
                    if (lblCertification.Text.Trim().Length == 0) { lblCertification.Text = "EU DoC"; }
                    else { lblCertification.Text += "、EU DoC"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Conformance"]))
                {
                    if (lblCertification.Text.Trim().Length == 0) { lblCertification.Text = "Conformance for GSM, CDMA , and WCDMA"; }
                    else { lblCertification.Text += "、Conformance for GSM, CDMA , and WCDMA"; }
                }
                if (dt.Rows[0]["OtherInternationally"].ToString().Trim().Length > 0) { lblOtherInternationally.Text = "Other internationally recognized certification (specify)<br>" + dt.Rows[0]["OtherInternationally"].ToString(); }
                
                //cbSchematics.Checked = Convert.ToBoolean(dt.Rows[0]["Schematics"]);
                //cbBlock.Checked = Convert.ToBoolean(dt.Rows[0]["Block"]);
                //cbLayout.Checked = Convert.ToBoolean(dt.Rows[0]["Layout"]);
                //cbGerber.Checked = Convert.ToBoolean(dt.Rows[0]["Gerber"]);
                //cbTheory.Checked = Convert.ToBoolean(dt.Rows[0]["Theory"]);

                if (Convert.ToBoolean(dt.Rows[0]["Schematics"])) { lblTechnicalDocs.Text = "Schematics"; }
                if (Convert.ToBoolean(dt.Rows[0]["Block"])) 
                {
                    if (lblTechnicalDocs.Text.Trim().Length == 0) { lblTechnicalDocs.Text = "Block Diagram"; }
                    else { lblTechnicalDocs.Text += "、Block Diagram"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Layout"]))
                {
                    if (lblTechnicalDocs.Text.Trim().Length == 0) { lblTechnicalDocs.Text = "Layout"; }
                    else { lblTechnicalDocs.Text += "、Layout"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Gerber"]))
                {
                    if (lblTechnicalDocs.Text.Trim().Length == 0) { lblTechnicalDocs.Text = "Gerber"; }
                    else { lblTechnicalDocs.Text += "、Gerber"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Theory"]))
                {
                    if (lblTechnicalDocs.Text.Trim().Length == 0) { lblTechnicalDocs.Text = "Theory of Operation"; }
                    else { lblTechnicalDocs.Text += "、Theory of Operation"; }
                }
                if (dt.Rows[0]["BOM1"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["BOM1"])) 
                    {
                        if (lblTechnicalDocs.Text.Trim().Length == 0) { lblTechnicalDocs.Text = "BOM"; }
                        else { lblTechnicalDocs.Text += "、BOM"; }
                    }
                }
                if (dt.Rows[0]["Technical"].ToString().Trim().Length > 0) { lblTechnical.Text = "Technical Spec In " + dt.Rows[0]["Technical"].ToString() + " Language"; }
                if (dt.Rows[0]["Antenna"].ToString().Trim().Length > 0) { lblAntenna.Text = "Antenna Spec In " + dt.Rows[0]["Antenna"].ToString() + " Language"; }                
                lblBOM.Text = dt.Rows[0]["BOM"].ToString();
                //cbOfficial.Checked = Convert.ToBoolean(dt.Rows[0]["Official"]);
                //cbWoWiRequest.Checked = Convert.ToBoolean(dt.Rows[0]["WoWiRequest"]);
                //cbISO.Checked = Convert.ToBoolean(dt.Rows[0]["ISO"]);
                //cbPayment.Checked = Convert.ToBoolean(dt.Rows[0]["Payment"]);
                //cbAuthor.Checked = Convert.ToBoolean(dt.Rows[0]["Author"]);
                if (dt.Rows[0]["OtherDocRequest"].ToString().Trim().Length > 0) 
                {
                    lblOtherDocRequest.Text = "Please specify any other documents required<br />" + dt.Rows[0]["OtherDocRequest"].ToString();
                }
                
                if (Convert.ToBoolean(dt.Rows[0]["Official"])) 
                { 
                    lblOtherDoc1.Text = "Official Application Form ";
                    if (dt.Rows[0]["OfficialLanguage"].ToString().Trim().Length > 0) { lblOtherDoc1.Text += "in " + dt.Rows[0]["OfficialLanguage"].ToString() + " Language"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["WoWiRequest"])) 
                {
                    if (lblOtherDoc1.Text.Trim().Length == 0) { lblOtherDoc1.Text = "WoWi Request Letter"; }
                    else { lblOtherDoc1.Text += "<br>WoWi Request Letter"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["ISO"]))
                {
                    if (lblOtherDoc1.Text.Trim().Length == 0) 
                    {
                        lblOtherDoc1.Text = "ISO/Quality Documents in ";                        
                    }
                    else { lblOtherDoc1.Text += "<br>ISO/Quality Documents in "; }
                    if (dt.Rows[0]["ISOLanguage"].ToString().Trim().Length > 0) { lblOtherDoc1.Text += dt.Rows[0]["ISOLanguage"].ToString() + " Language"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Payment"]))
                {
                    if (lblOtherDoc1.Text.Trim().Length == 0) { lblOtherDoc1.Text = "Payment Receipt"; }
                    else { lblOtherDoc1.Text += "<br>Payment Receipt"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Author"]))
                {
                    if (lblOtherDoc1.Text.Trim().Length == 0) { lblOtherDoc1.Text = "Authorization Letter from Manufacturer to Local Rep/Agent"; }
                    else { lblOtherDoc1.Text += "<br>Authorization Letter from Manufacturer to Local Rep/Agent"; }
                }
                if (dt.Rows[0]["AuthorWoWi"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["AuthorWoWi"]))
                    {
                        if (lblOtherDoc1.Text.Trim().Length == 0) { lblOtherDoc1.Text = "Authorization Letter from Manufacturer to WoWi"; }
                        else { lblOtherDoc1.Text += "<br>Authorization Letter from Manufacturer to WoWi"; }
                    }
                }
                if (dt.Rows[0]["AuthorAgent"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["AuthorAgent"]))
                    {
                        if (lblOtherDoc1.Text.Trim().Length == 0) { lblOtherDoc1.Text = "Authorization Letter from Local Rep to Local Agent"; }
                        else { lblOtherDoc1.Text += "<br>Authorization Letter from Local Rep to Local Agent"; }
                    }
                }
                if (dt.Rows[0]["Radiated"].ToString().Trim() != "") { lblRadiated.Text = dt.Rows[0]["Radiated"].ToString() + "  pieces"; }
                if (dt.Rows[0]["Conducted"].ToString().Trim() != "") { lblConducted.Text = dt.Rows[0]["Conducted"].ToString() + "  pieces"; }
                if (dt.Rows[0]["NormalLink"].ToString().Trim() != "") { lblNormalLink.Text = dt.Rows[0]["NormalLink"].ToString() + "  pieces"; }
                if (dt.Rows[0]["ReviewOnly"].ToString().Trim() != "") { lblReviewOnly.Text = dt.Rows[0]["ReviewOnly"].ToString() + "  pieces"; }


                

                if (dt.Rows[0]["PreInstalled"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["PreInstalled"])) { lblPreInstalled.Text = "Pre-installed"; }
                }
                if (dt.Rows[0]["CD"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["CD"])) 
                    {
                        if (lblPreInstalled.Text.Trim().Length == 0) { lblPreInstalled.Text = "CD"; }
                        else { lblPreInstalled.Text += "、CD"; }
                    }
                }
                if (dt.Rows[0]["Email"] != DBNull.Value)
                {
                    if (Convert.ToBoolean(dt.Rows[0]["Email"]))
                    {
                        if (lblPreInstalled.Text.Trim().Length == 0) { lblPreInstalled.Text = "Email"; }
                        else { lblPreInstalled.Text += "、Email"; }
                    }
                }
                if (dt.Rows[0]["FTP"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["FTP"]))
                    {
                        if (lblPreInstalled.Text.Trim().Length == 0) { lblPreInstalled.Text = "FTP"; }
                        else { lblPreInstalled.Text += "、FTP"; }
                    }
                }
                if (dt.Rows[0]["TestNote"].ToString().Trim() != "") 
                {
                    if (lblPreInstalled.Text.Trim().Length == 0) { lblTestNote.Text = "Note：" + dt.Rows[0]["TestNote"].ToString(); }
                    else { lblTestNote.Text = "<br>Note：" + dt.Rows[0]["TestNote"].ToString(); }
                    
                }
                if (dt.Rows[0]["TestMark"] != DBNull.Value) 
                {
                    //rblTestMark.SelectedValue = Convert.ToInt32(dt.Rows[0]["TestMark"]).ToString();
                    //if (Convert.ToInt32(dt.Rows[0]["TestMark"]) == 1) { lblTestMark.Text = "Yes"; }
                    //else { lblTestMark.Text = "No"; }
                    lblTestMark.Text = dt.Rows[0]["TestMark"].ToString();
                }
                
                if (dt.Rows[0]["TestMarkRemark"].ToString().Trim().Length > 0) { lblTestMarkRemark.Text = "<br>Remark：" + dt.Rows[0]["TestMarkRemark"].ToString(); }
                
                //if (dt.Rows[0]["BOM1"] != DBNull.Value) { cbBOM1.Checked = Convert.ToBoolean(dt.Rows[0]["BOM1"]); } 
                
                lblRemark.Text = dt.Rows[0]["Remark"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);

                //業務人員可以檢視的欄位
                lblProTypeNameS.Text = lblProTypeName.Text;
                lblLanguageS.Text = lblLanguage.Text;
                lblLanguageDescS.Text = lblLanguageDesc.Text;
                lblTestMarkS.Text = lblTestMark.Text;
                lblTestMarkRemarkS.Text = lblTestMarkRemark.Text;
                lblCertificationS.Text = lblCertification.Text;
                lblOtherInternationallyS.Text = lblOtherInternationally.Text;
                lblTechnicalDocsS.Text = lblTechnicalDocs.Text;
                lblTechnicalS.Text = lblTechnical.Text;
                lblAntennaS.Text = lblAntenna.Text;
                lblOtherDoc1S.Text = lblOtherDoc1.Text;
                lblOtherDocRequestS.Text = lblOtherDocRequest.Text;
                lblRadiatedS.Text = lblRadiated.Text;
                lblConductedS.Text = lblConducted.Text;
                lblNormalLinkS.Text = lblNormalLink.Text;
                lblReviewOnlyS.Text = lblReviewOnly.Text;

                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Testing and submission preparation Detail";
                }
                else
                {
                    trProductType.Visible = true;
                }
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