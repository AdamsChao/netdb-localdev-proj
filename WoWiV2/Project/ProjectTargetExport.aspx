<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>
<%@ Import Namespace="NPOI" %>
<%@ Import Namespace="NPOI.HSSF.UserModel" %>
<%@ Import Namespace="NPOI.SS.UserModel" %>
<%@ Import Namespace="System.IO" %>

<%@ Register src="~/UserControls/NPOIExportControl.ascx" tagname="NPOIExportControl" tagprefix="netdb" %>

<script runat="server">

  protected void btn_export_Click(object sender, EventArgs e)
  {
    string SheetName = "ProjectTarget";
    
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
    for (int i = 1, iCount = gv_project.HeaderRow.Cells.Count; i < iCount; i++)
    {
      //若有啟用排序，Header會變成 LinkButton
      LinkButton lb = null;
      if (gv_project.HeaderRow.Cells[i].Controls.Count > 0)
        lb = gv_project.HeaderRow.Cells[i].Controls[0] as LinkButton;
      string strValue = (lb != null) ? lb.Text : gv_project.HeaderRow.Cells[i].Text;

      rowHeader.CreateCell(i - 1).SetCellValue(strValue.Replace("&nbsp;", "").Replace("&amp;", "&").Trim());
    }
    // 建立 DataRow
    HSSFRow rowItem = null;
    HSSFCell cell = null;
    for (int i = 0, iCount = gv_project.Rows.Count; i < iCount; i++)
    {
      rowItem = mySheet1.CreateRow(i + 1) as HSSFRow;
      for (int j = 1, jCount = gv_project.HeaderRow.Cells.Count; j < jCount; j++)
      {
        cell = rowItem.CreateCell(j - 1) as HSSFCell;
        string data = gv_project.Rows[i].Cells[j].Text.Replace("&nbsp;", "").Trim();        
        
        if (j==4 || j==5) //日期欄位
        {
          DateTime dt = new DateTime();
          if (DateTime.TryParse(data,out dt))
          {
            cell.SetCellValue(dt);
          }          
          //設定日期格式
          HSSFCellStyle cellStyle = workbook.CreateCellStyle() as HSSFCellStyle;
          HSSFDataFormat format = workbook.CreateDataFormat() as HSSFDataFormat;
          cellStyle.DataFormat = format.GetFormat("yyyy/mm/dd");
          cell.CellStyle = cellStyle;
        }
        else
        {
          rowItem.CreateCell(j - 1).SetCellValue(data);
        }
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
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:Button ID="btn_export" runat="server" onclick="btn_export_Click" 
    Text="Export Data To Excel" />
  ( 下列 Project 資料為兩年內 DATA )<asp:GridView ID="gv_project" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSource_Project" AllowPaging="True" PageSize="30">
    <Columns>
      <asp:BoundField DataField="Quotation_Target_Id" 
        HeaderText="Quotation_Target_Id" InsertVisible="False" ReadOnly="True" 
        SortExpression="Quotation_Target_Id" Visible="False" />
      <asp:BoundField DataField="country_name" HeaderText="Country" ReadOnly="True" 
        SortExpression="country_name" />
      <asp:BoundField DataField="authority_name" HeaderText="Authority" 
        ReadOnly="True" SortExpression="authority_name" />
      <asp:BoundField DataField="Project No.[Model No.]" 
        HeaderText="Project No.[Model No.]" ReadOnly="True" 
        SortExpression="Project No.[Model No.]" />
      <asp:BoundField DataField="document_ready_to_process" DataFormatString="{0:d}" 
        HeaderText="Document &amp; Sample are ready to be process" 
        SortExpression="document_ready_to_process" />
      <asp:BoundField DataField="certification_completed" DataFormatString="{0:d}" 
        HeaderText="Certification Completed" SortExpression="certification_completed" />
      <asp:BoundField DataField="Actual_Lead_time" 
        HeaderText="Actual Lead Time(Week)" SortExpression="Actual_Lead_time" />
    </Columns>
  </asp:GridView>
  <asp:SqlDataSource ID="SqlDataSource_Project" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
    SelectCommand="SELECT Quotation_Target_Id, 
(SELECT COUNTRY_NAME FROM COUNTRY WHERE COUNTRY_ID=Quotation_Target.country_id) AS country_name,
(SELECT authority_name FROM Authority WHERE Authority.authority_id = Quotation_Target.authority_id ) AS authority_name, 
Project_Id , 
Project_No + ' ['+ (SELECT Model_No FROM Quotation_Version WHERE Quotation_Version.Quotation_Version_Id = PROJECT.Quotation_Id) +']' AS 'Project No.[Model No.]' , 
document_ready_to_process , certification_completed, Actual_Lead_time
FROM PROJECT 
INNER JOIN Quotation_Version ON PROJECT.Quotation_No = Quotation_Version.Quotation_No  AND Quotation_Status=5 
INNER JOIN Quotation_Target ON Quotation_Target.quotation_id = Quotation_Version.Quotation_Version_Id
WHERE PROJECT.Create_Date between DATEADD(year,-2,getdate()) and  DATEADD(year,1,getdate())
Order by country_name , authority_name ">
  </asp:SqlDataSource>
</asp:Content>

