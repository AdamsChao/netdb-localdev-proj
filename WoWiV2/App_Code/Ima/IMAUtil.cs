using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Collections.Specialized;

/// <summary>
/// IMAUtil 的摘要描述
/// </summary>
public class IMAUtil
{
	public IMAUtil()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

    public static string GetUser()
    {
        return "";
    }

    static public String GetIMAUploadPath()
    {
        String path = null;
        path = ConfigurationManager.AppSettings["IMAUploadPath"];
        return path;
    }

    //取得四大類
    static public String GetProductType(string strwowi_product_type_id)
    {
        string strTsql = "select wowi_product_type_name from wowi_product_type where wowi_product_type_id=@wowi_product_type_id";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@wowi_product_type_id", strwowi_product_type_id);
        return SQLUtil.ExecuteScalar(cmd).ToString();
    }

    //取得國別名稱
    static public String GetCountryName(string strcountry_id)
    {
        string strTsql = "select country_name from country where country_id=@country_id";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@country_id", strcountry_id);
        return SQLUtil.ExecuteScalar(cmd).ToString();
    }

    //依國別編號取得國別資料
    static public DataTable GetCountryByID(string strcountry_id)
    {
        string strTsql = "select * from country where country_id=@country_id";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@country_id", strcountry_id);
        return SQLUtil.QueryDS(cmd).Tables[0];
    }

    //判斷檔案上傳路徑是否存在，若不存在則建立
    static public void CheckURL(string strPaht)
    {
        DirectoryInfo di = new DirectoryInfo(strPaht);
        if (!di.Exists)
        {
            di.Create();
        } 
    }

    //刪除檔案
    static public void DelFile(string strFilePath) 
    {
        FileInfo fi = new FileInfo(strFilePath);
        if (fi.Exists) 
        {
            fi.Delete();
        }
    }

    /// <summary>
    /// QuseryString處理
    /// </summary>
    /// <param name="dic">預設參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    static public string SetQueryString(bool isClear, Dictionary<string, string> dic, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        StringBuilder sbQueryString = new StringBuilder();
        NameValueCollection nvc = new NameValueCollection();
        //如不清除原本的參數，並取得目前的QueryString轉為NameValueCollection物件        
        if (!isClear & HttpContext.Current.Request.QueryString.Count > 0)
        {
            nvc.Add(HttpContext.Current.Request.QueryString);
        }

        //加入預設參數
        foreach (KeyValuePair<string, string> kvp in dic)
        {
            nvc.Add(kvp.Key, kvp.Value);
        }
        //新增參數
        if (dicAdd != null)
        {
            foreach (KeyValuePair<string, string> kvp in dicAdd)
            {
                nvc.Add(kvp.Key, kvp.Value);
            }
        }
        //移除參數
        if (strRemove != null)
        {
            foreach (string strKey in strRemove)
            {
                nvc.Remove(strKey);
            }
        }
        //轉回組成QueryString
        foreach (string strKey in nvc.AllKeys)
        {
            string[] strValues = nvc.GetValues(strKey);
            foreach (string strValue in strValues)
            {
                sbQueryString.Append(("&" + strKey + "=") + HttpUtility.UrlEncode(strValue));
            }
        }
        //第一個字元處理
        if (sbQueryString.Length > 0)
        {
            sbQueryString.Remove(0, 1);

            sbQueryString.Insert(0, "?");
        }
        return sbQueryString.ToString();
    }

    /// <summary>
    /// 刪除Technology
    /// </summary>
    /// <param name="intDID"></param>
    /// <param name="strCategory"></param>
    public void DelTechnology(int intDID, string strCategory) 
    {
        SqlCommand cmd = new SqlCommand("delete from Ima_Technology where DID=@DID and Categroy=@Categroy");
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@Categroy", strCategory);
        SQLUtil.ExecuteSql(cmd);
    }

    /// <summary>
    /// 新增Technology
    /// </summary>
    /// <param name="intDID"></param>
    /// <param name="strCategory"></param>
    /// <param name="intTechID"></param>
    /// <param name="strFee"></param>
    public void AddTechnology(int intDID, string strCategory, int intTechID, string strFee) 
    {
        string strTsql = "if (not exists(select DID from Ima_Technology where DID=@DID and Categroy=@Categroy and wowi_tech_id=@wowi_tech_id)) ";
        strTsql += "insert into Ima_Technology (DID,Categroy,wowi_tech_id,Fee) values(@DID,@Categroy,@wowi_tech_id,@Fee)";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@Categroy", strCategory);
        cmd.Parameters.AddWithValue("@wowi_tech_id", intTechID);
        if (strFee.Length > 0) { cmd.Parameters.AddWithValue("@Fee", strFee); }
        else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }        
        SQLUtil.ExecuteSql(cmd);
    }

    public DataTable GetContact(int intDID, string strCategory) 
    {
        SqlCommand cmd = new SqlCommand("STP_IMAGetContactByDIDCategory");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@Categroy", strCategory);
        return SQLUtil.QueryDS(cmd).Tables[0];
    }


    public void FileUpload(int intID, FileUpload fu, string strFileCatetory, string strUploadPath)
    {
        string strFileURL = "";
        string strFileName = "";
        string strFileType = "";
        if (fu.HasFile)
        {
            //取得檔名(包含副檔名)
            strFileName = fu.FileName.Trim();
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");
            string strTsql = "insert into Ima_Files (DocID,DocCategory,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@DocID,@DocCategory,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@DocID", intID);
            cmd.Parameters.AddWithValue("@DocCategory", HttpContext.Current.Request["categroy"]);
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
}