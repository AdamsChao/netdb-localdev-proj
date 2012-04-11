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
        gvFile1.Columns[0].Visible = false;
        gvFile1.Columns[1].Visible = false;
        gvFile2.Columns[0].Visible = false;
        gvFile2.Columns[1].Visible = false;
        gvFile3.Columns[0].Visible = false;
        gvFile3.Columns[1].Visible = false;
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
                rbtnYes.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                rbtnNo.Checked = Convert.ToBoolean(dt.Rows[0]["Required"]);
                lblYear.Text = dt.Rows[0]["Year"].ToString();
                lblMonth.Text = dt.Rows[0]["Month"].ToString();
                lblRequiredDesc.Text = dt.Rows[0]["RequiredDesc"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                trProductType.Visible = true;
            }
            //Technology
            cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Technology where DID=@DID and Categroy=@Categroy";
            cmd.Parameters.AddWithValue("@DID", strID);
            cmd.Parameters.AddWithValue("@Categroy", Request["categroy"]);
            DataSet ds = SQLUtil.QueryDS(cmd);
            DataTable dtTechnology = ds.Tables[0];
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