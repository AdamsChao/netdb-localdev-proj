using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaCertificationBodies : System.Web.UI.Page
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
        lblTitle.Text = "Certification bodies and websites Edit";
        string strID = Request["cbwid"];
        trProductType.Visible = false;
        trCopyTo.Visible = false;
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_CertificationBodies where CertificationBodiesID=@CertificationBodiesID";
            cmd.Parameters.AddWithValue("@CertificationBodiesID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbName.Text = dt.Rows[0]["Name"].ToString();
                rblAuthority.SelectedValue = Convert.ToInt32(dt.Rows[0]["Authority"]).ToString();
                rblCB.SelectedValue = Convert.ToInt32(dt.Rows[0]["CertificationBody"]).ToString();
                tbVolumePerYear.Text = dt.Rows[0]["VolumePerYear"].ToString();
                rblPublish.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish"]).ToString();
                tbAccredidedLab.Text = dt.Rows[0]["AccredidedLab"].ToString();
                tbVolumePerYear1.Text = dt.Rows[0]["VolumePerYear1"].ToString();
                rblPublish1.SelectedValue = Convert.ToInt32(dt.Rows[0]["Publish1"]).ToString();
                tbWebsite.Text = dt.Rows[0]["Website"].ToString();
                lblProType.Text = dt.Rows[0]["wowi_product_type_id"].ToString();
                cbProductType.SelectedValue = dt.Rows[0]["wowi_product_type_id"].ToString();
                lblProTypeName.Text = IMAUtil.GetProductType(lblProType.Text);
                if (Request.Params["copy"] != null)
                {
                    trCopyTo.Visible = true;
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Certification bodies and websites Copy";
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
        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblProType.Text = "";
        string strTsql = "insert into Ima_CertificationBodies (world_region_id,country_id,wowi_product_type_id,Name,Authority,CertificationBody,VolumePerYear,Publish,AccredidedLab,VolumePerYear1,Publish1,Website,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@wowi_product_type_id,@Name,@Authority,@CertificationBody,@VolumePerYear,@Publish,@AccredidedLab,@VolumePerYear1,@Publish1,@Website,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.Add("@world_region_id", SqlDbType.TinyInt);
        cmd.Parameters.Add("@country_id", SqlDbType.Int);
        cmd.Parameters.Add("@wowi_product_type_id", SqlDbType.Int);
        cmd.Parameters.Add("@Name", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Authority", SqlDbType.Bit);
        cmd.Parameters.Add("@CertificationBody", SqlDbType.Bit);
        cmd.Parameters.Add("@VolumePerYear", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Publish", SqlDbType.Bit);
        cmd.Parameters.Add("@AccredidedLab", SqlDbType.NVarChar);
        cmd.Parameters.Add("@VolumePerYear1", SqlDbType.NVarChar);
        cmd.Parameters.Add("@Publish1", SqlDbType.Bit);
        cmd.Parameters.Add("@Website", SqlDbType.NVarChar);        
        cmd.Parameters.Add("@CreateUser", SqlDbType.NVarChar);
        cmd.Parameters.Add("@LasterUpdateUser", SqlDbType.NVarChar);
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
                cmd.Parameters["@Name"].Value = tbName.Text.Trim();
                cmd.Parameters["@Authority"].Value = rblAuthority.SelectedValue == "1";
                cmd.Parameters["@CertificationBody"].Value = rblCB.SelectedValue == "1";
                cmd.Parameters["@VolumePerYear"].Value = tbVolumePerYear.Text.Trim();
                cmd.Parameters["@Publish"].Value = rblPublish.SelectedValue == "1";
                cmd.Parameters["@AccredidedLab"].Value = tbAccredidedLab.Text.Trim();
                cmd.Parameters["@VolumePerYear1"].Value = tbVolumePerYear1.Text.Trim();
                cmd.Parameters["@Publish1"].Value = rblPublish1.SelectedValue == "1";
                cmd.Parameters["@Website"].Value = tbWebsite.Text.Trim();
                cmd.Parameters["@CreateUser"].Value = IMAUtil.GetUser();
                cmd.Parameters["@LasterUpdateUser"].Value = IMAUtil.GetUser();
                int intGeneralID = Convert.ToInt32(SQLUtil.ExecuteScalar(cmd));                
            }
        }
        BackURL();
    }

    
    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_CertificationBodies set Name=@Name,Authority=@Authority,CertificationBody=@CertificationBody,VolumePerYear=@VolumePerYear,Publish=@Publish,AccredidedLab=@AccredidedLab,VolumePerYear1=@VolumePerYear1,Publish1=@Publish1,Website=@Website,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where CertificationBodiesID=@CertificationBodiesID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@CertificationBodiesID", Request["cbwid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        cmd.Parameters.AddWithValue("@Authority", rblAuthority.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@CertificationBody", rblCB.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@VolumePerYear", tbVolumePerYear.Text.Trim());
        cmd.Parameters.AddWithValue("@Publish", rblPublish.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@AccredidedLab", tbAccredidedLab.Text.Trim());
        cmd.Parameters.AddWithValue("@VolumePerYear1", tbVolumePerYear1.Text.Trim());
        cmd.Parameters.AddWithValue("@Publish1", rblPublish1.SelectedValue == "1");
        cmd.Parameters.AddWithValue("@Website", tbWebsite.Text.Trim());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        BackURL();

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        BackURL();
    }

    protected void BackURL()
    {
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "cbwid", "copy" }));
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