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
                                <asp:Label ID="lblAuthority" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Also accredited test lab：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblAccreditedTest" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Certification Body：
                            </td>
                            <td class="tdRowValue" align="left">
                                <asp:Label ID="lblCB" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Volume Per Year：
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
                                <asp:Label ID="lblPublish" runat="server"></asp:Label>
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
                        <tr>
                            <td class="tdRowName" valign="top">
                                Contact：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlContact" runat="server" DataSourceID="sdsContact" CellPadding="4"
                                    ForeColor="#333333">
                                    <AlternatingItemStyle BackColor="White" />
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
                                    <ItemTemplate>
                                        <table border="1" cellpadding="1" cellspacing="1" width="670px">
                                            <tr>
                                                <td class="tdContactRowName">
                                                    First Name：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblFirstName" runat="server" Text='<%#Eval("FirstName") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Last Name：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblLastName" runat="server" Text='<%#Eval("LastName") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Title：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">
                                                    Work Phone：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblWorkPhone" runat="server" Text='<%#Eval("WorkPhone") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Fax：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblFax" runat="server" Text='<%#Eval("Fax") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Cell Phone：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblCellPhone" runat="server" Text='<%#Eval("CellPhone") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">
                                                    Email：
                                                </td>
                                                <td colspan="5">
                                                    <asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">
                                                    Adress：
                                                </td>
                                                <td colspan="5">
                                                    <asp:Label ID="lblAdress" runat="server" Text='<%#Eval("Adress") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">
                                                    Country：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblCountry" runat="server" Text='<%#Eval("country_name") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Lead Time：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblLeadTime" runat="server" Text='<%#Eval("LeadTime") %>'></asp:Label>
                                                </td>
                                                <td class="tdContactRowName">
                                                    Remark：
                                                </td>
                                                <td class="tdContactRowValue">
                                                    <asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="DID" QueryStringField="cbwid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Certification Body Fee by Technologies
                            </td>
                        </tr>
                        <tr id="trTechRF" runat="server" visible="false">
                            <td class="tdRowName">
                                RF：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechRF" runat="server" DataSourceID="sdsTechRF" DataKeyField="wowi_tech_id"
                                    RepeatColumns="3" RepeatDirection="Horizontal">
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
                                                    <asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="cbwid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblRFRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechEMC" runat="server" visible="false">
                            <td class="tdRowName">
                                EMC：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechEMC" runat="server" DataSourceID="sdsTechEMC" DataKeyField="wowi_tech_id"
                                    RepeatColumns="3" RepeatDirection="Horizontal">
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
                                                    <asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="cbwid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblEMCRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechSafety" runat="server" visible="false">
                            <td class="tdRowName">
                                Safety：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechSafety" runat="server" DataSourceID="sdsTechSafety" DataKeyField="wowi_tech_id"
                                    RepeatColumns="3" RepeatDirection="Horizontal">
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
                                                    <asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="cbwid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblSafetyRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="trTechTelecom" runat="server" visible="false">
                            <td class="tdRowName">
                                Telecom：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlTechTelecom" runat="server" DataSourceID="sdsTechTelecom" DataKeyField="wowi_tech_id"
                                    RepeatColumns="3" RepeatDirection="Horizontal">
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
                                                    <asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                        <asp:QueryStringParameter Name="DID" QueryStringField="cbwid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblTelecomRemark" runat="server"></asp:Label>
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
