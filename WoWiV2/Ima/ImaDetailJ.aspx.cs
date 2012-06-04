using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailJ : System.Web.UI.Page
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
        lblTitle.Text = "Application Procedures Detail";
        string strID = Request["aid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Application where ApplicationID=@ApplicationID";
            cmd.Parameters.AddWithValue("@ApplicationID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                if (Convert.ToBoolean(dt.Rows[0]["Direct"])) { lblSubmissMenthod.Text = "Direct Submission"; }
                if (Convert.ToBoolean(dt.Rows[0]["LocalAgent"])) 
                {
                    if (lblSubmissMenthod.Text.Trim().Length == 0) { lblSubmissMenthod.Text = "Local Agent Submission"; }
                    else { lblSubmissMenthod.Text += "、Local Agent Submission"; }
                }
                lblInPerson.Text = dt.Rows[0]["InPerson"].ToString();
                lblHardCopy.Text = dt.Rows[0]["HardCopy"].ToString();
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblEmail.Text = dt.Rows[0]["Email"].ToString();
                lblCD.Text = dt.Rows[0]["CD"].ToString();
                if (dt.Rows[0]["SubmissionDesc"].ToString().Trim().Length > 0) 
                {
                    if (lblCD.Text.Trim().Length == 0) { lblSubmissionDesc.Text = "Remark：" + dt.Rows[0]["SubmissionDesc"].ToString(); }
                    else { lblSubmissionDesc.Text = "Remark：" + dt.Rows[0]["SubmissionDesc"].ToString(); }
                }
                if (Convert.ToBoolean(dt.Rows[0]["FCCTest"])) { lblAccept.Text = "FCC Test Report"; }
                if (Convert.ToBoolean(dt.Rows[0]["CETest"])) 
                {
                    if (lblAccept.Text.Trim().Length == 0) { lblAccept.Text = "CE Test Report"; }
                    else { lblAccept.Text += "、CE Test Report"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["LocalTest"]))
                {
                    if (lblAccept.Text.Trim().Length == 0) { lblAccept.Text = "Local Testing"; }
                    else { lblAccept.Text += "、Local Testing"; }
                }
                if (dt.Rows[0]["Other"] != DBNull.Value)
                {
                    if (Convert.ToBoolean(dt.Rows[0]["Other"])) 
                    {
                        if (lblAccept.Text.Trim().Length == 0) { lblAccept.Text = "Other"; }
                        else { lblAccept.Text += "、Other"; }
                    }
                }
                //cbFCCTest.Checked = Convert.ToBoolean(dt.Rows[0]["FCCTest"]);
                //cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                //cbLocalTest.Checked = Convert.ToBoolean(dt.Rows[0]["LocalTest"]);
                //if (dt.Rows[0]["Other"] != DBNull.Value) { cbOther.Checked = Convert.ToBoolean(dt.Rows[0]["Other"]); }
                if (dt.Rows[0]["SamplesRequired"].ToString().ToLower() == "true") { lblSamplesRequired.Text = "Samples required(See Testing and Submission Preparation)"; }
                else { lblSamplesRequired.Text = "No Samples required"; }
                //rbtnlSamplesRequired.SelectedValue = dt.Rows[0]["SamplesRequired"].ToString().ToLower();
                //cbSamplesRequired.Checked = Convert.ToBoolean(dt.Rows[0]["SamplesRequired"]);
                //if (cbSamplesRequired.Checked) 
                //{
                //    trSamplesRequired.Visible = false;
                //    trSamplesRequired1.Visible = false;
                //    trSamplesRequired2.Visible = false;
                //    trSamplesRequired3.Visible = false;
                //    trSamplesRequired4.Visible = false;
                //}
                lblRadiated.Text = dt.Rows[0]["Radiated"].ToString();
                lblConducted.Text = dt.Rows[0]["Conducted"].ToString();
                lblNormalLink.Text = dt.Rows[0]["NormalLink"].ToString();
                lblReviewOnly.Text = dt.Rows[0]["ReviewOnly"].ToString();
                //rblModular.SelectedValue = dt.Rows[0]["Modular"].ToString();
                lblModular.Text = dt.Rows[0]["Modular"].ToString();
                lblModularDesc.Text = dt.Rows[0]["ModularDesc"].ToString();
                //rblRepresentative.SelectedValue = dt.Rows[0]["Representative"].ToString();
                lblRepresentative.Text = dt.Rows[0]["Representative"].ToString();
                lblRepresentativeDesc.Text = dt.Rows[0]["RepresentativeDesc"].ToString();
                lblLabLeadTime.Text = dt.Rows[0]["LabLeadTime"].ToString();
                lblBodyLeadTime.Text = dt.Rows[0]["BodyLeadTime"].ToString();
                lblAuthorityLeadTime.Text = dt.Rows[0]["AuthorityLeadTime"].ToString();
                //rblExpeditedProcess.SelectedValue = dt.Rows[0]["ExpeditedProcess"].ToString();
                lblExpeditedProcess.Text = dt.Rows[0]["ExpeditedProcess"].ToString();
                lblExpeditedProcessDesc.Text = dt.Rows[0]["ExpeditedProcessDesc"].ToString();
                //cbControlByCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByCertificate"]);
                //cbControlByModel.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByModel"]);
                //cbControlByID.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByID"]);
                if (Convert.ToBoolean(dt.Rows[0]["ControlByCertificate"])) { lblControlBy.Text = "Certificate # / Approval #"; }
                if (Convert.ToBoolean(dt.Rows[0]["ControlByModel"])) 
                {
                    if (lblControlBy.Text.Trim().Length == 0) { lblControlBy.Text = "Model #"; }
                    else { lblControlBy.Text += "、Model #"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["ControlByID"]))
                {
                    if (lblControlBy.Text.Trim().Length == 0) { lblControlBy.Text = "ID #"; }
                    else { lblControlBy.Text += "、ID #"; }
                }
                if (dt.Rows[0]["ControlByOther"].ToString().Trim().Length > 0) 
                {
                    if (lblControlBy.Text.Trim().Length == 0) { lblControlByOther.Text = "Others：" + dt.Rows[0]["ControlByOther"].ToString(); }
                    else { lblControlByOther.Text = "<br>Others：" + dt.Rows[0]["ControlByOther"].ToString(); }
                }
                //rblMMNamesListed.SelectedValue = dt.Rows[0]["MMNamesListed"].ToString();
                lblMMNamesListed.Text = dt.Rows[0]["MMNamesListed"].ToString();
                //rblAfterApproval.SelectedValue = dt.Rows[0]["AfterApproval"].ToString();
                lblAfterApproval.Text = dt.Rows[0]["AfterApproval"].ToString();
                lblModelDesc.Text = dt.Rows[0]["ModelDesc"].ToString();
                rblForeignApplicant.SelectedValue = dt.Rows[0]["ForeignApplicant"].ToString();
                rblAnyLocalPerson.SelectedValue = dt.Rows[0]["AnyLocalPerson"].ToString();
                rblActualImporter.SelectedValue = dt.Rows[0]["ActualImporter"].ToString();
                rblLocalDealer.SelectedValue = dt.Rows[0]["LocalDealer"].ToString();
                lblCertificateHolderDesc.Text = dt.Rows[0]["CertificateHolderDesc"].ToString();
                //rblOriginRequired.SelectedValue = dt.Rows[0]["OriginRequired"].ToString();
                lblOriginRequired.Text = dt.Rows[0]["OriginRequired"].ToString();
                rblQualityRequired.SelectedValue = dt.Rows[0]["QualityRequired"].ToString();
                lblRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                //rblContractRequired.SelectedValue = dt.Rows[0]["ContractRequired"].ToString();
                lblContractRequired.Text = dt.Rows[0]["ContractRequired"].ToString();
                //rblNotarizedPoARequired.SelectedValue = dt.Rows[0]["NotarizedPoARequired"].ToString();
                lblNotarizedPoARequired.Text = dt.Rows[0]["NotarizedPoARequired"].ToString();
                //rblCertificateIDCreateBy.SelectedValue = dt.Rows[0]["CertificateIDCreateBy"].ToString();
                lblCertificateIDCreateBy.Text = dt.Rows[0]["CertificateIDCreateBy"].ToString();
                //rblGetCertificateNumber.SelectedValue = dt.Rows[0]["GetCertificateNumber"].ToString();
                lblGetCertificateNumber.Text = dt.Rows[0]["GetCertificateNumber"].ToString();
                //rblValidity.SelectedValue = dt.Rows[0]["Validity"].ToString();
                lblValidity.Text = dt.Rows[0]["Validity"].ToString();
                lblValidityDesc.Text = dt.Rows[0]["ValidityDesc"].ToString();
                if (dt.Rows[0]["Years"].ToString() != "") 
                {
                    lblYearsMonths.Text = "；" + dt.Rows[0]["Years"].ToString() + "&nbsp;&nbsp;years";
                }
                if (lblYearsMonths.Text.Trim() == "")
                {
                    if (dt.Rows[0]["Months"].ToString() != "") { lblYearsMonths.Text = "；" + dt.Rows[0]["Months"].ToString() + "&nbsp;&nbsp;months"; }
                }
                else { if (dt.Rows[0]["Months"].ToString() != "") { lblYearsMonths.Text += "，" + dt.Rows[0]["Months"].ToString() + "&nbsp;&nbsp;months"; } }
                if (dt.Rows[0]["TypeApproval"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["TypeApproval"])) { lblApprovalMethod.Text = "Type Approval"; }
                }
                if (dt.Rows[0]["Registration"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["Registration"]) && lblApprovalMethod.Text.Trim().Length == 0) { lblApprovalMethod.Text = "Registration"; }
                    else if (Convert.ToBoolean(dt.Rows[0]["Registration"]) && lblApprovalMethod.Text.Trim().Length > 0) { lblApprovalMethod.Text += "、Registration"; }
                }
                if (dt.Rows[0]["DispensationLitter"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["DispensationLitter"]) && lblApprovalMethod.Text.Trim().Length == 0) { lblApprovalMethod.Text = "Dispensation Litter"; }
                    else if (Convert.ToBoolean(dt.Rows[0]["DispensationLitter"]) && lblApprovalMethod.Text.Trim().Length > 0) { lblApprovalMethod.Text += "、Dispensation Litter"; }
                }
                if (dt.Rows[0]["Homologation"] != DBNull.Value) 
                {
                    if (Convert.ToBoolean(dt.Rows[0]["Homologation"]) && lblApprovalMethod.Text.Trim().Length == 0) { lblApprovalMethod.Text = "Homologation"; }
                    else if (Convert.ToBoolean(dt.Rows[0]["Homologation"]) && lblApprovalMethod.Text.Trim().Length > 0) { lblApprovalMethod.Text += "、Homologation"; }
                }
                if (dt.Rows[0]["OtherApprovalMethod"].ToString() != "") 
                {
                    if (lblApprovalMethod.Text.Trim().Length == 0) { lblOtherApprovalMethod.Text = "Other：" + dt.Rows[0]["OtherApprovalMethod"].ToString(); }
                    else { lblOtherApprovalMethod.Text = "<br>Other：" + dt.Rows[0]["OtherApprovalMethod"].ToString(); }
                }
                                
                //rblProvisional.SelectedValue = dt.Rows[0]["Provisional"].ToString();
                lblProvisional.Text = dt.Rows[0]["Provisional"].ToString();
                if (dt.Rows[0]["ProvisionalYears"].ToString() != "")
                {
                    lblProvisionalYearsMonths.Text = "；" + dt.Rows[0]["ProvisionalYears"].ToString() + "&nbsp;&nbsp;years";
                }
                if (lblProvisionalYearsMonths.Text.Trim() == "")
                {
                    if (dt.Rows[0]["ProvisionalMonths"].ToString() != "") { lblProvisionalYearsMonths.Text = "；" + dt.Rows[0]["ProvisionalMonths"].ToString() + "&nbsp;&nbsp;months"; }
                }
                else { if (dt.Rows[0]["ProvisionalMonths"].ToString() != "") { lblProvisionalYearsMonths.Text += "，" + dt.Rows[0]["ProvisionalMonths"].ToString() + "&nbsp;&nbsp;months"; } }
                
                //rblPeriodic.SelectedValue = dt.Rows[0]["Periodic"].ToString();
                lblPeriodic.Text = dt.Rows[0]["Periodic"].ToString();
                if (dt.Rows[0]["PeriodicSDate"].ToString() != "")
                {
                    lblPeriodicDate.Text = "；From&nbsp;&nbsp;" + string.Format("{0:yyyy/MM/dd}", dt.Rows[0]["PeriodicSDate"]);
                }
                if (lblPeriodicDate.Text.Trim() == "")
                {
                    if (dt.Rows[0]["PeriodicSEnd"].ToString() != "") { lblPeriodicDate.Text = "；TO&nbsp;&nbsp;" + string.Format("{0:yyyy/MM/dd}", dt.Rows[0]["PeriodicSEnd"]); }
                }
                else { if (dt.Rows[0]["PeriodicSEnd"].ToString() != "") { lblPeriodicDate.Text += "&nbsp;&nbsp;TO&nbsp;&nbsp;" + string.Format("{0:yyyy/MM/dd}", dt.Rows[0]["PeriodicSEnd"]); } }
                lblShipment.Text = dt.Rows[0]["Shipment"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Application Procedures Detail";
                    gvFile1.Columns[1].Visible = true;
                    gvFile2.Columns[1].Visible = true;
                    gvFile3.Columns[1].Visible = true;
                    gvFile4.Columns[1].Visible = true;
                    gvFile5.Columns[1].Visible = true;
                    gvFile6.Columns[1].Visible = true;
                    gvFile7.Columns[1].Visible = true;
                    gvFile8.Columns[1].Visible = true;
                }
                else
                {
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                    gvFile2.Columns[0].Visible = true;
                    gvFile3.Columns[0].Visible = true;
                    gvFile4.Columns[0].Visible = true;
                    gvFile5.Columns[0].Visible = true;
                    gvFile6.Columns[0].Visible = true;
                    gvFile7.Columns[0].Visible = true;
                    gvFile8.Columns[0].Visible = true;
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