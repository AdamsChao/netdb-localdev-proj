using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailH : System.Web.UI.Page
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
        lblTitle.Text = "Standards Detail";
        string strID = Request["sid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;   
        lblFCCTitle.Text = "";
        lblRequiredTitle.Text = "";
        cbFCC.Visible = false;
        cbIEC.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Standard where StandardID=@StandardID";
            cmd.Parameters.AddWithValue("@StandardID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                lblOthers.Text = dt.Rows[0]["Others"].ToString();
                rblRequired.SelectedValue = dt.Rows[0]["Required"].ToString();
                lblStandardDesc.Text = dt.Rows[0]["StandardDesc"].ToString();
                cbFCC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbIEC.Checked = Convert.ToBoolean(dt.Rows[0]["FCC"]);
                cbCE.Checked = Convert.ToBoolean(dt.Rows[0]["CE"]);
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                rblProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);

                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Standards Detail";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
        }
        else
        {
            lblProTypeName.Text = IMAUtil.GetProductType(Request.Params["pt"]);
        }



        if (lblProTypeName.Text.Trim() != "Safety")
        {
            lblFCCTitle.Text = "Harmonized with FCC or CE";
            cbFCC.Visible = true;
            lblRequiredTitle.Text = "Safety Required";
        }
        else
        {
            lblFCCTitle.Text = "Harmonized with IEC or CE";
            cbIEC.Visible = true;
            lblRequiredTitle.Text = "EMC Required";
        }

    }
}