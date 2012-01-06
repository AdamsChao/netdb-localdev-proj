<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailP.aspx.cs" Inherits="Ima_ImaDetailP" StylesheetTheme="IMA" %>

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
                    <tr id="trCopyTo" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Coyp to：
                        </td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Label Requirement：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblRequirement" runat="server" RepeatDirection="Horizontal"
                                            Enabled="false">
                                            <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRequirementDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
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
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
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
                                            DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                            SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="PostFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbPrint" runat="server" Text="Labels can be self-printed" Enabled="false" />
                                        <br />
                                        <asp:CheckBox ID="cbPurchase" runat="server" Text="Labels need to be purchase from authority"
                                            Enabled="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLabelsDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
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
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                            SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="PostFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Renewal required：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:RadioButton ID="rbtnYes" runat="server" Text="Yes" GroupName="Renewal" Enabled="false" />：
                                        <asp:Label ID="lblYear" runat="server"></asp:Label>
                                        year(s)
                                        <asp:Label ID="lblMonth" runat="server"></asp:Label>
                                        month(s)
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:RadioButton ID="rbtnNo" runat="server" Text="No" GroupName="Renewal" Enabled="false" />：
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblRequiredDesc" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="PostFileID"
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
                                                                    <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "PostFile.ashx?fid="+Eval("PostFileID").ToString() %>'
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
                                                    <asp:SqlDataSource ID="sdsFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                        DeleteCommand="DELETE FROM [Ima_Post_Files] WHERE [PostFileID] = @PostFileID"
                                                        SelectCommand="SELECT * FROM [Ima_Post_Files] WHERE ([PostID] = @PostID) and FileCategory='C'">
                                                        <DeleteParameters>
                                                            <asp:Parameter Name="PostFileID" Type="Int32" />
                                                        </DeleteParameters>
                                                        <SelectParameters>
                                                            <asp:QueryStringParameter Name="PostID" QueryStringField="pcid" Type="Int32" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
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
