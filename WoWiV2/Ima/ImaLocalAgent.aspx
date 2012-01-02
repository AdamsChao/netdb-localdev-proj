<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="ImaLocalAgent.aspx.cs" Inherits="Ima_ImaLocalAgent" StylesheetTheme="IMA" %>
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
                    <%--<tr id="trProductType" runat="server">
                        <td class="tdRowName" valign="top">
                            Product Type：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span>Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbName" runat="server" Rows="3" TextMode="MultiLine" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="tbName"
                                ErrorMessage="Input Name" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveName" runat="server" TargetControlID="rfvName">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Product Type：
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
                            Credit：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCredit" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Communication：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCommunication" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Volume：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbVolume" runat="server" Rows="3" TextMode="MultiLine" Width="90%"></asp:TextBox>
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

