<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaTesting.aspx.cs" Inherits="Ima_Testing" StylesheetTheme="IMA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register src="../UserControls/ImaTree.ascx" tagname="ImaTree" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script language="javascript" type="text/javascript" src="../Scripts/IMA.js"></script>
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
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Document language 
                            <br />
                            acceptance：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblLanguage" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Text="All English" Value="All" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="Other or Partial" Value="Other"></asp:ListItem>
                                            <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbLanguageDesc" runat="server" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="fuGeneral1" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="fuGeneral2" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="fuGeneral3" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="fuGeneral4" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="fuGeneral5" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
                                                    DataSourceID="sdsFile1">
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
                                                <asp:SqlDataSource ID="sdsFile1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='A'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="TestingFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                           Testing Sample Label Marking：<br />
                           Remark：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblTestMark" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text="NO" Value="NO"></asp:ListItem>
                                            <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="tbTestMarkRemark" runat="server" Width="500px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload11" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload12" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload13" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload14" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload15" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile4" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
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
                                                <asp:SqlDataSource ID="sdsFile4" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='D'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="TestingFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            EUT Info：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbBW" runat="server" Text="Sales Brochure (B/W)" />
                            <asp:CheckBox ID="cbColor" runat="server" Text="Sales Brochure (Color)" /><br />
                            User Manual in <asp:TextBox ID="tbManual" runat="server" Width="300px"></asp:TextBox> language
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Test Report/Certification：</td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbFCCTest" runat="server" Text="FCC Test Report" />
                                        <asp:CheckBox ID="cbFCCCertificate" runat="server" Text="FCC Certificate" />
                                        <asp:CheckBox ID="cbCETest" runat="server" Text="CE Test Report" />
                                        <asp:CheckBox ID="cbNBEO" runat="server" Text="NBEO" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbEUDoC" runat="server" Text="EU DoC" />
                                        <asp:CheckBox ID="cbConformance" runat="server" Text="Conformance for GSM, CDMA , and WCDMA" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Other internationally recognized certification (specify)<br />
                                        <asp:TextBox ID="tbOtherInternationally" runat="server" Rows="5" TextMode="MultiLine"
                                            Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload1" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload2" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload3" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload4" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload5" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile2" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
                                                    DataSourceID="sdsFile2">
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
                                                <asp:SqlDataSource ID="sdsFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='B'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="TestingFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Technical Documents：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbSchematics" runat="server" Text="Schematics" />
                                        <asp:CheckBox ID="cbBlock" runat="server" Text="Block Diagram" />
                                        <asp:CheckBox ID="cbLayout" runat="server" Text="Layout" />
                                        <asp:CheckBox ID="cbGerber" runat="server" Text="Gerber" />
                                        <asp:CheckBox ID="cbTheory" runat="server" Text="Theory of Operation" />
                                        <asp:CheckBox ID="cbBOM1" runat="server" Text="BOM" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Technical Spec in <asp:TextBox ID="tbTechnical" runat="server" Width="300px"></asp:TextBox> language
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Antenna Spec in <asp:TextBox ID="tbAntenna" runat="server" Width="300px"></asp:TextBox> language
                                    </td>
                                </tr>
                                <tr id="trBOM" runat="server" visible="false">
                                    <td>
                                        BOM in <asp:TextBox ID="tbBOM" runat="server" Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Other Documents：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbOfficial" runat="server" Text="Official Application Form" /> in <asp:TextBox ID="tbOfficialLanguage" runat="server"></asp:TextBox> language<br />
                                        <asp:CheckBox ID="cbWoWiRequest" runat="server" Text="WoWi Request Letter" /><br />
                                        <asp:CheckBox ID="cbISO" runat="server" Text="ISO/Quality Documents" /> in <asp:TextBox ID="tbISOLanguage" runat="server"></asp:TextBox> language
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="cbPayment" runat="server" Text="Payment Receipt" /><br />
                                        <asp:CheckBox ID="cbAuthor" runat="server" Text="Authorization Letter from Manufacturer to Local Rep/Agent" /><br />
                                        <asp:CheckBox ID="cbAuthorWoWi" runat="server" Text="Authorization Letter from Manufacturer to WoWi" /><br />
                                        <asp:CheckBox ID="cbAuthorAgent" runat="server" Text="Authorization Letter from Local Rep to Local Agent" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Please specify any other documents required<br />
                                        <asp:TextBox ID="tbOtherDocRequest" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload6" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload7" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload8" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload9" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload10" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile3" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="TestingFileID"
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
                                                <asp:SqlDataSource ID="sdsFile3" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Testing_Files] WHERE [TestingFileID] = @TestingFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Testing_Files] WHERE ([TestingID] = @TestingID) and FileCategory='C'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="TestingFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="TestingID" QueryStringField="tid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Radiated Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbRadiated" runat="server" Width="60px"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revRadiated" runat="server" ControlToValidate="tbRadiated"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceRadiated" runat="server" TargetControlID="revRadiated">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Conducted Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbConducted" runat="server" Width="60px"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revConducted" runat="server" ControlToValidate="tbConducted"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceConducted" runat="server" TargetControlID="revConducted">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Normal-Link Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbNormalLink" runat="server" Width="60px"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revNormalLink" runat="server" ControlToValidate="tbNormalLink"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceNormalLink" runat="server" TargetControlID="revNormalLink">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Consumer Sample for review only：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbReviewOnly" runat="server" Width="60px"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revReviewOnly" runat="server" ControlToValidate="tbReviewOnly"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceReviewOnly" runat="server" TargetControlID="revReviewOnly">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Pre-install test software 
                            <br />
                            or send by CD, email, or FTP：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbPreInstalled" runat="server" Text="Pre-installed" />
                            <asp:CheckBox ID="cbCD" runat="server" Text="CD" />
                            <asp:CheckBox ID="cbEmail" runat="server" Text="Email" />
                            <asp:CheckBox ID="cbFTP" runat="server" Text="FTP" /><br />
                            Note：<asp:TextBox ID="tbTestNote" runat="server" Width="350px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Remark：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbRemark" runat="server" Width="500px"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr>
                        <td colspan="2" class="tdHeader1">
                            Technologies
                        </td>
                    </tr>
                    <tr id="trTechRF" runat="server" style="display: none;">
                        <td class="tdRowName">
                            RF：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechRF" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='RF'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechRFAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechEMC" runat="server" style="display: none;">
                        <td class="tdRowName">
                            EMC：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='EMC'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechEMCAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechSafety" runat="server" style="display: none;">
                        <td class="tdRowName">
                            Safety：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Safety'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechSafetyAll" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trTechTelecom" runat="server" style="display: none;">
                        <td class="tdRowName">
                            Telecom：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechTelecom" runat="server" RepeatDirection="Horizontal"
                                RepeatColumns="5" DataSourceID="sdsTechTelecom" DataTextField="wowi_tech_name"
                                DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Telecom'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechTelecomAll" runat="server" Visible="false"></asp:Label>
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

