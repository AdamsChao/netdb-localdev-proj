<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaFeeSchedule.aspx.cs" Inherits="Ima_ImaFeeSchedule" StylesheetTheme="IMA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
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
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Country：</td>
                        <td class="tdRowValue"><asp:Label ID="lblCountry" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Technologies：</td>
                        <td class="tdRowValue">
                            <asp:Label ID="lblProTypeName1" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddlTech" runat="server" DataSourceID="sdsTech" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsTech" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name=@TypeName">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblProTypeName" Name="TypeName" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Local Agent Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLAName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Agent handling Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAgentHandling" runat="server"></asp:TextBox>USD
                            <%--<asp:RequiredFieldValidator ID="rfvVoltage" runat="server" ControlToValidate="tbVoltage"
                                ErrorMessage="Input Voltage" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveVoltage" runat="server" TargetControlID="rfvVoltage">
                            </act:ValidatorCalloutExtender>--%>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAuthName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Authority submission fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:TextBox ID="tbAuthoritySubmission" runat="server"></asp:TextBox>USD</td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="fuGeneral1" runat="server" /><br />
                                        2.<asp:FileUpload ID="fuGeneral2" runat="server" /><br />
                                        3.<asp:FileUpload ID="fuGeneral3" runat="server" /><br />
                                        4.<asp:FileUpload ID="fuGeneral4" runat="server" /><br />
                                        5.<asp:FileUpload ID="fuGeneral5" runat="server" />
                                        <asp:GridView ID="gvImaFiles1" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
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
                        <td class="tdRowName">
                            Certification Body Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCBName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certification Body submission fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:TextBox ID="tbBodySubmission" runat="server" ></asp:TextBox>USD</td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload1" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload2" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload3" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload4" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload5" runat="server" />
                                        <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsImaFile2">
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
                        <td class="tdRowName">
                            Accredited Test Lab Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbATLName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Lab Testing fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td><asp:TextBox ID="tbLabTesting" runat="server"></asp:TextBox>USD</td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload6" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload7" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload8" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload9" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload10" runat="server" />
                                        <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile3">
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
                            <asp:TextBox ID="tbDocumentTranslation" runat="server"></asp:TextBox>USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Bank fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbBank" runat="server"></asp:TextBox>USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Custom clearance fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCustomClearance" runat="server"></asp:TextBox>USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Sample return fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbSampleReturn" runat="server"></asp:TextBox>USD
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Label purchase fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:TextBox ID="tbLabelPurchase" runat="server"></asp:TextBox>USD</td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload11" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload12" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload13" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload14" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload15" runat="server" />
                                        <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile4">
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
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbOther" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload16" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload17" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload18" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload19" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload20" runat="server" />
                                        <asp:GridView ID="gvFile5" runat="server" SkinID="gvList" DataKeyNames="FeeScheduleFileID"
                                            DataSourceID="sdsFile5">
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
                        <td class="tdRowName" valign="top">
                            Factory Inspection Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        Document Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbDocumentFee" runat="server" Width="60px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revDocumentFee" runat="server" ControlToValidate="tbDocumentFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceDocumentFee" runat="server" TargetControlID="revDocumentFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDocumentFeeUnit" runat="server">
                                            <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                            <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        One-time on-site Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOneTimeFee" runat="server" Width="60px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revOneTimeFee" runat="server" ControlToValidate="tbOneTimeFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceOneTimeFee" runat="server" TargetControlID="revOneTimeFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlOneTimeFeeUnit" runat="server">
                                            <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                            <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Periodic on-site Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbPeriodicFee" runat="server" Width="60px"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revPeriodicFee" runat="server" ControlToValidate="tbPeriodicFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vcePeriodicFee" runat="server" TargetControlID="revPeriodicFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPeriodicFeeUnit" runat="server">
                                            <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                            <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
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

