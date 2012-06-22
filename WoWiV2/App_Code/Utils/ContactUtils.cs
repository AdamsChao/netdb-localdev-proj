using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;

/// <summary>
/// Summary description for ContactUtild
/// </summary>
public class ContactUtils
{
    public static String Name_CheckBox_RoleList = "clRoleList";
    public static String Name_DropdownList_RoleList = "dlContactList";
    public static String IMA_Name_DropdownList_RoleList = "dlIMAContactList";
    public static String Key_ViewState_Roles = "Roles";
    public static String Key_ViewState_UpdateMessage = "Update_Message";
    public static String Value_ViewState_UpdateMessage = "Update contact information successfully.";
    public static String Key_ViewState_InsertMessage = "Insert_Message";
    public static String Value_ViewState_InsertMessage = "Insert a contact information successfully.";
    public static void InitRoles(int id, FormView FormView1,String dlID)
    {
        try
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    var roleList = from c in db.m_contact_role where c.contact_id == id select c;
                    foreach (WoWiModel.m_contact_role item in roleList)
                    {
                        Utils.SetCheckBoxListValues(item.role_id, FormView1, dlID);
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
    

    public static void StoreRolesInViewState(FormView fv, String ID,StateBag ViewState,String ViewStateKey)
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