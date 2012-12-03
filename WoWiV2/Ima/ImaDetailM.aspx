<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaDetailM.aspx.cs" Inherits="Ima_ImaDetailM" StylesheetTheme="IMA" %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/DenyPageCopy.js" type="text/javascript"></script>
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
                            Certification Type：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblProTypeName" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trCopyTo" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Coyp to：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblProductType" runat="server" RepeatDirection="Horizontal"
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:RadioButtonList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>
                            Which carrier is preferable
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCarrier" runat="server"></asp:Label>
                                        <%--<asp:CheckBox ID="cbFedex" runat="server" Text="Fedex" Enabled="false" />
                                        <asp:CheckBox ID="cbDHL" runat="server" Text="DHL" Enabled="false" />
                                        <asp:CheckBox ID="cbUPS" runat="server" Text="UPS" Enabled="false" /><br />--%>
                                        <asp:Label ID="lblOtherCarrier" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCarrierDesc" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="SampleShippingFileID"
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
                                        <asp:SqlDataSource ID="sdsFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_SampleShipping_Files] WHERE [SampleShippingFileID] = @SampleShippingFileID"
                                            SelectCommand="SELECT * FROM [Ima_SampleShipping_Files] WHERE ([SampleShippingID] = @SampleShippingID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="SampleShippingFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="SampleShippingID" QueryStringField="ssid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Any documents for sample shipping：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblSampleDoc" runat="server" ></asp:Label>
                            <%--<asp:CheckBox ID="cbInvoice" runat="server" Text="Invoice" Enabled="false" />
                            <asp:CheckBox ID="cbPackingList" runat="server" Text="Packing List" Enabled="false" />
                            <asp:CheckBox ID="cbContract" runat="server" Text="Contract" Enabled="false" /><br />--%>
                            <asp:Label ID="lblOtherSampleShipping" runat="server" ></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            How much value to declare to prevent 
                            <br />
                            from local customs’ auditing sample：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblUnderUSD" runat="server"></asp:Label>
                            <%--A value of under
                            <asp:TextBox ID="tbUnderUSD" runat="server" Enabled="false"></asp:TextBox>USD is suggested for custom
                            declaration value--%>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Mark sample for testing without commercial value on the 
                            <br />
                            invoice and packing list
                            OR declare actual commercial value ：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblMarksample" runat="server"></asp:Label>
                            <%--<asp:CheckBox ID="cbNoCommercial" runat="server" Text="Label shipment as no commercial value" Enabled="false" />
                            <asp:CheckBox ID="cbActualCommercial" runat="server" Text="Label shipment as actual commercial value" Enabled="false" /><br />--%>
                            <asp:Label ID="lblNote" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tr1" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Pre-install test software or send by CD, email, or FTP：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbPreInstalled" runat="server" Text="Pre-installed" Enabled="false" />
                            <asp:CheckBox ID="cbCD" runat="server" Text="CD" Enabled="false" />
                            <asp:CheckBox ID="cbEmail" runat="server" Text="Email" Enabled="false" />
                            <asp:CheckBox ID="cbFTP" runat="server" Text="FTP" Enabled="false" /><br />
                            Note：<asp:Label ID="lblTestNote" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Samples can be returned：
                        </td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblReturned" runat="server"></asp:Label>
                            <%--<asp:RadioButtonList ID="rblReturned" runat="server" RepeatDirection="Horizontal" Enabled="false">
                                <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                            </asp:RadioButtonList>--%>
                            <asp:Label ID="lblReturnedNote" runat="server"></asp:Label>
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
