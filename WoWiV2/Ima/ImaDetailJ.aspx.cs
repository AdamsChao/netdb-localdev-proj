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
                lblApprovalMethod.Text = dt.Rows[0]["ApprovalMethod"].ToString();
                cbDirect.Checked = Convert.ToBoolean(dt.Rows[0]["Direct"]);
                cbLocalAgent.Checked = Convert.ToBoolean(dt.Rows[0]["LocalAgent"]);
                rblInPerson.SelectedValue = dt.Rows[0]["InPerson"].ToString();
                rblHardCopy.Text = dt.Rows[0]["HardCopy"].ToString();
                rblWebsite.Text = dt.Rows[0]["Website"].ToString();
                rblEmail.Text = dt.Rows[0]["Email"].ToString();
                rblCD.Text = dt.Rows[0]["CD"].ToString();
                lblSubmissionDesc.Text = dt.Rows[0]["SubmissionDesc"].ToString();
                cbFCCTest.Checked = Convert.ToBoolean(dt.Rows[0]["FCCTest"]);
                cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                cbLocalTest.Checked = Convert.ToBoolean(dt.Rows[0]["LocalTest"]);
                rbtnlSamplesRequired.SelectedValue = dt.Rows[0]["SamplesRequired"].ToString().ToLower();
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
                rblModular.SelectedValue = dt.Rows[0]["Modular"].ToString();
                lblModularDesc.Text = dt.Rows[0]["ModularDesc"].ToString();
                rblRepresentative.SelectedValue = dt.Rows[0]["Representative"].ToString();
                lblRepresentativeDesc.Text = dt.Rows[0]["RepresentativeDesc"].ToString();
                lblLabLeadTime.Text = dt.Rows[0]["LabLeadTime"].ToString();
                lblBodyLeadTime.Text = dt.Rows[0]["BodyLeadTime"].ToString();
                lblAuthorityLeadTime.Text = dt.Rows[0]["AuthorityLeadTime"].ToString();
                rblExpeditedProcess.SelectedValue = dt.Rows[0]["ExpeditedProcess"].ToString();
                lblExpeditedProcessDesc.Text = dt.Rows[0]["ExpeditedProcessDesc"].ToString();
                cbControlByCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByCertificate"]);
                cbControlByModel.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByModel"]);
                cbControlByID.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByID"]);
                lblControlByOther.Text = dt.Rows[0]["ControlByOther"].ToString();
                rblMMNamesListed.SelectedValue = dt.Rows[0]["MMNamesListed"].ToString();
                rblAfterApproval.SelectedValue = dt.Rows[0]["AfterApproval"].ToString();
                lblModelDesc.Text = dt.Rows[0]["ModelDesc"].ToString();
                rblForeignApplicant.SelectedValue = dt.Rows[0]["ForeignApplicant"].ToString();
                rblAnyLocalPerson.SelectedValue = dt.Rows[0]["AnyLocalPerson"].ToString();
                rblActualImporter.SelectedValue = dt.Rows[0]["ActualImporter"].ToString();
                rblLocalDealer.SelectedValue = dt.Rows[0]["LocalDealer"].ToString();
                lblCertificateHolderDesc.Text = dt.Rows[0]["CertificateHolderDesc"].ToString();
                rblOriginRequired.SelectedValue = dt.Rows[0]["OriginRequired"].ToString();
                rblQualityRequired.SelectedValue = dt.Rows[0]["QualityRequired"].ToString();
                lblRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                rblContractRequired.SelectedValue = dt.Rows[0]["ContractRequired"].ToString();
                rblNotarizedPoARequired.SelectedValue = dt.Rows[0]["NotarizedPoARequired"].ToString();
                rblCertificateIDCreateBy.SelectedValue = dt.Rows[0]["CertificateIDCreateBy"].ToString();
                rblGetCertificateNumber.SelectedValue = dt.Rows[0]["GetCertificateNumber"].ToString();
                rblValidity.SelectedValue = dt.Rows[0]["Validity"].ToString();
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
                if (dt.Rows[0]["TypeApproval"] != DBNull.Value) { cbTypeApproval.Checked = Convert.ToBoolean(dt.Rows[0]["TypeApproval"]); }
                if (dt.Rows[0]["Registration"] != DBNull.Value) { cbRegistration.Checked = Convert.ToBoolean(dt.Rows[0]["Registration"]); }
                if (dt.Rows[0]["DispensationLitter"] != DBNull.Value) { cbDispensationLitter.Checked = Convert.ToBoolean(dt.Rows[0]["DispensationLitter"]); }
                if (dt.Rows[0]["Homologation"] != DBNull.Value) { cbHomologation.Checked = Convert.ToBoolean(dt.Rows[0]["Homologation"]); }
                if (dt.Rows[0]["OtherApprovalMethod"].ToString() != "") { lblOtherApprovalMethod.Text = "<br>Other：" + dt.Rows[0]["OtherApprovalMethod"].ToString(); }

                if (dt.Rows[0]["Other"] != DBNull.Value) { cbOther.Checked = Convert.ToBoolean(dt.Rows[0]["Other"]); }
                rblProvisional.SelectedValue = dt.Rows[0]["Provisional"].ToString();
                if (dt.Rows[0]["ProvisionalYears"].ToString() != "")
                {
                    lblProvisionalYearsMonths.Text = "；" + dt.Rows[0]["ProvisionalYears"].ToString() + "&nbsp;&nbsp;years";
                }
                if (lblProvisionalYearsMonths.Text.Trim() == "")
                {
                    if (dt.Rows[0]["ProvisionalMonths"].ToString() != "") { lblProvisionalYearsMonths.Text = "；" + dt.Rows[0]["ProvisionalMonths"].ToString() + "&nbsp;&nbsp;months"; }
                }
                else { if (dt.Rows[0]["ProvisionalMonths"].ToString() != "") { lblProvisionalYearsMonths.Text += "，" + dt.Rows[0]["ProvisionalMonths"].ToString() + "&nbsp;&nbsp;months"; } }
                
                rblPeriodic.SelectedValue = dt.Rows[0]["Periodic"].ToString();
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
}