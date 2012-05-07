<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCreateQuotationTab4.ascx.cs"
    Inherits="Sales_uc_ucCreateQuotationTab4" %>
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
    
    .CCSTextBoxRD
    {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-style: normal;
        font-size: 9pt;
        background: #dddddd;
    }
    
    .CCSTextBox
    {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-style: normal;
        font-size: 8pt;
    }
    
    .CCSLongButton
    {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-style: normal;
        font-weight: 800;
        font-size: 7pt;
        width: 200px;
    }
    
    
    .CCSBotton
    {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-style: normal;
        font-weight: 800;
        font-size: 7pt;
        width: 80px;
    }
    .quoEdit tr
    {
        height: 30px;
    }
</style>
<script language="javascript" type="text/javascript">
    $(document).ready(function () {

        Cal();
    });

    function Cal() {
        var dollar0 = $('#<%=rolling_forecast_dollar0.ClientID %>').val();
        var dollar1 = $('#<% =rolling_forecast_dollar1.ClientID %>').val();
        var dollar2 = $('#<% =rolling_forecast_dollar2.ClientID %>').val();
        var dollar3 = $('#<% =rolling_forecast_dollar3.ClientID %>').val();
        var dollar4 = $('#<% =rolling_forecast_dollar4.ClientID %>').val();
        var dollar5 = $('#<% =rolling_forecast_dollar5.ClientID %>').val();
        var dollar6 = $('#<% =rolling_forecast_dollar6.ClientID %>').val();
        var dollar7 = $('#<% =rolling_forecast_dollar7.ClientID %>').val();
        var dollar8 = $('#<% =rolling_forecast_dollar8.ClientID %>').val();
        var dollar9 = $('#<% =rolling_forecast_dollar9.ClientID %>').val();
        var dollar10 = $('#<% =rolling_forecast_dollar10.ClientID %>').val();
        var dollar11 = $('#<% =rolling_forecast_dollar11.ClientID %>').val();
        (dollar0 == "") ? 0 : dollar0;
        (dollar1 == "") ? 0 : dollar1;
        (dollar2 == "") ? 0 : dollar2;
        (dollar3 == "") ? 0 : dollar3;
        (dollar4 == "") ? 0 : dollar4;
        (dollar5 == "") ? 0 : dollar5;
        (dollar6 == "") ? 0 : dollar6;
        (dollar7 == "") ? 0 : dollar7;
        (dollar8 == "") ? 0 : dollar8;
        (dollar9 == "") ? 0 : dollar9;
        (dollar10 == "") ? 0 : dollar10;
        (dollar11 == "") ? 0 : dollar11;

        var txtTargetTotalPrice = '<% =txtTargetTotalPrice.ClientID %>';
        var txtDiscount = '<% =txtDiscount.ClientID %>';
        var txtFinalTotalPrice = '<% =txtFinalTotalPrice.ClientID %>';
        var txtTotal_Disc_Amt = '<% =txtTotal_Disc_Amt.ClientID %>';
        var txtDollar_balance = '<% =dollar_balance.ClientID %>';

        var TargetTotalPrice = $("#" + txtTargetTotalPrice).val();
        var Discount = $("#" + txtDiscount).val();
        var Total_Disc_Amt = $("#" + txtTotal_Disc_Amt).val();
        var FinalTotalPrice = TargetTotalPrice - Discount - Total_Disc_Amt;
        $("#" + txtFinalTotalPrice).val(FinalTotalPrice);


        var Dollar_balance = FinalTotalPrice - dollar0 - dollar1 - dollar2 - dollar3 - dollar4 - dollar5 - dollar6 - dollar7 - dollar8 - dollar9 - dollar10 - dollar11;

        $("#" + txtDollar_balance).val(Dollar_balance);


    }
