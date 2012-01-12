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
                cbSamplesRequired.Checked = Convert.ToBoolean(dt.Rows[0]["SamplesRequired"]);
                if (cbSamplesRequired.Checked) 
                {
                    trSamplesRequired.Visible = false;
                    trSamplesRequired1.Visible = false;
                    trSamplesRequired2.Visible = false;
                    trSamplesRequired3.Visible = false;
                    trSamplesRequired4.Visible = false;
                }
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
        }
    }
}