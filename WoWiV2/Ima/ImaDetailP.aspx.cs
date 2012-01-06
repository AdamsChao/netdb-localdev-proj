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
        lblTitle.Text = "Post certification Detail";
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
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Post certification Copy";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
        }
    }
}