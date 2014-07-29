<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaB.aspx.cs" Inherits="Ima_ImaB" StylesheetTheme="IMA" %>

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
                            <td colspan="2" class="tdHeader">
                                Government Authority Detail
                            </td>
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
                            <td class="tdRowName">
                                Authority FullName：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFullAuthorityNameS" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Authority Name：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblAbbreviatedAuthorityNameS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Mandatory or Voluntary：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblMandatoryS" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Certificate is valid for<br />
                                Single Importer / Any Importer：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCertificateValidS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Transfer of Certificate：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblTransferS" runat="server"></asp:Label><asp:Label ID="lblDescriptionS" runat="server" ></asp:Label>
                                <%--<asp:GridView ID="gvImaFilesS" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList" DataSourceID="sdsImaFiles">
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>--%>
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
                                Authority FullName：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFullAuthorityName" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Authority Name：
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsImaFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                    SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='A' order by FileName">
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
                                <asp:Label ID="lblCertificationBody" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Also accredited test lab：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblAccreditedTest" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Accreditation certification<br />body list：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblBodyListWebsite" runat="server"></asp:Label>
                                <asp:GridView ID="gvImaFiles2" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList" DataSourceID="sdsImaFiles2">
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsImaFiles2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='C' order by FileName">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Accreditation test lab list：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblLabListWebsite" runat="server"></asp:Label>
                                <asp:GridView ID="gvImaFiles3" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList"
                                    DataSourceID="sdsImaFiles3">
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsImaFiles3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='D' order by FileName">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName">
                                Certificate is valid for<br />
                                Single Importer / Any Importer：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblCertificateValid" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Transfer of Certificate：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblTransfer" runat="server"></asp:Label><asp:Label ID="lblDescription" runat="server" ></asp:Label>
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsImaFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                    SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='B' order by FileName">
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
                            <td class="tdRowName" valign="top">Contact：</td>
                            <td class="tdRowValue">
                                <asp:DataList ID="dlContact" runat="server" DataSourceID="sdsContact" 
                                    CellPadding="4" ForeColor="#333333" 
                                    onitemdatabound="dlContact_ItemDataBound">
                                    <AlternatingItemStyle BackColor="White" />
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
                                    <ItemTemplate>
                                        <table border="1" cellpadding="1" cellspacing="1" width="670px">
                                            <tr>
                                                <td class="tdContactRowName">First Name：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblFirstName" runat="server" Text='<%#Eval("FirstName") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Last Name：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblLastName" runat="server" Text='<%#Eval("LastName") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Title：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">Work Phone：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblWorkPhone" runat="server" Text='<%#Eval("WorkPhone") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Fax：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblFax" runat="server" Text='<%#Eval("Fax") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Cell Phone：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblCellPhone" runat="server" Text='<%#Eval("CellPhone") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">Email：</td>
                                                <td colspan="5"><asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">Adress：</td>
                                                <td colspan="5"><asp:Label ID="lblAdress" runat="server" Text='<%#Eval("Adress") %>'></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdContactRowName">Country：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblCountry" runat="server" Text='<%#Eval("country_name") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Lead Time：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblLeadTime" runat="server" Text='<%#Eval("LeadTime") %>'></asp:Label></td>
                                                <td class="tdContactRowName">Remark：</td>
                                                <td class="tdContactRowValue"><asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark") %>'></asp:Label></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                    <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                </asp:DataList>
                                <asp:SqlDataSource ID="sdsContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="DID" QueryStringField="gaid" Type="Int32" DefaultValue="0" />
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
                        </tr>--%>
                        <tr>
                            <td class="tdRowName">Lead Time：</td>
                            <td class="tdRowValue"><asp:Label ID="lblLeadT" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="tdHeader1">
                                Submission Fee By Technologies
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
                                                    <asp:CheckBox ID="cbRFFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>' onclick="TechFee(this);" Enabled="false" />
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="gaid" Type="Int32" DefaultValue="0" />
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
                                                <%--<td><asp:CheckBox ID="cbEMCFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>' Enabled="false"/></td>--%>
                                                <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="gaid" Type="Int32" DefaultValue="0" />
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
                                                    <asp:CheckBox ID="cbSafetyFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>' Enabled="false"/>
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="gaid" Type="Int32" DefaultValue="0" />
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
                                                    <asp:CheckBox ID="cbTelecomFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>' Enabled="false"/>
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
                                        <asp:QueryStringParameter Name="DID" QueryStringField="gaid" Type="Int32" DefaultValue="0" />
                                        <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="lblTelecomRemark" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdRowName" valign="top">
                                Submission fee list：
                            </td>
                            <td class="tdRowValue">
                                <asp:Label ID="lblFeeListWebsite" runat="server"></asp:Label>
                                <asp:GridView ID="gvImaFiles4" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList"
                                    DataSourceID="sdsImaFiles4">
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
                                                    Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                            </ItemTemplate>
                                            <HeaderStyle Font-Bold="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsImaFiles4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                    SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='E' order by FileName">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                    </SelectParameters>
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
    </asp:Panel>
    </form>
</body>
</html>
