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
                alert("Please select copy to?");
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
                                            <asp:ListItem Value="0">Please Select Category</asp:ListItem>
                                            <asp:ListItem Value="B">Government Authority</asp:ListItem>
                                            <asp:ListItem Value="C">National governed rules and regulation</asp:ListItem>
                                            <asp:ListItem Value="D">Certification bodies and websites</asp:ListItem>
                                            <asp:ListItem Value="G">Products Control</asp:ListItem>
                                            <%--<asp:ListItem Value="H">Standards</asp:ListItem>--%>
                                            <asp:ListItem Value="F">Local Agent</asp:ListItem>
                                            <%--<asp:ListItem Value="J">Application Procedures</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="K">Testing and submission preparation</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="M">Sample shipping</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="N">Periodic Factory inspection</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="O">Certificate</asp:ListItem>--%>
                                            <%--<asp:ListItem Value="P">Post certification</asp:ListItem>--%>
                                            <asp:ListItem Value="E">Enforcement–Market Inspection</asp:ListItem>
                                            <asp:ListItem Value="L">Fee schedule</asp:ListItem>
                                        </asp:DropDownList>
                                        <%--<asp:RequiredFieldValidator ID="rfvDocCategory" runat="server" ControlToValidate="ddlDocCategory"
                                            ErrorMessage="Please Select Category" Display="None" SetFocusOnError="true" InitialValue="0"></asp:RequiredFieldValidator>
                                        <act:ValidatorCalloutExtender ID="cveDocCategory" runat="server" TargetControlID="rfvDocCategory">
                                        </act:ValidatorCalloutExtender>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Copy to：</td>
                                    <td>
                                        <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                            DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                        </asp:CheckBoxList>
                                        <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                            SelectCommand="select wowi_product_type_id,wowi_product_type_name from wowi_product_type where publish='Y'">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="right"><asp:Button ID="btnAddDocument" runat="server" Text="Create Product Documents" OnClick="btnAddDocument_Click"
                                            OnClientClick="return IsSelect();" /></td>
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
                            <asp:GridView ID="gvImaGover" runat="server" DataKeyNames="GovernmentAuthorityID" SkinID="gvList" DataSourceID="sdsB">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <%--<asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEdit"
                                                Text="Edit" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' PostBackUrl='<%#"ImaGovernmentAuth.aspx?" + Request.QueryString.ToString() + "&gaid="+Eval("GovernmentAuthorityID").ToString() %>'></asp:LinkButton>--%>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditB"
                                                Text="Edit" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyB"
                                                Text="Copy" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaB.aspx?" + Request.QueryString.ToString() + "&gaid="+Eval("GovernmentAuthorityID").ToString() %>'>Detail</asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Full Authority Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFullAuthorityName" runat="server" Text='<%#Eval("FullAuthorityName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Website" HeaderText="Website" >
                                    <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CertificateValid" HeaderText="Valid" >
                                    <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsB" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetGovernmentAuthority" SelectCommandType="StoredProcedure"
                                DeleteCommand="delete from Ima_GovernmentAuthority where GovernmentAuthorityID=@GovernmentAuthorityID;delete from Ima_GoverAuth_Files where GovernmentAuthorityID=@GovernmentAuthorityID"
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
                            <%--<asp:SqlDataSource ID="sdsImaGover" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                DeleteCommand="DELETE FROM [Ima_General_Files] WHERE [GeneralFileID] = @GeneralFileID"
                                InsertCommand="INSERT INTO [Ima_General_Files] ([GeneralID], [GeneralFileURL], [GeneralFileName], [GeneralFileType], [CreateUser], [CreateDate], [LasterUpdateUser], [LasterUpdateDate]) VALUES (@GeneralID, @GeneralFileURL, @GeneralFileName, @GeneralFileType, @CreateUser, @CreateDate, @LasterUpdateUser, @LasterUpdateDate)"
                                SelectCommand="SELECT * FROM [Ima_GovernmentAuthority] WHERE ([world_region_id] = @world_region_id and country_id=@country_id)"
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
                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
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
                            </asp:SqlDataSource>--%>
                            <asp:GridView ID="gvC" runat="server" DataKeyNames="NationalGovID" SkinID="gvList" DataSourceID="sdsC">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditC"
                                                Text="Edit" CommandArgument='<%# Eval("NationalGovID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')" CommandArgument='<%# Eval("NationalGovID") %>'></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyC"
                                                Text="Copy" CommandArgument='<%# Eval("NationalGovID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaC.aspx?" + Request.QueryString.ToString() + "&ngid="+Eval("NationalGovID").ToString() %>'>Detail</asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
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
                                DeleteCommand="delete from Ima_NationalGoverned where NationalGovID=@NationalGovID;delete from Ima_NationalGover_Files where NationalGovID=@NationalGovID"
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
                            <asp:GridView ID="gvD" runat="server" DataKeyNames="CertificationBodiesID" SkinID="gvList"
                                DataSourceID="sdsD">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditD"
                                                Text="Edit" CommandArgument='<%# Eval("CertificationBodiesID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyD"
                                                Text="Copy" CommandArgument='<%# Eval("CertificationBodiesID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <%--<asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailG.aspx?" + Request.QueryString.ToString() + "&fid="+Eval("ProductControlID").ToString() %>'>Detail</asp:HyperLink>--%>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Name" HeaderText="Name">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Authority" HeaderText="Authority">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CertificationBody" HeaderText="Certification Body">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VolumePerYear" HeaderText="Volume Per Year">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Publish" HeaderText="Publish">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AccredidedLab" HeaderText="Accredided Lab">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VolumePerYear1" HeaderText="Volume Per Year">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Publish1" HeaderText="Publish">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Website" HeaderText="Website">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsD" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetCertificationBodies" SelectCommandType="StoredProcedure"
                                DeleteCommand="delete from Ima_CertificationBodies where CertificationBodiesID=@CertificationBodiesID"
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
                            <asp:GridView ID="gvG" runat="server" DataKeyNames="ProductControlID" SkinID="gvList" DataSourceID="sdsG">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditG"
                                                Text="Edit" CommandArgument='<%# Eval("ProductControlID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyG"
                                                Text="Copy" CommandArgument='<%# Eval("ProductControlID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailG.aspx?" + Request.QueryString.ToString() + "&fid="+Eval("ProductControlID").ToString() %>'>Detail</asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ControlList" HeaderText="ControlList">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsG" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetProductsControl" SelectCommandType="StoredProcedure"
                                DeleteCommand="delete from Ima_ProductsControl where ProductControlID=@ProductControlID;delete from Ima_ProductsControl_Files where ProductControlID=@ProductControlID"
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
                            <asp:GridView ID="gvF" runat="server" DataKeyNames="LocalAgentID" SkinID="gvList" DataSourceID="sdsF">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditF"
                                                Text="Edit" CommandArgument='<%# Eval("LocalAgentID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyF"
                                                Text="Copy" CommandArgument='<%# Eval("LocalAgentID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <%--<asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailG.aspx?" + Request.QueryString.ToString() + "&fid="+Eval("ProductControlID").ToString() %>'>Detail</asp:HyperLink>--%>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Name" HeaderText="Name">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RF" HeaderText="RF">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="EMC" HeaderText="EMC">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Safety" HeaderText="Safety">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Telecom" HeaderText="Telecom">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Credit" HeaderText="Credit">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Communication" HeaderText="Communication">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Volume" HeaderText="Volume">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsF" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetLocalAgent" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_LocalAgent where LocalAgentID=@LocalAgentID"
                                DeleteCommandType="Text" OnSelected="sdsC_Selected">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="LocalAgentID" Type="Int32" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvE" runat="server" DataKeyNames="EnforcementID" SkinID="gvList"
                                DataSourceID="sdsE">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditE"
                                                Text="Edit" CommandArgument='<%# Eval("EnforcementID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyE"
                                                Text="Copy" CommandArgument='<%# Eval("EnforcementID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Types of enforcement applied">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbCustom" runat="server" Text="Custom/Importation Enforcement" Checked='<%# Eval("Custom") %>' />
                                            <asp:CheckBox ID="cbMarket" runat="server" Text="Market Surveillance" Checked='<%# Eval("Market") %>' />
                                            <asp:CheckBox ID="cbFactory" runat="server" Text="Factory Inspection" Checked='<%# Eval("Factory") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
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
                            <asp:GridView ID="gvL" runat="server" DataKeyNames="FeeScheduleID" SkinID="gvList"
                                DataSourceID="sdsL">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <%--<asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEdit"
                                                Text="Edit" CommandArgument='<%# Eval("GovernmentAuthorityID") %>' PostBackUrl='<%#"ImaGovernmentAuth.aspx?" + Request.QueryString.ToString() + "&gaid="+Eval("GovernmentAuthorityID").ToString() %>'></asp:LinkButton>--%>
                                            <asp:LinkButton ID="lbtnEdit" runat="server" CausesValidation="False" CommandName="GoEditL"
                                                Text="Edit" CommandArgument='<%# Eval("FeeScheduleID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnCopy" runat="server" CausesValidation="False" CommandName="GoCopyL"
                                                Text="Copy" CommandArgument='<%# Eval("FeeScheduleID") %>' OnClick="lbtnEdit_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDel" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="Delete" OnClientClick="return confirm('Delete？')"></asp:LinkButton>
                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%#"ImaDetailL.aspx?" + Request.QueryString.ToString() + "&fsid="+Eval("FeeScheduleID").ToString() %>'>Detail</asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="140px" />
                                        <ItemStyle HorizontalAlign="Center" Width="140px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Agent handling Fee(USD)">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAgentHandling" runat="server" Text='<%#Eval("AgentHandling") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="AuthoritySubmission" HeaderText="Authority submission fee(USD)">
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="wowi_product_type_name" HeaderText="Product Type">
                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsL" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="STP_IMAGetFeeSchedule" SelectCommandType="StoredProcedure" DeleteCommand="delete from Ima_FeeSchedule where FeeScheduleID=@FeeScheduleID;delete from Ima_FeeSchedule_Files where FeeScheduleID=@FeeScheduleID"
                                DeleteCommandType="Text" OnSelected="sdsB_Selected">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="world_region_id" QueryStringField="rid" Type="Int32" />
                                    <asp:QueryStringParameter Name="country_id" QueryStringField="cid" Type="Int32" />
                                    <asp:QueryStringParameter Name="wowi_product_type_id" QueryStringField="pid" Type="Int32"
                                        DefaultValue="0" />
                                    <asp:ControlParameter ControlID="ddlDocCategory" Name="DocCategory" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="FeeScheduleID" Type="Int32" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
