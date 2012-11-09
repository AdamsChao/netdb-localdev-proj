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
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
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
                            <asp:UpdatePanel ID="upTech" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlTech" runat="server" DataSourceID="sdsTech" DataTextField="wowi_tech_name"
                                        DataValueField="wowi_tech_id" AutoPostBack="True" OnSelectedIndexChanged="ddlTech_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsTech" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from vw_Ima_wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_id=@wowi_product_type_id">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblProType" Name="wowi_product_type_id" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Local Agent Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upLocalAgent" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlLocalAgent" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlLocalAgent_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Agent handling Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upLocalAgentFee" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:TextBox ID="tbAgentFee" runat="server" Width="80px"></asp:TextBox>USD
                                    <asp:RegularExpressionValidator ID="revAgentFee" runat="server" ControlToValidate="tbAgentFee"
                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    <act:ValidatorCalloutExtender ID="vceAgentFee" runat="server" TargetControlID="revAgentFee">
                                    </act:ValidatorCalloutExtender>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlLocalAgent" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Authority Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upAuthority" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlAuthority" runat="server" AutoPostBack="True" 
                                        onselectedindexchanged="ddlAuthority_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Authority submission Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upAuthorityFee" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:TextBox ID="tbAuthorityFee" runat="server" Width="80px"></asp:TextBox>USD
                                                <asp:RegularExpressionValidator ID="revAuthorityFee" runat="server" ControlToValidate="tbAuthorityFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceAuthorityFee" runat="server" TargetControlID="revAuthorityFee">
                                                </act:ValidatorCalloutExtender>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlAuthority" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="fuGeneral1" runat="server" /><br />
                                        2.<asp:FileUpload ID="fuGeneral2" runat="server" /><br />
                                        3.<asp:FileUpload ID="fuGeneral3" runat="server" /><br />
                                        4.<asp:FileUpload ID="fuGeneral4" runat="server" /><br />
                                        5.<asp:FileUpload ID="fuGeneral5" runat="server" />
                                        <asp:UpdatePanel ID="upFile1" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvImaFiles1" runat="server" SkinID="gvList" DataKeyNames="FileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsImaFiles1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Files] WHERE [FileID] = @FileID"
                                                    SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='A'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="FileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="DocID" QueryStringField="fsid" Type="Int32" />
                                                        <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
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
                        <td class="tdRowName">
                            Certification Body Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upCertificationBody" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlCertification" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCertification_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certification Body 
                            <br />
                            submission Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upCertificationBodyFee" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:TextBox ID="tbCertificationBodyFee" runat="server" Width="80px" ></asp:TextBox>USD
                                                <asp:RegularExpressionValidator ID="revCertificationBodyFee" runat="server" ControlToValidate="tbCertificationBodyFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceCertificationBodyFee" runat="server" TargetControlID="revCertificationBodyFee">
                                                </act:ValidatorCalloutExtender>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlCertification" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload1" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload2" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload3" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload4" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload5" runat="server" />
                                        <asp:UpdatePanel ID="upFile2" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="FileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsImaFile2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Files] WHERE [FileID] = @FileID"
                                                    SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='B'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="FileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="DocID" QueryStringField="fsid" Type="Int32" />
                                                        <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
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
                        <td class="tdRowName">
                            Accredited Test Lab Name：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upLabTest" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlAccredited" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAccredited_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Lab Testing Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upLabTestFee" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:TextBox ID="tbLabTestFee" runat="server" Width="80px"></asp:TextBox>USD
                                                <asp:RegularExpressionValidator ID="revLabTestFee" runat="server" ControlToValidate="tbLabTestFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceLabTestFee" runat="server" TargetControlID="revLabTestFee">
                                                </act:ValidatorCalloutExtender>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlTech" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlAccredited" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload6" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload7" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload8" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload9" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload10" runat="server" />
                                        <asp:UpdatePanel ID="upFile3" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="FileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Files] WHERE [FileID] = @FileID"
                                                    SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='C'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="FileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="DocID" QueryStringField="fsid" Type="Int32" />
                                                        <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
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
                        <td class="tdRowName">
                            Document translation Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbDocTranslationFee" runat="server" Width="80px"></asp:TextBox>USD
                            <asp:RegularExpressionValidator ID="revDocTranslationFee" runat="server" ControlToValidate="tbDocTranslationFee"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceDocTranslationFee" runat="server" TargetControlID="revDocTranslationFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Bank Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbBankFee" runat="server" Width="80px"></asp:TextBox>USD
                            <asp:RegularExpressionValidator ID="revBankFee" runat="server" ControlToValidate="tbBankFee"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceBankFee" runat="server" TargetControlID="revBankFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Custom clearance Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbClearanceFee" runat="server" Width="80px"></asp:TextBox>USD
                            <asp:RegularExpressionValidator ID="revClearanceFee" runat="server" ControlToValidate="tbClearanceFee"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceClearanceFee" runat="server" TargetControlID="revClearanceFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Sample return Fee：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbSampleReturnFee" runat="server" Width="80px"></asp:TextBox>USD
                            <asp:RegularExpressionValidator ID="revSampleReturnFee" runat="server" ControlToValidate="tbSampleReturnFee"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceSampleReturnFee" runat="server" TargetControlID="revSampleReturnFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Label purchase Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbLabelPurchaseFee" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revLabelPurchaseFee" runat="server" ControlToValidate="tbLabelPurchaseFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceLabelPurchaseFee" runat="server" TargetControlID="revLabelPurchaseFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload11" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload12" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload13" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload14" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload15" runat="server" />
                                        <asp:UpdatePanel ID="upFile4" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="FileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Files] WHERE [FileID] = @FileID"
                                                    SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='D'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="FileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="DocID" QueryStringField="fsid" Type="Int32" />
                                                        <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
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
                            Other Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbOtherFee" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revOtherFee" runat="server" ControlToValidate="tbOtherFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceOtherFee" runat="server" TargetControlID="revOtherFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload16" runat="server" /><br />
                                        2.<asp:FileUpload ID="FileUpload17" runat="server" /><br />
                                        3.<asp:FileUpload ID="FileUpload18" runat="server" /><br />
                                        4.<asp:FileUpload ID="FileUpload19" runat="server" /><br />
                                        5.<asp:FileUpload ID="FileUpload20" runat="server" />
                                        <asp:UpdatePanel ID="upFile5" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile5" runat="server" SkinID="gvList" DataKeyNames="FileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "File.ashx?fid="+Eval("FileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsFile5" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Files] WHERE [FileID] = @FileID"
                                                    SelectCommand="SELECT * FROM [Ima_Files] WHERE ([DocID] = @DocID) and DocCategory=@DocCategory and FileCategory='E'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="FileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="DocID" QueryStringField="fsid" Type="Int32" />
                                                        <asp:QueryStringParameter Name="DocCategory" QueryStringField="categroy" Type="String" />
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
                            Factory Inspection Fee：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        Document Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbDocumentFee" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revDocumentFee" runat="server" ControlToValidate="tbDocumentFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceDocumentFee" runat="server" TargetControlID="revDocumentFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        One-time on-site Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbOneTimeFee" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revOneTimeFee" runat="server" ControlToValidate="tbOneTimeFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceOneTimeFee" runat="server" TargetControlID="revOneTimeFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Periodic on-site Inspection Fee：
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbPeriodicFee" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revPeriodicFee" runat="server" ControlToValidate="tbPeriodicFee"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vcePeriodicFee" runat="server" TargetControlID="revPeriodicFee">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Renewal Fee：</td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>W/Test：</td>
                                    <td>
                                        <asp:TextBox ID="tbRenewalWTest" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revRenewalWTest" runat="server" ControlToValidate="tbRenewalWTest"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceRenewalWTest" runat="server" TargetControlID="revRenewalWTest">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>W/O Test：</td>
                                    <td>
                                        <asp:TextBox ID="tbRenewalWOTest" runat="server" Width="80px"></asp:TextBox>USD
                                        <asp:RegularExpressionValidator ID="revRenewalWOTest" runat="server" ControlToValidate="tbRenewalWOTest"
                                            ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                            SetFocusOnError="True"></asp:RegularExpressionValidator>
                                        <act:ValidatorCalloutExtender ID="vceRenewalWOTest" runat="server" TargetControlID="revRenewalWOTest">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">Remark：</td>
                                    <td>
                                        <asp:TextBox ID="tbRenewalRemark" runat="server" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Sub Total Cost(New Application)：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upTotalCostNA" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:TextBox ID="tbTotalCostFeeNA" runat="server" Width="100px" Enabled="False"></asp:TextBox>USD
                                    <asp:Button ID="btnCalculateNA" runat="server" Text="Calculate" OnClick="btnCalculate_Click" CommandName="NA" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Lead Time(New Application)：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLeadTimeNA" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Sub Total Cost(Renewal)：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upTotalCost" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:TextBox ID="tbTotalCostFee" runat="server" Width="100px" Enabled="False"></asp:TextBox>USD
                                    <asp:Button ID="btnCalculate" runat="server" Text="Calculate" OnClick="btnCalculate_Click" CommandName="Renewal" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Lead Time(Renewal)：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLeadTime" runat="server"></asp:TextBox>
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

