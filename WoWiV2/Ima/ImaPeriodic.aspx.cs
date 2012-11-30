using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Ima_ImaPeriodic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //設定業務人員不可進入編輯Page
            new IMAUtil().CheckIsSales();
            BindItem();
            LoadData();
            SetControlVisible();
        }
    }

    //載入選項
    protected void BindItem()
    {
        //載入幣別
        //string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        //if (strFeeUnit != "") 
        //{
        //    ddlDocumentFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit));
        //    ddlOneTimeFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit));
        //    ddlPeriodicFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit));
        //    ddlOtherFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); 
        //}
        //Tech_RF
        //cbTechRF.DataBind();
        //foreach (ListItem li in cbTechRF.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechRF.Items.Count > 0) { cbTechRF.Items.Insert(0, new ListItem("All", "0")); cbTechRF.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_EMC
        //cbTechEMC.DataBind();
        //foreach (ListItem li in cbTechEMC.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechEMC.Items.Count > 0) { cbTechEMC.Items.Insert(0, new ListItem("All", "0")); cbTechEMC.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_Safety
        //cbTechSafety.DataBind();
        //foreach (ListItem li in cbTechSafety.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechSafety.Items.Count > 0) { cbTechSafety.Items.Insert(0, new ListItem("All", "0")); cbTechSafety.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        ////Tech_Telecom
        //cbTechTelecom.DataBind();
        //foreach (ListItem li in cbTechTelecom.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechTelecom.Items.Count > 0) { cbTechTelecom.Items.Insert(0, new ListItem("All", "0")); cbTechTelecom.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        //HtmlTableRow trTech;
        //foreach (string strCT in lblProTypeName.Text.Trim().Split(','))
        //{
        //    if (strCT.Length > 0)
        //    {
        //        if (strCT == "RF") { trTech = trTechRF; }
        //        else if (strCT == "EMC") { trTech = trTechEMC; }
        //        else if (strCT == "Safety") { trTech = trTechSafety; }
        //        else { trTech = trTechTelecom; }
        //        trTech.Style.Value = "display:'';";
        //    }
        //}
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Periodic Factory inspection Edit";
        string strID = Request["pfiid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Periodic where PeriodicID=@PeriodicID";
            cmd.Parameters.AddWithValue("@PeriodicID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblFactoryInspection.SelectedValue = dt.Rows[0]["FactoryInspection"].ToString();
                tbYear.Text = dt.Rows[0]["Year"].ToString();
                tbMonth.Text = dt.Rows[0]["Month"].ToString();
                tbPeriodicDesc.Text = dt.Rows[0]["PeriodicDesc"].ToString();
                tbDocumentFee.Text = dt.Rows[0]["DocumentFee"].ToString();
                //ddlDocumentFeeUnit.SelectedValue = dt.Rows[0]["DocumentFeeUnit"].ToString();
                tbOneTimeFee.Text = dt.Rows[0]["OneTimeFee"].ToString();
                //ddlOneTimeFeeUnit.SelectedValue = dt.Rows[0]["OneTimeFee"].ToString();
                tbPeriodicFee.Text = dt.Rows[0]["PeriodicFee"].ToString();
                //ddlPeriodicFeeUnit.SelectedValue = dt.Rows[0]["PeriodicFee"].ToString();
                tbOtherFee.Text = dt.Rows[0]["OtherFee"].ToString();
                //ddlOtherFeeUnit.SelectedValue = dt.Rows[0]["OtherFee"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Periodic Factory inspection Copy";
                    gvFile1.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                }
            }
            ////Technology
            //cmd = new SqlCommand();
            //cmd.CommandText = "select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            //cmd.Parameters.AddWithValue("@DID", strID);
            //cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            //DataSet ds = SQLUtil.QueryDS(cmd);
            //DataTable dtTechnology = ds.Tables[0];
            //if (dtTechnology.Rows.Count > 0)
            //{
            //    CheckBoxList cbl;
            //    if (lblProTypeName.Text.Trim() == "RF") { cbl = cbTechRF; }
            //    else if (lblProTypeName.Text.Trim() == "EMC") { cbl = cbTechEMC; }
            //    else if (lblProTypeName.Text.Trim() == "Safety") { cbl = cbTechSafety; }
            //    else { cbl = cbTechTelecom; }
            //    foreach (DataRow dr in dtTechnology.Rows)
            //    {
            //        foreach (ListItem li in cbl.Items)
            //        {
            //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
            //        }
            //    }
            //    if (dtTechnology.Rows.Count == cbl.Items.Count - 1) { cbl.Items[0].Selected = true; }
            //}
        }
        else
        {
            btnSave.Visible = true;
            trProductType.Visible = true;
            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_Periodic (world_region_id,country_id,wowi_product_type_id,FactoryInspection,Year,Month,PeriodicDesc,CreateUser,LasterUpdateUser,DocumentFee,DocumentFeeUnit,OneTimeFee,OneTimeFeeUnit,PeriodicFee,PeriodicFeeUnit,OtherFee,OtherFeeUnit) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@FactoryInspection,@Year,@Month,@PeriodicDesc,@CreateUser,@LasterUpdateUser,@DocumentFee,@DocumentFeeUnit,@OneTimeFee,@OneTimeFeeUnit,@PeriodicFee,@PeriodicFeeUnit,@OtherFee,@OtherFeeUnit)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@FactoryInspection", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Year", SqlDbType.Int);
        cmd.Parameters.Add("@Month", SqlDbType.Int);
        cmd.Parameters.Add("@PeriodicDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@DocumentFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@DocumentFeeUnit", SqlDbType.NVarChar);
        cmd.Parameters.Add("@OneTimeFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@OneTimeFeeUnit", SqlDbType.NVarChar);
        cmd.Parameters.Add("@PeriodicFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@PeriodicFeeUnit", SqlDbType.NVarChar);
        cmd.Parameters.Add("@OtherFee", SqlDbType.Decimal);
        cmd.Parameters.Add("@OtherFeeUnit", SqlDbType.NVarChar);
        string strCopyTo = HttpUtility.UrlDecode(Request["pt"]);
        if (Request["copy"] != null)
        {
            foreach (ListItem li in cbProductType.Items)
            {
                if (li.Selected)
                {
                    strCopyTo += "," + li.Value;
                }
            }
            if (strCopyTo != "") { strCopyTo = strCopyTo.Remove(0, 1); }
        }
        foreach (string str in strCopyTo.Split(','))
        {
            if (str != "")
            {
                lblProType.Text = str;
                cmd.Parameters["@world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@FactoryInspection"].Value = rblFactoryInspection.SelectedValue;
                
                if (tbYear.Text.Trim().Length > 0)
                {
                    cmd.Parameters["@Year"].Value = tbYear.Text.Trim();
                }
                else
                {
                    cmd.Parameters["@Year"].Value = DBNull.Value;
                }
                if (tbMonth.Text.Trim().Length > 0)
                {
                    cmd.Parameters["@Month"].Value = tbMonth.Text.Trim();
                }
                else
                {
                    cmd.Parameters["@Month"].Value = DBNull.Value;
                }
                cmd.Parameters["@PeriodicDesc"].Value = tbPeriodicDesc.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                if (tbDocumentFee.Text.Trim().Length > 0) { cmd.Parameters["@DocumentFee"].Value = tbDocumentFee.Text.Trim(); }
                else { cmd.Parameters["@DocumentFee"].Value = DBNull.Value; }
                //cmd.Parameters["@DocumentFeeUnit"].Value = ddlDocumentFeeUnit.SelectedValue;
                cmd.Parameters["@DocumentFeeUnit"].Value = "USD";
                if (tbOneTimeFee.Text.Trim().Length > 0) { cmd.Parameters["@OneTimeFee"].Value = tbOneTimeFee.Text.Trim(); }
                else { cmd.Parameters["@OneTimeFee"].Value = DBNull.Value; }
                //cmd.Parameters["@OneTimeFeeUnit"].Value = ddlOneTimeFeeUnit.SelectedValue;
                cmd.Parameters["@OneTimeFeeUnit"].Value = "USD";
                if (tbPeriodicFee.Text.Trim().Length > 0) { cmd.Parameters["@PeriodicFee"].Value = tbPeriodicFee.Text.Trim(); }
                else { cmd.Parameters["@PeriodicFee"].Value = DBNull.Value; }
                //cmd.Parameters["@PeriodicFeeUnit"].Value = ddlPeriodicFeeUnit.SelectedValue;
                cmd.Parameters["@PeriodicFeeUnit"].Value = "USD";
                if (tbOtherFee.Text.Trim().Length > 0) { cmd.Parameters["@OtherFee"].Value = tbOtherFee.Text.Trim(); }
                else { cmd.Parameters["@OtherFee"].Value = DBNull.Value; }
                //cmd.Parameters["@OtherFeeUnit"].Value = ddlOtherFeeUnit.SelectedValue;
                cmd.Parameters["@OtherFeeUnit"].Value = "USD";
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    CopyDocData(gvFile1, intGeneralID);
                }
                //新增Technology
                //AddUpdTechnology(intGeneralID);
            }
        }
        BackURL();
    }

    //
    protected void CopyDocData(GridView gv, int intGeneralID)
    {
        foreach (GridViewRow gvr in gv.Rows)
        {
            CheckBox chSelCopy = (CheckBox)gvr.FindControl("chSelCopy");
            if (chSelCopy.Checked)
            {
                //複制檔案資料
                CopyDoc(intGeneralID, gv.DataKeys[gvr.RowIndex].Values[0].ToString());
                //複制檔案
                Label lblFileURL = (Label)gvr.FindControl("lblFileURL");
                string strFileURLO = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim();
                string strFileURLN = IMAUtil.GetIMAUploadPath() + lblFileURL.Text.Trim().Replace(@"\" + lblProTypeName.Text.Trim() + @"\", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
                if (strFileURLO != strFileURLN)
                {
                    //上傳檔案路徑
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PeriodicFactoryinspection\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intGAID, string strGAFID)
    {
        string strTsql = "insert into Ima_Periodic_Files (PeriodicID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @PeriodicID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Periodic_Files where PeriodicFileID=@PeriodicFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PeriodicID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@PeriodicFileID", strGAFID);
        SQLUtil.ExecuteSql(cmd);
    }

    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        //Attach sample certificate附件
        GeneralFileUpload(intGeneralID, fuGeneral1, "A");
        GeneralFileUpload(intGeneralID, fuGeneral2, "A");
        GeneralFileUpload(intGeneralID, fuGeneral3, "A");
        GeneralFileUpload(intGeneralID, fuGeneral4, "A");
        GeneralFileUpload(intGeneralID, fuGeneral5, "A");
    }

    protected void GeneralFileUpload(int intID, FileUpload fu, string strFileCatetory)
    {
        string strFileURL = "";
        string strFileName = "";
        string strFileType = "";
        if (fu.HasFile)
        {
            //取得檔名(包含副檔名)
            strFileName = fu.FileName.Trim();
            //strFileURL = @"D:\IMA\General\" + strFileName;
            //上傳檔案路徑
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PeriodicFactoryinspection\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Periodic_Files (PeriodicID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@PeriodicID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@PeriodicID", intID);
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

    //新增及修改Technology
    //protected void AddUpdTechnology(int intID)
    //{
    //    SqlCommand cmd;
    //    string strTsql = "";
    //    //刪除Technology
    //    cmd = new SqlCommand();
    //    strTsql = "delete from Ima_Technology where DID=@DID and Categroy=@Categroy";
    //    cmd.CommandText = strTsql;
    //    cmd.Parameters.AddWithValue("@DID", intID);
    //    cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
    //    SQLUtil.ExecuteSql(cmd);
    //    //新增Technology
    //    strTsql = "if (not exists(select DID from Ima_Technology where DID=@DID and Categroy=@Categroy and wowi_tech_id=@wowi_tech_id)) ";
    //    strTsql += "insert into Ima_Technology (DID,Categroy,wowi_tech_id) values(@DID,@Categroy,@wowi_tech_id)";
    //    cmd = new SqlCommand();
    //    cmd.CommandText = strTsql;
    //    cmd.Parameters.AddWithValue("@DID", intID);
    //    cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
    //    cmd.Parameters.Add("wowi_tech_id", SqlDbType.Int);
    //    CheckBoxList cbl;
    //    string strProType = IMAUtil.GetProductType(lblProType.Text.Trim());
    //    if (strProType == "RF") { cbl = cbTechRF; }
    //    else if (strProType == "EMC") { cbl = cbTechEMC; }
    //    else if (strProType == "Safety") { cbl = cbTechSafety; }
    //    else { cbl = cbTechTelecom; }
    //    foreach (ListItem li in cbl.Items)
    //    {
    //        if (li.Selected && li.Value != "0")
    //        {
    //            cmd.Parameters["wowi_tech_id"].Value = li.Value;
    //            SQLUtil.ExecuteSql(cmd);
    //        }
    //    }
    //}

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_Periodic set FactoryInspection=@FactoryInspection,Year=@Year,Month=@Month,PeriodicDesc=@PeriodicDesc,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate()";
        strTsql += ",DocumentFee=@DocumentFee,DocumentFeeUnit=@DocumentFeeUnit,OneTimeFee=@OneTimeFee,OneTimeFeeUnit=@OneTimeFeeUnit,PeriodicFee=@PeriodicFee,PeriodicFeeUnit=@PeriodicFeeUnit,OtherFee=@OtherFee,OtherFeeUnit=@OtherFeeUnit ";
        strTsql += "where PeriodicID=@PeriodicID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PeriodicID", Request["pfiid"]);
        cmd.Parameters.AddWithValue("@FactoryInspection", rblFactoryInspection.SelectedValue);
        if (tbYear.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Year", tbYear.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Year", DBNull.Value);
        }
        if (tbMonth.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@Month", tbMonth.Text.Trim());
        }
        else
        {
            cmd.Parameters.AddWithValue("@Month", DBNull.Value);
        }
        cmd.Parameters.AddWithValue("@PeriodicDesc", tbPeriodicDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        if (tbDocumentFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@DocumentFee", tbDocumentFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@DocumentFee", DBNull.Value); }
        //cmd.Parameters.AddWithValue("@DocumentFeeUnit", ddlDocumentFeeUnit.SelectedValue);
        cmd.Parameters.AddWithValue("@DocumentFeeUnit", "USD");
        if (tbOneTimeFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@OneTimeFee", tbOneTimeFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@OneTimeFee", DBNull.Value); }
        //cmd.Parameters.AddWithValue("@OneTimeFeeUnit", ddlOneTimeFeeUnit.SelectedValue);
        cmd.Parameters.AddWithValue("@OneTimeFeeUnit", "USD");
        if (tbPeriodicFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@PeriodicFee", tbPeriodicFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@PeriodicFee", DBNull.Value); }
        //cmd.Parameters.AddWithValue("@PeriodicFeeUnit", ddlPeriodicFeeUnit.SelectedValue);
        cmd.Parameters.AddWithValue("@PeriodicFeeUnit", "USD");
        if (tbOtherFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@OtherFee", tbOtherFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@OtherFee", DBNull.Value); }
        //cmd.Parameters.AddWithValue("@OtherFeeUnit", ddlOtherFeeUnit.SelectedValue);
        cmd.Parameters.AddWithValue("@OtherFeeUnit", "USD");
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["pfiid"]));
        //修改Technology
        //AddUpdTechnology(Convert.ToInt32(Request["pfiid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "pfiid", "copy" }));
    }

    /// <summary>
    /// 下一頁的 Get 參數設定
    /// </summary>
    /// <param name="isClear">是否清除URL的參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    private string GetQueryString(bool isClear, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        //預設參數
        Dictionary<string, string> dic = new Dictionary<string, string>();
        return IMAUtil.SetQueryString(isClear, dic, dicAdd, strRemove);
    }
}