<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailD.aspx.cs" Inherits="Ima_ImaDetailD" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" align="center">
            <tr>
                <td valign="top">
                    <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                        <tr>
                            <td colspan="2" class="tdHeader">
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trProductType" runat="server">
                            <td class="tdRowName" valign="top">
                                Product Type：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
                                <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trCopyTo" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                Coyp to：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                    DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Name：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Authority：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblAuthority" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Certification Body：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblCB" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Volume Pre Year：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblVolumePerYear" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Publish：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblPublish" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                                &nbsp;&nbsp; Website：
                                <asp:Label ID="lblWebsite" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Accredided Lab：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblAccredidedLab" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Volume Pre Year：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblVolumePerYear1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Publish：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblPublish1" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                                &nbsp;&nbsp; Website：
                                <asp:Label ID="lblWebsite1" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" class="tdFooter">                               
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
