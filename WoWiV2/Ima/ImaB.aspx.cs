using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaB : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SetControlVisible();
            BindItem();
            LoadData();
            SetKW();
        }
    }

    //設定顯示的控制項
    protected void SetControlVisible()
    {
        //設定為業務或其他使用者可以看的Detail項
        if (!IMAUtil.IsEditOn())
        {
            plDetailSales.Visible = true;
        }
        else
        {
            plDetail.Visible = true;
        }
    }

    //載入選項
    protected void BindItem()
    {
        //載入幣別
        //string strFeeUnit = IMAUtil.GetCountryByID(Request["cid"]).Rows[0]["country_currency_type"].ToString();
        //if (strFeeUnit != "") { ddlFeeUnit.Items.Insert(0, new ListItem(strFeeUnit, strFeeUnit)); }        
    }

    //取得General資料
    protected void LoadData()
    {
        string strID = Request["gaid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID";
            cmd.Parameters.AddWithValue("@GovernmentAuthorityID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblFullAuthorityName.Text = dt.Rows[0]["FullAuthorityName"].ToString();
                lblFullAuthorityNameS.Text = lblFullAuthorityName.Text;
                lblAbbreviatedAuthorityName.Text = dt.Rows[0]["AbbreviatedAuthorityName"].ToString();
                lblAbbreviatedAuthorityNameS.Text = lblAbbreviatedAuthorityName.Text;
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblMandatory.Text = lblMandatoryS.Text = dt.Rows[0]["Mandatory"].ToString();
                if (dt.Rows[0]["CertificateValid"].ToString() != "N/A")
                {
                    lblCertificateValid.Text = lblCertificateValidS.Text = dt.Rows[0]["CertificateValid"].ToString() + " Importer";
                }
                else 
                {
                    lblCertificateValid.Text = lblCertificateValidS.Text = dt.Rows[0]["CertificateValid"].ToString();
                }
                if (dt.Rows[0]["CertificateValid"].ToString() != "N/A")
                {
                    lblCertificateValid.Text += " Importer";
                }           
                lblTransfer.Text = dt.Rows[0]["IsTransfer"].ToString();
                lblTransferS.Text = lblTransfer.Text;
                if (dt.Rows[0]["Description"].ToString().Trim().Length > 0) 
                {
                    lblDescription.Text = "<br>Remark：" + dt.Rows[0]["Description"].ToString();
                    lblDescriptionS.Text = lblDescription.Text;
                }
                lblCertificationBody.Text = dt.Rows[0]["CertificationBody"].ToString();
                lblAccreditedTest.Text = dt.Rows[0]["AccreditedTest"].ToString();
                trProductType.Visible = true;
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblCountryS.Text = lblCountry.Text;
                lblProTypeName.Text = IMAUtil.GetProductType(dt.Rows[0]["wowi_product_type_id"].ToString());
                lblProTypeNameS.Text = lblProTypeName.Text;
                if (dt.Rows[0]["RFRemark"].ToString().Trim().Length > 0) { lblRFRemark.Text = "Remark：" + dt.Rows[0]["RFRemark"].ToString(); }
                if (dt.Rows[0]["EMCRemark"].ToString().Trim().Length > 0) { lblEMCRemark.Text = "Remark：" + dt.Rows[0]["EMCRemark"].ToString(); }
                if (dt.Rows[0]["SafetyRemark"].ToString().Trim().Length > 0) { lblSafetyRemark.Text = "Remark：" + dt.Rows[0]["SafetyRemark"].ToString(); }
                if (dt.Rows[0]["TelecomRemark"].ToString().Trim().Length > 0) { lblTelecomRemark.Text = "Remark：" + dt.Rows[0]["TelecomRemark"].ToString(); }
                if (dt.Rows[0]["LeadTime"].ToString().Trim().Length > 0) { lblLeadT.Text = dt.Rows[0]["LeadTime"].ToString() + "&nbsp;Weeks"; }
                lblBodyListWebsite.Text = "Website：" + dt.Rows[0]["BodyListWebsite"].ToString();
                lblLabListWebsite.Text = "Website：" + dt.Rows[0]["LabListWebsite"].ToString();
                lblFeeListWebsite.Text = "Website：" + dt.Rows[0]["FeeListWebsite"].ToString();
            }

            //Ima_Contact
            cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Contact where DID=@DID and Categroy=@Categroy;select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            DataSet ds = SQLUtil.QueryDS(cmd);
            //DataTable dtContact = ds.Tables[0];
            //if (dtContact.Rows.Count > 0)
            //{
            //    lblFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
            //    lblLastName.Text = dtContact.Rows[0]["LastName"].ToString();
            //    lblTitle.Text = dtContact.Rows[0]["Title"].ToString();
            //    lblWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
            //    lblExt.Text = dtContact.Rows[0]["Ext"].ToString();
            //    lblCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
            //    lblAdress.Text = dtContact.Rows[0]["Adress"].ToString();
            //    ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
            //    lblFee.Text = dtContact.Rows[0]["Fee"].ToString();
            //    ddlFeeUnit.SelectedValue = dtContact.Rows[0]["FeeUnit"].ToString();
            //    lblLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            //}
            //Technology
            DataTable dtTechnology = ds.Tables[1];
            if (dtTechnology.Rows.Count > 0)
            {
                //CheckBoxList cbl;
                //if (lblProTypeName.Text.Trim() == "RF") { cbTechRF.DataBind(); cbl = cbTechRF; trTechRF.Visible = true; }
                //else if (lblProTypeName.Text.Trim() == "EMC") { cbTechEMC.DataBind(); cbl = cbTechEMC; trTechEMC.Visible = true; }
                //else if (lblProTypeName.Text.Trim() == "Safety") { cbTechSafety.DataBind(); cbl = cbTechSafety; trTechSafety.Visible = true; }
                //else { cbTechTelecom.DataBind(); cbl = cbTechTelecom; trTechTelecom.Visible = true; }

                //foreach (DataRow dr in dtTechnology.Rows)
                //{
                //    foreach (ListItem li in cbl.Items)
                //    {
                //        if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
                //    }
                //}
                if (lblProTypeName.Text.Trim() == "RF") { trTechRF.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "EMC") { trTechEMC.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "Safety") { trTechSafety.Visible = true; }
                else { trTechTelecom.Visible = true; }
            }
        }
    }


    //替換關鍵字查詢的顏色
    protected void SetKW()
    {
        new IMAUtil().RepKW(this.Form.Controls);
        //if (Request["kw"] != null)
        //{
        //    string strKW = HttpUtility.UrlDecode(Request["kw"]);
        //    string[] arrKW = strKW.Split(' ');
        //    Label lbl;
        //    foreach (Control ctl in this.Form.Controls)
        //    {
        //        if (ctl is Label)
        //        {
        //            lbl = (Label)ctl;
        //            foreach (string str in arrKW)
        //            {
        //                lbl.Text = lbl.Text.Replace(str, @"<span class=""fontR"">" + str + @"</span>");
        //            }
        //            lbl.Text = lbl.Text.Replace(strKW, @"<span class=""fontR"">" + strKW + @"</span>");
        //        }
        //        //Contact
        //        if (ctl is DataList)
        //        {
        //            if (ctl.ClientID == "dlContact")
        //            {
        //                foreach (Control cl in ctl.Controls)
        //                {
        //                    if (cl is DataListItem)
        //                    {
        //                        foreach (Control c in cl.Controls)
        //                        {
        //                            if (c is Label)
        //                            {
        //                                lbl = (Label)c;
        //                                lbl.Text = lbl.Text.Replace(strKW, @"<span class=""fontR"">" + strKW + @"</span>");
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //}
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