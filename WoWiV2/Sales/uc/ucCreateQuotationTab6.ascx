<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCreateQuotationTab6.ascx.cs"
    Inherits="Sales_uc_ucCreateQuotationTab6" %>
<style type="text/css">
    TD
    {
        font-size: 12px;
        font-style: normal;
    }
    
    TH
    {
        font-size: 12px;
        font-weight: bold;
    }
    
    .CCSTextBox
    {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-style: normal;
        font-size: 8pt;
    }
    .CCSTextBoxRD
    {
        font-style: normal;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        background: #dddddd;
        font-size: 9pt;
    }
    B
    {
        font-weight: bold;
    }
    
    A:link
    {
        text-decoration: underline;
        color: #222;
    }
    .style1
    {
        width: 100%;
    }
    .style2
    {
        border-style: solid;
        border-width: 1px;
        padding: 1px 4px;
    }
</style>
<script language="javascript" type="text/javascript">
    function cmdRBL(ddlAdv, txtAdv2, txtB1, txtB2, hidA1, hidA2, hidB1, hidB2, fPrice, show) {
        //alert(fPrice);
        if (show == 1) {
            $("#" + txtAdv2).val('');
            $("#" + ddlAdv).removeAttr("disabled");
            $("#" + txtAdv2).attr("disabled", "disabled");
            $("#" + ddlAdv).removeClass("CCSTextBoxRD");
            $("#" + txtAdv2).addClass("CCSTextBoxRD");
        } else {
            $("#" + ddlAdv).val("");
            $("#" + ddlAdv).attr("disabled", "disabled");
            $("#" + txtAdv2).removeAttr("disabled");
            $("#" + ddlAdv).addClass("CCSTextBoxRD");
            $("#" + txtAdv2).removeClass("CCSTextBoxRD");
        }
        $("#" + hidA1).val("");
        $("#" + hidA2).val("0");
        $("#" + txtAdv2).val('0');
        $("#" + txtB1).val('');
        $("#" + hidB1).val('');
        $("#" + txtB2).val('0');
        $("#" + hidB2).val('0');
        //alert(hidA2);

    }

    function cmdDDL(ddlAdv, txtAdv2, txtB1, txtB2, hidA1, hidA2, hidB1, hidB2, fPrice) {
        var t = $("#" + ddlAdv + " option:selected").val();
        $("#" + hidA1).val(t);
        var first = t * fPrice * 0.01;
        var end = fPrice - (t * fPrice * 0.01)
        $("#" + txtAdv2).val(t * fPrice * 0.01);
        $("#" + hidA2).val(t * fPrice * 0.01);
        $("#" + txtB1).val((100 - t) + '%');
        $("#" + hidB1).val((100 - t) + '%');
        $("#" + txtB2).val(end);
        $("#" + hidB2).val(end);
        //alert(hidA2);
    }
//    function cmdText(ddlAdv, txtAdv2, txtB1, txtB2, hidA1, hidA2, hidB1, hidB2, fPrice) {
//        var t = $("#" + txtAdv2).val();
//        $("#" + hidA1).val("");
//        $("#" + hidA2).val(t);
//        $("#" + txtB1).val('');
//        $("#" + hidB1).val('');
//        $("#" + txtB2).val(fPrice - t);
//        $("#" + hidB2).val(fPrice - t);
//        //alert(hidA2);
    //    }

    function cmdText(txtBill1, txtBill2, txtBill3, txtBillE, hidBill1, hidBill2, hidBill3, hidBillE, fPrice) {
        var b1 = parseFloat( $("#" + txtBill1).val());
        var b2 = parseFloat( $("#" + txtBill2).val());
        var b3 = parseFloat( $("#" + txtBill3).val());
        $("#" + hidBill1).val(b1);
        $("#" + hidBill2).val(b2);
        $("#" + hidBill3).val(b3);
        var t = b1 + b2 + b3;       
        $("#" + txtBillE).val(fPrice - t);
        $("#" + hidBillE).val(fPrice - t);

    }

    function changeHiddenValue(txtBillE, hidBillE) {
        $("#" + hidBillE).val($("#" + txtBillE).val());
    }

