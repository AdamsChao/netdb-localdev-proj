using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class Ima_ImaDetailM : System.Web.UI.Page
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
        lblTitle.Text = "Sample shipping Detail";
        string strID = Request["ssid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_SampleShipping where SampleShippingID=@SampleShippingID";
            cmd.Parameters.AddWithValue("@SampleShippingID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                cbFedex.Checked = Convert.ToBoolean(dt.Rows[0]["Fedex"]);
                cbDHL.Checked = Convert.ToBoolean(dt.Rows[0]["DHL"]);
                cbUPS.Checked = Convert.ToBoolean(dt.Rows[0]["UPS"]);
                lblOtherCarrier.Text = dt.Rows[0]["OtherCarrier"].ToString();
                lblCarrierDesc.Text = dt.Rows[0]["CarrierDesc"].ToString();
                cbInvoice.Checked = Convert.ToBoolean(dt.Rows[0]["Invoice"]);
                cbPackingList.Checked = Convert.ToBoolean(dt.Rows[0]["PackingList"]);
                cbContract.Checked = Convert.ToBoolean(dt.Rows[0]["Contract"]);
                lblOtherSampleShipping.Text = dt.Rows[0]["OtherSampleShipping"].ToString();
                tbUnderUSD.Text = dt.Rows[0]["UnderUSD"].ToString();
                cbNoCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["NoCommercial"]);
                cbActualCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["ActualCommercial"]);
                lblNote.Text = dt.Rows[0]["Note"].ToString();
                cbPreInstalled.Checked = Convert.ToBoolean(dt.Rows[0]["PreInstalled"]);
                cbCD.Checked = Convert.ToBoolean(dt.Rows[0]["CD"]);
                cbEmail.Checked = Convert.ToBoolean(dt.Rows[0]["Email"]);
                cbFTP.Checked = Convert.ToBoolean(dt.Rows[0]["FTP"]);
                lblTestNote.Text = dt.Rows[0]["TestNote"].ToString();
                rblReturned.SelectedValue = dt.Rows[0]["Returned"].ToString();
                lblReturnedNote.Text = dt.Rows[0]["ReturnedNote"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                rblProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    lblTitle.Text = "Sample shipping Copy";
                    gvFile1.Columns[1].Visible = true;
                }
                else
                {
                    trProductType.Visible = true;
                    gvFile1.Columns[0].Visible = true;
                }
            }
        }
        else
        {
            lblProTypeName.Text = IMAUtil.GetProductType(Request.Params["pt"]);
        }
    }
}