<%@ WebHandler Language="C#" Class="FileListHandler" %>

using System;
using System.Web;

public class FileListHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String UpPath = System.Configuration.ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = context.Request.QueryString["id"];
        String fileName = context.Request.QueryString["fn"];
        UpPath = UpPath + "/PR/" + prid+"/"+fileName;
        context.Response.ContentType = GetContentType(fileName);
        System.IO.FileInfo file = new System.IO.FileInfo(UpPath);
        if (file.Exists)
        {
            context.Response.WriteFile(UpPath);
        }
    }

    public String GetContentType(String fileName)
    {
        int idx = fileName.LastIndexOf(".");
        String ext = fileName.Substring(idx + 1);
        string ContentType = "";
        switch (ext)
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
        return ContentType;
    }
    public bool IsReusable {
        get {
            return true;
        }
    }

}