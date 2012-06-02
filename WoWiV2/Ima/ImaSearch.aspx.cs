using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Bind();
        }
    }

    protected void Bind() 
    {
        SetCondition(cbRegion, lblRegion, false);
        SetCondition(cbProductType, lblPTID, false);
        SetCondition(cbCategory, lblCategory, true);
        SqlCommand cmd = new SqlCommand("STP_GetFullText");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmpID", Session["Session_User_Id"]);
        cmd.Parameters.AddWithValue("@keyword", tbKeyWord.Text.Trim());
        cmd.Parameters.AddWithValue("@RID", lblRegion.Text.Trim());
        cmd.Parameters.AddWithValue("@CID", lblCountrys.Text.Trim());
        cmd.Parameters.AddWithValue("@PTID", lblPTID.Text.Trim());
        cmd.Parameters.AddWithValue("@Category", lblCategory.Text.Trim());
        DataTable dt = new DataTable();
        dt = SQLUtil.QueryDS(cmd).Tables[0];
        gvImaSearch.DataSource = dt;
        gvImaSearch.DataBind();
        lblMsg.Text = "Search Results：" + dt.Rows.Count.ToString() + " Datas";
    }

    //查詢
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Bind();
    }

    //分頁
    protected void gvImaSearch_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvImaSearch.PageIndex = e.NewPageIndex;
        Bind();
    }

    /// <summary>
    /// 設定查詢條件
    /// </summary>
    /// <param name="cbl"></param>
    /// <param name="lbl"></param>
    /// <param name="bl">是否為字串</param>
    protected void SetCondition(CheckBoxList cbl, Label lbl, bool bl)
    {
        lbl.Text = "";
        foreach (ListItem li in cbl.Items)
        {
            if (li.Selected) 
            {
                if (bl) { lbl.Text += ",'" + li.Value + "'"; }
                else { lbl.Text += "," + li.Value; }                
            }
        }
        if (lbl.Text.Trim().Length > 0) { lbl.Text = lbl.Text.Trim().Remove(0, 1); }
    }

    protected void btnSelect_Click(object sender, EventArgs e)
    {
        ddlSelRegion.Items.Clear();
        ddlSelRegion.DataBind();
        ddlSelRegion.Items.Insert(0, new ListItem("All Region", "0"));
        string strSelRegion = "";
        bool blSelRegion = false;
        foreach (ListItem li in cbRegion.Items)
        {
            if (li.Selected) { blSelRegion = true; break; }
        }
        foreach (ListItem li in cbRegion.Items)
        {
            if (li.Selected) { strSelRegion += "," + li.Value; }
            else 
            {
                if (blSelRegion) { ddlSelRegion.Items.Remove(new ListItem(li.Text, li.Value)); }
            }
        }
        if (strSelRegion.Length > 0) 
        { 
            strSelRegion = strSelRegion.Remove(0, 1);
        }
        lblRegion.Text = strSelRegion;
        GetCountryList();
        mpeCountry.Show();
    }

    protected void GetCountryList() 
    {
        string strTsql = "select a.country_id,a.country_name,a.world_region_id,b.world_region_name from country a inner join world_region b on a.world_region_id=b.world_region_id ";
        if (lblRegion.Text.Length > 0) { strTsql += "where a.world_region_id in(" + lblRegion.Text + ") "; }
        if (ddlSelRegion.SelectedIndex > 0) { strTsql += "and a.world_region_id=" + ddlSelRegion.SelectedValue + " "; }
        strTsql += "order by a.country_name";
        SqlCommand cmd = new SqlCommand(strTsql);
        cmd.CommandType = CommandType.Text;
        gvCountryList.DataSource = SQLUtil.QueryDS(cmd).Tables[0];
        gvCountryList.DataBind();
    }

    protected void btnCSelect_Click(object sender, EventArgs e)
    {
        string strCountryID = "";
        string strCountryName = "";
        foreach (GridViewRow gvr in gvCountryList.Rows) 
        {
            CheckBox cbChoose = (CheckBox)gvr.FindControl("cbChoose");
            if (cbChoose.Checked)
            {
                strCountryID += "," + gvCountryList.DataKeys[gvr.RowIndex].Values[0].ToString();
                strCountryName += "；" + gvCountryList.DataKeys[gvr.RowIndex].Values[1].ToString();
            }
        }
        if (strCountryID.Length > 0) 
        {
            strCountryID = strCountryID.Remove(0, 1);
            strCountryName = strCountryName.Remove(0, 1);
        }
        lblCountrys.Text = strCountryID;
        tbCountry.Text = strCountryName;
    }

    protected void ddlSelRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetCountryList();
        mpeCountry.Show();
    }

    protected void gvCountryList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && lblCountrys.Text.Trim().Length > 0) 
        {
            string strCountryID = "," + lblCountrys.Text.Trim() + ",";
            string strCID = gvCountryList.DataKeys[e.Row.RowIndex].Values[0].ToString();
            if (strCountryID.Contains("," + strCID + ",")) 
            {
                CheckBox cbChoose = (CheckBox)e.Row.FindControl("cbChoose");
                cbChoose.Checked = true;
            }
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        tbCountry.Text = "";
        lblCountrys.Text = "";
    }

    //設定Detail的路徑(加入查詢的關鍵字)
    protected string SetDetailUrl(object objUrl) 
    {
        string strURL = "";
        if (objUrl != null) 
        {
            strURL = objUrl.ToString() + "&kw=" + HttpUtility.UrlEncode(tbKeyWord.Text.Trim());
        }
        return strURL;
    }
}