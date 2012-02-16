<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCreateQuotationTab2.ascx.cs"
    Inherits="Sales_uc_ucCreateQuotationTab2" %>
<style type="text/css">
    .error
    {
        color: Red;
    }
    .quoEdit tr
    {
        height: 30px;
    }
    TD
    {
        font-style: normal;
        font-size: 12px;
    }
    TH
    {
        font-size: 12px;
        font-weight: bold;
    }
    A:link
    {
        color: #222;
        text-decoration: underline;
    }
    .CCSBotton
    {
        font-style: normal;
        width: 80px;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;
        font-weight: 800;
    }
    .CCSTextBox
    {
        font-style: normal;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 8pt;
    }
    .CCSTextBoxRD
    {
        font-style: normal;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        background: #dddddd;
        font-size: 9pt;
    }
</style>
<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        //        $("#ctl01").validate({
        //            onkeyup: false,
        //            highlight: function () {
        //                $("#<%=txtFprice.ClientID %>").val('0');
        //            },
        //            submitHandler: function () {
        //                calcFinalPrice();
        //            }
        //        });

        CalPricing();
    });

    function CalPricing() {
        var txtUnit = '<% =txtUnit.ClientID %>';
        var txtUnitPrice = '<% =txtUnitPrice.ClientID %>';
        var txtDiscAmt = '<% =txtDiscAmt.ClientID %>';
        var txtDiscPrice = '<% =txtDiscPrice.ClientID %>';
        var hidDiscPrice = '<% =hidDiscPrice.ClientID %>';
        var rblDisCount = '<% =rblDisCount.ClientID %>';
        var txtFprice = '<% =txtFprice.ClientID %>';
        var hidFprice = '<% =hidFprice.ClientID %>';

        var FinalPrice;
        var DiscPrice;
        var unit = $("#" + txtUnit).val();
        var price = $("#" + txtUnitPrice).val();
        var discamt = $("#" + txtDiscAmt).val();
        var disRBL = $('#<%=rblDisCount.ClientID %> input[type=radio]:checked').val();
        var disTestdisc = $("#<%=ddlTestdisc.ClientID %> option:selected").val();
        if (disRBL == "0") {
            disTestdisc = disTestdisc * 0.01
            FinalPrice = price * unit * (1 - disTestdisc);
            DiscPrice = price * unit * disTestdisc;
        } else {
            FinalPrice = price * unit - discamt;
            DiscPrice = discamt;
        }
        $("#" + txtFprice).val(FinalPrice);
        $("#" + hidFprice).val(FinalPrice);
        $("#" + txtDiscPrice).val(DiscPrice);
        $("#" + hidDiscPrice).val(DiscPrice);

    }

    function CalPricing_Old() {
        objectUnit = document.getElementById("testunit");
        objectUnitPrice = document.getElementById("testprice");
        objectDisc = document.getElementById("testdisc");
        objectDiscAmt = document.getElementById("testdiscamt");
        objectFinalPrice = document.getElementById("testfinalprice");
        objectTestHour = document.getElementById("testhour");
        objectBonusTargetHour = document.getElementById("bonustargethour");
        objectHourRate = document.getElementById("hourrate");
        objectSubcost = document.getElementById("subcost");
        objectSubcontract = document.getElementById("subcontract")

        tempVal = objectUnit.value * objectUnitPrice.value;
        objectDiscAmt.value = tempVal * objectDisc.value / 100.0;
        objectFinalPrice.value = tempVal - objectDiscAmt.value;
        if (objectSubcontract.checked) {
            //    alert('Subcost'.objectHourRate.value);
            objectBonusTargetHour.value = Math.round((objectFinalPrice.value - objectSubcost.value) / objectHourRate.value * 100) / 100;
        }
        else {
            //    alert('NoSubcost'.objectHourRate.value);
            objectBonusTargetHour.value = Math.round((objectFinalPrice.value - 0) / objectHourRate.value * 100) / 100;
        }
    }


