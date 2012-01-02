using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailL : System.Web.UI.Page
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
        lblTitle.Text = "Fee schedule Detail";
        string strID = Request["fsid"];
        trProductType.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_FeeSchedule where FeeScheduleID=@FeeScheduleID";
            cmd.Parameters.AddWithValue("@FeeScheduleID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblAgentHandling.Text = dt.Rows[0]["AgentHandling"].ToString();
                lblAuthoritySubmission.Text = dt.Rows[0]["AuthoritySubmission"].ToString();
                lblBodySubmission.Text = dt.Rows[0]["BodySubmission"].ToString();
                lblLabTesting.Text = dt.Rows[0]["LabTesting"].ToString();
                lblDocumentTranslation.Text = dt.Rows[0]["DocumentTranslation"].ToString();
                lblBank.Text = dt.Rows[0]["Bank"].ToString();
                lblCustomClearance.Text = dt.Rows[0]["CustomClearance"].ToString();
                lblSampleReturn.Text = dt.Rows[0]["SampleReturn"].ToString();
                lblLabelPurchase.Text = dt.Rows[0]["LabelPurchase"].ToString();
                lblOther.Text = dt.Rows[0]["Other"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
            }
        }
    }
}