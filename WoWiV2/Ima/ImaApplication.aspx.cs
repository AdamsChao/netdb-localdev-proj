using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_ImaApplication : System.Web.UI.Page
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
        lblTitle.Text = "Application Procedures Edit";
        string strID = Request["aid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        gvFile2.Columns[0].Visible = false;
        gvFile2.Columns[1].Visible = false;
        gvFile3.Columns[0].Visible = false;
        gvFile3.Columns[1].Visible = false;
        gvFile4.Columns[0].Visible = false;
        gvFile4.Columns[1].Visible = false;
        gvFile5.Columns[0].Visible = false;
        gvFile5.Columns[1].Visible = false;
        gvFile6.Columns[0].Visible = false;
        gvFile6.Columns[1].Visible = false;
        gvFile7.Columns[0].Visible = false;
        gvFile7.Columns[1].Visible = false;
        gvFile8.Columns[0].Visible = false;
        gvFile8.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Application where ApplicationID=@ApplicationID";
            cmd.Parameters.AddWithValue("@ApplicationID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbApprovalMethod.Text = dt.Rows[0]["ApprovalMethod"].ToString();
                cbDirect.Checked = Convert.ToBoolean(dt.Rows[0]["Direct"]);
                cbLocalAgent.Checked = Convert.ToBoolean(dt.Rows[0]["LocalAgent"]);
                rblInPerson.SelectedValue = dt.Rows[0]["InPerson"].ToString();
                rblHardCopy.Text = dt.Rows[0]["HardCopy"].ToString();
                rblWebsite.Text = dt.Rows[0]["Website"].ToString();
                rblEmail.Text = dt.Rows[0]["Email"].ToString();
                rblCD.Text = dt.Rows[0]["CD"].ToString();
                tbSubmissionDesc.Text = dt.Rows[0]["SubmissionDesc"].ToString();
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
                tbRadiated.Text = dt.Rows[0]["Radiated"].ToString();
                tbConducted.Text = dt.Rows[0]["Conducted"].ToString();
                tbNormalLink.Text = dt.Rows[0]["NormalLink"].ToString();
                tbReviewOnly.Text = dt.Rows[0]["ReviewOnly"].ToString();
                rblModular.SelectedValue = dt.Rows[0]["Modular"].ToString();
                tbModularDesc.Text = dt.Rows[0]["ModularDesc"].ToString();
                rblRepresentative.SelectedValue = dt.Rows[0]["Representative"].ToString();
                tbRepresentativeDesc.Text = dt.Rows[0]["RepresentativeDesc"].ToString();
                tbLabLeadTime.Text = dt.Rows[0]["LabLeadTime"].ToString();
                tbBodyLeadTime.Text = dt.Rows[0]["BodyLeadTime"].ToString();
                tbAuthorityLeadTime.Text = dt.Rows[0]["AuthorityLeadTime"].ToString();
                rblExpeditedProcess.SelectedValue = dt.Rows[0]["ExpeditedProcess"].ToString();
                tbExpeditedProcessDesc.Text = dt.Rows[0]["ExpeditedProcessDesc"].ToString();
                cbControlByCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByCertificate"]);
                cbControlByModel.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByModel"]);
                cbControlByID.Checked = Convert.ToBoolean(dt.Rows[0]["ControlByID"]);
                tbControlByOther.Text = dt.Rows[0]["ControlByOther"].ToString();
                rblMMNamesListed.SelectedValue = dt.Rows[0]["MMNamesListed"].ToString();
                rblAfterApproval.SelectedValue = dt.Rows[0]["AfterApproval"].ToString();
                tbModelDesc.Text = dt.Rows[0]["ModelDesc"].ToString();
                rblForeignApplicant.SelectedValue = dt.Rows[0]["ForeignApplicant"].ToString();
                rblAnyLocalPerson.SelectedValue = dt.Rows[0]["AnyLocalPerson"].ToString();
                rblActualImporter.SelectedValue = dt.Rows[0]["ActualImporter"].ToString();
                rblLocalDealer.SelectedValue = dt.Rows[0]["LocalDealer"].ToString();
                tbCertificateHolderDesc.Text = dt.Rows[0]["CertificateHolderDesc"].ToString();
                rblOriginRequired.SelectedValue = dt.Rows[0]["OriginRequired"].ToString();
                rblQualityRequired.SelectedValue = dt.Rows[0]["QualityRequired"].ToString();
                tbRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                rblContractRequired.SelectedValue = dt.Rows[0]["ContractRequired"].ToString();
                rblNotarizedPoARequired.SelectedValue = dt.Rows[0]["NotarizedPoARequired"].ToString();
                rblCertificateIDCreateBy.SelectedValue = dt.Rows[0]["CertificateIDCreateBy"].ToString();
                rblGetCertificateNumber.SelectedValue = dt.Rows[0]["GetCertificateNumber"].ToString();
                rblValidity.SelectedValue = dt.Rows[0]["Validity"].ToString();
                tbValidityDesc.Text = dt.Rows[0]["ValidityDesc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Application Procedures Copy";
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
                    btnUpd.Visible = true;
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
        else
        {
            btnSave.Visible = true;
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_Application (world_region_id,country_id,wowi_product_type_id,ApprovalMethod,Direct,LocalAgent,InPerson,HardCopy,Website,Email,CD,SubmissionDesc,FCCTest,CETest,LocalTest,SamplesRequired,Radiated,Conducted,NormalLink,ReviewOnly,Modular,ModularDesc,Representative,RepresentativeDesc,LabLeadTime,BodyLeadTime,AuthorityLeadTime,ExpeditedProcess,ExpeditedProcessDesc,ControlByCertificate,ControlByModel,ControlByID,ControlByOther,MMNamesListed,AfterApproval,ModelDesc,ForeignApplicant,AnyLocalPerson,ActualImporter,LocalDealer,CertificateHolderDesc,OriginRequired,QualityRequired,RequiredDesc,ContractRequired,NotarizedPoARequired,CertificateIDCreateBy,GetCertificateNumber,Validity,ValidityDesc,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@ApprovalMethod,@Direct,@LocalAgent,@InPerson,@HardCopy,@Website,@Email,@CD,@SubmissionDesc,@FCCTest,@CETest,@LocalTest,@SamplesRequired,@Radiated,@Conducted,@NormalLink,@ReviewOnly,@Modular,@ModularDesc,@Representative,@RepresentativeDesc,@LabLeadTime,@BodyLeadTime,@AuthorityLeadTime,@ExpeditedProcess,@ExpeditedProcessDesc,@ControlByCertificate,@ControlByModel,@ControlByID,@ControlByOther,@MMNamesListed,@AfterApproval,@ModelDesc,@ForeignApplicant,@AnyLocalPerson,@ActualImporter,@LocalDealer,@CertificateHolderDesc,@OriginRequired,@QualityRequired,@RequiredDesc,@ContractRequired,@NotarizedPoARequired,@CertificateIDCreateBy,@GetCertificateNumber,@Validity,@ValidityDesc,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@ApprovalMethod", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Direct", SqlDbType.Bit);
        cmd.Parameters.Add("@LocalAgent", SqlDbType.Bit);
        cmd.Parameters.Add("@InPerson", SqlDbType.NVarChar);
        cmd.Parameters.Add("@HardCopy", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Website", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Email", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CD", SqlDbType.NVarChar);
        cmd.Parameters.Add("@SubmissionDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@FCCTest", SqlDbType.Bit);
        cmd.Parameters.Add("@CETest", SqlDbType.Bit);
        cmd.Parameters.Add("@LocalTest", SqlDbType.Bit);
        cmd.Parameters.Add("@SamplesRequired", SqlDbType.Bit);
        cmd.Parameters.Add("@Radiated", SqlDbType.Int);
        cmd.Parameters.Add("@Conducted", SqlDbType.Int);
        cmd.Parameters.Add("@NormalLink", SqlDbType.Int);
        cmd.Parameters.Add("@ReviewOnly", SqlDbType.Int);
        cmd.Parameters.Add("@Modular", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ModularDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Representative", SqlDbType.NVarChar);
        cmd.Parameters.Add("@RepresentativeDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LabLeadTime", SqlDbType.Int);
        cmd.Parameters.Add("@BodyLeadTime", SqlDbType.Int);
        cmd.Parameters.Add("@AuthorityLeadTime", SqlDbType.Int);
        cmd.Parameters.Add("@ExpeditedProcess", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ExpeditedProcessDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ControlByCertificate", SqlDbType.Bit);
        cmd.Parameters.Add("@ControlByModel", SqlDbType.Bit);
        cmd.Parameters.Add("@ControlByID", SqlDbType.Bit);
        cmd.Parameters.Add("@ControlByOther", SqlDbType.NVarChar);
        cmd.Parameters.Add("@MMNamesListed", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AfterApproval", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ModelDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ForeignApplicant", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AnyLocalPerson", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ActualImporter", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LocalDealer", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CertificateHolderDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@OriginRequired", SqlDbType.NVarChar);
        cmd.Parameters.Add("@QualityRequired", SqlDbType.NVarChar);
        cmd.Parameters.Add("@RequiredDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ContractRequired", SqlDbType.NVarChar);
        cmd.Parameters.Add("@NotarizedPoARequired", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CertificateIDCreateBy", SqlDbType.NVarChar);
        cmd.Parameters.Add("@GetCertificateNumber", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Validity", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ValidityDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        string strCopyTo = HttpUtility.UrlDecode(Request["pt"]);
        if (Request["copy"] != null)
        {
            foreach (ListItem li in cbProductType.Items)
            {
                if (li.Selected)
                {
                    strCopyTo += "," + li.Value;
                }
            }
            if (strCopyTo != "") { strCopyTo = strCopyTo.Remove(0, 1); }
        }
        foreach (string str in strCopyTo.Split(','))
        {
            if (str != "")
            {
                lblProType.Text = str;
                cmd.Parameters["@world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@ApprovalMethod"].Value = tbApprovalMethod.Text.Trim();
                cmd.Parameters["@Direct"].Value = cbDirect.Checked;
                cmd.Parameters["@LocalAgent"].Value = cbLocalAgent.Checked;
                cmd.Parameters["@InPerson"].Value = rblInPerson.SelectedValue;
                cmd.Parameters["@HardCopy"].Value = rblHardCopy.SelectedValue;
                cmd.Parameters["@Website"].Value = rblWebsite.SelectedValue;
                cmd.Parameters["@Email"].Value = rblEmail.SelectedValue;
                cmd.Parameters["@CD"].Value = rblCD.SelectedValue;
                cmd.Parameters["@SubmissionDesc"].Value = tbSubmissionDesc.Text.Trim();
                cmd.Parameters["@FCCTest"].Value = cbFCCTest.Checked;
                cmd.Parameters["@CETest"].Value = cbCETest.Checked;
                cmd.Parameters["@LocalTest"].Value = cbLocalTest.Checked;
                cmd.Parameters["@SamplesRequired"].Value = cbSamplesRequired.Checked;
                cmd.Parameters["@Radiated"].Value = tbRadiated.Text.Trim();
                cmd.Parameters["@Conducted"].Value = tbConducted.Text.Trim();
                cmd.Parameters["@NormalLink"].Value = tbNormalLink.Text.Trim();
                cmd.Parameters["@ReviewOnly"].Value = tbReviewOnly.Text.Trim();
                cmd.Parameters["@Modular"].Value = rblModular.SelectedValue;
                cmd.Parameters["@ModularDesc"].Value = tbModularDesc.Text.Trim();
                cmd.Parameters["@Representative"].Value = rblRepresentative.SelectedValue;
                cmd.Parameters["@RepresentativeDesc"].Value = tbRepresentativeDesc.Text.Trim();
                cmd.Parameters["@LabLeadTime"].Value = tbLabLeadTime.Text.Trim();
                cmd.Parameters["@BodyLeadTime"].Value = tbBodyLeadTime.Text.Trim();
                cmd.Parameters["@AuthorityLeadTime"].Value = tbAuthorityLeadTime.Text.Trim();
                cmd.Parameters["@ExpeditedProcess"].Value = rblExpeditedProcess.SelectedValue;
                cmd.Parameters["@ExpeditedProcessDesc"].Value = tbExpeditedProcessDesc.Text.Trim();
                cmd.Parameters["@ControlByCertificate"].Value = cbControlByCertificate.Checked;
                cmd.Parameters["@ControlByModel"].Value = cbControlByModel.Checked;
                cmd.Parameters["@ControlByID"].Value = cbControlByID.Checked;
                cmd.Parameters["@ControlByOther"].Value = tbControlByOther.Text.Trim();
                cmd.Parameters["@MMNamesListed"].Value = rblMMNamesListed.SelectedValue;
                cmd.Parameters["@AfterApproval"].Value = rblAfterApproval.SelectedValue;
                cmd.Parameters["@ModelDesc"].Value = tbModelDesc.Text.Trim();
                cmd.Parameters["@ForeignApplicant"].Value = rblForeignApplicant.SelectedValue;
                cmd.Parameters["@AnyLocalPerson"].Value = rblAnyLocalPerson.SelectedValue;
                cmd.Parameters["@ActualImporter"].Value = rblActualImporter.SelectedValue;
                cmd.Parameters["@LocalDealer"].Value = rblLocalDealer.SelectedValue;
                cmd.Parameters["@CertificateHolderDesc"].Value = tbCertificateHolderDesc.Text.Trim();
                cmd.Parameters["@OriginRequired"].Value = rblOriginRequired.SelectedValue;
                cmd.Parameters["@QualityRequired"].Value = rblQualityRequired.SelectedValue;
                cmd.Parameters["@RequiredDesc"].Value = tbRequiredDesc.Text.Trim();
                cmd.Parameters["@ContractRequired"].Value = rblContractRequired.SelectedValue;
                cmd.Parameters["@NotarizedPoARequired"].Value = rblNotarizedPoARequired.SelectedValue;
                cmd.Parameters["@CertificateIDCreateBy"].Value = rblCertificateIDCreateBy.SelectedValue;
                cmd.Parameters["@GetCertificateNumber"].Value = rblGetCertificateNumber.SelectedValue;
                cmd.Parameters["@Validity"].Value = rblValidity.SelectedValue;
                cmd.Parameters["@ValidityDesc"].Value = tbValidityDesc.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    //Attach sample File
                    CopyDocData(gvFile1, intGeneralID);
                    //Transfer File
                    CopyDocData(gvFile2, intGeneralID);
                    CopyDocData(gvFile3, intGeneralID);
                    CopyDocData(gvFile4, intGeneralID);
                    CopyDocData(gvFile5, intGeneralID);
                    CopyDocData(gvFile6, intGeneralID);
                    CopyDocData(gvFile7, intGeneralID);
                    CopyDocData(gvFile8, intGeneralID);
                }
            }
        }
        BackURL();
    }

    //
    protected void CopyDocData(GridView gv, int intGeneralID)
    {
        foreach (GridViewRow gvr in gv.Rows)
        {
            CheckBox chSelCopy = (CheckBox)gvr.FindControl("chSelCopy");
            if (chSelCopy.Checked)
            {
                //複制檔案資料
                CopyDoc(intGeneralID, gv.DataKeys[gvr.RowIndex].Values[0].ToString());
                //複制檔案
                Label lblFileURL = (Label)gvr.FindControl("lblFileURL");
                string strFileURLO = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim();
                string strFileURLN = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim().Replace(@"\" + lblProTypeName.Text.Trim() + @"\", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
                if (strFileURLO != strFileURLN)
                {
                    //上傳檔案路徑
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\ApplicationProcedures\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intGAID, string strGAFID)
    {
        string strTsql = "insert into Ima_Application_Files (ApplicationID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @ApplicationID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Application_Files where ApplicationFileID=@ApplicationFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@ApplicationID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@ApplicationFileID", strGAFID);
        SQLUtil.ExecuteSql(cmd);
    }

    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        //Attach sample certificate附件
        GeneralFileUpload(intGeneralID, fuGeneral1, "A");
        GeneralFileUpload(intGeneralID, fuGeneral2, "A");
        GeneralFileUpload(intGeneralID, fuGeneral3, "A");
        GeneralFileUpload(intGeneralID, fuGeneral4, "A");
        GeneralFileUpload(intGeneralID, fuGeneral5, "A");
        //其他附件
        GeneralFileUpload(intGeneralID, FileUpload1, "B");
        GeneralFileUpload(intGeneralID, FileUpload2, "B");
        GeneralFileUpload(intGeneralID, FileUpload3, "B");
        GeneralFileUpload(intGeneralID, FileUpload4, "B");
        GeneralFileUpload(intGeneralID, FileUpload5, "B");

        GeneralFileUpload(intGeneralID, FileUpload6, "C");
        GeneralFileUpload(intGeneralID, FileUpload7, "C");
        GeneralFileUpload(intGeneralID, FileUpload8, "C");
        GeneralFileUpload(intGeneralID, FileUpload9, "C");
        GeneralFileUpload(intGeneralID, FileUpload10, "C");

        GeneralFileUpload(intGeneralID, FileUpload11, "D");
        GeneralFileUpload(intGeneralID, FileUpload12, "D");
        GeneralFileUpload(intGeneralID, FileUpload13, "D");
        GeneralFileUpload(intGeneralID, FileUpload14, "D");
        GeneralFileUpload(intGeneralID, FileUpload15, "D");

        GeneralFileUpload(intGeneralID, FileUpload16, "E");
        GeneralFileUpload(intGeneralID, FileUpload17, "E");
        GeneralFileUpload(intGeneralID, FileUpload18, "E");
        GeneralFileUpload(intGeneralID, FileUpload19, "E");
        GeneralFileUpload(intGeneralID, FileUpload20, "E");

        GeneralFileUpload(intGeneralID, FileUpload21, "F");
        GeneralFileUpload(intGeneralID, FileUpload22, "F");
        GeneralFileUpload(intGeneralID, FileUpload23, "F");
        GeneralFileUpload(intGeneralID, FileUpload24, "F");
        GeneralFileUpload(intGeneralID, FileUpload25, "F");

        GeneralFileUpload(intGeneralID, FileUpload26, "G");
        GeneralFileUpload(intGeneralID, FileUpload27, "G");
        GeneralFileUpload(intGeneralID, FileUpload28, "G");
        GeneralFileUpload(intGeneralID, FileUpload29, "G");
        GeneralFileUpload(intGeneralID, FileUpload30, "G");

        GeneralFileUpload(intGeneralID, FileUpload31, "H");
        GeneralFileUpload(intGeneralID, FileUpload32, "H");
        GeneralFileUpload(intGeneralID, FileUpload33, "H");
        GeneralFileUpload(intGeneralID, FileUpload34, "H");
        GeneralFileUpload(intGeneralID, FileUpload35, "H");
    }

    protected void GeneralFileUpload(int intID, FileUpload fu, string strFileCatetory)
    {
        string strFileURL = "";
        string strFileName = "";
        string strFileType = "";
        if (fu.HasFile)
        {
            //取得檔名(包含副檔名)
            strFileName = fu.FileName.Trim();
            //strFileURL = @"D:\IMA\General\" + strFileName;
            //上傳檔案路徑
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\ApplicationProcedures\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Application_Files (ApplicationID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@ApplicationID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@ApplicationID", intID);
            cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
            cmd.Parameters.AddWithValue("@FileName", strFileName);
            cmd.Parameters.AddWithValue("@FileType", strFileType);
            cmd.Parameters.AddWithValue("@FileCategory", strFileCatetory);
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            SQLUtil.ExecuteSql(cmd);
            fu.SaveAs(strFileURL);
        }
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_Application set ApprovalMethod=@ApprovalMethod,Direct=@Direct,LocalAgent=@LocalAgent,InPerson=@InPerson,HardCopy=@HardCopy,Website=@Website,Email=@Email,CD=@CD,SubmissionDesc=@SubmissionDesc";
        strTsql += ",FCCTest=@FCCTest,CETest=@CETest,LocalTest=@LocalTest,SamplesRequired=@SamplesRequired,Radiated=@Radiated,Conducted=@Conducted,NormalLink=@NormalLink,ReviewOnly=@ReviewOnly,Modular=@Modular,ModularDesc=@ModularDesc";
        strTsql += ",Representative=@Representative,RepresentativeDesc=@RepresentativeDesc,LabLeadTime=@LabLeadTime,BodyLeadTime=@BodyLeadTime,AuthorityLeadTime=@AuthorityLeadTime,ExpeditedProcess=@ExpeditedProcess,ExpeditedProcessDesc=@ExpeditedProcessDesc,ControlByCertificate=@ControlByCertificate";
        strTsql += ",ControlByModel=@ControlByModel,ControlByID=@ControlByID,ControlByOther=@ControlByOther,MMNamesListed=@MMNamesListed,AfterApproval=@AfterApproval,ModelDesc=@ModelDesc,ForeignApplicant=@ForeignApplicant,AnyLocalPerson=@AnyLocalPerson,ActualImporter=@ActualImporter";
        strTsql += ",LocalDealer=@LocalDealer,CertificateHolderDesc=@CertificateHolderDesc,OriginRequired=@OriginRequired,QualityRequired=@QualityRequired,RequiredDesc=@RequiredDesc,ContractRequired=@ContractRequired,NotarizedPoARequired=@NotarizedPoARequired,CertificateIDCreateBy=@CertificateIDCreateBy,GetCertificateNumber=@GetCertificateNumber";
        strTsql += ",Validity=@Validity,ValidityDesc=@ValidityDesc,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ApplicationID=@ApplicationID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@ApplicationID", Request["aid"]);
        cmd.Parameters.AddWithValue("@ApprovalMethod", tbApprovalMethod.Text.Trim());
        cmd.Parameters.AddWithValue("@Direct", cbDirect.Checked);
        cmd.Parameters.AddWithValue("@LocalAgent", cbLocalAgent.Checked);
        cmd.Parameters.AddWithValue("@InPerson", rblInPerson.SelectedValue);
        cmd.Parameters.AddWithValue("@HardCopy", rblHardCopy.SelectedValue);
        cmd.Parameters.AddWithValue("@Website", rblWebsite.SelectedValue);
        cmd.Parameters.AddWithValue("@Email", rblEmail.SelectedValue);
        cmd.Parameters.AddWithValue("@CD", rblCD.SelectedValue);
        cmd.Parameters.AddWithValue("@SubmissionDesc", tbSubmissionDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@FCCTest", cbFCCTest.Checked);
        cmd.Parameters.AddWithValue("@CETest", cbCETest.Checked);
        cmd.Parameters.AddWithValue("@LocalTest", cbLocalTest.Checked);
        cmd.Parameters.AddWithValue("@SamplesRequired", cbSamplesRequired.Checked);
        cmd.Parameters.AddWithValue("@Radiated", tbRadiated.Text.Trim());
        cmd.Parameters.AddWithValue("@Conducted", tbConducted.Text.Trim());
        cmd.Parameters.AddWithValue("@NormalLink", tbNormalLink.Text.Trim());
        cmd.Parameters.AddWithValue("@ReviewOnly", tbReviewOnly.Text.Trim());
        cmd.Parameters.AddWithValue("@Modular", rblModular.SelectedValue);
        cmd.Parameters.AddWithValue("@ModularDesc", tbModularDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@Representative", rblRepresentative.SelectedValue);
        cmd.Parameters.AddWithValue("@RepresentativeDesc", tbRepresentativeDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LabLeadTime", tbLabLeadTime.Text.Trim());
        cmd.Parameters.AddWithValue("@BodyLeadTime", tbBodyLeadTime.Text.Trim());
        cmd.Parameters.AddWithValue("@AuthorityLeadTime", tbAuthorityLeadTime.Text.Trim());
        cmd.Parameters.AddWithValue("@ExpeditedProcess", rblExpeditedProcess.SelectedValue);
        cmd.Parameters.AddWithValue("@ExpeditedProcessDesc", tbExpeditedProcessDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@ControlByCertificate", cbControlByCertificate.Checked);
        cmd.Parameters.AddWithValue("@ControlByModel", cbControlByModel.Checked);
        cmd.Parameters.AddWithValue("@ControlByID", cbControlByID.Checked);
        cmd.Parameters.AddWithValue("@ControlByOther", tbControlByOther.Text.Trim());
        cmd.Parameters.AddWithValue("@MMNamesListed", rblMMNamesListed.SelectedValue);
        cmd.Parameters.AddWithValue("@AfterApproval", rblAfterApproval.SelectedValue);
        cmd.Parameters.AddWithValue("@ModelDesc", tbModelDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@ForeignApplicant", rblForeignApplicant.SelectedValue);
        cmd.Parameters.AddWithValue("@AnyLocalPerson", rblAnyLocalPerson.SelectedValue);
        cmd.Parameters.AddWithValue("@ActualImporter", rblActualImporter.SelectedValue);
        cmd.Parameters.AddWithValue("@LocalDealer", rblLocalDealer.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificateHolderDesc", tbCertificateHolderDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@OriginRequired", rblOriginRequired.SelectedValue);
        cmd.Parameters.AddWithValue("@QualityRequired", rblQualityRequired.SelectedValue);
        cmd.Parameters.AddWithValue("@RequiredDesc", tbRequiredDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@ContractRequired", rblContractRequired.SelectedValue);
        cmd.Parameters.AddWithValue("@NotarizedPoARequired", rblNotarizedPoARequired.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificateIDCreateBy", rblCertificateIDCreateBy.SelectedValue);
        cmd.Parameters.AddWithValue("@GetCertificateNumber", rblGetCertificateNumber.SelectedValue);
        cmd.Parameters.AddWithValue("@Validity", rblValidity.SelectedValue);
        cmd.Parameters.AddWithValue("@ValidityDesc", tbValidityDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["aid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "aid", "copy" }));
    }

    /// <summary>
    /// 下一頁的 Get 參數設定
    /// </summary>
    /// <param name="isClear">是否清除URL的參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    private string GetQueryString(bool isClear, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        //預設參數
        Dictionary<string, string> dic = new Dictionary<string, string>();
        return IMAUtil.SetQueryString(isClear, dic, dicAdd, strRemove);
    }

    protected void cbSamplesRequired_CheckedChanged(object sender, EventArgs e)
    {
        trSamplesRequired.Visible = true;
        trSamplesRequired1.Visible = true;
        trSamplesRequired2.Visible = true;
        trSamplesRequired3.Visible = true;
        trSamplesRequired4.Visible = true;
        if (cbSamplesRequired.Checked) 
        {
            trSamplesRequired.Visible = false;
            trSamplesRequired1.Visible = false;
            trSamplesRequired2.Visible = false;
            trSamplesRequired3.Visible = false;
            trSamplesRequired4.Visible = false;
        }
    }
}