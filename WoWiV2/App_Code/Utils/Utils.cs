using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web.SessionState;
using System.IO;

/// <summary>
/// Summary description for Utils
/// </summary>
public class Utils
{
    public static String Key_Session_AddContacts_ID = "Add_Contacts_ID";
    public static String Key_Session_AddContacts_BackURL = "Add_Contacts_BackURL";
    public static String Key_Session_New_Contact = "New_Contact";
	public Utils()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void Message_Load(Label lbl, StateBag ViewState,String Key)
    {
        if (ViewState[Key] != null)
        {
            lbl.Text = (String)ViewState[Key];
        }
        ViewState.Remove(Key);
    }

    public static void SetTextBoxValue(FormView fv, String ID, String value)
    {
        TextBox tb = (TextBox)fv.FindControl(ID);
        tb.Text = value;
    }

    public static String GetTextBoxValue(FormView fv, String ID)
    {
        TextBox tb = (TextBox)fv.FindControl(ID);
        return tb.Text; 
    }

    public static void SetDropDownListValue(FormView fv, String ID, String value)
    {
        DropDownList dl = (DropDownList)fv.FindControl(ID);
        dl.SelectedValue = value;
    }

    public static String GetDropDownListSelectedValue(FormView fv, String ID)
    {
        DropDownList dl = (DropDownList)fv.FindControl(ID);
        return dl.SelectedValue ;
    }

    public static void MoveItems(ListBox from, ListBox to)
    {
        foreach (ListItem item in from.Items)
        {
            if (item.Selected)
            {
                item.Selected = false;
                to.Items.Add(item);
            }
        }
        foreach (ListItem item in to.Items)
        {
            if (from.Items.Contains(item))
            {
                from.Items.Remove(item);
            }
        }
    }

    public static void StoreSelectedItemsInSession(ListBox lb,HttpSessionState Session, String Key)
    {
        List<ListItem> list = new List<ListItem>();
        foreach (ListItem item in lb.Items)
        {
            list.Add(item);
        }
        Session[Key] = list;
    }
    public static void StoreSelectedItemsInViewState(ListBox lb, StateBag ViewState, String Key)
    {
        List<ListItem> list = new List<ListItem>();
        foreach (ListItem item in lb.Items)
        {
            list.Add(item);
        }
        ViewState[Key] = list;
    }

    public static void SetCheckBoxListValues(int id, FormView FormView1, String dlID)
    {
        SetCheckBoxListValues(id + "", FormView1, dlID);
    }

    public static void SetCheckBoxListValues(String id, FormView FormView1, String dlID)
    {
        CheckBoxList list = (CheckBoxList)FormView1.FindControl(dlID);
        foreach (ListItem item in list.Items)
        {
            if (item.Value == id )
            {
                item.Selected = true;
                break;
            }
        }
    }

    public static void ExportExcel(GridView iGridView1, String filrName)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filrName + "_" + DateTime.Now.ToString("yyyyMMddHH") + ".xls");
        //HttpContext.Current.Response.Charset = "utf-8";
        HttpContext.Current.Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        iGridView1.RenderControl(htmlWrite);
        //Appendg CSS file
        FileInfo fi = new FileInfo(HttpContext.Current.Server.MapPath("~/styles/SiteMaster.css"));
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        StreamReader sr  = fi.OpenText();
        while(sr.Peek()>=0){
             sb.Append(sr.ReadLine());
        }
        sr.Close();

        HttpContext.Current.Response.Write("<html><head><style type='text/css'>" + sb.ToString() + "</style><head>" + stringWrite.ToString() + "</html>");
        //HttpContext.Current.Response.Write(stringWrite.ToString());
        HttpContext.Current.Response.End();

    }
}

public delegate void CustomLogic();

