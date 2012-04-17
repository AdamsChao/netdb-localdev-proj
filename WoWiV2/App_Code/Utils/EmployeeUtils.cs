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
public class EmployeeUtils
{
    public static String Key_ViewState_AccessLevel = "Employee_AccessLevel";
    public static String Name_CheckBox_AccessLevel = "clAccessLevel";

    public static void InitAccessLevel(int id, FormView FormView1, String dlID)
    {
        try
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    var typeList = from c in db.m_employee_accesslevel where c.employee_id== id select c;
                    foreach (WoWiModel.m_employee_accesslevel item in typeList)
                    {
                        SetTypes(item.accesslevel_id, FormView1, dlID);
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

    public static Object GetEmployeeList(WoWiModel.WoWiEntities db)
    {
        var list = from e in db.employees where e.status == "Active"  select new { id = e.id, name = String.IsNullOrEmpty(e.fname) ? e.c_lname + " " + e.c_fname : e.fname + " " + e.lname };
        return list;
    }
}