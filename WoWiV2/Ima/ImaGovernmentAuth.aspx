<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="ImaGovernmentAuth.aspx.cs" Inherits="Ima_ImaGovernmentAuth" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="../UserControls/ImaTree.ascx" TagName="ImaTree" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script language="javascript" type="text/javascript">
        function CertificationSelect(a) {
            var ControlRef = a;
            //var ControlRef = document.getElementById('<%= cbProductType.ClientID %>');
            var CheckBoxListArray = ControlRef.getElementsByTagName('input');
            var strContentID = a.id.split("_", 1);
            for (var i = 0; i < CheckBoxListArray.length; i++) {
                var checkBoxRef = CheckBoxListArray[i];
                var strType = checkBoxRef.parentElement.innerText;
                var trID = document.getElementById(strContentID + "_trTech" + strType);
                //alert(checkBoxRef.value);
                if (checkBoxRef.checked == true) {
                    trID.style.display = "";
                }
                else {
                    trID.style.display = "none";
                }
            }
        }


        function TechSelect(a) {
            //var ControlRef = document.getElementById(a.id.replace('_0', ''));
            var ControlRef = document.getElementById(a.id.substring(0, a.id.lastIndexOf("_")));
            var CheckBoxListArray = ControlRef.getElementsByTagName('input');
            for (var i = 0; i < CheckBoxListArray.length; i++) {
                var checkBoxRef = CheckBoxListArray[i];
                checkBoxRef.checked = a.checked;
            }
        }


        function Tech(a) {
            var ControlRef = document.getElementById(a.id.substring(0, a.id.lastIndexOf("_")));
            var CheckBoxListArray = ControlRef.getElementsByTagName('input');
            var checkBoxRef;
            var b = true;
            if (!a.checked) {
                b = false;
            }
            else {
                for (var i = 1; i < CheckBoxListArray.length; i++) {
                    checkBoxRef = CheckBoxListArray[i];
                    if (!checkBoxRef.checked) { b = false; break; }
                }
             }
            checkBoxRef = CheckBoxListArray[0];
            checkBoxRef.checked = b;
        }

    </script>
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
                                DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id"
                                onclick="CertificationSelect(this);">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish=1">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            <%--<span style="color: Red; font-size: 10pt;">*</span>--%>Authority FullName：
                        </td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFullAuthorityName" runat="server" Width="90%"></asp:TextBox>
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
                            <asp:TextBox ID="tbAbbreviatedAuthorityName" runat="server" Width="90%"></asp:TextBox>
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
                            Also certification body：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificationBody" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Also accredited test lab：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblAccreditedTest" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                <asp:ListItem Text="No" Value="No" Selected="True"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">
                            Certificate is valid for：
                        </td>
                        <td class="tdRowValue">
                            <asp:RadioButtonList ID="rblCertificateValid" runat="server" 
                                RepeatDirection="Horizontal">
                                <asp:ListItem Text="Single Importer" Value="Single" Selected="True"></asp:ListItem>
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
                    <tr>
                        <td colspan="2" class="tdHeader1">Contact</td>
                    </tr>
                    <tr>
                        <td class="tdRowName">First Name：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFirstName" runat="server" Width="90%"></asp:TextBox>
                            <asp:Label ID="lblContactID" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Last Name：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLastName" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Title：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbTitle" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Work Phone：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbWorkPhone" runat="server"></asp:TextBox>
                            &nbsp;&nbsp;&nbsp; EXT：<asp:TextBox ID="tbExt" runat="server" Width="60px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Cell Phone：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbCellPhone" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Adress：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbAdress" runat="server" Width="96%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Country：</td>
                        <td class="tdRowValue">
                            <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name" DataValueField="country_id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Submission Fee：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbFee" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddlFeeUnit" runat="server">
                                <asp:ListItem Text="USD" Value="USD"></asp:ListItem>
                                <asp:ListItem Text="EUR" Value="EUR"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RegularExpressionValidator ID="revFee" runat="server" ControlToValidate="tbFee" ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceFee" runat="server" TargetControlID="revFee">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Lead Time：</td>
                        <td class="tdRowValue">
                            <asp:TextBox ID="tbLeadTime" runat="server" Width="60px"></asp:TextBox>&nbsp;Weeks
                            <asp:RegularExpressionValidator ID="revLeadTime" runat="server" ControlToValidate="tbLeadTime" ErrorMessage="Input Numeric" Display="None" ValidationExpression="^\d+(\.\d+)?$" SetFocusOnError="True"></asp:RegularExpressionValidator>
                            <act:ValidatorCalloutExtender ID="vceLeadTime" runat="server" TargetControlID="revLeadTime">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="tdHeader1">Technologies</td>
                    </tr>
                    <tr id="trTechRF" runat="server" style="display:none;">
                        <td class="tdRowName">RF：</td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechRF" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='RF'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechRFAll" runat="server" Visible="false"></asp:Label>
                            <%--<asp:UpdatePanel ID="upTechRF" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbTechRF" runat="server" RepeatDirection="Horizontal" 
                                        RepeatColumns="5" DataSourceID="sdsTechRF" DataTextField="wowi_tech_name" 
                                        DataValueField="wowi_tech_id" AutoPostBack="True" 
                                        onselectedindexchanged="cbTechRF_SelectedIndexChanged">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsTechRF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='RF'">
                                    </asp:SqlDataSource>
                                    <asp:Label ID="lblTechRFAll" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cbTechRF" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr id="trTechEMC" runat="server" style="display: none;">
                        <td class="tdRowName">EMC：</td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='EMC'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechEMCAll" runat="server" Visible="false"></asp:Label>
                            <%--<asp:UpdatePanel ID="upTechEMC" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbTechEMC" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                        DataSourceID="sdsTechEMC" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id"
                                        AutoPostBack="true" OnSelectedIndexChanged="cbTechRF_SelectedIndexChanged">
                                        <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem>ITE</asp:ListItem>
                                            <asp:ListItem>Printer</asp:ListItem>
                                            <asp:ListItem>Cell Phone</asp:ListItem>
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsTechEMC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='EMC'">
                                    </asp:SqlDataSource>
                                    <asp:Label ID="lblTechEMCAll" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cbTechEMC" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr id="trTechSafety" runat="server" style="display: none;">
                        <td class="tdRowName">Safety：</td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Safety'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechSafetyAll" runat="server" Visible="false"></asp:Label>
                            <%--<asp:UpdatePanel ID="upTechSafety" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbTechSafety" runat="server" RepeatDirection="Horizontal" RepeatColumns="5"
                                        DataSourceID="sdsTechSafety" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id"
                                        AutoPostBack="true" OnSelectedIndexChanged="cbTechRF_SelectedIndexChanged">
                                        <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem>ITE</asp:ListItem>
                                            <asp:ListItem>Printer</asp:ListItem>
                                            <asp:ListItem>Cell Phone</asp:ListItem>
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsTechSafety" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Safety'">
                                    </asp:SqlDataSource>
                                    <asp:Label ID="lblTechSafetyAll" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cbTechSafety" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr id="trTechTelecom" runat="server" style="display: none;">
                        <td class="tdRowName">Telecom：</td>
                        <td class="tdRowValue">
                            <asp:CheckBoxList ID="cbTechTelecom" runat="server" RepeatDirection="Horizontal" RepeatColumns="5" DataSourceID="sdsTechTelecom" DataTextField="wowi_tech_name" DataValueField="wowi_tech_id">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Telecom'">
                            </asp:SqlDataSource>
                            <asp:Label ID="lblTechTelecomAll" runat="server" Visible="false"></asp:Label>
                            <%--<asp:UpdatePanel ID="upTechTelecom" runat="server">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbTechTelecom" runat="server" RepeatDirection="Horizontal"
                                        RepeatColumns="5" DataSourceID="sdsTechTelecom" DataTextField="wowi_tech_name"
                                        DataValueField="wowi_tech_id" AutoPostBack="true" OnSelectedIndexChanged="cbTechRF_SelectedIndexChanged">
                                        <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem>Printer</asp:ListItem>
                                            <asp:ListItem>ADSL</asp:ListItem>
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsTechTelecom" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="select a.wowi_tech_id,a.wowi_tech_name from wowi_tech a inner join wowi_product_type b on a.wowi_product_type_id=b.wowi_product_type_id where a.publish=1 and b.wowi_product_type_name='Telecom'">
                                    </asp:SqlDataSource>
                                    <asp:Label ID="lblTechTelecomAll" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cbTechTelecom" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>--%>
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

