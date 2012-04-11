<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AccreditedTestLab.aspx.cs" Inherits="Ima_AccreditedTestLab" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script language="javascript" type="text/javascript" src="../Scripts/IMA.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table border="0">
        <tr>
            <td valign="top">
                <uc1:ImaTree ID="ImaTree1" runat="server" />
            </td>
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
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id" onclick="CertificationSelect(this);">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span>Accredited Lab：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAccreditedLab" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAccreditedLab" runat="server" ControlToValidate="tbAccreditedLab"
                                ErrorMessage="Input Accredited Lab" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveAccreditedLab" runat="server" TargetControlID="rfvAccreditedLab">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Volume Pre Year：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbVolumePerYear" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Publish：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblPublish" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                            &nbsp;&nbsp;
                            Website：
                            <asp:TextBox ID="tbWebsite" runat="server" Width="450px"></asp:TextBox>
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
                            <asp:TextBox ID="tbFirstName" runat="server" Width="90%"></asp:TextBox>
                            <asp:Label ID="lblContactID" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Last Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLastName" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Title：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbTitle" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Work Phone：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbWorkPhone" runat="server"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp; EXT：<asp:TextBox ID="tbExt" runat="server" Width="60px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Cell Phone：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCellPhone" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Adress：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAdress" runat="server" Width="96%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Country：
                        </td>
                        <td class="tdRowValue">
                            <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name"
                                DataValueField="country_id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Test Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFee" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddlFeeUnit" runat="server">
                                <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RegularExpressionValidator ID="revFee" runat="server" ControlToValidate="tbFee"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceFee" runat="server" TargetControlID="revFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Lead Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLeadTime" runat="server" Width="60px"></asp:TextBox>&nbsp;Weeks
                            <asp:RegularExpressionValidator ID="revLeadTime" runat="server" ControlToValidate="tbLeadTime"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceLeadTime" runat="server" TargetControlID="revLeadTime">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            Technologies
                        </td>
                    </tr>
                    <tr id="trTechRF" runat="server" style="display: none;">
                        <td class="tdRowName">
                            RF：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechRF" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='RF'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechRFAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechEMC" runat="server" style="display: none;">
                        <td class="tdRowName">
                            EMC：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='EMC'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechEMCAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechSafety" runat="server" style="display: none;">
                        <td class="tdRowName">
                            Safety：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='Safety'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechSafetyAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechTelecom" runat="server" style="display: none;">
                        <td class="tdRowName">
                            Telecom：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechTelecom" runat="server" RepeatDirection="Horizontal"
                                RepeatColumns="5" DataSourceID="sdsTechTelecom" DataTextField="wowi_tech_name"
                                DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='Telecom'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechTelecomAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" class="tdFooter">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:Button ID="btnSaveCopy" runat="server" Text="Save(Copy)" OnClick="btnSave_Click" />
                            <asp:Button ID="btnUpd" runat="server" Text="Update" OnClick="btnUpd_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel/Back" OnClick="btnCancel_Click"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

