using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaLocalAgent : System.Web.UI.Page
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
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Selected)
            {
                //lblProTypeName.Text += "," + li.Text;
                if (li.Text == "RF") { trTechRF.Style.Value = "display:'';"; }
                if (li.Text == "EMC") { trTechEMC.Style.Value = "display:'';"; }
                if (li.Text == "Safety") { trTechSafety.Style.Value = "display:'';"; }
                if (li.Text == "Telecom") { trTechTelecom.Style.Value = "display:'';"; }
            }
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Local Agent Edit";
        string strID = Request["laid"];
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        cbProductType.DataBind();
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_LocalAgent where LocalAgentID=@LocalAgentID";
            cmd.Parameters.AddWithValue("@LocalAgentID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbName.Text = dt.Rows[0]["Name"].ToString();
                if (dt.Rows[0]["Professional"].ToString().Trim().ToLower() == "true") { cbProfessional.Checked = true; }
                if (dt.Rows[0]["Individual"].ToString().Trim().ToLower() == "true") { cbIndividual.Checked = true; }
                if (dt.Rows[0]["OtherBusiness"].ToString().Trim().ToLower() == "true") { cbOtherBusiness.Checked = true; }
                if (dt.Rows[0]["Responsive"].ToString().Trim().ToLower() == "true") { cbResponsive.Checked = true; }
                if (dt.Rows[0]["Knowledgeable"].ToString().Trim().ToLower() == "true") { cbKnowledgeable.Checked = true; }
                if (dt.Rows[0]["Slow"].ToString().Trim().ToLower() == "true") { cbSlow.Checked = true; }
                if (dt.Rows[0]["NDAYes"].ToString().Trim().ToLower() == "true") { cbNDAYes.Checked = true; }
                if (dt.Rows[0]["NDAChoose"].ToString().Trim().ToLower() == "true") { cbNDAChoose.Checked = true; }
                if (dt.Rows[0]["MOUYes"].ToString().Trim().ToLower() == "true") { cbMOUYes.Checked = true; }
                if (dt.Rows[0]["MOUChoose"].ToString().Trim().ToLower() == "true") { cbMOUChoose.Checked = true; }
                tbCredit.Text = dt.Rows[0]["Credit"].ToString();
                tbCommunication.Text = dt.Rows[0]["Communication"].ToString();                
                tbVolume.Text = dt.Rows[0]["Volume"].ToString();

                foreach (ListItem li in cbProductType.Items)
                {
                    if (li.Text.Trim() == "RF")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["RF"]);
                    }
                    else if (li.Text.Trim() == "Telecom")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Telecom"]);
                    }
                    else if (li.Text.Trim() == "EMC")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["EMC"]);
                    }
                    else if (li.Text.Trim() == "Safety")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Safety"]);
                    }
                    if (li.Selected) { lblProTypeName.Text += "," + li.Text; }
                }

                if (Request.Params["copy"] != null)
                {
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Local Agent Copy";
                }
                else
                {
                    btnUpd.Visible = true;
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
                if (lblProTypeName.Text.Trim().Contains(",RF")) { CheckSelect("RF", dtTechnology); }
                if (lblProTypeName.Text.Trim().Contains(",EMC")) { CheckSelect("EMC", dtTechnology); }
                if (lblProTypeName.Text.Trim().Contains(",Safety")) { CheckSelect("Safety", dtTechnology); }
                if (lblProTypeName.Text.Trim().Contains(",Telecom")) { CheckSelect("Telecom", dtTechnology); }
            }
        }
        else
        {
            btnSave.Visible = true;
            foreach (string str in HttpUtility.UrlDecode(Request["pt"]).Split(','))
            {
                if (str != "")
                {
                    foreach (ListItem li in cbProductType.Items)
                    {
                        if (li.Value == str)
                        {
                            li.Selected = true;
                            break;
                        }
                    }
                }
            }
        }
    }

    protected void CheckSelect(string strType, DataTable dtTechnology) 
    {
        CheckBoxList cbl;
        if (strType == "RF") { cbl = cbTechRF; }
        else if (strType == "EMC") { cbl = cbTechEMC; }
        else if (strType == "Safety") { cbl = cbTechSafety; }
        else { cbl = cbTechTelecom; }
        int i = 0;
        foreach (DataRow dr in dtTechnology.Rows)
        {
            foreach (ListItem li in cbl.Items)
            {
                if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; i += 1; }
            }
        }
        if (i == cbl.Items.Count - 1) { cbl.Items[0].Selected = true; }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strTsql = "insert into Ima_LocalAgent (world_region_id,country_id,Name,RF,Telecom,EMC,Safety,Credit,Communication,Volume,CreateUser,LasterUpdateUser,Professional,Individual,OtherBusiness,Responsive,Knowledgeable,Slow,NDAYes,NDAChoose,MOUYes,MOUChoose) ";
        strTsql += "values(@world_region_id,@country_id,@Name,@RF,@Telecom,@EMC,@Safety,@Credit,@Communication,@Volume,@CreateUser,@LasterUpdateUser,@Professional,@Individual,@OtherBusiness,@Responsive,@Knowledgeable,@Slow,@NDAYes,@NDAChoose,@MOUYes,@MOUChoose)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF") 
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@Credit", tbCredit.Text.Trim());
        cmd.Parameters.AddWithValue("@Communication", tbCommunication.Text.Trim());
        cmd.Parameters.AddWithValue("@Volume", tbVolume.Text.Trim());
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Professional", cbProfessional.Checked);
        cmd.Parameters.AddWithValue("@Individual", cbIndividual.Checked);
        cmd.Parameters.AddWithValue("@OtherBusiness", cbOtherBusiness.Checked);
        cmd.Parameters.AddWithValue("@Responsive", cbResponsive.Checked);
        cmd.Parameters.AddWithValue("@Knowledgeable", cbKnowledgeable.Checked);
        cmd.Parameters.AddWithValue("@Slow", cbSlow.Checked);
        cmd.Parameters.AddWithValue("@NDAYes", cbNDAYes.Checked);
        cmd.Parameters.AddWithValue("@NDAChoose", cbNDAChoose.Checked);
        cmd.Parameters.AddWithValue("@MOUYes", cbMOUYes.Checked);
        cmd.Parameters.AddWithValue("@MOUChoose", cbMOUChoose.Checked);
        //SQLUtil.ExecuteSql(cmd);
        int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
        //Ima_Contact
        AddContact(intGeneralID);
        //新增Technology
        AddUpdTechnology(intGeneralID);
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
        CheckBoxList cbl = null;
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF" && li.Selected) { cbl = cbTechRF; }
            else if (li.Text.Trim() == "Telecom") { cbl = cbTechTelecom; }
            else if (li.Text.Trim() == "EMC") { cbl = cbTechEMC; }
            else if (li.Text.Trim() == "Safety") { cbl = cbTechSafety; }
            if (cbl != null) 
            {
                foreach (ListItem liS in cbl.Items)
                {
                    if (liS.Selected && liS.Value != "0")
                    {
                        cmd.Parameters["wowi_tech_id"].Value = liS.Value;
                        SQLUtil.ExecuteSql(cmd);
                    }
                }
            }
        }
    }

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_LocalAgent set Name=@Name,RF=@RF,Telecom=@Telecom,EMC=@EMC,Safety=@Safety,Credit=@Credit,Communication=@Communication,Volume=@Volume,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Professional=@Professional,Individual=@Individual,OtherBusiness=@OtherBusiness,Responsive=@Responsive,Knowledgeable=@Knowledgeable,Slow=@Slow,NDAYes=@NDAYes,NDAChoose=@NDAChoose,MOUYes=@MOUYes,MOUChoose=@MOUChoose ";
        strTsql += "where LocalAgentID=@LocalAgentID ";
        if (lblContactID.Text.Trim().Length > 0)
        {
            strTsql += "Update Ima_Contact set FirstName=@FirstName,LastName=@LastName,Title=@Title,WorkPhone=@WorkPhone,Ext=@Ext,CellPhone=@CellPhone,Adress=@Adress,CountryID=@CountryID,DID=@DID,Categroy=@Categroy,Fee=@Fee,FeeUnit=@FeeUnit,LeadTime=@LeadTime,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() where ContactID=@ContactID ";
        }
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@LocalAgentID", Request["laid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF")
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@Credit", tbCredit.Text.Trim());
        cmd.Parameters.AddWithValue("@Communication", tbCommunication.Text.Trim());
        cmd.Parameters.AddWithValue("@Volume", tbVolume.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Professional", cbProfessional.Checked);
        cmd.Parameters.AddWithValue("@Individual", cbIndividual.Checked);
        cmd.Parameters.AddWithValue("@OtherBusiness", cbOtherBusiness.Checked);
        cmd.Parameters.AddWithValue("@Responsive", cbResponsive.Checked);
        cmd.Parameters.AddWithValue("@Knowledgeable", cbKnowledgeable.Checked);
        cmd.Parameters.AddWithValue("@Slow", cbSlow.Checked);
        cmd.Parameters.AddWithValue("@NDAYes", cbNDAYes.Checked);
        cmd.Parameters.AddWithValue("@NDAChoose", cbNDAChoose.Checked);
        cmd.Parameters.AddWithValue("@MOUYes", cbMOUYes.Checked);
        cmd.Parameters.AddWithValue("@MOUChoose", cbMOUChoose.Checked);
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
            cmd.Parameters.AddWithValue("@DID", Request["laid"]);
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
            AddContact(Convert.ToInt32(Request["laid"]));
        }
        //修改Technology
        AddUpdTechnology(Convert.ToInt32(Request["laid"]));
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "laid", "copy" }));
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