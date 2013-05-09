<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailAll.aspx.cs" Inherits="Ima_ImaDetailAll" StylesheetTheme="IMA" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/DenyPageCopy.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <act:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </act:ToolkitScriptManager>
    <div style="margin-left:30px;">
        <table border="0" width="100%" align="left">
            <tr>
                <td>Country：<asp:Label ID="lblCountry" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>Certification Type：<asp:Label ID="lblProTypeName" runat="server"></asp:Label></td>
            </tr>
            <%--General--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoGeneral" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpGeneral" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleGeneral" runat="server">General</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgGeneral" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plGeneralDetail" runat="server">
                        <table border="0">
                            <tr>
                                <td valign="top">
                                    <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem">
                                        <tr>
                                            <td colspan="2" class="tdHeader">
                                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="tdHeader1">
                                                1.Voltage，Frequency，and Plug type
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName">
                                                Voltage：
                                            </td>
                                            <td class="tdRowValue">
                                                <asp:Label ID="lblVoltage" runat="server" Text="Label"></asp:Label>V
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName">
                                                Frequency：
                                            </td>
                                            <td class="tdRowValue">
                                                <asp:Label ID="lblFrequency" runat="server"></asp:Label>Hz
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName" valign="top">
                                                Plug Type(s)：
                                            </td>
                                            <td class="tdRowValue">
                                                <asp:Label ID="lblPlugType" runat="server"></asp:Label>
                                                <asp:DataList ID="dlImages" runat="server" DataKeyField="GeneralImageID" RepeatColumns="1"
                                                    RepeatDirection="Horizontal" DataSourceID="sdsImage">
                                                    <ItemTemplate>
                                                        <table border="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("GeneralImageURL") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblImgDec" runat="server" Text='<%# Eval("GeneralImageDesc") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                                <asp:SqlDataSource ID="sdsImage" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    SelectCommand="SELECT * FROM [Ima_General_Images] WHERE [GeneralID] = (select GeneralID from Ima_General where country_id=@country_id)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="tdHeader1">
                                                2.Currency used by government
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName">
                                                Currency Code：
                                            </td>
                                            <td class="tdRowValue">
                                                <asp:Label ID="lblCurrency_Code" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="tdHeader1">
                                                3.Currency exchange rate
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName" valign="top">
                                                Currency exchange rate：
                                            </td>
                                            <td class="tdRowValue">
                                                1 USD to
                                                <asp:Label ID="lblExchange_rate_USD" runat="server"></asp:Label><br />
                                                1 EUR to
                                                <asp:Label ID="lblExchange_rate_EUR" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="tdHeader1">
                                                4.Country code
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName">
                                                Country code：
                                            </td>
                                            <td class="tdRowValue">
                                                +<asp:Label ID="lblCountry_Code" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="tdHeader1">
                                                5.Culture & Taboos
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="tdRowName" valign="top">
                                                Culture & Taboos：
                                            </td>
                                            <td class="tdRowValue">
                                                <asp:Label ID="lblCulture_Taboos" runat="server"></asp:Label>
                                                <asp:GridView ID="gvIma_General_Files" runat="server" DataKeyNames="GeneralFileID"
                                                    DataSourceID="sdsIma_General_Files" SkinID="gvList">
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GeneralFile.ashx?gfid="+Eval("GeneralFileID").ToString() %>'
                                                                    Text='<%# Eval("GeneralFileName").ToString()+"."+Eval("GeneralFileType").ToString() %>'
                                                                    Target="_blank"></asp:HyperLink>
                                                            </ItemTemplate>
                                                            <HeaderStyle Font-Bold="False" />
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsIma_General_Files" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    SelectCommand="SELECT * FROM [Ima_General_Files] WHERE [GeneralID] = (select GeneralID from Ima_General where country_id=@country_id)">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeGeneral" runat="server" CollapseControlID="plInfoGeneral"
                        ExpandControlID="plInfoGeneral" TargetControlID="plGeneralDetail" ImageControlID="imgExpGeneral"
                        TextLabelID="lblMsgGeneral" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--1.Government Authority(B)--%>
            <tr id="trImaB" runat="server">
                <td>
                    <asp:Panel ID="plInfoImaDetailB" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailB" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailB" runat="server">Government Authority</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailB" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailB" runat="server">
                        <asp:DataList ID="dlImaDetailB" runat="server" DataSourceID="sdsImaDetailB" DataKeyNames="GovernmentAuthorityID" cellpadding="1" cellspacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom:20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Government Authority Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Full Authority Name：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblGovernmentAuthorityID" runat="server" Text='<%#Eval("GovernmentAuthorityID") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblFullAuthorityName" runat="server" Text='<%#Eval("FullAuthorityName") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Abbreviated Authority Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblAbbreviatedAuthorityName" runat="server" Text='<%#Eval("AbbreviatedAuthorityName") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trWebsite" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Website：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblWebsite" runat="server" Text='<%#Eval("Website") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trMandatory" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Mandatory or Voluntary：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblMandatory" runat="server" Text='<%#Eval("Mandatory") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trAttach" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Attach sample certificate：</td>
                                        <td class="tdRowValue">
                                            <asp:GridView ID="gvImaBFiles1" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList" DataSourceID="sdsImaBFiles1">
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
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GoverFile.ashx?fid="+Eval("GoverAuthFileID").ToString() %>' Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsImaBFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='A'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="GovernmentAuthorityID" PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trCertificationBody" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Also certification body：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblCertificationBody" runat="server" Text='<%#Eval("CertificationBody") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trAccreditedTest" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Also accredited test lab：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblAccreditedTest" runat="server" Text='<%#Eval("AccreditedTest") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trBodyListWebsite" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">
                                            Accreditation certification<br />body list：
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblBodyListWebsite" runat="server" Text='<%#"Website :"+Eval("BodyListWebsite").ToString() %>'></asp:Label>
                                            <asp:GridView ID="gvImaFiles2" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList"
                                                DataSourceID="sdsImaFiles2">
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
                                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='C'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="GovernmentAuthorityID"
                                                        PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trLabListWebsite" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">
                                            Accreditation test lab list：
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblLabListWebsite" runat="server" Text='<%#"Website :"+Eval("LabListWebsite").ToString() %>'></asp:Label>
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
                                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='D'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="GovernmentAuthorityID"
                                                        PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trCertificateValid" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Certificate is valid for<br />Single Importer / Any Importer：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblCertificateValid" runat="server" Text='<%#Eval("CertificateValid1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Transfer of Certificate：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblTransfer" runat="server" Text='<%#Eval("IsTransfer") %>'></asp:Label>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%#Eval("Description1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                            <asp:GridView ID="gvImaBFiles" runat="server" DataKeyNames="GoverAuthFileID" SkinID="gvList" DataSourceID="sdsImaBFiles" Visible='<%#IMAUtil.IsEditOn() %>'>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex + 1%>
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
                                            <asp:SqlDataSource ID="sdsImaBFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='B'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="GovernmentAuthorityID" PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trContact" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Contact：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaBContact" runat="server" DataSourceID="sdsImaBContact" CellPadding="4" ForeColor="#333333">
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
                                            <asp:SqlDataSource ID="sdsImaBContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="B" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trLeadTime" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Lead Time：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadT" runat="server" Text='<%#Eval("LeadTime1") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trSubmission" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td colspan="2" class="tdHeader1">Submission Fee By Technologies</td>
                                    </tr>
                                    <tr id="trTechRF" runat="server" visible='<%# SetTechVisible(Eval("trTechRF")) %>'>
                                        <td class="tdRowName">RF：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaBTechRF" runat="server" DataSourceID="sdsImaBTechRF" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaBTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="B" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaBRFRemark" runat="server" Text='<%#Eval("RFRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechEMC" runat="server" visible='<%# SetTechVisible(Eval("trTechEMC")) %>'>
                                        <td class="tdRowName">EMC：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaBTechEMC" runat="server" DataSourceID="sdsImaBTechEMC" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaBTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="B" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaBEMCRemark" runat="server" Text='<%#Eval("EMCRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechSafety" runat="server" visible='<%# SetTechVisible(Eval("trTechSafety")) %>'>
                                        <td class="tdRowName">Safety：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaBTechSafety" runat="server" DataSourceID="sdsImaBTechSafety" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaBTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="B" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaBSafetyRemark" runat="server" Text='<%#Eval("SafetyRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechTelecom" runat="server" visible='<%# SetTechVisible(Eval("trTechTelecom")) %>'>
                                        <td class="tdRowName">Telecom：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaBTechTelecom" runat="server" DataSourceID="sdsImaBTechTelecom" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaBTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="B" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaBTelecomRemark" runat="server" Text='<%#Eval("TelecomRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trFeeListWebsite" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">
                                            Submission fee list：
                                        </td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblFeeListWebsite" runat="server" Text='<%#"Website :"+Eval("FeeListWebsite").ToString() %>'></asp:Label>
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
                                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='E'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblGovernmentAuthorityID" Name="GovernmentAuthorityID"
                                                        PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailB" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailBGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailB" runat="server" CollapseControlID="plInfoImaDetailB"
                        ExpandControlID="plInfoImaDetailB" TargetControlID="plImaDetailB" ImageControlID="imgExpImaDetailB"
                        TextLabelID="lblMsgImaDetailB" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--2.National governed rules and regulation(C)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailC" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailC" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailC" runat="server">National governed rules and regulation</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailC" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailC" runat="server">
                        <asp:DataList ID="dlImaDetailC" runat="server" DataSourceID="sdsImaDetailC" DataKeyNames="NationalGovID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom:20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">National government rules and regulation Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">National Regulation：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblImaCID" runat="server" Text='<%#Eval("NationalGovID") %>' Visible="false"></asp:Label>
                                            <asp:Label ID="lblImaCDescription" runat="server" Text='<%#Eval("Description") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" class="tdRowName">Files：</td>
                                        <td class="tdRowValue">
                                            <asp:GridView ID="gvImaCFiles" runat="server" DataKeyNames="NationalGovFileID" DataSourceID="sdsImaCFiles" SkinID="gvList">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="NO">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex + 1%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" Width="50px" HorizontalAlign="Center" />
                                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="FileName">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "NationalGovFile.ashx?fid="+Eval("NationalGovFileID").ToString() %>'
                                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_self"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsImaCFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="SELECT * FROM [Ima_NationalGover_Files] WHERE ([NationalGovID] = @NationalGovID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblImaCID" Name="NationalGovID" PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="select * from Ima_NationalGoverned where country_id=@country_id and wowi_product_type_id=@wowi_product_type_id"
                            SelectCommandType="Text">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailC" runat="server" CollapseControlID="plInfoImaDetailC"
                        ExpandControlID="plInfoImaDetailC" TargetControlID="plImaDetailC" ImageControlID="imgExpImaDetailC"
                        TextLabelID="lblMsgImaDetailC" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--3.Certification bodies(D)--%>
            <tr id="trImaD" runat="server">
                <td>
                    <asp:Panel ID="plInfoImaDetailD" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailD" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailD" runat="server">Certification bodies</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailD" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailD" runat="server">
                        <asp:DataList ID="dlImaDetailD" runat="server" DataSourceID="sdsImaDetailD" DataKeyNames="CertificationBodiesID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader"> Certification bodies Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblName" runat="server" Text='<%#Eval("Name") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Authority：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblAuthority" runat="server" Text='<%#Eval("Authority1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Also accredited test lab：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblAccreditedTest" runat="server" Text='<%#Eval("AccreditedTest") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Certification Body：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblCB" runat="server" Text='<%#Eval("CertificationBody1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Volume Per Year：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblVolumePerYear" runat="server" Text='<%#Eval("VolumePerYear") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Publish：</td>
                                        <td class="tdRowValue" align="left">
                                            <asp:Label ID="lblPublish" runat="server" Text='<%#Eval("Publish2") %>'></asp:Label>
                                            <asp:Label ID="lblWebsite" runat="server" Text='<%#Eval("Website2") %>'></asp:Label>
                                            <asp:Label ID="lblCertificationBodiesID" runat="server" Text='<%#Eval("CertificationBodiesID") %>' Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Contact：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaDContact" runat="server" DataSourceID="sdsImaDContact" CellPadding="4" ForeColor="#333333">
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
                                            <asp:SqlDataSource ID="sdsImaDContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblCertificationBodiesID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="D" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Lead Time：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadT" runat="server" Text='<%#Eval("LeadTime1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tdHeader1">Certification Body Fee by Technologies</td>
                                    </tr>
                                    <tr id="trTechRF" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechRF")) %>'>
                                        <td class="tdRowName">RF：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaDTechRF" runat="server" DataSourceID="sdsImaDTechRF" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaDTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblCertificationBodiesID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="D" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaDRFRemark" runat="server" Text='<%#Eval("RFRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechEMC" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechEMC")) %>'>
                                        <td class="tdRowName">EMC：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaDTechEMC" runat="server" DataSourceID="sdsImaDTechEMC" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaDTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblCertificationBodiesID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="D" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaDEMCRemark" runat="server" Text='<%#Eval("EMCRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechSafety" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechSafety")) %>'>
                                        <td class="tdRowName">Safety：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaDTechSafety" runat="server" DataSourceID="sdsImaDTechSafety" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaDTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblCertificationBodiesID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="D" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaDSafetyRemark" runat="server" Text='<%#Eval("SafetyRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechTelecom" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechTelecom")) %>'>
                                        <td class="tdRowName">Telecom：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaDTechTelecom" runat="server" DataSourceID="sdsImaDTechTelecom" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaDTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblCertificationBodiesID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="D" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaDTelecomRemark" runat="server" Text='<%#Eval("TelecomRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailD" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_ImaDetailDGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailD" runat="server" CollapseControlID="plInfoImaDetailD"
                        ExpandControlID="plInfoImaDetailD" TargetControlID="plImaDetailD" ImageControlID="imgExpImaDetailD"
                        TextLabelID="lblMsgImaDetailD" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--4.Accredited Test Lab(Q)--%>
            <tr id="trImaQ" runat="server">
                <td>
                    <asp:Panel ID="plInfoImaDetailQ" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailQ" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailQ" runat="server">Accredited Test Lab</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailQ" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailQ" runat="server">
                        <asp:DataList ID="dlImaDetailQ" runat="server" DataSourceID="sdsImaDetailQ" DataKeyNames="AccreditedTestID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Accredited Test Lab Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Accredited Lab：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblAccreditedLab" runat="server" Text='<%#Eval("AccreditedLab") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Volume Per Year：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblVolumePerYear" runat="server" Text='<%#Eval("VolumePerYear") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Publish：</td>
                                        <td class="tdRowValue" align="left">
                                            <asp:Label ID="lblPublish" runat="server" Text='<%#Eval("Publish1") %>'></asp:Label>
                                            <asp:Label ID="lblWebsite" runat="server" Text='<%#Eval("Website1") %>'></asp:Label>
                                            <asp:Label ID="lblAccreditedTestID" runat="server" Text='<%#Eval("AccreditedTestID") %>' Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Contact：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaQContact" runat="server" DataSourceID="sdsImaQContact" CellPadding="4" ForeColor="#333333">
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
                                            <asp:SqlDataSource ID="sdsImaQContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblAccreditedTestID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="Q" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Lead Time：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadT" runat="server" Text='<%#Eval("LeadTime1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tdHeader1">Test Fee by Technologies</td>
                                    </tr>
                                    <tr id="trTechRF" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechRF")) %>'>
                                        <td class="tdRowName">RF：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaQTechRF" runat="server" DataSourceID="sdsImaQTechRF" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaQTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblAccreditedTestID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="Q" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaQRFRemark" runat="server" Text='<%#Eval("RFRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechEMC" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechEMC")) %>'>
                                        <td class="tdRowName">EMC：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaQTechEMC" runat="server" DataSourceID="sdsImaQTechEMC" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaQTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblAccreditedTestID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="Q" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaQEMCRemark" runat="server" Text='<%#Eval("EMCRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechSafety" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechSafety")) %>'>
                                        <td class="tdRowName">Safety：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaQTechSafety" runat="server" DataSourceID="sdsImaQTechSafety" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaQTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblAccreditedTestID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="Q" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaQSafetyRemark" runat="server" Text='<%#Eval("SafetyRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechTelecom" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechTelecom")) %>'>
                                        <td class="tdRowName">Telecom：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaQTechTelecom" runat="server" DataSourceID="sdsImaQTechTelecom" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaQTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblAccreditedTestID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="Q" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaQTelecomRemark" runat="server" Text='<%#Eval("TelecomRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailQ" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_ImaDetailQGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailQ" runat="server" CollapseControlID="plInfoImaDetailQ"
                        ExpandControlID="plInfoImaDetailQ" TargetControlID="plImaDetailQ" ImageControlID="imgExpImaDetailQ"
                        TextLabelID="lblMsgImaDetailQ" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--5.Products Control(G)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailG" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailG" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailG" runat="server">Products Control</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailG" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailG" runat="server">
                        <asp:DataList ID="dlImaDetailG" runat="server" DataSourceID="sdsImaDetailG" DataKeyNames="ProductControlID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Products Control Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">
                                            Control List：
                                        </td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblProductControlID" runat="server" Text='<%#Eval("ProductControlID") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblControlList" runat="server" Text='<%#Eval("ControlList").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaGFiles" runat="server" SkinID="gvList" DataKeyNames="ProductControlFileID" DataSourceID="sdsImaGFiles">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ProductControlFile.ashx?fid="+Eval("ProductControlFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaGFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_ProductsControl_Files] WHERE ([ProductControlID] = @ProductControlID)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProductControlID" Name="ProductControlID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailG" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="select * from Ima_ProductsControl where country_id=@country_id and wowi_product_type_id=@wowi_product_type_id" >
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailG" runat="server" CollapseControlID="plInfoImaDetailG"
                        ExpandControlID="plInfoImaDetailG" TargetControlID="plImaDetailG" ImageControlID="imgExpImaDetailG"
                        TextLabelID="lblMsgImaDetailG" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--6.Test Standards(H)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailH" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailH" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailH" runat="server">Test Standards</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailH" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailH" runat="server">
                        <asp:DataList ID="dlImaDetailH" runat="server" DataSourceID="sdsImaDetailH" DataKeyNames="StandardID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Standards Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top"><asp:Label ID="lblFCCTitle" runat="server" Text='<%#Eval("FCCTitle")%>'></asp:Label></td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblFCCorIECorCE" runat="server" Text='<%#Eval("FCCorIECorCE")%>'></asp:Label>
                                            <asp:Label ID="lblOthers" runat="server" Text='<%#Eval("Others1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top"><asp:Label ID="lblRequiredTitle" runat="server" Text='<%#Eval("RequiredTitle")%>'></asp:Label></td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblRequired" runat="server" Text='<%#Eval("Required")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">List harmonizes standards：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblStandardDesc" runat="server" Text='<%#Eval("StandardDesc")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trLocalStandards" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Files：</td>
                                        <td class="tdRowValue" align="left">
                                            <asp:Label ID="lblLocalStandards" runat="server" Visible="false" Text='<%#Eval("LocalStandards")%>'></asp:Label>
                                            <asp:Label ID="lblStandardID" runat="server" Visible="false" Text='<%#Eval("StandardID")%>'></asp:Label>
                                            <asp:GridView ID="gvImaHFile1" runat="server" SkinID="gvList" DataKeyNames="StandardFileID" DataSourceID="sdsImaHFile1">
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
                                            <asp:SqlDataSource ID="sdsImaHFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="SELECT * FROM [Ima_Standard_Files] WHERE ([StandardID] = @StandardID) and FileCategory='A'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblStandardID" Name="StandardID" PropertyName="Text" Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr id="trTechStandards" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td colspan="2" class="tdHeader1">Local Standards by Technologies</td>
                                    </tr>
                                    <tr id="trTechRF" runat="server" visible='<%# SetTechVisible(Eval("trTechRF")) %>'>
                                        <td class="tdRowName" valign="top">RF：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaHTechRF" runat="server" DataSourceID="sdsImaHTechRF" DataKeyField="wowi_tech_id" RepeatColumns="2" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbRFFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaHTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblStandardID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="H" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaHRFRemark" runat="server" Text='<%#Eval("RFRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechEMC" runat="server" visible='<%# SetTechVisible(Eval("trTechEMC")) %>'>
                                        <td class="tdRowName" valign="top">EMC：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaHTechEMC" runat="server" DataSourceID="sdsImaHTechEMC" DataKeyField="wowi_tech_id" RepeatColumns="2" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbEMCFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaHTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblStandardID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="H" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaHEMCRemark" runat="server" Text='<%#Eval("EMCRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechSafety" runat="server" visible='<%# SetTechVisible(Eval("trTechSafety")) %>'>
                                        <td class="tdRowName" valign="top">Safety：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaHTechSafety" runat="server" DataSourceID="sdsImaHTechSafety" DataKeyField="wowi_tech_id" RepeatColumns="2" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbSafetyFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaHTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblStandardID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="H" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaHSafetyRemark" runat="server" Text='<%#Eval("SafetyRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trTechTelecom" runat="server" visible='<%# SetTechVisible(Eval("trTechTelecom")) %>'>
                                        <td class="tdRowName" valign="top">Telecom：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaHTechTelecom" runat="server" DataSourceID="sdsImaHTechTelecom" DataKeyField="wowi_tech_id" RepeatColumns="2" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table border="0">
                                                        <tr>
                                                            <td><asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                            <td><asp:TextBox ID="tbTelecomFee" runat="server" Width="200px" Enabled="false" Text='<%#Eval("Description") %>'></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:SqlDataSource ID="sdsImaHTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                <SelectParameters>
                                                    <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:ControlParameter ControlID="lblStandardID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="H" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblImaHTelecomRemark" runat="server" Text='<%#Eval("TelecomRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailH" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailHGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailH" runat="server" CollapseControlID="plInfoImaDetailH"
                        ExpandControlID="plInfoImaDetailH" TargetControlID="plImaDetailH" ImageControlID="imgExpImaDetailH"
                        TextLabelID="lblMsgImaDetailH" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--7.Local Agent(F)--%>
            <tr id="trImaF" runat="server">
                <td>
                    <asp:Panel ID="plInfoImaDetailF" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailF" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailF" runat="server">Local Agent</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailF" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailF" runat="server">
                        <asp:DataList ID="dlImaDetailF" runat="server" DataSourceID="sdsImaDetailF" DataKeyNames="LocalAgentID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Local Agent Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblName" runat="server" Text='<%#Eval("Name") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Local Angent Type：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblAngentType" runat="server" Text='<%#Eval("AngentType") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Credit：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblCredit" runat="server" Text='<%#Eval("Credit") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Signed NDA：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblNDAYes" runat="server" Text='<%#Eval("NDAYes1") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblLocalAgentID" runat="server" Text='<%#Eval("LocalAgentID") %>' Visible="false"></asp:Label>
                                                        <asp:GridView ID="gvImaFFile1" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile1">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Signed MOU：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblMOUYes" runat="server" Text='<%#Eval("MOUYes1") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaFFile2" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile2">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='B'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Contact：</td>
                                        <td class="tdRowValue">
                                            <asp:DataList ID="dlImaFContact" runat="server" DataSourceID="sdsImaFContact" CellPadding="4" ForeColor="#333333">
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
                                            <asp:SqlDataSource ID="sdsImaFContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetContactByDIDCategory" SelectCommandType="StoredProcedure">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblLocalAgentID" Name="DID" PropertyName="Text" Type="Int32" />
                                                    <asp:Parameter Name="Categroy" Type="String" DefaultValue="F" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Local Rep. Service：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLocalRep" runat="server" Text='<%#Eval("LocalRep1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Lead Time：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadT" runat="server" Text='<%#Eval("LeadTime1") %>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="tdHeader1">Local Agent Fee by Technologies</td>
                                    </tr>
                                    <tr id="trTechRF" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechRF")) %>'>
                                        <td class="tdRowName">RF：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="dlImaFTechRF" runat="server" DataSourceID="sdsImaFTechRF" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                            <ItemTemplate>
                                                                <table border="0">
                                                                    <tr>
                                                                        <td><asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                                        <td><asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsImaFTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="Categroy" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblImaFRFRemark" runat="server" Text='<%#Eval("RFRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaFFile3" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile3">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='C'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trTechEMC" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechEMC")) %>'>
                                        <td class="tdRowName">EMC：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="dlImaFTechEMC" runat="server" DataSourceID="sdsImaFTechEMC" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                            <ItemTemplate>
                                                                <table border="0">
                                                                    <tr>
                                                                        <td><asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                                        <td><asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsImaFTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="Categroy" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblImaFEMCRemark" runat="server" Text='<%#Eval("EMCRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaFFile4" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile4">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='D'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text"  Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trTechSafety" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechSafety")) %>'>
                                        <td class="tdRowName">Safety：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="dlImaFTechSafety" runat="server" DataSourceID="sdsImaFTechSafety" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                            <ItemTemplate>
                                                                <table border="0">
                                                                    <tr>
                                                                        <td><asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                                        <td><asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsImaFTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="Categroy" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblImaFSafetyRemark" runat="server" Text='<%#Eval("SafetyRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaFFile5" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile5">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='E'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trTechTelecom" runat="server" visible='<%# Convert.ToBoolean(Eval("trTechTelecom")) %>'>
                                        <td class="tdRowName">Telecom：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:DataList ID="dlImaFTechTelecom" runat="server" DataSourceID="sdsImaFTechTelecom" DataKeyField="wowi_tech_id" RepeatColumns="3" RepeatDirection="Horizontal">
                                                            <ItemTemplate>
                                                                <table border="0">
                                                                    <tr>
                                                                        <td><asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label></td>
                                                                        <td><asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled="false" Text='<%#Eval("Fee") %>'></asp:TextBox>USD</td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsImaFTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure" FilterExpression="DID is not null">
                                                            <SelectParameters>
                                                                <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="Categroy" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblImaFTelecomRemark" runat="server" Text='<%#Eval("TelecomRemark1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaFFile6" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaFFile6">
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
                                                        <asp:SqlDataSource ID="sdsImaFFile6" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='F'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblLocalAgentID" Name="DocID" PropertyName="Text"
                                                                    Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="F" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailFGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailF" runat="server" CollapseControlID="plInfoImaDetailF"
                        ExpandControlID="plInfoImaDetailF" TargetControlID="plImaDetailF" ImageControlID="imgExpImaDetailF"
                        TextLabelID="lblMsgImaDetailF" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--8.Application Procedures(J)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailJ" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailJ" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailJ" runat="server">Application Procedures</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailJ" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailJ" runat="server">
                        <asp:DataList ID="dlImaDetailJ" runat="server" DataSourceID="sdsImaDetailJ" DataKeyNames="ApplicationID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Application Procedures Detail</td>
                                    </tr>
                                    <tr id="trApprovalMethod" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Name of approval method：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblApprovalMethod" runat="server" Text='<%#Eval("ApprovalMethod1") %>'></asp:Label>
                                            <asp:Label ID="lblOtherApprovalMethod" runat="server" Text='<%#Eval("OtherApprovalMethod1") %>'></asp:Label>
                                            <asp:Label ID="lblApplicationID" runat="server" Text='<%#Eval("ApplicationID") %>' Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trSubmissMenthod" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission Methods：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblSubmissMenthod" runat="server" Text='<%#Eval("SubmissMenthod") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trInPerson" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission in-person：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblInPerson" runat="server" Text='<%#Eval("InPerson") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trHardCopy" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission w/ Hard Copy：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblHardCopy" runat="server" Text='<%#Eval("HardCopy") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trSubmissionWebsite" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission w/ Website：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblWebsite" runat="server" Text='<%#Eval("Website") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trEmail" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission w/ Email：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email") %>'></asp:Label></td>
                                    </tr>
                                    <tr id="trCD" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Submission w/ CD：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblCD" runat="server" Text='<%#Eval("CD") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblSubmissionDesc" runat="server" Text='<%#Eval("SubmissionDesc1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile1" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID" DataSourceID="sdsImaJFile1">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaJFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblApplicationID" Name="ApplicationID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Accepts：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblAccept" runat="server" Text='<%#Eval("Accept")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Samples required：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblSamplesRequired" runat="server" Text='<%#Eval("SamplesRequired1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Modular Approval acceptable：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblModular" runat="server" Text='<%#Eval("Modular")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblModularDesc" runat="server" Text='<%#Eval("ModularDesc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trModularFiles" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile2" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID" DataSourceID="sdsImaJFile2">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaJFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='B'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblApplicationID" Name="ApplicationID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Local Representative required：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblRepresentative" runat="server" Text='<%#Eval("Representative")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblRepresentativeDesc" runat="server" Text='<%#Eval("RepresentativeDesc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trLocalFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile3" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID" DataSourceID="sdsImaJFile3">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaJFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='C'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblApplicationID" Name="ApplicationID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Expedited Process Available ：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblExpeditedProcess" runat="server" Text='<%#Eval("ExpeditedProcess")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblExpeditedProcessDesc" runat="server" Text='<%#Eval("ExpeditedProcessDesc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trExpeditedFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile4" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID" DataSourceID="sdsImaJFile4">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaJFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='D'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblApplicationID" Name="ApplicationID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Certification Control by：</td>
                                        <td class="tdRowValue" align="left">
                                            <asp:Label ID="lblControlBy" runat="server" Text='<%#Eval("ControlBy")%>'></asp:Label>
                                            <asp:Label ID="lblControlByOther" runat="server" Text='<%#Eval("ControlByOther1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Multiple Model Names listed：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblMMNamesListed" runat="server" Text='<%#Eval("MMNamesListed")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Adding model after approval ：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblAfterApproval" runat="server" Text='<%#Eval("AfterApproval")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblModelDesc" runat="server" Text='<%#Eval("ModelDesc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trAfterApprovalFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile5" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID" DataSourceID="sdsImaJFile5">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaJFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='E'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblApplicationID" Name="ApplicationID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trOriginRequired" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Declaration of Origin required：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblOriginRequired" runat="server" Text='<%#Eval("OriginRequired")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trContractRequired" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Contract required<br />with Local Agent：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblContractRequired" runat="server" Text='<%#Eval("ContractRequired")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trNotarizedPoARequired" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Notarized PoA required<br />with Local Agent：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblNotarizedPoARequired" runat="server" Text='<%#Eval("NotarizedPoARequired")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Certificate Number/ID<br />created by：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblCertificateIDCreateBy" runat="server" Text='<%#Eval("CertificateIDCreateBy")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Possible to get certificate number<br />before certificate issuance t：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblGetCertificateNumber" runat="server" Text='<%#Eval("GetCertificateNumber")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Provisional Certificate Y/N & Validity：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td><asp:Label ID="lblProvisional" runat="server" Text='<%#Eval("Provisional")%>'></asp:Label></td>
                                                                <td><asp:Label ID="lblProvisionalYearsMonths" runat="server" Text='<%#Eval("ProvisionalYearsMonths")%>'></asp:Label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Validity of Certificate：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td><asp:Label ID="lblValidity" runat="server" Text='<%#Eval("Validity")%>'></asp:Label></td>
                                                                <td><asp:Label ID="lblYearsMonths" runat="server" Text='<%#Eval("YearsMonths")%>'></asp:Label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Periodic Certificate Y/N & Validity：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td><asp:Label ID="lblPeriodic" runat="server" Text='<%#Eval("Periodic")%>'></asp:Label></td>
                                                                <td><asp:Label ID="lblPeriodicDate" runat="server" Text='<%#Eval("PeriodicDate")%>'></asp:Label></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trShipment" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Certificate by Shipment/Quantity：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblShipment" runat="server" Text='<%#Eval("Shipment")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailJ" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailJGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailJ" runat="server" CollapseControlID="plInfoImaDetailJ"
                        ExpandControlID="plInfoImaDetailJ" TargetControlID="plImaDetailJ" ImageControlID="imgExpImaDetailJ"
                        TextLabelID="lblMsgImaDetailJ" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--Testing and submission preparation(K)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailK" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailK" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailK" runat="server">Testing and submission preparation</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailK" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailK" runat="server">
                        <asp:DataList ID="dlImaDetailK" runat="server" DataSourceID="sdsImaDetailK" DataKeyNames="TestingID"
                            CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Testing and submission preparation Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Document language acceptance：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblLanguage" runat="server" Text='<%#Eval("Language1")%>'></asp:Label>
                                                        <asp:Label ID="lblTestingID" runat="server" Text='<%#Eval("TestingID")%>' Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblLanguageDesc" runat="server" Text='<%#Eval("LanguageDesc")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trTestingFile1" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaKFile1" runat="server" SkinID="gvList" DataKeyNames="TestingFileID" DataSourceID="sdsImaKFile1">
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
                                                        <asp:SqlDataSource ID="sdsImaKFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblTestingID" Name="TestingID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Testing Sample Label Marking：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblTestMark" runat="server" Text='<%#Eval("TestMark1")%>'></asp:Label>
                                                        <asp:Label ID="lblTestMarkRemark" runat="server" Text='<%#Eval("TestMarkRemark1")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trTestMark" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaKFile4" runat="server" SkinID="gvList" DataKeyNames="TestingFileID" DataSourceID="sdsImaKFile4">
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
                                                        <asp:SqlDataSource ID="sdsImaKFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='D'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblTestingID" Name="TestingID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trEUTInfo" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">EUT Info：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblEUTInfo" runat="server" Text='<%#Eval("EUTInfo")%>'></asp:Label>
                                            <asp:Label ID="lblManual" runat="server" Text='<%#Eval("Manual1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Test Report/Certification：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblCertification" runat="server" Text='<%#Eval("Certification")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblOtherInternationally" runat="server" Text='<%#Eval("OtherInternationally1")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trCertificationReport" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaKFile2" runat="server" SkinID="gvList" DataKeyNames="TestingFileID" DataSourceID="sdsImaKFile2">
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
                                                        <asp:SqlDataSource ID="sdsImaKFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='B'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblTestingID" Name="TestingID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Technical Documents：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblTechnicalDocs" runat="server" Text='<%#Eval("TechnicalDocs")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblTechnical" runat="server" Text='<%#Eval("Technical1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblAntenna" runat="server" Text='<%#Eval("Antenna1")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Other Documents：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblOtherDoc1" runat="server" Text='<%#Eval("OtherDoc1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblOtherDocRequest" runat="server" Text='<%#Eval("OtherDocRequest1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trOtherFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaJFile3" runat="server" SkinID="gvList" DataKeyNames="TestingFileID" DataSourceID="sdsImaJFile3">
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
                                                        <asp:SqlDataSource ID="sdsImaJFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='C'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblTestingID" Name="TestingID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Radiated Sample for testing：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblRadiated" runat="server" Text='<%#Eval("Radiated1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Conducted Sample for testing：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblConducted" runat="server" Text='<%#Eval("Conducted1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Normal-Link Sample for testing：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblNormalLink" runat="server" Text='<%#Eval("NormalLink1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Consumer Sample for review only：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblReviewOnly" runat="server" Text='<%#Eval("ReviewOnly1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trPreInstalled" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Pre-install test software<br />or send by CD, email, or FTP：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblPreInstalled" runat="server" Text='<%#Eval("PreInstalled1")%>'></asp:Label>
                                            <asp:Label ID="lblTestNote" runat="server" Text='<%#Eval("TestNote1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trRemark" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Remark：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailK" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailKGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailK" runat="server" CollapseControlID="plInfoImaDetailK"
                        ExpandControlID="plInfoImaDetailK" TargetControlID="plImaDetailK" ImageControlID="imgExpImaDetailK"
                        TextLabelID="lblMsgImaDetailK" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--10.Sample shipping(M)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailM" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailM" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailM" runat="server">Sample shipping</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailM" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailM" runat="server">
                        <asp:DataList ID="dlImaDetailM" runat="server" DataSourceID="sdsImaDetailM" DataKeyNames="SampleShippingID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Sample shipping Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Which carrier is preferable：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCarrier" runat="server" Text='<%#Eval("Carrier")%>'></asp:Label>
                                                        <asp:Label ID="lblOtherCarrier" runat="server" Text='<%#Eval("OtherCarrier1")%>'></asp:Label>
                                                        <asp:Label ID="lblSampleShippingID" runat="server" Text='<%#Eval("SampleShippingID")%>' Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblCarrierDesc" runat="server" Text='<%#Eval("CarrierDesc1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaMFile1" runat="server" SkinID="gvList" DataKeyNames="SampleShippingFileID" DataSourceID="sdsImaMFile1">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "SampleShippingFile.ashx?fid="+Eval("SampleShippingFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaMFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_SampleShipping_Files] WHERE ([SampleShippingID] = @SampleShippingID) and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblSampleShippingID" Name="SampleShippingID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Any documents for sample shipping：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblSampleDoc" runat="server" Text='<%#Eval("SampleDoc")%>'></asp:Label>
                                            <asp:Label ID="lblOtherSampleShipping" runat="server" Text='<%#Eval("OtherSampleShipping1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">How much value to declare to prevent<br />from local customs’ auditing sample：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblUnderUSD" runat="server" Text='<%#Eval("UnderUSD1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Mark sample for testing without commercial value on the<br />invoice and packing list OR declare actual commercial value ：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblMarksample" runat="server" Text='<%#Eval("Marksample")%>'></asp:Label>
                                            <asp:Label ID="lblNote" runat="server" Text='<%#Eval("Note1")%>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Samples can be returned：</td>
                                        <td class="tdRowValue">
                                            <asp:Label ID="lblReturned" runat="server" Text='<%#Eval("Returned")%>'></asp:Label>
                                            <asp:Label ID="lblReturnedNote" runat="server" Text='<%#Eval("ReturnedNote1")%>'></asp:Label>
                                            <asp:GridView ID="gvImaMFile2" runat="server" SkinID="gvList" DataKeyNames="SampleShippingFileID"
                                                DataSourceID="sdsImaMFile2">
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
                                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "SampleShippingFile.ashx?fid="+Eval("SampleShippingFileID").ToString() %>'
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
                                            <asp:SqlDataSource ID="sdsImaMFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="SELECT * FROM [Ima_SampleShipping_Files] WHERE ([SampleShippingID] = @SampleShippingID) and FileCategory='B'">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblSampleShippingID" Name="SampleShippingID" PropertyName="Text"
                                                        Type="Int32" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailM" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailMGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailM" runat="server" CollapseControlID="plInfoImaDetailM"
                        ExpandControlID="plInfoImaDetailM" TargetControlID="plImaDetailM" ImageControlID="imgExpImaDetailM"
                        TextLabelID="lblMsgImaDetailM" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--11.Periodic Factory inspection(N)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailN" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailN" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailN" runat="server">Periodic Factory inspection</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailN" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailN" runat="server">
                        <asp:DataList ID="dlImaDetailN" runat="server" DataSourceID="sdsImaDetailN" DataKeyNames="PeriodicID"
                            CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Periodic Factory inspection Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Factory Inspection：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td><asp:Label ID="lblFactoryInspection" runat="server" Text='<%#Eval("FactoryInspection1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblInspection" runat="server" Text='<%#Eval("Inspection")%>'></asp:Label>
                                                        <asp:Label ID="lblPeriodicID" runat="server" Text='<%#Eval("PeriodicID")%>' Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblPeriodicDesc" runat="server" Text='<%#Eval("PeriodicDesc1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaNFile1" runat="server" SkinID="gvList" DataKeyNames="PeriodicFileID" DataSourceID="sdsImaNFile1">
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
                                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PeriodicFile.ashx?fid="+Eval("PeriodicFileID").ToString() %>'
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
                                                        <asp:SqlDataSource ID="sdsImaNFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Periodic_Files] WHERE ([PeriodicID] = @PeriodicID) and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblPeriodicID" Name="PeriodicID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Factory Inspection Fee：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblDocumentFee" runat="server" Text='<%#Eval("DocumentFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblOneTimeFee" runat="server" Text='<%#Eval("OneTimeFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblPeriodicFee" runat="server" Text='<%#Eval("PeriodicFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblOtherFee" runat="server" Text='<%#Eval("OtherFee1")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailN" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailNGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailN" runat="server" CollapseControlID="plInfoImaDetailN"
                        ExpandControlID="plInfoImaDetailN" TargetControlID="plImaDetailN" ImageControlID="imgExpImaDetailN"
                        TextLabelID="lblMsgImaDetailN" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--12.Certificate Deliver(O)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailO" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailO" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailO" runat="server">Certificate Deliver</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailO" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailO" runat="server">
                        <asp:DataList ID="dlImaDetailO" runat="server" DataSourceID="sdsImaDetailO" DataKeyNames="CertificateID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Certificate Deliver Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Types of enforcement applied：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblEmail" runat="server" Text='<%#Eval("Email1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblCopy" runat="server" Text='<%#Eval("Copy1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblCollect" runat="server" Text='<%#Eval("Collect1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblLocal" runat="server" Text='<%#Eval("Local1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblProof" runat="server" Text='<%#Eval("Proof1")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailO" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailOGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailO" runat="server" CollapseControlID="plInfoImaDetailO"
                        ExpandControlID="plInfoImaDetailO" TargetControlID="plImaDetailO" ImageControlID="imgExpImaDetailO"
                        TextLabelID="lblMsgImaDetailO" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--13.Label and Renewal(P)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailP" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailP" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailP" runat="server">Label and Renewal</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailP" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailP" runat="server">
                        <asp:DataList ID="dlImaDetailP" runat="server" DataSourceID="sdsImaDetailP" DataKeyNames="PostID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Label and Renewal Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Label Requirement：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblRequirement" runat="server" Text='<%#Eval("Requirement")%>'></asp:Label>
                                                        <asp:Label ID="lblPostID" runat="server" Text='<%#Eval("PostID")%>' Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trRequirementDesc" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblRequirementDesc" runat="server" Text='<%#Eval("RequirementDesc1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trRequirementFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaPFile1" runat="server" SkinID="gvList" DataKeyNames="PostFileID" DataSourceID="sdsImaPFile1">
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
                                                        <asp:SqlDataSource ID="sdsImaPFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblPostID" Name="PostID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr id="trPrint" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblPrint" runat="server" Text='<%#Eval("Print1")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trPurchase" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblPurchase" runat="server" Text='<%#Eval("Purchase1")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trManufacturer" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblManufacturer" runat="server" Text='<%#Eval("Manufacturer1")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trImportation" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblImportation" runat="server" Text='<%#Eval("Importation1")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trLabelsDesc" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td><asp:Label ID="lblLabelsDesc" runat="server" Text='<%#Eval("LabelsDesc1").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Label Location：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblProduct" runat="server" Text='<%#Eval("Product1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT1" runat="server" Text='<%#Eval("EUT11")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT2" runat="server" Text='<%#Eval("EUT21")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT3" runat="server" Text='<%#Eval("EUT31")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT4" runat="server" Text='<%#Eval("EUT41")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT5" runat="server" Text='<%#Eval("EUT51")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT6" runat="server" Text='<%#Eval("EUT61")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT7" runat="server" Text='<%#Eval("EUT71")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblEUT8" runat="server" Text='<%#Eval("EUT81")%>'></asp:Label></td>
                                                </tr>
                                                <tr id="trLabelLocationFile" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                                    <td>
                                                        <asp:GridView ID="gvImaPFile2" runat="server" SkinID="gvList" DataKeyNames="PostFileID" DataSourceID="sdsImaPFile2">
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
                                                        <asp:SqlDataSource ID="sdsImaPFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='B'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblPostID" Name="PostID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trWarningStatement" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Warning Statement：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblRequiredDesc" runat="server" Text='<%#Eval("RequiredDesc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaPFile3" runat="server" SkinID="gvList" DataKeyNames="PostFileID" DataSourceID="sdsImaPFile3">
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
                                                        <asp:SqlDataSource ID="sdsImaPFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='C'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblPostID" Name="PostID" PropertyName="Text" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Renewal：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblRenewal" runat="server" Text='<%#Eval("Renewal1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trRequired" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Test Required：</td>
                                        <td class="tdRowValue" align="left"><asp:Label ID="lblRequired" runat="server" Text='<%#Eval("Required1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trCostTest1" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Cost W/Test：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblCost1" runat="server" Text='<%#Eval("CostTest11")%>'></asp:Label></td>
                                                    <td><asp:Label ID="lblLeadTime1" runat="server" Text='<%#Eval("LeadTime11")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trCostTest2" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Cost W/O Test：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblCost2" runat="server" Text='<%#Eval("CostTest21")%>'></asp:Label></td>
                                                    <td><asp:Label ID="lblLeadTime2" runat="server" Text='<%#Eval("LeadTime21")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Renewal Validity：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblYearMonth" runat="server" Text='<%#Eval("YearMonth")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Renewal Required Document：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblRequiredDoc" runat="server" Text='<%#Eval("RequiredDoc").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trLabelRenewalRemark" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Remark：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailP" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailPGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailP" runat="server" CollapseControlID="plInfoImaDetailP"
                        ExpandControlID="plInfoImaDetailP" TargetControlID="plImaDetailP" ImageControlID="imgExpImaDetailP"
                        TextLabelID="lblMsgImaDetailP" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--14.Enforcement & Importation–Market Inspection(E)--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetailE" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailE" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailE" runat="server">Enforcement & Importation–Market Inspection</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailE" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailE" runat="server">
                        <asp:DataList ID="dlImaDetailE" runat="server" DataSourceID="sdsImaDetailE" DataKeyNames="EnforcementID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Enforcement & Importation–Market Inspection Detail</td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Types of enforcement applied：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblCustom" runat="server" Text='<%#Eval("Custom1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblMarket" runat="server" Text='<%#Eval("Market1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblFactory" runat="server" Text='<%#Eval("Factory1")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName">Remark：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark").ToString().Replace(Convert.ToChar(10).ToString(), "<br>")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailE" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailEGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailE" runat="server" CollapseControlID="plInfoImaDetailE"
                        ExpandControlID="plInfoImaDetailE" TargetControlID="plImaDetailE" ImageControlID="imgExpImaDetailE"
                        TextLabelID="lblMsgImaDetailE" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--15.Fee schedule(L)--%>
            <tr id="trImaL" runat="server">
                <td>
                    <asp:Panel ID="plInfoImaDetailL" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetailL" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetailL" runat="server">Fee schedule</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetailL" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetailL" runat="server">
                        <asp:DataList ID="dlImaDetailL" runat="server" DataSourceID="sdsImaDetailL" DataKeyNames="FeeScheduleID" CellPadding="1" CellSpacing="1" border="0">
                            <ItemTemplate>
                                <%# "#Data" + (Container.ItemIndex + 1).ToString()%>
                                <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" style="margin-bottom: 20px">
                                    <tr>
                                        <td colspan="2" class="tdHeader">Fee schedule Detail</td>
                                    </tr>
                                    <tr id="trTechName" runat="server">
                                        <td class="tdRowName">Technologies：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblTechName" runat="server" Text='<%#Eval("wowi_tech_name")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trLocalAgent" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Local Agent Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLocalAgent" runat="server" Text='<%#Eval("Name")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trAgentFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Agent handling Fee：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblAgentFee" runat="server" Text='<%#Eval("AgentFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trAuthority" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Authority Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblAuthority" runat="server" Text='<%#Eval("AbbreviatedAuthorityName")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trAuthorityFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Authority submission Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblAuthorityFee" runat="server" Text='<%#Eval("AuthorityFee1")%>'></asp:Label>
                                                        <asp:Label ID="lblFeeScheduleID" runat="server" Text='<%#Eval("FeeScheduleID")%>' Visible="false"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaLFiles1" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaLFiles1">
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
                                                        <asp:SqlDataSource ID="sdsImaLFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='A'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblFeeScheduleID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="L" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trCBName" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Certification Body Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblCertification" runat="server" Text='<%#Eval("CBName")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trCBFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Certification Body<br />submission Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCertificationBodyFee" runat="server" Text='<%#Eval("CertificationBodyFee1")%>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaLFile2" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaLFile2">
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
                                                        <asp:SqlDataSource ID="sdsImaLFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='B'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblFeeScheduleID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="L" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trAccreditedLab" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Accredited Test Lab Name：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblAccredited" runat="server" Text='<%#Eval("AccreditedLab")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trLabTestFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Lab Testing Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td><asp:Label ID="lblLabTestFee" runat="server" Text='<%#Eval("LabTestFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaLFile3" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaLFile3">
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
                                                        <asp:SqlDataSource ID="sdsImaLFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='C'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblFeeScheduleID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="L" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trDocTranslationFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Document translation Fee：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblDocTranslationFee" runat="server" Text='<%#Eval("DocTranslationFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trBankFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Bank Fee：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblBankFee" runat="server" Text='<%#Eval("BankFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trClearanceFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Custom clearance Fee：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblClearanceFee" runat="server" Text='<%#Eval("ClearanceFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trSampleReturnFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName">Sample return Fee：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblSampleReturnFee" runat="server" Text='<%#Eval("SampleReturnFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trLabelPurchaseFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Label purchase Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblLabelPurchaseFee" runat="server" Text='<%#Eval("LabelPurchaseFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaLFile4" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaLFile4">
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
                                                        <asp:SqlDataSource ID="sdsImaLFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='D'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblFeeScheduleID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="L" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trOtherFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Other Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblOtherFee" runat="server" Text='<%#Eval("OtherFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvImaLFile5" runat="server" SkinID="gvList" DataKeyNames="FileID" DataSourceID="sdsImaLFile5">
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
                                                        <asp:SqlDataSource ID="sdsImaLFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                            SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='E'">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblFeeScheduleID" Name="DocID" PropertyName="Text" Type="Int32" />
                                                                <asp:Parameter Name="DocCategory" Type="String" DefaultValue="L" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trFactoryInspectionFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Factory Inspection Fee：</td>
                                        <td class="tdRowValue">
                                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                <tr>
                                                    <td><asp:Label ID="lblDocumentFee" runat="server" Text='<%#Eval("DocumentFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblOneTimeFee" runat="server" Text='<%#Eval("OneTimeFee1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblPeriodicFee" runat="server" Text='<%#Eval("PeriodicFee1")%>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trRenewalFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Renewal Fee：</td>
                                        <td class="tdRowValue" align="left">
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td><asp:Label ID="lblRenewalWTest" runat="server" Text='<%#Eval("RenewalWTest1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblRenewalWOTest" runat="server" Text='<%#Eval("RenewalWOTest1")%>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td><asp:Label ID="lblRenewalRemark" runat="server" Text='<%# Eval("RenewalRemark").ToString().Trim().Length>0 ? "Remark："+Eval("RenewalRemark").ToString() : "" %>'></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trTotalCostFeeNA" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Sub Total Cost(New Application)：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblTotalCostFeeNA" runat="server" Text='<%#Eval("TotalCostFeeNA1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Lead Time(New Application)：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadTimeNA" runat="server" Text='<%#Eval("LeadTimeNA1")%>'></asp:Label></td>
                                    </tr>
                                    <tr id="trTotalCostFee" runat="server" visible='<%#IMAUtil.IsEditOn() %>'>
                                        <td class="tdRowName" valign="top">Sub Total Cost(Renewal)：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblTotalCostFee" runat="server" Text='<%#Eval("TotalCostFee1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="tdRowName" valign="top">Lead Time(Renewal)：</td>
                                        <td class="tdRowValue"><asp:Label ID="lblLeadTime" runat="server" Text='<%#Eval("LeadTime1")%>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="tdFooter"></td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsImaDetailL" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                            SelectCommand="STP_ImaDetailLGet" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetailL" runat="server" CollapseControlID="plInfoImaDetailL"
                        ExpandControlID="plInfoImaDetailL" TargetControlID="plImaDetailL" ImageControlID="imgExpImaDetailL"
                        TextLabelID="lblMsgImaDetailL" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
            <%--16.Frequency allocation,power limit by Technologies--%>
            <tr>
                <td>
                    <asp:Panel ID="plInfoImaDetail99" runat="server" CssClass="collapsePanelHeader" Width="80%">
                        <asp:Image ID="imgExpImaDetail99" runat="server" ImageUrl="~/images/IMA/exp.gif" />&nbsp;
                        <asp:Label ID="lblModuleImaDetail99" runat="server">Frequency allocation,power limit by Technologies</asp:Label>&nbsp;&nbsp;
                        <asp:Label ID="lblMsgImaDetail99" runat="server">(Show Details...)</asp:Label>
                    </asp:Panel>
                    <asp:Panel ID="plImaDetail99" runat="server">
                        <table border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <%-- WiFi--%>
                                    <asp:Panel ID="plWiFi" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                            <tr>
                                                <td colspan="7" class="tdHeader">WiFi Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF2" runat="server" Text="5150-5250 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF3" runat="server" Text="5250-5350 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF4" runat="server" Text="5470-5725 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF5" runat="server" Text="5725-5825 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblWiFiF6" runat="server" Text="5825-5850 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblWiFiANA6" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblWiFiPL6" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Indoor/Outdoor allowed</td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA1" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiODA1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA2" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiODA2" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA3" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiODA3" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA4" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiODA4" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA5" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="lblWiFiODA5" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="center">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiIDA6" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiODA6" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">HT20/HT40/HT80/HT160</td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT201" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT401" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT801" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1601" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT202" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT402" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT802" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1602" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT2" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT203" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT403" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT803" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1603" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT3" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT204" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT404" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT804" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1604" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT4" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT205" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT405" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT805" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1605" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT5" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT206" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT406" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT806" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT1606" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiHT6" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">
                                                    DFS/TPC
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFS1" runat="server" Visible="false"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC1" runat="server" Visible="false"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"> <asp:Label ID="lblWiFiDFS2" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC2" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc2" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFS3" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC3" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc3" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFS4" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC4" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc4" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFS5" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC5" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc5" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowValue">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFS6" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiTPC6" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWiFiDFSDesc6" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="6" class="tdRowValue"><asp:Label ID="lblWiFiRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="7" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- Bluetooth--%>
                                    <asp:Panel ID="plBluetooth" runat="server" ScrollBars="Auto" style="padding-top:20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                            <tr>
                                                <td colspan="2" class="tdHeader">Bluetooth Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblBluetoothF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblBluetoothPL1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue"><asp:Label ID="lblBluetoothANA1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td class="tdRowValue"><asp:Label ID="lblBluetoothRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- RFID--%>
                                    <asp:Panel ID="plRFID" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                            <tr>
                                                <td colspan="9" class="tdHeader">RFID Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF1" runat="server" Text="120-150 KHZ"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF2" runat="server" Text="13.56 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF3" runat="server" Text="433 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF4" runat="server" Text="868-870 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF5" runat="server" Text="902-928 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF6" runat="server" Text="2400-2500 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF7" runat="server" Text="2450-5800 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblRFIDF8" runat="server" Text="5725-5875 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblRFIDPL8" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblRFIDANA8" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="8" class="tdRowValue"><asp:Label ID="lblRFIDRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="9" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- FM Transmitter--%>
                                    <asp:Panel ID="plFMTransmitter" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                            <tr>
                                                <td colspan="2" class="tdHeader">FM Transmitter Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Frequency</td>
                                                <td class="tdRowName">
                                                    <table border="0" align="left">
                                                        <tr>
                                                            <td><asp:Label ID="lblFMTransmitterF1" runat="server" Text="88-108 MHz"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblFMTransmitterFDesc1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblFMTransmitterPL1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue"><asp:Label ID="lblFMTransmitterANA1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td class="tdRowValue"><asp:Label ID="lblFMTransmitterRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- Below 1GHz SRD--%>
                                    <asp:Panel ID="plBelow1GSRD" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                            <tr>
                                                <td colspan="5" class="tdHeader">Below 1GHz SRD Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF1" runat="server" Text="13.56 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF2" runat="server" Text="88-108 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF3" runat="server" Text="300/400/800 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblBelow1GSRDF4" runat="server" Text="900 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblBelow1GSRDPL4" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblBelow1GSRDANA4" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="4" class="tdRowValue"><asp:Label ID="lblBelow1GSRDRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- Above 1GHz SRD--%>
                                    <asp:Panel ID="plAbove1GSRD" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                            <tr>
                                                <td colspan="3" class="tdHeader">Above 1GHz SRD Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Frequency</td>
                                                <td class="tdRowName1">
                                                    <table border="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblAbove1GSRDF1" runat="server" Text="2.4 GHz"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblAbove1GSRDFDesc1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="tdRowName1">
                                                    <table border="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblAbove1GSRDF2" runat="server" Text="5 GHz"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblAbove1GSRDFDesc2" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblAbove1GSRDPL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblAbove1GSRDPL2" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblAbove1GSRDANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblAbove1GSRDANA2" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="2" class="tdRowValue"><asp:Label ID="lblAbove1GSRDRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- Zigbee--%>
                                    <asp:Panel ID="plZigbee" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                            <tr>
                                                <td colspan="4" class="tdHeader">Zigbee Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblZigbeeF1" runat="server" Text="2400-2483.5 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblZigbeeF2" runat="server" Text="898 MHz"></asp:Label></td>
                                                <td class="tdRowName1"><asp:Label ID="lblZigbeeF3" runat="server" Text="915 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblZigbeePL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblZigbeePL2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblZigbeePL3" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblZigbeeANA3" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="3" class="tdRowValue"><asp:Label ID="lblZigbeeRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- UWB--%>
                                    <asp:Panel ID="plUWB" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left">
                                            <tr>
                                                <td colspan="8" class="tdHeader">UWB Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF1" runat="server" Text="3168-3696 MHz"></asp:Label><br />(Band#1)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF2" runat="server" Text="3696-4224 MHz"></asp:Label><br />(Band#2)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF3" runat="server" Text="4224-4752 MHz"></asp:Label><br />(Band#3)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF4" runat="server" Text="4752-5280 MHz"></asp:Label><br />(Band#4)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF5" runat="server" Text="5280-5808 MHz"></asp:Label><br />(Band#5)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF6" runat="server" Text="5808-6336 MHz"></asp:Label><br />(Band#6)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF7" runat="server" Text="6336-6864 MHz"></asp:Label><br />(Band#7)</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL7" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA7" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="8" style="height: 1px;"></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF8" runat="server" Text="6864-7392 MHz"></asp:Label><br />(Band#8)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF9" runat="server" Text="7392-7920 MHz"></asp:Label><br />(Band#9)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF10" runat="server" Text="7920-8448 MHz"></asp:Label><br />(Band#10)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF11" runat="server" Text="8448-8976 MHz"></asp:Label><br />(Band#11)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF12" runat="server" Text="8976-9504 MHz"></asp:Label><br />(Band#12)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF13" runat="server" Text="9504-10032 MHz"></asp:Label><br />(Band#13)</td>
                                                <td class="tdRowName1"><asp:Label ID="lblUWBF14" runat="server" Text="10032-10560 MHz"></asp:Label><br />(Band#14)</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL11" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL12" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL13" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblUWBPL14" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName">Allowed/Not Allowed</td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA11" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA12" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA13" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lblUWBANA14" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top">Remark</td>
                                                <td colspan="7" class="tdRowValue"><asp:Label ID="lblUWBRemark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="8" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- 2G--%>
                                    <asp:Panel ID="pl2G" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                            <tr>
                                                <td colspan="4" class="tdHeader">2G GSM/GPRS/EDGE/EDGE Evolution Detail</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="tdHeader1">
                                                    <table cellpadding="0" cellspacing="0" border="0" align="left">
                                                        <tr>
                                                            <td>North America：850-1900 MHz</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Europe：900-1800 MHz</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Power Limit：850,900：33dBm；900,1800：30dBm</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1">UL</td>
                                                <td class="tdRowName1">DL</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" style="width: 100px;"><asp:Label ID="lbl2GANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF1" runat="server" Text="T-GSM-380"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL1" runat="server" Text="380.2-389.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL1" runat="server" Text="390.2-399.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF2" runat="server" Text="T-GSM-410"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL2" runat="server" Text="410.2-419.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL2" runat="server" Text="420.2-429.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF3" runat="server" Text="GSM-450"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL3" runat="server" Text="450.4-457.6 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL3" runat="server" Text="460.4-467.6 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF4" runat="server" Text="GSM-480"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL4" runat="server" Text="479.0-486.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL4" runat="server" Text="489.0-496.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF5" runat="server" Text="GSM-710"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL5" runat="server" Text="698.0-716.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL5" runat="server" Text="728.0-746.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF6" runat="server" Text="GSM-750"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL6" runat="server" Text="747.0-762.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL6" runat="server" Text="777.0-792.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF7" runat="server" Text="T-GSM-810"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL7" runat="server" Text="806.0-821.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL7" runat="server" Text="851.0-866.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF8" runat="server" Text="GSM-850"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL8" runat="server" Text="824.0-849.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL8" runat="server" Text="869.0-894.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF9" runat="server" Text="P-GSM-900"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL9" runat="server" Text="890.2-914.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL9" runat="server" Text="935.2-959.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF10" runat="server" Text="E-GSM-900"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL10" runat="server" Text="880.0-914.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL10" runat="server" Text="925.2-959.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA11" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF11" runat="server" Text="R-GSM-900"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL11" runat="server" Text="876.0-914.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL11" runat="server" Text="921.0-959.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA12" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF12" runat="server" Text="T-GSM-900"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL12" runat="server" Text="870.4-876.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL12" runat="server" Text="915.4-921.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA13" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF13" runat="server" Text="DCS-1800"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL13" runat="server" Text="1710.2-1784.8 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL13" runat="server" Text="1805.2-1879.8 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GANA14" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GF14" runat="server" Text="PCS-1900"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GUL14" runat="server" Text="1850.0-1910.0 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl2GDL14" runat="server" Text="1930.0-1990.0 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" colspan="4">
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 50px;">Remark：</td>
                                                            <td align="left"><asp:Label ID="lbl2GRemark" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- 3G--%>
                                    <asp:Panel ID="pl3G" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                            <tr>
                                                <td colspan="4" class="tdHeader">3G W-CDMA/HSPA(HSDPA and HSUPA)/HSPA+ Detail</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="tdHeader1">Power Limit：24dBm,class 3</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1">UL</td>
                                                <td class="tdRowName1">DL</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" style="width: 100px;"><asp:Label ID="lbl3GANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF1" runat="server" Text="Band1"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL1" runat="server" Text="1920-1980 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL1" runat="server" Text="2110-2170 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF2" runat="server" Text="Band2"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL2" runat="server" Text="1850-1910 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL2" runat="server" Text="1930-1990 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF3" runat="server" Text="Band3"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL3" runat="server" Text="1710-1785 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL3" runat="server" Text="1805-1880 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF4" runat="server" Text="Band4"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL4" runat="server" Text="1710-1755 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL4" runat="server" Text="2110-2155 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF5" runat="server" Text="Band5"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL5" runat="server" Text="824-849 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL5" runat="server" Text="869-894 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF6" runat="server" Text="Band6"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL6" runat="server" Text="830-840 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL6" runat="server" Text="875-885 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF7" runat="server" Text="Band7"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL7" runat="server" Text="2500-2570 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL7" runat="server" Text="2620-2690 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF8" runat="server" Text="Band8"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL8" runat="server" Text="880-915 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL8" runat="server" Text="925-960 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF9" runat="server" Text="Band9"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL9" runat="server" Text="1749.9-1784.9 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL9" runat="server" Text="1844.9-1879.9 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF10" runat="server" Text="Band10"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL10" runat="server" Text="1710-1770 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL10" runat="server" Text="2110-2170 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA11" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF11" runat="server" Text="Band11"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL11" runat="server" Text="1427.9-1452.9 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL11" runat="server" Text="1475.9-1500.9 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA12" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF12" runat="server" Text="Band12"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL12" runat="server" Text="698-716 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL12" runat="server" Text="728-746 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA13" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF13" runat="server" Text="Band13"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL13" runat="server" Text="777-787 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL13" runat="server" Text="746-756 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA14" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF14" runat="server" Text="Band14"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL14" runat="server" Text="788-798 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL14" runat="server" Text="758-768 MHz"></asp:Label>/td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA15" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF15" runat="server" Text="Band19"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL15" runat="server" Text="830-845 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL15" runat="server" Text="875-890 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA16" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF16" runat="server" Text="Band20"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL16" runat="server" Text="832-862 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL16" runat="server" Text="791-821 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GANA17" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GF17" runat="server" Text="Band21"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GUL17" runat="server" Text="1447.9-1462.9 MHz"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl3GDL17" runat="server" Text="1495.9-1510.9 MHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" colspan="4">
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 50px;">Remark：</td>
                                                            <td align="left"><asp:Label ID="lbl3GRemark" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- 4G--%>
                                    <asp:Panel ID="pl4G" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                            <tr>
                                                <td colspan="4" class="tdHeader">4G LTE Detail</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" class="tdHeader1">Power Limit：24dBm,class 3</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1"></td>
                                                <td class="tdRowName1">UL</td>
                                                <td class="tdRowName1">DL</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" style="width: 100px;"><asp:Label ID="lbl4GANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF1" runat="server" Text="Band17"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL1" runat="server" Text="704-716 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL1" runat="server" Text="734-746 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF2" runat="server" Text="Band18"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL2" runat="server" Text="815-830 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL2" runat="server" Text="860-875 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF3" runat="server" Text="Band24"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL3" runat="server" Text="1626.5-1660.5 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL3" runat="server" Text="1525-1559 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF4" runat="server" Text="Band33"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL4" runat="server" Text="1900-1920 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL4" runat="server" Text="1900-1920 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF5" runat="server" Text="Band34"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL5" runat="server" Text="2010-2025 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL5" runat="server" Text="2010-2025 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF6" runat="server" Text="Band35"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL6" runat="server" Text="1850-1910 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL6" runat="server" Text="1850-1910 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF7" runat="server" Text="Band36"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL7" runat="server" Text="1930-1990 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL7" runat="server" Text="1930-1990 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF8" runat="server" Text="Band37"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL8" runat="server" Text="1910-1930 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL8" runat="server" Text="1910-1930 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF9" runat="server" Text="Band38"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL9" runat="server" Text="2570-2620 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL9" runat="server" Text="2570-2620 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF10" runat="server" Text="Band39"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL10" runat="server" Text="1880-1920 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL10" runat="server" Text="1880-1920 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA11" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF11" runat="server" Text="Band40"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL11" runat="server" Text="2300-2400 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL11" runat="server" Text="2300-2400 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA12" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF12" runat="server" Text="Band41"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL12" runat="server" Text="2496-2690 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL12" runat="server" Text="2496-2690 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA13" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF13" runat="server" Text="Band42"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL13" runat="server" Text="3400-3600 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"> <asp:Label ID="lbl4GDL13" runat="server" Text="3400-3600 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GANA14" runat="server"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GF14" runat="server" Text="Band43"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GUL14" runat="server" Text="3600-3800 MHz(FDD)"></asp:Label></td>
                                                <td class="tdRowValue1"><asp:Label ID="lbl4GDL14" runat="server" Text="3600-3800 MHz(FDD)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" colspan="4">
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 50px;">Remark：</td>
                                                            <td align="left"><asp:Label ID="lbl4GRemark" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- CDMA--%>
                                    <asp:Panel ID="plCDMA" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="600px">
                                            <tr>
                                                <td colspan="2" class="tdHeader">cdmaOne/CDMA2000 Detail</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="tdHeader1">cdmaOne&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Power Limit：24dBm</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" style="width:100px;"><asp:Label ID="lblCDMAOneANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF1" runat="server" Text="824-849 MHz(MS Tx：US,Korea)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF2" runat="server" Text="869-894 MHz(BS Tx：US,Korea)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF3" runat="server" Text="887-925 MHz(MS Tx：Japan)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF4" runat="server" Text="832-870 MHz(BS Tx：Japan)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF5" runat="server" Text="1850-1910 MHz(MS Tx：US)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF6" runat="server" Text="1930-1990 MHz(BS Tx：US)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF7" runat="server" Text="1750-1780 MHz(MS Tx：Korea)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMAOneANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMAOneF8" runat="server" Text="1840-1870 MHz(BS Tx：Korea)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="tdHeader1">CDMA2000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Power Limit：24dBm</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA1" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F1" runat="server" Text="410-430 MHz(MS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA2" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F2" runat="server" Text="450-470 MHz(BS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA3" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F3" runat="server" Text="824-849 MHz(MS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA4" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F4" runat="server" Text="869-894 MHz(BS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA5" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F5" runat="server" Text="1710-1755 MHz(MS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA6" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F6" runat="server" Text="2110-2155 MHz(BS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA7" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F7" runat="server" Text="1850-1910 MHz(MS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA8" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F8" runat="server" Text="1930-1990 MHz(BS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA9" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F9" runat="server" Text="1920-1980 MHz(MS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1"><asp:Label ID="lblCDMA2000ANA10" runat="server"></asp:Label></td>
                                                <td class="tdRowValue"><asp:Label ID="lblCDMA2000F10" runat="server" Text="2110-2170 MHz(BS Tx)"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowValue1" colspan="2">
                                                    <table border="0" width="100%">
                                                        <tr>
                                                            <td style="width: 50px;">Remark：</td>
                                                            <td align="left"><asp:Label ID="lblCDMRemark" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center" class="tdFooter"></td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <%-- Wireless HD 60GHz--%>
                                    <asp:Panel ID="plWirelessHD60" runat="server" ScrollBars="Auto" Style="padding-top: 20px;">
                                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" align="left" width="500px">
                                            <tr>
                                                <td colspan="2" class="tdHeader">Wireless HD 60GHz Detail</td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Frequency</td>
                                                <td class="tdRowName1"><asp:Label ID="lblWirelessHD60F1" runat="server" Text="60 GHz"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Allowed/Not Allowed</td>
                                                <td class="tdRowValue"><asp:Label ID="lblWirelessHD60ANA1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Power limit</td>
                                                <td class="tdRowValue"><asp:Label ID="lblWirelessHD60PL1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" style="width: 150px;">Indoor/Outdoor allowed</td>
                                                <td class="tdRowValue1">
                                                    <table border="0" cellpadding="0" cellspacing="0" align="left">
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWirelessHD60IDA1" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left"><asp:Label ID="lblWirelessHD60ODA1" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="tdRowName" valign="top" style="width: 150px;">Remark</td>
                                                <td class="tdRowValue"><asp:Label ID="lblWirelessHD60Remark" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center" class="tdFooter">
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <act:CollapsiblePanelExtender ID="cpeImaDetail99" runat="server" CollapseControlID="plInfoImaDetail99"
                        ExpandControlID="plInfoImaDetail99" TargetControlID="plImaDetail99" ImageControlID="imgExpImaDetail99"
                        TextLabelID="lblMsgImaDetail99" CollapsedText="(Show Details...)" ExpandedText="(Hide Details...)"
                        ExpandedImage="~/images/IMA/col.gif" CollapsedImage="~/images/IMA/exp.gif" Collapsed="true"
                        ExpandDirection="Vertical">
                    </act:CollapsiblePanelExtender>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
