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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindItem();
            LoadData();
        }
    }

    //載入選項
    protected void BindItem() 
    {
        //載入幣別
        string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        if (strFeeUnit != "") { ddlFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); }
        //Tech_RF
        cbTechRF.DataBind();
        foreach (ListItem li in cbTechRF.Items) 
        {
            li.Attributes.Add("onclick", "Tech(this);");
        }
        if (cbTechRF.Items.Count > 0) { cbTechRF.Items.Insert(0, new ListItem("All", "0")); cbTechRF.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_EMC
        cbTechEMC.DataBind();
        foreach (ListItem li in cbTechEMC.Items)
        {
            li.Attributes.Add("onclick", "Tech(this);");
        }
        if (cbTechEMC.Items.Count > 0) { cbTechEMC.Items.Insert(0, new ListItem("All", "0")); cbTechEMC.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_Safety
        cbTechSafety.DataBind();
        foreach (ListItem li in cbTechSafety.Items)
        {
            li.Attributes.Add("onclick", "Tech(this);");
        }
        if (cbTechSafety.Items.Count > 0) { cbTechSafety.Items.Insert(0, new ListItem("All", "0")); cbTechSafety.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }
        //Tech_Telecom
        cbTechTelecom.DataBind();
        foreach (ListItem li in cbTechTelecom.Items)
        {
            li.Attributes.Add("onclick", "Tech(this);");
        }
        if (cbTechTelecom.Items.Count > 0) { cbTechTelecom.Items.Insert(0, new ListItem("All", "0")); cbTechTelecom.Items[0].Attributes.Add("onclick", "TechSelect(this);"); }        
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
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Government Authority Copy";
                    gvImaFiles1.Columns[1].Visible = true;
                    gvImaFiles.Columns[1].Visible = true;
                }
                else 
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvImaFiles1.Columns[0].Visible = true;
                    gvImaFiles.Columns[0].Visible = true;
                }
            }
            //Ima_Contact
            cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Contact where DID=@DID and Categroy=@Categroy;select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            DataSet ds= SQLUtil.QueryDS(cmd);
            DataTable dtContact = ds.Tables[0];
            if (dtContact.Rows.Count > 0) 
            {
                lblContactID.Text = dtContact.Rows[0]["ContactID"].ToString();
                tbFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
                tbLastName.Text = dtContact.Rows[0]["LastName"].ToString();
                tbTitle.Text = dtContact.Rows[0]["Title"].ToString();
                tbWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
                tbExt.Text = dtContact.Rows[0]["Ext"].ToString();
                tbCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
                tbAdress.Text = dtContact.Rows[0]["Adress"].ToString();
                ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
                tbFee.Text = dtContact.Rows[0]["Fee"].ToString();
                ddlFeeUnit.SelectedValue = dtContact.Rows[0]["FeeUnit"].ToString();
                tbLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            }
            //Technology
            DataTable dtTechnology = ds.Tables[1];
            if (dtTechnology.Rows.Count > 0) 
            {
                CheckBoxList cbl;
                if (lblProTypeName.Text.Trim() == "RF") { cbl = cbTechRF; }
                else if (lblProTypeName.Text.Trim() == "EMC") { cbl = cbTechEMC; }
                else if (lblProTypeName.Text.Trim() == "Safety") { cbl = cbTechSafety; }
                else { cbl = cbTechTelecom; }

                foreach (DataRow dr in dtTechnology.Rows)
                {
                    foreach (ListItem li in cbl.Items)
                    {
                        if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
                    }
                }
                if (dtTechnology.Rows.Count == cbl.Items.Count - 1) { cbl.Items[0].Selected = true; }
            }
        }
        else
        {
            btnSave.Visible = true;
            trProductType.Visible = true;
            lblProTypeName.Text = IMAUtil.GetProductType(Request["pt"]);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Authority where country_id=@country_id and wowi_product_type_id=@wowi_product_type_id";
            cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
            cmd.Parameters.AddWithValue("@wowi_product_type_id", Request["pt"]);            
            SqlDataReader sdr = SQLUtil.QueryDR(cmd);
            while (sdr.Read()) 
            {
                tbFullAuthorityName.Text = sdr["authority_fullname"].ToString();
                tbAbbreviatedAuthorityName.Text = sdr["authority_name"].ToString();
            }
            sdr.Close();
        }

        string strCT = lblProTypeName.Text;
        //if (strCT == "RF") { trTechRF.Visible = true; }
        //else if (strCT == "EMC") { trTechEMC.Visible = true; }
        //else if (strCT == "Safety") { trTechSafety.Visible = true; }
        //else if (strCT == "Telecom") { trTechTelecom.Visible = true; }
        
        if (strCT == "RF") { trTechRF.Style.Value = "display:'';"; }
        else if (strCT == "EMC") { trTechEMC.Style.Value = "display:'';"; }
        else if (strCT == "Safety") { trTechSafety.Style.Value = "display:'';"; }
        else if (strCT == "Telecom") { trTechTelecom.Style.Value = "display:'';"; }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_GovernmentAuthority (world_region_id,country_id,FullAuthorityName,AbbreviatedAuthorityName,Website,Mandatory,wowi_product_type_id,CertificateValid,IsTransfer,Description,CreateUser,LasterUpdateUser,CertificationBody,AccreditedTest) ";
        strTsql += "values(@world_region_id,@country_id,@FullAuthorityName,@AbbreviatedAuthorityName,@Website,@Mandatory,@wowi_product_type_id,@CertificateValid,@IsTransfer,@Description,@CreateUser,@LasterUpdateUser,@CertificationBody,@AccreditedTest)";
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
                AddContact(intGeneralID);
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

    //新增Contact
    protected void AddContact(int intGAID)
    {
        string strTsql = "insert into Ima_Contact (FirstName,LastName,Title,WorkPhone,Ext,CellPhone,Adress,CountryID,DID,Categroy,Fee,FeeUnit,LeadTime,CreateUser,LasterUpdateUser)";
        strTsql += "values(@FirstName,@LastName,@Title,@WorkPhone,@Ext,@CellPhone,@Adress,@CountryID,@DID,@Categroy,@Fee,@FeeUnit,@LeadTime,@CreateUser,@LasterUpdateUser)";
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
        if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }        
        cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
        if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
    }

    //新增及修改Technology
    protected void AddUpdTechnology(int intGAID) 
    {
        SqlCommand cmd;
        string strTsql = "";
        //刪除Technology
        cmd = new SqlCommand();
        strTsql = "delete from Ima_Technology where DID=@DID and Categroy=@Categroy";
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@DID", intGAID);
        cmd.Parameters.AddWithValue("@Categroy", "B");
        SQLUtil.ExecuteSql(cmd);
        //新增Technology
        strTsql = "if (not exists(select DID from Ima_Technology where DID=@DID and Categroy=@Categroy and wowi_tech_id=@wowi_tech_id)) ";
        strTsql += "insert into Ima_Technology (DID,Categroy,wowi_tech_id) values(@DID,@Categroy,@wowi_tech_id)";         
        cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@DID", intGAID);
        cmd.Parameters.AddWithValue("@Categroy", "B");
        cmd.Parameters.Add("wowi_tech_id", SqlDbType.Int);
        CheckBoxList cbl;
        string strProType = IMAUtil.GetProductType(lblProType.Text.Trim());
        if (strProType == "RF") { cbl = cbTechRF; }
        else if (strProType == "EMC") { cbl = cbTechEMC; }
        else if (strProType == "Safety") { cbl = cbTechSafety; }
        else { cbl = cbTechTelecom; }
        foreach (ListItem li in cbl.Items)
        {
            if (li.Selected && li.Value != "0")
            {
                cmd.Parameters["wowi_tech_id"].Value = li.Value;
                SQLUtil.ExecuteSql(cmd);
            }
        }
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_GovernmentAuthority set FullAuthorityName=@FullAuthorityName,AbbreviatedAuthorityName=@AbbreviatedAuthorityName,Website=@Website,Mandatory=@Mandatory,CertificateValid=@CertificateValid,IsTransfer=@IsTransfer,Description=@Description,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),CertificationBody=@CertificationBody,AccreditedTest=@AccreditedTest ";
        strTsql += "where GovernmentAuthorityID=@GovernmentAuthorityID ";
        if (lblContactID.Text.Trim().Length > 0) 
        {
            strTsql += "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
        }
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
        if (lblContactID.Text.Trim().Length > 0)
        {
            cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text.Trim());
            cmd.Parameters.AddWithValue("@LastName", tbLastName.Text.Trim());
            cmd.Parameters.AddWithValue("@Title", tbTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@WorkPhone", tbWorkPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@Ext", tbExt.Text.Trim());
            cmd.Parameters.AddWithValue("@CellPhone", tbCellPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@Adress", tbAdress.Text.Trim());
            cmd.Parameters.AddWithValue("@CountryID", ddlCountry.SelectedValue);
            cmd.Parameters.AddWithValue("@DID", Request["gaid"]);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
            else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }
            cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
            if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
            else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
            cmd.Parameters.AddWithValue("@ContactID", lblContactID.Text.Trim());
        }        
        SQLUtil.ExecuteSql(cmd);
        //文件上傳
        GeneralFileUpload(Convert.ToInt32(Request["gaid"]));
        //新增Contact
        if (lblContactID.Text.Trim().Length == 0) 
        {
            AddContact(Convert.ToInt32(Request["gaid"]));
        }
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

    protected void cbTechRF_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckBoxList cbTech = (CheckBoxList)sender;
        switch (cbTech.ID)
        {
            case "cbTechRF":
                cbTech_SelectedIndexChanged(lblTechRFAll, cbTechRF);
                break;
            case "cbTechEMC":
                cbTech_SelectedIndexChanged(lblTechEMCAll, cbTechEMC);
                break;
            case "cbTechSafety":
                cbTech_SelectedIndexChanged(lblTechSafetyAll, cbTechSafety);
                break;
            case "cbTechTelecom":
                cbTech_SelectedIndexChanged(lblTechTelecomAll, cbTechTelecom);
                break;
        }
    }
    
    protected void cbTech_SelectedIndexChanged(Label lblTechAll, CheckBoxList cb) 
    {
        if (lblTechAll.Text != "0" && cb.SelectedValue == "0")
        {
            lblTechAll.Text = cb.SelectedValue;
            foreach (ListItem li in cb.Items)
            {
                if (li.Value != "0") { li.Enabled = false; }
                li.Selected = cb.Items[0].Selected;
            }
        }
        else if (lblTechAll.Text == "0")
        {
            lblTechAll.Text = "";
            foreach (ListItem li in cb.Items)
            {
                li.Enabled = true;
                li.Selected = false;
            }
        }
    }

    //protected void cbProductType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    trTechRF.Visible = false;
    //    trTechEMC.Visible = false;
    //    trTechSafety.Visible = false;
    //    trTechTelecom.Visible = false;
    //    foreach (ListItem li in cbProductType.Items)
    //    {
    //        if (li.Selected)
    //        {
    //            if (li.Text == "RF") { trTechRF.Visible = true; }
    //            if (li.Text == "EMC") { trTechEMC.Visible = true; }
    //            if (li.Text == "Safety") { trTechSafety.Visible = true; }
    //            if (li.Text == "Telecom") { trTechTelecom.Visible = true; }
    //        }
    //    }
    //}
}