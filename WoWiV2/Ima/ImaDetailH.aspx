<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailH.aspx.cs" Inherits="Ima_ImaDetailH" StylesheetTheme="IMA" %>

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
                            Product Type：
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
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
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
                            <asp:CheckBox ID="cbFCC" runat="server" Text="FCC" Enabled="false" />
                            <asp:CheckBox ID="cbIEC" runat="server" Text="IEC" Enabled="false" />
                            <asp:CheckBox ID="cbCE" runat="server" Text="CE" Enabled="false" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Others：<asp:Label ID="lblOthers" runat="server" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <asp:Label ID="lblRequiredTitle" runat="server"></asp:Label>
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:RadioButtonList ID="rblRequired" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            List harmonizes standards to
                            <br />
                            the above products：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblStandardDesc" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Local standards：
                        </td>
                        <td class="tdRowValue" align="left">
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
                                                Text='<%# Eval("FileName").ToString()+"."+Eval("FileType").ToString() %>' Target="_blank"></asp:HyperLink>
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
