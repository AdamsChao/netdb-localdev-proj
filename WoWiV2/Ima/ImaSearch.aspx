<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true" CodeFile="ImaSearch.aspx.cs" Inherits="Ima_ImaSearch" StylesheetTheme="IMA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:UpdatePanel ID="upSearch" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <%-- Search --%>
            <div style="width: 90%; margin: 5px auto">
                <table border="0" cellpadding="2" cellspacing="0" class="tbSearch" width="90%" align="center">
                    <tr>
                        <td class="tdRowName">KeyWords：</td>
                        <td class="tdRowValue" align="left">
                            <asp:TextBox ID="tbKeyWord" runat="server" Width="400px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvKeyWord" runat="server" ControlToValidate="tbKeyWord"
                                ErrorMessage="Input KeyWords" Display="None" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <act:ValidatorCalloutExtender ID="cveKeyWord" runat="server" TargetControlID="rfvKeyWord">
                            </act:ValidatorCalloutExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Region：</td>
                        <td class="tdRowValue" align="left">
                            <asp:CheckBoxList ID="cbRegion" runat="server" RepeatDirection="Horizontal" DataSourceID="sdsRegion"
                                DataTextField="world_region_name" DataValueField="world_region_id" RepeatColumns="5">
                            </asp:CheckBoxList>
                            <asp:SqlDataSource ID="sdsRegion" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="select world_region_id,world_region_name from world_region where world_region_id in(select world_region_id from vw_ImaAccess where id=@EmpID) order by world_region_name"
                                SelectCommandType="Text">
                                <SelectParameters>
                                    <%--<asp:SessionParameter Name="EmpID" SessionField="Session_User_Id" />--%>
                                    <asp:ControlParameter Name="EmpID" ControlID="lblEmpID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lblRegion" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lblEmpID" runat="server" Visible="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Country：</td>
                        <td class="tdRowValue" align="left">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="tbCountry" runat="server" Width="400px" TextMode="MultiLine" Rows="2"
                                            ReadOnly="True"></asp:TextBox>
                                        <asp:Label ID="lblCountrys" runat="server" Visible="false"></asp:Label>
                                        <asp:Button ID="btnSelect" runat="server" Text="Select" CausesValidation="false"
                                            OnClick="btnSelect_Click" />
                                        <asp:Button ID="btnClear" runat="server" Text="Clear" CausesValidation="false" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnHidden" runat="server" Text="Select" CausesValidation="false"
                                            Style="display: none;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <act:ModalPopupExtender ID="mpeCountry" runat="server" TargetControlID="btnHidden"
                                            PopupControlID="panCountry" PopupDragHandleControlID="panCountry" BackgroundCssClass="mpeBackground"
                                            DropShadow="true" CancelControlID="btnCCancel">
                                        </act:ModalPopupExtender>
                                        <asp:Panel ID="panCountry" runat="server" Style="display: none; width: 600px; height: 300px;">
                                            <table border="0" width="100%" align="center" class="tbModalPopup">
                                                <tr>
                                                    <td class="tdHeader" style="text-align: left;">
                                                        <asp:DropDownList ID="ddlSelRegion" runat="server" DataSourceID="sdsRegion" DataTextField="world_region_name"
                                                            DataValueField="world_region_id" AutoPostBack="True" OnSelectedIndexChanged="ddlSelRegion_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Panel ID="plCountryList" runat="server" ScrollBars="Vertical" Height="300px">
                                                            <asp:GridView ID="gvCountryList" runat="server" SkinID="gvList" AutoGenerateColumns="False"
                                                                DataKeyNames="country_id,country_name" AllowPaging="false" OnRowDataBound="gvCountryList_RowDataBound">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Choose">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="cbChoose" runat="server" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="world_region_name" HeaderText="Region">
                                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="country_name" HeaderText="Country">
                                                                        <HeaderStyle Font-Bold="false" HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdHeader" align="center">
                                                        <asp:Button ID="btnCSelect" runat="server" Text="Select" CausesValidation="false"
                                                            OnClick="btnCSelect_Click" />
                                                        <asp:Button ID="btnCCancel" runat="server" Text="Cancel" CausesValidation="false" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName">Certification Type：</td>
                        <td class="tdRowValue" align="left">
                            <asp:UpdatePanel ID="upProductType" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbProductType" runat="server" RepeatDirection="Horizontal"
                                        DataSourceID="sdsProductType" DataTextField="wowi_product_type_name" DataValueField="wowi_product_type_id">
                                    </asp:CheckBoxList>
                                    <asp:SqlDataSource ID="sdsProductType" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                        SelectCommand="STP_IMAGetProductType" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                    <asp:Label ID="lblPTID" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdRowName" valign="top">Document Categories：</td>
                        <td class="tdRowValue" align="left">
                            <asp:UpdatePanel ID="upCategory" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:CheckBoxList ID="cbCategory" runat="server" RepeatColumns="4" RepeatDirection="Horizontal">
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
                                        <asp:ListItem Value="P">13.Label and Renewal</asp:ListItem>
                                    </asp:CheckBoxList>
                                    <asp:Label ID="lblCategory" runat="server" Visible="false"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="tdFooter" colspan="2">
                            <table cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td>
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table border="0" cellpadding="1" cellspacing="1" align="center" width="90%">
                    <tr>
                        <td class="tdStatSubject" align="center"><asp:Label ID="lblMsg" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvImaSearch" runat="server" SkinID="gvList" OnPageIndexChanging="gvImaSearch_PageIndexChanging" >
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlEdit" runat="server" Target="_blank" NavigateUrl='<%#Eval("EditURL") %>' Visible='<%#IMAUtil.IsEditOn() %>'>Edit</asp:HyperLink>
                                            <asp:HyperLink ID="hlDetail" runat="server" Target="_blank" NavigateUrl='<%# SetDetailUrl(Eval("DetailURL")) %>'>Detail</asp:HyperLink>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="100px" />
                                        <ItemStyle HorizontalAlign="Center" Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Category">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCategoryName" runat="server" Text='<%#Eval("CategoryName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Font-Bold="False" HorizontalAlign="Center" Width="200px" />
                                        <ItemStyle HorizontalAlign="Left" Width="200px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Path">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlDocumentPath" runat="server" Target="_blank" Text='<%#Eval("DocPath") %>'
                                                NavigateUrl='<%# "~/Ima/ImaList.aspx?rid="+Eval("world_region_id").ToString()+"&cid="+Eval("country_id").ToString()+"&pid="+Eval("wowi_product_type_id").ToString()+"&categroy="+Eval("Category").ToString() %>'></asp:HyperLink>
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
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

