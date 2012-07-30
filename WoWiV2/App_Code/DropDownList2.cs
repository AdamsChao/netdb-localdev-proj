using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for DropDownList2
/// </summary>
namespace NETDB.UI.WebControls
{
    public class DropDownList2 : DropDownList
    {
        protected override void PerformDataBinding(System.Collections.IEnumerable dataSource)
        {
            // 過濾掉 DropDownList 在 DataBinding 時可能會發生的 Exception 問題！
            // 如果 Exception 發生，預設會選取第一個下拉選項！
            try
            {
                base.PerformDataBinding(dataSource);
            }
            catch (ArgumentOutOfRangeException ex)
            {
                ArgumentOutOfRangeException o = ex;
            }
        }
    }
}