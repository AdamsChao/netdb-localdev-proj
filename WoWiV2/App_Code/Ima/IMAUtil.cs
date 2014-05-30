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
using System.Text.RegularExpressions;

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
        return HttpContext.Current.User.Identity.Name;
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
        return SQLUtil.ExecuteScalar(cmd).ToString().Trim();
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


    /// <summary>
    /// 刪除Technology
    /// </summary>
    /// <param name="intDID"></param>
    /// <param name="strCategory"></param>
    public void DelTech(int intDID, string strCategory)
    {
        SqlCommand cmd = new SqlCommand("delete from Ima_Tech where DID=@DID and Categroy=@Categroy");
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
    public void AddTech(int intDID, string strCategory, int intTechID, string strDescription)
    {
        string strTsql = "if (not exists(select DID from Ima_Tech where DID=@DID and Categroy=@Categroy and wowi_tech_id=@wowi_tech_id)) ";
        strTsql += "insert into Ima_Tech (DID,Categroy,wowi_tech_id,Description) values(@DID,@Categroy,@wowi_tech_id,@Description)";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@Categroy", strCategory);
        cmd.Parameters.AddWithValue("@wowi_tech_id", intTechID);
        if (strDescription.Length > 0) { cmd.Parameters.AddWithValue("@Description", strDescription); }
        else { cmd.Parameters.AddWithValue("@Description", DBNull.Value); }
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

    //替換查詢關鍵字的顏色及換行
    public void RepKW(System.Web.UI.ControlCollection CTLC)
    {
        string strKW = HttpUtility.UrlDecode(HttpContext.Current.Request["kw"]);
         Label lbl;
        if (strKW != null)
        {
            string[] arrKW = strKW.Split(' ');
            foreach (System.Web.UI.Control ctl in CTLC)
            {
                if (ctl is Label)
                {
                    lbl = (Label)ctl;
                    lbl.Text = HighlightString(lbl.Text, strKW);
                    foreach (string str in arrKW)
                    {
                        lbl.Text = HighlightString(lbl.Text, str);
                    }
                    lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                }
                //Control在tr內
                if (ctl is System.Web.UI.HtmlControls.HtmlTableRow)
                {
                    foreach (System.Web.UI.Control tc in ctl.Controls)
                    {
                        if (tc is System.Web.UI.HtmlControls.HtmlTableCell)
                        {
                            foreach (System.Web.UI.Control c in tc.Controls)
                            {
                                if (c is Label)
                                {
                                    lbl = (Label)c;
                                    lbl.Text = HighlightString(lbl.Text, strKW);
                                    foreach (string str in arrKW)
                                    {
                                        lbl.Text = HighlightString(lbl.Text, str);
                                    }
                                    lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                                }
                            }
                        }
                    }
                }
                //Control在Panel內
                if (ctl is Panel)
                {
                    foreach (System.Web.UI.Control tc in ctl.Controls)
                    {
                        if (tc is Label)
                        {
                            lbl = (Label)tc;
                            lbl.Text = HighlightString(lbl.Text, strKW);
                            foreach (string str in arrKW)
                            {
                                lbl.Text = HighlightString(lbl.Text, str);
                            }
                            lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                        }
                        if (tc is System.Web.UI.HtmlControls.HtmlTableRow)
                        {
                            foreach (System.Web.UI.Control pltc in tc.Controls)
                            {
                                if (pltc is System.Web.UI.HtmlControls.HtmlTableCell)
                                {
                                    foreach (System.Web.UI.Control c in pltc.Controls)
                                    {
                                        if (c is Label)
                                        {
                                            lbl = (Label)c;
                                            lbl.Text = HighlightString(lbl.Text, strKW);
                                            foreach (string str in arrKW)
                                            {
                                                lbl.Text = HighlightString(lbl.Text, str);
                                            }
                                            lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        else 
        {
            foreach (System.Web.UI.Control ctl in CTLC)
            {
                if (ctl is Label)
                {
                    lbl = (Label)ctl;
                    lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                }                
                //Control在tr內
                if (ctl is System.Web.UI.HtmlControls.HtmlTableRow)
                {
                    foreach (System.Web.UI.Control tc in ctl.Controls)
                    {
                        if (tc is System.Web.UI.HtmlControls.HtmlTableCell)
                        {
                            foreach (System.Web.UI.Control c in tc.Controls)
                            {
                                if (c is Label)
                                {
                                    lbl = (Label)c;
                                    lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                                }
                            }
                        }
                    }
                }
                //Control在Panel內
                if (ctl is Panel)
                {
                    foreach (System.Web.UI.Control tc in ctl.Controls)
                    {
                        if (tc is Label)
                        {
                            lbl = (Label)tc;
                            lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                        }
                        if (tc is System.Web.UI.HtmlControls.HtmlTableRow)
                        {
                            foreach (System.Web.UI.Control pltc in tc.Controls)
                            {
                                if (pltc is System.Web.UI.HtmlControls.HtmlTableCell)
                                {
                                    foreach (System.Web.UI.Control c in pltc.Controls)
                                    {
                                        if (c is Label)
                                        {
                                            lbl = (Label)c;
                                            lbl.Text = lbl.Text.Replace(Convert.ToChar(10).ToString(), "<br>");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    protected string HighlightString(string Contents, string ReplaceWord)
    {
        System.Text.RegularExpressions.MatchCollection matchs = Regex.Matches(Contents, ReplaceWord, RegexOptions.IgnoreCase);
        for (int i = 0; i < matchs.Count; i++)
        {
            Contents = Regex.Replace(Contents, matchs[i].Value, "<span class=\"fontR\">" + matchs[i].Value + "</span>");
            //Contents = Regex.Replace(Contents, matchs[i].Value, @"<span class=""fontR"">" + matchs[i].Value + @"</span>");
        }
        return Contents;
    }


    public void dlTech_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        DataList dl = (DataList)sender;
        string strID = dl.ClientID.Replace("MainContent_dlTech", "");
        CheckBox cb = (CheckBox)e.Item.FindControl("cb" + strID + "Fee");
        cb.Attributes.Add("onclick", "TechFeeAll(this);");
        TextBox tb = (TextBox)e.Item.FindControl("tb" + strID + "Fee");
        tb.Attributes.Add("onkeyup", "SetTechFeeAll(this);");
    }

    //控制可刪除的按鈕
    public static bool IsDeleteOn()
    {
        string strUserName = HttpContext.Current.User.Identity.Name.ToLower().Trim();
        if (strUserName == "shirley" || strUserName == "scott") { return true; }
        return false;
    }

    //控制Sales不能新增、編輯按妞
    public static bool IsEditOn()
    {
        string strUserName = HttpContext.Current.User.Identity.Name.ToLower().Trim();
        if (strUserName == "amy" || strUserName == "timur" || strUserName == "doris" || strUserName == "amanda") { return false; }
        return true;
    }

    //依LoginName取得EmpId
    static public string GetEmpIDbyLoginName()
    {
        string strTsql = "select id from Employee where username=@username";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@username", HttpContext.Current.User.Identity.Name);
        return SQLUtil.ExecuteScalar(cmd).ToString();
    }

    //設定Sales不能進入編輯頁
    public void CheckIsSales()
    {
        if (!IsEditOn())
        {
            HttpContext.Current.Response.Redirect("~/Home.aspx");
        }
    }
}