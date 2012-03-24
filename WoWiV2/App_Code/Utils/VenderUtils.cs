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
public class VenderUtils
{
    public static String Name_CheckBox_VenderTypeList = "clVenderTypeList";
    public static String Name_DropdownList_VenderList = "dlVenderList";
    public static String Key_ViewState_VenderTypes = "VenderTypes";
    public static String Key_ViewState_UpdateMessage = "Update_Message";
    public static String Value_ViewState_UpdateMessage = "Update vender information successfully.";
    public static String Key_ViewState_InsertMessage = "Insert_Message";
    public static String Value_ViewState_InsertMessage = "Insert a vender information successfully.";
    public static String Key_Session_InsertContacts = "Vender_Insert_Contact";
    public static String Key_ViewState_InsertContacts = "Vender_Insert_Contact";
    public static String Key_Session_VenderState = "Vender_State";

    public static String GetPaymentType(String pID)
    {
        String ret = "Not set yet";
        switch (pID)
        {
            case "0":
                ret = "支票";
                break;
            case "1":
                ret = "國內匯款";
                break;
            case "2":
                ret = "匯票";
                break;
            case "3":
                ret = "信用卡";
                break;
            case "4":
                ret = "現金";
                break;
            case "5":
                ret = "西聯匯款";
                break;
            case "6":
                ret = "國外匯款";
                break;
        }
        return ret;
    }
    public static void InitVenderTypes(int id, FormView FormView1,String dlID)
    {
        try
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    var typeList = from c in db.m_vender_type where c.vender_id == id select c;
                    foreach (WoWiModel.m_vender_type item in typeList)
                    {
                        SetVenderTypes(item.vender_type_id, FormView1, dlID);
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
    public static void SetVenderTypes(int id, FormView FormView1, String dlID)
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

    public static void StoreVenderTypesInViewState(FormView fv, String ID,StateBag ViewState,String ViewStateKey)
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