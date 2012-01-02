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
                            Product Type：
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
                            Certificate is valid for：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificateValid" runat="server" RepeatDirection="Horizontal">
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
                            <asp:RadioButtonList ID="rblTransfer" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                <asp:ListItem Text="NO" Value="0"></asp:ListItem>
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
