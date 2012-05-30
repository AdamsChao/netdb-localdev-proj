<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailK.aspx.cs" Inherits="Ima_ImaDetailK" StylesheetTheme="IMA" %>

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
                            <asp:Label ID="lblTitle" runat="server"></asp:Label>
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
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Document language acceptance：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLanguage" runat="server"></asp:Label>
                                        <%--<asp:RadioButtonList ID="rblLanguage" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                            <asp:ListItem Text="All English" Value="All" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Other or Partial" Value="Other"></asp:ListItem>
                                        </asp:RadioButtonList>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLanguageDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
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
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "TestingFile.ashx?fid="+Eval("TestingFileID").ToString() %>'
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
                                            DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="TestingFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Testing Sample Label Marking：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblTestMark" runat="server"></asp:Label>
                            <%--<asp:RadioButtonList ID="rblTestMark" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>--%>
                            <asp:Label ID="lblTestMarkRemark" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            EUT Info：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblEUTInfo" runat="server"></asp:Label>
                            <%--<asp:CheckBox ID="cbBW" runat="server" Text="Sales Brochure (B/W)" Enabled="false" />
                            <asp:CheckBox ID="cbColor" runat="server" Text="Sales Brochure (Color)" Enabled="false" /><br />--%>
                            <asp:Label ID="lblManual" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Test Report/Certification
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCertification" runat="server"></asp:Label>
                                        <%--<asp:CheckBox ID="cbFCCTest" runat="server" Text="FCC Test Report" Enabled="false" />
                                        <asp:CheckBox ID="cbFCCCertificate" runat="server" Text="FCC Certificate" Enabled="false" />
                                        <asp:CheckBox ID="cbCETest" runat="server" Text="CE Test Report" Enabled="false" />
                                        <asp:CheckBox ID="cbNBEO" runat="server" Text="NBEO" Enabled="false" />--%>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>
                                        <asp:CheckBox ID="cbEUDoC" runat="server" Text="EU DoC" Enabled="false" />
                                        <asp:CheckBox ID="cbConformance" runat="server" Text="Conformance for GSM, CDMA , and WCDMA" Enabled="false" />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOtherInternationally" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
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
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "TestingFile.ashx?fid="+Eval("TestingFileID").ToString() %>'
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
                                            DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="TestingFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Technical Documents：
                        </td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTechnicalDocs" runat="server"></asp:Label>
                                        <%--<asp:CheckBox ID="cbSchematics" runat="server" Text="Schematics" Enabled="false" />
                                        <asp:CheckBox ID="cbBlock" runat="server" Text="Block Diagram" Enabled="false" />
                                        <asp:CheckBox ID="cbLayout" runat="server" Text="Layout" Enabled="false" />
                                        <asp:CheckBox ID="cbGerber" runat="server" Text="Gerber" Enabled="false" />
                                        <asp:CheckBox ID="cbTheory" runat="server" Text="Theory of Operation" Enabled="false" />
                                        <asp:CheckBox ID="cbBOM1" runat="server" Text="BOM" Enabled="false" />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblTechnical" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAntenna" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr id="trBOM" runat="server" visible="false">
                                    <td>
                                        BOM In
                                        <asp:Label ID="lblBOM" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Other Documents：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOtherDoc1" runat="server"></asp:Label>
                                        <%--<asp:CheckBox ID="cbOfficial" runat="server" Text="Official Application Form" Enabled="false" /><asp:Label ID="lblOfficialLanguage" runat="server"></asp:Label><br />--%>
                                        <%--<asp:CheckBox ID="cbWoWiRequest" runat="server" Text="WoWi Request Letter" Enabled="false" />--%><br />
                                        <%--<asp:CheckBox ID="cbISO" runat="server" Text="ISO/Quality Documents" Enabled="false" /><asp:Label ID="lblISOLanguage" runat="server"></asp:Label>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%--<asp:CheckBox ID="cbPayment" runat="server" Text="Payment Receipt" Enabled="false" /><br />--%>
                                        <%--<asp:CheckBox ID="cbAuthor" runat="server" Text="Authorization Letter from Manufacturer to Local Rep/Agent" Enabled="false" /><br />--%>
                                        <%--<asp:CheckBox ID="cbAuthorWoWi" runat="server" Text="Authorization Letter from Manufacturer to WoWi" Enabled="false" /><br />--%>
                                        <%--<asp:CheckBox ID="cbAuthorAgent" runat="server" Text="Authorization Letter from Local Rep to Local Agent" Enabled="false" />--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOtherDocRequest" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
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
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "TestingFile.ashx?fid="+Eval("TestingFileID").ToString() %>'
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
                                            DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='C'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="TestingFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Radiated Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblRadiated" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Conducted Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblConducted" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Normal-Link Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblNormalLink" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Consummer Sample for review only：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblReviewOnly" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Pre-install test software
                            <br />
                            or send by CD, email, or FTP：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblPreInstalled" runat="server"></asp:Label>
                            <%--<asp:CheckBox ID="cbPreInstalled" runat="server" Text="Pre-installed" Enabled="false" />
                            <asp:CheckBox ID="cbCD" runat="server" Text="CD" Enabled="false" />
                            <asp:CheckBox ID="cbEmail" runat="server" Text="Email" Enabled="false" />
                            <asp:CheckBox ID="cbFTP" runat="server" Text="FTP" Enabled="false" />--%>
                            <asp:Label ID="lblTestNote" runat="server"></asp:Label>
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
    </form>
</body>
</html>
