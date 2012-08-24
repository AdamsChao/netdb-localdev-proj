<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetail99RF.aspx.cs" Inherits="Ima_ImaDetail99RF" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            var ddlTech = $("#ddlTech");
            getSelect();
            ddlTech.change(function () {
                getSelect();
            });
        });

        function getSelect() {
            var ddlTech = $("#ddlTech");
            var plWiFi = $("#plWiFi");
            var plBluetooth = $("#plBluetooth");
            var plRFID = $("#plRFID");
            var plFMTransmitter = $("#plFMTransmitter");
            var plBelow1GSRD = $("#plBelow1GSRD");
            var plAbove1GSRD = $("#plAbove1GSRD");
            var plZigbee = $("#plZigbee");
            var plUWB = $("#plUWB");
            var pl2G = $("#pl2G");
            var pl3G = $("#pl3G");
            var pl4G = $("#pl4G");
            var plCDMA = $("#plCDMA");
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
            if (ddlTech.val() == 'WiFi') { plWiFi.css("display", ""); }
            else if (ddlTech.val() == 'Bluetooth') { plBluetooth.css("display", ""); plBluetooth.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'RFID') { plRFID.css("display", ""); plRFID.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'FM Transmitter') { plFMTransmitter.css("display", ""); plFMTransmitter.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'Below 1GHz SRD') { plBelow1GSRD.css("display", ""); plBelow1GSRD.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'Above 1GHz SRD') { plAbove1GSRD.css("display", ""); plAbove1GSRD.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'Zigbee') { plZigbee.css("display", ""); plZigbee.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'UWB') { plUWB.css("display", ""); plUWB.css("padding-top", "0px"); }
            else if (ddlTech.val() == '2G GSM/GPRS/EDGE/EDGE Evolution') { pl2G.css("display", ""); pl2G.css("padding-top", "0px"); }
            else if (ddlTech.val() == '3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+') { pl3G.css("display", ""); pl3G.css("padding-top", "0px"); }
            else if (ddlTech.val() == '4G LTE') { pl4G.css("display", ""); pl4G.css("padding-top", "0px"); }
            else if (ddlTech.val() == 'CDMA') { plCDMA.css("display", ""); plCDMA.css("padding-top", "0px"); }
            else {
                plWiFi.css("display", "");
                plBluetooth.css("display", "");
                plBluetooth.css("padding-top", "20px");
                plRFID.css("display", "");
                plRFID.css("padding-top", "20px");
                plFMTransmitter.css("display", "");
                plFMTransmitter.css("padding-top", "20px");
                plBelow1GSRD.css("display", "");
                plBelow1GSRD.css("padding-top", "20px");
                plAbove1GSRD.css("display", "");
                plAbove1GSRD.css("padding-top", "20px");
                plZigbee.css("display", "");
                plZigbee.css("padding-top", "20px");
                plUWB.css("display", "");
                plUWB.css("padding-top", "20px");
                pl2G.css("display", "");
                pl2G.css("padding-top", "20px");
                pl3G.css("display", "");
                pl3G.css("padding-top", "20px");
                pl4G.css("display", "");
                pl4G.css("padding-top", "20px");
                plCDMA.css("display", "");
                plCDMA.css("padding-top", "20px");
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" align="center">
        <tr>
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
                                            <asp:ListItem Text="All" Value="0"></asp:ListItem>
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
                                        <td colspan="7" class="tdHeader">WiFi Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                        <td class="tdRowName1"><asp:Label ID="lblWiFiF2" runat="server" Text="5150-5250 MHz"></asp:Label></td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblWiFiF3" runat="server" Text="5250-5350 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblWiFiF4" runat="server" Text="5470-5725 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblWiFiF5" runat="server" Text="5725-5825 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblWiFiF6" runat="server" Text="5825-5850 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblWiFiANA6" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblWiFiPL6" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Indoor/Outdoor allowed</td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA1" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA1" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA2" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA2" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA3" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA3" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA4" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA4" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA5" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA5" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue1">
                                            <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiIDA6" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiODA6" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">HT20/HT40/HT80/HT160</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT201" runat="server" Visible="false" ></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT401" runat="server" Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT801" runat="server" Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1601" runat="server" Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT202" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT402" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT802" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1602" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT2" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT203" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT403" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT803" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1603" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT3" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT204" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT404" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT804" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1604" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT4" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT205" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT405" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT805" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1605" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT5" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT206" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT406" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT806" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT1606" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiHT6" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            DFS/TPC
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS1" runat="server" Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC1" runat="server" Visible="false"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc1" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS2" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC2" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc2" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS3" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC3" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc3" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS4" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC4" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc4" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS5" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC5" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc5" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFS6" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiTPC6" runat="server"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left"><asp:Label ID="lblWiFiDFSDesc6" runat="server"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="6" class="tdRowValue"><asp:Label ID="lblWiFiRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center" class="tdFooter">
                                            
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Bluetooth Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" style="width:150px;">Frequency</td>
                                        <td class="tdRowName1"><asp:Label ID="lblBluetoothF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:Label ID="lblBluetoothPL1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue"><asp:Label ID="lblBluetoothANA1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">
                                            Remark
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblBluetoothRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            
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
                                        <td colspan="9" class="tdHeader">RFID Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Frequency</td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF1" runat="server" Text="120-150 KHZ"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF2" runat="server" Text="13.56 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF3" runat="server" Text="433 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF4" runat="server" Text="868-870 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF5" runat="server" Text="902-928 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF6" runat="server" Text="2400-2500 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF7" runat="server" Text="2450-5800 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblRFIDF8" runat="server" Text="5725-5875 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Power limit
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL7" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblRFIDPL8" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA7" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblRFIDANA8" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="8" class="tdRowValue"><asp:Label ID="lblRFIDRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="9" align="center" class="tdFooter">
                                            
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">FM Transmitter Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" style="width:150px;">Frequency</td>
                                        <td class="tdRowName">
                                            <table border="0" align="left">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblFMTransmitterF1" runat="server" Text="88-108 MHz"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblFMTransmitterFDesc1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblFMTransmitterPL1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Allowed/Not Allowed
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblFMTransmitterANA1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td class="tdRowValue"><asp:Label ID="lblFMTransmitterRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                    <tr>
                                        <td colspan="5" class="tdHeader">Below 1GHz SRD Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" style="width:150px;">
                                            Frequency
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblBelow1GSRDF1" runat="server" Text="13.56 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblBelow1GSRDF2" runat="server" Text="88-108 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblBelow1GSRDF3" runat="server" Text="300/400/800 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblBelow1GSRDF4" runat="server" Text="900 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Power limit</td>
                                        <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL4" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Allowed/Not Allowed</td>
                                        <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA4" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Remark</td>
                                        <td colspan="4" class="tdRowValue"><asp:Label ID="lblBelow1GSRDRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center" class="tdFooter">
                                            
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- Above 1GHz SRD--%>
                            <asp:Panel ID="plAbove1GSRD" runat="server" ScrollBars="Auto">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                    <tr>
                                        <td colspan="3" class="tdHeader">
                                            Above 1GHz SRD Detail
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" style="width:150px;">
                                            Frequency
                                        </td>
                                        <td class="tdRowName1">
                                            <table border="0" align="left">
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblAbove1GSRDF1" runat="server" Text="2.4 GHz"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblAbove1GSRDFDesc1" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="tdRowName1">
                                            <table border="0" align="left">
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblAbove1GSRDF2" runat="server" Text="5 GHz"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="lblAbove1GSRDFDesc2" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Power limit
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblAbove1GSRDPL1" runat="server"></asp:Label>
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblAbove1GSRDPL2" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Allowed/Not Allowed
                                        </td>
                                        <td class="tdRowValue1"><asp:Label ID="lblAbove1GSRDANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblAbove1GSRDANA2" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">
                                            Remark
                                        </td>
                                        <td colspan="2" class="tdRowValue"><asp:Label ID="lblAbove1GSRDRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center" class="tdFooter">
                                            
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">
                                            Zigbee Detail
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" style="width:150px;">
                                            Frequency
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblZigbeeF1" runat="server" Text="2400-2483.5 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblZigbeeF2" runat="server" Text="898 MHz"></asp:Label>
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblZigbeeF3" runat="server" Text="915 MHz"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Power limit
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblZigbeePL1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblZigbeePL2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblZigbeePL3" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Allowed/Not Allowed
                                        </td>
                                        <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA3" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">
                                            Remark
                                        </td>
                                        <td colspan="3" class="tdRowValue"><asp:Label ID="lblZigbeeRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" class="tdFooter">
                                            
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
                                        <td colspan="8" class="tdHeader">
                                            UWB Detail
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Frequency
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF1" runat="server" Text="3168-3696 MHz"></asp:Label><br />
                                            (Band#1)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF2" runat="server" Text="3696-4224 MHz"></asp:Label><br />
                                            (Band#2)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF3" runat="server" Text="4224-4752 MHz"></asp:Label><br />
                                            (Band#3)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF4" runat="server" Text="4752-5280 MHz"></asp:Label><br />
                                            (Band#4)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF5" runat="server" Text="5280-5808 MHz"></asp:Label><br />
                                            (Band#5)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF6" runat="server" Text="5808-6336 MHz"></asp:Label><br />
                                            (Band#6)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF7" runat="server" Text="6336-6864 MHz"></asp:Label><br />
                                            (Band#7)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Power limit
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL7" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Allowed/Not Allowed
                                        </td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA7" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" style="height: 1px;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Frequency
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF8" runat="server" Text="6864-7392 MHz"></asp:Label><br />
                                            (Band#8)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF9" runat="server" Text="7392-7920 MHz"></asp:Label><br />
                                            (Band#9)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF10" runat="server" Text="7920-8448 MHz"></asp:Label><br />
                                            (Band#10)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF11" runat="server" Text="8448-8976 MHz"></asp:Label><br />
                                            (Band#11)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF12" runat="server" Text="8976-9504 MHz"></asp:Label><br />
                                            (Band#12)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF13" runat="server" Text="9504-10032 MHz"></asp:Label><br />
                                            (Band#13)
                                        </td>
                                        <td class="tdRowName1">
                                            <asp:Label ID="lblUWBF14" runat="server" Text="10032-10560 MHz"></asp:Label><br />
                                            (Band#14)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Power limit
                                        </td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL8" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL9" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL10" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL11" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL12" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL13" runat="server"></asp:Label></td>
                                        <td class="tdRowValue"><asp:Label ID="lblUWBPL14" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">
                                            Allowed/Not Allowed
                                        </td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA8" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA9" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA10" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA11" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA12" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA13" runat="server"></asp:Label></td>
                                        <td class="tdRowValue1"><asp:Label ID="lblUWBANA14" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">
                                            Remark
                                        </td>
                                        <td colspan="7" class="tdRowValue"><asp:Label ID="lblUWBRemark" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8" align="center" class="tdFooter">
                                            
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
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="4" class="tdHeader">2G GSM/GPRS/EDGE/EDGE Evolution Detail</td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA1" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA2" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA3" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA4" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA5" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA6" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA7" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA8" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA9" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA10" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA11" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA12" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA13" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl2GANA14" runat="server"></asp:Label></td>
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
                                        <td colspan="4" align="center" class="tdFooter">
                                            
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
                                            3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+ Detail
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA1" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA2" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA3" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA4" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA5" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA6" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA7" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA8" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA9" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA10" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA11" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA12" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA13" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA14" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA15" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA16" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl3GANA17" runat="server"></asp:Label></td>
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
                                        <td colspan="4" align="center" class="tdFooter">
                                            
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
                                            4G LTE Detail
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA1" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA2" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA3" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA4" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA5" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA6" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA7" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA8" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA9" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA10" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA11" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA12" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA13" runat="server"></asp:Label></td>
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
                                        <td class="tdRowValue1"><asp:Label ID="lbl4GANA14" runat="server"></asp:Label></td>
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
                                        <td colspan="4" align="center" class="tdFooter">
                                            
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%-- CDMA--%>
                            <asp:Panel ID="plCDMA" runat="server" ScrollBars="Auto" style="padding-top:20px;">
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left"
                                    width="600px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">
                                            cdmaOne/CDMA2000 Detail
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tdHeader1">
                                            cdmaOne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Power Limit：24dBm
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF1" runat="server" Text="824-849 MHz(MS Tx：US,Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF2" runat="server" Text="869-894 MHz(BS Tx：US,Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF3" runat="server" Text="887-925 MHz(MS Tx：Japan)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF4" runat="server" Text="832-870 MHz(BS Tx：Japan)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF5" runat="server" Text="1850-1910 MHz(MS Tx：US)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF6" runat="server" Text="1930-1990 MHz(BS Tx：US)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA7" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF7" runat="server" Text="1750-1780 MHz(MS Tx：Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA8" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMAOneF8" runat="server" Text="1840-1870 MHz(BS Tx：Korea)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tdHeader1">
                                            CDMA2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power
                                            Limit：24dBm
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA1" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F1" runat="server" Text="410-430 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA2" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F2" runat="server" Text="450-470 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA3" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F3" runat="server" Text="824-849 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA4" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F4" runat="server" Text="869-894 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA5" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F5" runat="server" Text="1710-1755 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA6" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F6" runat="server" Text="2110-2155 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA7" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F7" runat="server" Text="1850-1910 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA8" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F8" runat="server" Text="1930-1990 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA9" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F9" runat="server" Text="1920-1980 MHz(MS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA10" runat="server"></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblCDMA2000F10" runat="server" Text="2110-2170 MHz(BS Tx)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter">
                                            
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
    </form>
</body>
</html>
