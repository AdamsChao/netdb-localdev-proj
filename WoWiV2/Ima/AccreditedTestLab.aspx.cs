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
        if (Request["atid"] == null || (Request["atid"] != null && Request["copy"] != null))
        {
            DateTime dt = DateTime.Now;
            lblContactIDTemp.Text = dt.Day.ToString() + dt.Minute.ToString() + dt.Second.ToString() + dt.Millisecond.ToString();
        }
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
        gvContact.Columns[0].Visible = false;
        gvContact.Columns[1].Visible = false;
        ddlCountry.SelectedValue = Request["cid"];
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
                tbRFRemark.Text = dt.Rows[0]["RFRemark"].ToString();
                tbEMCRemark.Text = dt.Rows[0]["EMCRemark"].ToString();
                tbSafetyRemark.Text = dt.Rows[0]["SafetyRemark"].ToString();
                tbTelecomRemark.Text = dt.Rows[0]["TelecomRemark"].ToString();
                tbLeadT.Text = dt.Rows[0]["LeadTime"].ToString();
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    gvContact.Columns[1].Visible = true;
                    lblTitle.Text = "Accredited Test Lab Copy";
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                    gvContact.Columns[0].Visible = true;
                }
            }
            //Ima_Contact
            DataTable dtContact = imau.GetContact(Convert.ToInt32(strID), Request["categroy"].ToString());
            gvContact.DataSource = dtContact;
            gvContact.DataBind();
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
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_AccreditedTestLab (world_region_id,country_id,wowi_product_type_id,AccreditedLab,VolumePerYear,Publish,Website,CreateUser,LasterUpdateUser,RFRemark,EMCRemark,SafetyRemark,TelecomRemark,LeadTime) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@AccreditedLab,@VolumePerYear,@Publish,@Website,@CreateUser,@LasterUpdateUser,@RFRemark,@EMCRemark,@SafetyRemark,@TelecomRemark,@LeadTime)";
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
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        if (tbLeadT.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadT.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
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
                CopyContact(gvContact, intGeneralID);
                intCopyTimes += 1;
                UpdateContact(intGeneralID);
                //新增Technology
                AddUpdTechnology(intGeneralID);
            }
        }
        BackURL();
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
                cmd.Parameters.AddWithValue("@IsTemp", 0);
                cmd.Parameters.AddWithValue("@Email", ((Label)gvr.FindControl("lblEmail")).Text.Trim());
                SQLUtil.ExecuteSql(cmd);
            }
        }
    }

    //新增及修改Technology
    protected void AddUpdTechnology(int intID)
    {
        //刪除Technology
        imau.DelTechnology(intID, Request["categroy"]);
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
                imau.AddTechnology(intID, Request["categroy"], intTechID, tbFee.Text.Trim());
            }
        }
    }

    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_AccreditedTestLab set AccreditedLab=@AccreditedLab,VolumePerYear=@VolumePerYear,Publish=@Publish,Website=@Website,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),RFRemark=@RFRemark,EMCRemark=@EMCRemark,SafetyRemark=@SafetyRemark,TelecomRemark=@TelecomRemark,LeadTime=@LeadTime ";
        strTsql += "where AccreditedTestID=@AccreditedTestID ";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@AccreditedTestID", Request["atid"]);
        cmd.Parameters.AddWithValue("@AccreditedLab", tbAccreditedLab.Text.Trim());
        cmd.Parameters.AddWithValue("@VolumePerYear", tbVolumePerYear.Text.Trim());
        cmd.Parameters.AddWithValue("@Publish", rblPublish.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@Website", tbWebsite.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        if (tbRFRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@RFRemark", tbRFRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@RFRemark", DBNull.Value); }
        if (tbEMCRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@EMCRemark", tbEMCRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@EMCRemark", DBNull.Value); }
        if (tbSafetyRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@SafetyRemark", tbSafetyRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@SafetyRemark", DBNull.Value); }
        if (tbTelecomRemark.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@TelecomRemark", tbTelecomRemark.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@TelecomRemark", DBNull.Value); }
        if (tbLeadT.Text.Trim().Length > 0) { cmd.Parameters.AddWithValue("@LeadTime", tbLeadT.Text.Trim()); }
        else { cmd.Parameters.AddWithValue("@LeadTime", DBNull.Value); }
        SQLUtil.ExecuteSql(cmd);
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

    protected void btnCSave_Click(object sender, EventArgs e)
    {
        if (lblContactIDTemp.Text.Trim().Length == 0)
        {
            AddContact(Convert.ToInt32(Request["atid"]));
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
            cmd.Parameters.AddWithValue("@DID", Request["atid"]);
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
            SqlCommand cmd = new SqlCommand("delete from Ima_Contact where ContactID=@ContactID");
            cmd.Parameters.AddWithValue("@ContactID", e.CommandArgument.ToString());
            SQLUtil.ExecuteSql(cmd);
            GetContact();
        }
    }

    protected void GetContact()
    {
        int intDID;
        if (Request["atid"] != null) { intDID = Convert.ToInt32(Request["atid"]); }
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

    protected void dlTech_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (e.Item.ItemIndex == 0)
            {
                imau.dlTech_ItemDataBound(sender, e);
            }
        }
    }

}