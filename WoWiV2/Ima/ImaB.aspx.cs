﻿using System;
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
                lblAbbreviatedAuthorityName.Text = dt.Rows[0]["AbbreviatedAuthorityName"].ToString();
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblMandatory.Text = dt.Rows[0]["Mandatory"].ToString();
                rblCertificateValid.SelectedValue = dt.Rows[0]["CertificateValid"].ToString();
                rblTransfer.SelectedValue = dt.Rows[0]["IsTransfer"].ToString();
                lblDescription.Text = dt.Rows[0]["Description"].ToString();
                rblCertificationBody.SelectedValue = dt.Rows[0]["CertificationBody"].ToString();
                rblAccreditedTest.SelectedValue = dt.Rows[0]["AccreditedTest"].ToString();
                trProductType.Visible = true;
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(dt.Rows[0]["wowi_product_type_id"].ToString());
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
                lblFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
                lblLastName.Text = dtContact.Rows[0]["LastName"].ToString();
                lblTitle.Text = dtContact.Rows[0]["Title"].ToString();
                lblWorkPhone.Text = dtContact.Rows[0]["WorkPhone"].ToString();
                lblExt.Text = dtContact.Rows[0]["Ext"].ToString();
                lblCellPhone.Text = dtContact.Rows[0]["CellPhone"].ToString();
                lblAdress.Text = dtContact.Rows[0]["Adress"].ToString();
                ddlCountry.SelectedValue = dtContact.Rows[0]["CountryID"].ToString();
                lblFee.Text = dtContact.Rows[0]["Fee"].ToString();
                ddlFeeUnit.SelectedValue = dtContact.Rows[0]["FeeUnit"].ToString();
                lblLeadTime.Text = dtContact.Rows[0]["LeadTime"].ToString();
            }
            //Technology
            DataTable dtTechnology = ds.Tables[1];
            if (dtTechnology.Rows.Count > 0)
            {
                CheckBoxList cbl;
                if (lblProTypeName.Text.Trim() == "RF") { cbTechRF.DataBind(); cbl = cbTechRF; trTechRF.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "EMC") { cbTechEMC.DataBind(); cbl = cbTechEMC; trTechEMC.Visible = true; }
                else if (lblProTypeName.Text.Trim() == "Safety") { cbTechSafety.DataBind(); cbl = cbTechSafety; trTechSafety.Visible = true; }
                else { cbTechTelecom.DataBind(); cbl = cbTechTelecom; trTechTelecom.Visible = true; }

                foreach (DataRow dr in dtTechnology.Rows)
                {
                    foreach (ListItem li in cbl.Items)
                    {
                        if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
                    }
                }
            }
        }
    }
}