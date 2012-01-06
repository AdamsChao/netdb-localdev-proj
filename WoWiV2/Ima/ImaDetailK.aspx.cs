using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetailK : System.Web.UI.Page
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
        lblTitle.Text = "Testing and submission preparation Detail";
        string strID = Request["tid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Testing where TestingID=@TestingID";
            cmd.Parameters.AddWithValue("@TestingID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                rblLanguage.SelectedValue = dt.Rows[0]["Language"].ToString();
                lblLanguageDesc.Text = dt.Rows[0]["LanguageDesc"].ToString();
                cbBW.Checked = Convert.ToBoolean(dt.Rows[0]["BW"]);
                cbColor.Checked = Convert.ToBoolean(dt.Rows[0]["Color"]);
                lblManual.Text = dt.Rows[0]["Manual"].ToString();
                cbFCCTest.Checked = Convert.ToBoolean(dt.Rows[0]["FCCTest"]);
                cbFCCCertificate.Checked = Convert.ToBoolean(dt.Rows[0]["FCCCertificate"]);
                cbCETest.Checked = Convert.ToBoolean(dt.Rows[0]["CETest"]);
                cbNBEO.Checked = Convert.ToBoolean(dt.Rows[0]["NBEO"]);
                cbEUDoC.Checked = Convert.ToBoolean(dt.Rows[0]["EUDoC"]);
                cbConformance.Checked = Convert.ToBoolean(dt.Rows[0]["Conformance"]);
                lblOtherInternationally.Text = dt.Rows[0]["OtherInternationally"].ToString();
                cbSchematics.Checked = Convert.ToBoolean(dt.Rows[0]["Schematics"]);
                cbBlock.Checked = Convert.ToBoolean(dt.Rows[0]["Block"]);
                cbLayout.Checked = Convert.ToBoolean(dt.Rows[0]["Layout"]);
                cbGerber.Checked = Convert.ToBoolean(dt.Rows[0]["Gerber"]);
                cbTheory.Checked = Convert.ToBoolean(dt.Rows[0]["Theory"]);
                lblTechnical.Text = dt.Rows[0]["Technical"].ToString();
                lblAntenna.Text = dt.Rows[0]["Antenna"].ToString();
                lblBOM.Text = dt.Rows[0]["BOM"].ToString();
                cbOfficial.Checked = Convert.ToBoolean(dt.Rows[0]["Official"]);
                cbWoWiRequest.Checked = Convert.ToBoolean(dt.Rows[0]["WoWiRequest"]);
                cbISO.Checked = Convert.ToBoolean(dt.Rows[0]["ISO"]);
                cbPayment.Checked = Convert.ToBoolean(dt.Rows[0]["Payment"]);
                cbAuthor.Checked = Convert.ToBoolean(dt.Rows[0]["Author"]);
                lblOtherDocRequest.Text = dt.Rows[0]["OtherDocRequest"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Testing and submission preparation Detail";
                }
                else
                {
                    trProductType.Visible = true;
                }
            }
        }
    }
}