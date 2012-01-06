<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaC.aspx.cs" Inherits="Ima_ImaC"
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
                            National government rules and regulation Detail
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
                        <td class="tdRowName" valign="top">
                            National Regulation：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="tdRowName">
                            FileUpload：
                        </td>
                        <td class="tdRowValue">
                            <asp:GridView ID="gvImaFiles" runat="server" DataKeyNames="NationalGovFileID"
                                DataSourceID="sdsImaFiles" SkinID="gvList">
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
                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "NationalGovFile.ashx?fid="+Eval("NationalGovFileID").ToString() %>'
                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsImaFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                DeleteCommand="DELETE FROM [Ima_NationalGover_Files] WHERE [NationalGovFileID] = @NationalGovFileID"
                                SelectCommand="SELECT * FROM [Ima_NationalGover_Files] WHERE ([NationalGovID] = @NationalGovID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="NationalGovFileID" Type="Int32" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="NationalGovID" QueryStringField="ngid" Type="Int32" />
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
