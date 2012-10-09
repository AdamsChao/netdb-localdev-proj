﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaTechTelecom.aspx.cs" Inherits="Ima_ImaTechTelecom" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/MsgBox.ascx" TagName="MsgBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $(function () {
            var ddlTech = $("#<%= ddlTech.ClientID %>");
            getSelect();
            ddlTech.change(function () {
                getSelect();
            });
        });

        function getSelect() {
            var ddlTech = $("#<%= ddlTech.ClientID %>");
            var pl2G = $("#<%= pl2G.ClientID %>");
            var pl3G = $("#<%= pl3G.ClientID %>");
            var pl4G = $("#<%= pl4G.ClientID %>");
            var plCDMA = $("#<%= plCDMA.ClientID %>");
            pl2G.css("display", "none");
            pl3G.css("display", "none");
            pl4G.css("display", "none");
            plCDMA.css("display", "none");
            if (ddlTech.val() == '2G GSM/GPRS/EDGE/EDGE Evolution') { pl2G.css("display", ""); }
            else if (ddlTech.val() == '3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+') { pl3G.css("display", ""); }
            else if (ddlTech.val() == '4G LTE') { pl4G.css("display", ""); }
            else if (ddlTech.val() == 'CDMA') { plCDMA.css("display", ""); }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0">
        <tr>
            <td valign="top" style="width: 270px;">
                <uc1:imatree id="ImaTree1" runat="server" />
            </td>
            <td valign="top" style="padding-left: 30px;">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" cellpadding="2" cellspacing="0" class="tbSearch" align="left" style="margin-bottom: 20px;">
                                <tr>
                                    <td class="tdRowName" valign="top">Country</td>
                                    <td class="tdRowValue" align="left">
                                        <asp:Label ID="lblCountry" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdRowName">Certification Type：</td>
                                    <td class="tdRowValue" align="left">
                                        <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
                                        <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="tdRowName" valign="top">Technology：</td>
                                    <td class="tdRowValue" align="left">
                                        <asp:DropDownList ID="ddlTech" runat="server">
                                            <asp:ListItem Text="2G GSM/GPRS/EDGE/EDGE Evolution" Value="2G GSM/GPRS/EDGE/EDGE Evolution"></asp:ListItem>
                                            <asp:ListItem Text="3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+" Value="3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+"></asp:ListItem>
                                            <asp:ListItem Text="4G LTE" Value="4G LTE"></asp:ListItem>
                                            <asp:ListItem Text="cdmaOne/CDMA2000" Value="CDMA"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- 2G--%>
                            <asp:Panel ID="pl2G" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">
                                            2G GSM/GPRS/EDGE/EDGE Evolution Edit
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            <table cellpadding="0" cellspacing="0" border="0" align="left">
                                                <tr>
                                                    <td>
                                                        North America：850-1900 MHz
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Europe：900-1800 MHz
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Power Limit：850,900：33dBm；900,1800：30dBm
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                            UL
                                        </td>
                                        <td class="tdRowName1">
                                            DL
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA1" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF1" runat="server" Text="T-GSM-380"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL1" runat="server" Text="380.2-389.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL1" runat="server" Text="390.2-399.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA2" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF2" runat="server" Text="T-GSM-410"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL2" runat="server" Text="410.2-419.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL2" runat="server" Text="420.2-429.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA3" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF3" runat="server" Text="GSM-450"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL3" runat="server" Text="450.4-457.6 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL3" runat="server" Text="460.4-467.6 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA4" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF4" runat="server" Text="GSM-480"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL4" runat="server" Text="479.0-486.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL4" runat="server" Text="489.0-496.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA5" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF5" runat="server" Text="GSM-710"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL5" runat="server" Text="698.0-716.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL5" runat="server" Text="728.0-746.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA6" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF6" runat="server" Text="GSM-750"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL6" runat="server" Text="747.0-762.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL6" runat="server" Text="777.0-792.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA7" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF7" runat="server" Text="T-GSM-810"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL7" runat="server" Text="806.0-821.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL7" runat="server" Text="851.0-866.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA8" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF8" runat="server" Text="GSM-850"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL8" runat="server" Text="824.0-849.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL8" runat="server" Text="869.0-894.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA9" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF9" runat="server" Text="P-GSM-900"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL9" runat="server" Text="890.2-914.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL9" runat="server" Text="935.2-959.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA10" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF10" runat="server" Text="E-GSM-900"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL10" runat="server" Text="880.0-914.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL10" runat="server" Text="925.2-959.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA11" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF11" runat="server" Text="R-GSM-900"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL11" runat="server" Text="876.0-914.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL11" runat="server" Text="921.0-959.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA12" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF12" runat="server" Text="T-GSM-900"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL12" runat="server" Text="870.4-876.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL12" runat="server" Text="915.4-921.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA13" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF13" runat="server" Text="DCS-1800"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL13" runat="server" Text="1710.2-1784.8 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL13" runat="server" Text="1805.2-1879.8 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb2GANA14" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GF14" runat="server" Text="PCS-1900"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GUL14" runat="server" Text="1850.0-1910.0 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl2GDL14" runat="server" Text="1930.0-1990.0 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1" colspan="4">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td style="width: 50px;">Remark：</td>
                                                    <td align="left"><asp:TextBox ID="tb2GRemark" runat="server" TextMode="MultiLine" Rows="3" Width="96%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="up2G" runat="server">
                                                <ContentTemplate>
                                                    <uc2:msgbox id="mbMsg2G" runat="server" />
                                                    <asp:Button ID="btn2GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn2GCancel" runat="server" Text="Cancel/Back" CausesValidation="false"
                                                        OnClick="btnCancel_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- 3G--%>
                            <asp:Panel ID="pl3G" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">
                                            3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+ Edit
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            Power Limit：24dBm,class 3
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                            UL
                                        </td>
                                        <td class="tdRowName1">
                                            DL
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA1" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF1" runat="server" Text="Band1"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL1" runat="server" Text="1920-1980 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL1" runat="server" Text="2110-2170 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA2" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF2" runat="server" Text="Band2"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL2" runat="server" Text="1850-1910 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL2" runat="server" Text="1930-1990 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA3" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF3" runat="server" Text="Band3"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL3" runat="server" Text="1710-1785 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL3" runat="server" Text="1805-1880 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA4" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF4" runat="server" Text="Band4"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL4" runat="server" Text="1710-1755 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL4" runat="server" Text="2110-2155 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA5" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF5" runat="server" Text="Band5"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL5" runat="server" Text="824-849 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL5" runat="server" Text="869-894 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA6" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF6" runat="server" Text="Band6"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL6" runat="server" Text="830-840 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL6" runat="server" Text="875-885 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA7" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF7" runat="server" Text="Band7"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL7" runat="server" Text="2500-2570 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL7" runat="server" Text="2620-2690 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA8" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF8" runat="server" Text="Band8"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL8" runat="server" Text="880-915 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL8" runat="server" Text="925-960 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA9" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF9" runat="server" Text="Band9"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL9" runat="server" Text="1749.9-1784.9 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL9" runat="server" Text="1844.9-1879.9 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA10" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF10" runat="server" Text="Band10"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL10" runat="server" Text="1710-1770 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL10" runat="server" Text="2110-2170 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA11" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF11" runat="server" Text="Band11"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL11" runat="server" Text="1427.9-1452.9 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL11" runat="server" Text="1475.9-1500.9 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA12" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF12" runat="server" Text="Band12"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL12" runat="server" Text="698-716 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL12" runat="server" Text="728-746 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA13" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF13" runat="server" Text="Band13"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL13" runat="server" Text="777-787 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL13" runat="server" Text="746-756 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA14" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF14" runat="server" Text="Band14"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL14" runat="server" Text="788-798 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL14" runat="server" Text="758-768 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA15" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF15" runat="server" Text="Band19"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL15" runat="server" Text="830-845 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL15" runat="server" Text="875-890 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA16" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF16" runat="server" Text="Band20"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL16" runat="server" Text="832-862 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL16" runat="server" Text="791-821 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb3GANA17" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GF17" runat="server" Text="Band21"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GUL17" runat="server" Text="1447.9-1462.9 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl3GDL17" runat="server" Text="1495.9-1510.9 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1" colspan="4">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td style="width: 50px;">Remark：</td>
                                                    <td align="left"><asp:TextBox ID="tb3GRemark" runat="server" TextMode="MultiLine" Rows="3" Width="96%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="up3G" runat="server">
                                                <ContentTemplate>
                                                    <uc2:msgbox id="mbMsg3G" runat="server" />
                                                    <asp:Button ID="btn3GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn3GCancel" runat="server" Text="Cancel/Back" CausesValidation="false"
                                                        OnClick="btnCancel_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- 4G--%>
                            <asp:Panel ID="pl4G" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">
                                            4G LTE Edit
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            Power Limit：24dBm,class 3
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                        </td>
                                        <td class="tdRowName1">
                                            UL
                                        </td>
                                        <td class="tdRowName1">
                                            DL
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA1" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF1" runat="server" Text="Band17"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL1" runat="server" Text="704-716 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL1" runat="server" Text="734-746 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA2" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF2" runat="server" Text="Band18"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL2" runat="server" Text="815-830 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL2" runat="server" Text="860-875 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA3" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF3" runat="server" Text="Band24"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL3" runat="server" Text="1626.5-1660.5 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL3" runat="server" Text="1525-1559 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA4" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF4" runat="server" Text="Band33"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL4" runat="server" Text="1900-1920 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL4" runat="server" Text="1900-1920 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA5" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF5" runat="server" Text="Band34"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL5" runat="server" Text="2010-2025 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL5" runat="server" Text="2010-2025 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA6" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF6" runat="server" Text="Band35"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL6" runat="server" Text="1850-1910 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL6" runat="server" Text="1850-1910 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA7" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF7" runat="server" Text="Band36"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL7" runat="server" Text="1930-1990 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL7" runat="server" Text="1930-1990 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA8" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF8" runat="server" Text="Band37"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL8" runat="server" Text="1910-1930 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL8" runat="server" Text="1910-1930 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA9" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF9" runat="server" Text="Band38"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL9" runat="server" Text="2570-2620 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL9" runat="server" Text="2570-2620 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA10" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF10" runat="server" Text="Band39"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL10" runat="server" Text="1880-1920 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL10" runat="server" Text="1880-1920 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA11" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF11" runat="server" Text="Band40"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL11" runat="server" Text="2300-2400 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL11" runat="server" Text="2300-2400 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA12" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF12" runat="server" Text="Band41"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL12" runat="server" Text="2496-2690 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL12" runat="server" Text="2496-2690 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA13" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF13" runat="server" Text="Band42"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL13" runat="server" Text="3400-3600 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL13" runat="server" Text="3400-3600 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cb4GANA14" runat="server" />
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GF14" runat="server" Text="Band43"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GUL14" runat="server" Text="3600-3800 MHz(FDD)"></asp:Label>
                                        </td>
                                        <td class="tdRowValue1">
                                            <asp:Label ID="lbl4GDL14" runat="server" Text="3600-3800 MHz(FDD)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1" colspan="4">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td style="width: 50px;">Remark：</td>
                                                    <td align="left"><asp:TextBox ID="tb4GRemark" runat="server" TextMode="MultiLine" Rows="3" Width="96%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="up4G" runat="server">
                                                <ContentTemplate>
                                                    <uc2:msgbox id="mbMsg4G" runat="server" />
                                                    <asp:Button ID="btn4GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn4GCancel" runat="server" Text="Cancel/Back" CausesValidation="false"
                                                        OnClick="btnCancel_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- CDMA--%>
                            <asp:Panel ID="plCDMA" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">
                                            cdmaOne/CDMA2000 Edit
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            cdmaOne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Power Limit：24dBm
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA1" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF1" runat="server" Text="824-849 MHz(MS Tx：US,Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA2" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF2" runat="server" Text="869-894 MHz(BS Tx：US,Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA3" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF3" runat="server" Text="887-925 MHz(MS Tx：Japan)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA4" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF4" runat="server" Text="832-870 MHz(BS Tx：Japan)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA5" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF5" runat="server" Text="1850-1910 MHz(MS Tx：US)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA6" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF6" runat="server" Text="1930-1990 MHz(BS Tx：US)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA7" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF7" runat="server" Text="1750-1780 MHz(MS Tx：Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMAOneANA8" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF8" runat="server" Text="1840-1870 MHz(BS Tx：Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            CDMA2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power
                                            Limit：24dBm
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA1" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F1" runat="server" Text="410-430 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA2" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F2" runat="server" Text="450-470 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA3" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F3" runat="server" Text="824-849 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA4" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F4" runat="server" Text="869-894 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA5" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F5" runat="server" Text="1710-1755 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA6" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F6" runat="server" Text="2110-2155 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA7" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F7" runat="server" Text="1850-1910 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA8" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F8" runat="server" Text="1930-1990 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA9" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F9" runat="server" Text="1920-1980 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1">
                                            <asp:CheckBox ID="cbCDMA2000ANA10" runat="server" />
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F10" runat="server" Text="2110-2170 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1" colspan="2">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td style="width: 50px;">Remark：</td>
                                                    <td align="left"><asp:TextBox ID="tbCDMRemark" runat="server" TextMode="MultiLine" Rows="3" Width="96%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upCDMA" runat="server">
                                                <ContentTemplate>
                                                    <uc2:msgbox id="mbMsgCDMA" runat="server" />
                                                    <asp:Button ID="btnCDMASave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnCDMACancel" runat="server" Text="Cancel/Back" CausesValidation="false"
                                                        OnClick="btnCancel_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

