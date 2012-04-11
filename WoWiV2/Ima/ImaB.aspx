<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaB.aspx.cs" Inherits="Ima_ImaB"
    StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" align="center">
        <tr>
            <td valign="top">
                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                    <tr>
                        <td colspan="2" class="tdHeader">
                            Government Authority Detail
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
                    <tr>
                        <td class="tdRowName">
                            Full Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblFullAuthorityName" runat="server" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Abbreviated Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblAbbreviatedAuthorityName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Website：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblWebsite" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Mandatory or Voluntary：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblMandatory" runat="server" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Attach sample certificate：
                        </td>
                        <td class="tdRowValue">
                            <asp:GridView ID="gvImaFiles1" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList"
                                DataSourceID="sdsImaFiles1" >
                                <Columns>
                                    <asp:TemplateField HeaderText="NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" Width="50px" HorizontalAlign="Center" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FileName">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GoverFile.ashx?fid="+Eval("GoverAuthFileID").ToString() %>'
                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsImaFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='A'">
                                <DeleteParameters>
                                    <asp:Parameter Name="GeneralFileID" Type="Int32" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Also certification body：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificationBody" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Also accredited test lab：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblAccreditedTest" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Certificate is valid for：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificateValid" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Single Importer" Value="Single"></asp:ListItem>
                                <asp:ListItem Text="Any Importer" Value="Any"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Transfer of Certificate：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblTransfer" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:Label ID="lblDescription" runat="server" ></asp:Label>
                            <asp:GridView ID="gvImaFiles" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList"
                                DataSourceID="sdsImaFiles">
                                <Columns>
                                    <asp:TemplateField HeaderText="NO">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" Width="50px" HorizontalAlign="Center" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FileName">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GoverFile.ashx?fid="+Eval("GoverAuthFileID").ToString() %>'
                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsImaFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='B'">
                                <DeleteParameters>
                                    <asp:Parameter Name="GeneralFileID" Type="Int32" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
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
                            <asp:Label ID="lblTitle" runat="server"></asp:Label>
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
                            Submission Fee：
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
                                DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id" Enabled="false" >
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='RF'">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr id="trTechEMC" runat="server" visible="false">
                        <td class="tdRowName">
                            EMC：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id" Enabled="false">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='EMC'">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr id="trTechSafety" runat="server" visible="false">
                        <td class="tdRowName">
                            Safety：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id" Enabled="false" >
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='Safety'">
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
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish='Y' and b.wowi_product_type_name='Telecom'">
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
    </form>
</body>
</html>
