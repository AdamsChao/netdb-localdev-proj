using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailD : System.Web.UI.Page
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
        lblTitle.Text = "Certification bodies Detail";
        string strID = Request["cbwid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_CertificationBodies where CertificationBodiesID=@CertificationBodiesID";
            cmd.Parameters.AddWithValue("@CertificationBodiesID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblName.Text = dt.Rows[0]["Name"].ToString();
                rblAuthority.SelectedValue = Convert.ToInt32(dt.Rows[0]["Authority"]).ToString();
                rblAccreditedTest.SelectedValue = dt.Rows[0]["AccreditedTest"].ToString();
                rblCB.SelectedValue = Convert.ToInt32(dt.Rows[0]["CertificationBody"]).ToString();
                lblVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                rblPublish.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish"]).ToString();
                lblAccredidedLab.Text = dt.Rows[0]["AccredidedLab"].ToString();
                lblVolumePerYear1.Text = dt.Rows[0]["VolumePerYear1"].ToString();
                rblPublish1.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish1"]).ToString();
                lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblWebsite1.Text = dt.Rows[0]["Website1"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Certification bodies Copy";
                }
                else
                {
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
                lblFirstName.Text = dtContact.Rows[0]["FirstName"].ToString();
                lblLastName.Text = dtContact.Rows[0]["LastName"].ToString();
                lblContactTitle.Text = dtContact.Rows[0]["Title"].ToString();
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