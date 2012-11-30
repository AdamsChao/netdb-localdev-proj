<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaApplication.aspx.cs" Inherits="Ima_ImaApplication" StylesheetTheme="IMA" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script language="javascript" type="text/javascript" src="../Scripts/IMA.js"></script>
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
                            Name of approval method：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbTypeApproval" runat="server" Text="Type Approval" />
                            <asp:CheckBox ID="cbRegistration" runat="server" Text="Registration" />
                            <asp:CheckBox ID="cbDispensationLitter" runat="server" Text="Dispensation Letter" />
                            <asp:CheckBox ID="cbHomologation" runat="server" Text="Homologation" /><br />
                            Other：<asp:TextBox ID="tbOtherApprovalMethod" runat="server" Width="90%"></asp:TextBox>
                            <asp:TextBox ID="tbApprovalMethod" runat="server" Width="90%" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission Methods：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbDirect" runat="server" Text="Direct Submission" />
                            <asp:CheckBox ID="cbLocalAgent" runat="server" Text="Local Agent Submission" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission in-person：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblInPerson" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Hard Copy：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblHardCopy" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Website：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblWebsite" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ Email：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblEmail" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Submission w/ CD：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCD" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Remark：</td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbSubmissionDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
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
                                                <asp:GridView ID="gvFile1" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='A'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                            Accepts：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbFCCTest" runat="server" Text="FCC Test Report" />
                            <asp:CheckBox ID="cbCETest" runat="server" Text="CE Test Report" />
                            <asp:CheckBox ID="cbLocalTest" runat="server" Text="Local Testing" />
                            <asp:CheckBox ID="cbOther" runat="server" Text="Other" />
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Samples required：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rbtnlSamplesRequired" runat="server"  RepeatDirection="Horizontal">
                                <asp:ListItem Text="No Samples required" Value="false" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Samples required(See Testing and Submission Preparation)" Value="true"></asp:ListItem>
                            </asp:RadioButtonList>
                            <%--<asp:CheckBox ID="cbSamplesRequired" runat="server" Text="No Samples required"  AutoPostBack="true" oncheckedchanged="cbSamplesRequired_CheckedChanged" />--%>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Radiated Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbRadiated" runat="server"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revRadiated" runat="server" ControlToValidate="tbRadiated"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceRadiated" runat="server" TargetControlID="revRadiated">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired1" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Conducted Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbConducted" runat="server"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revConducted" runat="server" ControlToValidate="tbConducted"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceConducted" runat="server" TargetControlID="revConducted">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired2" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Normal-Link Sample for testing：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbNormalLink" runat="server"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revNormalLink" runat="server" ControlToValidate="tbNormalLink"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceNormalLink" runat="server" TargetControlID="revNormalLink">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired3" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Testing Sample for review only：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbReviewOnly" runat="server"></asp:TextBox>pieces
                            <asp:RegularExpressionValidator ID="revReviewOnly" runat="server" ControlToValidate="tbReviewOnly"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceReviewOnly" runat="server" TargetControlID="revReviewOnly">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="trSamplesRequired4" runat="server">
                        <td class="tdRowName" valign="top">
                            Modular Approval acceptable：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblModular" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbModularDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
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
                                                <asp:GridView ID="gvFile2" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='B'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                            Local Representative required：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblRepresentative" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="LocalCompany" Text="Local Company" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="LocalDealer" Text="Local Dealer"></asp:ListItem>
                                            <asp:ListItem Value="RealImporter" Text="Real Importer"></asp:ListItem>
                                            <asp:ListItem Value="Distributor" Text="Distributor"></asp:ListItem>
                                            <asp:ListItem Value="NotRequired" Text="Not Required"></asp:ListItem>
                                            <asp:ListItem Value="Operator" Text="Operator"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbRepresentativeDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
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
                                                <asp:GridView ID="gvFile3" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='C'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr1" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Test Lab Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLabLeadTime" runat="server"></asp:TextBox>week(s)
                            <asp:RegularExpressionValidator ID="revLabLeadTime" runat="server" ControlToValidate="tbLabLeadTime"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceLabLeadTime" runat="server" TargetControlID="revLabLeadTime">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="tr2" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Certification Body Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbBodyLeadTime" runat="server"></asp:TextBox>week(s)
                            <asp:RegularExpressionValidator ID="revBodyLeadTime" runat="server" ControlToValidate="tbBodyLeadTime"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceBodyLeadTime" runat="server" TargetControlID="revBodyLeadTime">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr id="tr3" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Authority Lead-Time：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAuthorityLeadTime" runat="server"></asp:TextBox>week(s)
                            <asp:RegularExpressionValidator ID="revAuthorityLeadTime" runat="server" ControlToValidate="tbAuthorityLeadTime"
                                ErrorMessage="Input Integer" Display="None" ValidationExpression="\d+" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceAuthorityLeadTime" runat="server" TargetControlID="revAuthorityLeadTime">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Expedited Process Available ：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblExpeditedProcess" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbExpeditedProcessDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
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
                                                <asp:GridView ID="gvFile4" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='D'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                        <td class="tdRowName" valign="top">Certification Control by：</td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbControlByCertificate" runat="server" Text="Certificate # / Approval #" />
                            <asp:CheckBox ID="cbControlByModel" runat="server" Text="Model #" />
                            <asp:CheckBox ID="cbControlByID" runat="server" Text="ID #" /><br />
                            Others：<asp:TextBox ID="tbControlByOther" runat="server" Width="350px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Multiple Model Names listed：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblMMNamesListed" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Adding model after approval ：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblAfterApproval" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbModelDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload16" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload17" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload18" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload19" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload20" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile5" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile5" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='E'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="tr7" runat="server" visible="false">
                        <td colspan="2" class="tdHeader1">
                            Certificate Holder(s)
                        </td>
                    </tr>
                    <tr id="tr6" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Foreign Applicant：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblForeignApplicant" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="tr5" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Any Local Person/Company：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblAnyLocalPerson" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="tr4" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Actual Importer：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblActualImporter" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="trLocalDealer" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Local Dealer：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblLocalDealer" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbCertificateHolderDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload21" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload22" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload23" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload24" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload25" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile6" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile6" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                                    DataSourceID="sdsFile6">
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsFile6" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='F'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                            Declaration of Origin required：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblOriginRequired" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr id="trISO" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            ISO/Quality documents required：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblQualityRequired" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Yes" Text="Yes(Specify)" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbRequiredDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox><br />
                                        *Specify if these documents must be of the manufacturer or actual factories*
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload26" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload27" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload28" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload29" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload30" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile7" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile7" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                                    DataSourceID="sdsFile7">
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsFile7" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='G'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                            Contract required with Local Agent：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblContractRequired" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Notarized PoA required 
                            <br />
                            with Local Agent：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblNotarizedPoARequired" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certificate Number/ID created by：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificateIDCreateBy" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Authority" Text="Authority" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="User" Text="User"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Possible to get certificate number 
                            <br />
                            before certificate issuance t：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblGetCertificateNumber" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="Yes" Text="Yes" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="No" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Provisional Certificate Y/N & Validity：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:RadioButtonList ID="rblProvisional" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                                        <asp:ListItem Value="No" Text="No" Selected="True"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    ；<asp:TextBox ID="tbProvisionalYears" runat="server" Width="50"></asp:TextBox>years
                                                    <asp:RegularExpressionValidator ID="revProvisionalYears" runat="server" ControlToValidate="tbProvisionalYears"
                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                    <act:ValidatorCalloutExtender ID="vceProvisionalYears" runat="server" TargetControlID="revProvisionalYears">
                                                    </act:ValidatorCalloutExtender>
                                                </td>
                                                <td>
                                                    ，<asp:TextBox ID="tbProvisionalMonths" runat="server" Width="50"></asp:TextBox>months
                                                    <asp:RegularExpressionValidator ID="revProvisionalMonths" runat="server" ControlToValidate="tbProvisionalMonths"
                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                    <act:ValidatorCalloutExtender ID="vceProvisionalMonths" runat="server" TargetControlID="revProvisionalMonths">
                                                    </act:ValidatorCalloutExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Validity of Certificate：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:RadioButtonList ID="rblValidity" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="Permanent" Text="Permanent"></asp:ListItem>
                                                        <asp:ListItem Value="Non-Life time" Text="Non-Life time"></asp:ListItem>
                                                        <asp:ListItem Value="Life-time" Text="Life-time" Selected="True"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    ；<asp:TextBox ID="tbYears" runat="server" Width="50"></asp:TextBox>years
                                                    <asp:RegularExpressionValidator ID="revYears" runat="server" ControlToValidate="tbYears"
                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                    <act:ValidatorCalloutExtender ID="vceYears" runat="server" TargetControlID="revYears">
                                                    </act:ValidatorCalloutExtender>
                                                </td>
                                                <td>
                                                    ，<asp:TextBox ID="tbMonths" runat="server" Width="50"></asp:TextBox>months
                                                    <asp:RegularExpressionValidator ID="revMonths" runat="server" ControlToValidate="tbMonths"
                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                    <act:ValidatorCalloutExtender ID="vceMonths" runat="server" TargetControlID="revMonths">
                                                    </act:ValidatorCalloutExtender>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr id="trVD" runat="server" visible="false">
                                    <td>
                                        <asp:TextBox ID="tbValidityDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr id="trVDFile" runat="server" visible="false">
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload31" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload32" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload33" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload34" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload35" runat="server" Width="90%" />
                                        <asp:UpdatePanel ID="upFile8" runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView ID="gvFile8" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID">
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
                                                                <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "ApplicationFile.ashx?fid="+Eval("ApplicationFileID").ToString() %>'
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
                                                <asp:SqlDataSource ID="sdsFile8" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                                    SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='H'">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
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
                            Periodic Certificate Y/N & Validity：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:RadioButtonList ID="rblPeriodic" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                                        <asp:ListItem Value="No" Text="No" Selected="True"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    ；From<asp:TextBox ID="tbPeriodicSDate" runat="server" Width="80"></asp:TextBox>
                                                    To<asp:TextBox ID="tbPeriodicSEnd" runat="server" Width="80"></asp:TextBox>
                                                    <act:CalendarExtender ID="cePeriodicSDate" runat="server" PopupButtonID="tbPeriodicSDate"
                                                        Format="yyyy/MM/dd" TargetControlID="tbPeriodicSDate">
                                                    </act:CalendarExtender>
                                                    <%--<asp:RegularExpressionValidator ID="revPeriodicSDate" runat="server" ControlToValidate="tbPeriodicSDate"
                                                        ErrorMessage="Input Date" Display="None" ValidationExpression="^(19|20)\d\d[-/.]((0[1-9])|([1-9])|(1[0-2]))[-/.](([0-2][1-9])|([1-2]0)|(3[0-1])|([1-9]))"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                                                    <%--<act:ValidatorCalloutExtender ID="vcePeriodicSDate" runat="server" TargetControlID="revPeriodicSDate">
                                                    </act:ValidatorCalloutExtender>--%>
                                                    <act:CalendarExtender ID="cePeriodicSEnd" runat="server" PopupButtonID="tbPeriodicSEnd"
                                                        Format="yyyy/MM/dd" TargetControlID="tbPeriodicSEnd">
                                                    </act:CalendarExtender>
                                                    <%--<asp:RegularExpressionValidator ID="revPeriodicSEnd" runat="server" ControlToValidate="tbPeriodicSEnd"
                                                        ErrorMessage="Input Date" Display="None" ValidationExpression="^(19|20)\d\d[-/.]((0[1-9])|([1-9])|(1[0-2]))[-/.](([0-2][1-9])|([1-2]0)|(3[0-1])|([1-9]))"
                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>--%>
                                                    <%--<act:ValidatorCalloutExtender ID="vcePeriodicSEnd" runat="server" TargetControlID="revPeriodicSEnd">
                                                    </act:ValidatorCalloutExtender>--%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Certificate by Shipment/Quantity：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbShipment" runat="server" Width="500px"></asp:TextBox>
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

