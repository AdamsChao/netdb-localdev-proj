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
                                Certification Type：
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
                                    SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1">
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
                                Also accredited test lab：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblAccreditedTest" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                    <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
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
                        <tr id="tr1" runat="server" visible="false">
                            <td class="tdRowName">
                                Accredided Lab：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblAccredidedLab" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="tr2" runat="server" visible="false">
                            <td class="tdRowName">
                                Volume Pre Year：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblVolumePerYear1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="tr3" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                Publish：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:RadioButtonList ID="rblPublish1" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                                &nbsp;&nbsp; Website：
                                <asp:Label ID="lblWebsite1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Contact
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                First Name：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFirstName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Last Name：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblLastName" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Title：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblContactTitle" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Work Phone：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblWorkPhone" runat="server"></asp:Label>
                                &nbsp;&nbsp;&nbsp; EXT：<asp:Label ID="lblExt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Cell Phone：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCellPhone" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Adress：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblAdress" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Country：
                            </td>
                            <td class="tdRowValue">
                                <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name"
                                    DataValueField="country_id" Enabled="false">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Certification Body Fee：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFee" runat="server"></asp:Label>
                                <asp:DropDownList ID="ddlFeeUnit" runat="server" Enabled="false">
                                    <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                    <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Lead Time：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblLeadTime" runat="server"></asp:Label>&nbsp;Weeks
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Technologies
                            </td>
                        </tr>
                        <tr id="trTechRF" runat="server" visible="false">
                            <td class="tdRowName">
                                RF：
                            </td>
                            <td class="tdRowValue">
                                <asp:CheckBoxList ID="cbTechRF" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                    DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id"
                                    Enabled="false">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='RF'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr id="trTechEMC" runat="server" visible="false">
                            <td class="tdRowName">
                                EMC：
                            </td>
                            <td class="tdRowValue">
                                <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                    DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id"
                                    Enabled="false">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='EMC'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr id="trTechSafety" runat="server" visible="false">
                            <td class="tdRowName">
                                Safety：
                            </td>
                            <td class="tdRowValue">
                                <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                    DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id"
                                    Enabled="false">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Safety'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr id="trTechTelecom" runat="server" visible="false">
                            <td class="tdRowName">
                                Telecom：
                            </td>
                            <td class="tdRowValue">
                                <asp:CheckBoxList ID="cbTechTelecom" runat="server" RepeatDirection="Horizontal"
                                    RepeatColumns="5" DataSourceID="sdsTechTelecom" DataTextField="wowi_tech_name"
                                    DataValueField="wowi_tech_id" Enabled="false">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Telecom'">
                                </asp:SqlDataSource>
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
