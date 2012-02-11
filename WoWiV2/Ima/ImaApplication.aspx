<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaApplication.aspx.cs" Inherits="Ima_ImaApplication" StylesheetTheme="IMA" MaintainScrollPositionOnPostback="true" %>

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
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Name of approval method：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbApprovalMethod" runat="server" Width="90%"></asp:TextBox>
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
                        <td class="tdRowName" valign="top">
                        </td>
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
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='A'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
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
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Samples required：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBox ID="cbSamplesRequired" runat="server" Text="No Samples required" 
                                AutoPostBack="True" oncheckedchanged="cbSamplesRequired_CheckedChanged" />
                        </td>
                    </tr>
                    <%--<tr id="trSamplesRequired" runat="server">
                        <td colspan="2">
                            <table border="0" cellpadding="0" cellspacing="0">
                            </table>
                        </td>
                    </tr>--%>
                    <tr id="trSamplesRequired" runat="server">
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
                    <tr id="trSamplesRequired1" runat="server">
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
                    <tr id="trSamplesRequired2" runat="server">
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
                    <tr id="trSamplesRequired3" runat="server">
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
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='B'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
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
                                            <asp:ListItem Value="NotRequired" Text="Not Required"></asp:ListItem>
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
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='C'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
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
                    <tr>
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
                    <tr>
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
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='D'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Control by：</td>
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
                                            DeleteCommand="DELETE FROM [Ima_Application_Files] WHERE [ApplicationFileID] = @ApplicationFileID"
                                            SelectCommand="SELECT * FROM [Ima_Application_Files] WHERE ([ApplicationID] = @ApplicationID) and FileCategory='E'">
                                            <DeleteParameters>
                                                <asp:Parameter Name="ApplicationFileID" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="ApplicationID" QueryStringField="aid" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            Certificate Holder(s)
                        </td>
                    </tr>
                    <tr>
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
                    <tr>
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
                    <tr>
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
                    <tr>
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
                    <tr>
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
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Contract required 
                            <br />
                            with Local Agent：
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
                            Certificate Number/ID 
                            <br />
                            created by：
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
                            Validity of Certificate：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:RadioButtonList ID="rblValidity" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem Value="Life-time" Text="Life-time" Selected="True"></asp:ListItem>
                                            <asp:ListItem Value="Non-Life time" Text="Non-Life time"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbValidityDesc" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        1.<asp:FileUpload ID="FileUpload31" runat="server" Width="90%" /><br />
                                        2.<asp:FileUpload ID="FileUpload32" runat="server" Width="90%" /><br />
                                        3.<asp:FileUpload ID="FileUpload33" runat="server" Width="90%" /><br />
                                        4.<asp:FileUpload ID="FileUpload34" runat="server" Width="90%" /><br />
                                        5.<asp:FileUpload ID="FileUpload35" runat="server" Width="90%" />
                                        <asp:GridView ID="gvFile8" runat="server" SkinID="gvList" DataKeyNames="ApplicationFileID"
                                            DataSourceID="sdsFile8">
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

