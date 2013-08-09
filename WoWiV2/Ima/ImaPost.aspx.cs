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

public partial class Ima_ImaPost : System.Web.UI.Page
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
        ////Tech_RF
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
        lblTitle.Text = "Label and Renewal Edit";
        string strID = Request["pcid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        gvFile2.Columns[0].Visible = false;
        gvFile2.Columns[1].Visible = false;
        gvFile3.Columns[0].Visible = false;
        gvFile3.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Post where PostID=@PostID";
            cmd.Parameters.AddWithValue("@PostID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblRequirement.SelectedValue = dt.Rows[0]["Requirement"].ToString();
                tbRequirementDesc.Text = dt.Rows[0]["RequirementDesc"].ToString();
                cbPrint.Checked = Convert.ToBoolean(dt.Rows[0]["Print"]);
                cbPurchase.Checked = Convert.ToBoolean(dt.Rows[0]["Purchase"]);
                tbLabelsDesc.Text = dt.Rows[0]["LabelsDesc"].ToString();
                tbYear.Text = dt.Rows[0]["Year"].ToString();
                tbMonth.Text = dt.Rows[0]["Month"].ToString();
                tbRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                cbManufacturer.Checked = Convert.ToBoolean(dt.Rows[0]["Manufacturer"]);
                cbImportation.Checked = Convert.ToBoolean(dt.Rows[0]["Importation"]);
                rblProduct.SelectedValue = dt.Rows[0]["Product"].ToString();
                cbEUT1.Checked = Convert.ToBoolean(dt.Rows[0]["EUT1"]);
                cbEUT2.Checked = Convert.ToBoolean(dt.Rows[0]["EUT2"]);
                cbEUT3.Checked = Convert.ToBoolean(dt.Rows[0]["EUT3"]);
                cbEUT4.Checked = Convert.ToBoolean(dt.Rows[0]["EUT4"]);
                cbEUT5.Checked = Convert.ToBoolean(dt.Rows[0]["EUT5"]);
                cbEUT6.Checked = Convert.ToBoolean(dt.Rows[0]["EUT6"]);
                cbEUT7.Checked = Convert.ToBoolean(dt.Rows[0]["EUT7"]);
                cbEUT8.Checked = Convert.ToBoolean(dt.Rows[0]["EUT8"]);
                rblRenewal.SelectedValue = dt.Rows[0]["Renewal"].ToString();
                rblRequired.SelectedValue = dt.Rows[0]["Required"].ToString();
                tbCostTest1.Text = dt.Rows[0]["CostTest1"].ToString();
                tbLeadTime1.Text = dt.Rows[0]["LeadTime1"].ToString();
                tbCostTest2.Text = dt.Rows[0]["CostTest2"].ToString();
                tbLeadTime2.Text = dt.Rows[0]["LeadTime2"].ToString();
                tbRemark.Text = dt.Rows[0]["Remark"].ToString();
                tbRequiredDoc.Text = dt.Rows[0]["RequiredDoc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Label and Renewal Copy";
                    gvFile1.Columns[1].Visible = true;
                    gvFile2.Columns[1].Visible = true;
                    gvFile3.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                    gvFile2.Columns[0].Visible = true;
                    gvFile3.Columns[0].Visible = true;
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
        string strTsql = "insert into Ima_Post (world_region_id,country_id,wowi_product_type_id,Requirement,RequirementDesc,[Print],Purchase,LabelsDesc,Required,Year,Month,RequiredDesc,CreateUser,LasterUpdateUser,Manufacturer,Importation,Product,EUT1,EUT2,EUT3,EUT4,EUT5,EUT6,EUT7,EUT8,Renewal,CostTest1,LeadTime1,CostTest2,LeadTime2,Remark,RequiredDoc) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Requirement,@RequirementDesc,@Print,@Purchase,@LabelsDesc,@Required,@Year,@Month,@RequiredDesc,@CreateUser,@LasterUpdateUser,@Manufacturer,@Importation,@Product,@EUT1,@EUT2,@EUT3,@EUT4,@EUT5,@EUT6,@EUT7,@EUT8,@Renewal,@CostTest1,@LeadTime1,@CostTest2,@LeadTime2,@Remark,@RequiredDoc)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Requirement", SqlDbType.NVarChar);
        cmd.Parameters.Add("@RequirementDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Print", SqlDbType.Bit);
        cmd.Parameters.Add("@Purchase", SqlDbType.Bit);
        cmd.Parameters.Add("@LabelsDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Required", SqlDbType.Bit);
        cmd.Parameters.Add("@Year", SqlDbType.Int);
        cmd.Parameters.Add("@Month", SqlDbType.Int);
        cmd.Parameters.Add("@RequiredDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Manufacturer", SqlDbType.Bit);
        cmd.Parameters.Add("@Importation", SqlDbType.Bit);
        cmd.Parameters.Add("@Product", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT1", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT2", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT3", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT4", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT5", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT6", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT7", SqlDbType.Bit);
        cmd.Parameters.Add("@EUT8", SqlDbType.Bit);
        cmd.Parameters.Add("@Renewal", SqlDbType.Bit);
        cmd.Parameters.Add("@CostTest1", SqlDbType.Decimal);
        cmd.Parameters.Add("@LeadTime1", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CostTest2", SqlDbType.Decimal);
        cmd.Parameters.Add("@LeadTime2", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Remark", SqlDbType.NVarChar);
        cmd.Parameters.AddWithValue("@RequiredDoc", tbRequiredDoc.Text.Trim());
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
                cmd.Parameters["@Requirement"].Value = rblRequirement.SelectedValue;
                cmd.Parameters["@RequirementDesc"].Value = tbRequirementDesc.Text.Trim();
                cmd.Parameters["@Print"].Value = cbPrint.Checked;
                cmd.Parameters["@Purchase"].Value = cbPurchase.Checked;
                cmd.Parameters["@LabelsDesc"].Value = tbLabelsDesc.Text.Trim();
                cmd.Parameters["@Required"].Value = rblRequired.SelectedValue;
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
                cmd.Parameters["@RequiredDesc"].Value = tbRequiredDesc.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@Manufacturer"].Value = cbManufacturer.Checked;
                cmd.Parameters["@Importation"].Value = cbImportation.Checked;
                cmd.Parameters["@Product"].Value = rblProduct.SelectedValue;
                cmd.Parameters["@EUT1"].Value = cbEUT1.Checked;
                cmd.Parameters["@EUT2"].Value = cbEUT2.Checked;
                cmd.Parameters["@EUT3"].Value = cbEUT3.Checked;
                cmd.Parameters["@EUT4"].Value = cbEUT4.Checked;
                cmd.Parameters["@EUT5"].Value = cbEUT5.Checked;
                cmd.Parameters["@EUT6"].Value = cbEUT6.Checked;
                cmd.Parameters["@EUT7"].Value = cbEUT7.Checked;
                cmd.Parameters["@EUT8"].Value = cbEUT8.Checked;
                cmd.Parameters["@Renewal"].Value = rblRenewal.SelectedValue;
                if (tbCostTest1.Text.Trim().Length > 0) { cmd.Parameters["@CostTest1"].Value = tbCostTest1.Text.Trim(); }
                else { cmd.Parameters["@CostTest1"].Value = DBNull.Value; }
                if (tbLeadTime1.Text.Trim().Length > 0) { cmd.Parameters["@LeadTime1"].Value = tbLeadTime1.Text.Trim(); }
                else { cmd.Parameters["@LeadTime1"].Value = DBNull.Value; }
                if (tbCostTest2.Text.Trim().Length > 0) { cmd.Parameters["@CostTest2"].Value = tbCostTest2.Text.Trim(); }
                else { cmd.Parameters["@CostTest2"].Value = DBNull.Value; }
                if (tbLeadTime2.Text.Trim().Length > 0) { cmd.Parameters["@LeadTime2"].Value = tbLeadTime2.Text.Trim(); }
                else { cmd.Parameters["@LeadTime2"].Value = DBNull.Value; }
                cmd.Parameters["@Remark"].Value = tbRemark.Text.Trim();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    //Attach sample File
                    CopyDocData(gvFile1, intGeneralID);
                    //Transfer File
                    CopyDocData(gvFile2, intGeneralID);
                    CopyDocData(gvFile3, intGeneralID);
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PostCertification\" + IMAUtil.GetProductType(lblProType.Text.Trim());
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
        string strTsql = "insert into Ima_Post_Files (PostID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @PostID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_Post_Files where PostFileID=@PostFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PostID", intGAID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@PostFileID", strGAFID);
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
        //其他附件
        GeneralFileUpload(intGeneralID, FileUpload1, "B");
        GeneralFileUpload(intGeneralID, FileUpload2, "B");
        GeneralFileUpload(intGeneralID, FileUpload3, "B");
        GeneralFileUpload(intGeneralID, FileUpload4, "B");
        GeneralFileUpload(intGeneralID, FileUpload5, "B");

        GeneralFileUpload(intGeneralID, FileUpload6, "C");
        GeneralFileUpload(intGeneralID, FileUpload7, "C");
        GeneralFileUpload(intGeneralID, FileUpload8, "C");
        GeneralFileUpload(intGeneralID, FileUpload9, "C");
        GeneralFileUpload(intGeneralID, FileUpload10, "C");
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\PostCertification\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_Post_Files (PostID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@PostID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@PostID", intID);
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
        string strTsql = "Update Ima_Post set Requirement=@Requirement,RequirementDesc=@RequirementDesc,[Print]=@Print,Purchase=@Purchase,LabelsDesc=@LabelsDesc,Required=@Required,Year=@Year,Month=@Month,RequiredDesc=@RequiredDesc,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate()";
        strTsql += ",Manufacturer=@Manufacturer,Importation=@Importation,Product=@Product,EUT1=@EUT1,EUT2=@EUT2,EUT3=@EUT3,EUT4=@EUT4,EUT5=@EUT5,EUT6=@EUT6,EUT7=@EUT7,EUT8=@EUT8,Renewal=@Renewal,CostTest1=@CostTest1,LeadTime1=@LeadTime1,CostTest2=@CostTest2,LeadTime2=@LeadTime2,Remark=@Remark,RequiredDoc=@RequiredDoc ";
        strTsql += "where PostID=@PostID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@PostID", Request["pcid"]);
        cmd.Parameters.AddWithValue("@Requirement", rblRequirement.SelectedValue);
        cmd.Parameters.AddWithValue("@RequirementDesc", tbRequirementDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@Print", cbPrint.Checked);
        cmd.Parameters.AddWithValue("@Purchase", cbPurchase.Checked);
        cmd.Parameters.AddWithValue("@LabelsDesc", tbLabelsDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@Required", rblRequired.SelectedValue);
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
        cmd.Parameters.AddWithValue("@RequiredDesc", tbRequiredDesc.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Manufacturer", cbManufacturer.Checked);
        cmd.Parameters.AddWithValue("@Importation", cbImportation.Checked);
        cmd.Parameters.AddWithValue("@Product", rblProduct.SelectedValue);
        cmd.Parameters.AddWithValue("@EUT1", cbEUT1.Checked);
        cmd.Parameters.AddWithValue("@EUT2", cbEUT2.Checked);
        cmd.Parameters.AddWithValue("@EUT3", cbEUT3.Checked);
        cmd.Parameters.AddWithValue("@EUT4", cbEUT4.Checked);
        cmd.Parameters.AddWithValue("@EUT5", cbEUT5.Checked);
        cmd.Parameters.AddWithValue("@EUT6", cbEUT6.Checked);
        cmd.Parameters.AddWithValue("@EUT7", cbEUT7.Checked);
        cmd.Parameters.AddWithValue("@EUT8", cbEUT8.Checked);
        cmd.Parameters.AddWithValue("@Renewal", rblRenewal.SelectedValue);
        if (tbCostTest1.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@CostTest1", tbCostTest1.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@CostTest1", DBNull.Value); }
        if (tbLeadTime1.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime1", tbLeadTime1.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime1", DBNull.Value); }
        if (tbCostTest2.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@CostTest2", tbCostTest2.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@CostTest2", DBNull.Value); }
        if (tbLeadTime2.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime2", tbLeadTime2.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime2", DBNull.Value); }
        cmd.Parameters.AddWithValue("@Remark", tbRemark.Text.Trim());
        cmd.Parameters.AddWithValue("@RequiredDoc", tbRequiredDoc.Text.Trim());
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["pcid"]));
        //修改Technology
        //AddUpdTechnology(Convert.ToInt32(Request["pcid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "pcid", "copy" }));
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