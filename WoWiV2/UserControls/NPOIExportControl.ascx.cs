using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using NPOI.HSSF.UserModel;

namespace NPOI4Fun
{
  public partial class NPOIExportControl : System.Web.UI.UserControl
  {
    /// <summary>
    /// 目標 GridView ID
    /// </summary>
    public string TargetGridViewID { get; set; }
    /// <summary>
    /// 匯出報表名稱
    /// </summary>
    public string SheetName { get; set; }

    protected void btnExport_Click(object sender, EventArgs e)
    {
      //取得目標
      GridView gv = this.Parent.FindControl(TargetGridViewID) as GridView;

      if (gv != null)
      {
        gv.AllowPaging = false;
        gv.DataBind();
        this.ExportToFile(gv);
      }
    }

    private void ExportToFile(GridView gv)
    {
      #region 建立 WorkBook 及試算表
      HSSFWorkbook workbook = new HSSFWorkbook();
      MemoryStream ms = new MemoryStream();
      HSSFSheet mySheet1 = workbook.CreateSheet(SheetName) as HSSFSheet;
      #endregion

      #region 建立 sheet 內容
      // 建立 sheet 內容
      HSSFRow rowHeader = mySheet1.CreateRow(0) as HSSFRow;
      // 建立 Header
      // 不用 GridView.Columns.Count，因為用 AutoGenerateColumns 會抓不到
      for (int i = 1, iCount = gv.HeaderRow.Cells.Count; i < iCount; i++)
      {
        //若有啟用排序，Header會變成 LinkButton
        LinkButton lb = null;
        if (gv.HeaderRow.Cells[i].Controls.Count > 0)
          lb = gv.HeaderRow.Cells[i].Controls[0] as LinkButton;
        string strValue = (lb != null) ? lb.Text : gv.HeaderRow.Cells[i].Text;

        rowHeader.CreateCell(i - 1).SetCellValue(strValue.Replace("&nbsp;", "").Trim());
      }
      // 建立 DataRow
      for (int i = 0, iCount = gv.Rows.Count; i < iCount; i++)
      {
        HSSFRow rowItem = mySheet1.CreateRow(i + 1) as HSSFRow;
        for (int j = 1, jCount = gv.HeaderRow.Cells.Count; j < jCount; j++)
        {
          rowItem.CreateCell(j - 1).SetCellValue(gv.Rows[i].Cells[j].Text.Replace("&nbsp;", "").Trim());
        }
      }
      #endregion

      #region 匯出
      workbook.Write(ms);
      Response.AddHeader("Content-Disposition",
        string.Format("attachment; filename=" + Server.UrlEncode(DateTime.Now.ToString("yyyyMMdd") + "-" + SheetName) + ".xls"));
      Response.BinaryWrite(ms.ToArray());
      #endregion

      #region 善後
      workbook = null;
      ms.Close();
      ms.Dispose();
      #endregion
    }
  }

}