</script>
<table width="100%">
    <tr>
        <td>
            <table align="center" border="1" class="quoEdit" cellpadding="0" cellspacing="0"
                width="100%" style="background-color: #EFF3FB;">
                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                    <th colspan="8">
                        Quotation Info
                    </th>
                </tr>
                <tr>
                    <td>
                        Open Date:
                    </td>
                    <td>
                        <asp:TextBox ID="txtOpenDate" CssClass="CCSTextBoxRD" runat="server" MaxLength="10"
                            ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        Open By:
                    </td>
                    <td>
                        <asp:TextBox ID="txtOpenBy" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        Revised Date :
                    </td>
                    <td>
                        <asp:TextBox ID="txtRevisedDate" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        Revised By :
                    </td>
                    <td>
                        <asp:TextBox ID="txtRevisedBy" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        Target Total Price :
                    </td>
                    <td>
                        <asp:TextBox ID="txtTargetTotalPrice" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            Text="0" ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        WoWi Discount:
                    </td>
                    <td>
                        <asp:TextBox ID="txtDiscount" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            Text="0" ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        Final Total Price:
                    </td>
                    <td>
                        <asp:TextBox ID="txtFinalTotalPrice" CssClass="CCSTextBoxRD" MaxLength="10" runat="server"
                            Text="0" ReadOnly="true" Width="100px"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <table align="center" border="1" class="quoEdit" cellpadding="0" cellspacing="0"
                width="100%" style="background-color: #EFF3FB;">
                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                    <th colspan="4">
                        Total Discount &amp; Remark
                    </th>
                </tr>
                <tr>
                    <td>
                        Discount Amount:
                    </td>
                    <td>
                        <asp:TextBox ID="txtTotal_Disc_Amt" CssClass="CCSTextBox" MaxLength="5" runat="server"
                            Text="0" onkeyup="Cal();" Width="50px"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTotal_Disc_Amt"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        Remark for Client:
                    </td>
                    <td>
                        <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Width="650px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>
            <table align="center" border="1" class="quoEdit" cellpadding="0" cellspacing="0"
                width="100%" style="background-color: #EFF3FB;">
                <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                    <th colspan="7">
                        Rolling Forecast &amp; MISC
                    </th>
                </tr>
                <tr>
                    <td colspan="7">
                        Probability:
                        <asp:DropDownList ID="ddlProbability" CssClass="CCSTextBox" runat="server">
                            <asp:ListItem Value="">-Select One</asp:ListItem>
                            <asp:ListItem Value="25%">25%</asp:ListItem>
                            <asp:ListItem Value="50%">50%</asp:ListItem>
                            <asp:ListItem Value="75%">75%</asp:ListItem>
                            <asp:ListItem Value="100%">100%</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="lightblue" colspan="7">
                        <font color="black" style="font-weight: bold">Gross Distribution: Select the adjacent
                            checkbox when finished billing for the month. Please make sure balance are zero!</font>
                    </td>
                </tr>
                <tr>
                    <td width="14%">
                        <asp:Label ID="lbl00" runat="server" Text="Jan10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar0" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="rolling_forecast_dollar0"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                    <td width="14%">
                        <asp:Label ID="lbl01" runat="server" Text="Feb10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar1" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="rolling_forecast_dollar1"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                        
                    </td>
                    <td width="14%">
                        <asp:Label ID="lbl02" runat="server" Text="Mar10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar2" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="rolling_forecast_dollar2"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                     <td width="14%">
                        <asp:Label ID="lbl03" runat="server" Text="Apr10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar3" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="rolling_forecast_dollar3"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                        &nbsp;
                    </td>
                     <td width="14%">
                        <asp:Label ID="lbl04" runat="server" Text="May10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar4" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="rolling_forecast_dollar4"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                        &nbsp;
                    </td>
                    <td width="14%">
                        <asp:Label ID="lbl05" runat="server" Text="Jun10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar5" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="rolling_forecast_dollar5"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                        &nbsp;
                    </td>
                    <td rowspan="2">
                        Balance:&nbsp;
                        <asp:TextBox ID="dollar_balance" CssClass="CCSTextBoxRD" MaxLength="7" Width="50"
                            ReadOnly="true" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl06" runat="server" Text="Jul10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar6" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="rolling_forecast_dollar6"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Label ID="lbl07" runat="server" Text="Aug10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar7" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="rolling_forecast_dollar7"
                            ErrorMessage="Only number allowed" ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$"
                            ForeColor="Red" SetFocusOnError="True" Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label ID="lbl08" runat="server" Text="Sep10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar8" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server"
                            ControlToValidate="rolling_forecast_dollar8" ErrorMessage="Only number allowed"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$" ForeColor="Red" SetFocusOnError="True"
                            Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label ID="lbl09" runat="server" Text="Oct10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar9" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server"
                            ControlToValidate="rolling_forecast_dollar9" ErrorMessage="Only number allowed"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$" ForeColor="Red" SetFocusOnError="True"
                            Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label ID="lbl10" runat="server" Text="Nov10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar10" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server"
                            ControlToValidate="rolling_forecast_dollar10" ErrorMessage="Only number allowed"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$" ForeColor="Red" SetFocusOnError="True"
                            Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Label ID="lbl11" runat="server" Text="Dec10"></asp:Label>&nbsp;<asp:TextBox
                            ID="rolling_forecast_dollar11" CssClass="CCSTextBox" MaxLength="7" onkeyup="Cal();"
                            Width="50" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server"
                            ControlToValidate="rolling_forecast_dollar11" ErrorMessage="Only number allowed"
                            ValidationExpression="^([-+]?[0-9]*\.?[0-9]+)$" ForeColor="Red" SetFocusOnError="True"
                            Display="Dynamic"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="7">
                        PO No.:
                        <asp:TextBox ID="txtPocheckno" CssClass="CCSTextBox" MaxLength="20" Width="100" runat="server"></asp:TextBox>  &nbsp;  PO 
                        Limit.:
                        <asp:TextBox ID="txtPOLimit" CssClass="CCSTextBox" MaxLength="20" Width="100" runat="server"></asp:TextBox> &nbsp; Deposit Check No:
                        <asp:TextBox ID="txtDeposit_Check_No" CssClass="CCSTextBox" MaxLength="20" Width="100" runat="server"></asp:TextBox> &nbsp;  Amount .:
                        <asp:TextBox ID="txtPO_Amount" CssClass="CCSTextBox" MaxLength="20" Width="100" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
        </td>
    </tr>
    <tr>
        <td align="middle">
            <asp:Button ID="btnSubmitType2" runat="server" Text="Save" OnClick="btnSubmitType2_Click"
                OnClientClick="btn();" />
        </td>
    </tr>
</table>
<p>
    <asp:TextBox ID="hidQuotationID" runat="server" Text="0" Visible="false"></asp:TextBox>
</p>
