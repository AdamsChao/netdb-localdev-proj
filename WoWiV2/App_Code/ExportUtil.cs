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
    //HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
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

  public static void ExportGridViewToExcel(string FileName, GridView gv)
  {
    Microsoft.Office.Interop.Excel.ApplicationClass ExcelApp = 
      new Microsoft.Office.Interop.Excel.ApplicationClass();
    try
    {
      ExcelApp.Application.Workbooks.Add(Type.Missing);

      //匯出全部欄位資料
      //for (int i = 1; i < gv.Columns.Count + 1; i++)
      //{
      //  ExcelApp.Cells[1, i] = gv.Columns[i - 1].HeaderText;
      //}
      //for (int i = 0; i < gv.Rows.Count - 1; i++)
      //{
      //  for (int j = 0; j < gv.Columns.Count; j++)
      //  {
      //    ExcelApp.Cells[i + 2, j + 1] = gv.Rows[i].Cells[j].Text.ToString();
      //  }
      //}

      //隱藏第一個欄位資料
      for (int i = 1; i < gv.Columns.Count ; i++)
      { 
        ExcelApp.Cells[1, i] = gv.Columns[i].HeaderText;
      }
      for (int i = 0; i < gv.Rows.Count - 1; i++)
      {
        for (int j = 1; j < gv.Columns.Count; j++)
        {
          ExcelApp.Cells[i + 2, j] = gv.Rows[i].Cells[j].Text.ToString().Replace("&nbsp;", "");
        }
      }
      ExcelApp.ActiveWorkbook.SaveCopyAs(FileName);
      ExcelApp.ActiveWorkbook.Saved = true;
      ExcelApp.Quit();
    }
    catch (Exception ex)
    {
      throw ex;
    }
    finally
    {
      ExcelApp.Quit();
      System.Runtime.InteropServices.Marshal.ReleaseComObject(ExcelApp);
      ExcelApp = null;
    }
    GC.Collect();
  }
}