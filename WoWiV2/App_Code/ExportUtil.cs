using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// ExportUtil 的摘要描述
/// </summary>
public class ExportUtil
{
  public static void ExportWebControlToExcel(string FileName, WebControl control)
  {
    HttpContext.Current.Response.Clear();
    HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
    HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename="
        + HttpContext.Current.Server.UrlEncode(FileName) + ".xls");
    HttpContext.Current.Response.Charset = "utf-8";
    HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
    StringWriter sw = new StringWriter();
    HtmlTextWriter hw = new HtmlTextWriter(sw);    
    control.RenderControl(hw);
    HttpContext.Current.Response.Write(sw.ToString());
    HttpContext.Current.Response.Flush();
    HttpContext.Current.Response.End();
  }
}