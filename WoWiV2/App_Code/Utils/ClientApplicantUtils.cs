using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using AjaxControlToolkit;

/// <summary>
/// Summary description for ContactUtild
/// </summary>
public class ClientApplicantUtils
{
    public static String Key_ViewState_Industry = "ClientApplican_Industry";
    public static String Key_ViewState_Technologies = "ClientApplican_Technologies";
    public static String Name_CheckBox_IndustryList = "clIndustryList";
    public static String Name_CheckBox_TechnologyList = "clTechnologyList";
    //public static String Name_DropdownList_IndustryList = "dlIndustryList";;
    //public static String Key_ViewState_UpdateMessage = "Update_Message";
    //public static String Value_ViewState_UpdateMessage = "Update vender information successfully.";
    //public static String Key_ViewState_InsertMessage = "Insert_Message";
    //public static String Value_ViewState_InsertMessage = "Insert a vender information successfully.";
    //public static String Key_Session_InsertContacts = "Vender_Insert_Contact";
    //public static String Key_ViewState_InsertContacts = "Vender_Insert_Contact";
    //public static String Key_Session_VenderState = "Vender_State";
    public static void InitIndustryData(int id, FormView FormView1, String dlID)
    {
        try
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    var typeList = from c in db.m_clientappliant_industry where c.clientappliant_id == id select c;
                    foreach (WoWiModel.m_clientappliant_industry item in typeList)
                    {
                        SetTypes(item.industry_id, FormView1, dlID);
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }
        catch
        {
        }
    }

    public static void InitTechnologyData(int id, FormView FormView1, String dlID)
    {
        try
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    var typeList = from c in db.m_clientappliant_technology where c.clientappliant_id == id select c;
                    foreach (WoWiModel.m_clientappliant_technology item in typeList)
                    {
                        SetTypes(item.technology_id, FormView1, dlID);
                    }
                }
                catch (Exception ex)
                {
                }
            }
        }
        catch
        {
        }
    }
    public static void SetTypes(int id, FormView FormView1, String dlID)
    {

        CheckBoxList list = (CheckBoxList)FormView1.FindControl(dlID);
        foreach (ListItem item in list.Items)
        {
            if (item.Value == id + "")
            {
                item.Selected = true;
                break;
            }
        }
    }

    public static void StoreDatasInViewState(FormView fv, String ID, StateBag ViewState, String ViewStateKey)
    {
        List<int> roles = new List<int>();
        CheckBoxList list = (CheckBoxList)fv.FindControl(ID);
        foreach (ListItem item in list.Items)
        {
            if (item.Selected)
            {
                roles.Add(int.Parse(item.Value));
            }
        }
        ViewState[ViewStateKey] = roles;

    }
}