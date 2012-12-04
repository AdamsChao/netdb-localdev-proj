using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_SampleShipping : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //設定業務人員不可進入編輯Page
            new IMAUtil().CheckIsSales();
            LoadData();
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Sample shipping Edit";
        string strID = Request["ssid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_SampleShipping where SampleShippingID=@SampleShippingID";
            cmd.Parameters.AddWithValue("@SampleShippingID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                cbFedex.Checked = Convert.ToBoolean(dt.Rows[0]["Fedex"]);
                cbDHL.Checked = Convert.ToBoolean(dt.Rows[0]["DHL"]);
                cbUPS.Checked = Convert.ToBoolean(dt.Rows[0]["UPS"]);
                tbOtherCarrier.Text = dt.Rows[0]["OtherCarrier"].ToString();
                tbCarrierDesc.Text = dt.Rows[0]["CarrierDesc"].ToString();
                cbInvoice.Checked = Convert.ToBoolean(dt.Rows[0]["Invoice"]);
                cbPackingList.Checked = Convert.ToBoolean(dt.Rows[0]["PackingList"]);
                cbContract.Checked = Convert.ToBoolean(dt.Rows[0]["Contract"]);
                tbOtherSampleShipping.Text = dt.Rows[0]["OtherSampleShipping"].ToString();
                tbUnderUSD.Text = dt.Rows[0]["UnderUSD"].ToString();
                cbNoCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["NoCommercial"]);
                cbActualCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["ActualCommercial"]);
                tbNote.Text = dt.Rows[0]["Note"].ToString();
                cbPreInstalled.Checked = Convert.ToBoolean(dt.Rows[0]["PreInstalled"]);
                cbCD.Checked = Convert.ToBoolean(dt.Rows[0]["CD"]);
                cbEmail.Checked = Convert.ToBoolean(dt.Rows[0]["Email"]);
                cbFTP.Checked = Convert.ToBoolean(dt.Rows[0]["FTP"]);
                tbTestNote.Text = dt.Rows[0]["TestNote"].ToString();
                rblReturned.SelectedValue = dt.Rows[0]["Returned"].ToString();
                tbReturnedNote.Text = dt.Rows[0]["ReturnedNote"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Sample shipping Copy";
                    gvFile1.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                }
            }
        }
        else
        {
            btnSave.Visible = true;
            //lblProTypeName.Text = IMAUtil.GetProductType(Request.Params["pt"]);
            trProductType.Visible = true;
            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_SampleShipping (world_region_id,country_id,wowi_product_type_id,Fedex,DHL,UPS,OtherCarrier,CarrierDesc,Invoice,PackingList,Contract,OtherSampleShipping,UnderUSD,NoCommercial,ActualCommercial,Note,PreInstalled,CD,Email,FTP,TestNote,Returned,ReturnedNote,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Fedex,@DHL,@UPS,@OtherCarrier,@CarrierDesc,@Invoice,@PackingList,@Contract,@OtherSampleShipping,@UnderUSD,@NoCommercial,@ActualCommercial,@Note,@PreInstalled,@CD,@Email,@FTP,@TestNote,@Returned,@ReturnedNote,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Fedex", SqlDbType.Bit);
        cmd.Parameters.Add("@DHL", SqlDbType.Bit);
        cmd.Parameters.Add("@UPS", SqlDbType.Bit);
        cmd.Parameters.Add("@OtherCarrier", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CarrierDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Invoice", SqlDbType.Bit);
        cmd.Parameters.Add("@PackingList", SqlDbType.Bit);
        cmd.Parameters.Add("@Contract", SqlDbType.Bit);
        cmd.Parameters.Add("@OtherSampleShipping", SqlDbType.NVarChar);
        cmd.Parameters.Add("@UnderUSD", SqlDbType.NVarChar);
        cmd.Parameters.Add("@NoCommercial", SqlDbType.Bit);
        cmd.Parameters.Add("@ActualCommercial", SqlDbType.Bit);
        cmd.Parameters.Add("@Note", SqlDbType.NVarChar);
        cmd.Parameters.Add("@PreInstalled", SqlDbType.Bit);
        cmd.Parameters.Add("@CD", SqlDbType.Bit);
        cmd.Parameters.Add("@Email", SqlDbType.Bit);
        cmd.Parameters.Add("@FTP", SqlDbType.Bit);
        cmd.Parameters.Add("@TestNote", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Returned", SqlDbType.NVarChar);
        cmd.Parameters.Add("@ReturnedNote", SqlDbType.NVarChar);
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
                cmd.Parameters["@Fedex"].Value = cbFedex.Checked;
                cmd.Parameters["@DHL"].Value = cbDHL.Checked;
                cmd.Parameters["@UPS"].Value = cbUPS.Checked;
                cmd.Parameters["@OtherCarrier"].Value = tbOtherCarrier.Text.Trim();
                cmd.Parameters["@CarrierDesc"].Value = tbCarrierDesc.Text.Trim();
                cmd.Parameters["@Invoice"].Value = cbInvoice.Checked;
                cmd.Parameters["@PackingList"].Value = cbPackingList.Checked;
                cmd.Parameters["@Contract"].Value = cbContract.Checked;
                cmd.Parameters["@OtherSampleShipping"].Value = tbOtherSampleShipping.Text.Trim();
                cmd.Parameters["@UnderUSD"].Value = tbUnderUSD.Text.Trim();
                cmd.Parameters["@NoCommercial"].Value = cbNoCommercial.Checked;
                cmd.Parameters["@ActualCommercial"].Value = cbActualCommercial.Checked;
                cmd.Parameters["@Note"].Value = tbNote.Text.Trim();
                cmd.Parameters["@PreInstalled"].Value = cbPreInstalled.Checked;
                cmd.Parameters["@CD"].Value = cbCD.Checked;
                cmd.Parameters["@Email"].Value = cbEmail.Checked;
                cmd.Parameters["@FTP"].Value = cbFTP.Checked;
                cmd.Parameters["@TestNote"].Value = tbTestNote.Text.Trim();
                cmd.Parameters["@Returned"].Value = rblReturned.SelectedValue;
                cmd.Parameters["@ReturnedNote"].Value = tbReturnedNote.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    CopyDocData(gvFile1, intGeneralID);
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\SampleShipping\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_SampleShipping_Files (SampleShippingID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @SampleShippingID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_SampleShipping_Files where SampleShippingFileID=@SampleShippingFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@SampleShippingID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@SampleShippingFileID", strGAFID);
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
        //Samples can be returned附件
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\SampleShipping\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_SampleShipping_Files (SampleShippingID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@SampleShippingID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@SampleShippingID", intID);
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
        string strTsql = "Update Ima_SampleShipping set Fedex=@Fedex,DHL=@DHL,UPS=@UPS,OtherCarrier=@OtherCarrier,CarrierDesc=@CarrierDesc,Invoice=@Invoice,PackingList=@PackingList,Contract=@Contract,OtherSampleShipping=@OtherSampleShipping,UnderUSD=@UnderUSD,NoCommercial=@NoCommercial,ActualCommercial=@ActualCommercial,Note=@Note,PreInstalled=@PreInstalled,CD=@CD,Email=@Email,FTP=@FTP,TestNote=@TestNote,Returned=@Returned,ReturnedNote=@ReturnedNote,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where SampleShippingID=@SampleShippingID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@SampleShippingID", Request["ssid"]);
        cmd.Parameters.AddWithValue("@Fedex", cbFedex.Checked);
        cmd.Parameters.AddWithValue("@DHL", cbDHL.Checked);
        cmd.Parameters.AddWithValue("@UPS", cbUPS.Checked);
        cmd.Parameters.AddWithValue("@OtherCarrier", tbOtherCarrier.Text.Trim());
        cmd.Parameters.AddWithValue("@CarrierDesc", tbCarrierDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@Invoice",cbInvoice.Checked );
        cmd.Parameters.AddWithValue("@PackingList",cbPackingList.Checked );
        cmd.Parameters.AddWithValue("@Contract",cbContract.Checked );
        cmd.Parameters.AddWithValue("@OtherSampleShipping",tbOtherSampleShipping.Text.Trim());
        cmd.Parameters.AddWithValue("@UnderUSD",tbUnderUSD.Text.Trim() );
        cmd.Parameters.AddWithValue("@NoCommercial",cbNoCommercial.Checked );
        cmd.Parameters.AddWithValue("@ActualCommercial",cbActualCommercial.Checked );
        cmd.Parameters.AddWithValue("@Note",tbNote.Text);
        cmd.Parameters.AddWithValue("@PreInstalled",cbPreInstalled.Checked );
        cmd.Parameters.AddWithValue("@CD", cbCD.Checked);
        cmd.Parameters.AddWithValue("@Email", cbEmail.Checked);
        cmd.Parameters.AddWithValue("@FTP",cbFTP.Checked );
        cmd.Parameters.AddWithValue("@TestNote",tbTestNote.Text.Trim() );
        cmd.Parameters.AddWithValue("@Returned", rblReturned.SelectedValue);
        cmd.Parameters.AddWithValue("@ReturnedNote", tbReturnedNote.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["ssid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "ssid", "copy" }));
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