using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaCertificate : System.Web.UI.Page
{
    IMAUtil imau = new IMAUtil();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //設定業務人員不可進入編輯Page
            imau.CheckIsSales();
            LoadData();
        }
    }

    //取得General資料
    protected void LoadData()
    {
        lblTitle.Text = "Certificate Deliver Edit";
        string strID = Request["cfid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_Certificate where CertificateID=@CertificateID";
            cmd.Parameters.AddWithValue("@CertificateID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                cbEmail.Checked = Convert.ToBoolean(dt.Rows[0]["Email"]);
                cbCopy.Checked = Convert.ToBoolean(dt.Rows[0]["Copy"]);
                if (dt.Rows[0]["Collect"] != DBNull.Value) { cbCollect.Checked = Convert.ToBoolean(dt.Rows[0]["Collect"]); }
                cbLocal.Checked = Convert.ToBoolean(dt.Rows[0]["Local"]);
                cbProof.Checked = Convert.ToBoolean(dt.Rows[0]["Proof"]);
                if (dt.Rows[0]["NA"] != DBNull.Value) { cbNA.Checked = Convert.ToBoolean(dt.Rows[0]["NA"]); }
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                //2012/09/13會議取消copy預設
                //cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Certificate Deliver Copy";
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
        string strTsql = "insert into Ima_Certificate (world_region_id,country_id,wowi_product_type_id,Email,Copy,Local,Proof,CreateUser,LasterUpdateUser,Collect,NA) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Email,@Copy,@Local,@Proof,@CreateUser,@LasterUpdateUser,@Collect,@NA)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.TinyInt);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Email", SqlDbType.Bit);
        cmd.Parameters.Add("@Copy", SqlDbType.Bit);
        cmd.Parameters.Add("@Local", SqlDbType.Bit);
        cmd.Parameters.Add("@Proof", SqlDbType.Bit);
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Collect", SqlDbType.Bit);
        cmd.Parameters.Add("@NA", SqlDbType.Bit);
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
                cmd.Parameters["@Email"].Value = cbEmail.Checked;
                cmd.Parameters["@Copy"].Value = cbCopy.Checked;
                cmd.Parameters["@Local"].Value = cbLocal.Checked;
                cmd.Parameters["@Proof"].Value = cbProof.Checked;
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@Collect"].Value = cbCollect.Checked;
                cmd.Parameters["@NA"].Value = cbNA.Checked;
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));
            }
        }
        BackURL();
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_Certificate set Email=@Email,Copy=@Copy,Local=@Local,Proof=@Proof,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate(),Collect=@Collect,NA=@NA ";
        strTsql += "where CertificateID=@CertificateID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@CertificateID", Request["cfid"]);
        cmd.Parameters.AddWithValue("@Email", cbEmail.Checked);
        cmd.Parameters.AddWithValue("@Copy", cbCopy.Checked);
        cmd.Parameters.AddWithValue("@Local", cbLocal.Checked);
        cmd.Parameters.AddWithValue("@Proof", cbProof.Checked);
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@Collect", cbCollect.Checked);
        cmd.Parameters.AddWithValue("@NA", cbNA.Checked);
        SQLUtil.ExecuteSql(cmd);
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "cfid", "copy" }));
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