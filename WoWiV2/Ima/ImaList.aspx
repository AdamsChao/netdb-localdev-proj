<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="ImaList.aspx.cs" Inherits="Ima_ImaList" StylesheetTheme="IMA" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register src="../UserControls/ImaTree.ascx" tagname="ImaTree" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<link href="../App_Themes/Ima.css" type="text/css" rel="Stylesheet" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <script language="javascript" type="text/javascript">
        function IsSelect() {
            var bl = false;
            if (document.getElementById('<%= ddlDocCategory.ClientID %>').selectedIndex == 0) {
                alert("Please Select Category!");
                return false;
            }
//            if (document.getElementById('<%= ddlDocCategory.ClientID %>').selectedIndex > 2) {
//                alert("constructing.......");
//                return false;
//            }          
            var ControlRef = document.getElementById('<%= cbProductType.ClientID %>');
            var CheckBoxListArray = ControlRef.getElementsByTagName('input');            
            var sValue = 0;
            for (var i = 0; i < CheckBoxListArray.length; i++) {
                var checkBoxRef = CheckBoxListArray[i];
                if (checkBoxRef.checked == true) {
                    bl = true;
                    break;
                }
            }
            if (!bl) {
                alert("Please select copy to!!");
                return false;
            }
        }
    </script>
    <table border="0" width="100%">
        <tr>
            <td valign="top">
                <uc1:ImaTree ID="ImaTree1" runat="server" />
            </td>
            <td valign="top">
                <asp:UpdatePanel ID="upCategory" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table cellpadding="1" cellspacing="1" border="0" class="tbEditItem" width="100%">
                            <tr id="trDoc1" runat="server">
                                <td class="tdHeader1" colspan="2">IMA Management</td>
                            </tr>
                            <tr id="trDoc2" runat="server">
                                <td class="tdRowName">General Data：
                                </td>
                                <td class="tdRowValue">
                                    <asp:Button ID="btnGeneral" runat="server" Text="Create General" 
                                        CausesValidation="false" onclick="btnGeneral_Click" />
                                    <asp:HyperLink ID="hlGeneral" runat="server" Visible="false" Target="_blank">Detail</asp:HyperLink>
                                    <asp:HiddenField ID="hfGID" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr id="trDoc3" runat="server">
                                <td class="tdRowName" valign="top">
                                    Product Document：
                                </td>
                                <td class="tdRowValue">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="right">Document Categories：</td>
                                            <td>
                                                <asp:DropDownList ID="ddlDocCategory" runat="server" AutoPostBack="True" 
                                                    onselectedindexchanged="ddlDocCategory_SelectedIndexChanged">
                                                    <asp:ListItem Value="0">--Please Select Category--</asp:ListItem>
                                                    <asp:ListItem Value="B">1.Government Authority</asp:ListItem>
                                                    <asp:ListItem Value="C">2.National governed rules and regulation</asp:ListItem>
                                                    <asp:ListItem Value="D">3.Certification bodies</asp:ListItem>
                                                    <asp:ListItem Value="Q">4.Accredited Test Lab</asp:ListItem>
                                                    <asp:ListItem Value="G">5.Products Control</asp:ListItem>
                                                    <asp:ListItem Value="H">6.Test Standards</asp:ListItem>
                                                    <asp:ListItem Value="F">7.Local Agent</asp:ListItem>
                                                    <asp:ListItem Value="J">8.Application Procedures</asp:ListItem>
                                                    <asp:ListItem Value="K">9.Testing and submission preparation</asp:ListItem>
                                                    <asp:ListItem Value="M">10.Sample shipping</asp:ListItem>
                                                    <asp:ListItem Value="N">11.Periodic Factory inspection</asp:ListItem>
                                                    <asp:ListItem Value="O">12.Certificate Deliver</asp:ListItem>
                                                    <asp:ListItem Value="P">13.Label and Renewal</asp:ListItem>
                                                    <asp:ListItem Value="E">14.Enforcement & Importation–Market Inspection</asp:ListItem>
                                                    <asp:ListItem Value="L">15.Fee schedule</asp:ListItem>
                                                    <asp:ListItem Value="99">16.Frequency allocation,power limit by Technologies</asp:ListItem>
                                                </asp:DropDownList>
                                                <%--<asp:RequiredFieldValidator ID="rfvDocCategory" runat="server" ControlToValidate="ddlDocCategory"
                                                    ErrorMessage="Please Select Category" Display="None" SetFocusOnError="true" InitialValue="0"></asp:RequiredFieldValidator>
                                                <act:ValidatorCalloutExtender ID="cveDocCategory" runat="server" TargetControlID="rfvDocCategory">
                                                </act:ValidatorCalloutExtender>--%>
                                            </td>
                                        </tr>
                                        <tr id="trCopy" runat="server">
                                            <td align="right"><asp:Label ID="lblCType" runat="server" Text="Copy to："></asp:Label></td>
                                            <td>
                                                <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                                    DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                                </asp:CheckBoxList>
                                                <asp:RadioButtonList ID="rblProductType" runat="server" RepeatDirection="Horizontal" Visible="false"
                                                    DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                                </asp:RadioButtonList>
                                                <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                    SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure">
                                                </asp:SqlDataSource>
                                            </td>
                                        </tr>
                                        <tr id="trTDetail" runat="server" visible="false">
                                            <td></td>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td><asp:HyperLink ID="hlDetailRF" runat="server" Target="_blank">1.View all RF datas</asp:HyperLink></td>
                                                        <td style="padding-left:6px"><asp:HyperLink ID="hlDetailEMC" runat="server" Target="_blank">2.View all EMC datas</asp:HyperLink></td>
                                                        <td style="padding-left:6px"><asp:HyperLink ID="hlDetailSafety" runat="server" Target="_blank">3.View all Safety datas</asp:HyperLink></td>
                                                        <td style="padding-left:6px"><asp:HyperLink ID="hlDetailTelecom" runat="server" Target="_blank">4.View all Telecom datas</asp:HyperLink></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="right">
                                                <asp:Button ID="btnAddDocument" runat="server" Text="Create Documents" OnClick="btnAddDocument_Click" OnClientClick="return IsSelect();" />
                                                <asp:Button ID="btnAdd" runat="server" Text="Create Documents" OnClick="btnAddDocument_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="trDL" runat="server" visible="false">
                                <td class="tdHeader1" colspan="2">
                                    Documents List<br />
                                    <asp:Label ID="lblTitle" runat="server"></asp:Label>
                                    <asp:Label ID="lblCount" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trImaGover" runat="server" visible="false">
                                <td colspan="2" class="tdRowValue">
                                    <asp:UpdatePanel ID="upB" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvImaGover" runat="server" DataKeyNames="GovernmentAuthorityID" SkinID="gvList" DataSourceID="sdsB">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditB" Text="Edit" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyB" Text="Copy" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaB.aspx" + GetQueryString(true, null, null) + "&gaid="+Eval("GovernmentAuthorityID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Full Authority Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFullAuthorityName" runat="server" Text='<%#Eval("FullAuthorityName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="200px" />
                                                        <ItemStyle HorizontalAlign="Center" Wrap="true" Width="200px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Website" HeaderText="Website" >
                                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Valid">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCertificateValid" runat="server" Text='<%# Eval("CertificateValid").ToString()!="" ? Eval("CertificateValid").ToString()+" Importer" : "" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsB" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetGovernmentAuthority" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID;delete from Ima_GoverAuth_Files where GovernmentAuthorityID=@GovernmentAuthorityID;delete from Ima_Contact where DID=@GovernmentAuthorityID and Categroy='B';delete from Ima_Technology where DID=@GovernmentAuthorityID and Categroy='B'"
                                                DeleteCommandType="Text" OnSelected="sdsB_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />                                    
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="GovernmentAuthorityID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upC" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvC" runat="server" DataKeyNames="NationalGovID" SkinID="gvList" DataSourceID="sdsC">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditC" Text="Edit" CommandArgument='<%# Eval("NationalGovID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("NationalGovID") %>' Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyC" Text="Copy" CommandArgument='<%# Eval("NationalGovID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaC.aspx" + GetQueryString(true, null, null) + "&ngid="+Eval("NationalGovID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Description" HeaderText="Description">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsC" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetNationalGoverned" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_NationalGoverned where NationalGovID=@NationalGovID;delete from Ima_NationalGover_Files where NationalGovID=@NationalGovID;delete from Ima_Technology where DID=@NationalGovID and Categroy='C'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="NationalGovID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                            
                                    <asp:UpdatePanel ID="upD" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvD" runat="server" DataKeyNames="CertificationBodiesID" SkinID="gvList"
                                                DataSourceID="sdsD">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditD" Text="Edit" CommandArgument='<%# Eval("CertificationBodiesID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyD" Text="Copy" CommandArgument='<%# Eval("CertificationBodiesID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailD.aspx" + GetQueryString(true, null, null) + "&cbwid="+Eval("CertificationBodiesID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Name" HeaderText="Name">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Also Authority">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAuthority" runat="server" Text='<%# Convert.ToBoolean(Eval("Authority")) ? "Yes" : "No" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="AccreditedTest" HeaderText="Also Accredited Test Lab">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Certification Body">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCertificationBody" runat="server" Text='<%# Convert.ToBoolean(Eval("CertificationBody")) ? "Yes" : "No" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="VolumePerYear" HeaderText="Volume Per Year">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Publish">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPublish" runat="server" Text='<%# Convert.ToBoolean(Eval("Publish")) ? "Yes" : "No" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsD" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetCertificationBodies" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_CertificationBodies where CertificationBodiesID=@CertificationBodiesID;delete from Ima_Contact where DID=@CertificationBodiesID and Categroy='D';delete from Ima_Technology where DID=@CertificationBodiesID and Categroy='D'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32"
                                                        DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="CertificationBodiesID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upQ" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvQ" runat="server" DataKeyNames="AccreditedTestID" SkinID="gvList" DataSourceID="sdsQ">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditQ" Text="Edit" CommandArgument='<%# Eval("AccreditedTestID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyQ" Text="Copy" CommandArgument='<%# Eval("AccreditedTestID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailQ.aspx" + GetQueryString(true, null, null) + "&atid="+Eval("AccreditedTestID").ToString() %>'>Detail</asp:HyperLink>
                                                            <%--<asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailQ.aspx?" + Request.QueryString.ToString() + "&atid="+Eval("AccreditedTestID").ToString() %>'>Detail</asp:HyperLink>--%>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="AccreditedLab" HeaderText="Accredited Lab">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="VolumePerYear" HeaderText="Volume Per Year">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Publish">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPublish" runat="server" Text='<%# Convert.ToBoolean(Eval("Publish")) ? "Yes" : "No" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsQ" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetAccreditedTestLab" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_AccreditedTestLab where AccreditedTestID=@AccreditedTestID;delete from Ima_Contact where DID=@AccreditedTestID and Categroy='Q';delete from Ima_Technology where DID=@AccreditedTestID and Categroy='Q'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="AccreditedTestID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upG" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvG" runat="server" DataKeyNames="ProductControlID" SkinID="gvList" DataSourceID="sdsG">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditG" Text="Edit" CommandArgument='<%# Eval("ProductControlID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyG" Text="Copy" CommandArgument='<%# Eval("ProductControlID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailG.aspx" + GetQueryString(true, null, null) + "&fid="+Eval("ProductControlID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ControlList" HeaderText="ControlList">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsG" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetProductsControl" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_ProductsControl where ProductControlID=@ProductControlID;delete from Ima_ProductsControl_Files where ProductControlID=@ProductControlID;delete from Ima_Technology where DID=@ProductControlID and Categroy='G'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="ProductControlID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upF" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvF" runat="server" DataKeyNames="LocalAgentID" SkinID="gvList" DataSourceID="sdsF">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditF" Text="Edit" CommandArgument='<%# Eval("LocalAgentID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyF" Text="Copy" CommandArgument='<%# Eval("LocalAgentID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailF.aspx" + GetQueryString(true, null, null) + "&laid="+Eval("LocalAgentID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Name" HeaderText="Name">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="RF">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRF" runat="server" Text='<%# Convert.ToBoolean(Eval("RF")) ? "Y" : "N" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="EMC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblEMC" runat="server" Text='<%# Convert.ToBoolean(Eval("EMC")) ? "Y" : "N" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Safety">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSafety" runat="server" Text='<%# Convert.ToBoolean(Eval("Safety")) ? "Y" : "N" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" /> 
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Telecom">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTelecom" runat="server" Text='<%# Convert.ToBoolean(Eval("Telecom")) ? "Y" : "N" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetLocalAgent" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_LocalAgent where LocalAgentID=@LocalAgentID;delete from Ima_Contact where DID=@LocalAgentID and Categroy='F';delete from Ima_Technology where DID=@LocalAgentID and Categroy='F';delete from Ima_Files where DocID=@LocalAgentID and DocCategory='F'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="LocalAgentID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upN" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvN" runat="server" DataKeyNames="PeriodicID" SkinID="gvList" DataSourceID="sdsN">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditN" Text="Edit" CommandArgument='<%# Eval("PeriodicID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("PeriodicID") %>' Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyN" Text="Copy" CommandArgument='<%# Eval("PeriodicID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailN.aspx" + GetQueryString(true, null, null) + "&pfiid="+Eval("PeriodicID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Factory  Inspection">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFactoryInspection" runat="server" Text="Document review only" Visible='<%#Eval("FactoryInspection").ToString()=="Document" ? true : false %>'></asp:Label>
                                                            <asp:Label ID="lblOneTime" runat="server" Text="One-time on-site Inspection Required" Visible='<%#Eval("FactoryInspection").ToString()=="OneTime" ? true : false %>'></asp:Label>
                                                            <asp:Label ID="lblPeriodic" runat="server" Text="Periodic on-site Inspection Required" Visible='<%#Eval("FactoryInspection").ToString()=="Periodic" ? true : false %>'></asp:Label>
                                                            <asp:Label ID="lblNotRequired" runat="server" Text="Not Required" Visible='<%#Eval("FactoryInspection").ToString()=="NotRequired" ? true : false %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsN" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetPeriodic" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Periodic where PeriodicID=@PeriodicID;delete from Ima_Periodic_Files where PeriodicID=@PeriodicID;delete from Ima_Technology where DID=@PeriodicID and Categroy='N'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32"
                                                        DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PeriodicID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upO" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvO" runat="server" DataKeyNames="CertificateID" SkinID="gvList" DataSourceID="sdsO">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditO" Text="Edit" CommandArgument='<%# Eval("CertificateID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyO" Text="Copy" CommandArgument='<%# Eval("CertificateID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Method of Certificate Delivery">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbEmail" runat="server" Text="Email to WoWi" Checked='<%# Eval("Email") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbCopy" runat="server" Text="Hard copy to WoWi" Checked='<%# Eval("Copy") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbCollect" runat="server" Text="Hard copy to be Collected" Checked='<%# Eval("Collect") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbLocal" runat="server" Text="Hard copy to Local Applicant" Checked='<%# Eval("Local") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbProof" runat="server" Text="Proof shown on website" Checked='<%# Eval("Proof") %>' Enabled="false" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsO" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetCertificate" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Certificate where CertificateID=@CertificateID"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32"
                                                        DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="CertificateID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upP" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvP" runat="server" DataKeyNames="PostID" SkinID="gvList" DataSourceID="sdsP">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditP" Text="Edit" CommandArgument='<%# Eval("PostID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("PostID") %>' Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyP" Text="Copy" CommandArgument='<%# Eval("PostID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailP.aspx" + GetQueryString(true, null, null) + "&pcid="+Eval("PostID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Label Requirement">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRequirement" runat="server" Text='<%# Eval("Requirement") %>'></asp:Label>；
                                                            <asp:CheckBox ID="cbPrint" runat="server" Checked='<%# Convert.ToBoolean(Eval("Print")) %>' Enabled="false" Text="Labels can be self-printed" />
                                                            <asp:CheckBox ID="cbPurchase" runat="server" Checked='<%# Convert.ToBoolean(Eval("Purchase")) %>' Enabled="false" Text="Labels need to be purchase from authority" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsP" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetPost" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Post where PostID=@PostID;delete from Ima_Post_Files where PostID=@PostID;delete from Ima_Technology where DID=@PostID and Categroy='P'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="PostID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upE" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvE" runat="server" DataKeyNames="EnforcementID" SkinID="gvList" DataSourceID="sdsE">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditE" Text="Edit" CommandArgument='<%# Eval("EnforcementID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyE" Text="Copy" CommandArgument='<%# Eval("EnforcementID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Types of enforcement applied">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbCustom" runat="server" Text="Custom/Importation Enforcement" Checked='<%# Eval("Custom") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbMarket" runat="server" Text="Market Surveillance" Checked='<%# Eval("Market") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbFactory" runat="server" Text="Factory Inspection" Checked='<%# Eval("Factory") %>' Enabled="false" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Remark" HeaderText="Remark">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsE" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetEnforcement" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Enforcement where EnforcementID=@EnforcementID"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="EnforcementID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upL" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvL" runat="server" DataKeyNames="FeeScheduleID" SkinID="gvList" DataSourceID="sdsL">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditL" Text="Edit" CommandArgument='<%# Eval("FeeScheduleID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <%--<asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyL" Text="Copy" CommandArgument='<%# Eval("FeeScheduleID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>--%>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailL.aspx" + GetQueryString(true, null, null) + "&fsid="+Eval("FeeScheduleID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="110px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="110px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="country_name" HeaderText="Country">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="CBName" HeaderText="Certification Body">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AbbreviatedAuthorityName" HeaderText="Authority Name">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AccreditedLab" HeaderText="Accredited Test Lab">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" HeaderText="Local Agent">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wowi_tech_name" HeaderText="Technology">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Renew" HeaderText="Renew(USD)">
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="TotalCostFee" HeaderText="Sub Total Cost(USD)">
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LeadTime" HeaderText="Lead Time">
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsL" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetFeeSchedule" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_FeeSchedule where FeeScheduleID=@FeeScheduleID;delete from Ima_Files where DocID=@FeeScheduleID and DocCategory='L'"
                                                DeleteCommandType="Text" OnSelected="sdsB_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="FeeScheduleID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upK" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvK" runat="server" DataKeyNames="TestingID" SkinID="gvList" DataSourceID="sdsK">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditK" Text="Edit" CommandArgument='<%# Eval("TestingID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("TestingID") %>' Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyK" Text="Copy" CommandArgument='<%# Eval("TestingID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailK.aspx" + GetQueryString(true, null, null) + "&tid="+Eval("TestingID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Language Acceptance">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRequirement" runat="server" Text='<%# Eval("Language").ToString()=="All" ? "All English" : "Other or Partial" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Test Report/Certification">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbFCCTest" runat="server" Text="FCC Test Report" Checked='<%# Convert.ToBoolean(Eval("FCCTest")) %>'
                                                                Enabled="false" />
                                                            <asp:CheckBox ID="cbFCCCertificate" runat="server" Text="FCC Certificate" Checked='<%# Convert.ToBoolean(Eval("FCCCertificate")) %>'
                                                                Enabled="false" />
                                                            <asp:CheckBox ID="cbCETest" runat="server" Text="CE Test Report" Checked='<%# Convert.ToBoolean(Eval("CETest")) %>'
                                                                Enabled="false" /><br />
                                                            <asp:CheckBox ID="cbNBEO" runat="server" Text="NBEO" Checked='<%# Convert.ToBoolean(Eval("NBEO")) %>'
                                                                Enabled="false" />
                                                            <asp:CheckBox ID="cbEUDoC" runat="server" Checked='<%# Convert.ToBoolean(Eval("EUDoC")) %>'
                                                                Enabled="false" Text="EU DoC" />
                                                            <asp:CheckBox ID="cbConformance" runat="server" Checked='<%# Convert.ToBoolean(Eval("Conformance")) %>'
                                                                Enabled="false" Text="Conformance for GSM,CDMA,and WCDMA" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsK" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetTesting" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Testing where TestingID=@TestingID;delete from Ima_Testing_Files where TestingID=@TestingID;delete from Ima_Technology where DID=@TestingID and Categroy='K'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="TestingID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upH" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvH" runat="server" DataKeyNames="StandardID" SkinID="gvList" DataSourceID="sdsH">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditH" Text="Edit" CommandArgument='<%# Eval("StandardID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("StandardID") %>' Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyH" Text="Copy" CommandArgument='<%# Eval("StandardID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailH.aspx" + GetQueryString(true, null, null) + "&sid="+Eval("StandardID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Harmonized">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbFCC" runat="server" Text="FCC" Checked='<%# Convert.ToBoolean(Eval("FCC")) %>'
                                                                Enabled="false" Visible='<%#Eval("wowi_product_type_name").ToString()=="Safety" ? false : true %>' />
                                                            <asp:CheckBox ID="cbIEC" runat="server" Text="IEC" Checked='<%# Convert.ToBoolean(Eval("FCC")) %>'
                                                                Enabled="false" Visible='<%#Eval("wowi_product_type_name").ToString()=="Safety" ? true : false %>' />
                                                            <asp:CheckBox ID="cbCE" runat="server" Text="CE" Checked='<%# Convert.ToBoolean(Eval("CE")) %>' Enabled="false" />
                                                            <asp:Label ID="lblOthers" runat="server" Text='<%#Eval("Others").ToString()!="" ?  "； Others："+Eval("Others").ToString() : "" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsH" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetStandard" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Standard where StandardID=@StandardID;delete from Ima_Standard_Files where StandardID=@StandardID;delete from Ima_Technology where DID=@StandardID and Categroy='H'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="StandardID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upJ" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvJ" runat="server" DataKeyNames="ApplicationID" SkinID="gvList" DataSourceID="sdsJ">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditJ" Text="Edit" CommandArgument='<%# Eval("ApplicationID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyJ" Text="Copy" CommandArgument='<%# Eval("ApplicationID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailJ.aspx" + GetQueryString(true, null, null) + "&aid="+Eval("ApplicationID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Name of Approval Method ">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbTypeApproval" runat="server" Text="Type Approval" Checked='<%# Eval("TypeApproval") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbRegistration" runat="server" Text="Registration" Checked='<%# Eval("Registration") %>' Enabled="false" />
                                                            <br />
                                                            <asp:CheckBox ID="cbDispensationLitter" runat="server" Text="Dispensation Litter" Checked='<%# Eval("DispensationLitter") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbHomologation" runat="server" Text="Homologation" Checked='<%# Eval("Homologation") %>' Enabled="false" />
                                                            <asp:Label ID="lblOtherApprovalMethod" runat="server" Text='<%#Eval("OtherApprovalMethod").ToString()!="" ?  "<br>Others："+Eval("OtherApprovalMethod").ToString() : "" %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Submission Methods ">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbDirect" runat="server" Text="Direct Submission" Checked='<%# Eval("Direct") %>'
                                                                Enabled="false" />
                                                            <asp:CheckBox ID="cbLocalAgent" runat="server" Text="Local Agent Submission" Checked='<%# Eval("LocalAgent") %>'
                                                                Enabled="false" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsJ" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetApplication" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_Application where ApplicationID=@ApplicationID;delete from Ima_Application_Files where ApplicationID=@ApplicationID;delete from Ima_Technology where DID=@ApplicationID and Categroy='J'"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32"
                                                        DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="ApplicationID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upM" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gvM" runat="server" DataKeyNames="SampleShippingID" SkinID="gvList" DataSourceID="sdsM">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditM" Text="Edit" CommandArgument='<%# Eval("SampleShippingID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyM" Text="Copy" CommandArgument='<%# Eval("SampleShippingID") %>' OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailM.aspx" + GetQueryString(true, null, null) + "&ssid="+Eval("SampleShippingID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Which carrier is preferable">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cbFedex" runat="server" Text="Fedex" Checked='<%# Eval("Fedex") %>'
                                                                Enabled="false" />
                                                            <asp:CheckBox ID="cbDHL" runat="server" Text="DHL" Checked='<%# Eval("DHL") %>' Enabled="false" />
                                                            <asp:CheckBox ID="cbUPS" runat="server" Text="UPS" Checked='<%# Eval("UPS") %>' Enabled="false" />
                                                            Other (specify)：<asp:Label ID="lblOtherCarrier" runat="server" Text='<%# Eval("OtherCarrier") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sdsM" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMAGetSampleShipping" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_SampleShipping where SampleShippingID=@SampleShippingID;delete from Ima_SampleShipping_Files where SampleShippingID=@SampleShippingID"
                                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="SampleShippingID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="up99" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:GridView ID="gv99" runat="server" DataKeyNames="world_region_id,country_id,wowi_product_type_id,GID"
                                                SkinID="gvList" DataSourceID="sds99" OnPreRender="gv_PreRender" PageSize="20">
                                                <Columns>
                                                    <asp:TemplateField ShowHeader="False">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEdit99"
                                                                Text="Edit" CommandArgument='<%# Eval("GID").ToString()+","+Eval("wowi_product_type_name").ToString()+","+Eval("wowi_product_type_id").ToString() %>'
                                                                OnClick="lbtnEdit_Click" Visible='<%#IMAUtil.IsEditOn() %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Delete？')" Visible='<%#IMAUtil.IsDeleteOn() %>'></asp:LinkButton>
                                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetail99"+Eval("wowi_product_type_name").ToString()+".aspx" + GetQueryString(true, null, null) + "&pt="+Eval("wowi_product_type_id").ToString() + "&group="+Eval("GID").ToString() %>'>Detail</asp:HyperLink>
                                                        </ItemTemplate>
                                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="TechName" HeaderText="Technology">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Frequency" HeaderText="Frequency">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Allowed" HeaderText="Allowed/Not Allowed">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="PowerLimit" HeaderText="Power Limit">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Certification Type">
                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="sds99" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                                SelectCommand="STP_IMATechAttributeGetByPK" SelectCommandType="StoredProcedure"
                                                DeleteCommand="delete from Ima_TechAttribute where world_region_id=@world_region_id and country_id=@country_id and wowi_product_type_id=@wowi_product_type_id and GID=@GID"
                                                DeleteCommandType="Text">
                                                <SelectParameters>
                                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32" DefaultValue="0" />
                                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                                <DeleteParameters>
                                                    <asp:Parameter Name="world_region_id" Type="Int32" />
                                                    <asp:Parameter Name="country_id" Type="Int32" />
                                                    <asp:Parameter Name="wowi_product_type_id" Type="Int32" />
                                                    <asp:Parameter Name="GID" Type="Int32" />
                                                </DeleteParameters>
                                            </asp:SqlDataSource>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
