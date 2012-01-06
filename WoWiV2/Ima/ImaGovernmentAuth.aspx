<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="ImaGovernmentAuth.aspx.cs" Inherits="Ima_ImaGovernmentAuth" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <table border="0">
        <tr>
            <td valign="top">
                <uc1:ImaTree ID="ImaTree1" runat="server" />
            </td>
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
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Full Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFullAuthorityName" runat="server"></asp:TextBox>
                            <%--<asp:RequiredFieldValidator ID="rfvVoltage" runat="server" ControlToValidate="tbVoltage"
                                ErrorMessage="Input Voltage" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveVoltage" runat="server" TargetControlID="rfvVoltage">
                            </act:ValidatorCalloutExtender>--%>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Abbreviated Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAbbreviatedAuthorityName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                             Website：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbWebsite" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Mandatory or Voluntary：
                        </td>
                        <td class="tdRowValue">
                            <%--<asp:TextBox ID="tbMandatory" runat="server"></asp:TextBox>--%>
                            <asp:RadioButtonList ID="rblMandatory" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Mandatory" Value="Mandatory" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Voluntary" Value="Voluntary"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Attach sample certificate：
                        </td>
                        <td class="tdRowValue">
                            1.<asp:FileUpload ID="fuGeneral1" runat="server" Width="90%" /><br />
                            2.<asp:FileUpload ID="fuGeneral2" runat="server" Width="90%" /><br />
                            3.<asp:FileUpload ID="fuGeneral3" runat="server" Width="90%" /><br />
                            4.<asp:FileUpload ID="fuGeneral4" runat="server" Width="90%" /><br />
                            5.<asp:FileUpload ID="fuGeneral5" runat="server" Width="90%" />
                            <asp:GridView ID="gvImaFiles1" runat="server" SkinID="gvList" DataKeyNames="GoverAuthFileID"
                                DataSourceID="sdsImaFiles1">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Copy to">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chSelCopy" runat="server" Checked="true" />
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="NO" Visible="false">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                        <ItemStyle Width="30px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FileName">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GoverFile.ashx?fid="+Eval("GoverAuthFileID").ToString() %>'
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
                                DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='A'">
                                <DeleteParameters>
                                    <asp:Parameter Name="GoverAuthFileID" Type="Int32" />
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
                            <asp:RadioButtonList ID="rblCertificateValid" runat="server" 
                                RepeatDirection="Horizontal">
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
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblTransfer" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                            <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="tbDescription" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload1" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload2" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload3" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload4" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload5" runat="server" Width="90%" />
                                        <asp:GridView ID="gvImaFiles" runat="server" SkinID="gvList" DataKeyNames="GoverAuthFileID"
                                            DataSourceID="sdsImaFiles">
                                            <Columns>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                            Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Copy to">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chSelCopy" runat="server" Checked="true" />
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NO" Visible="false">
                                                    <ItemTemplate>
                                                        <%#Container.DataItemIndex+1 %>
                                                    </ItemTemplate>
                                                    <HeaderStyle Font-Bold="False" Width="30px" HorizontalAlign="Center" />
                                                    <ItemStyle Width="30px" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="FileName">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GoverFile.ashx?fid="+Eval("GoverAuthFileID").ToString() %>'
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
                                        <asp:SqlDataSource ID="sdsImaFiles" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            DeleteCommand="DELETE FROM [Ima_GoverAuth_Files] WHERE [GoverAuthFileID] = @GoverAuthFileID"
                                            SelectCommand="SELECT * FROM [Ima_GoverAuth_Files] WHERE ([GovernmentAuthorityID] = @GovernmentAuthorityID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="GoverAuthFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="GovernmentAuthorityID" QueryStringField="gaid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr>
                        <td valign="top" class="tdRowName">
                            FileUpload：
                        </td>
                        <td class="tdRowValue">
                            
                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2" align="center" class="tdFooter">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:Button ID="btnSaveCopy" runat="server" Text="Save(Copy)" OnClick="btnSave_Click" />
                            <asp:Button ID="btnUpd" runat="server" Text="Update" OnClick="btnUpd_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel/Back" OnClick="btnCancel_Click"
                                CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

