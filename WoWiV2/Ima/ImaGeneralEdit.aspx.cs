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
        if (strGeneralID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_General where GeneralID=@GeneralID";
            cmd.Parameters.AddWithValue("@GeneralID", strGeneralID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
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
        }
        else
        {
            btnSave.Visible = true;
        }
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