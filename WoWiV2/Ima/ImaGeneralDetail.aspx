<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaGeneralDetail.aspx.cs"
    Inherits="Ima_ImaGeneralDetail" StylesheetTheme="IMA" %>

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
                                                <%--<asp:Image ID="img" runat="server" ImageUrl='<%# IMAUtil.GetIMAUploadPath()+Eval("GeneralImageURL").ToString() %>' />--%>
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
                                SelectCommand="SELECT * FROM [Ima_General_Images] WHERE ([GeneralID] = @GeneralID)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="GeneralID" QueryStringField="gid" Type="Int32" />
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
                            1 USD to <asp:Label ID="lblExchange_rate_USD" runat="server"></asp:Label><br />
                            1 EUR to <asp:Label ID="lblExchange_rate_EUR" runat="server"></asp:Label>
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
                                DeleteCommand="DELETE FROM [Ima_General_Files] WHERE [GeneralFileID] = @GeneralFileID"
                                InsertCommand="INSERT INTO [Ima_General_Files] ([GeneralID], [GeneralFileURL], [GeneralFileName], [GeneralFileType], [CreateUser], [CreateDate], [LasterUpdateUser], [LasterUpdateDate]) VALUES (@GeneralID, @GeneralFileURL, @GeneralFileName, @GeneralFileType, @CreateUser, @CreateDate, @LasterUpdateUser, @LasterUpdateDate)"
                                SelectCommand="SELECT * FROM [Ima_General_Files] WHERE ([GeneralID] = @GeneralID)"
                                UpdateCommand="UPDATE [Ima_General_Files] SET [GeneralID] = @GeneralID, [GeneralFileURL] = @GeneralFileURL, [GeneralFileName] = @GeneralFileName, [GeneralFileType] = @GeneralFileType, [CreateUser] = @CreateUser, [CreateDate] = @CreateDate, [LasterUpdateUser] = @LasterUpdateUser, [LasterUpdateDate] = @LasterUpdateDate WHERE [GeneralFileID] = @GeneralFileID">
                                <DeleteParameters>
                                    <asp:Parameter Name="GeneralFileID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="GeneralID" Type="Int32" />
                                    <asp:Parameter Name="GeneralFileURL" Type="String" />
                                    <asp:Parameter Name="GeneralFileName" Type="String" />
                                    <asp:Parameter Name="GeneralFileType" Type="String" />
                                    <asp:Parameter Name="CreateUser" Type="String" />
                                    <asp:Parameter Name="CreateDate" Type="DateTime" />
                                    <asp:Parameter Name="LasterUpdateUser" Type="String" />
                                    <asp:Parameter Name="LasterUpdateDate" Type="DateTime" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="GeneralID" QueryStringField="gid" Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="GeneralID" Type="Int32" />
                                    <asp:Parameter Name="GeneralFileURL" Type="String" />
                                    <asp:Parameter Name="GeneralFileName" Type="String" />
                                    <asp:Parameter Name="GeneralFileType" Type="String" />
                                    <asp:Parameter Name="CreateUser" Type="String" />
                                    <asp:Parameter Name="CreateDate" Type="DateTime" />
                                    <asp:Parameter Name="LasterUpdateUser" Type="String" />
                                    <asp:Parameter Name="LasterUpdateDate" Type="DateTime" />
                                    <asp:Parameter Name="GeneralFileID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
