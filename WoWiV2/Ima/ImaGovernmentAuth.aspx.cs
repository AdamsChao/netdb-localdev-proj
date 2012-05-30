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

public partial class Ima_ImaGovernmentAuth : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
    int intCopyTimes = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindItem();
            LoadData();
            SetControlVisible();
        }
    }

    //載入選項
    protected void BindItem() 
    {
        if (Request["gaid"] == null || (Request["gaid"] != null && Request["copy"] != null)) 
        {
            DateTime dt = DateTime.Now;
            lblContactIDTemp.Text = dt.Day.ToString() + dt.Minute.ToString() + dt.Second.ToString() + dt.Millisecond.ToString();
        }
        
        //載入幣別
        //string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        //if (strFeeUnit != "") { ddlFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); }        
        //Tech_RF
        //cbTechRF.DataBind();
        //foreach (ListItem li in cbTechRF.Items) 
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechRF.Items.Count > 0) { cbTechRF.Items.Insert(0, new ListItem("All", "0")); cbTechRF.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_EMC
        //cbTechEMC.DataBind();
        //foreach (ListItem li in cbTechEMC.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechEMC.Items.Count > 0) { cbTechEMC.Items.Insert(0, new ListItem("All", "0")); cbTechEMC.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_Safety
        //cbTechSafety.DataBind();
        //foreach (ListItem li in cbTechSafety.Items)
        //{
        //    li.Attributes.Add("onclick", "Tech(this);");
        //}
        //if (cbTechSafety.Items.Count > 0) { cbTechSafety.Items.Insert(0, new ListItem("All", "0")); cbTechSafety.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_Telecom
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
        HtmlTableRow trTech;
        foreach (string strCT in lblProTypeName.Text.Trim().Split(','))
        {
            if (strCT.Length > 0)
            {
                if (strCT == "RF") { trTech = trTechRF; }
                else if (strCT == "EMC") { trTech = trTechEMC; }
                else if (strCT == "Safety") { trTech = trTechSafety; }
                else { trTech = trTechTelecom; }
                trTech.Style.Value = "display:'';";
            }
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Government Authority Edit";
        string strID = Request["gaid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        gvImaFiles1.Columns[0].Visible = false;
        gvImaFiles1.Columns[1].Visible = false;
        gvImaFiles.Columns[0].Visible = false;
        gvImaFiles.Columns[1].Visible = false;
        gvContact.Columns[0].Visible = false;
        gvContact.Columns[1].Visible = false;
        ddlCountry.SelectedValue = Request["cid"];
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID";
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbFullAuthorityName.Text = dt.Rows[0]["FullAuthorityName"].ToString();
                tbAbbreviatedAuthorityName.Text = dt.Rows[0]["AbbreviatedAuthorityName"].ToString();
                tbWebsite.Text = dt.Rows[0]["Website"].ToString();
                //tbMandatory.Text = dt.Rows[0]["Mandatory"].ToString();
                rblMandatory.SelectedValue = dt.Rows[0]["Mandatory"].ToString();
                rblCertificateValid.SelectedValue = dt.Rows[0]["CertificateValid"].ToString();
                //rblTransfer.SelectedValue =Convert.ToInt32(dt.Rows[0]["IsTransfer"]).ToString();
                rblTransfer.SelectedValue = dt.Rows[0]["IsTransfer"].ToString();
                tbDescription.Text = dt.Rows[0]["Description"].ToString();
                rblCertificationBody.SelectedValue = dt.Rows[0]["CertificationBody"].ToString();
                rblAccreditedTest.SelectedValue = dt.Rows[0]["AccreditedTest"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();                
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                tbRFRemark.Text = dt.Rows[0]["RFRemark"].ToString();
                tbEMCRemark.Text = dt.Rows[0]["EMCRemark"].ToString();
                tbSafetyRemark.Text = dt.Rows[0]["SafetyRemark"].ToString();
                tbTelecomRemark.Text = dt.Rows[0]["TelecomRemark"].ToString();
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Government Authority Copy";
                    gvImaFiles1.Columns[1].Visible = true;
                    gvImaFiles.Columns[1].Visible = true;
                    gvContact.Columns[1].Visible = true;
                }
                else 
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvImaFiles1.Columns[0].Visible = true;
                    gvImaFiles.Columns[0].Visible = true;
                    gvContact.Columns[0].Visible = true;
                }
            }
            //Ima_Contact            
            //cmd = new SqlCommand();
            //cmd.CommandText = "select * from Ima_Contact where DID=@DID and Categroy=@Categroy;select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            //cmd.Parameters.AddWithValue("@DID", strID);
            //cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            //DataSet ds= SQLUtil.QueryDS(cmd);
            //DataTable dtContact = ds.Tables[0];
            //if (dtContact.Rows.Count > 0) 
            //{
            //    lblContactID.Text = dtContact.Rows[0]["ContactID"].ToString();
            //    tbFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
            //    tbLastName.Text = dtContact.Rows[0]["LastName"].ToString();
            //    tbTitle.Text = dtContact.Rows[0]["Title"].ToString();
            //    tbWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
            //    tbExt.Text = dtContact.Rows[0]["Ext"].ToString();
            //    tbCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
            //    tbAdress.Text = dtContact.Rows[0]["Adress"].ToString();
            //    ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
            //    tbFee.Text = dtContact.Rows[0]["Fee"].ToString();
            //    ddlFeeUnit.SelectedValue = dtContact.Rows[0]["FeeUnit"].ToString();
            //    tbLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            //}


            
            //Ima_Contact
            DataTable dtContact = imau.GetContact(Convert.ToInt32(strID), Request["categroy"].ToString());

            //DataTable dtImaContact = CreateContactDataTable();
            //if (dtContact.Rows.Count > 0) 
            //{
            //    foreach (DataRow dr in dtContact.Rows)
            //    {
            //        DataRow row = dtImaContact.NewRow();
            //        row["ContactID"] = dr["ContactID"].ToString();
            //        row["FirstName"] = dr["FirstName"].ToString();
            //        row["LastName"] = dr["LastName"].ToString();
            //        row["Title"] = dr["Title"].ToString();
            //        row["WorkPhone"] = dr["WorkPhone"].ToString();
            //        row["Ext"] = dr["Ext"].ToString();
            //        row["CellPhone"] = dr["CellPhone"].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        row[""] = dr[""].ToString();
            //        dtImaContact.Rows.Add(row);
            //    }
            //}
            gvContact.DataSource = dtContact;
            gvContact.DataBind();

            ////Technology
            //DataTable dtTechnology = ds.Tables[1];
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
            gvContact.Columns[0].Visible = true;
            btnSave.Visible = true;
            trProductType.Visible = true;

            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }

            //lblProTypeName.Text = IMAUtil.GetProductType(Request["pt"]);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Authority where country_id=@country_id and wowi_product_type_id=@wowi_product_type_id";
            cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
            cmd.Parameters.AddWithValue("@wowi_product_type_id", Request["pt"].Split(',')[0]);
            SqlDataReader sdr = SQLUtil.QueryDR(cmd);
            while (sdr.Read()) 
            {
                tbFullAuthorityName.Text = sdr["authority_fullname"].ToString();
                tbAbbreviatedAuthorityName.Text = sdr["authority_name"].ToString();
            }
            sdr.Close();
        }

        //string strCT = lblProTypeName.Text;
        ////if (strCT == "RF") { trTechRF.Visible = true; }
        ////else if (strCT == "EMC") { trTechEMC.Visible = true; }
        ////else if (strCT == "Safety") { trTechSafety.Visible = true; }
        ////else if (strCT == "Telecom") { trTechTelecom.Visible = true; }
        
        //if (strCT == "RF") { trTechRF.Style.Value = "display:'';"; }
        //else if (strCT == "EMC") { trTechEMC.Style.Value = "display:'';"; }
        //else if (strCT == "Safety") { trTechSafety.Style.Value = "display:'';"; }
        //else if (strCT == "Telecom") { trTechTelecom.Style.Value = "display:'';"; }
    }

    //protected DataTable CreateContactDataTable()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Columns.Add("ContactID");
    //    dt.Columns.Add("FirstName");
    //    dt.Columns.Add("LastName");
    //    dt.Columns.Add("Title");
    //    dt.Columns.Add("WorkPhone");
    //    dt.Columns.Add("Ext");
    //    dt.Columns.Add("CellPhone");
    //    dt.Columns.Add("Adress");
    //    dt.Columns.Add("CountryID");
    //    dt.Columns.Add("DID");
    //    dt.Columns.Add("Categroy");
    //    dt.Columns.Add("LeadTime");
    //    dt.Columns.Add("Fax");
    //    dt.Columns.Add("Remark");
    //    return dt;
    //}

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_GovernmentAuthority (world_region_id,country_id,FullAuthorityName,AbbreviatedAuthorityName,Website,Mandatory,wowi_product_type_id,CertificateValid,IsTransfer,Description,CreateUser,LasterUpdateUser,CertificationBody,AccreditedTest,RFRemark,EMCRemark,SafetyRemark,TelecomRemark) ";
        strTsql += "values(@world_region_id,@country_id,@FullAuthorityName,@AbbreviatedAuthorityName,@Website,@Mandatory,@wowi_product_type_id,@CertificateValid,@IsTransfer,@Description,@CreateUser,@LasterUpdateUser,@CertificationBody,@AccreditedTest,@RFRemark,@EMCRemark,@SafetyRemark,@TelecomRemark)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("world_region_id",SqlDbType.Int);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@FullAuthorityName", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AbbreviatedAuthorityName", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Website", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Mandatory", SqlDbType.NVarChar);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@CertificateValid", SqlDbType.NVarChar);
        //cmd.Parameters.Add("@IsTransfer", SqlDbType.Bit);
        cmd.Parameters.Add("@IsTransfer", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Description", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CertificationBody", SqlDbType.NVarChar);
        cmd.Parameters.Add("@AccreditedTest", SqlDbType.NVarChar);
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }        
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
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
                cmd.Parameters["world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@FullAuthorityName"].Value = tbFullAuthorityName.Text.Trim();
                cmd.Parameters["@AbbreviatedAuthorityName"].Value = tbAbbreviatedAuthorityName.Text.Trim();
                cmd.Parameters["@Website"].Value = tbWebsite.Text.Trim();
                //cmd.Parameters["@Mandatory"].Value = tbMandatory.Text.Trim();
                cmd.Parameters["@Mandatory"].Value = rblMandatory.SelectedValue;
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@CertificateValid"].Value = rblCertificateValid.SelectedValue;
                //cmd.Parameters["@IsTransfer"].Value = rblTransfer.SelectedValue == "1";
                cmd.Parameters["@IsTransfer"].Value = rblTransfer.SelectedValue;
                cmd.Parameters["@Description"].Value = tbDescription.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@CertificationBody"].Value = rblCertificationBody.SelectedValue;
                cmd.Parameters["@AccreditedTest"].Value = rblAccreditedTest.SelectedValue;
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //文件上傳
                GeneralFileUpload(intGeneralID);
                //上傳已存在的文件
                if (Request["copy"] != null)
                {
                    //Attach sample File
                    CopyDocData(gvImaFiles1, intGeneralID);
                    //Transfer File
                    CopyDocData(gvImaFiles, intGeneralID);
                }
                //Ima_Contact
                //AddContact(intGeneralID);

                //Ima_Contact
                CopyContact(gvContact, intGeneralID);
                intCopyTimes += 1;
                UpdateContact(intGeneralID);
                //新增Technology
                AddUpdTechnology(intGeneralID);
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
                    string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\GovernmentAuthority\" + IMAUtil.GetProductType(lblProType.Text.Trim());
                    //檢查上傳檔案路徑是否存在，若不存在就自動建立
                    IMAUtil.CheckURL(strUploadPath);
                    System.IO.File.Copy(strFileURLO, strFileURLN, true);
                }                
            }
        }
    }

    //複制文件基本資料
    protected void CopyDoc(int intGAID,string strGAFID) 
    {
        string strTsql = "insert into Ima_GoverAuth_Files (GovernmentAuthorityID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser)";
        strTsql += "select @GovernmentAuthorityID,replace(FileURL,@s1,@s2),FileName,FileType,FileCategory,@CreateUser,@LasterUpdateUser from Ima_GoverAuth_Files where GoverAuthFileID=@GoverAuthFileID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", intGAID);//lblProTypeName
        cmd.Parameters.AddWithValue("@s1", @"\" + lblProTypeName.Text.Trim() + @"\");
        cmd.Parameters.AddWithValue("@s2", @"\" + IMAUtil.GetProductType(lblProType.Text.Trim()) + @"\");
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@GoverAuthFileID", strGAFID);
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
            string strUploadPath = IMAUtil.GetIMAUploadPath() + @"\" + IMAUtil.GetCountryName(Request["cid"]) + @"\GovernmentAuthority\" + IMAUtil.GetProductType(lblProType.Text.Trim());
            //檢查上傳檔案路徑是否存在，若不存在就自動建立
            IMAUtil.CheckURL(strUploadPath);
            strFileURL = strUploadPath + @"\" + strFileName;
            //取得副檔名
            strFileType = strFileName.Substring(strFileName.LastIndexOf(Convert.ToChar(".")) + 1).Trim().ToLower();
            strFileName = strFileName.Replace("." + strFileType, "");

            string strTsql = "insert into Ima_GoverAuth_Files (GovernmentAuthorityID,FileURL,FileName,FileType,FileCategory,CreateUser,LasterUpdateUser) ";
            strTsql += "values(@GovernmentAuthorityID,@FileURL,@FileName,@FileType,@FileCategory,@CreateUser,@LasterUpdateUser)";
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = strTsql;
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", intID);
            cmd.Parameters.AddWithValue("@FileURL", strFileURL.Replace(IMAUtil.GetIMAUploadPath(),""));
            cmd.Parameters.AddWithValue("@FileName", strFileName);
            cmd.Parameters.AddWithValue("@FileType", strFileType);
            cmd.Parameters.AddWithValue("@FileCategory", strFileCatetory);
            cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
            cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
            SQLUtil.ExecuteSql(cmd);
            fu.SaveAs(strFileURL);
        }
    }

    protected void UpdateContact(int intDID)
    {
        SqlCommand cmd = new SqlCommand("update Ima_Contact set DID=@DID,IsTemp=0 where DID=@OldDID and Categroy=@Categroy and IsTemp=1 ");
        cmd.Parameters.AddWithValue("@DID", intDID);
        cmd.Parameters.AddWithValue("@OldDID", lblContactIDTemp.Text.Trim());
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        if (lblContactIDTemp.Text.Trim().Length > 0) 
        {
            SQLUtil.ExecuteSql(cmd);
        }
    }

    //新增Contact
    protected void AddContact(int intGAID)
    {
        string strTsql = "insert into Ima_Contact (FirstName,LastName,Title,WorkPhone,Ext,CellPhone,Adress,CountryID,DID,Categroy,LeadTime,CreateUser,LasterUpdateUser,Fax,Remark,IsTemp,Email)";
        strTsql += "values(@FirstName,@LastName,@Title,@WorkPhone,@Ext,@CellPhone,@Adress,@CountryID,@DID,@Categroy,@LeadTime,@CreateUser,@LasterUpdateUser,@Fax,@Remark,@IsTemp,@Email)";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
        cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
        cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
        cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
        cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
        cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
        cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
        cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
        cmd.Parameters.AddWithValue("@DID", intGAID);
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        //if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
        //else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }        
        //cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
        if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Fax", tbFax.Text.Trim());
        cmd.Parameters.AddWithValue("@Remark", tbRemark.Text.Trim());
        cmd.Parameters.AddWithValue("@Email", tbEmail.Text.Trim());
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            cmd.Parameters.AddWithValue("@IsTemp", 0);
        }
        else 
        {
            cmd.Parameters.AddWithValue("@IsTemp", 1);
        }
        SQLUtil.ExecuteSql(cmd);
    }

    //複製Contact
    protected void CopyContact(GridView gv, int intDID)
    {
        foreach (GridViewRow gvr in gvContact.Rows)
        {
            CheckBox chContactCopy = (CheckBox)gvr.FindControl("chContactCopy");
            bool blIsTemp = Convert.ToBoolean(gvContact.DataKeys[gvr.RowIndex].Values["IsTemp"]);
            //intCopyTimes
            if (intCopyTimes >= 1) { blIsTemp = false; }
            if (Request["copy"] == null) { chContactCopy.Checked = true; }
            if (chContactCopy.Checked && !blIsTemp)
            {
                string strTsql = "insert into Ima_Contact (FirstName,LastName,Title,WorkPhone,Ext,CellPhone,Adress,CountryID,DID,Categroy,LeadTime,CreateUser,LasterUpdateUser,Fax,Remark,IsTemp,Email)";
                strTsql += "values(@FirstName,@LastName,@Title,@WorkPhone,@Ext,@CellPhone,@Adress,@CountryID,@DID,@Categroy,@LeadTime,@CreateUser,@LasterUpdateUser,@Fax,@Remark,@IsTemp,@Email)";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = strTsql;
                cmd.Parameters.AddWithValue("@FirstName", ((Label)gvr.FindControl("lblFirstName")).Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", ((Label)gvr.FindControl("lblLastName")).Text.Trim());
                cmd.Parameters.AddWithValue("@Title", ((Label)gvr.FindControl("lblTitle")).Text.Trim());
                cmd.Parameters.AddWithValue("@WorkPhone", ((Label)gvr.FindControl("lblWorkPhone")).Text.Trim());
                cmd.Parameters.AddWithValue("@Ext", ((Label)gvr.FindControl("lblExt")).Text.Trim());
                cmd.Parameters.AddWithValue("@CellPhone", ((Label)gvr.FindControl("lblCellPhone")).Text.Trim());
                cmd.Parameters.AddWithValue("@Adress", ((Label)gvr.FindControl("lblAdress")).Text.Trim());
                cmd.Parameters.AddWithValue("@CountryID", ((Label)gvr.FindControl("lblCountryID")).Text.Trim());
                cmd.Parameters.AddWithValue("@DID", intDID);
                cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
                Label lblLeadTime = (Label)gvr.FindControl("lblLeadTime");
                if (lblLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", lblLeadTime.Text.Trim()); }
                else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
                cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
                cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
                cmd.Parameters.AddWithValue("@Fax", ((Label)gvr.FindControl("lblFax")).Text.Trim());
                cmd.Parameters.AddWithValue("@Remark", ((Label)gvr.FindControl("lblRemark")).Text.Trim());
                cmd.Parameters.AddWithValue("@Email", ((Label)gvr.FindControl("lblEmail")).Text.Trim());
                cmd.Parameters.AddWithValue("@IsTemp", 0);
                SQLUtil.ExecuteSql(cmd);
            }
        }
    }

    //新增及修改Technology
    protected void AddUpdTechnology(int intGAID) 
    {
        //IMAUtil imau = new IMAUtil();
        //刪除Technology
        imau.DelTechnology(intGAID, Request["categroy"]);
        DataList dl;
        string strProType = IMAUtil.GetProductType(lblProType.Text.Trim());
        if (strProType == "RF") { dl = dlTechRF; }
        else if (strProType == "EMC") { dl = dlTechEMC; }
        else if (strProType == "Safety") { dl = dlTechSafety; }
        else { dl = dlTechTelecom; }

        foreach (DataListItem dli in dl.Items) 
        {
            int intTechID = Convert.ToInt32(dl.DataKeys[dli.ItemIndex]);
            CheckBox cbFee = (CheckBox)dli.FindControl("cb" + strProType + "Fee");
            TextBox tbFee = (TextBox)dli.FindControl("tb" + strProType + "Fee");
            if (cbFee.Checked)
            {
                //新增Technology
                imau.AddTechnology(intGAID, Request["categroy"], intTechID, tbFee.Text.Trim());
            }
        }

        //for (int i = 0; i <= dl.Items.Count - 1; i++) 
        //{
        //    int intwowi_tech_id = Convert.ToInt32(dl.DataKeys[i]);
        //    CheckBox cb = (CheckBox) dl.Items[i].FindControl("cbRFFee");
        //    TextBox tbRFFee = (TextBox)dl.Items[i].FindControl("tbRFFee");
        //    if (cb.Checked) 
        //    {
        //        cmd.Parameters["@wowi_tech_id"].Value = intwowi_tech_id;
        //        cmd.Parameters["@Fee"].Value = DBNull.Value;
        //        if (tbRFFee.Text.Trim().Length > 0) 
        //        {
        //            cmd.Parameters["@Fee"].Value = tbRFFee.Text.Trim();
        //        }                
        //        SQLUtil.ExecuteSql(cmd);
        //    }
        //}
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_GovernmentAuthority set FullAuthorityName=@FullAuthorityName,AbbreviatedAuthorityName=@AbbreviatedAuthorityName,Website=@Website,Mandatory=@Mandatory,CertificateValid=@CertificateValid,IsTransfer=@IsTransfer,Description=@Description,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),CertificationBody=@CertificationBody,AccreditedTest=@AccreditedTest,RFRemark=@RFRemark,EMCRemark=@EMCRemark,SafetyRemark=@SafetyRemark,TelecomRemark=@TelecomRemark ";
        strTsql += "where GovernmentAuthorityID=@GovernmentAuthorityID ";
        //if (lblContactID.Text.Trim().Length > 0) 
        //{
        //    strTsql += "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
        //}
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@GovernmentAuthorityID", Request["gaid"]);
        cmd.Parameters.AddWithValue("@FullAuthorityName", tbFullAuthorityName.Text.Trim());
        cmd.Parameters.AddWithValue("@AbbreviatedAuthorityName", tbAbbreviatedAuthorityName.Text.Trim());
        cmd.Parameters.AddWithValue("@Website", tbWebsite.Text.Trim());
        cmd.Parameters.AddWithValue("@Mandatory", rblMandatory.SelectedValue);
        cmd.Parameters.AddWithValue("@CertificateValid", rblCertificateValid.SelectedValue);
        //cmd.Parameters.AddWithValue("@IsTransfer", rblTransfer.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@IsTransfer", rblTransfer.SelectedValue);
        cmd.Parameters.AddWithValue("@Description", tbDescription.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@CertificationBody", rblCertificationBody.SelectedValue);
        cmd.Parameters.AddWithValue("@AccreditedTest", rblAccreditedTest.SelectedValue);
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        //if (lblContactID.Text.Trim().Length > 0)
        //{
        //    cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
        //    cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
        //    cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
        //    cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
        //    cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
        //    cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
        //    cmd.Parameters.AddWithValue("@DID", Request["gaid"]);
        //    cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        //    if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
        //    else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }
        //    cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
        //    if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        //    else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        //    cmd.Parameters.AddWithValue("@ContactID", lblContactID.Text.Trim());
        //}        
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["gaid"]));
        ////新增Contact
        //if (lblContactID.Text.Trim().Length == 0) 
        //{
        //    AddContact(Convert.ToInt32(Request["gaid"]));
        //}
        //修改Technology
        AddUpdTechnology(Convert.ToInt32(Request["gaid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "gaid", "copy" }));
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


    protected void btnCSave_Click(object sender, EventArgs e)
    {
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            AddContact(Convert.ToInt32(Request["gaid"]));
        }
        else 
        {
            AddContact(Convert.ToInt32(lblContactIDTemp.Text.Trim()));
        }        
        tbFirstName.Text = "";
        tbLastName.Text = "";
        tbTitle.Text = "";
        tbWorkPhone.Text = "";
        tbExt.Text = "";
        tbCellPhone.Text = "";
        tbAdress.Text = "";
        ddlCountry.SelectedValue = Request["cid"];
        tbLeadTime.Text = "";
        tbFax.Text = "";
        tbRemark.Text = "";
        tbEmail.Text = "";
        GetContact();
    }

    protected void btnEditSave_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow gvr = gvContact.Rows[Convert.ToInt32(btn.CommandArgument)];
        string strTsql = "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Fax=@Fax,Remark=@Remark,Email=@Email where ContactID=@ContactID ";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.Parameters.AddWithValue("@FirstName", ((TextBox)gvr.FindControl("tbFirstName")).Text.Trim());
        cmd.Parameters.AddWithValue("@LastName", ((TextBox)gvr.FindControl("tbLastName")).Text.Trim());
        cmd.Parameters.AddWithValue("@Title", ((TextBox)gvr.FindControl("tbTitle")).Text.Trim());
        cmd.Parameters.AddWithValue("@WorkPhone", ((TextBox)gvr.FindControl("tbWorkPhone")).Text.Trim());
        cmd.Parameters.AddWithValue("@Ext", ((TextBox)gvr.FindControl("tbExt")).Text.Trim());
        cmd.Parameters.AddWithValue("@CellPhone", ((TextBox)gvr.FindControl("tbCellPhone")).Text.Trim());
        cmd.Parameters.AddWithValue("@Adress", ((TextBox)gvr.FindControl("tbAdress")).Text.Trim());
        cmd.Parameters.AddWithValue("@CountryID", ((DropDownList)gvr.FindControl("ddlCountry")).SelectedValue);        
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            cmd.Parameters.AddWithValue("@DID", Request["gaid"]);
        }
        else 
        {
            cmd.Parameters.AddWithValue("@DID", lblContactIDTemp.Text.Trim());
        }        
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        TextBox tbLeadTime = (TextBox)gvr.FindControl("tbLeadTime");
        if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Fax", ((TextBox)gvr.FindControl("tbFax")).Text.Trim());
        cmd.Parameters.AddWithValue("@Remark", ((TextBox)gvr.FindControl("tbRemark")).Text.Trim());
        cmd.Parameters.AddWithValue("@Email", ((TextBox)gvr.FindControl("tbEmail")).Text.Trim());
        cmd.Parameters.AddWithValue("@ContactID", gvContact.DataKeys[gvr.RowIndex].Values[0]);
        SQLUtil.ExecuteSql(cmd);
        GetContact();
    }

    protected void gvContact_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "GoDel") 
        {
            //if (Request["gaid"] != null) 
            //{
                
            //}
            SqlCommand cmd = new SqlCommand("delete from Ima_Contact where ContactID=@ContactID");
            cmd.Parameters.AddWithValue("@ContactID", e.CommandArgument.ToString());
            SQLUtil.ExecuteSql(cmd);
            GetContact();
        }
    }

    protected void GetContact() 
    {
        //if (Request["gaid"] == null || (Request["gaid"] != null && Request["copy"] != null))
        //{
        //    DateTime dt = DateTime.Now;
        //    lblContactIDTemp.Text = dt.Day.ToString() + dt.Minute.ToString() + dt.Second.ToString() + dt.Millisecond.ToString();
        //}

        
        int intDID;

        //if (lblContactIDTemp.Text.Trim().Length == 0) { intDID = Convert.ToInt32(Request["gaid"]); }
        //else { intDID = Convert.ToInt32(lblContactIDTemp.Text.Trim()); }

        if (Request["gaid"] != null) { intDID = Convert.ToInt32(Request["gaid"]); }
        else { intDID = Convert.ToInt32(lblContactIDTemp.Text.Trim()); }

        DataTable dtContact = imau.GetContact(intDID, Request["categroy"].ToString());
        if (Request["Copy"] != null) 
        {
            intDID = Convert.ToInt32(lblContactIDTemp.Text.Trim());
            DataTable dtContactTemp = imau.GetContact(intDID, Request["categroy"].ToString());
            if (dtContactTemp.Rows.Count > 0) { dtContact.Merge(dtContactTemp); }
        }        
        gvContact.DataSource = dtContact;
        gvContact.DataBind();
    }


    //public void UpdateContact(int intContactID)
    //{
    //    string strTsql = "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
    //    SqlCommand cmd = new SqlCommand(strTsql);
    //    cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
    //    cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
    //    cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
    //    cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
    //    cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
    //    cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
    //    cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
    //    cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
    //    cmd.Parameters.AddWithValue("@DID", Request["gaid"]);
    //    cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
    //    if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
    //    else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }
    //    cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
    //    if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
    //    else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
    //    cmd.Parameters.AddWithValue("@ContactID", lblContactID.Text.Trim());
    //}

    protected void gvContact_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) 
        {
            DropDownList ddlCountry = (DropDownList)e.Row.FindControl("ddlCountry");
            ddlCountry.DataBind();
            Label lblCountryID = (Label)e.Row.FindControl("lblCountryID");
            ddlCountry.SelectedValue = lblCountryID.Text.Trim();
        }
    }
}