using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaTechRF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int intGID = Convert.ToInt32(Request["group"]);
            //if (intGID == 13) { intGID = 12; }
            if (intGID >= 13) { intGID -= 1; }
            ddlTech.SelectedIndex = intGID - 1;
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


        ContentPlaceHolder cph = (ContentPlaceHolder)Master.FindControl("MainContent");
        Panel plTech;
        SqlCommand cmd = new SqlCommand("STP_IMATechAttributeGet");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@wowi_product_type_id", lblProType.Text.Trim());
        cmd.Parameters.Add("@TechName", SqlDbType.NVarChar);
        //WiFi
        plTech = (Panel)cph.FindControl("plWiFi");
        GetTechFrequency(cmd, plTech, "WiFi");
        //Bluetooth
        plTech = (Panel)cph.FindControl("plBluetooth");
        GetTechFrequency(cmd, plTech, "Bluetooth");
        //RFID
        plTech = (Panel)cph.FindControl("plRFID");
        GetTechFrequency(cmd, plTech, "RFID");
        //FM Transmitter
        plTech = (Panel)cph.FindControl("plFMTransmitter");
        GetTechFrequency(cmd, plTech, "FM Transmitter");
        //Below 1GHz SRD
        plTech = (Panel)cph.FindControl("plBelow1GSRD");
        GetTechFrequency(cmd, plTech, "Below 1GHz SRD");
        //Above 1GHz SRD
        plTech = (Panel)cph.FindControl("plAbove1GSRD");
        GetTechFrequency(cmd, plTech, "Above 1GHz SRD");
        //Zigbee
        plTech = (Panel)cph.FindControl("plZigbee");
        GetTechFrequency(cmd, plTech, "Zigbee");
        //UWB
        plTech = (Panel)cph.FindControl("plUWB");
        GetTechFrequency(cmd, plTech, "UWB");
        //2G
        plTech = (Panel)cph.FindControl("pl2G");
        GetTechFrequency(cmd, plTech, "2G GSM/GPRS/EDGE/EDGE Evolution");
        //3G
        plTech = (Panel)cph.FindControl("pl3G");
        GetTechFrequency(cmd, plTech, "3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+");
        //4G
        plTech = (Panel)cph.FindControl("pl4G");
        GetTechFrequency(cmd, plTech, "4G LTE");
        //CDMAOne
        plTech = (Panel)cph.FindControl("plCDMA");
        GetTechFrequency(cmd, plTech, "CDMAOne");
        //CDMA2000
        plTech = (Panel)cph.FindControl("plCDMA");
        GetTechFrequency(cmd, plTech, "CDMA2000");
        //Wireless HD 60
        plTech = (Panel)cph.FindControl("plWirelessHD60");
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
            TextBox tbPL;
            CheckBox cbIDA;
            CheckBox cbODA;
            CheckBox cbHT20;
            CheckBox cbHT40;
            CheckBox cbHT80;
            CheckBox cbHT160;
            TextBox tbHT;
            CheckBox cbDFS;
            CheckBox cbTPC;
            TextBox tbDFS;
            CheckBox cbANA;
            CheckBox cbANAN;
            for (int i = 1; i <= intRowCount; i++)
            {
                TextBox tbFrequencyDesc = (TextBox)plTech.FindControl("tb" + strTechName + "FDesc" + i.ToString());
                if (tbFrequencyDesc != null) { tbFrequencyDesc.Text = dtTech.Rows[i - 1]["FrequencyDesc"].ToString(); }
                tbPL = (TextBox)plTech.FindControl("tb" + strTechName + "PL" + i.ToString());
                if (tbPL != null) { tbPL.Text = dtTech.Rows[i - 1]["PowerLimit"].ToString(); }
                cbIDA = (CheckBox)plTech.FindControl("cb" + strTechName + "IDA" + i.ToString());
                if (cbIDA != null) { cbIDA.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["IndoorAllowed"]); }
                cbODA = (CheckBox)plTech.FindControl("cb" + strTechName + "ODA" + i.ToString());
                if (cbODA != null) { cbODA.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["OutdoorAllowed"]); }
                cbHT20 = (CheckBox)plTech.FindControl("cb" + strTechName + "HT20" + i.ToString());
                if (cbHT20 != null) { cbHT20.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["HT20"]); }
                cbHT40 = (CheckBox)plTech.FindControl("cb" + strTechName + "HT40" + i.ToString());
                if (cbHT40 != null) { cbHT40.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["HT40"]); }
                cbHT80 = (CheckBox)plTech.FindControl("cb" + strTechName + "HT80" + i.ToString());
                if (cbHT80 != null) { cbHT80.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["HT80"]); }
                cbHT160 = (CheckBox)plTech.FindControl("cb" + strTechName + "HT160" + i.ToString());
                if (cbHT160 != null) { cbHT160.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["HT160"]); }
                tbHT = (TextBox)plTech.FindControl("tb" + strTechName + "HT" + i.ToString());
                if (tbHT != null) { tbHT.Text = dtTech.Rows[i - 1]["HTDesc"].ToString(); }
                cbDFS = (CheckBox)plTech.FindControl("cb" + strTechName + "DFS" + i.ToString());
                if (cbDFS != null) { cbDFS.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["DFS"]); }
                cbTPC = (CheckBox)plTech.FindControl("cb" + strTechName + "TPC" + i.ToString());
                if (cbTPC != null) { cbTPC.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["TPC"]); }
                tbDFS = (TextBox)plTech.FindControl("tb" + strTechName + "DFS" + i.ToString());
                if (tbDFS != null) { tbDFS.Text = dtTech.Rows[i - 1]["DFSDesc"].ToString(); }
                cbANA = (CheckBox)plTech.FindControl("cb" + strTechName + "ANA" + i.ToString());
                if (cbANA != null) { cbANA.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["IsAllowed"]); }
                cbANAN = (CheckBox)plTech.FindControl("cb" + strTechName + "ANAN" + i.ToString());
                if (cbANAN != null) { cbANAN.Checked = Convert.ToBoolean(dtTech.Rows[i - 1]["IsNotAllowed"]); }
                if (i == 1) 
                {
                    TextBox tbRemark;
                    if (plTech.ID.Replace("pl", "") != "CDMA") { tbRemark = (TextBox)plTech.FindControl("tb" + strTechName + "Remark"); }
                    else { tbRemark = tbCDMRemark; }
                    if (tbRemark != null) { tbRemark.Text = dtTech.Rows[i - 1]["Remark"].ToString(); }
                }
            }
        }
    }
    
    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand("STP_IMATechAttributeAdd");
        cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        //cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        //cmd.Parameters.AddWithValue("@wowi_product_type_id", lblProType.Text.Trim());
        //cmd.Parameters.AddWithValue("@TechName", ddlTech.SelectedValue);
        //cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        //cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.Add("@world_region_id", SqlDbType.TinyInt);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@TechName", SqlDbType.NVarChar);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters["@world_region_id"].Value = Convert.ToInt32(Request["rid"]);
        cmd.Parameters["@country_id"].Value = Convert.ToInt32(Request["cid"]);
        cmd.Parameters["@wowi_product_type_id"].Value = Convert.ToInt32(lblProType.Text.Trim());        
        cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
        cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
        cmd.Parameters.Add("@Remark", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Frequency", SqlDbType.NVarChar);
        cmd.Parameters.Add("@FrequencyDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@PowerLimit", SqlDbType.NVarChar);
        cmd.Parameters.Add("@IsAllowed", SqlDbType.Bit);
        cmd.Parameters.Add("@IsNotAllowed", SqlDbType.Bit);
        cmd.Parameters.Add("@IndoorAllowed", SqlDbType.Bit);
        cmd.Parameters.Add("@OutdoorAllowed", SqlDbType.Bit);
        cmd.Parameters.Add("@HT20", SqlDbType.Bit);
        cmd.Parameters.Add("@HT40", SqlDbType.Bit);
        cmd.Parameters.Add("@HT80", SqlDbType.Bit);
        cmd.Parameters.Add("@HT160", SqlDbType.Bit);
        cmd.Parameters.Add("@HTDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@DFS", SqlDbType.Bit);
        cmd.Parameters.Add("@TPC", SqlDbType.Bit);
        cmd.Parameters.Add("@DFSDesc", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Seq", SqlDbType.SmallInt);
        cmd.Parameters.Add("@GID", SqlDbType.SmallInt);
        if (ddlTech.SelectedIndex > 11) { cmd.Parameters["@GID"].Value = ddlTech.SelectedIndex + 2; }
        else { cmd.Parameters["@GID"].Value = ddlTech.SelectedIndex + 1; }       

        ContentPlaceHolder cph = (ContentPlaceHolder)Master.FindControl("MainContent");
        Panel plTech;
        if (ddlTech.SelectedValue == "WiFi") 
        {
            plTech = (Panel)cph.FindControl("plWiFi");
            AddWiFi(cmd, plTech);
            mbMsgWiFi.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "Bluetooth")
        {
            plTech = (Panel)cph.FindControl("plBluetooth");
            AddTechFrequency(cmd, plTech, "Bluetooth", 1);
            mbMsgBluetooth.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "RFID")
        {
            plTech = (Panel)cph.FindControl("plRFID");
            AddTechFrequency(cmd, plTech, "RFID", 8);
            mbMsgRFID.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "FM Transmitter")
        {
            plTech = (Panel)cph.FindControl("plFMTransmitter");
            AddTechFrequency(cmd, plTech, "FMTransmitter", 1);
            mbMsgFMTransmitter.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "Below 1GHz SRD")
        {
            plTech = (Panel)cph.FindControl("plBelow1GSRD");
            AddTechFrequency(cmd, plTech, "Below1GSRD", 4);
            mbMsgBelow1GSRD.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "Above 1GHz SRD")
        {
            plTech = (Panel)cph.FindControl("plAbove1GSRD");
            AddTechFrequency(cmd, plTech, "Above1GSRD", 2);
            mbMsgAbove1GSRD.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "Zigbee")
        {
            plTech = (Panel)cph.FindControl("plZigbee");
            AddTechFrequency(cmd, plTech, "Zigbee", 3);
            mbMsgZigbee.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "UWB")
        {
            plTech = (Panel)cph.FindControl("plUWB");
            AddTechFrequency(cmd, plTech, "UWB", 14);
            mbMsgUWB.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "2G GSM/GPRS/EDGE/EDGE Evolution")
        {
            plTech = (Panel)cph.FindControl("pl2G");
            AddTechFrequency(cmd, plTech, "2G", 14);
            mbMsg2G.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+")
        {
            plTech = (Panel)cph.FindControl("pl3G");
            AddTechFrequency(cmd, plTech, "3G", 17);
            mbMsg3G.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "4G LTE")
        {
            plTech = (Panel)cph.FindControl("pl4G");
            AddTechFrequency(cmd, plTech, "4G", 14);
            mbMsg4G.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "CDMA")
        {
            plTech = (Panel)cph.FindControl("plCDMA");
            AddTechFrequency(cmd, plTech, "CDMAOne", 8);
            AddTechFrequency(cmd, plTech, "CDMA2000", 10);
            mbMsgCDMA.Show("Successfully saved!");
        }
        else if (ddlTech.SelectedValue == "Wireless HD 60GHz")
        {
            plTech = (Panel)cph.FindControl("plWirelessHD60");
            AddTechFrequency(cmd, plTech, "WirelessHD60", 1);
            mbMsgWirelessHD60.Show("Successfully saved!");
        }
    }

    protected void AddWiFi(SqlCommand cmd, Panel plTech) 
    {
        cmd.Parameters["@TechName"].Value = ddlTech.SelectedValue;
        cmd.Parameters["@Remark"].Value = tbWiFiRemark.Text.Trim();
        Label lblWiFiF;
        TextBox tbWiFiPL;
        CheckBox cbWiFiIDA;
        CheckBox cbWiFiODA;
        CheckBox cbWiFiHT20;
        CheckBox cbWiFiHT40;
        CheckBox cbWiFiHT80;
        CheckBox cbWiFiHT160;
        TextBox tbWiFiHT;
        CheckBox cbWiFiDFS;
        CheckBox cbWiFiTPC;
        TextBox tbWiFiDFS;
        CheckBox cbWiFiANA;
        for (int i = 1; i <= 6; i++)
        {
            lblWiFiF = (Label)plTech.FindControl("lblWiFiF" + i.ToString());
            tbWiFiPL = (TextBox)plTech.FindControl("tbWiFiPL" + i.ToString());
            cbWiFiIDA = (CheckBox)plTech.FindControl("cbWiFiIDA" + i.ToString());
            cbWiFiODA = (CheckBox)plTech.FindControl("cbWiFiODA" + i.ToString());
            cbWiFiHT20 = (CheckBox)plTech.FindControl("cbWiFiHT20" + i.ToString());
            cbWiFiHT40 = (CheckBox)plTech.FindControl("cbWiFiHT40" + i.ToString());
            cbWiFiHT80 = (CheckBox)plTech.FindControl("cbWiFiHT80" + i.ToString());
            cbWiFiHT160 = (CheckBox)plTech.FindControl("cbWiFiHT160" + i.ToString());
            tbWiFiHT = (TextBox)plTech.FindControl("tbWiFiHT" + i.ToString());
            cbWiFiDFS = (CheckBox)plTech.FindControl("cbWiFiDFS" + i.ToString());
            cbWiFiTPC = (CheckBox)plTech.FindControl("cbWiFiTPC" + i.ToString());
            tbWiFiDFS = (TextBox)plTech.FindControl("tbWiFiDFS" + i.ToString());
            cbWiFiANA = (CheckBox)plTech.FindControl("cbWiFiANA" + i.ToString());
            cmd.Parameters["@Frequency"].Value = lblWiFiF.Text.Trim();
            cmd.Parameters["@FrequencyDesc"].Value = DBNull.Value;
            cmd.Parameters["@PowerLimit"].Value = tbWiFiPL.Text.Trim();
            cmd.Parameters["@IsAllowed"].Value = cbWiFiANA.Checked;
            cmd.Parameters["@IndoorAllowed"].Value = cbWiFiIDA.Checked;
            cmd.Parameters["@OutdoorAllowed"].Value = cbWiFiODA.Checked;
            cmd.Parameters["@HT20"].Value = cbWiFiHT20.Checked;
            cmd.Parameters["@HT40"].Value = cbWiFiHT40.Checked;
            cmd.Parameters["@HT80"].Value = cbWiFiHT80.Checked;
            cmd.Parameters["@HT160"].Value = cbWiFiHT160.Checked;
            cmd.Parameters["@HTDesc"].Value = tbWiFiHT.Text.Trim();
            cmd.Parameters["@DFS"].Value = cbWiFiDFS.Checked;
            cmd.Parameters["@TPC"].Value = cbWiFiTPC.Checked;
            cmd.Parameters["@DFSDesc"].Value = tbWiFiDFS.Text.Trim();
            cmd.Parameters["@Seq"].Value = i;
            SQLUtil.ExecuteSql(cmd);
        }
    }

    protected void AddTechFrequency(SqlCommand cmd, Panel plTech, string strTechName, int intNum)
    {
        if (plTech.ID.Replace("pl", "") == "CDMA")
        {
            cmd.Parameters["@TechName"].Value = strTechName;
            if (strTechName == "CDMA2000") { cmd.Parameters["@GID"].Value = ddlTech.SelectedIndex + 2; }
        }
        else 
        {
            cmd.Parameters["@TechName"].Value = ddlTech.SelectedValue;            
        }
        TextBox tbRemark;
        if (plTech.ID.Replace("pl", "") == "CDMA")
        {
            tbRemark = (TextBox)plTech.FindControl("tbCDMRemark");
        }
        else 
        {
            tbRemark = (TextBox)plTech.FindControl("tb" + strTechName + "Remark");
        }
        if (tbRemark != null) { cmd.Parameters["@Remark"].Value = tbRemark.Text.Trim(); }
        else { cmd.Parameters["@Remark"].Value = DBNull.Value; }
        //WirelessHD60
        if (plTech.ID.Replace("pl", "") == "WirelessHD60")
        {
            cmd.Parameters["@IndoorAllowed"].Value = cbWirelessHD60IDA1.Checked;
            cmd.Parameters["@OutdoorAllowed"].Value = cbWirelessHD60ODA1.Checked;
        }
        else 
        {
            cmd.Parameters["@IndoorAllowed"].Value = DBNull.Value;
            cmd.Parameters["@OutdoorAllowed"].Value = DBNull.Value;
        }       
        cmd.Parameters["@HT20"].Value = DBNull.Value;
        cmd.Parameters["@HT40"].Value = DBNull.Value;
        cmd.Parameters["@HT80"].Value = DBNull.Value;
        cmd.Parameters["@HT160"].Value = DBNull.Value;
        cmd.Parameters["@HTDesc"].Value = DBNull.Value;
        cmd.Parameters["@DFS"].Value = DBNull.Value;
        cmd.Parameters["@TPC"].Value = DBNull.Value;
        cmd.Parameters["@DFSDesc"].Value = DBNull.Value;
        Label lblF;
        TextBox tbPL;
        CheckBox cbANA;
        CheckBox cbANAN;
        for (int i = 1; i <= intNum; i++)
        {
            lblF = (Label)plTech.FindControl("lbl" + strTechName + "F" + i.ToString());
            tbPL = (TextBox)plTech.FindControl("tb" + strTechName + "PL" + i.ToString());
            cbANA = (CheckBox)plTech.FindControl("cb" + strTechName + "ANA" + i.ToString());
            cbANAN = (CheckBox)plTech.FindControl("cb" + strTechName + "ANAN" + i.ToString());
            if (lblF != null) { cmd.Parameters["@Frequency"].Value = lblF.Text.Trim(); }
            else { cmd.Parameters["@Frequency"].Value = DBNull.Value; }            
            if (strTechName == "FMTransmitter" || strTechName == "Above1GSRD")
            {
                TextBox tbFrequencyDesc = (TextBox)plTech.FindControl("tb" + strTechName + "FDesc" + i.ToString());
                if (tbFrequencyDesc != null) { cmd.Parameters["@FrequencyDesc"].Value = tbFrequencyDesc.Text.Trim(); }
                else { cmd.Parameters["@FrequencyDesc"].Value = DBNull.Value; }
            }
            else { cmd.Parameters["@FrequencyDesc"].Value = DBNull.Value; }
            if (tbPL != null) { cmd.Parameters["@PowerLimit"].Value = tbPL.Text.Trim(); }
            else { cmd.Parameters["@PowerLimit"].Value = DBNull.Value; }
            if (cbANA != null) { cmd.Parameters["@IsAllowed"].Value = cbANA.Checked; }
            else { cmd.Parameters["@IsAllowed"].Value = DBNull.Value; }
            if (cbANAN != null) { cmd.Parameters["@IsNotAllowed"].Value = cbANAN.Checked; }
            else { cmd.Parameters["@IsNotAllowed"].Value = DBNull.Value; }
            cmd.Parameters["@Seq"].Value = i;
            SQLUtil.ExecuteSql(cmd);
        }
    }

    //返回
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "group" }));
    }

    /// <summary>
    /// 下一頁的 Get 參數設定
    /// </summary>
    /// <param name="isClear">是否清除URL的參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    private string GetQueryString(bool isClear, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        //預設參數
        Dictionary<string, string> dic = new Dictionary<string, string>();
        return IMAUtil.SetQueryString(isClear, dic, dicAdd, strRemove);
    }

    
}