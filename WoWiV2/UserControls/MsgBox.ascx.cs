using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UC_MsgBox : System.Web.UI.UserControl
{
    public enum Type
    {
        Warming,
        Info
    }

    /// <summary>
    /// 顯示訊息
    /// </summary>
    /// <param name="message">訊息內容</param>
    /// <param name="mbt">訊息類別</param>
    public void Show(string message, Type mbt)
    {
        if (mbt == Type.Warming)
        {
            lblTitle.Text = "警示";
            imgIcon.ImageUrl = "~/images/IMA/MsgBox/warming.gif";
            lblMsg.Text = message;
            ibtnOK.Visible = true;
            ibtnGo.Visible = false;
        }
        else
        {
            lblTitle.Text = "Message";
            imgIcon.ImageUrl = "~/images/IMA/MsgBox/info.gif";
            lblMsg.Text = message;
            ibtnOK.Visible = true;
            ibtnGo.Visible = false;
        }
        mpeMsgBox.Show();
    }

    /// <summary>
    /// 顯示訊息
    /// </summary>
    /// <param name="message">訊息內容</param>
    public void Show(string message)
    {
        lblTitle.Text = "Message";
        imgIcon.ImageUrl = "~/images/IMA/MsgBox/info.gif";
        lblMsg.Text = message;
        ibtnOK.Visible = false;
        ibtnGo.Visible = true;
        mpeMsgBox.CancelControlID = "";
        mpeMsgBox.Show();
    }

    public event ibtnMsgGo_ClickEventHandler ibtnMsgGo_Click;
    public delegate void ibtnMsgGo_ClickEventHandler(object sender, ImageClickEventArgs e);

    protected void ibtnGo_Click(object sender, ImageClickEventArgs e)
    {
        if (ibtnMsgGo_Click != null)
        {
            ibtnMsgGo_Click(sender, e);
        }
    }

}