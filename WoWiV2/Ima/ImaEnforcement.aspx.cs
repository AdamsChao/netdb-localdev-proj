using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaEnforcement : System.Web.UI.Page
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
        lblTitle.Text = "Enforcement & Importation – Market Inspection Edit";
        string strID = Request["eid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Enforcement where EnforcementID=@EnforcementID";
            cmd.Parameters.AddWithValue("@EnforcementID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                cbCustom.Checked = Convert.ToBoolean(dt.Rows[0]["Custom"]);
                cbMarket.Checked = Convert.ToBoolean(dt.Rows[0]["Market"]);
                cbFactory.Checked = Convert.ToBoolean(dt.Rows[0]["Factory"]);
                tbRemark.Text = dt.Rows[0]["Remark"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Enforcement & Importation – Market Inspection Copy";
                }
                else
                {
                    btnUpd.Visible = true;
                    trProductType.Visible = true;
                }
            }
        }
        else
        {
            btnSave.Visible = true;
            trProductType.Visible = true;
            foreach (string str in Request["pt"].Split(','))
            {
                if (str.Length > 0) { lblProTypeName.Text += "," + IMAUtil.GetProductType(str); }
            }
            if (lblProTypeName.Text.Trim().Length > 0) { lblProTypeName.Text = lblProTypeName.Text.Remove(0, 1); }
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_Enforcement (world_region_id,country_id,wowi_product_type_id,Custom,Market,Factory,CreateUser,LasterUpdateUser,Remark) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Custom,@Market,@Factory,@CreateUser,@LasterUpdateUser,@Remark)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.TinyInt);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Custom", SqlDbType.Bit);
        cmd.Parameters.Add("@Market", SqlDbType.Bit);
        cmd.Parameters.Add("@Factory", SqlDbType.Bit);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Remark", SqlDbType.NVarChar);
        string strCopyTo = HttpUtility.UrlDecode(Request["pt"]);
        if (Request["copy"] != null)
        {
            foreach (ListItem li in cbProductType.Items)
            {
                if (li.Selected)
                {
                    strCopyTo += "," + li.Value;
                }
            }
            if (strCopyTo != "") { strCopyTo = strCopyTo.Remove(0, 1); }
        }
        foreach (string str in strCopyTo.Split(','))
        {
            if (str != "")
            {
                lblProType.Text = str;
                cmd.Parameters["@world_region_id"].Value = Request["rid"];
                cmd.Parameters["@country_id"].Value = Request["cid"];
                cmd.Parameters["@wowi_product_type_id"].Value = str;
                cmd.Parameters["@Custom"].Value = cbCustom.Checked;
                cmd.Parameters["@Market"].Value = cbMarket.Checked;
                cmd.Parameters["@Factory"].Value = cbFactory.Checked;
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@Remark"].Value = tbRemark.Text.Trim();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
            }
        }
        BackURL();
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_Enforcement set Custom=@Custom,Market=@Market,Factory=@Factory,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Remark=@Remark ";
        strTsql += "where EnforcementID=@EnforcementID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@EnforcementID", Request["eid"]);
        cmd.Parameters.AddWithValue("@Custom", cbCustom.Checked);
        cmd.Parameters.AddWithValue("@Market", cbMarket.Checked);
        cmd.Parameters.AddWithValue("@Factory", cbFactory.Checked);
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Remark", tbRemark.Text.Trim());
        SQLUtil.ExecuteSql(cmd);
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "eid", "copy" }));
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