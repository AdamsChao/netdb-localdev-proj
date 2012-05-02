using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;


public partial class Ima_ImaFeeSchedule : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    //載入選項
    protected void BindItem()
    {
        ////Tech_RF
        //cbTechRF.DataBind();
        //foreach (ListItem li in cbTechRF.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechRF.Items.Count > 0) { cbTechRF.Items.Insert(0, new ListItem("All", "0")); cbTechRF.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_EMC
        //cbTechEMC.DataBind();
        //foreach (ListItem li in cbTechEMC.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechEMC.Items.Count > 0) { cbTechEMC.Items.Insert(0, new ListItem("All", "0")); cbTechEMC.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_Safety
        //cbTechSafety.DataBind();
        //foreach (ListItem li in cbTechSafety.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechSafety.Items.Count > 0) { cbTechSafety.Items.Insert(0, new ListItem("All", "0")); cbTechSafety.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_Telecom
        //cbTechTelecom.DataBind();
        //foreach (ListItem li in cbTechTelecom.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechTelecom.Items.Count > 0) { cbTechTelecom.Items.Insert(0, new ListItem("All", "0")); cbTechTelecom.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
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
                tbAgentHandling.Text = dt.Rows[0]["AgentHandling"].ToString();
                tbAuthoritySubmission.Text = dt.Rows[0]["AuthoritySubmission"].ToString();
                tbBodySubmission.Text = dt.Rows[0]["BodySubmission"].ToString();
                tbLabTesting.Text = dt.Rows[0]["LabTesting"].ToString();
                tbDocumentTranslation.Text = dt.Rows[0]["DocumentTranslation"].ToString();
                tbBank.Text = dt.Rows[0]["Bank"].ToString();
                tbCustomClearance.Text = dt.Rows[0]["CustomClearance"].ToString();
                tbSampleReturn.Text = dt.Rows[0]["SampleReturn"].ToString();
                tbLabelPurchase.Text = dt.Rows[0]["LabelPurchase"].ToString();
                tbOther.Text = dt.Rows[0]["Other"].ToString();                
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                lblProTypeName1.Text = lblProTypeName.Text + "：";
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
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); lblProTypeName1.Text = lblProTypeName.Text + "："; }
        }
        lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_FeeSchedule (world_region_id,country_id,wowi_product_type_id,AgentHandling,AuthoritySubmission,BodySubmission,LabTesting,DocumentTranslation,Bank,CustomClearance,SampleReturn,LabelPurchase,Other,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@AgentHandling,@AuthoritySubmission,@BodySubmission,@LabTesting,@DocumentTranslation,@Bank,@CustomClearance,@SampleReturn,@LabelPurchase,@Other,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@AgentHandling", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AuthoritySubmission", SqlDbType.NVarChar);
        cmd.Parameters.Add("@BodySubmission", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LabTesting", SqlDbType.NVarChar);
        cmd.Parameters.Add("@DocumentTranslation", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Bank", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CustomClearance", SqlDbType.NVarChar);
        cmd.Parameters.Add("@SampleReturn", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LabelPurchase", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Other", SqlDbType.NVarChar);
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
                cmd.Parameters["world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@AgentHandling"].Value = tbAgentHandling.Text.Trim();
                cmd.Parameters["@AuthoritySubmission"].Value = tbAuthoritySubmission.Text.Trim();
                cmd.Parameters["@BodySubmission"].Value = tbBodySubmission.Text.Trim();
                cmd.Parameters["@LabTesting"].Value = tbLabTesting.Text.Trim();
                cmd.Parameters["@DocumentTranslation"].Value = tbDocumentTranslation.Text.Trim();
                cmd.Parameters["@Bank"].Value = tbBank.Text.Trim();
                cmd.Parameters["@CustomClearance"].Value = tbCustomClearance.Text.Trim();
                cmd.Parameters["@SampleReturn"].Value = tbSampleReturn.Text.Trim();
                cmd.Parameters["@LabelPurchase"].Value = tbLabelPurchase.Text.Trim();
                cmd.Parameters["@Other"].Value = tbOther.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\Feeschedule\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_FeeSchedule_Files (FeeScheduleID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@FeeScheduleID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@FeeScheduleID", intID);
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
        string strTsql = "Update Ima_FeeSchedule set AgentHandling=@AgentHandling,AuthoritySubmission=@AuthoritySubmission,BodySubmission=@BodySubmission,LabTesting=@LabTesting,DocumentTranslation=@DocumentTranslation,Bank=@Bank,CustomClearance=@CustomClearance,SampleReturn=@SampleReturn,LabelPurchase=@LabelPurchase,Other=@Other,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where FeeScheduleID=@FeeScheduleID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@FeeScheduleID", Request["fsid"]);
        cmd.Parameters.AddWithValue("@AgentHandling", tbAgentHandling.Text.Trim());
        cmd.Parameters.AddWithValue("@AuthoritySubmission", tbAuthoritySubmission.Text.Trim());
        cmd.Parameters.AddWithValue("@BodySubmission", tbBodySubmission.Text.Trim());
        cmd.Parameters.AddWithValue("@LabTesting", tbLabTesting.Text.Trim());
        cmd.Parameters.AddWithValue("@DocumentTranslation", tbDocumentTranslation.Text.Trim());
        cmd.Parameters.AddWithValue("@Bank", tbBank.Text.Trim());
        cmd.Parameters.AddWithValue("@CustomClearance", tbCustomClearance.Text.Trim());
        cmd.Parameters.AddWithValue("@SampleReturn", tbSampleReturn.Text.Trim());
        cmd.Parameters.AddWithValue("@LabelPurchase", tbLabelPurchase.Text.Trim());
        cmd.Parameters.AddWithValue("@Other", tbOther.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
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
}