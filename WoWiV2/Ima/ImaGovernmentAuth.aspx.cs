using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_ImaGovernmentAuth : System.Web.UI.Page
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
        lblTitle.Text = "Government Authority Edit";
        string strID = Request["gaid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvImaFiles1.Columns[0].Visible = false;
        gvImaFiles1.Columns[1].Visible = false;
        gvImaFiles.Columns[0].Visible = false;
        gvImaFiles.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID";
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbFullAuthorityName.Text = dt.Rows[0]["FullAuthorityName"].ToString();
                tbAbbreviatedAuthorityName.Text = dt.Rows[0]["AbbreviatedAuthorityName"].ToString();
                tbWebsite.Text = dt.Rows[0]["Website"].ToString();
                tbMandatory.Text = dt.Rows[0]["Mandatory"].ToString();
                rblCertificateValid.SelectedValue = dt.Rows[0]["CertificateValid"].ToString();
                rblTransfer.SelectedValue =Convert.ToInt32(dt.Rows[0]["IsTransfer"]).ToString();
                tbDescription.Text = dt.Rows[0]["Description"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();                
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Government Authority Copy";
                    gvImaFiles1.Columns[1].Visible = true;
                    gvImaFiles.Columns[1].Visible = true;
                }
                else 
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvImaFiles1.Columns[0].Visible = true;
                    gvImaFiles.Columns[0].Visible = true;
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
        string strTsql = "insert into Ima_GovernmentAuthority (world_region_id,country_id,FullAuthorityName,AbbreviatedAuthorityName,Website,Mandatory,wowi_product_type_id,CertificateValid,IsTransfer,Description,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@FullAuthorityName,@AbbreviatedAuthorityName,@Website,@Mandatory,@wowi_product_type_id,@CertificateValid,@IsTransfer,@Description,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("world_region_id",SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@FullAuthorityName", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AbbreviatedAuthorityName", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Website", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Mandatory", SqlDbType.NVarChar);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@CertificateValid", SqlDbType.NVarChar);
        cmd.Parameters.Add("@IsTransfer", SqlDbType.Bit);
        cmd.Parameters.Add("@Description", SqlDbType.NVarChar);
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
                cmd.Parameters["@FullAuthorityName"].Value = tbFullAuthorityName.Text.Trim();
                cmd.Parameters["@AbbreviatedAuthorityName"].Value = tbAbbreviatedAuthorityName.Text.Trim();
                cmd.Parameters["@Website"].Value = tbWebsite.Text.Trim();
                cmd.Parameters["@Mandatory"].Value = tbMandatory.Text.Trim();
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@CertificateValid"].Value = rblCertificateValid.SelectedValue;
                cmd.Parameters["@IsTransfer"].Value = rblTransfer.SelectedValue == "1";
                cmd.Parameters["@Description"].Value = tbDescription.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    //Attach sample File
                    CopyDocData(gvImaFiles1, intGeneralID);
                    //Transfer File
                    CopyDocData(gvImaFiles, intGeneralID);
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\GovernmentAuthority\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }                
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intGAID,string strGAFID) 
    {
        string strTsql = "insert into Ima_GoverAuth_Files (GovernmentAuthorityID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @GovernmentAuthorityID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_GoverAuth_Files where GoverAuthFileID=@GoverAuthFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", intGAID);//lblProTypeName
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@GoverAuthFileID", strGAFID);
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\GovernmentAuthority\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_GoverAuth_Files (GovernmentAuthorityID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@GovernmentAuthorityID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", intID);
            cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(),""));
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
        string strTsql = "Update Ima_GovernmentAuthority set FullAuthorityName=@FullAuthorityName,AbbreviatedAuthorityName=@AbbreviatedAuthorityName,Website=@Website,Mandatory=@Mandatory,CertificateValid=@CertificateValid,IsTransfer=@IsTransfer,Description=@Description,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where GovernmentAuthorityID=@GovernmentAuthorityID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", Request["gaid"]);
        cmd.Parameters.AddWithValue("@FullAuthorityName", tbFullAuthorityName.Text.Trim());
        cmd.Parameters.AddWithValue("@AbbreviatedAuthorityName", tbAbbreviatedAuthorityName.Text.Trim());
        cmd.Parameters.AddWithValue("@Website", tbWebsite.Text.Trim());
        cmd.Parameters.AddWithValue("@Mandatory", tbMandatory.Text.Trim());
        cmd.Parameters.AddWithValue("@CertificateValid", rblCertificateValid.SelectedValue);
        cmd.Parameters.AddWithValue("@IsTransfer", rblTransfer.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@Description", tbDescription.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["gaid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        //string strURL = Request.QueryString.ToString();
        //if (Request["pt"] != null)
        //{
        //    strURL = strURL.Replace("&pt=" + HttpUtility.UrlEncode(HttpUtility.UrlDecode(Request["pt"])), "");
        //}
        //if (Request["gaid"] != null)
        //{
        //    strURL = strURL.Replace("&gaid=" + Request["gaid"], "");
        //}
        //if (Request["copy"] != null) 
        //{
        //    strURL = strURL.Replace("&copy=1", "");
        //}
        //Response.Redirect("ImaList.aspx?" + strURL);
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "gaid", "copy" }));
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