<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true"
    CodeFile="ImaGeneralEdit.aspx.cs" Inherits="Ima_ImaGeneralEdit" StylesheetTheme="IMA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<link href="../App_Themes/Ima.css" type="text/css" rel="Stylesheet" />--%>
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
                            General Edit
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                           1.Voltage，Frequency，and Plug type
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span> Voltage：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbVoltage" runat="server"></asp:TextBox>V
                            <asp:RequiredFieldValidator ID="rfvVoltage" runat="server" ControlToValidate="tbVoltage"
                                ErrorMessage="Input Voltage" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveVoltage" runat="server" TargetControlID="rfvVoltage">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span> Frequency：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFrequency" runat="server"></asp:TextBox>Hz
                            <asp:RequiredFieldValidator ID="rfvFrequency" runat="server" ControlToValidate="tbFrequency"
                                ErrorMessage="Input Frequency" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="vceFrequency" runat="server" TargetControlID="rfvFrequency">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            <span style="color: Red; font-size: 10pt;">*</span> Plug Type(s)：
                        </td>
                        <td class="tdRowValue" valign="top">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbPlugType" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvPlugType" runat="server" ControlToValidate="tbPlugType"
                                            ErrorMessage="Input Plug Type(s)" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <act:ValidatorCalloutExtender ID="vcePlugType" runat="server" TargetControlID="rfvPlugType">
                                        </act:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td valign="top">Image Upload：</td>
                                                <td>
                                                    <asp:FileUpload ID="fuImage" runat="server" />
                                                    <asp:Button ID="btnImageUpload" runat="server" Text="Upload" Font-Size="8pt" onclick="btnImageUpload_Click" CausesValidation="false" />
                                                    <asp:Label ID="lblImageMsg" runat="server" Font-Size="8pt" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td><asp:HiddenField ID="hfImageNum" runat="server" Value="0" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td valign="top">Description：</td>
                                                <td><asp:TextBox ID="tbImageDesc" runat="server" Rows="3" TextMode="MultiLine" Width="400px"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upImages" runat="server">
                                            <ContentTemplate>
                                                <asp:DataList ID="dlImages" runat="server" DataKeyField="GeneralImageID" 
                                                    RepeatColumns="1" RepeatDirection="Horizontal" 
                                                    ondeletecommand="dlImages_DeleteCommand">
                                                    <ItemTemplate>
                                                        <table border="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:Image ID="img" runat="server" ImageUrl='<%# Eval("GeneralImageURL") %>'/>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblImgDec" runat="server" Text='<%# Eval("GeneralImageDesc") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnImgDel" runat="server" CommandArgument='<%# Eval("GeneralImageURL") %>'
                                                                        CommandName="Delete" CssClass="btn_b" OnClientClick="return confirm('Delete the Picture？')"
                                                                        Text="Delete the Picture" CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            2.Currency used by government
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span> Currency Code：
                        </td>
                        <td class="tdRowValue">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:UpdatePanel ID="upCurrencyCode" runat="server">
                                            <ContentTemplate>
                                                <asp:TextBox ID="tbCurrency_Code" runat="server" AutoPostBack="True" 
                                                    ontextchanged="tbCurrency_Code_TextChanged"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfvCurrency_Code" runat="server" ControlToValidate="tbCurrency_Code"
                                                    ErrorMessage="Input Currency Code" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                                <act:ValidatorCalloutExtender ID="vceCurrency_Code" runat="server" TargetControlID="rfvCurrency_Code">
                                                </act:ValidatorCalloutExtender>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnSelCurrencyCode" EventName="Click" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td valign="baseline"><asp:Button ID="btnSelCurrencyCode" runat="server" Text="Auto Input" CausesValidation="false" OnClick="btnSelCurrencyCode_Click" Font-Size="8pt" Width="64px" /></td>
                                    <td>
                                        <asp:UpdatePanel ID="upCurrencyCodeMsg" runat="server">
                                            <ContentTemplate>
                                                <asp:Label ID="lblCurrencyCodeMsg" runat="server" Font-Size="8pt" ForeColor="Red"></asp:Label>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnSelCurrencyCode" EventName="Click" />
                                                <asp:AsyncPostBackTrigger ControlID="tbCurrency_Code" EventName="TextChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            3.Currency exchange rate
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Currency
                            <br />
                            exchange rate：
                        </td>
                        <td class="tdRowValue">
                            1 USD to<asp:TextBox ID="tbExchange_rate_USD" runat="server"></asp:TextBox><br />
                            1 EUR to<asp:TextBox ID="tbExchange_rate_EUR" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revExchange_rate_USD" runat="server" ControlToValidate="tbExchange_rate_USD"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceExchange_rate_USD" runat="server" TargetControlID="revExchange_rate_USD">
                            </act:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator ID="revExchange_rate_EUR" runat="server" ControlToValidate="tbExchange_rate_EUR"
                                ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceExchange_rate_EUR" runat="server" TargetControlID="revExchange_rate_EUR">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            4.Country code
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span> Country code：
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upCountryCode" runat="server">
                                <ContentTemplate>
                                    +<asp:TextBox ID="tbCountry_Code" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCountry_Code" runat="server" ControlToValidate="tbCountry_Code"
                                        ErrorMessage="Input Country code" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <act:ValidatorCalloutExtender ID="vceCountry_Code" runat="server" TargetControlID="rfvCountry_Code">
                                    </act:ValidatorCalloutExtender>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSelCurrencyCode" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            5.Culture & Taboos
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Culture & Taboos：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCulture_Taboos" runat="server" Rows="5" TextMode="MultiLine" Width="500px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="tdRowName">
                            FileUpload：
                        </td>
                        <td class="tdRowValue">
                            1.<asp:FileUpload ID="fuGeneral1" runat="server" Width="90%" /><br />
                            2.<asp:FileUpload ID="fuGeneral2" runat="server" Width="90%" /><br />
                            3.<asp:FileUpload ID="fuGeneral3" runat="server" Width="90%" /><br />
                            4.<asp:FileUpload ID="fuGeneral4" runat="server" Width="90%" /><br />
                            5.<asp:FileUpload ID="fuGeneral5" runat="server" Width="90%" />
                        </td>
                    </tr>
                    <tr id="trDocList" runat="server">
                        <td valign="top" class="tdRowName">
                            Files List：
                        </td>
                        <td class="tdRowValue">
                            <asp:GridView ID="gvIma_General_Files" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="GeneralFileID" DataSourceID="sdsIma_General_Files" BackColor="White"
                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                        </ItemTemplate>
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
                                            <asp:HyperLink ID="hlGeneralFileName" runat="server" NavigateUrl='<%# "GeneralFile.ashx?gfid="+Eval("GeneralFileID").ToString() %>'
                                                Text='<%# Eval("GeneralFileName").ToString()+"."+Eval("GeneralFileType").ToString() %>'
                                                Target="_blank"></asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <RowStyle ForeColor="#000066" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#00547E" />
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
                    <tr>
                        <td colspan="2" align="center" class="tdFooter">
                            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
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
