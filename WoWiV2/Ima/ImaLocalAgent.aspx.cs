using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaLocalAgent : System.Web.UI.Page
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
        lblTitle.Text = "Local Agent Edit";
        string strID = Request["laid"];
        btnSave.Visible = false;
        btnUpd.Visible = false;
        btnSaveCopy.Visible = false;
        cbProductType.DataBind();
        if (strID != null)
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from Ima_LocalAgent where LocalAgentID=@LocalAgentID";
            cmd.Parameters.AddWithValue("@LocalAgentID", strID);
            DataTable dt = new DataTable();
            dt = SQLUtil.QueryDS(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                tbName.Text = dt.Rows[0]["Name"].ToString();
                tbCredit.Text = dt.Rows[0]["Credit"].ToString();
                tbCommunication.Text = dt.Rows[0]["Communication"].ToString();                
                tbVolume.Text = dt.Rows[0]["Volume"].ToString();

                foreach (ListItem li in cbProductType.Items)
                {
                    if (li.Text.Trim() == "RF")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["RF"]);
                    }
                    else if (li.Text.Trim() == "Telecom")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Telecom"]);
                    }
                    else if (li.Text.Trim() == "EMC")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["EMC"]);
                    }
                    else if (li.Text.Trim() == "Safety")
                    {
                        li.Selected = Convert.ToBoolean(dt.Rows[0]["Safety"]);
                    }
                }

                if (Request.Params["copy"] != null)
                {
                    btnSaveCopy.Visible = true;
                    lblTitle.Text = "Local Agent Copy";
                }
                else
                {
                    btnUpd.Visible = true;
                }
            }
        }
        else
        {
            btnSave.Visible = true;
            foreach (string str in HttpUtility.UrlDecode(Request["pt"]).Split(','))
            {
                if (str != "")
                {
                    foreach (ListItem li in cbProductType.Items)
                    {
                        if (li.Value == str)
                        {
                            li.Selected = true;
                            break;
                        }
                    }
                }
            }


        }
    }

    //儲存
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strTsql = "insert into Ima_LocalAgent (world_region_id,country_id,Name,RF,Telecom,EMC,Safety,Credit,Communication,Volume,CreateUser,LasterUpdateUser) ";
        strTsql += "values(@world_region_id,@country_id,@Name,@RF,@Telecom,@EMC,@Safety,@Credit,@Communication,@Volume,@CreateUser,@LasterUpdateUser)";
        strTsql += ";select @@identity";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@world_region_id", Request["rid"]);
        cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF") 
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@Credit", tbCredit.Text.Trim());
        cmd.Parameters.AddWithValue("@Communication", tbCommunication.Text.Trim());
        cmd.Parameters.AddWithValue("@Volume", tbVolume.Text.Trim());
        cmd.Parameters.AddWithValue("@CreateUser", IMAUtil.GetUser());
        cmd.Parameters.AddWithValue("@LasterUpdateUser", IMAUtil.GetUser());
        SQLUtil.ExecuteSql(cmd);
        BackURL();
    }


    protected void btnUpd_Click(object sender, EventArgs e)
    {
        string strTsql = "Update Ima_LocalAgent set Name=@Name,RF=@RF,Telecom=@Telecom,EMC=@EMC,Safety=@Safety,Credit=@Credit,Communication=@Communication,Volume=@Volume,LasterUpdateUser=@LasterUpdateUser,LasterUpdateDate=getdate() ";
        strTsql += "where LocalAgentID=@LocalAgentID";
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = strTsql;
        cmd.Parameters.AddWithValue("@LocalAgentID", Request["laid"]);
        cmd.Parameters.AddWithValue("@Name", tbName.Text.Trim());
        foreach (ListItem li in cbProductType.Items)
        {
            if (li.Text.Trim() == "RF")
            {
                cmd.Parameters.AddWithValue("@RF", li.Selected);
            }
            else if (li.Text.Trim() == "Telecom")
            {
                cmd.Parameters.AddWithValue("@Telecom", li.Selected);
            }
            else if (li.Text.Trim() == "EMC")
            {
                cmd.Parameters.AddWithValue("@EMC", li.Selected);
            }
            else if (li.Text.Trim() == "Safety")
            {
                cmd.Parameters.AddWithValue("@Safety", li.Selected);
            }
        }
        cmd.Parameters.AddWithValue("@Credit", tbCredit.Text.Trim());
        cmd.Parameters.AddWithValue("@Communication", tbCommunication.Text.Trim());
        cmd.Parameters.AddWithValue("@Volume", tbVolume.Text.Trim());
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
        Response.Redirect("ImaList.aspx" + GetQueryString(false, null, new string[] { "pt", "laid", "copy" }));
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