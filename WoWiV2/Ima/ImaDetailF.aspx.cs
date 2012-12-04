using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindItem();
            LoadData();
            //SetControlVisible();
            SetKW();
        }
    }

    //載入選項
    protected void BindItem()
    {
        ////載入幣別
        //string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        //if (strFeeUnit != "") { ddlFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); }
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        //foreach (ListItem li in cbProductType.Items)
        //{
        //    if (li.Selected)
        //    {
        //        if (li.Text == "RF") { trTechRF.Style.Value = "display:'';"; }
        //        if (li.Text == "EMC") { trTechEMC.Style.Value = "display:'';"; }
        //        if (li.Text == "Safety") { trTechSafety.Style.Value = "display:'';"; }
        //        if (li.Text == "Telecom") { trTechTelecom.Style.Value = "display:'';"; }
        //    }
        //}
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Local Agent Detail";
        string strID = Request["laid"];
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
                lblName.Text = dt.Rows[0]["Name"].ToString();
                if (dt.Rows[0]["Professional"].ToString().Trim().ToLower() == "true") { lblAngentType.Text = "Professional"; }
                if (dt.Rows[0]["Individual"].ToString().Trim().ToLower() == "true") 
                {
                    if (lblAngentType.Text.Trim().Length == 0) { lblAngentType.Text = "Individual"; }
                    else { lblAngentType.Text += "、Individual"; }
                }
                if (dt.Rows[0]["OtherBusiness"].ToString().Trim().ToLower() == "true") 
                {
                    if (lblAngentType.Text.Trim().Length == 0) { lblAngentType.Text = "Other Business"; }
                    else { lblAngentType.Text += "、Other Business"; }
                }

                if (dt.Rows[0]["Responsive"].ToString().Trim().ToLower() == "true") { lblCredit.Text = "Responsive"; }
                if (dt.Rows[0]["Knowledgeable"].ToString().Trim().ToLower() == "true")
                {
                    if (lblCredit.Text.Trim().Length == 0) { lblCredit.Text = "Knowledgeable"; }
                    else { lblCredit.Text += "、Knowledgeable"; }
                }
                if (dt.Rows[0]["Slow"].ToString().Trim().ToLower() == "true")
                {
                    if (lblCredit.Text.Trim().Length == 0) { lblCredit.Text = "Slow"; }
                    else { lblCredit.Text += "、Slow"; }
                }

                if (dt.Rows[0]["NDAYes"].ToString().Trim().ToLower() == "true") { lblNDAYes.Text = "Yes"; }
                //if (dt.Rows[0]["NDAChoose"].ToString().Trim().ToLower() == "true") { cbNDAChoose.Checked = true; }
                if (dt.Rows[0]["MOUYes"].ToString().Trim().ToLower() == "true") { lblMOUYes.Text = "Yes"; }
                //if (dt.Rows[0]["MOUChoose"].ToString().Trim().ToLower() == "true") { cbMOUChoose.Checked = true; }
                if (dt.Rows[0]["RFRemark"].ToString().Trim().Length > 0) { lblRFRemark.Text = "Remark：" + dt.Rows[0]["RFRemark"].ToString(); }
                if (dt.Rows[0]["EMCRemark"].ToString().Trim().Length > 0) { lblEMCRemark.Text = "Remark：" + dt.Rows[0]["EMCRemark"].ToString(); }
                if (dt.Rows[0]["SafetyRemark"].ToString().Trim().Length > 0) { lblSafetyRemark.Text = "Remark：" + dt.Rows[0]["SafetyRemark"].ToString(); }
                if (dt.Rows[0]["TelecomRemark"].ToString().Trim().Length > 0) { lblTelecomRemark.Text = "Remark：" + dt.Rows[0]["TelecomRemark"].ToString(); }
                if (dt.Rows[0]["LeadTime"].ToString().Trim().Length > 0) { lblLeadT.Text = dt.Rows[0]["LeadTime"].ToString() + "&nbsp;Weeks"; }
                if (dt.Rows[0]["LocalRep"].ToString().Trim().ToLower() == "true") { lblLocalRep.Text = "Yes"; }
                if (dt.Rows[0]["LocalRepFee"].ToString().Trim().Length > 0) { lblLocalRep.Text += "  ；  Local Rep. Service fee：" + dt.Rows[0]["LocalRepFee"].ToString().Trim() + " USD"; }
                if (dt.Rows[0]["LocalRepRemark"].ToString().Trim().Length > 0) { lblLocalRep.Text += "<br>Remark：" + dt.Rows[0]["LocalRepRemark"].ToString().Trim(); }

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
            }
            ////Ima_Contact
            //cmd = new SqlCommand();
            //cmd.CommandText = "select * from Ima_Contact where DID=@DID and Categroy=@Categroy;select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            //cmd.Parameters.AddWithValue("@DID", strID);
            //cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            //DataSet ds = SQLUtil.QueryDS(cmd);
            //DataTable dtContact = ds.Tables[0];
            //if (dtContact.Rows.Count > 0)
            //{
            //    lblFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
            //    lblLastName.Text = dtContact.Rows[0]["LastName"].ToString();
            //    lblContactTitle.Text = dtContact.Rows[0]["Title"].ToString();
            //    lblWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
            //    lblExt.Text = dtContact.Rows[0]["Ext"].ToString();
            //    lblCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
            //    lblAdress.Text = dtContact.Rows[0]["Adress"].ToString();
            //    ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
            //    lblFee.Text = dtContact.Rows[0]["Fee"].ToString();
            //    ddlFeeUnit.SelectedValue = dtContact.Rows[0]["FeeUnit"].ToString();
            //    lblLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            //}
            ////Technology
            //DataTable dtTechnology = ds.Tables[1];
            //if (dtTechnology.Rows.Count > 0)
            //{
            //    if (lblProTypeName.Text.Trim().Contains(",RF")) { CheckSelect("RF", dtTechnology); trTechRF.Visible = true; }
            //    if (lblProTypeName.Text.Trim().Contains(",EMC")) { CheckSelect("EMC", dtTechnology); trTechEMC.Visible = true; }
            //    if (lblProTypeName.Text.Trim().Contains(",Safety")) { CheckSelect("Safety", dtTechnology); trTechSafety.Visible = true; }
            //    if (lblProTypeName.Text.Trim().Contains(",Telecom")) { CheckSelect("Telecom", dtTechnology); trTechTelecom.Visible = true; }
            //}

            //Technology
            cmd = new SqlCommand();
            cmd.CommandText = "select count(DID) from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            int intCount = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
            if (intCount > 0)
            {
                if (lblProTypeName.Text.Trim().Contains(",RF")) { trTechRF.Visible = true; }
                if (lblProTypeName.Text.Trim().Contains(",EMC")) { trTechEMC.Visible = true; }
                if (lblProTypeName.Text.Trim().Contains(",Safety")) { trTechSafety.Visible = true; }
                if (lblProTypeName.Text.Trim().Contains(",Telecom")) { trTechTelecom.Visible = true; }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }
        }
    }

    //protected void CheckSelect(string strType, DataTable dtTechnology)
    //{
    //    CheckBoxList cbl;
    //    if (strType == "RF") { cbl = cbTechRF; }
    //    else if (strType == "EMC") { cbl = cbTechEMC; }
    //    else if (strType == "Safety") { cbl = cbTechSafety; }
    //    else { cbl = cbTechTelecom; }
    //    cbl.DataBind();
    //    foreach (DataRow dr in dtTechnology.Rows)
    //    {
    //        foreach (ListItem li in cbl.Items)
    //        {
    //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; }
    //        }
    //    }
    //}

    //替換關鍵字查詢的顏色
    protected void SetKW()
    {
        new IMAUtil().RepKW(this.Form.Controls);
    }

    //Contact 替換關鍵字查詢的顏色
    protected void dlContact_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            new IMAUtil().RepKW(e.Item.Controls);
        }
    }
}