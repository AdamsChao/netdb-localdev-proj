<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaTechRF.aspx.cs" Inherits="Ima_ImaTechRF" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/MsgBox.ascx" TagName="MsgBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $(function () {
            var ddlTech = $("#<%= ddlTech.ClientID %>");
            //            var plWiFi = $("#<%= plWiFi.ClientID %>");
            //            var plBluetooth = $("#<%= plBluetooth.ClientID %>");
            //            var plRFID = $("#<%= plRFID.ClientID %>");
            getSelect();
            //            plBluetooth.css("display", "none");
            ddlTech.change(function () {
                getSelect();
                //                plWiFi.css("display", "none");
                //                plBluetooth.css("display", "none");
                //                var selected = $(this).val();
                //                if (selected == 'WiFi') { plWiFi.css("display", ""); }
                //                else if (selected == 'Bluetooth') { plBluetooth.css("display", ""); }


                //alert(selected);
            });

            //            $("#<%= btnWiFiSave.ClientID %>").click(function (event) {
            //                getSelect();
            //            });


        });

        function getSelect() {
            var ddlTech = $("#<%= ddlTech.ClientID %>");
            var plWiFi = $("#<%= plWiFi.ClientID %>");
            var plBluetooth = $("#<%= plBluetooth.ClientID %>");
            var plRFID = $("#<%= plRFID.ClientID %>");
            var plFMTransmitter = $("#<%= plFMTransmitter.ClientID %>");
            var plBelow1GSRD = $("#<%= plBelow1GSRD.ClientID %>");
            var plAbove1GSRD = $("#<%= plAbove1GSRD.ClientID %>");
            var plZigbee = $("#<%= plZigbee.ClientID %>");
            var plUWB = $("#<%= plUWB.ClientID %>");
            var pl2G = $("#<%= pl2G.ClientID %>");
            var pl3G = $("#<%= pl3G.ClientID %>");
            var pl4G = $("#<%= pl4G.ClientID %>");
            var plCDMA = $("#<%= plCDMA.ClientID %>");
            var plWirelessHD60 = $("#<%= plWirelessHD60.ClientID %>");
            plWiFi.css("display", "none");
            plBluetooth.css("display", "none");
            plRFID.css("display", "none");
            plFMTransmitter.css("display", "none");
            plBelow1GSRD.css("display", "none");
            plAbove1GSRD.css("display", "none");
            plZigbee.css("display", "none");
            plUWB.css("display", "none");
            pl2G.css("display", "none");
            pl3G.css("display", "none");
            pl4G.css("display", "none");
            plCDMA.css("display", "none");
            plWirelessHD60.css("display", "none");
            if (ddlTech.val() == 'WiFi') { plWiFi.css("display", ""); }
            else if (ddlTech.val() == 'Bluetooth') { plBluetooth.css("display", ""); }
            else if (ddlTech.val() == 'RFID') { plRFID.css("display", ""); }
            else if (ddlTech.val() == 'FM Transmitter') { plFMTransmitter.css("display", ""); }
            else if (ddlTech.val() == 'Below 1GHz SRD') { plBelow1GSRD.css("display", ""); }
            else if (ddlTech.val() == 'Above 1GHz SRD') { plAbove1GSRD.css("display", ""); }
            else if (ddlTech.val() == 'Zigbee') { plZigbee.css("display", ""); }
            else if (ddlTech.val() == 'UWB') { plUWB.css("display", ""); }
            else if (ddlTech.val() == '2G GSM/GPRS/EDGE/EDGE Evolution') { pl2G.css("display", ""); }
            else if (ddlTech.val() == '3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+') { pl3G.css("display", ""); }
            else if (ddlTech.val() == '4G LTE') { pl4G.css("display", ""); }
            else if (ddlTech.val() == 'CDMA') { plCDMA.css("display", ""); }
            else if (ddlTech.val() == 'Wireless HD 60GHz') { plWirelessHD60.css("display", ""); }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0">
        <tr>
            <td valign="top" style="width:270px;">
                <uc1:ImaTree ID="ImaTree1" runat="server" />
            </td>
            <td valign="top" style="padding-left: 30px;">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <table border="0" cellpadding="2" cellspacing="0" class="tbSearch" align="left" style="margin-bottom: 20px;">
                                <tr>
                                    <td class="tdRowName" valign="top">Country：</td>
                                    <td class="tdRowValue" align="left"><asp:Label ID="lblCountry" runat="server"></asp:Label></td>
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
                                            <asp:ListItem Text="WiFi" Value="WiFi"></asp:ListItem>
                                            <asp:ListItem Text="Bluetooth" Value="Bluetooth"></asp:ListItem>
                                            <asp:ListItem Text="RFID" Value="RFID"></asp:ListItem>
                                            <asp:ListItem Text="FM Transmitter" Value="FM Transmitter"></asp:ListItem>
                                            <asp:ListItem Text="Below 1GHz SRD" Value="Below 1GHz SRD"></asp:ListItem>
                                            <asp:ListItem Text="Above 1GHz SRD" Value="Above 1GHz SRD"></asp:ListItem>
                                            <asp:ListItem Text="Zigbee" Value="Zigbee"></asp:ListItem>
                                            <asp:ListItem Text="UWB" Value="UWB"></asp:ListItem>
                                            <asp:ListItem Text="2G GSM/GPRS/EDGE/EDGE Evolution" Value="2G GSM/GPRS/EDGE/EDGE Evolution"></asp:ListItem>
                                            <asp:ListItem Text="3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+" Value="3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+"></asp:ListItem>
                                            <asp:ListItem Text="4G LTE" Value="4G LTE"></asp:ListItem>
                                            <asp:ListItem Text="cdmaOne/CDMA2000" Value="CDMA"></asp:ListItem>
                                            <asp:ListItem Text="Wireless HD 60GHz" Value="Wireless HD 60GHz"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- WiFi--%>
                            <asp:Panel ID="plWiFi" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="7" class="tdHeader">WiFi Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF2" runat="server" Text="5150-5250 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF3" runat="server" Text="5250-5350 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF4" runat="server" Text="5470-5725 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF5" runat="server" Text="5725-5825 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF6" runat="server" Text="5825-5850 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA3" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN3" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA4" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN4" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA5" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN5" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANA6" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbWiFiANAN6" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL4" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL5" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbWiFiPL6" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Indoor/Outdoor allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA1" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA1" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA2" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA2" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA3" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA3" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA4" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA4" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA5" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA5" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiIDA6" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWiFiODA6" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">HT20/HT40/HT80/HT160</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT201" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT401" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT801" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1601" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT202" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT402" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT802" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1602" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT203" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT403" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT803" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1603" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT204" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT404" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT804" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1604" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT4" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT205" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT405" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT805" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1605" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT5" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT206" runat="server" Text="HT20" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT406" runat="server" Text="HT40" /></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiHT806" runat="server" Text="HT80" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiHT1606" runat="server" Text="HT160" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiHT6" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">DFS/TPC</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS1" runat="server" Text="DFS" Visible="false" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC1" runat="server" Text="TPC" Visible="false" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS2" runat="server" Text="DFS" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC2" runat="server" Text="TPC" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS3" runat="server" Text="DFS" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC3" runat="server" Text="TPC" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS4" runat="server" Text="DFS" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC4" runat="server" Text="TPC" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS4" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS5" runat="server" Text="DFS" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC5" runat="server" Text="TPC" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS5" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td><asp:CheckBox ID="cbWiFiDFS6" runat="server" Text="DFS" /></td>
                                                    <td><asp:CheckBox ID="cbWiFiTPC6" runat="server" Text="TPC" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2"><asp:TextBox ID="tbWiFiDFS6" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="6" class="tdRowValue">
                                            <asp:TextBox ID="tbWiFiRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upWiFi" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgWiFi" runat="server" />
                                                    <asp:Button ID="btnWiFiSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnWiFiCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- Bluetooth--%>
                            <asp:Panel ID="plBluetooth" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Bluetooth Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblBluetoothF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:TextBox ID="tbBluetoothPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue">
                                            <asp:CheckBox ID="cbBluetoothANA1" runat="server" Text="Allowed" />
                                            <asp:CheckBox ID="cbBluetoothANAN1" runat="server" Text="Not Allowed" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td class="tdRowValue">
                                            <asp:TextBox ID="tbBluetoothRemark" runat="server" TextMode="MultiLine" Rows="2" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upBluetooth" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgBluetooth" runat="server" />
                                                    <asp:Button ID="btnBluetoothSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnBluetoothCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- RFID--%>
                            <asp:Panel ID="plRFID" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="9" class="tdHeader">RFID Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF1" runat="server" Text="120-150 KHZ"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF2" runat="server" Text="13.56 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF3" runat="server" Text="433 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF4" runat="server" Text="868-870 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF5" runat="server" Text="902-928 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF6" runat="server" Text="2400-2500 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF7" runat="server" Text="2450-5800 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblRFIDF8" runat="server" Text="5725-5875 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL1" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL2" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL3" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL4" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL5" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL6" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL7" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbRFIDPL8" runat="server" Width="100px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA3" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN3" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA4" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN4" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA5" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN5" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA6" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN6" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA7" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN7" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANA8" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbRFIDANAN8" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="8" class="tdRowValue">
                                            <asp:TextBox ID="tbRFIDRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="9" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upRFID" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgRFID" runat="server" />
                                                    <asp:Button ID="btnRFIDSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnRFIDCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- FM Transmitter--%>
                            <asp:Panel ID="plFMTransmitter" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="2" class="tdHeader">FM Transmitter Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1">
                                            <table border="0" align="center" >
                                                <tr>
                                                    <td><asp:Label ID="lblFMTransmitterF1" runat="server" Text="88-108 MHz"></asp:Label></td>
                                                    <td><asp:TextBox ID="tbFMTransmitterFDesc1" runat="server" Width="200px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:TextBox ID="tbFMTransmitterPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue">
                                            <asp:CheckBox ID="cbFMTransmitterANA1" runat="server" Text="Allowed" />
                                            <asp:CheckBox ID="cbFMTransmitterANAN1" runat="server" Text="Not Allowed" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td class="tdRowValue">
                                            <asp:TextBox ID="tbFMTransmitterRemark" runat="server" TextMode="MultiLine" Rows="2" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upFMTransmitter" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgFMTransmitter" runat="server" />
                                                    <asp:Button ID="btnFMTransmitterSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnFMTransmitterCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- Below 1GHz SRD--%>
                            <asp:Panel ID="plBelow1GSRD" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="5" class="tdHeader">Below 1GHz SRD Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF1" runat="server" Text="13.56 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF2" runat="server" Text="88-108 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF3" runat="server" Text="300/400/800 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF4" runat="server" Text="900 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbBelow1GSRDPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbBelow1GSRDPL2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbBelow1GSRDPL3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbBelow1GSRDPL4" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANA3" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANAN3" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANA4" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbBelow1GSRDANAN4" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="4" class="tdRowValue">
                                            <asp:TextBox ID="tbBelow1GSRDRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upBelow1GSRD" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgBelow1GSRD" runat="server" />
                                                    <asp:Button ID="btnBelow1GSRDSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnBelow1GSRDCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- Above 1G SRD--%>
                            <asp:Panel ID="plAbove1GSRD" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="3" class="tdHeader">Above 1GHz SRD Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1">
                                            <table border="0" align="center">
                                                <tr>
                                                    <td><asp:Label ID="lblAbove1GSRDF1" runat="server" Text="2.4 GHz"></asp:Label></td>
                                                    <td><asp:TextBox ID="tbAbove1GSRDFDesc1" runat="server" Width="200px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowName1">
                                            <table border="0" align="center">
                                                <tr>
                                                    <td><asp:Label ID="lblAbove1GSRDF2" runat="server" Text="5 GHz"></asp:Label></td>
                                                    <td><asp:TextBox ID="tbAbove1GSRDFDesc2" runat="server" Width="200px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbAbove1GSRDPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbAbove1GSRDPL2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbAbove1GSRDANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbAbove1GSRDANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbAbove1GSRDANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbAbove1GSRDANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="2" class="tdRowValue">
                                            <asp:TextBox ID="tbAbove1GSRDRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upAbove1GSRD" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgAbove1GSRD" runat="server" />
                                                    <asp:Button ID="btnAbove1GSRDSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnAbove1GSRDCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- Zigbee--%>
                            <asp:Panel ID="plZigbee" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="4" class="tdHeader">Zigbee Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblZigbeeF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblZigbeeF2" runat="server" Text="898 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblZigbeeF3" runat="server" Text="915 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbZigbeePL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbZigbeePL2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbZigbeePL3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANA3" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbZigbeeANAN3" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="3" class="tdRowValue">
                                            <asp:TextBox ID="tbZigbeeRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upZigbee" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgZigbee" runat="server" />
                                                    <asp:Button ID="btnZigbeeSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnZigbeeCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- UWB--%>
                            <asp:Panel ID="plUWB" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="15" class="tdHeader">UWB Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF1" runat="server" Text="3168-3696 MHz"></asp:Label><br />(Band#1)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF2" runat="server" Text="3696-4224 MHz"></asp:Label><br />(Band#2)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF3" runat="server" Text="4224-4752 MHz"></asp:Label><br />(Band#3)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF4" runat="server" Text="4752-5280 MHz"></asp:Label><br />(Band#4)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF5" runat="server" Text="5280-5808 MHz"></asp:Label><br />(Band#5)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF6" runat="server" Text="5808-6336 MHz"></asp:Label><br />(Band#6)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF7" runat="server" Text="6336-6864 MHz"></asp:Label><br />(Band#7)</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL2" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL3" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL4" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL5" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL6" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL7" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA1" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN1" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA2" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN2" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA3" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN3" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA4" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN4" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA5" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN5" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA6" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN6" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA7" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN7" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="15" style="height:1px;"></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF8" runat="server" Text="6864-7392 MHz"></asp:Label><br />(Band#8)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF9" runat="server" Text="7392-7920 MHz"></asp:Label><br />(Band#9)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF10" runat="server" Text="7920-8448 MHz"></asp:Label><br />(Band#10)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF11" runat="server" Text="8448-8976 MHz"></asp:Label><br />(Band#11)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF12" runat="server" Text="8976-9504 MHz"></asp:Label><br />(Band#12)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF13" runat="server" Text="9504-10032 MHz"></asp:Label><br />(Band#13)</td>
                                        <td class="tdRowName1"><asp:Label ID="lblUWBF14" runat="server" Text="10032-10560 MHz"></asp:Label><br />(Band#14)</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL8" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL9" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL10" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL11" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL12" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL13" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                        <td class="tdRowValue1"><asp:TextBox ID="tbUWBPL14" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA8" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN8" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA9" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN9" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA10" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN10" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA11" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN11" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA12" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN12" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA13" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN13" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANA14" runat="server" Text="Allowed" /></td></tr>
                                                <tr><td align="left"><asp:CheckBox ID="cbUWBANAN14" runat="server" Text="Not Allowed" /></td></tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="14" class="tdRowValue">
                                            <asp:TextBox ID="tbUWBRemark" runat="server" TextMode="MultiLine" Rows="2" Width="96%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="15" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upUWB" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgUWB" runat="server" />
                                                    <asp:Button ID="btnUWBSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnUWBCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- 2G--%>
                            <asp:Panel ID="pl2G" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">2G GSM/GPRS/EDGE/EDGE Evolution Edit</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">
                                            <table cellpadding="0" cellspacing="0" border="0" align="left">
                                                <tr>
                                                    <td>North America：850-1900 MHz</td>
                                                </tr>
                                                <tr>
                                                    <td>Europe：900-1800 MHz</td>
                                                </tr>
                                                <tr>
                                                    <td>Power Limit：850,900：33dBm；900,1800：30dBm</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1">UL</td>
                                        <td class="tdRowName1">DL</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA1" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF1" runat="server" Text="T-GSM-380"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL1" runat="server" Text="380.2-389.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL1" runat="server" Text="390.2-399.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA2" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF2" runat="server" Text="T-GSM-410"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL2" runat="server" Text="410.2-419.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL2" runat="server" Text="420.2-429.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA3" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF3" runat="server" Text="GSM-450"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL3" runat="server" Text="450.4-457.6 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL3" runat="server" Text="460.4-467.6 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA4" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF4" runat="server" Text="GSM-480"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL4" runat="server" Text="479.0-486.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL4" runat="server" Text="489.0-496.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA5" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF5" runat="server" Text="GSM-710"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL5" runat="server" Text="698.0-716.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL5" runat="server" Text="728.0-746.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA6" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF6" runat="server" Text="GSM-750"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL6" runat="server" Text="747.0-762.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL6" runat="server" Text="777.0-792.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA7" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF7" runat="server" Text="T-GSM-810"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL7" runat="server" Text="806.0-821.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL7" runat="server" Text="851.0-866.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA8" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF8" runat="server" Text="GSM-850"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL8" runat="server" Text="824.0-849.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL8" runat="server" Text="869.0-894.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA9" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF9" runat="server" Text="P-GSM-900"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL9" runat="server" Text="890.2-914.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL9" runat="server" Text="935.2-959.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA10" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF10" runat="server" Text="E-GSM-900"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL10" runat="server" Text="880.0-914.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL10" runat="server" Text="925.2-959.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA11" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF11" runat="server" Text="R-GSM-900"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL11" runat="server" Text="876.0-914.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL11" runat="server" Text="921.0-959.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA12" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF12" runat="server" Text="T-GSM-900"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL12" runat="server" Text="870.4-876.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL12" runat="server" Text="915.4-921.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA13" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF13" runat="server" Text="DCS-1800"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL13" runat="server" Text="1710.2-1784.8 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL13" runat="server" Text="1805.2-1879.8 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb2GANA14" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GF14" runat="server" Text="PCS-1900"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GUL14" runat="server" Text="1850.0-1910.0 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GDL14" runat="server" Text="1930.0-1990.0 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1" colspan="4">
                                            <table border="0" width="100%">
                                                <tr>
                                                    <td  style="width:50px;">Remark：</td>
                                                    <td align="left"><asp:TextBox ID="tb2GRemark" runat="server" TextMode="MultiLine" Rows="3" Width="96%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="up2G" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsg2G" runat="server" />
                                                    <asp:Button ID="btn2GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn2GCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+ Edit</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">Power Limit：24dBm,class 3</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1">UL</td>
                                        <td class="tdRowName1">DL</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA1" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF1" runat="server" Text="Band1"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL1" runat="server" Text="1920-1980 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL1" runat="server" Text="2110-2170 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA2" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF2" runat="server" Text="Band2"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL2" runat="server" Text="1850-1910 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL2" runat="server" Text="1930-1990 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA3" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF3" runat="server" Text="Band3"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL3" runat="server" Text="1710-1785 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL3" runat="server" Text="1805-1880 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA4" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF4" runat="server" Text="Band4"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL4" runat="server" Text="1710-1755 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL4" runat="server" Text="2110-2155 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA5" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF5" runat="server" Text="Band5"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL5" runat="server" Text="824-849 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL5" runat="server" Text="869-894 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA6" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF6" runat="server" Text="Band6"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL6" runat="server" Text="830-840 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL6" runat="server" Text="875-885 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA7" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF7" runat="server" Text="Band7"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL7" runat="server" Text="2500-2570 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL7" runat="server" Text="2620-2690 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA8" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF8" runat="server" Text="Band8"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL8" runat="server" Text="880-915 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL8" runat="server" Text="925-960 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA9" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF9" runat="server" Text="Band9"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL9" runat="server" Text="1749.9-1784.9 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL9" runat="server" Text="1844.9-1879.9 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA10" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF10" runat="server" Text="Band10"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL10" runat="server" Text="1710-1770 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL10" runat="server" Text="2110-2170 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA11" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF11" runat="server" Text="Band11"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL11" runat="server" Text="1427.9-1452.9 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL11" runat="server" Text="1475.9-1500.9 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA12" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF12" runat="server" Text="Band12"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL12" runat="server" Text="698-716 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL12" runat="server" Text="728-746 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA13" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF13" runat="server" Text="Band13"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL13" runat="server" Text="777-787 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL13" runat="server" Text="746-756 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA14" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF14" runat="server" Text="Band14"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL14" runat="server" Text="788-798 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL14" runat="server" Text="758-768 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA15" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF15" runat="server" Text="Band19"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL15" runat="server" Text="830-845 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL15" runat="server" Text="875-890 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA16" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF16" runat="server" Text="Band20"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL16" runat="server" Text="832-862 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL16" runat="server" Text="791-821 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb3GANA17" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GF17" runat="server" Text="Band21"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GUL17" runat="server" Text="1447.9-1462.9 MHz"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GDL17" runat="server" Text="1495.9-1510.9 MHz"></asp:Label></td>
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
                                                    <uc2:MsgBox ID="mbMsg3G" runat="server" />
                                                    <asp:Button ID="btn3GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn3GCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">4G LTE Edit</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">Power Limit：24dBm,class 3</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1"></td>
                                        <td class="tdRowName1">UL</td>
                                        <td class="tdRowName1">DL</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA1" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF1" runat="server" Text="Band17"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL1" runat="server" Text="704-716 MHz(FDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL1" runat="server" Text="734-746 MHz(FDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA2" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF2" runat="server" Text="Band18"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL2" runat="server" Text="815-830 MHz(FDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL2" runat="server" Text="860-875 MHz(FDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA3" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF3" runat="server" Text="Band24"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL3" runat="server" Text="1626.5-1660.5 MHz(FDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL3" runat="server" Text="1525-1559 MHz(FDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA4" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF4" runat="server" Text="Band33"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL4" runat="server" Text="1900-1920 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL4" runat="server" Text="1900-1920 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA5" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF5" runat="server" Text="Band34"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL5" runat="server" Text="2010-2025 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL5" runat="server" Text="2010-2025 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA6" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF6" runat="server" Text="Band35"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL6" runat="server" Text="1850-1910 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL6" runat="server" Text="1850-1910 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA7" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF7" runat="server" Text="Band36"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL7" runat="server" Text="1930-1990 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL7" runat="server" Text="1930-1990 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA8" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF8" runat="server" Text="Band37"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL8" runat="server" Text="1910-1930 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL8" runat="server" Text="1910-1930 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA9" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF9" runat="server" Text="Band38"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL9" runat="server" Text="2570-2620 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL9" runat="server" Text="2570-2620 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA10" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF10" runat="server" Text="Band39"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL10" runat="server" Text="1880-1920 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL10" runat="server" Text="1880-1920 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA11" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF11" runat="server" Text="Band40"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL11" runat="server" Text="2300-2400 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL11" runat="server" Text="2300-2400 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA12" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF12" runat="server" Text="Band41"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL12" runat="server" Text="2496-2690 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL12" runat="server" Text="2496-2690 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA13" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF13" runat="server" Text="Band42"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL13" runat="server" Text="3400-3600 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL13" runat="server" Text="3400-3600 MHz(TDD)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cb4GANA14" runat="server" /></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GF14" runat="server" Text="Band43"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GUL14" runat="server" Text="3600-3800 MHz(TDD)"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GDL14" runat="server" Text="3600-3800 MHz(TDD)"></asp:Label></td>
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
                                                    <uc2:MsgBox ID="mbMsg4G" runat="server" />
                                                    <asp:Button ID="btn4GSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btn4GCancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">cdmaOne/CDMA2000 Edit</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">cdmaOne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power Limit：24dBm</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA1" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF1" runat="server" Text="824-849 MHz(MS Tx：US,Korea)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA2" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF2" runat="server" Text="869-894 MHz(BS Tx：US,Korea)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA3" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF3" runat="server" Text="887-925 MHz(MS Tx：Japan)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA4" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF4" runat="server" Text="832-870 MHz(BS Tx：Japan)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA5" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF5" runat="server" Text="1850-1910 MHz(MS Tx：US)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA6" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF6" runat="server" Text="1930-1990 MHz(BS Tx：US)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA7" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF7" runat="server" Text="1750-1780 MHz(MS Tx：Korea)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMAOneANA8" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMAOneF8" runat="server" Text="1840-1870 MHz(BS Tx：Korea)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="tdHeader1">CDMA2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power Limit：24dBm</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA1" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F1" runat="server" Text="410-430 MHz(MS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA2" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F2" runat="server" Text="450-470 MHz(BS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA3" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F3" runat="server" Text="824-849 MHz(MS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA4" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F4" runat="server" Text="869-894 MHz(BS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA5" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F5" runat="server" Text="1710-1755 MHz(MS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA6" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F6" runat="server" Text="2110-2155 MHz(BS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA7" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F7" runat="server" Text="1850-1910 MHz(MS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA8" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F8" runat="server" Text="1930-1990 MHz(BS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA9" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F9" runat="server" Text="1920-1980 MHz(MS Tx)"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:CheckBox ID="cbCDMA2000ANA10" runat="server" /></td>
                                        <td class="tdRowValue"><asp:Label ID="lblCDMA2000F10" runat="server" Text="2110-2170 MHz(BS Tx)"></asp:Label></td>
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
                                                    <uc2:MsgBox ID="mbMsgCDMA" runat="server" />
                                                    <asp:Button ID="btnCDMASave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnCDMACancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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
                            <%-- Wireless HD 60GHz--%>
                            <asp:Panel ID="plWirelessHD60" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Wireless HD 60GHz Edit</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblWirelessHD60F1" runat="server" Text="60 GHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue">
                                            <asp:CheckBox ID="cbWirelessHD60ANA1" runat="server" Text="Allowed" />
                                            <asp:CheckBox ID="cbWirelessHD60ANAN1" runat="server" Text="Not Allowed" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:TextBox ID="tbWirelessHD60PL1" runat="server" Width="120px" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Indoor/Outdoor allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWirelessHD60IDA1" runat="server" Text="Indoor allowed" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:CheckBox ID="cbWirelessHD60ODA1" runat="server" Text="Outdoor allowed" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td class="tdRowValue">
                                            <asp:TextBox ID="tbWirelessHD60Remark" runat="server" TextMode="MultiLine" Rows="2" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            <asp:UpdatePanel ID="upWirelessHD60" runat="server">
                                                <ContentTemplate>
                                                    <uc2:MsgBox ID="mbMsgWirelessHD60" runat="server" />
                                                    <asp:Button ID="btnWirelessHD60Save" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                    <asp:Button ID="btnWirelessHD60Cancel" runat="server" Text="Cancel/Back" CausesValidation="false" OnClick="btnCancel_Click" />
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

