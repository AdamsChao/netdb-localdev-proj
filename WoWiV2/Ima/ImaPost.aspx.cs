using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_ImaPost : System.Web.UI.Page
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
        lblTitle.Text = "Post certification Edit";
        string strID = Request["pcid"];
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
            cmd.CommandText = "select * from Ima_Post where PostID=@PostID";
            cmd.Parameters.AddWithValue("@PostID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblRequirement.SelectedValue = dt.Rows[0]["Requirement"].ToString();
                tbRequirementDesc.Text = dt.Rows[0]["RequirementDesc"].ToString();
                cbPrint.Checked = Convert.ToBoolean(dt.Rows[0]["Print"]);
                cbPurchase.Checked = Convert.ToBoolean(dt.Rows[0]["Purchase"]);
                tbLabelsDesc.Text = dt.Rows[0]["LabelsDesc"].ToString();
                bool b = Convert.ToBoolean(dt.Rows[0]["Required"]);
                if (b)
                {
                    rbtnYes.Checked = true;
                }
                else 
                {
                    rbtnNo.Checked = true;
                }
                //rbtnYes.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                //rbtnNo.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                tbYear.Text = dt.Rows[0]["Year"].ToString();
                tbMonth.Text = dt.Rows[0]["Month"].ToString();
                tbRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Post certification Copy";
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
        string strTsql = "insert into Ima_Post (world_region_id,country_id,wowi_product_type_id,Requirement,RequirementDesc,[Print],Purchase,LabelsDesc,Required,Year,Month,RequiredDesc,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Requirement,@RequirementDesc,@Print,@Purchase,@LabelsDesc,@Required,@Year,@Month,@RequiredDesc,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Requirement", SqlDbType.NVarChar);
        cmd.Parameters.Add("@RequirementDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Print", SqlDbType.Bit);
        cmd.Parameters.Add("@Purchase", SqlDbType.Bit);
        cmd.Parameters.Add("@LabelsDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Required", SqlDbType.Bit);
        cmd.Parameters.Add("@Year", SqlDbType.Int);
        cmd.Parameters.Add("@Month", SqlDbType.Int);
        cmd.Parameters.Add("@RequiredDesc", SqlDbType.NVarChar);
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
                cmd.Parameters["@Requirement"].Value = rblRequirement.SelectedValue;
                cmd.Parameters["@RequirementDesc"].Value = tbRequirementDesc.Text.Trim();
                cmd.Parameters["@Print"].Value = cbPrint.Checked;
                cmd.Parameters["@Purchase"].Value = cbPurchase.Checked;
                cmd.Parameters["@LabelsDesc"].Value = tbLabelsDesc.Text.Trim();
                bool b = false;
                if (rbtnYes.Checked)
                {
                    b = true;
                }
                cmd.Parameters["@Required"].Value = b;
                if (tbYear.Text.Trim().Length > 0)
                {
                    cmd.Parameters["@Year"].Value = tbYear.Text.Trim();
                }
                else 
                {
                    cmd.Parameters["@Year"].Value = DBNull.Value;
                }
                if (tbMonth.Text.Trim().Length > 0)
                {
                    cmd.Parameters["@Month"].Value = tbMonth.Text.Trim();
                }
                else
                {
                    cmd.Parameters["@Month"].Value = DBNull.Value;
                }                
                cmd.Parameters["@RequiredDesc"].Value = tbRequiredDesc.Text.Trim();
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PostCertification\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_Post_Files (PostID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @PostID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Post_Files where PostFileID=@PostFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PostID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@PostFileID", strGAFID);
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PostCertification\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Post_Files (PostID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@PostID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@PostID", intID);
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
        string strTsql = "Update Ima_Post set Requirement=@Requirement,RequirementDesc=@RequirementDesc,[Print]=@Print,Purchase=@Purchase,LabelsDesc=@LabelsDesc,Required=@Required,Year=@Year,Month=@Month,RequiredDesc=@RequiredDesc,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where PostID=@PostID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PostID", Request["pcid"]);
        cmd.Parameters.AddWithValue("@Requirement", rblRequirement.SelectedValue);
        cmd.Parameters.AddWithValue("@RequirementDesc", tbRequirementDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@Print", cbPrint.Checked);
        cmd.Parameters.AddWithValue("@Purchase", cbPurchase.Checked);
        cmd.Parameters.AddWithValue("@LabelsDesc", tbLabelsDesc.Text.Trim());
        bool b = false;
        if (rbtnYes.Checked) 
        {
            b = true;
        }
        cmd.Parameters.AddWithValue("@Required", b);
        if (tbYear.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Year", tbYear.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Year", DBNull.Value);
        }
        if (tbMonth.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Month", tbMonth.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Month", DBNull.Value);
        }       
        //cmd.Parameters.AddWithValue("@Year", tbYear.Text.Trim());
        //cmd.Parameters.AddWithValue("@Month", tbMonth.Text.Trim());
        cmd.Parameters.AddWithValue("@RequiredDesc", tbRequiredDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["pcid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "pcid", "copy" }));
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