</script>
<table class="style1" bordercolor="#0000aa" cellpadding="4" style="border-bottom: solid;
    border-left: solid; background-color: #ffffff; border-collapse: collapse; border-top: solid;
    border-right: solid" valign="top" width="98%">
    <tr>
        <th rowspan="2" valign="center" width="20%" class="style2">
            <font size="+1">Billing Summary</font>
        </th>
        <th align="middle" width="10%" class="style2">
            Service
        </th>
        <th align="middle" width="10%" class="style2">
            Discount
        </th>
        <th align="middle" width="10%" class="style2">
            Sub Total
        </th>
        <th align="middle" width="10%" class="style2">
            Total Billed
        </th>
        <th align="middle" width="10%" class="style2">
            Balance
        </th>
    </tr>
    <tr>
        <td align="middle" class="style2">
            <asp:Label ID="lblService" runat="server" Text="0"></asp:Label>
        </td>
        <td align="middle" class="style2">
            <asp:Label ID="lblDiscount" runat="server" Text="0"></asp:Label>
        </td>
        <td align="middle" class="style2">
            <asp:Label ID="lblSubTotal" runat="server" Text="0"></asp:Label>
        </td>
        <td align="middle" class="style2">
            <asp:Label ID="lblTotalBilled" runat="server" Text="0"></asp:Label>
        </td>
        <td align="middle" class="style2">
            <asp:Label ID="lblBlance" runat="server" Text="0"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="6">
            <asp:GridView ID="gvTestTargetList" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                CellPadding="4" ForeColor="#333333" Width="100%" GridLines="None" Caption='<table border="1" width="100%" cellpadding="0" cellspacing="0" bgcolor="yellow"><tr bgcolor="#bbbbbb"><th colspan="7"><font color="red">Test Target List</font></th></tr></table>'
                CaptionAlign="Top" OnRowDataBound="gvTestTargetList_RowDataBound" Style="text-align: left">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="Vername" HeaderText="Version" SortExpression="Vername" />
                    <asp:BoundField DataField="target_description" HeaderText="T. Description" SortExpression="target_description" />
                    <%--<asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />--%>
                    <asp:BoundField DataField="unit" HeaderText="Unit" SortExpression="unit" />
                    <asp:BoundField DataField="unit_price" HeaderText="Unit Price" SortExpression="unit_price" />
                    <asp:BoundField DataField="FinalPrice" HeaderText="FinalPrice" SortExpression="FinalPrice" />
                    <asp:TemplateField>
                        <FooterTemplate>
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        </FooterTemplate>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFPrice" Visible="false" runat="server" Text='<%# Eval("FinalPrice") %>'></asp:Label>
                                        <asp:Label ID="lblQuotation_Target_Id" Visible="false" runat="server" Text='<%# Eval("Quotation_Target_Id") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        預收1:<asp:TextBox ID="txtBill1" Text='<%# Eval("Bill1") %>' runat="server" Width="50px"></asp:TextBox>元
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtBill1" Display="Dynamic"
                                            ErrorMessage="Only number allowed" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                        Invoice No:<asp:Literal ID="lblInvoiceNo1" runat="server"></asp:Literal>&nbsp;
                                        Date:<asp:Literal ID="lblInvoiceDate1" runat="server"></asp:Literal>
                                        <input id="hidBill1" type="hidden" runat="server"  />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        預收2:<asp:TextBox ID="txtBill2" Text='<%# Eval("Bill2") %>' runat="server" Width="50px"></asp:TextBox>元
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtBill2" Display="Dynamic"
                                            ErrorMessage="Only number allowed" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                        Invoice No:<asp:Literal ID="lblInvoiceNo2" runat="server"></asp:Literal>&nbsp;
                                        Date:<asp:Literal ID="lblInvoiceDate2" runat="server"></asp:Literal>
                                        <input id="hidBill2" type="hidden" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        預收3:<asp:TextBox ID="txtBill3" Text='<%# Eval("Bill3") %>' runat="server" Width="50px"></asp:TextBox>元
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtBill3" Display="Dynamic"
                                            ErrorMessage="Only number allowed" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                        Invoice No:<asp:Literal ID="lblInvoiceNo3" runat="server"></asp:Literal>&nbsp;
                                        Date:<asp:Literal ID="lblInvoiceDate3" runat="server"></asp:Literal>
                                        <input id="hidBill3" type="hidden" runat="server" />
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        尾款:&nbsp;&nbsp;<asp:TextBox ID="txtBillE" Text='<%# Eval("BillE") %>' runat="server" Width="50px" ></asp:TextBox>元
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtBillE" Display="Dynamic"
                                            ErrorMessage="Only number allowed" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"></asp:RegularExpressionValidator>
                                        &nbsp;
                                        Invoice No:<asp:Literal ID="lblInvoiceNoE" runat="server"></asp:Literal>&nbsp;
                                        Date:<asp:Literal ID="lblInvoiceDateE" runat="server"></asp:Literal>
                                        <input id="hidBillE" type="hidden" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Invoice Flag" >
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlPR_Flag" ToolTip='<%# Eval("PR_Flag")  %>' runat="server">
                                <asp:ListItem Text="無" Value="0"></asp:ListItem>
                                <asp:ListItem Text="預收1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="預收2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="預收3" Value="3"></asp:ListItem>
                                <asp:ListItem Text="尾款" Value="E"></asp:ListItem>
                                <asp:ListItem Text="作廢" Value="A"></asp:ListItem>
                            </asp:DropDownList>
                            <%-- <asp:CheckBox ID="chkPR_Flag" runat="server" Checked='<%# CheckPR_Flag(Eval("PR_Flag")) %>' 
                                Enabled="true" />--%>
                        </ItemTemplate>
                    </asp:TemplateField>
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
                
                
                SelectCommand="SELECT Quotation_No, Vername, target_description, unit, unit_price, FinalPrice, Status, Bill, advance1, advance2, balance1, balance2, option1, option2, Quotation_Target_Id, PR_Flag, Bill1, Bill2, Bill3, BillE FROM vw_Test_Target_List WHERE (Quotation_Version_Id = @Quotation_Version_Id) ORDER BY Quotation_Version_Id">
                <SelectParameters>
                    <asp:ControlParameter ControlID="hidQuotationID" Name="Quotation_Version_Id" 
                        PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="6">
            <p style="text-align: center">
                <asp:Button ID="btnSubmit" CssClass="CCSBotton" runat="server" Text="Save" OnClick="btnSubmit_Click" />
            </p>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<asp:TextBox ID="hidQuotationID" runat="server" Text="0" Visible="false"></asp:TextBox>
<asp:TextBox ID="hidQuotation_No" runat="server" Text="0" Visible="false"></asp:TextBox>