</script>
<table width="100%">
    <tr>
        <td>
            <asp:GridView ID="gvData" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" OnRowCommand="gvData_RowCommand" >
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="tEdit"
                                Text="Edit" CommandArgument='<%# Eval("Quotation_Target_Id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                   <%-- <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" CausesValidation="false" CommandName="tDelete"
                                CommandArgument='<%# Eval("Quotation_Target_Id") %>' Text="Delete" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="T.No">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="target_description" HeaderText="T.Description" SortExpression="target_description" />
                    <asp:BoundField DataField="FinalPrice" HeaderText="F.Price" SortExpression="FinalPrice" />
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F5F7FB" />
                <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                <SortedDescendingCellStyle BackColor="#E9EBEF" />
                <SortedDescendingHeaderStyle BackColor="#4870BE" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT [Quotation_Target_Id], [quotation_id], [target_description], [FinalPrice] FROM [Quotation_Target] WHERE ([quotation_id] = @quotation_id)"
                ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [Quotation_Target] WHERE [Quotation_Target_Id] = @original_Quotation_Target_Id AND (([quotation_id] = @original_quotation_id) OR ([quotation_id] IS NULL AND @original_quotation_id IS NULL)) AND (([target_description] = @original_target_description) OR ([target_description] IS NULL AND @original_target_description IS NULL)) AND (([FinalPrice] = @original_FinalPrice) OR ([FinalPrice] IS NULL AND @original_FinalPrice IS NULL))"
                InsertCommand="INSERT INTO [Quotation_Target] ([quotation_id], [target_description], [FinalPrice]) VALUES (@quotation_id, @target_description, @FinalPrice)"
                OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [Quotation_Target] SET [quotation_id] = @quotation_id, [target_description] = @target_description, [FinalPrice] = @FinalPrice WHERE [Quotation_Target_Id] = @original_Quotation_Target_Id AND (([quotation_id] = @original_quotation_id) OR ([quotation_id] IS NULL AND @original_quotation_id IS NULL)) AND (([target_description] = @original_target_description) OR ([target_description] IS NULL AND @original_target_description IS NULL)) AND (([FinalPrice] = @original_FinalPrice) OR ([FinalPrice] IS NULL AND @original_FinalPrice IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_Quotation_Target_Id" Type="Int32" />
                    <asp:Parameter Name="original_quotation_id" Type="Int32" />
                    <asp:Parameter Name="original_target_description" Type="String" />
                    <asp:Parameter Name="original_FinalPrice" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="quotation_id" Type="Int32" />
                    <asp:Parameter Name="target_description" Type="String" />
                    <asp:Parameter Name="FinalPrice" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidQuotationID" Name="quotation_id" PropertyName="Text"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="quotation_id" Type="Int32" />
                    <asp:Parameter Name="target_description" Type="String" />
                    <asp:Parameter Name="FinalPrice" Type="Decimal" />
                    <asp:Parameter Name="original_Quotation_Target_Id" Type="Int32" />
                    <asp:Parameter Name="original_quotation_id" Type="Int32" />
                    <asp:Parameter Name="original_target_description" Type="String" />
                    <asp:Parameter Name="original_FinalPrice" Type="Decimal" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            <br />
        </td>
    </tr>
    <tr>
        <td>
            <table align="center" border="1" class="quoEdit" cellpadding="0" cellspacing="0"
                width="100%" style="background-color: #EFF3FB;">
                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                    <th colspan="2">
                        Test Target Detail
                    </th>
                </tr>
                <tr>
                    <td width="50%">
                        Country:<asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                            Width="70%">
                        </asp:DropDownList>
                    </td>
                    <td width="50%">
                        Certification Type:
                        <asp:DropDownList ID="ddlProductType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Authority Name:<asp:DropDownList ID="ddlAuthority" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlAuthority_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td>
                        Technology:<asp:DropDownList ID="ddlTechnology" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlTechnology_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        Test Target:<asp:DropDownList ID="ddlTarget" runat="server">
                            <asp:ListItem>Select Test Target</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        Target Rate
                        <asp:TextBox ID="txtRate" runat="server" CssClass="CCSTextBoxRD" ReadOnly="true"
                            Width="100"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Description:
                        <asp:TextBox ID="txtDespction" runat="server" Width="300"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td width="50%">
                        Unit:
                        <asp:TextBox ID="txtUnit" CssClass="number" Text="0" runat="server" CausesValidation="True"
                            onkeyup="CalPricing();"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtUnit"
                            ErrorMessage="Only number allowed in Unit." ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </td>
                    <td width="50%">
                        Unit Price :
                        <asp:TextBox ID="txtUnitPrice" Text="0" runat="server" CausesValidation="True" onkeyup="CalPricing();"
                            CssClass="CCSTextBoxRD" ReadOnly="true"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtUnitPrice"
                            ErrorMessage="Only number allowed in Unit Price" ForeColor="Red" SetFocusOnError="True"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rblDisCount" runat="server" RepeatDirection="Horizontal"
                            RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rblDisCount_SelectedIndexChanged"
                            onclick="CalPricing();">
                            <asp:ListItem Value="0" Selected="True">DisCount %</asp:ListItem>
                            <asp:ListItem Value="1">Discount Amt.</asp:ListItem>
                        </asp:RadioButtonList>
                        &nbsp;
                        <asp:DropDownList ID="ddlTestdisc" runat="server" CssClass="CCSTextBox" onchange="CalPricing();"
                            Width="80px">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtDiscAmt" CssClass="number" Text="0" runat="server" Width="80"
                            onkeyup="CalPricing();" Visible="false" CausesValidation="True"></asp:TextBox>
                        &nbsp;
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDiscAmt"
                            ErrorMessage="Only number allowed in Discount Amt." ForeColor="Red" SetFocusOnError="True"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        Show Discount:
                        <asp:TextBox ID="txtDiscPrice" ReadOnly="true" CssClass="CCSTextBoxRD" Text="0" runat="server"
                            Width="100"></asp:TextBox><input id="hidDiscPrice" type="hidden" runat="server" value="0" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Final Price:
                        <asp:TextBox ID="txtFprice" CssClass="CCSTextBoxRD" ReadOnly="true" Text="0" runat="server"
                            Width="100"></asp:TextBox>
                        &nbsp;
                        <input id="hidFprice" runat="server" type="hidden" value="0" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtPayTo" CssClass="CCSTextBox" runat="server" Visible="false"></asp:TextBox>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div style="text-align:center;">
 <asp:Button ID="btnSubmit" runat="server" CssClass="CCSBotton" OnClick="btnSubmit_Click"
                Text="Save" OnClientClick="btn();" />
</div>
<asp:TextBox ID="hidQuotationID" runat="server" Visible="false"></asp:TextBox>
<asp:TextBox ID="hidTargetID" runat="server" Text="0" Visible="false"></asp:TextBox>
