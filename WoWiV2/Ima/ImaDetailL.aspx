<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailL.aspx.cs" Inherits="Ima_ImaDetailL" StylesheetTheme="IMA" %>

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
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Agent handling Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblAgentHandling" runat="server"></asp:Label>&nbsp;USD
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Authority submission fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAuthoritySubmission" runat="server"></asp:Label>&nbsp;USD
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvImaFiles1" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsImaFiles1">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "FeeScheduleFile.ashx?fid="+Eval("FeeScheduleFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsImaFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_FeeSchedule_Files] WHERE [FeeScheduleFileID] = @FeeScheduleFileID"
                                            SelectCommand="SELECT * FROM [Ima_FeeSchedule_Files] WHERE ([FeeScheduleID] = @FeeScheduleID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="FeeScheduleFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="FeeScheduleID" QueryStringField="fsid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certification Body submission fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblBodySubmission" runat="server"></asp:Label>&nbsp;USD
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsImaFile2">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "FeeScheduleFile.ashx?fid="+Eval("FeeScheduleFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsImaFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_FeeSchedule_Files] WHERE [FeeScheduleFileID] = @FeeScheduleFileID"
                                            SelectCommand="SELECT * FROM [Ima_FeeSchedule_Files] WHERE ([FeeScheduleID] = @FeeScheduleID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="FeeScheduleFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="FeeScheduleID" QueryStringField="fsid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Lab Testing fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellspacing="0" cellpadding="0" align="left">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLabTesting" runat="server"></asp:Label>&nbsp;USD
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile3">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "FeeScheduleFile.ashx?fid="+Eval("FeeScheduleFileID").ToString() %>'
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
                                            DeleteCommand="DELETE FROM [Ima_FeeSchedule_Files] WHERE [FeeScheduleFileID] = @FeeScheduleFileID"
                                            SelectCommand="SELECT * FROM [Ima_FeeSchedule_Files] WHERE ([FeeScheduleID] = @FeeScheduleID) and FileCategory='C'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="FeeScheduleFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="FeeScheduleID" QueryStringField="fsid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Document translation fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblDocumentTranslation" runat="server"></asp:Label>&nbsp;USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Bank fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblBank" runat="server"></asp:Label>&nbsp;USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Custom clearance fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblCustomClearance" runat="server"></asp:Label>&nbsp;USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Sample return fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblSampleReturn" runat="server"></asp:Label>&nbsp;USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Label purchase fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLabelPurchase" runat="server"></asp:Label>&nbsp;USD
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile4">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "FeeScheduleFile.ashx?fid="+Eval("FeeScheduleFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_FeeSchedule_Files] WHERE [FeeScheduleFileID] = @FeeScheduleFileID"
                                            SelectCommand="SELECT * FROM [Ima_FeeSchedule_Files] WHERE ([FeeScheduleID] = @FeeScheduleID) and FileCategory='D'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="FeeScheduleFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="FeeScheduleID" QueryStringField="fsid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Other fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0" align="left">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblOther" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile5" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile5">
                                            <Columns>
                                                <asp:TemplateField HeaderText="NO.">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "FeeScheduleFile.ashx?fid="+Eval("FeeScheduleFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_FeeSchedule_Files] WHERE [FeeScheduleFileID] = @FeeScheduleFileID"
                                            SelectCommand="SELECT * FROM [Ima_FeeSchedule_Files] WHERE ([FeeScheduleID] = @FeeScheduleID) and FileCategory='E'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="FeeScheduleFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="FeeScheduleID" QueryStringField="fsid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
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
