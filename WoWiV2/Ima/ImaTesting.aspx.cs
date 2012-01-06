using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_Testing : System.Web.UI.Page
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
        lblTitle.Text = "Testing and submission preparation Edit";
        string strID = Request["tid"];
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
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Testing where TestingID=@TestingID";
            cmd.Parameters.AddWithValue("@TestingID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblLanguage.SelectedValue = dt.Rows[0]["Language"].ToString();
                tbLanguageDesc.Text = dt.Rows[0]["LanguageDesc"].ToString();
                cbBW.Checked = Convert.ToBoolean(dt.Rows[0]["BW"]);
                cbColor.Checked = Convert.ToBoolean(dt.Rows[0]["Color"]);
                tbManual.Text = dt.Rows[0]["Manual"].ToString();
                cbFCCTest.Checked = Convert.ToBoolean(dt.Rows[0]["FCCTest"]);
                cbFCCCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["FCCCertificate"]);
                cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                cbNBEO.Checked = Convert.ToBoolean(dt.Rows[0]["NBEO"]);
                cbEUDoC.Checked = Convert.ToBoolean(dt.Rows[0]["EUDoC"]);
                cbConformance.Checked = Convert.ToBoolean(dt.Rows[0]["Conformance"]);
                tbOtherInternationally.Text = dt.Rows[0]["OtherInternationally"].ToString();
                cbSchematics.Checked = Convert.ToBoolean(dt.Rows[0]["Schematics"]);
                cbBlock.Checked = Convert.ToBoolean(dt.Rows[0]["Block"]);
                cbLayout.Checked = Convert.ToBoolean(dt.Rows[0]["Layout"]);
                cbGerber.Checked = Convert.ToBoolean(dt.Rows[0]["Gerber"]);
                cbTheory.Checked = Convert.ToBoolean(dt.Rows[0]["Theory"]);
                tbTechnical.Text = dt.Rows[0]["Technical"].ToString();
                tbAntenna.Text = dt.Rows[0]["Antenna"].ToString();
                tbBOM.Text = dt.Rows[0]["BOM"].ToString();
                cbOfficial.Checked = Convert.ToBoolean(dt.Rows[0]["Official"]);
                cbWoWiRequest.Checked = Convert.ToBoolean(dt.Rows[0]["WoWiRequest"]);
                cbISO.Checked = Convert.ToBoolean(dt.Rows[0]["ISO"]);
                cbPayment.Checked = Convert.ToBoolean(dt.Rows[0]["Payment"]);
                cbAuthor.Checked = Convert.ToBoolean(dt.Rows[0]["Author"]);
                tbOtherDocRequest.Text = dt.Rows[0]["OtherDocRequest"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Testing and submission preparation Copy";
                    gvFile1.Columns[1].Visible = true;
                    gvFile2.Columns[1].Visible = true;
                    gvFile3.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                    gvFile2.Columns[0].Visible = true;
                    gvFile3.Columns[0].Visible = true;
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
        string strTsql = "insert into Ima_Testing (world_region_id,country_id,wowi_product_type_id,Language,LanguageDesc,BW,Color,Manual,FCCTest,FCCCertificate,CETest,NBEO,EUDoC,Conformance,OtherInternationally,Schematics,Block,Layout,Gerber,Theory,Technical,Antenna,BOM,Official,WoWiRequest,ISO,Payment,Author,OtherDocRequest,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Language,@LanguageDesc,@BW,@Color,@Manual,@FCCTest,@FCCCertificate,@CETest,@NBEO,@EUDoC,@Conformance,@OtherInternationally,@Schematics,@Block,@Layout,@Gerber,@Theory,@Technical,@Antenna,@BOM,@Official,@WoWiRequest,@ISO,@Payment,@Author,@OtherDocRequest,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Language", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LanguageDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@BW", SqlDbType.Bit);
        cmd.Parameters.Add("@Color", SqlDbType.Bit);
        cmd.Parameters.Add("@Manual", SqlDbType.NVarChar);
        cmd.Parameters.Add("@FCCTest", SqlDbType.Bit);
        cmd.Parameters.Add("@FCCCertificate", SqlDbType.Bit);
        cmd.Parameters.Add("@CETest", SqlDbType.Bit);
        cmd.Parameters.Add("@NBEO", SqlDbType.Bit);       
        cmd.Parameters.Add("@EUDoC", SqlDbType.Bit);
        cmd.Parameters.Add("@Conformance", SqlDbType.Bit);
        cmd.Parameters.Add("@OtherInternationally", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Schematics", SqlDbType.Bit);
        cmd.Parameters.Add("@Block", SqlDbType.Bit);
        cmd.Parameters.Add("@Layout", SqlDbType.Bit);
        cmd.Parameters.Add("@Gerber", SqlDbType.Bit);
        cmd.Parameters.Add("@Theory", SqlDbType.Bit);
        cmd.Parameters.Add("@Technical", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Antenna", SqlDbType.NVarChar);
        cmd.Parameters.Add("@BOM", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Official", SqlDbType.Bit);
        cmd.Parameters.Add("@WoWiRequest", SqlDbType.Bit);
        cmd.Parameters.Add("@ISO", SqlDbType.Bit);
        cmd.Parameters.Add("@Payment", SqlDbType.Bit);
        cmd.Parameters.Add("@Author", SqlDbType.Bit);
        cmd.Parameters.Add("@OtherDocRequest", SqlDbType.NVarChar);        
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
                cmd.Parameters["@Language"].Value = rblLanguage.SelectedValue;
                cmd.Parameters["@LanguageDesc"].Value = tbLanguageDesc.Text.Trim();
                cmd.Parameters["@BW"].Value = cbBW.Checked;
                cmd.Parameters["@Color"].Value = cbColor.Checked;
                cmd.Parameters["@Manual"].Value = tbManual.Text.Trim();
                cmd.Parameters["@FCCTest"].Value = cbFCCTest.Checked;
                cmd.Parameters["@FCCCertificate"].Value = cbFCCCertificate.Checked;
                cmd.Parameters["@CETest"].Value = cbCETest.Checked;
                cmd.Parameters["@NBEO"].Value = cbNBEO.Checked;
                cmd.Parameters["@EUDoC"].Value = cbEUDoC.Checked;
                cmd.Parameters["@Conformance"].Value = cbConformance.Checked;
                cmd.Parameters["@OtherInternationally"].Value = tbOtherInternationally.Text.Trim();
                cmd.Parameters["@Schematics"].Value = cbSchematics.Checked;
                cmd.Parameters["@Block"].Value = cbBlock.Checked;
                cmd.Parameters["@Layout"].Value = cbLayout.Checked;
                cmd.Parameters["@Gerber"].Value = cbGerber.Checked;
                cmd.Parameters["@Theory"].Value = cbTheory.Checked;
                cmd.Parameters["@Technical"].Value = tbTechnical.Text.Trim();
                cmd.Parameters["@Antenna"].Value = tbAntenna.Text.Trim();
                cmd.Parameters["@BOM"].Value = tbBOM.Text.Trim();
                cmd.Parameters["@Official"].Value = cbOfficial.Checked;
                cmd.Parameters["@WoWiRequest"].Value = cbWoWiRequest.Checked;
                cmd.Parameters["@ISO"].Value = cbISO.Checked;
                cmd.Parameters["@Payment"].Value = cbPayment.Checked;
                cmd.Parameters["@Author"].Value = cbAuthor.Checked;
                cmd.Parameters["@OtherDocRequest"].Value = tbOtherDocRequest.Text.Trim();
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\TestingAndSubmissionPreparation\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_Testing_Files (TestingID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @TestingID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Testing_Files where TestingFileID=@TestingFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@TestingID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@TestingFileID", strGAFID);
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\TestingAndSubmissionPreparation\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Testing_Files (TestingID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@TestingID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@TestingID", intID);
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
        string strTsql = "Update Ima_Testing set Language=@Language,LanguageDesc=@LanguageDesc,BW=@BW,Color=@Color,Manual=@Manual,FCCTest=@FCCTest,FCCCertificate=@FCCCertificate,CETest=@CETest,NBEO=@NBEO";
        strTsql += ",EUDoC=@EUDoC,Conformance=@Conformance,OtherInternationally=@OtherInternationally,Schematics=@Schematics,Block=@Block,Layout=@Layout,Gerber=@Gerber,Theory=@Theory,Technical=@Technical";
        strTsql += ",Antenna=@Antenna,BOM=@BOM,Official=@Official,WoWiRequest=@WoWiRequest,ISO=@ISO,Payment=@Payment,Author=@Author,OtherDocRequest=@OtherDocRequest,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where TestingID=@TestingID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@TestingID", Request["tid"]);
        cmd.Parameters.AddWithValue("@Language", rblLanguage.SelectedValue);
        cmd.Parameters.AddWithValue("@LanguageDesc", tbLanguageDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@BW", cbBW.Checked);
        cmd.Parameters.AddWithValue("@Color", cbColor.Checked);
        cmd.Parameters.AddWithValue("@Manual", tbManual.Text.Trim());
        cmd.Parameters.AddWithValue("@FCCTest", cbFCCTest.Checked);
        cmd.Parameters.AddWithValue("@FCCCertificate", cbFCCCertificate.Checked);
        cmd.Parameters.AddWithValue("@CETest", cbCETest.Checked);
        cmd.Parameters.AddWithValue("@NBEO", cbNBEO.Checked);
        cmd.Parameters.AddWithValue("@EUDoC", cbEUDoC.Checked);
        cmd.Parameters.AddWithValue("@Conformance", cbConformance.Checked);
        cmd.Parameters.AddWithValue("@OtherInternationally", tbOtherInternationally.Text.Trim());
        cmd.Parameters.AddWithValue("@Schematics", cbSchematics.Checked);
        cmd.Parameters.AddWithValue("@Block", cbBlock.Checked);
        cmd.Parameters.AddWithValue("@Layout", cbLayout.Checked);
        cmd.Parameters.AddWithValue("@Gerber", cbGerber.Checked);
        cmd.Parameters.AddWithValue("@Theory", cbTheory.Checked);
        cmd.Parameters.AddWithValue("@Technical", tbTechnical.Text.Trim());
        cmd.Parameters.AddWithValue("@Antenna", tbAntenna.Text.Trim());
        cmd.Parameters.AddWithValue("@BOM", tbBOM.Text.Trim());
        cmd.Parameters.AddWithValue("@Official", cbOfficial.Checked);
        cmd.Parameters.AddWithValue("@WoWiRequest", cbWoWiRequest.Checked);
        cmd.Parameters.AddWithValue("@ISO", cbISO.Checked);
        cmd.Parameters.AddWithValue("@Payment", cbPayment.Checked);
        cmd.Parameters.AddWithValue("@Author", cbAuthor.Checked);
        cmd.Parameters.AddWithValue("@OtherDocRequest", tbOtherDocRequest.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["tid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "tid", "copy" }));
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