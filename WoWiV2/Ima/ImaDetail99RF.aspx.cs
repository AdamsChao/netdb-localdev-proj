using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaDetail99RF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int intGID = Convert.ToInt32(Request["group"]);
            //if (intGID == 13) { intGID = 12; }
            if (intGID >= 13) { intGID -= 1; }
            ddlTech.SelectedIndex = intGID;
            LoadData();
        }
    }

    //取得資料
    protected void LoadData()
    {
        lblProType.Text = Request["pt"];
        foreach (string str in Request["pt"].Split(','))
        {
            if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
        }
        if (lblProTypeName.Text.Trim().Length > 0)
        {
            lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1);
        }
        lblCountry.Text = IMAUtil.GetCountryName(Request.Params["cid"]);
        Panel plTech;
        SqlCommand cmd = new SqlCommand("STP_IMATechAttributeGet");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@wowi_product_type_id", lblProType.Text.Trim());
        cmd.Parameters.Add("@TechName", SqlDbType.NVarChar);
        //WiFi
        plTech = (Panel)Form.FindControl("plWiFi");
        GetTechFrequency(cmd, plTech, "WiFi");
        //Bluetooth
        plTech = (Panel)Form.FindControl("plBluetooth");
        GetTechFrequency(cmd, plTech, "Bluetooth");
        //RFID
        plTech = (Panel)Form.FindControl("plRFID");
        GetTechFrequency(cmd, plTech, "RFID");
        //FM Transmitter
        plTech = (Panel)Form.FindControl("plFMTransmitter");
        GetTechFrequency(cmd, plTech, "FM Transmitter");
        //Below 1G SRD
        plTech = (Panel)Form.FindControl("plBelow1GSRD");
        GetTechFrequency(cmd, plTech, "Below 1GHz SRD");
        //Above 1G SRD
        plTech = (Panel)Form.FindControl("plAbove1GSRD");
        GetTechFrequency(cmd, plTech, "Above 1GHz SRD");
        //Zigbee
        plTech = (Panel)Form.FindControl("plZigbee");
        GetTechFrequency(cmd, plTech, "Zigbee");
        //UWB
        plTech = (Panel)Form.FindControl("plUWB");
        GetTechFrequency(cmd, plTech, "UWB");
        //2G
        plTech = (Panel)Form.FindControl("pl2G");
        GetTechFrequency(cmd, plTech, "2G GSM/GPRS/EDGE/EDGE Evolution");
        //3G
        plTech = (Panel)Form.FindControl("pl3G");
        GetTechFrequency(cmd, plTech, "3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+");
        //4G
        plTech = (Panel)Form.FindControl("pl4G");
        GetTechFrequency(cmd, plTech, "4G LTE");
        //CDMAOne
        plTech = (Panel)Form.FindControl("plCDMA");
        GetTechFrequency(cmd, plTech, "CDMAOne");
        //CDMA2000
        plTech = (Panel)Form.FindControl("plCDMA");
        GetTechFrequency(cmd, plTech, "CDMA2000");
        //Wireless HD 60
        plTech = (Panel)Form.FindControl("plWirelessHD60");
        GetTechFrequency(cmd, plTech, "Wireless HD 60GHz");
    }

    private void GetTechFrequency(SqlCommand cmd, Panel plTech, string strTechName)
    {
        cmd.Parameters["@TechName"].Value = strTechName;
        DataTable dtTech = SQLUtil.QueryDS(cmd).Tables[0];
        int intRowCount = dtTech.Rows.Count;
        if (intRowCount > 0)
        {
            if (plTech.ID.Replace("pl", "") != "CDMA") { strTechName = plTech.ID.Replace("pl", ""); }
            Label lblPL;
            Label lblIDA;
            Label lblODA;
            Label lblHT20;
            Label lblHT40;
            Label lblHT80;
            Label lblHT160;
            Label lblHT;
            Label lblDFS;
            Label lblTPC;
            Label lblDFSDesc;
            Label lblANA;
            for (int i = 1; i <= intRowCount; i++)
            {
                Label lblFrequencyDesc = (Label)plTech.FindControl("lbl" + strTechName + "FDesc" + i.ToString());
                if (lblFrequencyDesc != null) { lblFrequencyDesc.Text = dtTech.Rows[i - 1]["FrequencyDesc"].ToString(); }
                lblPL = (Label)plTech.FindControl("lbl" + strTechName + "PL" + i.ToString());
                if (lblPL != null) { lblPL.Text = dtTech.Rows[i - 1]["PowerLimit"].ToString(); }
                lblIDA = (Label)plTech.FindControl("lbl" + strTechName + "IDA" + i.ToString());
                if (lblIDA != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["IndoorAllowed"])) { lblIDA.Text = "Indoor Allowed"; }
                }
                lblODA = (Label)plTech.FindControl("lbl" + strTechName + "ODA" + i.ToString());
                if (lblODA != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["OutdoorAllowed"])) { lblODA.Text = "Outdoor Allowed"; }
                }
                lblHT20 = (Label)plTech.FindControl("lbl" + strTechName + "HT20" + i.ToString());
                if (lblHT20 != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["HT20"])) { lblHT20.Text = "HT20"; }
                }
                lblHT40 = (Label)plTech.FindControl("lbl" + strTechName + "HT40" + i.ToString());
                if (lblHT40 != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["HT40"])) { lblHT40.Text = "HT40"; }
                }
                lblHT80 = (Label)plTech.FindControl("lbl" + strTechName + "HT80" + i.ToString());
                if (lblHT80 != null)
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["HT80"])) { lblHT80.Text = "HT80"; }
                }
                lblHT160 = (Label)plTech.FindControl("lbl" + strTechName + "HT160" + i.ToString());
                if (lblHT160 != null)
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["HT160"])) { lblHT160.Text = "HT160"; }
                }
                lblHT = (Label)plTech.FindControl("lbl" + strTechName + "HT" + i.ToString());
                if (lblHT != null) 
                {
                    lblHT.Text = dtTech.Rows[i - 1]["HTDesc"].ToString(); 
                }
                lblDFS = (Label)plTech.FindControl("lbl" + strTechName + "DFS" + i.ToString());
                if (lblDFS != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["DFS"])) { lblDFS.Text = "DFS"; }
                }
                lblTPC = (Label)plTech.FindControl("lbl" + strTechName + "TPC" + i.ToString());
                if (lblTPC != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["TPC"])) { lblTPC.Text = "TPC"; }
                }
                lblDFSDesc = (Label)plTech.FindControl("lbl" + strTechName + "DFSDesc" + i.ToString());
                if (lblDFSDesc != null) { lblDFSDesc.Text = dtTech.Rows[i - 1]["DFSDesc"].ToString(); }
                lblANA = (Label)plTech.FindControl("lbl" + strTechName + "ANA" + i.ToString());
                if (lblANA != null) 
                {
                    if (Convert.ToBoolean(dtTech.Rows[i - 1]["IsAllowed"])) { lblANA.Text = "Allowed"; }
                    else { lblANA.Text = "Not Allowed"; }
                }
                if (i == 1)
                {
                    Label lblRemark;
                    if (plTech.ID.Replace("pl", "") != "CDMA") { lblRemark = (Label)plTech.FindControl("lbl" + strTechName + "Remark"); }
                    else { lblRemark = lblCDMRemark; }
                    if (lblRemark != null) { lblRemark.Text = dtTech.Rows[i - 1]["Remark"].ToString(); }
                }
            }
        }
    }

}