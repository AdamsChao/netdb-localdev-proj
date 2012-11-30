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

public partial class Ima_ImaProductControl : System.Web.UI.Page
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

    //取得資料
    protected void LoadData()
    {
        lblTitle.Text = "Products Control Edit";
        string strID = Request["pcid"];
        trProductType.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        trCopyTo.Visible = false;
        btnSaveCopy.Visible = false;
        gvImaFiles.Columns[0].Visible = false;
        gvImaFiles.Columns[1].Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_ProductsControl where ProductControlID=@ProductControlID";
            cmd.Parameters.AddWithValue("@ProductControlID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbControlList.Text = dt.Rows[0]["ControlList"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //trProductType.Visible = true;
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Products Control Copy";
                    gvImaFiles.Columns[1].Visible = true;
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvImaFiles.Columns[0].Visible = true;
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
        string strTsql = "insert into Ima_ProductsControl (world_region_id,country_id,wowi_product_type_id,ControlList,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@ControlList,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@ControlList", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
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
            lblProType.Text = str;
            cmd.Parameters["@world_region_id"].Value = Request["rid"];
            cmd.Parameters["@country_id"].Value = Request["cid"];
            cmd.Parameters["@wowi_product_type_id"].Value = str;
            cmd.Parameters["@ControlList"].Value = tbControlList.Text.Trim();
            cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
            cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
            int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
            //文件上傳
            GeneralFileUpload(intGeneralID);
            //上傳已存在的文件
            if (Request["copy"] != null)
            {
                CopyDocData(gvImaFiles, intGeneralID);
            }
            //新增Technology
            //AddUpdTechnology(intGeneralID);
        }
        BackURL();
    }

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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\ProductsControl\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intID, string strID)
    {
        string strTsql = "insert into Ima_ProductsControl_Files (ProductControlID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
        strTsql += "select @ProductControlID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_ProductsControl_Files where ProductControlFileID=@ProductControlFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@ProductControlID", intID);
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@ProductControlFileID", strID);
        SQLUtil.ExecuteSql(cmd);
    }


    //文件上傳
    protected void GeneralFileUpload(int intGeneralID)
    {
        //Attach sample certificate附件
        GeneralFileUpload(intGeneralID, fuGeneral1);
        GeneralFileUpload(intGeneralID, fuGeneral2);
        GeneralFileUpload(intGeneralID, fuGeneral3);
        GeneralFileUpload(intGeneralID, fuGeneral4);
        GeneralFileUpload(intGeneralID, fuGeneral5);
    }

    protected void GeneralFileUpload(int intID, FileUpload fu)
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\ProductsControl\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_ProductsControl_Files (ProductControlID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@ProductControlID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@ProductControlID", intID);
            cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(), ""));
            cmd.Parameters.AddWithValue("@FileName", strFileName);
            cmd.Parameters.AddWithValue("@FileType", strFileType);
            cmd.Parameters.AddWithValue("@FileCategory", "");
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            SQLUtil.ExecuteSql(cmd);
            fu.SaveAs(strFileURL);
        }
    }

    ////新增及修改Technology
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

    //修改
    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_ProductsControl set ControlList=@ControlList,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where ProductControlID=@ProductControlID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@ProductControlID", Request["pcid"]);
        cmd.Parameters.AddWithValue("@ControlList", tbControlList.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
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