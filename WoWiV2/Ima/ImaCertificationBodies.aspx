<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="ImaCertificationBodies.aspx.cs" Inherits="Ima_ImaCertificationBodies"
    StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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
                        <td class="tdRowValue">
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
                            <span style="color: Red; font-size: 10pt;">*</span>Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbName" runat="server" Rows="3" TextMode="MultiLine" 
                                Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbName"
                                ErrorMessage="Input Name" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveName" runat="server" TargetControlID="rfvName">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Authority：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblAuthority" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Certification Body：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCB" runat="server" RepeatDirection="Horizontal">
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
                        <td class="tdRowName">
                            Accredided Lab：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAccredidedLab" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Volume Pre Year：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbVolumePerYear1" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Publish：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblPublish1" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                            &nbsp;&nbsp; Website：
                            <asp:TextBox ID="tbWebsite1" runat="server" Width="450px"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="tdRowName">
                            Website：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbWebsite1" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>--%>
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

