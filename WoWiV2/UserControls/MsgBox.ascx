<%@ Control Language="C#" AutoEventWireup="false" CodeFile="MsgBox.ascx.cs" Inherits="UC_MsgBox"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Button ID="btnMsgBox" runat="server" Text="Hidden" CssClass="btnHidden" />
<act:ModalPopupExtender ID="mpeMsgBox" runat="server" TargetControlID="btnMsgBox" PopupControlID="panMsgBox" BackgroundCssClass="mpeBackground" DropShadow="true" CancelControlID="ibtnOK"></act:ModalPopupExtender>
 <center>
    <asp:Panel ID="panMsgBox" runat="server" style="display:none">
        <table cellspacing="0" cellpadding="5" class="tbMsgBox">
            <tr>
                <td class="MsgBoxTitle"><asp:Label ID="lblTitle" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="center">
                    <table width="100%">
                        <tr>
                             <td align="right" style="width:50px"><asp:Image ID="imgIcon" runat="server" ImageUrl="~/images/IMA/MsgBox/info.gif" /></td>
                             <td align="center"><asp:Label ID="lblMsg" runat="server"></asp:Label></td>
                             <td style="width:50px"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:ImageButton id="ibtnOK" runat="server" SkinID="ibtnOK" CausesValidation="false" />
                    <asp:ImageButton id="ibtnGo" runat="server" SkinID="ibtnOK" CausesValidation="false" OnClick="ibtnGo_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</center>
