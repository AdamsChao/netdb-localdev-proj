<%@ WebHandler Language="C#" Class="NationalGovFile" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class NationalGovFile : IHttpHandler
{    
    public void ProcessRequest (HttpContext context) {        
        if ((context.Request["fid"] != null)) 
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_NationalGover_Files where NationalGovFileID=@FileID";
            cmd.Parameters.AddWithValue("@FileID", context.Request["fid"]);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string strGeneralFileName = dt.Rows[0]["FileName"].ToString();
                string strGeneralFileURL = IMAUtil.GetIMAUploadPath() + dt.Rows[0]["FileURL"].ToString();
                string strGeneralFileType = dt.Rows[0]["FileType"].ToString();
                //確認檔案存在    
                System.IO.FileInfo file = new System.IO.FileInfo(strGeneralFileURL);
                if (file.Exists)
                {
                    string ContentType = "";
                    switch (strGeneralFileType)
                    {
                        case "jpg":
                        case "jpeg":
                        case "jpe":
                            ContentType = "image/jpeg";
                            break;
                        case "gif":
                            ContentType = "image/gif";
                            break;
                        case "pdf":
                            ContentType = "application/pdf";
                            break;
                        case "png":
                            ContentType = "image/png";
                            break;
                        case "docx":
                        case "doc":
                            ContentType = "application/msword";
                            break;
                        case "xlsx":
                        case "xls":
                            ContentType = "application/vnd.ms-excel";
                            break;
                        case "pptx":
                        case "ppt":
                            ContentType = "application/vnd.ms-powerpoint";
                            break;
                        case "rar":
                            ContentType = "application/x-rar-compressed";
                            break;
                        case "zip":
                            ContentType = "application/x-zip-compressed";
                            break;
                    }
                    context.Response.AddHeader("Content-Disposition", String.Format("attachment; filename=" + HttpUtility.UrlEncode(strGeneralFileName) + HttpUtility.UrlEncode("." + strGeneralFileType)));
                    //context.Response.AddHeader("content-disposition", "attachment; filename=" + HttpUtility.UrlPathEncode(strGeneralFileName));
                    context.Response.ContentType = ContentType;
                    context.Response.WriteFile(strGeneralFileURL);
                }
                else
                {
                    context.Response.Write("找不到指定的檔案");
                }
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}