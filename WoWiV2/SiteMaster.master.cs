using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    SecurityModel.SecurityEntities sm = new SecurityModel.SecurityEntities();
    List<string> ShowMenu = new List<string>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            var results = from am in sm.Access_Menu
                          where am.Username == HttpContext.Current.User.Identity.Name
                          select am;
            foreach (SecurityModel.Access_Menu item in results)
            {
                ShowMenu.Add(item.MenuValuePath);
            }
        }

    }
    protected void NavigationMenu_MenuItemDataBound(object sender, MenuEventArgs e)
    {       
            bool IsShowMenu = false;
            //var results = from am in sm.Access_Menu
            //              where am.Username == HttpContext.Current.User.Identity.Name
            //              select am;
            //foreach (SecurityModel.Access_Menu item in results)
            //{
            //    if (e.Item.ValuePath == item.MenuValuePath)
            //    {
            //        IsShowMenu = true;
            //        break;
            //    }
            //}
            foreach (string MenuValuePath in ShowMenu)
            {
                if (e.Item.ValuePath == MenuValuePath)
                {
                    IsShowMenu = true;
                    break;
                }
            }

            if (IsShowMenu == false)
            {
                if (e.Item.Parent != null)
                {
                    e.Item.Parent.ChildItems.Remove(e.Item);
                }
            }                        
          
    }
}
