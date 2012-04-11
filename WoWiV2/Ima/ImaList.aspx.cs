using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Ima_ImaList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) 
        {
            if (Request["categroy"] != null) 
            {
                ddlDocCategory.SelectedValue = Request["categroy"].ToString();
                SetDDlChanged();
            }            
            SetControlInit();
        }
    }

    protected void SetControlInit() 
    {
        trDoc1.Visible = false;
        trDoc2.Visible = false;
        trDoc3.Visible = false;
        //string strParms = Request.QueryString.ToString();
        //if (Request["categroy"] != null) { strParms = strParms.Replace("&categroy=" + Request.Params["categroy"], ""); }
        //btnGeneral.PostBackUrl = "ImaGeneralEdit.aspx?" + strParms + "&categroy=" + ddlDocCategory.SelectedValue;
        hlGeneral.Visible = false;
        if (Request.Params["rid"] != null && Request.Params["cid"] != null) 
        {
            trDoc1.Visible = true;
            trDoc2.Visible = true;
            trDoc3.Visible = true;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select GeneralID from Ima_General where country_id=@country_id;select country_name from country where country_id=@country_id";
            cmd.Parameters.AddWithValue("@country_id", Request["cid"]);
            DataSet ds = new DataSet();
            ds = SQLUtil.QueryDS(cmd);
            int intCount=0;
            if (ds.Tables[0].Rows.Count > 0) 
            {
                intCount = Convert.ToInt32(ds.Tables[0].Rows[0]["GeneralID"].ToString());
                hfGID.Value = intCount.ToString();
            }
            string strContryName = ds.Tables[1].Rows[0]["country_name"].ToString();
            if (intCount > 0) 
            {
                btnGeneral.Text = "Edit General";
                //btnGeneral.PostBackUrl = "ImaGeneralEdit.aspx?" + strParms + "&gid=" + intCount.ToString() + "&categroy=" + ddlDocCategory.SelectedValue;
                hlGeneral.Visible = true;
                hlGeneral.NavigateUrl = "ImaGeneralDetail.aspx?" + Request.QueryString.ToString() + "&gid=" + intCount.ToString(); ;
            }
            if (strContryName.Length > 0)
            {
                btnGeneral.Text += "(" + strContryName + ")";
            }
        }
       
        if (Request["pid"] != null)
        {
            cbProductType.DataBind();
            foreach (ListItem li in cbProductType.Items)
            {
                if (li.Value == Request["pid"])
                {
                    li.Selected = true;
                    break;
                }
            }
        }
        SetButton();
    }

    private void SetButton()
    {
        btnAdd.Visible = false;
        btnAddDocument.Visible = false;

        if (ddlDocCategory.SelectedValue == "H" || ddlDocCategory.SelectedValue == "B")
        {
            btnAdd.Visible = true;
        }
        else
        {
            btnAddDocument.Visible = true;
        }
    }


    //新增文件
    protected void btnAddDocument_Click(object sender, EventArgs e)
    {
        //string strURL = "";
        //string strParm = "";
        //foreach (ListItem li in cbProductType.Items)
        //{
        //    if (li.Selected)
        //    {
        //        strParm += "," + li.Value;
        //    }
        //}
        //if (strParm.Length > 0) { strParm = strParm.Remove(0, 1); }
        //if (ddlDocCategory.SelectedValue == "B")
        //{
        //    strURL = "ImaGovernmentAuth.aspx";
        //}
        //else if (ddlDocCategory.SelectedValue == "C")
        //{
        //    strURL = "ImaNationalGoverned.aspx";
        //}
        //Response.Redirect(strURL + "?" + Request.QueryString.ToString() + "&pt=" + HttpUtility.UrlEncode(strParm));



        Dictionary<string, string> dic = new Dictionary<string, string>();
        string strURL = "";
        string strParm = "";
        if (ddlDocCategory.SelectedValue == "H" || ddlDocCategory.SelectedValue == "B")
        {
            strParm = rblProductType.SelectedValue;
            dic.Add("pt", strParm);
        }
        else 
        {
            foreach (ListItem li in cbProductType.Items)
            {
                if (li.Selected)
                {
                    strParm += "," + li.Value;
                }
            }
            if (strParm.Length > 0)
            {
                strParm = strParm.Remove(0, 1);
                dic.Add("pt", strParm);
            }
        }        

        if (ddlDocCategory.SelectedValue == "B")
        {
            strURL = "ImaGovernmentAuth.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "C")
        {
            strURL = "ImaNationalGoverned.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "D")
        {
            strURL = "ImaCertificationBodies.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "Q")
        {
            strURL = "AccreditedTestLab.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "G")
        {
            strURL = "ImaProductControl.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "F")
        {
            strURL = "ImaLocalAgent.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "O")
        {
            strURL = "ImaCertificate.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "E")
        {
            strURL = "ImaEnforcement.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "L")
        {
            strURL = "ImaFeeSchedule.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "P")
        {
            strURL = "ImaPost.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "N")
        {
            strURL = "ImaPeriodic.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "K")
        {
            strURL = "ImaTesting.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "H")
        {
            strURL = "ImaStandard.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "J")
        {
            strURL = "ImaApplication.aspx";
        }
        else if (ddlDocCategory.SelectedValue == "M")
        {
            strURL = "ImaSampleShipping.aspx";
        }
        Response.Redirect(strURL + GetQueryString(true, dic, null));
    }

    //建立/修改General文件
    protected void btnGeneral_Click(object sender, EventArgs e)
    {
        //string strParms = Request.QueryString.ToString();
        //if (Request["categroy"] != null) { strParms = strParms.Replace("&categroy=" + Request.Params["categroy"], ""); }
        ////btnGeneral.PostBackUrl = "ImaGeneralEdit.aspx?" + strParms + "&categroy=" + ddlDocCategory.SelectedValue;
        //string strURL = "ImaGeneralEdit.aspx?" + strParms + "&categroy=" + ddlDocCategory.SelectedValue;
        //if (Request.Params["rid"] != null && Request.Params["cid"] != null && hfGID.Value != "0")
        //{
        //    strURL = "ImaGeneralEdit.aspx?" + strParms + "&gid=" + hfGID.Value + "&categroy=" + ddlDocCategory.SelectedValue;

        //}
        //Response.Redirect(strURL);
        Dictionary<string, string> dic = new Dictionary<string, string>();
        if (Request.Params["rid"] != null && Request.Params["cid"] != null && hfGID.Value != "0")
        {
            dic.Add("gid", hfGID.Value);
        }
        Response.Redirect("ImaGeneralEdit.aspx" + GetQueryString(true, dic, null));
    }

    protected void ddlDocCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetDDlChanged();
        SetButton();
    }

    protected void SetDDlChanged() 
    {
        trImaGover.Visible = false;
        trDL.Visible = false;
        //lblTitle.Text = "";
        if (ddlDocCategory.SelectedValue != "0")
        {
            trDL.Visible = true;
            trImaGover.Visible = true;
            //lblTitle.Text = "Country：" + IMAUtil.GetCountryName(Request.Params["cid"]) + @" \ Document Categories--> ";
            //lblTitle.Text += ddlDocCategory.SelectedItem.Text + @" \ Data：";
        }
        if (ddlDocCategory.SelectedValue == "H" || ddlDocCategory.SelectedValue == "B")
        {
            rblProductType.DataBind();
            rblProductType.Visible = true;
            rblProductType.SelectedIndex = 0;
            cbProductType.Visible = false;
        }
        else 
        {
            rblProductType.Visible = false;
            cbProductType.Visible = true;
        }
    }

    /// <summary>
    /// B.Government Authority
    /// </summary>
    protected void sdsB_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //if (ddlDocCategory.SelectedValue == "B") { lblCount.Text = e.AffectedRows.ToString(); }
    }

    //C.National governed rules and regulation
    protected void sdsC_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        //if (ddlDocCategory.SelectedValue == "C") { lblCount.Text = e.AffectedRows.ToString(); }
    }




    //前往修改或複制
    protected void lbtnEdit_Click(object sender, EventArgs e)
    {
        Dictionary<string, string> dic = new Dictionary<string, string>();
        string strURL = "";
        LinkButton lbtn = (LinkButton)sender;
        switch (lbtn.CommandName)
        {
            case "GoEditB":
                dic.Add("gaid", lbtn.CommandArgument);
                strURL = "ImaGovernmentAuth.aspx";
                break;
            case "GoCopyB":
                dic.Add("gaid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaGovernmentAuth.aspx";
                break;
            case "GoEditC":
                dic.Add("ngid", lbtn.CommandArgument);
                strURL = "ImaNationalGoverned.aspx";
                break;
            case "GoCopyC":
                dic.Add("ngid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaNationalGoverned.aspx";
                break;
            case "GoEditD":
                dic.Add("cbwid", lbtn.CommandArgument);
                strURL = "ImaCertificationBodies.aspx";
                break;
            case "GoCopyD":
                dic.Add("cbwid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaCertificationBodies.aspx";
                break;
            case "GoEditQ":
                dic.Add("atid", lbtn.CommandArgument);
                strURL = "AccreditedTestLab.aspx";
                break;
            case "GoCopyQ":
                dic.Add("atid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "AccreditedTestLab.aspx";
                break;
            case "GoEditG":
                dic.Add("pcid", lbtn.CommandArgument);
                strURL = "ImaProductControl.aspx";
                break;
            case "GoCopyG":
                dic.Add("pcid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaProductControl.aspx";
                break;
            case "GoEditF":
                dic.Add("laid", lbtn.CommandArgument);
                strURL = "ImaLocalAgent.aspx";
                break;
            case "GoCopyF":
                dic.Add("laid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaLocalAgent.aspx";
                break;
            case "GoEditE":
                dic.Add("eid", lbtn.CommandArgument);
                strURL = "ImaEnforcement.aspx";
                break;
            case "GoCopyE":
                dic.Add("eid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaEnforcement.aspx";
                break;
            case "GoEditL":
                dic.Add("fsid", lbtn.CommandArgument);
                strURL = "ImaFeeSchedule.aspx";
                break;
            case "GoCopyL":
                dic.Add("fsid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaFeeSchedule.aspx";
                break;
            case "GoEditO":
                dic.Add("cfid", lbtn.CommandArgument);
                strURL = "ImaCertificate.aspx";
                break;
            case "GoCopyO":
                dic.Add("cfid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaCertificate.aspx";
                break;
            case "GoEditP":
                dic.Add("pcid", lbtn.CommandArgument);
                strURL = "ImaPost.aspx";
                break;
            case "GoCopyP":
                dic.Add("pcid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaPost.aspx";
                break;
            case "GoEditN":
                dic.Add("pfiid", lbtn.CommandArgument);
                strURL = "ImaPeriodic.aspx";
                break;
            case "GoCopyN":
                dic.Add("pfiid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaPeriodic.aspx";
                break;
            case "GoEditK":
                dic.Add("tid", lbtn.CommandArgument);
                strURL = "ImaTesting.aspx";
                break;
            case "GoCopyK":
                dic.Add("tid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaTesting.aspx";
                break;
            case "GoEditH":
                dic.Add("sid", lbtn.CommandArgument);
                strURL = "ImaStandard.aspx";
                break;
            case "GoCopyH":
                dic.Add("sid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaStandard.aspx";
                break;
            case "GoEditJ":
                dic.Add("aid", lbtn.CommandArgument);
                strURL = "ImaApplication.aspx";
                break;
            case "GoCopyJ":
                dic.Add("aid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaApplication.aspx";
                break;
            case "GoEditM":
                dic.Add("ssid", lbtn.CommandArgument);
                strURL = "ImaSampleShipping.aspx";
                break;
            case "GoCopyM":
                dic.Add("ssid", lbtn.CommandArgument);
                dic.Add("copy", "1");
                strURL = "ImaSampleShipping.aspx";
                break;
        }
        Response.Redirect(strURL + GetQueryString(true, dic, null));
    }

    /// <summary>
    /// 下一頁的 Get 參數設定
    /// </summary>
    /// <param name="isClear">是否清除URL的參數</param>
    /// <param name="dicAdd">新增參數</param>
    /// <param name="strRemove">移除參數</param>
    /// <returns>組成QuseryString</returns>
    protected string GetQueryString(bool isClear, Dictionary<string, string> dicAdd, string[] strRemove)
    {
        //預設參數
        Dictionary<string, string> dic = new Dictionary<string, string>();
        if (Request.Params["rid"] != null) { dic.Add("rid", Request.Params["rid"]); }
        if (Request.Params["cid"] != null) { dic.Add("cid", Request.Params["cid"]); }
        if (Request.Params["pid"] != null) { dic.Add("pid", Request.Params["pid"]); }
        dic.Add("categroy", ddlDocCategory.SelectedValue);
        return IMAUtil.SetQueryString(isClear, dic, dicAdd, strRemove);
    }
}