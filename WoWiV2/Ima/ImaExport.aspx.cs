using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.HSSF.Util;

public partial class Ima_ImaExport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblEmpID.Text = IMAUtil.GetEmpIDbyLoginName();
            GetExport();
        }
    }

    private void GetExport() 
    {
        string strTsql = "select * from Ima_Export where [Enable]=1 ";
        if (!IMAUtil.IsEditOn())
        {
            //Sales排除可閱覽的模組編號
            strTsql += "and MID not in(1,3,4,7,15) ";
        }
        strTsql += "order by MID,Seq";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.CommandType = CommandType.Text;
        DataTable dt = SQLUtil.QueryDS(cmd).Tables[0];
        for (int i = 0; i <= dt.Rows.Count - 1; i++) 
        {
            chExportData.Items.Insert(i, new ListItem(dt.Rows[i]["ShowName"].ToString(), dt.Rows[i]["ExportID"].ToString() + "／" + dt.Rows[i]["TableIndex"].ToString() + "／" + dt.Rows[i]["ExcelTitleName"].ToString()));
        }
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        ddlSelRegion.Items.Clear();
        ddlSelRegion.DataBind();
        ddlSelRegion.Items.Insert(0, new ListItem("All Region", "0"));
        string strSelRegion = "";
        bool blSelRegion = false;
        foreach (ListItem li in cbRegion.Items)
        {
            if (li.Selected) { blSelRegion = true; break; }
        }
        foreach (ListItem li in cbRegion.Items)
        {
            if (li.Selected) { strSelRegion += "," + li.Value; }
            else
            {
                if (blSelRegion) { ddlSelRegion.Items.Remove(new ListItem(li.Text, li.Value)); }
            }
        }
        if (strSelRegion.Length > 0)
        {
            strSelRegion = strSelRegion.Remove(0, 1);
        }
        lblRegion.Text = strSelRegion;
        GetCountryList();
        mpeCountry.Show();
    }

    protected void GetCountryList()
    {
        string strTsql = "select a.country_id,a.country_name,a.world_region_id,b.world_region_name from country a inner join world_region b on a.world_region_id=b.world_region_id ";
        if (lblRegion.Text.Length > 0) { strTsql += "where a.world_region_id in(" + lblRegion.Text + ") "; }
        if (ddlSelRegion.SelectedIndex > 0) { strTsql += "and a.world_region_id=" + ddlSelRegion.SelectedValue + " "; }
        strTsql += "order by a.country_name";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.CommandType = CommandType.Text;
        gvCountryList.DataSource = SQLUtil.QueryDS(cmd).Tables[0];
        gvCountryList.DataBind();
    }

    protected void btnCSelect_Click(object sender, EventArgs e)
    {
        string strCountryID = "";
        string strCountryName = "";
        foreach (GridViewRow gvr in gvCountryList.Rows)
        {
            CheckBox cbChoose = (CheckBox)gvr.FindControl("cbChoose");
            if (cbChoose.Checked)
            {
                strCountryID += "," + gvCountryList.DataKeys[gvr.RowIndex].Values[0].ToString();
                strCountryName += "；" + gvCountryList.DataKeys[gvr.RowIndex].Values[1].ToString();
            }
        }
        if (strCountryID.Length > 0)
        {
            strCountryID = strCountryID.Remove(0, 1);
            strCountryName = strCountryName.Remove(0, 1);
        }
        lblCountrys.Text = strCountryID;
        tbCountry.Text = strCountryName;
    }

    protected void ddlSelRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetCountryList();
        mpeCountry.Show();
    }

    protected void gvCountryList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && lblCountrys.Text.Trim().Length > 0)
        {
            string strCountryID = "," + lblCountrys.Text.Trim() + ",";
            string strCID = gvCountryList.DataKeys[e.Row.RowIndex].Values[0].ToString();
            if (strCountryID.Contains("," + strCID + ","))
            {
                CheckBox cbChoose = (CheckBox)e.Row.FindControl("cbChoose");
                cbChoose.Checked = true;
            }
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        tbCountry.Text = "";
        lblCountrys.Text = "";
    }

    protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
    {
        cbTechnology.DataBind();
    }

    /// <summary>
    /// 匯出
    /// </summary>
    protected void btnExport_Click(object sender, EventArgs e)
    {
        Export();
    }

    private void Export()
    {
        SetCondition(cbRegion, lblRegion, false);
        SetCondition(cbTechnology, lblTechID, false);
        SqlCommand cmd = new SqlCommand("STP_GetExportData");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@RID", lblRegion.Text.Trim());
        cmd.Parameters.AddWithValue("@CID", lblCountrys.Text.Trim());
        cmd.Parameters.AddWithValue("@PTID", ddlProductType.SelectedValue);
        cmd.Parameters.AddWithValue("@TecID", lblTechID.Text.Trim());
        DataSet dsTech = SQLUtil.QueryDS(cmd);

        MemoryStream ms = new MemoryStream();
        string strTitle = "WoWi_Technology";        
        base.Response.Clear();
        base.Response.Buffer = true;
        base.Response.Charset = "utf-8";
        string strFile = System.Web.HttpUtility.UrlEncode(strTitle + ".xls", System.Text.Encoding.UTF8);
        base.Response.AppendHeader("Content-Disposition", "attachment;filename=" + strFile);
        base.Response.ContentEncoding = Encoding.GetEncoding("utf-8");
        base.Response.ContentType = "application/ms-excel";
        //建立試算表
        HSSFWorkbook workbook = new HSSFWorkbook();
        ISheet sheet ;
        IRow row;
        
        //建立欄位名稱儲存格樣式
        ICellStyle icsHeader = workbook.CreateCellStyle();
        icsHeader.Alignment = HorizontalAlignment.CENTER;
        icsHeader.VerticalAlignment = VerticalAlignment.CENTER;
        icsHeader.WrapText = true;
        icsHeader.FillForegroundColor = HSSFColor.LIGHT_TURQUOISE.index;
        icsHeader.FillPattern = FillPatternType.SOLID_FOREGROUND;
        icsHeader.BorderBottom = CellBorderType.THIN;
        icsHeader.BorderLeft = CellBorderType.THIN;
        icsHeader.BorderRight = CellBorderType.THIN;
        icsHeader.BorderTop = CellBorderType.THIN;
        icsHeader.BottomBorderColor = HSSFColor.BLACK.index;
        icsHeader.LeftBorderColor = HSSFColor.BLACK.index;
        icsHeader.RightBorderColor = HSSFColor.BLACK.index;
        icsHeader.TopBorderColor = HSSFColor.BLACK.index;
        IFont iFont = workbook.CreateFont();
        iFont.Color = HSSFColor.BLACK.index;
        iFont.FontHeightInPoints = 9;
        iFont.FontName = "Arial";
        iFont.Boldweight = (short)FontBoldWeight.BOLD;
        icsHeader.SetFont(iFont);

        //建立文字儲存格樣式
        ICellStyle icsTxt = workbook.CreateCellStyle();
        icsTxt.Alignment = HorizontalAlignment.CENTER;
        icsTxt.VerticalAlignment = VerticalAlignment.CENTER;
        icsTxt.WrapText = true;
        icsTxt.BorderBottom = CellBorderType.THIN;
        icsTxt.BorderLeft = CellBorderType.THIN;
        icsTxt.BorderRight = CellBorderType.THIN;
        icsTxt.BorderTop = CellBorderType.THIN;
        icsTxt.BottomBorderColor = HSSFColor.BLACK.index;
        icsTxt.LeftBorderColor = HSSFColor.BLACK.index;
        icsTxt.RightBorderColor = HSSFColor.BLACK.index;
        icsTxt.TopBorderColor = HSSFColor.BLACK.index;
        IFont iFont1 = workbook.CreateFont();
        iFont1.FontHeightInPoints = 9;
        iFont1.FontName = "Arial";
        icsTxt.SetFont(iFont1);
        //選擇匯出的Technology
        foreach (ListItem liTechnology in cbTechnology.Items) 
        {
            if (liTechnology.Selected) 
            {
                sheet = workbook.CreateSheet(liTechnology.Text.Replace("/"," "));
                row = sheet.CreateRow(0);                
                //建立表頭
                int j = 0;
                string strExportData = "";
                string strValue = "";
                foreach(ListItem liExportData in chExportData.Items)
                { 
                    if (liExportData.Selected) 
                    {
                        //記錄勾選要匯出的欄位
                        strExportData += "；" + liExportData.Value;
                        ICell cell;
                        if (j == 0)
                        {
                            cell = row.CreateCell(j);
                            strValue = "No.";
                            cell.SetCellValue(strValue);
                            cell.CellStyle = icsHeader;
                            //自動設定欄位寬度
                            sheet.AutoSizeColumn(j);
                            j++;
                        }
                        cell = row.CreateCell(j);
                        strValue = liExportData.Value.Split('／')[2].ToString().Replace("_", " ").Replace("$", "/").Replace("@", ".").Replace("#td#", "-");
                        if (strValue.Contains("#br#"))
                        {
                            icsHeader.WrapText = true;
                            strValue = strValue.Replace("#br#", "\n");
                            //因為換行所以將Row的高度變成4倍
                            row.HeightInPoints = 4 * sheet.DefaultRowHeight / 20;
                        }
                        else { icsHeader.WrapText = true; }
                        cell.SetCellValue(strValue);
                        cell.CellStyle = icsHeader;
                        //自動設定欄位寬度
                        sheet.AutoSizeColumn(j);
                        j++;
                    }
                }

                //將要匯出的欄位寫入一維陣列
                if (strExportData.Length > 0) { strExportData = strExportData.Remove(0, 1); }
                string[] strColumn = strExportData.Split('；');
                int intRowIndex = 1;
                DataView dv;
                string strCountryID;
                //建立資料
                for (int i = 0; i <= dsTech.Tables[0].Rows.Count - 1; i++)
                {
                    strCountryID = dsTech.Tables[0].Rows[i]["country_id"].ToString();
                    row = sheet.CreateRow(intRowIndex);
                    for (int k = 0; k <= strColumn.Length; k++)
                    {
                        ICell cell;
                        if (k == 0)
                        {
                            cell = row.CreateCell(k);
                            cell.SetCellValue(i + 1);
                        }
                        else
                        {
                            cell = row.CreateCell(k);
                            strValue = strColumn[k - 1].ToString();
                            DataTable dt;
                            string str = "";
                            switch (strValue.Split('／')[1].ToString()) 
                            {
                                case "0":
                                    strValue = dsTech.Tables[Convert.ToInt32(strValue.Split('／')[1])].Rows[i][strValue.Split('／')[2].ToString()].ToString();
                                    break;
                                case "1":
                                case "2":
                                case "3":
                                case "8":
                                    //CountryID及TechnologyID篩選
                                    dv = dsTech.Tables[Convert.ToInt32(strValue.Split('／')[1])].DefaultView;
                                    //dv.RowFilter = "country_id=" + strCountryID + " and wowi_tech_id=" + liTechnology.Value;
                                    dv.RowFilter = "country_id=" + strCountryID;
                                    //判斷是否為Fee schedule 加入 wowi_tech_id is null
                                    if (strValue.Split('／')[1].ToString().Trim() == "8") { dv.RowFilter += " and (wowi_tech_id is null or wowi_tech_id=" + liTechnology.Value + ")"; }
                                    else { dv.RowFilter += " and wowi_tech_id=" + liTechnology.Value; }
                                    dt = dv.ToTable();                                    
                                    foreach (DataRow dr in dt.Rows) 
                                    {
                                        str += "\n" + dr[strValue.Split('／')[2].ToString()].ToString();
                                    }
                                    if (str.Length > 0) { strValue = str.Remove(0, 1); }
                                    else { strValue = ""; }
                                    break;
                                case "4":
                                case "5":
                                case "6":
                                case "7":
                                    //CountryID篩選
                                    dv = dsTech.Tables[Convert.ToInt32(strValue.Split('／')[1])].DefaultView;
                                    dv.RowFilter = "country_id=" + strCountryID;
                                    dt = dv.ToTable();
                                    foreach (DataRow dr in dt.Rows)
                                    {
                                        str += "\n" + dr[strValue.Split('／')[2].ToString()].ToString();
                                    }
                                    if (str.Length > 0) { strValue = str.Remove(0, 1); }
                                    else { strValue = ""; }
                                    break;
                            }
                            //判斷是否有換行符號
                            if (strValue.Contains("#br#")) 
                            {
                                if (strValue.Substring(0, 4) == "#br#")
                                {
                                    strValue = strValue.Remove(0, 4);
                                }
                            }
                            cell.SetCellValue(strValue.Replace("#br#", "\n"));
                        }
                        cell.CellStyle = icsTxt;
                    }
                    intRowIndex++;
                }
            }
        }

        workbook.Write(ms);
        Response.BinaryWrite(ms.ToArray());
        sheet = null;
        workbook = null;
        ms.Flush();
        ms.Position = 0;
        ms.Close();
        ms.Dispose();
        base.Response.End();
    }


    /// <summary>
    /// 設定查詢條件
    /// </summary>
    /// <param name="cbl"></param>
    /// <param name="lbl"></param>
    /// <param name="bl">是否為字串</param>
    protected void SetCondition(CheckBoxList cbl, Label lbl, bool bl)
    {
        lbl.Text = "";
        foreach (ListItem li in cbl.Items)
        {
            if (li.Selected)
            {
                if (bl) { lbl.Text += ",'" + li.Value + "'"; }
                else { lbl.Text += "," + li.Value; }
            }
        }
        if (lbl.Text.Trim().Length > 0) { lbl.Text = lbl.Text.Trim().Remove(0, 1); }
    }
}