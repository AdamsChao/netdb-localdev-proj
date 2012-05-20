using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailP : System.Web.UI.Page
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
        lblTitle.Text = "Label and Renewal Detail";
        string strID = Request["pcid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Post where PostID=@PostID";
            cmd.Parameters.AddWithValue("@PostID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblRequirement.SelectedValue = dt.Rows[0]["Requirement"].ToString();
                lblRequirementDesc.Text = dt.Rows[0]["RequirementDesc"].ToString();
                cbPrint.Checked = Convert.ToBoolean(dt.Rows[0]["Print"]);
                cbPurchase.Checked = Convert.ToBoolean(dt.Rows[0]["Purchase"]);
                lblLabelsDesc.Text = dt.Rows[0]["LabelsDesc"].ToString();
                //rbtnYes.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                //rbtnNo.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                //lblYear.Text = dt.Rows[0]["Year"].ToString();
                //lblMonth.Text = dt.Rows[0]["Month"].ToString();
                lblRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                cbManufacturer.Checked = Convert.ToBoolean(dt.Rows[0]["Manufacturer"]);
                cbImportation.Checked = Convert.ToBoolean(dt.Rows[0]["Importation"]);
                rblProduct.SelectedValue = Convert.ToInt32(dt.Rows[0]["Product"]).ToString();
                cbEUT1.Checked = Convert.ToBoolean(dt.Rows[0]["EUT1"]);
                cbEUT2.Checked = Convert.ToBoolean(dt.Rows[0]["EUT2"]);
                cbEUT3.Checked = Convert.ToBoolean(dt.Rows[0]["EUT3"]);
                cbEUT4.Checked = Convert.ToBoolean(dt.Rows[0]["EUT4"]);
                cbEUT5.Checked = Convert.ToBoolean(dt.Rows[0]["EUT5"]);
                cbEUT6.Checked = Convert.ToBoolean(dt.Rows[0]["EUT6"]);
                cbEUT7.Checked = Convert.ToBoolean(dt.Rows[0]["EUT7"]);
                cbEUT8.Checked = Convert.ToBoolean(dt.Rows[0]["EUT8"]);
                rblRenewal.SelectedValue = Convert.ToInt32(dt.Rows[0]["Renewal"]).ToString();
                rblRequired.SelectedValue = Convert.ToInt32(dt.Rows[0]["Required"]).ToString();
                if (dt.Rows[0]["CostTest1"].ToString() != "")
                {
                    lblCost1.Text = dt.Rows[0]["CostTest1"].ToString() + "&nbsp;&nbsp;USD";
                }
                if (lblCost1.Text.Trim() == "")
                {
                    if (dt.Rows[0]["LeadTime1"].ToString() != "") { lblCost1.Text = "Lead-Time：" + dt.Rows[0]["LeadTime1"].ToString() + "&nbsp;&nbsp;weeks"; }
                }
                else { if (dt.Rows[0]["LeadTime1"].ToString() != "") { lblCost1.Text += "；Lead-Time：" + dt.Rows[0]["LeadTime1"].ToString() + "&nbsp;&nbsp;weeks"; } }
                if (dt.Rows[0]["CostTest2"].ToString() != "")
                {
                    lblCost2.Text = dt.Rows[0]["CostTest2"].ToString() + "&nbsp;&nbsp;USD";
                }
                if (lblCost2.Text.Trim() == "")
                {
                    if (dt.Rows[0]["LeadTime2"].ToString() != "") { lblCost2.Text = "Lead-Time：" + dt.Rows[0]["LeadTime2"].ToString() + "&nbsp;&nbsp;weeks"; }
                }
                else { if (dt.Rows[0]["LeadTime2"].ToString() != "") { lblCost2.Text += "；Lead-Time：" + dt.Rows[0]["LeadTime2"].ToString() + "&nbsp;&nbsp;weeks"; } }
                if (dt.Rows[0]["Year"].ToString() != "")
                {
                    lblYearMonth.Text = "；" + dt.Rows[0]["Year"].ToString() + "&nbsp;&nbsp;year(s)";
                }
                if (lblYearMonth.Text.Trim() == "")
                {
                    if (dt.Rows[0]["Month"].ToString() != "") { lblYearMonth.Text = "；" + dt.Rows[0]["Month"].ToString() + "&nbsp;&nbsp;month(s)"; }
                }
                else { if (dt.Rows[0]["Month"].ToString() != "") { lblYearMonth.Text += "，" + dt.Rows[0]["Month"].ToString() + "&nbsp;&nbsp;month(s)"; } }                
                lblRemark.Text = dt.Rows[0]["Remark"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                trProductType.Visible = true;
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