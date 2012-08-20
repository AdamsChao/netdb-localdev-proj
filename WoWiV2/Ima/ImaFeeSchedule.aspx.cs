using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

public partial class Ima_ImaFeeSchedule : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
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
        tbAgentFee.Text = "";
        if (ds.Tables[0].Rows.Count > 0)
        {
            //tbAgentFee.Text = ds.Tables[0].Rows[0]["Fee"].ToString();
            ddlLocalAgent.Items.Insert(0, new ListItem("-Select-", "-1"));
        }        
        
        //Authority
        ddlAuthority.DataSource = ds.Tables[1];
        ddlAuthority.DataTextField = "AbbreviatedAuthorityName";
        ddlAuthority.DataValueField = "GovernmentAuthorityID";
        ddlAuthority.DataBind();
        tbAuthorityFee.Text = "";
        if (ds.Tables[1].Rows.Count > 0)
        {
            //tbAuthorityFee.Text = ds.Tables[1].Rows[0]["Fee"].ToString();
            ddlAuthority.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
       
        //Certification Body
        ddlCertification.DataSource = ds.Tables[2];
        ddlCertification.DataTextField = "Name";
        ddlCertification.DataValueField = "CertificationBodiesID";
        ddlCertification.DataBind();
        tbCertificationBodyFee.Text = "";
        if (ds.Tables[2].Rows.Count > 0)
        {
            //tbCertificationBodyFee.Text = ds.Tables[2].Rows[0]["Fee"].ToString();
            ddlCertification.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
        
        //Accredited Test Lab
        ddlAccredited.DataSource = ds.Tables[3];
        ddlAccredited.DataTextField = "AccreditedLab";
        ddlAccredited.DataValueField = "AccreditedTestID";
        ddlAccredited.DataBind();
        tbLabTestFee.Text = "";
        if (ds.Tables[3].Rows.Count > 0)
        {
            //tbLabTestFee.Text = ds.Tables[3].Rows[0]["Fee"].ToString();
            ddlAccredited.Items.Insert(0, new ListItem("-Select-", "-1"));
        }
        
        //Factory Inspection Fee
        tbDocumentFee.Text = "";
        tbOneTimeFee.Text = "";
        tbPeriodicFee.Text = "";
        if (ds.Tables[4].Rows.Count > 0)
        {
            tbDocumentFee.Text = ds.Tables[4].Rows[0]["DocumentFee"].ToString();
            tbOneTimeFee.Text = ds.Tables[4].Rows[0]["OneTimeFee"].ToString();
            tbPeriodicFee.Text = ds.Tables[4].Rows[0]["PeriodicFee"].ToString();
        }
        //Renewal Fee
        tbRenewalWTest.Text = "";
        tbRenewalWOTest.Text = "";
        if (ds.Tables[5].Rows.Count > 0)
        {
            tbRenewalWTest.Text = ds.Tables[5].Rows[0]["CostTest1"].ToString();
            tbRenewalWOTest.Text = ds.Tables[5].Rows[0]["CostTest2"].ToString();
        }
    }
       
    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Fee schedule Edit";
        string strID = Request["fsid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvImaFiles1.Columns[0].Visible = false;
        gvImaFiles1.Columns[1].Visible = false;
        gvFile2.Columns[0].Visible = false;
        gvFile2.Columns[1].Visible = false;
        gvFile3.Columns[0].Visible = false;
        gvFile3.Columns[1].Visible = false;
        gvFile4.Columns[0].Visible = false;
        gvFile4.Columns[1].Visible = false;
        gvFile5.Columns[0].Visible = false;
        gvFile5.Columns[1].Visible = false;
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
                ddlLocalAgent.SelectedValue = dt.Rows[0]["LocalAgentID"].ToString();
                ddlAuthority.SelectedValue = dt.Rows[0]["GovernmentAuthorityID"].ToString();
                ddlCertification.SelectedValue = dt.Rows[0]["CertificationBodiesID"].ToString();
                ddlAccredited.SelectedValue = dt.Rows[0]["AccreditedTestID"].ToString();
                //if (dt.Rows[0]["AgentFee"].ToString().Trim().Length > 0) { tbAgentFee.Text = dt.Rows[0]["AgentFee"].ToString(); }
                //if (dt.Rows[0]["AuthorityFee"].ToString().Trim().Length > 0) { tbAuthorityFee.Text = dt.Rows[0]["AuthorityFee"].ToString(); }
                //if (dt.Rows[0]["CertificationBodyFee"].ToString().Trim().Length > 0) { tbCertificationBodyFee.Text = dt.Rows[0]["CertificationBodyFee"].ToString(); }
                //if (dt.Rows[0]["LabTestFee"].ToString().Trim().Length > 0) { tbLabTestFee.Text = dt.Rows[0]["LabTestFee"].ToString(); }
                //if (dt.Rows[0]["DocTranslationFee"].ToString().Trim().Length > 0) { tbDocTranslationFee.Text = dt.Rows[0]["DocTranslationFee"].ToString(); }
                //if (dt.Rows[0]["BankFee"].ToString().Trim().Length > 0) { tbBankFee.Text = dt.Rows[0]["BankFee"].ToString(); }
                //if (dt.Rows[0]["ClearanceFee"].ToString().Trim().Length > 0) { tbClearanceFee.Text = dt.Rows[0]["ClearanceFee"].ToString(); }
                //if (dt.Rows[0]["SampleReturnFee"].ToString().Trim().Length > 0) { tbSampleReturnFee.Text = dt.Rows[0]["SampleReturnFee"].ToString(); }
                //if (dt.Rows[0]["LabelPurchaseFee"].ToString().Trim().Length > 0) { tbLabelPurchaseFee.Text = dt.Rows[0]["LabelPurchaseFee"].ToString(); }
                //if (dt.Rows[0]["OtherFee"].ToString().Trim().Length > 0) { tbOtherFee.Text = dt.Rows[0]["OtherFee"].ToString(); }
                //if (dt.Rows[0]["DocumentFee"].ToString().Trim().Length > 0) { tbDocumentFee.Text = dt.Rows[0]["DocumentFee"].ToString(); }                
                //if (dt.Rows[0]["OneTimeFee"].ToString().Trim().Length > 0) { tbOneTimeFee.Text = dt.Rows[0]["OneTimeFee"].ToString(); }
                //if (dt.Rows[0]["PeriodicFee"].ToString().Trim().Length > 0) { tbPeriodicFee.Text = dt.Rows[0]["PeriodicFee"].ToString(); }
                //if (dt.Rows[0]["RenewalWTest"].ToString().Trim().Length > 0) { tbRenewalWTest.Text = dt.Rows[0]["RenewalWTest"].ToString(); }
                //if (dt.Rows[0]["RenewalWOTest"].ToString().Trim().Length > 0) { tbRenewalWOTest.Text = dt.Rows[0]["RenewalWOTest"].ToString(); }
                //if (dt.Rows[0]["TotalCostFee"].ToString().Trim().Length > 0) { tbTotalCostFee.Text = dt.Rows[0]["TotalCostFee"].ToString(); }
                tbAgentFee.Text = dt.Rows[0]["AgentFee"].ToString();
                tbAuthorityFee.Text = dt.Rows[0]["AuthorityFee"].ToString();
                tbCertificationBodyFee.Text = dt.Rows[0]["CertificationBodyFee"].ToString();
                tbLabTestFee.Text = dt.Rows[0]["LabTestFee"].ToString();
                tbDocTranslationFee.Text = dt.Rows[0]["DocTranslationFee"].ToString();
                tbBankFee.Text = dt.Rows[0]["BankFee"].ToString();
                tbClearanceFee.Text = dt.Rows[0]["ClearanceFee"].ToString();
                tbSampleReturnFee.Text = dt.Rows[0]["SampleReturnFee"].ToString();
                tbLabelPurchaseFee.Text = dt.Rows[0]["LabelPurchaseFee"].ToString();
                tbOtherFee.Text = dt.Rows[0]["OtherFee"].ToString();
                tbDocumentFee.Text = dt.Rows[0]["DocumentFee"].ToString();
                tbOneTimeFee.Text = dt.Rows[0]["OneTimeFee"].ToString();
                tbPeriodicFee.Text = dt.Rows[0]["PeriodicFee"].ToString();
                tbRenewalWTest.Text = dt.Rows[0]["RenewalWTest"].ToString();
                tbRenewalWOTest.Text = dt.Rows[0]["RenewalWOTest"].ToString();
                tbTotalCostFee.Text = dt.Rows[0]["TotalCostFee"].ToString();
                tbLeadTime.Text = dt.Rows[0]["LeadTime"].ToString();
                //lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                //lblProTypeName1.Text = lblProTypeName.Text + "：";
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Fee schedule Copy";
                    gvImaFiles1.Columns[1].Visible = true;
                    gvFile2.Columns[1].Visible = true;
                    gvFile3.Columns[1].Visible = true;
                    gvFile4.Columns[1].Visible = true;
                    gvFile5.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvImaFiles1.Columns[0].Visible = true;
                    gvFile2.Columns[0].Visible = true;
                    gvFile3.Columns[0].Visible = true;
                    gvFile4.Columns[0].Visible = true;
                    gvFile5.Columns[0].Visible = true;
                }
            }
        }
        else
        {
            btnSave.Visible = true;
            trProductType.Visible = true;
            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) 
            {
                lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); 
                //lblProTypeName1.Text = lblProTypeName.Text + "：";
            }
        }
        lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_FeeSchedule (world_region_id,country_id,wowi_product_type_id,wowi_tech_id,AgentFee,LocalAgentID,GovernmentAuthorityID,AuthorityFee,CertificationBodiesID,CertificationBodyFee,AccreditedTestID,LabTestFee,DocTranslationFee,BankFee,ClearanceFee,SampleReturnFee,LabelPurchaseFee,OtherFee,CreateUser,LasterUpdateUser,DocumentFee,OneTimeFee,PeriodicFee,RenewalWTest,RenewalWOTest,TotalCostFee,LeadTime) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@wowi_tech_id,@AgentFee,@LocalAgentID,@GovernmentAuthorityID,@AuthorityFee,@CertificationBodiesID,@CertificationBodyFee,@AccreditedTestID,@LabTestFee,@DocTranslationFee,@BankFee,@ClearanceFee,@SampleReturnFee,@LabelPurchaseFee,@OtherFee,@CreateUser,@LasterUpdateUser,@DocumentFee,@OneTimeFee,@PeriodicFee,@RenewalWTest,@RenewalWOTest,@TotalCostFee,@LeadTime)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.Add("@AgentFee", SqlDbType.Decimal);
        cmd.Parameters.AddWithValue("@LocalAgentID", ddlLocalAgent.SelectedValue);
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", ddlAuthority.SelectedValue);
        cmd.Parameters.Add("@AuthorityFee", SqlDbType.Decimal);
        cmd.Parameters.AddWithValue("@CertificationBodiesID", ddlCertification.SelectedValue);
        cmd.Parameters.Add("@CertificationBodyFee", SqlDbType.Decimal);
        cmd.Parameters.AddWithValue("@AccreditedTestID", ddlAccredited.SelectedValue);
        cmd.Parameters.Add("@LabTestFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@DocTranslationFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@BankFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@ClearanceFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@SampleReturnFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@LabelPurchaseFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@OtherFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@DocumentFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@OneTimeFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@PeriodicFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@RenewalWTest", SqlDbType.Decimal);
        cmd.Parameters.Add("@RenewalWOTest", SqlDbType.Decimal);
        cmd.Parameters.Add("@TotalCostFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@LeadTime", SqlDbType.NVarChar);

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
                cmd.Parameters["world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;                
                if (tbAgentFee.Text.Trim().Length > 0) { cmd.Parameters["@AgentFee"].Value = tbAgentFee.Text.Trim(); }
                else { cmd.Parameters["@AgentFee"].Value = DBNull.Value; }                
                if (tbAuthorityFee.Text.Trim().Length > 0) { cmd.Parameters["@AuthorityFee"].Value = tbAuthorityFee.Text.Trim(); }
                else { cmd.Parameters["@AuthorityFee"].Value = DBNull.Value; }
                if (tbCertificationBodyFee.Text.Trim().Length > 0) { cmd.Parameters["@CertificationBodyFee"].Value = tbCertificationBodyFee.Text.Trim(); }
                else { cmd.Parameters["@CertificationBodyFee"].Value = DBNull.Value; }
                if (tbLabTestFee.Text.Trim().Length > 0) { cmd.Parameters["@LabTestFee"].Value = tbLabTestFee.Text.Trim(); }
                else { cmd.Parameters["@LabTestFee"].Value = DBNull.Value; }
                if (tbDocTranslationFee.Text.Trim().Length > 0) { cmd.Parameters["@DocTranslationFee"].Value = tbDocTranslationFee.Text.Trim(); }
                else { cmd.Parameters["@DocTranslationFee"].Value = DBNull.Value; }
                if (tbBankFee.Text.Trim().Length > 0) { cmd.Parameters["@BankFee"].Value = tbBankFee.Text.Trim(); }
                else { cmd.Parameters["@BankFee"].Value = DBNull.Value; }
                if (tbClearanceFee.Text.Trim().Length > 0) { cmd.Parameters["@ClearanceFee"].Value = tbClearanceFee.Text.Trim(); }
                else { cmd.Parameters["@ClearanceFee"].Value = DBNull.Value; }
                if (tbSampleReturnFee.Text.Trim().Length > 0) { cmd.Parameters["@SampleReturnFee"].Value = tbSampleReturnFee.Text.Trim(); }
                else { cmd.Parameters["@SampleReturnFee"].Value = DBNull.Value; }
                if (tbLabelPurchaseFee.Text.Trim().Length > 0) { cmd.Parameters["@LabelPurchaseFee"].Value = tbLabelPurchaseFee.Text.Trim(); }
                else { cmd.Parameters["@LabelPurchaseFee"].Value = DBNull.Value; }
                if (tbOtherFee.Text.Trim().Length > 0) { cmd.Parameters["@OtherFee"].Value = tbOtherFee.Text.Trim(); }
                else { cmd.Parameters["@OtherFee"].Value = DBNull.Value; }
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                if (tbDocumentFee.Text.Trim().Length > 0) { cmd.Parameters["@DocumentFee"].Value = tbDocumentFee.Text.Trim(); }
                else { cmd.Parameters["@DocumentFee"].Value = DBNull.Value; }
                if (tbOneTimeFee.Text.Trim().Length > 0) { cmd.Parameters["@OneTimeFee"].Value = tbOneTimeFee.Text.Trim(); }
                else { cmd.Parameters["@OneTimeFee"].Value = DBNull.Value; }
                if (tbPeriodicFee.Text.Trim().Length > 0) { cmd.Parameters["@PeriodicFee"].Value = tbPeriodicFee.Text.Trim(); }
                else { cmd.Parameters["@PeriodicFee"].Value = DBNull.Value; }
                if (tbRenewalWTest.Text.Trim().Length > 0) { cmd.Parameters["@RenewalWTest"].Value = tbRenewalWTest.Text.Trim(); }
                else { cmd.Parameters["@RenewalWTest"].Value = DBNull.Value; }
                if (tbRenewalWOTest.Text.Trim().Length > 0) { cmd.Parameters["@RenewalWOTest"].Value = tbRenewalWOTest.Text.Trim(); }
                else { cmd.Parameters["@RenewalWOTest"].Value = DBNull.Value; }
                cmd.Parameters["@TotalCostFee"].Value = GetTotalCost();
                cmd.Parameters["@LeadTime"].Value = tbLeadTime.Text.Trim();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    //Authority submission 
                    CopyDocData(gvImaFiles1, intGeneralID);
                    //Body submission 
                    CopyDocData(gvFile2, intGeneralID);
                    //Lab Testing 
                    CopyDocData(gvFile3, intGeneralID);
                    //Label purchase 
                    CopyDocData(gvFile4, intGeneralID);
                    //Other  
                    CopyDocData(gvFile5, intGeneralID);
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\Feeschedule\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_FeeSchedule_Files (FeeScheduleID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @FeeScheduleID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_FeeSchedule_Files where FeeScheduleFileID=@FeeScheduleFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@FeeScheduleID", intGAID);//lblProTypeName
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@FeeScheduleFileID", strGAFID);
        SQLUtil.ExecuteSql(cmd);
    }

    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        //上傳檔案路徑
        string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\FeeSchedule\" + IMAUtil.GetProductType(lblProType.Text.Trim());

        imau.FileUpload(intGeneralID, fuGeneral1, "A", strUploadPath);
        imau.FileUpload(intGeneralID, fuGeneral2, "A", strUploadPath);
        imau.FileUpload(intGeneralID, fuGeneral3, "A", strUploadPath);
        imau.FileUpload(intGeneralID, fuGeneral4, "A", strUploadPath);
        imau.FileUpload(intGeneralID, fuGeneral5, "A", strUploadPath);

        imau.FileUpload(intGeneralID, FileUpload1, "B", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload2, "B", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload3, "B", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload4, "B", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload5, "B", strUploadPath);

        imau.FileUpload(intGeneralID, FileUpload6, "C", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload7, "C", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload8, "C", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload9, "C", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload10, "C", strUploadPath);

        imau.FileUpload(intGeneralID, FileUpload11, "D", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload12, "D", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload13, "D", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload14, "D", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload15, "D", strUploadPath);

        imau.FileUpload(intGeneralID, FileUpload16, "E", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload17, "E", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload18, "E", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload19, "E", strUploadPath);
        imau.FileUpload(intGeneralID, FileUpload20, "E", strUploadPath);

        ////Attach sample certificate附件
        //GeneralFileUpload(intGeneralID, fuGeneral1, "A");
        //GeneralFileUpload(intGeneralID, fuGeneral2, "A");
        //GeneralFileUpload(intGeneralID, fuGeneral3, "A");
        //GeneralFileUpload(intGeneralID, fuGeneral4, "A");
        //GeneralFileUpload(intGeneralID, fuGeneral5, "A");
        ////其他附件
        //GeneralFileUpload(intGeneralID, FileUpload1, "B");
        //GeneralFileUpload(intGeneralID, FileUpload2, "B");
        //GeneralFileUpload(intGeneralID, FileUpload3, "B");
        //GeneralFileUpload(intGeneralID, FileUpload4, "B");
        //GeneralFileUpload(intGeneralID, FileUpload5, "B");

        //GeneralFileUpload(intGeneralID, FileUpload6, "C");
        //GeneralFileUpload(intGeneralID, FileUpload7, "C");
        //GeneralFileUpload(intGeneralID, FileUpload8, "C");
        //GeneralFileUpload(intGeneralID, FileUpload9, "C");
        //GeneralFileUpload(intGeneralID, FileUpload10, "C");

        //GeneralFileUpload(intGeneralID, FileUpload11, "D");
        //GeneralFileUpload(intGeneralID, FileUpload12, "D");
        //GeneralFileUpload(intGeneralID, FileUpload13, "D");
        //GeneralFileUpload(intGeneralID, FileUpload14, "D");
        //GeneralFileUpload(intGeneralID, FileUpload15, "D");

        //GeneralFileUpload(intGeneralID, FileUpload16, "E");
        //GeneralFileUpload(intGeneralID, FileUpload17, "E");
        //GeneralFileUpload(intGeneralID, FileUpload18, "E");
        //GeneralFileUpload(intGeneralID, FileUpload19, "E");
        //GeneralFileUpload(intGeneralID, FileUpload20, "E");
    }

    //protected void GeneralFileUpload(int intID, FileUpload fu, string strFileCatetory)
    //{
    //    string strFileURL = "";
    //    string strFileName = "";
    //    string strFileType = "";
    //    if (fu.HasFile)
    //    {
    //        //取得檔名(包含副檔名)
    //        strFileName = fu.FileName.Trim();
    //        //strFileURL = @"D:\IMA\General\" + strFileName;
    //        //上傳檔案路徑
    //        string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\FeeSchedule\" + IMAUtil.GetProductType(lblProType.Text.Trim());
    //        //檢查上傳檔案路徑是否存在，若不存在就自動建立
    //        IMAUtil.CheckURL(strUploadPath);
    //        strFileURL = strUploadPath + @"\" + strFileName;
    //        //取得副檔名
    //        strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
    //        strFileName = strFileName.Replace("." + strFileType, "");

    //        string strTsql = "insert into Ima_FeeSchedule_Files (FeeScheduleID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
    //        strTsql += "values(@FeeScheduleID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
    //        SqlCommand cmd = new SqlCommand();
    //        cmd.CommandText = strTsql;
    //        cmd.Parameters.AddWithValue("@FeeScheduleID", intID);
    //        cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
    //        cmd.Parameters.AddWithValue("@FileName", strFileName);
    //        cmd.Parameters.AddWithValue("@FileType", strFileType);
    //        cmd.Parameters.AddWithValue("@FileCategory", strFileCatetory);
    //        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
    //        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
    //        SQLUtil.ExecuteSql(cmd);
    //        fu.SaveAs(strFileURL);
    //    }
    //}


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_FeeSchedule set wowi_tech_id=@wowi_tech_id,AgentFee=@AgentFee,LocalAgentID=@LocalAgentID,GovernmentAuthorityID=@GovernmentAuthorityID,AuthorityFee=@AuthorityFee,CertificationBodiesID=@CertificationBodiesID,CertificationBodyFee=@CertificationBodyFee,AccreditedTestID=@AccreditedTestID,LabTestFee=@LabTestFee,DocTranslationFee=@DocTranslationFee";
        strTsql += ",BankFee=@BankFee,ClearanceFee=@ClearanceFee,SampleReturnFee=@SampleReturnFee,LabelPurchaseFee=@LabelPurchaseFee,OtherFee=@OtherFee,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),DocumentFee=@DocumentFee,OneTimeFee=@OneTimeFee,PeriodicFee=@PeriodicFee,RenewalWTest=@RenewalWTest,RenewalWOTest=@RenewalWOTest,TotalCostFee=@TotalCostFee,LeadTime=@LeadTime where FeeScheduleID=@FeeScheduleID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@FeeScheduleID", Request["fsid"]);
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@LocalAgentID", ddlLocalAgent.SelectedValue);
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", ddlAuthority.SelectedValue);        
        cmd.Parameters.AddWithValue("@CertificationBodiesID", ddlCertification.SelectedValue);        
        cmd.Parameters.AddWithValue("@AccreditedTestID", ddlAccredited.SelectedValue);
        if (tbAgentFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@AgentFee", tbAgentFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@AgentFee", DBNull.Value); }        
        if (tbAuthorityFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@AuthorityFee", tbAuthorityFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@AuthorityFee", DBNull.Value); }        
        if (tbCertificationBodyFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@CertificationBodyFee", tbCertificationBodyFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@CertificationBodyFee", DBNull.Value); }
        if (tbLabTestFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LabTestFee", tbLabTestFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LabTestFee", DBNull.Value); }
        if (tbDocTranslationFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@DocTranslationFee", tbDocTranslationFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@DocTranslationFee", DBNull.Value); }
        if (tbBankFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@BankFee", tbBankFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@BankFee", DBNull.Value); }
        if (tbClearanceFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@ClearanceFee", tbClearanceFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@ClearanceFee", DBNull.Value); }
        if (tbSampleReturnFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SampleReturnFee", tbSampleReturnFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SampleReturnFee", DBNull.Value); }
        if (tbLabelPurchaseFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LabelPurchaseFee", tbLabelPurchaseFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LabelPurchaseFee", DBNull.Value); }
        if (tbOtherFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@OtherFee", tbOtherFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@OtherFee", DBNull.Value); }
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        if (tbDocumentFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@DocumentFee", tbDocumentFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@DocumentFee", DBNull.Value); }
        if (tbOneTimeFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@OneTimeFee", tbOneTimeFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@OneTimeFee", DBNull.Value); }
        if (tbPeriodicFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@PeriodicFee", tbPeriodicFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@PeriodicFee", DBNull.Value); }
        if (tbRenewalWTest.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RenewalWTest", tbRenewalWTest.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RenewalWTest", DBNull.Value); }
        if (tbRenewalWOTest.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RenewalWOTest", tbRenewalWOTest.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RenewalWOTest", DBNull.Value); }
        cmd.Parameters.AddWithValue("@TotalCostFee", GetTotalCost());
        cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["fsid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "fsid", "copy" }));
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

    //Technologies變動更新所有Fee設定
    protected void ddlTech_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetFee();
    }

    //依LocalAgent取得Fee
    protected void ddlLocalAgent_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("STP_GetImaLocalAgentFee");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@DID", ddlLocalAgent.SelectedValue);
        object obj = SQLUtil.ExecuteScalar(cmd);
        if (obj != null) { tbAgentFee.Text = obj.ToString(); }
        else { tbAgentFee.Text = ""; }
    }

    //依Authority取得Fee
    protected void ddlAuthority_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("STP_GetImaAuthorityFee");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@DID", ddlAuthority.SelectedValue);
        object obj = SQLUtil.ExecuteScalar(cmd);
        if (obj != null) { tbAuthorityFee.Text = obj.ToString(); }
        else { tbAuthorityFee.Text = ""; }
    }

    //依Certification Body取得Fee
    protected void ddlCertification_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("STP_GetImaCertificationBodyFee");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@DID", ddlCertification.SelectedValue);
        object obj = SQLUtil.ExecuteScalar(cmd);
        if (obj != null) { tbCertificationBodyFee.Text = obj.ToString(); }
        else { tbCertificationBodyFee.Text = ""; }
    }

    //依AccreditedTestLab取得Fee
    protected void ddlAccredited_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("STP_GetImaAccreditedTestLabFee");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@wowi_tech_id", ddlTech.SelectedValue);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@DID", ddlAccredited.SelectedValue);
        object obj = SQLUtil.ExecuteScalar(cmd);
        if (obj != null) { tbLabTestFee.Text = obj.ToString(); }
        else { tbLabTestFee.Text = ""; }
    }

    //計算TotalCost
    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        tbTotalCostFee.Text = GetTotalCost().ToString();
    }

    protected decimal GetTotalCost() 
    {
        decimal dTotalCost = 0;
        Regex regNumber = new Regex("^(-?\\d+)(\\.\\d+)?$");
        if (tbAgentFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbAgentFee.Text.Trim())) 
        {
            dTotalCost += Convert.ToDecimal(tbAgentFee.Text.Trim());
        }
        if (tbAuthorityFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbAuthorityFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbAuthorityFee.Text.Trim());
        }
        if (tbCertificationBodyFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbCertificationBodyFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbCertificationBodyFee.Text.Trim());
        }
        if (tbLabTestFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbLabTestFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbLabTestFee.Text.Trim());
        }
        if (tbDocTranslationFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbDocTranslationFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbDocTranslationFee.Text.Trim());
        }
        if (tbBankFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbBankFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbBankFee.Text.Trim());
        }
        if (tbClearanceFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbClearanceFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbClearanceFee.Text.Trim());
        }
        if (tbSampleReturnFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbSampleReturnFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbSampleReturnFee.Text.Trim());
        }
        if (tbLabelPurchaseFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbLabelPurchaseFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbLabelPurchaseFee.Text.Trim());
        }
        if (tbOtherFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbOtherFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbOtherFee.Text.Trim());
        }
        if (tbDocumentFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbDocumentFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbDocumentFee.Text.Trim());
        }
        if (tbOneTimeFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbOneTimeFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbOneTimeFee.Text.Trim());
        }
        if (tbPeriodicFee.Text.Trim().Length > 0 && regNumber.IsMatch(tbPeriodicFee.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbPeriodicFee.Text.Trim());
        }
        if (tbRenewalWTest.Text.Trim().Length > 0 && regNumber.IsMatch(tbRenewalWTest.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbRenewalWTest.Text.Trim());
        }
        if (tbRenewalWOTest.Text.Trim().Length > 0 && regNumber.IsMatch(tbRenewalWOTest.Text.Trim()))
        {
            dTotalCost += Convert.ToDecimal(tbRenewalWOTest.Text.Trim());
        }
        return dTotalCost;
    }
}