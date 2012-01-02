<%@ Page Title="首頁" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="Home.aspx.cs" Inherits="Home" Culture="en-US" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td height="30">
                    <img alt="WoWi Approval Service, Inc. " height="22" 
                        src="http://www.wowiapproval.com/images/p1-about/icon-WoWi_Approval.gif" 
                        width="245" /></td>
            </tr>
            <tr>
                <td>
                    <table align="right" border="0" cellpadding="0" cellspacing="0" width="97%">
                        <tr>
                            <td>
                                Found in 2009, WoWi’s goal is to go beyond what we already offer to providing 
                                approval services world-wide.</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="40" valign="bottom">
                    <img alt="Product Types :" height="17" 
                        src="http://www.wowiapproval.com/images/p1-about/icon-product.gif" width="99" /></td>
            </tr>
            <tr>
                <td>
                    <table align="right" border="0" cellpadding="0" cellspacing="0" width="97%">
                        <tr>
                            <td>
                                Radio/Wireless - Low Power and Short Range Devices</td>
                        </tr>
                        <tr>
                            <td>
                                Radio/Wireless - Unlicensed and Licensed Devices</td>
                        </tr>
                        <tr>
                            <td>
                                Safety - ITE/ Digital Devices</td>
                        </tr>
                        <tr>
                            <td>
                                EMC- ITE / Digital Devices</td>
                        </tr>
                        <tr>
                            <td>
                                Wired Telecommunication Devices</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </p>
    <p>
        <asp:Calendar ID="Calendar1" runat="server" Width="100%" 
            NextPrevFormat="ShortMonth" ></asp:Calendar>
    </p>
</asp:Content>
