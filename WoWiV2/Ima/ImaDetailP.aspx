<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailP.aspx.cs" Inherits="Ima_ImaDetailP" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/DenyPageCopy.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="plDetailSales" runat="server" Visible="false">
        <table border="0" align="center">
            <tr>
                <td valign="top">
                    <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                        <tr>
                            <td colspan="2" class="tdHeader">Label and Renewal Detail</td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Country：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCountryS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Certification Type：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblProTypeNameS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Label Requirement：
                            </td>
                            <td class="tdRowValue">
                                <table border="0" cellpadding="0" cellspacing="0" align="left">
                                    <tr>
                                        <td><asp:Label ID="lblRequirementS" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRequirementDescS" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile1S" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
                                                DataSourceID="sdsFile1S">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                        <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileName">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
                                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsFile1S" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                                SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='A'">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PostFileID" Type="Int32" />
                                                </DeleteParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPrintS" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLabelsDescS" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">Label Location：</td>
                            <td class="tdRowValue" align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>Must be on End Product：</td>
                                                    <td>
                                                        <asp:Label ID="lblProductS" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblEUTS" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">Warning Statement：</td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRequiredDescS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRenewalS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Test Required：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRequiredS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal Validity：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblYearMonthS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal Required Document：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblRequiredDocS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Remark：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblRemarkS" runat="server"></asp:Label>
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
    </asp:Panel>
    <asp:Panel ID="plDetail" runat="server" Visible="false">
        <table border="0" align="center">
            <tr>
                <td valign="top">
                    <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                        <tr>
                            <td colspan="2" class="tdHeader">
                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Country：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCountry" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trProductType" runat="server">
                            <td class="tdRowName" valign="top">
                                Certification Type：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
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
                                <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Label Requirement：
                            </td>
                            <td class="tdRowValue">
                                <table border="0" cellpadding="0" cellspacing="0" align="left">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRequirement" runat="server"></asp:Label>
                                            <%--<asp:RadioButtonList ID="rblRequirement" runat="server" RepeatDirection="Horizontal"
                                                Enabled="false">
                                                <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                            </asp:RadioButtonList>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblRequirementDesc" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
                                                DataSourceID="sdsFile1">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                        <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileName">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
                                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                                SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='A'">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PostFileID" Type="Int32" />
                                                </DeleteParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblPrint" runat="server"></asp:Label>
                                            <%--<asp:CheckBox ID="cbPrint" runat="server" Text="Labels can be self-printed" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbPurchase" runat="server" Text="Labels need to be purchase from authority" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbManufacturer" runat="server" Text="Affixed in Manufacturer" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbImportation" runat="server" Text="Affixed after Importation" Enabled="false" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblLabelsDesc" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">Label Location：</td>
                            <td class="tdRowValue" align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>Must be on End Product：</td>
                                                    <td>
                                                        <asp:Label ID="lblProduct" runat="server"></asp:Label>
                                                        <%--<asp:RadioButtonList ID="rblProduct" runat="server" 
                                                            RepeatDirection="Horizontal" Enabled="False">
                                                            <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                                            <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                                        </asp:RadioButtonList>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblEUT" runat="server"></asp:Label>
                                            <%--<asp:CheckBox ID="cbEUT1" runat="server" Text="EUT(module) or Manual or Package" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT2" runat="server" Text="EUT(module) or End Product" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT3" runat="server" Text="EUT(module) or End Product or Manual" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT4" runat="server" Text="EUT(module) or End Product or Manual or Package" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT5" runat="server" Text="EUT(module) and End Product" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT6" runat="server" Text="EUT(module) and End Product and Manual" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT7" runat="server" Text="EUT(module) and End Product and Manual and Package" Enabled="false" /><br />
                                            <asp:CheckBox ID="cbEUT8" runat="server" Text="EUT(module) and End Product and Package" Enabled="false" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
                                                DataSourceID="sdsFile2">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                        <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileName">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
                                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                                SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='B'">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PostFileID" Type="Int32" />
                                                </DeleteParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">Warning Statement：</td>
                            <td class="tdRowValue" align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td><asp:Label ID="lblRequiredDesc" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
                                                DataSourceID="sdsFile3">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                        <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileName">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
                                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileURL" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("FileURL")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                                SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='C'">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PostFileID" Type="Int32" />
                                                </DeleteParameters>
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRenewal" runat="server"></asp:Label>
                                <%--<asp:RadioButtonList ID="rblRenewal" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Test Required：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRequired" runat="server"></asp:Label>
                                <%--<asp:RadioButtonList ID="rblRequired" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                    <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Cost W/Test：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCost1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Cost W/O Test：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCost2" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal Validity：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblYearMonth" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Renewal Required Document：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblRequiredDoc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Remark：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr>
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
                        </tr>--%>
                        <tr>
                            <td colspan="2" align="center" class="tdFooter">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    </form>
</body>
</html>
