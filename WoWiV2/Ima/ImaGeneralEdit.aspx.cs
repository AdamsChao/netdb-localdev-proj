using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaGeneralEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetGeneralData();
        }
    }

    //取得General資料
    protected void GetGeneralData() 
    {
        string strGeneralID = Request["gid"];
        btnSave.Visible = false;
        btnUpd.Visible = false;
        trDocList.Visible = false;
        DataTable dtGeneralImage = CreateImageDataTable();
        if (strGeneralID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_General where GeneralID=@GeneralID;select * from Ima_General_Images where GeneralID=@GeneralID";
            cmd.Parameters.AddWithValue("@GeneralID", strGeneralID);
            DataSet ds=SQLUtil.QueryDS(cmd);
            DataTable dt = new DataTable();
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbVoltage.Text = dt.Rows[0]["Voltage"].ToString();
                tbFrequency.Text = dt.Rows[0]["Frequency"].ToString();
                tbPlugType.Text = dt.Rows[0]["Plug_Type"].ToString();
                tbCurrency_Code.Text = dt.Rows[0]["Currency_Code"].ToString();
                tbExchange_rate_USD.Text = dt.Rows[0]["Exchange_rate_USD"].ToString();
                tbExchange_rate_EUR.Text = dt.Rows[0]["Exchange_rate_EUR"].ToString();
                tbCountry_Code.Text = dt.Rows[0]["Country_Code"].ToString();
                tbCulture_Taboos.Text = dt.Rows[0]["Culture_Taboos"].ToString();
                btnUpd.Visible = true;
                if (gvIma_General_Files.Rows.Count > 0) { trDocList.Visible = true; }
            }
          
            //載入圖片
            DataTable dtImage=new DataTable();
            dtImage = ds.Tables[1];
            if (dtImage.Rows.Count > 0) 
            {
                foreach (DataRow dr in dtImage.Rows) 
                {
                    DataRow row = dtGeneralImage.NewRow();
                    row["GeneralImageID"] = dr["GeneralImageID"].ToString();
                    row["GeneralID"] = dr["GeneralID"].ToString();
                    row["GeneralImageURL"] = IMAUtil.GetIMAUploadPath() + dr["GeneralImageURL"].ToString();
                    row["GeneralImageDesc"] = dr["GeneralImageDesc"].ToString();
                    dtGeneralImage.Rows.Add(row);
                }
                string strNum = dtImage.Rows[dtImage.Rows.Count - 1]["GeneralImageURL"].ToString();
                strNum=strNum.Substring(dtImage.Rows[dtImage.Rows.Count - 1]["GeneralImageURL"].ToString().LastIndexOf(Convert.ToChar(@"\")) + 1);
                strNum = strNum.Split('.')[0].ToString().Replace(Request["cid"] + "_", "");
                hfImageNum.Value = strNum;
                dlImages.DataSource = dtGeneralImage;
                dlImages.DataBind();
            }
        }
        else
        {
            btnSave.Visible = true;
        }
        ViewState["GeneralImage"] = dtGeneralImage;
    }

    protected DataTable CreateImageDataTable() 
    {
        DataTable dt=new DataTable();
        dt.Columns.Add("GeneralImageID");
        dt.Columns.Add("GeneralID");
        dt.Columns.Add("GeneralImageURL");
        dt.Columns.Add("GeneralImageDesc");
        return dt;
    }

    //取消/返回
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        //string strURL = Request.QueryString.ToString();
        //if (Request["gid"] != null) 
        //{
        //    strURL = strURL.Replace("&gid=" + Request["gid"], "");
        //}
        //Response.Redirect("ImaList.aspx?" + strURL);

        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "gid" }));
    }

    //新增儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strTsql = "insert into Ima_General (world_region_id,country_id,Voltage,Frequency,Plug_Type,Currency_Code,Exchange_rate_USD,Exchange_rate_EUR,Country_Code,Culture_Taboos,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@Voltage,@Frequency,@Plug_Type,@Currency_Code,@Exchange_rate_USD,@Exchange_rate_EUR,@Country_Code,@Culture_Taboos,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@Voltage", tbVoltage.Text.Trim());
        cmd.Parameters.AddWithValue("@Frequency", tbFrequency.Text.Trim());
        cmd.Parameters.AddWithValue("@Plug_Type", tbPlugType.Text.Trim());
        cmd.Parameters.AddWithValue("@Currency_Code", tbCurrency_Code.Text.Trim());
        if (tbExchange_rate_USD.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_USD", tbExchange_rate_USD.Text.Trim());
        }
        else 
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_USD", DBNull.Value);
        }
        if (tbExchange_rate_EUR.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_EUR", tbExchange_rate_EUR.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_EUR", DBNull.Value);
        }
        cmd.Parameters.AddWithValue("@Country_Code", tbCountry_Code.Text.Trim());
        cmd.Parameters.AddWithValue("@Culture_Taboos", tbCulture_Taboos.Text.Trim());
        cmd.Parameters.AddWithValue("@CreateUser", "");
        cmd.Parameters.AddWithValue("@LasterUpdateUser", "");
        int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
        //文件上傳
        GeneralFileUpload(intGeneralID);
        //圖片上傳
        GeneralImageUpload(intGeneralID);
        BackURL();
    }

    //修改儲存
    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_General set Voltage=@Voltage,Frequency=@Frequency,Plug_Type=@Plug_Type,Currency_Code=@Currency_Code,Exchange_rate_USD=@Exchange_rate_USD,Exchange_rate_EUR=@Exchange_rate_EUR,Country_Code=@Country_Code,Culture_Taboos=@Culture_Taboos,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where GeneralID=@GeneralID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@GeneralID", Request["gid"]);
        cmd.Parameters.AddWithValue("@Voltage", tbVoltage.Text.Trim());
        cmd.Parameters.AddWithValue("@Frequency", tbFrequency.Text.Trim());
        cmd.Parameters.AddWithValue("@Plug_Type", tbPlugType.Text.Trim());
        cmd.Parameters.AddWithValue("@Currency_Code", tbCurrency_Code.Text.Trim());
        if (tbExchange_rate_USD.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_USD", tbExchange_rate_USD.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_USD", DBNull.Value);
        }
        if (tbExchange_rate_EUR.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_EUR", tbExchange_rate_EUR.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Exchange_rate_EUR", DBNull.Value);
        }
        cmd.Parameters.AddWithValue("@Country_Code", tbCountry_Code.Text.Trim());
        cmd.Parameters.AddWithValue("@Culture_Taboos", tbCulture_Taboos.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["gid"]));
        //圖片上傳
        GeneralImageUpload(Convert.ToInt32(Request["gid"]));
        BackURL();
    }
        
    //文件上傳
    protected void GeneralFileUpload(int intGeneralID) 
    {
        GeneralFileUpload(intGeneralID, fuGeneral1);
        GeneralFileUpload(intGeneralID, fuGeneral2);
        GeneralFileUpload(intGeneralID, fuGeneral3);
        GeneralFileUpload(intGeneralID, fuGeneral4);
        GeneralFileUpload(intGeneralID, fuGeneral5);
    }

    protected void GeneralFileUpload(int intGeneralID,FileUpload fu) 
    {
        string strFileURL = "";
        string strFileName = "";
        string strFileType = ""; 
        if (fu.HasFile)
        {
            //取得檔名(包含副檔名)
            strFileName = fu.FileName.Trim();
            //上傳檔案路徑
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\General" ;
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            //strFileURL = @"D:\IMA\General\" + strFileName;
            strFileURL = strUploadPath + @"\" + strFileName;            
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_General_Files (GeneralID,GeneralFileURL,GeneralFileName,GeneralFileType,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@GeneralID,@GeneralFileURL,@GeneralFileName,@GeneralFileType,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@GeneralID", intGeneralID);
            cmd.Parameters.AddWithValue("@GeneralFileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
            cmd.Parameters.AddWithValue("@GeneralFileName", strFileName);
            cmd.Parameters.AddWithValue("@GeneralFileType", strFileType);
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            SQLUtil.ExecuteSql(cmd);
            fu.SaveAs(strFileURL);
        }
    }

    //上傳圖片
    protected void GeneralImageUpload(int intGeneralID) 
    {
        DataTable dtGeneralImage = (DataTable)ViewState["GeneralImage"];
        if (dtGeneralImage.Rows.Count > 0) 
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "insert into Ima_General_Images (GeneralID,GeneralImageURL,GeneralImageDesc,CreateUser,LasterUpdateUser) values(@GeneralID,@GeneralImageURL,@GeneralImageDesc,@CreateUser,@LasterUpdateUser)";            
            cmd.Parameters.AddWithValue("@GeneralID", intGeneralID);
            cmd.Parameters.Add("@GeneralImageURL", SqlDbType.NVarChar);
            cmd.Parameters.Add("@GeneralImageDesc", SqlDbType.NText);
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            foreach (DataRow row in dtGeneralImage.Rows)
            {
                if (row["GeneralImageID"].ToString() == "0")
                {
                    cmd.Parameters["@GeneralImageURL"].Value = row["GeneralImageURL"].ToString().Replace(IMAUtil.GetIMAUploadPath(), "");
                    cmd.Parameters["@GeneralImageDesc"].Value = row["GeneralImageDesc"].ToString();
                    SQLUtil.ExecuteSql(cmd);
                }
            }
        }
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

    //自動代入CurrencyCode及CountryCode
    protected void btnSelCurrencyCode_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select country_telephone_code,country_currency_type from country where country_id=@country_id";
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        SqlDataReader sdr = SQLUtil.QueryDR(cmd);
        if (sdr.Read())
        {
            if (sdr["country_currency_type"].ToString() == "")
            {
                lblCurrencyCodeMsg.Text = "No Currency Code Data";
            }
            else 
            {
                tbCurrency_Code.Text = sdr["country_currency_type"].ToString();
                tbCountry_Code.Text = sdr["country_telephone_code"].ToString();
            }
        }
        else 
        {
            lblCurrencyCodeMsg.Text = "No Currency Code Data";
        }
        sdr.Close();
    }

    
    protected void tbCurrency_Code_TextChanged(object sender, EventArgs e)
    {
        if (lblCurrencyCodeMsg.Text.Trim().Length > 0) { lblCurrencyCodeMsg.Text = ""; }        
    }

    //圖片上傳
    protected void btnImageUpload_Click(object sender, EventArgs e)
    {
        lblImageMsg.Text = "";
        if (fuImage.HasFile) 
        {
            string strFileURL = "";
            string strFileName = fuImage.FileName.Trim();
            //取得副檔名
            string strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            //判斷上傳檔案是否為圖檔
            if (strFileType == "gif" || strFileType == "jpeg" || strFileType == "jpg" || strFileType == "png")
            {
                string strImageNum = (Convert.ToInt32(hfImageNum.Value) + 1).ToString();
                string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\GeneralImages";
                //檢查上傳檔案路徑是否存在，若不存在就自動建立
                IMAUtil.CheckURL(strUploadPath);
                strFileURL = strUploadPath + @"\" + Request["cid"] + "_" + strImageNum + "." + strFileType;
                fuImage.SaveAs(strFileURL);

                DataTable dtGeneralImage = (DataTable)ViewState["GeneralImage"];
                DataRow row = dtGeneralImage.NewRow();
                row["GeneralImageID"] = "0";
                row["GeneralID"] = "0";
                row["GeneralImageURL"] = strFileURL;
                row["GeneralImageDesc"] = tbImageDesc.Text.Trim();
                dtGeneralImage.Rows.Add(row);

                dlImages.DataSource = dtGeneralImage;
                dlImages.DataBind();
                ViewState["GeneralImage"] = dtGeneralImage;
                tbImageDesc.Text = "";
                hfImageNum.Value = strImageNum;
            }
            else 
            {
                lblImageMsg.Text = @"Please Upload Image!("".gif"","".jpeg"","".jpg"","".png"")";
            }
        }
    }

    //刪除圖片
    protected void dlImages_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) 
        {
            string strGeneralImageID = dlImages.DataKeys[e.Item.ItemIndex].ToString();
            DataTable dt = (DataTable)ViewState["GeneralImage"];
            if (strGeneralImageID != "0")
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "delete from Ima_General_Images where GeneralImageID=@GeneralImageID";
                cmd.Parameters.AddWithValue("@GeneralImageID", strGeneralImageID);
                SQLUtil.ExecuteSql(cmd);
                foreach (DataRow row in dt.Rows)
                {
                    if (strGeneralImageID == row["GeneralImageID"].ToString())
                    {
                        //刪除資料夾圖片
                        IMAUtil.DelFile(@row["GeneralImageURL"].ToString());
                        //刪除DataTable資料
                        row.Delete();
                        break;
                    }
                }
            }
            else 
            {
                string strURL = e.CommandArgument.ToString();
                foreach (DataRow row in dt.Rows)
                {
                    if (strURL == row["GeneralImageURL"].ToString())
                    {
                        //刪除資料夾圖片
                        IMAUtil.DelFile(@row["GeneralImageURL"].ToString());
                        //刪除DataTable資料
                        row.Delete();
                        break;
                    }
                }
            }
            dlImages.DataSource = dt;
            dlImages.DataBind();
            ViewState["GeneralImage"] = dt;
        }
    }
}