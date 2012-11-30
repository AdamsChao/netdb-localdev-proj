<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailH.aspx.cs" Inherits="Ima_ImaDetailH" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="plDetailSales" runat="server" Visible="false">
        <table border="0" align="center">
            <tr>
                <td valign="top">
                    <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                        <tr>
                            <td colspan="2" class="tdHeader">Test Standards Detail</td>
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
                                <asp:Label ID="lblFCCTitleS" runat="server"></asp:Label>
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFCCorIECorCES" runat="server"></asp:Label>
                                <asp:Label ID="lblOthersS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                <asp:Label ID="lblRequiredTitleS" runat="server"></asp:Label>
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRequiredS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                List harmonizes standards：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblStandardDescS" runat="server"></asp:Label>
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
                        <tr id="trCopyTo" runat="server" visible="false" align="left">
                            <td class="tdRowName" valign="top">
                                Coyp to：
                            </td>
                            <td class="tdRowValue">
                                <asp:RadioButtonList ID="rblProductType" runat="server" RepeatDirection="Horizontal"
                                    DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                </asp:RadioButtonList>
                                <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1">
                                </asp:SqlDataSource>
                                <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                <%--<span style="color: Red; font-size: 10pt;">*</span>--%>
                                <asp:Label ID="lblFCCTitle" runat="server"></asp:Label>
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFCCorIECorCE" runat="server"></asp:Label>
                                <asp:Label ID="lblOthers" runat="server"></asp:Label>
                                <asp:CheckBox ID="cbFCC" runat="server" Text="FCC" Enabled="false" Visible="false" />
                                <asp:CheckBox ID="cbIEC" runat="server" Text="IEC" Enabled="false" Visible="false" />
                                <asp:CheckBox ID="cbCE" runat="server" Text="CE" Enabled="false" Visible="false" />
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                <asp:Label ID="lblRequiredTitle" runat="server"></asp:Label>
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblRequired" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                List harmonizes standards：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblStandardDesc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Files：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblLocalStandards" runat="server" Visible="false"></asp:Label>
                                <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="StandardFileID"
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
                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "StandardFile.ashx?fid="+Eval("StandardFileID").ToString() %>'
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
                                    DeleteCommand="DELETE FROM [Ima_Standard_Files] WHERE [StandardFileID] = @StandardFileID"
                                    SelectCommand="SELECT * FROM [Ima_Standard_Files] WHERE ([StandardID] = @StandardID) and FileCategory='A'">
                                    <DeleteParameters>
                                        <asp:Parameter Name="StandardFileID" Type="Int32" />
                                    </DeleteParameters>
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="StandardID" QueryStringField="sid" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Local Standards by Technologies
                            </td>
                        </tr>
                        <tr id="trTechRF" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                RF：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechRF" runat="server" DataSourceID="sdsTechRF" DataKeyField="wowi_tech_id"
                                    RepeatColumns="2" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <table border="0">
                                            <tr>
                                                <%--<td>
                                                    <asp:CheckBox ID="cbRFFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                        onclick="TechFee(this);" Enabled="false" />
                                                </td>--%>
                                                <td>
                                                    <asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbRFFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblRFRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechEMC" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                EMC：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechEMC" runat="server" DataSourceID="sdsTechEMC" DataKeyField="wowi_tech_id"
                                    RepeatColumns="2" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <table border="0">
                                            <tr>
                                                <%--<td>
                                                    <asp:CheckBox ID="cbEMCFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                        Enabled="false" />
                                                </td>--%>
                                                <td>
                                                    <asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbEMCFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblEMCRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechSafety" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                Safety：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechSafety" runat="server" DataSourceID="sdsTechSafety" DataKeyField="wowi_tech_id"
                                    RepeatColumns="2" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <table border="0">
                                            <tr>
                                                <%--<td>
                                                    <asp:CheckBox ID="cbSafetyFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                        Enabled="false" />
                                                </td>--%>
                                                <td>
                                                    <asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbSafetyFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblSafetyRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechTelecom" runat="server" visible="false">
                            <td class="tdRowName" valign="top">
                                Telecom：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechTelecom" runat="server" DataSourceID="sdsTechTelecom" DataKeyField="wowi_tech_id"
                                    RepeatColumns="2" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <table border="0">
                                            <tr>
                                                <%--<td>
                                                    <asp:CheckBox ID="cbTelecomFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                        Enabled="false" />
                                                </td>--%>
                                                <td>
                                                    <asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbTelecomFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblTelecomRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" class="tdFooter"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    </form>
</body>
</html>
