using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadData();
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Periodic Factory inspection Detail";
        string strID = Request["pfiid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Periodic where PeriodicID=@PeriodicID";
            cmd.Parameters.AddWithValue("@PeriodicID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                //rblFactoryInspection.SelectedValue = dt.Rows[0]["FactoryInspection"].ToString();
                if (dt.Rows[0]["FactoryInspection"].ToString() == "Document") { lblFactoryInspection.Text = "Document review only"; }
                else if (dt.Rows[0]["FactoryInspection"].ToString() == "OneTime") { lblFactoryInspection.Text = "One-time on-site Inspection Required"; }
                else if (dt.Rows[0]["FactoryInspection"].ToString() == "Periodic") { lblFactoryInspection.Text = "Periodic on-site Inspection Required"; }
                else { lblFactoryInspection.Text = "Not Required"; }
                if (dt.Rows[0]["Year"].ToString().Trim().Length > 0) { lblInspection.Text = "Inspection every：" + dt.Rows[0]["Year"].ToString() + " year(s) "; }
                if (dt.Rows[0]["Month"].ToString().Trim().Length > 0) 
                {
                    if (lblInspection.Text.Trim().Length == 0) { lblInspection.Text = "Inspection every：" + dt.Rows[0]["Month"].ToString() + " month(s) "; }
                    else { lblInspection.Text += dt.Rows[0]["Month"].ToString() + " month(s) "; }
                }
                //lblYear.Text = dt.Rows[0]["Year"].ToString();
                //lblMonth.Text = dt.Rows[0]["Month"].ToString();

                if (dt.Rows[0]["PeriodicDesc"].ToString().Trim().Length > 0) { lblPeriodicDesc.Text = "Remark：" + dt.Rows[0]["PeriodicDesc"].ToString(); }

                if (dt.Rows[0]["DocumentFee"].ToString().Trim().Length > 0) { lblDocumentFee.Text = "Document Inspection Fee：" + dt.Rows[0]["DocumentFee"].ToString() + dt.Rows[0]["DocumentFeeUnit"].ToString(); }
                if (dt.Rows[0]["OneTimeFee"].ToString().Trim().Length > 0) { lblOneTimeFee.Text = "One-time on-site Inspection Fee：" + dt.Rows[0]["OneTimeFee"].ToString() + dt.Rows[0]["OneTimeFeeUnit"].ToString(); }
                if (dt.Rows[0]["PeriodicFee"].ToString().Trim().Length > 0) { lblPeriodicFee.Text = "Periodic on-site Inspection Fee：" + dt.Rows[0]["PeriodicFee"].ToString() + dt.Rows[0]["PeriodicFeeUnit"].ToString(); }
                if (dt.Rows[0]["OtherFee"].ToString().Trim().Length > 0) { lblOtherFee.Text = "Other Fee：" + dt.Rows[0]["OtherFee"].ToString() + dt.Rows[0]["OtherFeeUnit"].ToString(); }
                
                //tbOneTimeFee.Text = dt.Rows[0]["OneTimeFee"].ToString();
                //ddlOneTimeFeeUnit.SelectedValue = dt.Rows[0]["OneTimeFee"].ToString();
                //tbPeriodicFee.Text = dt.Rows[0]["PeriodicFee"].ToString();
                //ddlPeriodicFeeUnit.SelectedValue = dt.Rows[0]["PeriodicFee"].ToString();
                //tbOtherFee.Text = dt.Rows[0]["OtherFee"].ToString();
                //ddlOtherFeeUnit.SelectedValue = dt.Rows[0]["OtherFee"].ToString();


                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);

                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                }
                else
                {
                    trProductType.Visible = true;
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
            //    if (lblProTypeName.Text.Trim() == "RF") { cbTechRF.DataBind(); cbl = cbTechRF; trTechRF.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "EMC") { cbTechEMC.DataBind(); cbl = cbTechEMC; trTechEMC.Visible = true; }
            //    else if (lblProTypeName.Text.Trim() == "Safety") { cbTechSafety.DataBind(); cbl = cbTechSafety; trTechSafety.Visible = true; }
            //    else { cbTechTelecom.DataBind(); cbl = cbTechTelecom; trTechTelecom.Visible = true; }

            //    foreach (DataRow dr in dtTechnology.Rows)
            //    {
            //        foreach (ListItem li in cbl.Items)
            //        {
            //            if (li.Value == dr["wowi_tech_id"].ToString()) { li.Selected = true; break; }
            //        }
            //    }
            //}
        }
    }
}