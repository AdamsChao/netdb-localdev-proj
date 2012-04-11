using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_AccreditedTestLab : System.Web.UI.Page
{
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
        lblTitle.Text = "Accredited Test Lab Edit";
        string strID = Request["atid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_AccreditedTestLab where AccreditedTestID=@AccreditedTestID";
            cmd.Parameters.AddWithValue("@AccreditedTestID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbAccreditedLab.Text = dt.Rows[0]["AccreditedLab"].ToString();
                tbVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                rblPublish.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish"]).ToString();
                tbWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Accredited Test Lab Copy";
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                }
            }
            //Ima_Contact
            cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Contact where DID=@DID and Categroy=@Categroy;select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            DataSet ds = SQLUtil.QueryDS(cmd);
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
        string strTsql = "insert into Ima_AccreditedTestLab (world_region_id,country_id,wowi_product_type_id,AccreditedLab,VolumePerYear,Publish,Website,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@AccreditedLab,@VolumePerYear,@Publish,@Website,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.TinyInt);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@AccreditedLab", SqlDbType.NVarChar);
        cmd.Parameters.Add("@VolumePerYear", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Publish", SqlDbType.Bit);
        cmd.Parameters.Add("@Website", SqlDbType.NVarChar);
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
            if (str != "")
            {
                lblProType.Text = str;
                cmd.Parameters["@world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@AccreditedLab"].Value = tbAccreditedLab.Text.Trim();
                cmd.Parameters["@VolumePerYear"].Value = tbVolumePerYear.Text.Trim();
                cmd.Parameters["@Publish"].Value = rblPublish.SelectedValue == "1";
                cmd.Parameters["@Website"].Value = tbWebsite.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
                //Ima_Contact
                AddContact(intGeneralID);
                //新增Technology
                AddUpdTechnology(intGeneralID);
            }
        }
        BackURL();
    }

    //新增Contact
    protected void AddContact(int intID)
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
        cmd.Parameters.AddWithValue("@DID", intID);
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
    protected void AddUpdTechnology(int intID)
    {
        SqlCommand cmd;
        string strTsql = "";
        //刪除Technology
        cmd = new SqlCommand();
        strTsql = "delete from Ima_Technology where DID=@DID and Categroy=@Categroy";
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@DID", intID);
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
        SQLUtil.ExecuteSql(cmd);
        //新增Technology
        strTsql = "if (not exists(select DID from Ima_Technology where DID=@DID and Categroy=@Categroy and wowi_tech_id=@wowi_tech_id)) ";
        strTsql += "insert into Ima_Technology (DID,Categroy,wowi_tech_id) values(@DID,@Categroy,@wowi_tech_id)";
        cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@DID", intID);
        cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
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
        string strTsql = "Update Ima_AccreditedTestLab set AccreditedLab=@AccreditedLab,VolumePerYear=@VolumePerYear,Publish=@Publish,Website=@Website,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where AccreditedTestID=@AccreditedTestID ";
        if (lblContactID.Text.Trim().Length > 0)
        {
            strTsql += "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
        }
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@AccreditedTestID", Request["atid"]);
        cmd.Parameters.AddWithValue("@AccreditedLab", tbAccreditedLab.Text.Trim());
        cmd.Parameters.AddWithValue("@VolumePerYear", tbVolumePerYear.Text.Trim());
        cmd.Parameters.AddWithValue("@Publish", rblPublish.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@Website", tbWebsite.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
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
            cmd.Parameters.AddWithValue("@DID", Request["atid"]);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            if (tbFee.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@Fee", tbFee.Text.Trim()); }
            else { cmd.Parameters.AddWithValue("@Fee", DBNull.Value); }
            cmd.Parameters.AddWithValue("@FeeUnit", ddlFeeUnit.SelectedValue);
            if (tbLeadTime.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadTime.Text.Trim()); }
            else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
            cmd.Parameters.AddWithValue("@ContactID", lblContactID.Text.Trim());
        }
        SQLUtil.ExecuteSql(cmd);
        //新增Contact
        if (lblContactID.Text.Trim().Length == 0)
        {
            AddContact(Convert.ToInt32(Request["atid"]));
        }
        //修改Technology
        AddUpdTechnology(Convert.ToInt32(Request["atid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "atid", "copy" }));
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