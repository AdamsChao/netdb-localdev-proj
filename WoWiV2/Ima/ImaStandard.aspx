<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaStandard.aspx.cs" Inherits="Ima_ImaStandard" StylesheetTheme="IMA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
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
                            <asp:UpdatePanel ID="upProductType" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="rblProductType" runat="server" RepeatDirection="Horizontal"
                                        DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id"
                                        AutoPostBack="True" OnSelectedIndexChanged="rblProductType_SelectedIndexChanged">
                                    </asp:RadioButtonList>
                                    <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <asp:UpdatePanel ID="upFccTitle" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <%--<span style="color: Red; font-size: 10pt;">*</span>--%>
                                    <asp:Label ID="lblFCCTitle" runat="server"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rblProductType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upFcc" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBox ID="cbFCC" runat="server" Text="FCC" />
                                    <asp:CheckBox ID="cbIEC" runat="server" Text="IEC" />
                                    <asp:CheckBox ID="cbCE" runat="server" Text="CE" />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Others：<asp:TextBox ID="tbOthers" runat="server"></asp:TextBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rblProductType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <asp:Label ID="lblRequiredTitle" runat="server"></asp:Label>
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblRequired" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            List harmonizes standards：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbStandardDesc" runat="server" Width="500px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            File Upload：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr id="trLS" runat="server" visible="false">
                                    <td><asp:TextBox ID="tbLocalStandards" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="fuGeneral1" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="fuGeneral2" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="fuGeneral3" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="fuGeneral4" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="fuGeneral5" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="StandardFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "StandardFile.ashx?fid="+Eval("StandardFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Standard_Files] WHERE [StandardFileID] = @StandardFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Standard_Files] WHERE ([StandardID] = @StandardID) and FileCategory='A' order by FileName">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="StandardFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="StandardID" QueryStringField="sid" Type="Int32" />
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
                        <td colspan="2" class="tdHeader1">
                            Local Standards by Technologies
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <asp:UpdatePanel ID="upTechTitle" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Label ID="lblTech" runat="server"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rblProductType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upTech" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Panel ID="plTechRF" runat="server" Visible="false">
                                        <table border="0">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:DataList ID="dlTechRF" runat="server" DataSourceID="sdsTechRF" DataKeyField="wowi_tech_id"
                                                        RepeatColumns="2" RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <table border="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBox ID="cbRFFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>' onclick="TechDesc(this);" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="tbRFFee" runat="server" Width="200px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            Text='<%#Eval("Description") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                        SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                            <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                                            <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    Remark：
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbRFRemark" runat="server" Width="400px" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="plTechEMC" runat="server" Visible="false">
                                        <table border="0">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:DataList ID="dlTechEMC" runat="server" DataSourceID="sdsTechEMC" DataKeyField="wowi_tech_id"
                                                        RepeatColumns="2" RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <table border="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBox ID="cbEMCFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            onclick="TechDesc(this);" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="tbEMCFee" runat="server" Width="200px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            Text='<%#Eval("Description") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                        SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                            <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                                            <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    Remark：
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbEMCRemark" runat="server" Width="400px" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="plTechSafety" runat="server" Visible="false">
                                        <table border="0">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:DataList ID="dlTechSafety" runat="server" DataSourceID="sdsTechSafety" DataKeyField="wowi_tech_id"
                                                        RepeatColumns="2" RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <table border="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBox ID="cbSafetyFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            onclick="TechDesc(this);" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="tbSafetyFee" runat="server" Width="200px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            Text='<%#Eval("Description") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                        SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                            <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                                            <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    Remark：
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbSafetyRemark" runat="server" Width="400px" TextMode="MultiLine"
                                                        Rows="2"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="plTechTelecom" runat="server" Visible="false">
                                        <table border="0">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:DataList ID="dlTechTelecom" runat="server" DataSourceID="sdsTechTelecom" DataKeyField="wowi_tech_id"
                                                        RepeatColumns="2" RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <table border="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:CheckBox ID="cbTelecomFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            onclick="TechDesc(this);" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="tbTelecomFee" runat="server" Width="200px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                            Text='<%#Eval("Description") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                    <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                        SelectCommand="STP_IMAGetTechList1" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                            <asp:QueryStringParameter Name="DID" QueryStringField="sid" Type="Int32" DefaultValue="0" />
                                                            <asp:QueryStringParameter Name="Categroy" QueryStringField="categroy" Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    Remark：
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbTelecomRemark" runat="server" Width="400px" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="rblProductType" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" class="tdFooter">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                            <asp:Button ID="btnSaveCopy" runat="server" Text="Save(Copy)" OnClick="btnSave_Click" />
                            <asp:Button ID="btnUpd" runat="server" Text="Update" OnClick="btnUpd_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel/Back" OnClick="btnCancel_Click" CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

