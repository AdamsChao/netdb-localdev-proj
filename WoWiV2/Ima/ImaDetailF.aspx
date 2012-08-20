<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailF.aspx.cs" Inherits="Ima_ImaDetailF" StylesheetTheme="IMA" %>

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
                                <asp:Label ID="lblTitle" runat="server" Text="Local Agent Detail"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Certification Type：
                            </td>
                            <td class="tdRowValue">
                                <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id" Enabled="false" Visible="false">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                <asp:Label ID="lblProTypeName" runat="server" ></asp:Label>
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
                                Local Angent Type：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblAngentType" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Credit：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCredit" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Signed NDA：
                            </td>
                            <td class="tdRowValue" align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblNDAYes" runat="server" Text="No"></asp:Label><%--
                                            <asp:CheckBox ID="cbNDAYes" runat="server" Text="Yes" Enabled="false" />
                                            <asp:CheckBox ID="cbNDAChoose" runat="server" Text="Choose File" Enabled="false" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsFile1">
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
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='A'">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="DocID" QueryStringField="laid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Signed MOU：
                            </td>
                            <td class="tdRowValue" align="left">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblMOUYes" runat="server" Text="No"></asp:Label>
                                            <%--<asp:CheckBox ID="cbMOUYes" runat="server" Text="Yes" Enabled="false" />
                                            <asp:CheckBox ID="cbMOUChoose" runat="server" Text="Choose File" Enabled="false" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsFile2">
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
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='B'">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="DocID" QueryStringField="laid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Contact：
                            </td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlContact" runat="server" DataSourceID="sdsContact" CellPadding="4"
                                    ForeColor="#333333" onitemdatabound="dlContact_ItemDataBound">
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="laid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <%--<tr>
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
                                Local Agent Fee：
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
                        </tr>--%>
                        <tr>
                            <td class="tdRowName">
                                Local Rep. Service：
                            </td>
                            <td class="tdRowValue"><asp:Label ID="lblLocalRep" runat="server" Text="No"></asp:Label></td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Lead Time：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblLeadT" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Local Agent Fee by Technologies
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="laid" Type="Int32" DefaultValue="0" />
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="laid" Type="Int32" DefaultValue="0" />
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="laid" Type="Int32" DefaultValue="0" />
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="laid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblTelecomRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <%--<tr id="trTechRF" runat="server" visible="false">
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
                            <td colspan="2" align="center" class="tdFooter"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
