<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="AccreditedTestLab.aspx.cs" Inherits="Ima_AccreditedTestLab" StylesheetTheme="IMA" %>

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
                            <asp:Label ID="lblProType" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr id="trCopyTo" runat="server" visible="false">
                        <td class="tdRowName" valign="top">
                            Coyp to：
                        </td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id" onclick="CertificationSelect(this);">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <span style="color: Red; font-size: 10pt;">*</span>Accredited Lab：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAccreditedLab" runat="server" Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAccreditedLab" runat="server" ControlToValidate="tbAccreditedLab"
                                ErrorMessage="Input Accredited Lab" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveAccreditedLab" runat="server" TargetControlID="rfvAccreditedLab">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Volume Per Year：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbVolumePerYear" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Publish：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblPublish" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="NO" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                            &nbsp;&nbsp;
                            Website：
                            <asp:TextBox ID="tbWebsite" runat="server" Width="450px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">
                            Contact
                        </td>
                        <td class="tdRowValue">
                            <asp:UpdatePanel ID="upContact" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table border="0">
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnAddContact" runat="server" Text="Add Contact" CausesValidation="false" />
                                                <asp:Label ID="lblContactIDTemp" runat="server" Visible="false"></asp:Label>
                                                <div>
                                                    <act:ModalPopupExtender ID="mpeContact" runat="server" TargetControlID="btnAddContact"
                                                        PopupControlID="panAddContact" PopupDragHandleControlID="panAddContact" BackgroundCssClass="mpeBackground"
                                                        DropShadow="true" CancelControlID="btnCCancel">
                                                    </act:ModalPopupExtender>
                                                    <asp:Panel ID="panAddContact" runat="server" Style="display: none; width: 800px;">
                                                        <table border="0" width="100%" align="center" class="tbModalPopup">
                                                            <tr>
                                                                <td colspan="2" class="tdHeader" align="center">
                                                                    Contact Edit
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    First Name：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbFirstName" runat="server" Width="90%"></asp:TextBox>
                                                                    <asp:Label ID="lblContactID" runat="server" Visible="false"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Last Name：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbLastName" runat="server" Width="90%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Title：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbTitle" runat="server" Width="90%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Work Phone：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbWorkPhone" runat="server"></asp:TextBox>
                                                                    &nbsp;&nbsp;&nbsp; EXT：<asp:TextBox ID="tbExt" runat="server" Width="60px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Fax：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbFax" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Cell Phone：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbCellPhone" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Adress：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbAdress" runat="server" Width="96%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Country：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name"
                                                                        DataValueField="country_id">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                                        SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr id="trSubFee" runat="server" visible="false">
                                                                <td class="tdRowName">
                                                                    Submission Fee：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbFee" runat="server"></asp:TextBox>
                                                                    <asp:DropDownList ID="ddlFeeUnit" runat="server">
                                                                        <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                                                        <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RegularExpressionValidator ID="revFee" runat="server" ControlToValidate="tbFee"
                                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                                        SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                                    <act:ValidatorCalloutExtender ID="vceFee" runat="server" TargetControlID="revFee">
                                                                    </act:ValidatorCalloutExtender>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Lead Time：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbLeadTime" runat="server" Width="60px" ValidationGroup="A"></asp:TextBox>&nbsp;Weeks
                                                                    <asp:RegularExpressionValidator ID="revLeadTime" runat="server" ControlToValidate="tbLeadTime"
                                                                        ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                                        SetFocusOnError="True" ValidationGroup="A"></asp:RegularExpressionValidator>
                                                                    <act:ValidatorCalloutExtender ID="vceLeadTime" runat="server" TargetControlID="revLeadTime">
                                                                    </act:ValidatorCalloutExtender>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="tdRowName">
                                                                    Remark：
                                                                </td>
                                                                <td class="tdRowValue">
                                                                    <asp:TextBox ID="tbRemark" runat="server" Width="90%" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" class="tdHeader" align="center">
                                                                    <asp:Button ID="btnCSave" runat="server" Text="Save" OnClick="btnCSave_Click" ValidationGroup="A" />
                                                                    <asp:Button ID="btnCCancel" runat="server" Text="Cancel" CausesValidation="false" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvContact" runat="server" SkinID="gvList" DataKeyNames="ContactID,IsTemp"
                                                    OnRowCommand="gvContact_RowCommand" OnRowDataBound="gvContact_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaContactDetail.aspx?ContactID="+Eval("ContactID").ToString() %>'>Detail</asp:HyperLink>
                                                                <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEdit"
                                                                    Text="Edit" CommandArgument='<%# Eval("ContactID") %>'></asp:LinkButton>
                                                                <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="GoDel"
                                                                    Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("ContactID") %>'></asp:LinkButton>
                                                                <act:ModalPopupExtender ID="mpeContactEdit" runat="server" TargetControlID="lbtnEdit"
                                                                    PopupControlID="panContactEdit" PopupDragHandleControlID="panContactEdit" BackgroundCssClass="mpeBackground"
                                                                    DropShadow="true" CancelControlID="btnEditCancel">
                                                                </act:ModalPopupExtender>
                                                                <asp:Panel ID="panContactEdit" runat="server" Style="display: none; width: 800px;">
                                                                    <table border="0" width="100%" align="center" class="tbModalPopup">
                                                                        <tr>
                                                                            <td colspan="2" class="tdHeader" align="center">
                                                                                Contact Edit
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                First Name：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbFirstName" runat="server" Width="90%" Text='<%#Eval("FirstName") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblFirstName" runat="server" Text='<%#Eval("FirstName") %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblContactID" runat="server" Text='<%#Eval("ContactID") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Last Name：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbLastName" runat="server" Width="90%" Text='<%#Eval("LastName") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblLastName" runat="server" Text='<%#Eval("LastName") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Title：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbTitle" runat="server" Width="90%" Text='<%#Eval("Title") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Title") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Work Phone：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbWorkPhone" runat="server" Text='<%#Eval("WorkPhone") %>'></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp; EXT：<asp:TextBox ID="tbExt" runat="server" Width="60px" Text='<%#Eval("Ext") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblWorkPhone" runat="server" Text='<%#Eval("WorkPhone") %>' Visible="false"></asp:Label>
                                                                                <asp:Label ID="lblExt" runat="server" Text='<%#Eval("Ext") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Fax：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbFax" runat="server" Text='<%#Eval("Fax") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblFax" runat="server" Text='<%#Eval("Fax") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Cell Phone：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbCellPhone" runat="server" Text='<%#Eval("CellPhone") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblCellPhone" runat="server" Text='<%#Eval("CellPhone") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Adress：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbAdress" runat="server" Width="96%" Text='<%#Eval("Adress") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblAdress" runat="server" Text='<%#Eval("Adress") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Country：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name"
                                                                                    DataValueField="country_id">
                                                                                </asp:DropDownList>
                                                                                <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                                                    SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                                                                                </asp:SqlDataSource>
                                                                                <asp:Label ID="lblCountryID" runat="server" Text='<%#Eval("CountryID") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Lead Time：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbLeadTime" runat="server" Width="60px" ValidationGroup="B" Text='<%#Eval("LeadTime") %>'></asp:TextBox>&nbsp;Weeks
                                                                                <asp:RegularExpressionValidator ID="revLeadTime" runat="server" ControlToValidate="tbLeadTime"
                                                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                                                    SetFocusOnError="True" ValidationGroup="B"></asp:RegularExpressionValidator>
                                                                                <act:ValidatorCalloutExtender ID="vceLeadTime" runat="server" TargetControlID="revLeadTime">
                                                                                </act:ValidatorCalloutExtender>
                                                                                <asp:Label ID="lblLeadTime" runat="server" Text='<%#Eval("LeadTime") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td class="tdRowName">
                                                                                Remark：
                                                                            </td>
                                                                            <td class="tdRowValue">
                                                                                <asp:TextBox ID="tbRemark" runat="server" Width="90%" TextMode="MultiLine" Rows="2"
                                                                                    Text='<%#Eval("Remark") %>'></asp:TextBox>
                                                                                <asp:Label ID="lblRemark" runat="server" Text='<%#Eval("Remark") %>' Visible="false"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2" class="tdHeader" align="center">
                                                                                <asp:Button ID="btnEditSave" runat="server" Text="Save" OnClick="btnEditSave_Click"
                                                                                    ValidationGroup="B" CommandArgument='<%#Container.DataItemIndex%>' />
                                                                                <asp:Button ID="btnEditCancel" runat="server" Text="Cancel" CausesValidation="false" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                            </ItemTemplate>
                                                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Copy to">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chContactCopy" runat="server" Checked="true" />
                                                            </ItemTemplate>
                                                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                                                        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                                                        <asp:BoundField DataField="Title" HeaderText="Title">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Work Phone">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFileURL" runat="server" Text='<%#Eval("WorkPhone").ToString() + (Eval("Ext").ToString()!="" ? "  Ext："+Eval("Ext").ToString() : "")%>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">
                            Test Fee by Technologies
                        </td>
                    </tr>
                    <tr id="trTechRF" runat="server" style="display: none;">
                        <td class="tdRowName" valign="top">
                            RF：
                        </td>
                        <td class="tdRowValue">
                            <table border="0">
                                <tr>
                                    <td colspan="2">
                                        <asp:DataList ID="dlTechRF" runat="server" DataSourceID="sdsTechRF" DataKeyField="wowi_tech_id"
                                            RepeatColumns="2" RepeatDirection="Horizontal">
                                            <ItemTemplate>
                                                <table border="0">
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="cbRFFee" runat="server" Checked='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                onclick="TechFee(this);" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTechRF" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tbRFFee" runat="server" Width="60px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:RegularExpressionValidator ID="revRFFee" runat="server" ControlToValidate="tbRFFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceRFFee" runat="server" TargetControlID="revRFFee">
                                                </act:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="10000" Name="wowi_product_type_id" Type="Int32" />
                                                <asp:QueryStringParameter Name="DID" QueryStringField="atid" Type="Int32" DefaultValue="0" />
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
                        </td>
                    </tr>
                    <tr id="trTechEMC" runat="server" style="display: none;">
                        <td class="tdRowName" valign="top">
                            EMC：
                        </td>
                        <td class="tdRowValue">
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
                                                                onclick="TechFee(this);" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTechEMC" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tbEMCFee" runat="server" Width="60px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:RegularExpressionValidator ID="revEMCFee" runat="server" ControlToValidate="tbEMCFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceEMCFee" runat="server" TargetControlID="revEMCFee">
                                                </act:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="10001" Name="wowi_product_type_id" Type="Int32" />
                                                <asp:QueryStringParameter Name="DID" QueryStringField="atid" Type="Int32" DefaultValue="0" />
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
                        </td>
                    </tr>
                    <tr id="trTechSafety" runat="server" style="display: none;">
                        <td class="tdRowName" valign="top">
                            Safety：
                        </td>
                        <td class="tdRowValue">
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
                                                                onclick="TechFee(this);" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTechSafety" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tbSafetyFee" runat="server" Width="60px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:RegularExpressionValidator ID="revSafetyFee" runat="server" ControlToValidate="tbSafetyFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceSafetyFee" runat="server" TargetControlID="revSafetyFee">
                                                </act:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="10002" Name="wowi_product_type_id" Type="Int32" />
                                                <asp:QueryStringParameter Name="DID" QueryStringField="atid" Type="Int32" DefaultValue="0" />
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
                        </td>
                    </tr>
                    <tr id="trTechTelecom" runat="server" style="display: none;">
                        <td class="tdRowName" valign="top">
                            Telecom：
                        </td>
                        <td class="tdRowValue">
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
                                                                onclick="TechFee(this);" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTechTelecom" runat="server" Text='<%#Eval("wowi_tech_name") %>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="tbTelecomFee" runat="server" Width="60px" Enabled='<%# Eval("DID").ToString()!="" ? true : false %>'
                                                                Text='<%#Eval("Fee") %>'></asp:TextBox>USD
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:RegularExpressionValidator ID="revTelecomFee" runat="server" ControlToValidate="tbTelecomFee"
                                                    ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$"
                                                    SetFocusOnError="True"></asp:RegularExpressionValidator>
                                                <act:ValidatorCalloutExtender ID="vceTelecomFee" runat="server" TargetControlID="revTelecomFee">
                                                </act:ValidatorCalloutExtender>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            SelectCommand="STP_IMAGetTechList" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="10003" Name="wowi_product_type_id" Type="Int32" />
                                                <asp:QueryStringParameter Name="DID" QueryStringField="atid" Type="Int32" DefaultValue="0" />
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
                                        <asp:TextBox ID="tbTelecomRemark" runat="server" Width="400px" TextMode="MultiLine"
                                            Rows="2"></asp:TextBox>
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

