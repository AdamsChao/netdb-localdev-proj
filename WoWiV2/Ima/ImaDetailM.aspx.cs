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
            SetKW();
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
                //cbFedex.Checked = Convert.ToBoolean(dt.Rows[0]["Fedex"]);
                //cbDHL.Checked = Convert.ToBoolean(dt.Rows[0]["DHL"]);
                //cbUPS.Checked = Convert.ToBoolean(dt.Rows[0]["UPS"]);
                if (Convert.ToBoolean(dt.Rows[0]["Fedex"])) { lblCarrier.Text = "Fedex"; }
                if (Convert.ToBoolean(dt.Rows[0]["DHL"])) 
                {
                    if (lblCarrier.Text.Trim().Length == 0) { lblCarrier.Text = "DHL"; }
                    else { lblCarrier.Text += "、DHL"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["UPS"]))
                {
                    if (lblCarrier.Text.Trim().Length == 0) { lblCarrier.Text = "UPS"; }
                    else { lblCarrier.Text += "、UPS"; }
                }
                if (dt.Rows[0]["OtherCarrier"].ToString().Trim().Length > 0) 
                {
                    if (lblCarrier.Text.Trim().Length == 0) { lblOtherCarrier.Text = "Other(specify)：" + dt.Rows[0]["OtherCarrier"].ToString(); }
                    else { lblOtherCarrier.Text = "<br>Other(specify)：" + dt.Rows[0]["OtherCarrier"].ToString(); }
                }
                if (dt.Rows[0]["CarrierDesc"].ToString().Trim().Length > 0)
                {
                    lblCarrierDesc.Text = "Please specify if there’s any special cases (Ex. No Zip code used, or P.O. Box only for the entire country)<br>" + dt.Rows[0]["CarrierDesc"].ToString();
                }
                //cbInvoice.Checked = Convert.ToBoolean(dt.Rows[0]["Invoice"]);
                //cbPackingList.Checked = Convert.ToBoolean(dt.Rows[0]["PackingList"]);
                //cbContract.Checked = Convert.ToBoolean(dt.Rows[0]["Contract"]);
                if (Convert.ToBoolean(dt.Rows[0]["Invoice"])) { lblSampleDoc.Text = "Invoice"; }
                if (Convert.ToBoolean(dt.Rows[0]["PackingList"])) 
                {
                    if (lblSampleDoc.Text.Trim().Length == 0) { lblSampleDoc.Text = "Packing List"; }
                    else { lblSampleDoc.Text += "、Packing List"; }
                }
                if (Convert.ToBoolean(dt.Rows[0]["Contract"]))
                {
                    if (lblSampleDoc.Text.Trim().Length == 0) { lblSampleDoc.Text = "Contract"; }
                    else { lblSampleDoc.Text += "、Contract"; }
                }
                if (dt.Rows[0]["OtherSampleShipping"].ToString().Trim().Length > 0)
                {
                    if (lblSampleDoc.Text.Trim().Length == 0) { lblOtherSampleShipping.Text = "Other(specify)：" + dt.Rows[0]["OtherSampleShipping"].ToString(); }
                    else { lblOtherSampleShipping.Text = "<br>Other(specify)：" + dt.Rows[0]["OtherSampleShipping"].ToString(); }
                }
                if (dt.Rows[0]["UnderUSD"].ToString().Trim().Length > 0) { lblUnderUSD.Text = "A value of under " + dt.Rows[0]["UnderUSD"].ToString() + " USD is suggested for custom declaration value"; }
                //tbUnderUSD.Text = dt.Rows[0]["UnderUSD"].ToString();
                //cbNoCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["NoCommercial"]);
                //cbActualCommercial.Checked = Convert.ToBoolean(dt.Rows[0]["ActualCommercial"]);
                if (Convert.ToBoolean(dt.Rows[0]["NoCommercial"])) { lblMarksample.Text = "Label shipment as no commercial value"; }
                if (Convert.ToBoolean(dt.Rows[0]["ActualCommercial"]))
                {
                    if (lblMarksample.Text.Trim().Length == 0) { lblMarksample.Text = "Label shipment as actual commercial value"; }
                    else { lblMarksample.Text += "、Label shipment as actual commercial value"; }
                }
                if (dt.Rows[0]["Note"].ToString().Trim().Length > 0) 
                {
                    if (lblMarksample.Text.Trim().Length == 0) { lblNote.Text = "Note：" + dt.Rows[0]["Note"].ToString(); }
                    else { lblNote.Text = "<br>Note：" + dt.Rows[0]["Note"].ToString(); }
                }
                
                cbPreInstalled.Checked = Convert.ToBoolean(dt.Rows[0]["PreInstalled"]);
                cbCD.Checked = Convert.ToBoolean(dt.Rows[0]["CD"]);
                cbEmail.Checked = Convert.ToBoolean(dt.Rows[0]["Email"]);
                cbFTP.Checked = Convert.ToBoolean(dt.Rows[0]["FTP"]);
                lblTestNote.Text = dt.Rows[0]["TestNote"].ToString();
                //rblReturned.SelectedValue = dt.Rows[0]["Returned"].ToString();
                lblReturned.Text = dt.Rows[0]["Returned"].ToString();                
                if (dt.Rows[0]["ReturnedNote"].ToString().Trim().Length > 0) 
                {
                    lblReturnedNote.Text = "<br>Note：" + dt.Rows[0]["ReturnedNote"].ToString();
                }
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

    //替換關鍵字查詢的顏色
    protected void SetKW()
    {
        if (Request["kw"] != null)
        {
            new IMAUtil().RepKW(this.Form.Controls);
        }
    }
}