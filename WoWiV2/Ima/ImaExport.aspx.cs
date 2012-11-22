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
using System.Web.UI.HtmlControls;

public partial class Ima_ImaExport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // Set 以IE8文件模式解析
            HtmlMeta htmlMeta = new HtmlMeta();
            htmlMeta.HttpEquiv = "X-UA-Compatible";
            htmlMeta.Content = "IE=EmulateIE8";
            //Master.Page.Header.Controls.AddAt(0, htmlMeta);
            Page.Header.Controls.AddAt(0, htmlMeta);

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
        //加入第16個模組選項
        if (chExportData.Items.Count > 0)
        {
            chExportData.Items.Insert(chExportData.Items.Count, new ListItem("Frequency allocation,power limit by Technologies", "0"));
        }
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        lblCCountrys.Text = lblCountrys.Text;
        ddlSelRegion.Items.Clear();
        ddlSelRegion.DataBind();
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
        if (lblRegion.Text.Trim().Length > 0)
        {
            ddlSelRegion.Items.Insert(0, new ListItem("All Selected Region", "0"));
        }
        else 
        {
            ddlSelRegion.Items.Insert(0, new ListItem("All Region", "0")); 
        }
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
        string strSqlCountryID = lblCCountrys.Text.Trim();
        if (strSqlCountryID.Length > 0)
        {
            if (lblCCountrys.Text.Trim().Substring(0, 1) == ",")
            {
                strSqlCountryID = lblCCountrys.Text.Trim().Remove(0, 1);
            }
        }
        else { strSqlCountryID = "0"; }
        string strTsql = "select country_id,country_name from country where country_id in(" + strSqlCountryID + ") order by country_name";
        SqlCommand cmd = new SqlCommand(strTsql);
        SqlDataReader sdr = SQLUtil.QueryDR(cmd);
        while (sdr.Read()) 
        {
            strCountryID += "," + sdr["country_id"].ToString();
            strCountryName += "；" + sdr["country_name"].ToString();
        }
        
        
        //foreach (GridViewRow gvr in gvCountryList.Rows)
        //{
        //    CheckBox cbChoose = (CheckBox)gvr.FindControl("cbChoose");
        //    if (cbChoose.Checked)
        //    {
        //        strCountryID += "," + gvCountryList.DataKeys[gvr.RowIndex].Values[0].ToString();
        //        strCountryName += "；" + gvCountryList.DataKeys[gvr.RowIndex].Values[1].ToString();
        //    }
        //}

        if (strCountryID.Length > 0)
        {
            //strCountryID = strCountryID.Remove(0, 1);
            strCountryName = strCountryName.Remove(0, 1);
        }
        lblCCountrys.Text = strCountryID;
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
        if (e.Row.RowType == DataControlRowType.DataRow && lblCCountrys.Text.Trim().Length > 0)
        {
            string strCountryID = "," + lblCCountrys.Text.Trim() + ",";
            string strCID = gvCountryList.DataKeys[e.Row.RowIndex].Values[0].ToString();
            if (strCountryID.Contains("," + strCID + ","))
            {
                CheckBox cbChoose = (CheckBox)e.Row.FindControl("cbChoose");
                cbChoose.Checked = true;
            }
        }
    }

    //選擇國家時
    protected void cb_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        if (cb.Checked)
        {
            lblCCountrys.Text += "," + cb.ToolTip.ToString();
        }
        else 
        {
            lblCCountrys.Text = lblCCountrys.Text.Replace("," + cb.ToolTip.ToString(), "");
        }
        mpeCountry.Show();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        tbCountry.Text = "";
        lblCountrys.Text = "";
        lblCCountrys.Text = "";
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
        try
        {
            if (!CheckExportData(cbTechnology))
            {
                Message.Text = "請選擇要匯出的Technology!";
                return;
            }
            if (!CheckExportData(chExportData))
            {
                Message.Text = "請選擇要匯出的Export Datas!";
                return;
            }
            Export();
        }
        catch (Exception ex)
        {
            Message.Text = "檔案匯出錯誤，錯誤訊息為：" + ex.Message + "，請通知系統管理員!";
        }
    }


    //檢查是否有勾選要匯出的Technology或匯出的欄位
    private bool CheckExportData(CheckBoxList cb)
    {
        bool IsSelect = false;
        foreach (ListItem li in cb.Items)
        {
            if (li.Selected) { IsSelect = true; break; }
        }
        return IsSelect;
    }

    private void Export()
    {
        SetCondition(cbRegion, lblRegion, false);
        SetCondition(cbTechnology, lblTechID, false);
        string strSelCountryID = lblCountrys.Text.Trim();
        if (strSelCountryID.Length > 0 && strSelCountryID.Substring(0, 1) == ",") 
        {
            strSelCountryID = strSelCountryID.Remove(0, 1);
        }
        SqlCommand cmd = new SqlCommand("STP_GetExportData");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@RID", lblRegion.Text.Trim());
        cmd.Parameters.AddWithValue("@CID", strSelCountryID);
        cmd.Parameters.AddWithValue("@PTID", ddlProductType.SelectedValue);
        cmd.Parameters.AddWithValue("@TecID", lblTechID.Text.Trim());
        DataSet dsTech = SQLUtil.QueryDS(cmd);

        MemoryStream ms = new MemoryStream();
        string strTitle = "WoWi_Technology_"
          + DateTime.Now.ToString("yyyyMMdd_HHmmss_")
          + User.Identity.Name;

        //Mark By Adams=================================
        //base.Response.Clear();
        //base.Response.Buffer = true;
        //base.Response.Charset = "utf-8";
        string strFile = System.Web.HttpUtility.UrlEncode(strTitle + ".xls", System.Text.Encoding.UTF8);
        //base.Response.AppendHeader("Content-Disposition", "attachment;filename=" + strFile);
        //base.Response.ContentEncoding = Encoding.GetEncoding("utf-8");
        //base.Response.ContentType = "application/ms-excel";
        //Mark By Adams=================================

        //建立試算表
        HSSFWorkbook workbook = new HSSFWorkbook();
        ISheet sheet;
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
        //判斷第16個模組是否有勾選匯出
        bool blnFrequency = chExportData.Items[chExportData.Items.Count - 1].Selected;
        DataTable dtFreqTitle;
        DataTable dtFreq;
        //選擇匯出的Technology
        foreach (ListItem liTechnology in cbTechnology.Items)
        {
            if (liTechnology.Selected)
            {
                sheet = workbook.CreateSheet(liTechnology.Text.Replace("/", " "));
                row = sheet.CreateRow(0);
                //建立表頭
                int j = 0;
                string strExportData = "";
                string strValue = "";
                foreach (ListItem liExportData in chExportData.Items)
                {
                    if (liExportData.Selected && liExportData.Value != "0")
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
                        strValue = liExportData.Value.Split('／')[2].ToString().Replace("_", " ").Replace("$", "/").Replace("@", ".").Replace("#td#", "-").Replace("#thl#", "(").Replace("#thr#", ")");
                        row.HeightInPoints = 24;
                        if (strValue.Contains("#br#"))
                        {
                            icsHeader.WrapText = true;
                            strValue = strValue.Replace("#br#", "\n");
                            //因為換行所以將Row的高度變成4倍
                            //row.HeightInPoints = 2 * sheet.DefaultRowHeight / 20;
                            //row.HeightInPoints = 24;
                        }
                        else { icsHeader.WrapText = true; }
                        cell.SetCellValue(strValue);
                        cell.CellStyle = icsHeader;
                        //自動設定欄位寬度
                        sheet.AutoSizeColumn(j);
                        j++;
                    }
                }

                //建立第16個模組表頭
                int intTitleIndex = j;
                string[] strTitle3 = { };
                if (blnFrequency)
                {
                    cmd = new SqlCommand("STP_ImaFrequencyTitle");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@wowi_tech_id", liTechnology.Value);
                    dtFreqTitle = SQLUtil.QueryDS(cmd).Tables[0];
                    if (dtFreqTitle.Rows.Count > 0)
                    {
                        //int intTitleIndex = j;
                        int intTitle2Index = 0;
                        IRow row1 = sheet.CreateRow(1);
                        IRow row2 = sheet.CreateRow(2);
                        ICell cell;
                        foreach (DataRow dr in dtFreqTitle.Rows)
                        {
                            strTitle3 = dr["Title3"].ToString().Split(';');
                            for (int i = 0; i <= strTitle3.Length - 1; i++)
                            {
                                //第0列
                                cell = row.CreateCell(intTitleIndex + i);
                                cell.SetCellValue(dr["TechnologyCategoryName"].ToString());
                                cell.CellStyle = icsHeader;

                                cell = row1.CreateCell(intTitleIndex + i);
                                cell.SetCellValue(dr["Frequency"].ToString().Replace("#br#", "\n"));
                                cell.CellStyle = icsHeader;
                                if (dr["Frequency"].ToString().Contains("#br#"))
                                {
                                    //因為換行所以將Row的高度變成3倍
                                    row1.HeightInPoints = 3 * sheet.DefaultRowHeight / 20;
                                }
                                else
                                {
                                    row1.HeightInPoints = 24;
                                }
                                cell = row2.CreateCell(intTitleIndex + i);
                                cell.SetCellValue(strTitle3.GetValue(i).ToString());
                                cell.CellStyle = icsHeader;
                                row2.HeightInPoints = 24;
                                //自動設定欄位寬度
                                sheet.AutoSizeColumn(intTitleIndex + i);
                            }
                            intTitleIndex += strTitle3.Length;
                            //合併第二列的欄位
                            sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(1, 1, j + intTitle2Index * strTitle3.Length, intTitleIndex - 1));
                            intTitle2Index++;
                            //建立備註欄位
                            if (intTitle2Index == dtFreqTitle.Rows.Count && Convert.ToBoolean(dr["IsRemark"]))
                            {
                                cell = row.CreateCell(intTitleIndex);
                                cell.CellStyle = icsHeader;
                                cell = row1.CreateCell(intTitleIndex);
                                cell.SetCellValue("Remark");
                                cell.CellStyle = icsHeader;
                                cell = row2.CreateCell(intTitleIndex);
                                cell.CellStyle = icsHeader;
                                sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(1, 2, intTitleIndex, intTitleIndex));
                                //自動設定欄位寬度
                                sheet.AutoSizeColumn(intTitleIndex);
                                //再加1是因為合併第一列欄位時減1的原因
                                intTitleIndex += 1;
                            }
                        }
                        //合併第一列欄位
                        sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(0, 0, j, intTitleIndex - 1));
                        //建立第2及第3列前n欄表頭，並且上下欄位合併
                        for (int i = 1; i <= 2; i++)
                        {
                            row = sheet.GetRow(i);
                            for (int k = 0; k < j; k++)
                            {
                                cell = row.CreateCell(k);
                                cell.CellStyle = icsHeader;
                                sheet.AddMergedRegion(new NPOI.SS.Util.CellRangeAddress(0, 2, k, k));
                            }
                        }
                    }
                    else//Technology沒有對應的Frequency
                    {
                        blnFrequency = false;
                    }
                }

                //若沒有勾選模組16則資料從第1列開始寫入，若有則從第3列開始寫入
                int intRowIndex = 1;
                if (blnFrequency)
                {
                    intRowIndex = 3;
                }
                //將要匯出的欄位寫入一維陣列
                if (strExportData.Length > 0) { strExportData = strExportData.Remove(0, 1); }
                string[] strColumn = strExportData.Split('；');
                DataView dv;
                string strCountryID;
                string strRegionID;
                //建立資料intTitleIndex 
                for (int i = 0; i <= dsTech.Tables[0].Rows.Count - 1; i++)
                {
                    strCountryID = dsTech.Tables[0].Rows[i]["country_id"].ToString();
                    strRegionID = dsTech.Tables[0].Rows[i]["world_region_id"].ToString();
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
                                //case "1":2012/10/05取消與Technology的關連
                                //case "2":2012/10/05取消與Technology的關連
                                //case "3":2012/10/05取消與Technology的關連
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
                                case "1"://2012/10/05取消與Technology的關連
                                case "2"://2012/10/05取消與Technology的關連
                                case "3"://2012/10/05取消與Technology的關連
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
                    //第16個模組資料
                    if (blnFrequency)
                    {
                        cmd = new SqlCommand("STP_ImaFrequencyGet");
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@world_region_id", strRegionID);
                        cmd.Parameters.AddWithValue("@country_id", strCountryID);
                        cmd.Parameters.AddWithValue("@wowi_tech_id", liTechnology.Value);
                        dtFreq = SQLUtil.QueryDS(cmd).Tables[0];
                        ICell cell;
                        if (dtFreq.Rows.Count > 0)
                        {
                            int intTechnologyCategoryID = Convert.ToInt32(dtFreq.Rows[0]["TechnologyCategoryID"]);
                            int intShowColumn = 0;
                            int intCalcRow = 0;//記錄dtFreq跑迴圈到第幾筆資料
                            string[] strFreColumn = { "IsAllowedN", "PowerLimit", "DoorAllowed", "HT", "TPCDFS" };
                            //strTitle3 = dtFreq.Rows[0]["Title3"].ToString().Split(';');
                            intShowColumn = strTitle3.Length;
                            foreach (DataRow dr in dtFreq.Rows)
                            {
                                for (int l = strColumn.Length + 1 + intShowColumn * intCalcRow; l <= strColumn.Length + intShowColumn + intShowColumn * intCalcRow; l++)
                                {
                                    string strFreqValue = "";
                                    for (int intK = 0; intK <= intShowColumn - 1; intK++)
                                    {
                                        cell = row.CreateCell(l);
                                        strFreqValue = dr[strFreColumn.GetValue(intK).ToString()].ToString().Trim();
                                        if (strFreqValue.Contains("#br#"))
                                        {
                                            if (strFreqValue.Substring(0, 4) == "#br#")
                                            {
                                                strFreqValue = strFreqValue.Remove(0, 4);
                                                strFreqValue = strFreqValue.Replace("#br#", "\n");
                                            }
                                            else { strFreqValue = strFreqValue.Replace("#br#", "\n"); }
                                        }
                                        cell.SetCellValue(strFreqValue);
                                        cell.CellStyle = icsTxt;
                                        l++;
                                    }
                                }
                                intCalcRow++;
                            }
                            //判斷是否有Remark備註資料
                            if (Convert.ToBoolean(dtFreq.Rows[0]["IsRemark"]))
                            {
                                cell = row.CreateCell(strColumn.Length + intShowColumn * intCalcRow + 1);
                                cell.SetCellValue(dtFreq.Rows[0]["Remark"].ToString());
                                cell.CellStyle = icsTxt;
                            }                            
                        }
                        else
                        {
                            for (int l = strColumn.Length + 1; l <= intTitleIndex - 1; l++)
                            {
                                cell = row.CreateCell(l);
                                cell.CellStyle = icsTxt;
                            }
                        }
                    }
                    intRowIndex++;
                }
            }
        }

        //Add Export Flow by Adams 2012/11/12======================================================
        string ExportPathNoEncrypt =
          System.Configuration.ConfigurationManager.AppSettings["IMAExportPathNoEncrypt"].ToString();
        string ExportPathWithEncrypt =
          System.Configuration.ConfigurationManager.AppSettings["IMAExportPathWithEncrypt"].ToString();
        FileStream fs = new FileStream(ExportPathNoEncrypt + strFile, FileMode.Create);
        workbook.Write(fs);
        //workbook.Write(ms);
        //Response.BinaryWrite(ms.ToArray());
        sheet = null;
        workbook.Dispose();
        workbook = null;
        ms.Flush();
        ms.Position = 0;
        ms.Close();
        ms.Dispose();
        //base.Response.End();
        fs.Close();

        //產生加密的Excel檔
        string openPassword = ExcelEncrypt.GenerateRandomCode();
        string writePassword = ExcelEncrypt.GenerateRandomCode();
        ExcelEncrypt.EncryptExcelByPassword(ExportPathNoEncrypt + strFile,
          ExportPathWithEncrypt + strFile,
          openPassword,
          openPassword);
        //傳送MAIL
        string mailfrom = "dbService@wowiapproval.com";
        string mailTo = System.Configuration.ConfigurationManager.AppSettings["IMAExportApprovor"].ToString();
        string mailSubject = "[IMA Notice]" + User.Identity.Name + " had Export IMA Document at " + DateTime.Now.ToString();
        string mailBody =
          "<br/> Dear Approver:" +
          "<br/> The password of IMA Export Excel File：" + openPassword +
          "<br/> Please refer to the attachment file";
        MailUtil.SendMailWithAttachment(mailfrom, mailTo, mailSubject, mailBody, ExportPathWithEncrypt + strFile);
        //Add Export Flow by Adams 2012/11/12======================================================
        Message.Text = "檔案 : " + strFile + " 匯出完成，請待主管審核確認!";
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