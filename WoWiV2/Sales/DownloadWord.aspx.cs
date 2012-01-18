using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Sales_DownloadWord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string FullFileName = Request.QueryString["id"];
        FileInfo DownloadFile = new FileInfo(@"C:\" + FullFileName);
        Response.Clear();
        Response.ClearHeaders();
        Response.Buffer = false;
        //Response.ContentType指定檔案類型 
        //可以為application/ms-excel || application/ms-word || application/ms-txt 
        //application/ms-html || 或其他瀏覽器可以支援的文件
        Response.ContentType = "application/octet-stream";//所有類型
        //下面這行很重要， attachment 参数表示作為附件下載，可以改成 online線上開啟
        //filename=FileFlow.xls 指定输出檔案名稱，注意其附檔名和指定檔案類型相符，
        //可以為：.doc || .xls || .txt ||.htm
        Response.AppendHeader("Content-Disposition", "attachment;filename=" +
        HttpUtility.UrlEncode(FullFileName, System.Text.Encoding.UTF8));
        Response.AppendHeader("Content-Length", DownloadFile.Length.ToString());//取得檔案大小

        Response.WriteFile(DownloadFile.FullName);
        Response.Flush();
        Response.End();
    }
}