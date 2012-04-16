<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateChooser2.ascx.cs" Inherits="UserControls_DateChooser2" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:TextBox ID="TextBox1" runat="server" ValidationGroup="VenderGroup"></asp:TextBox>
<asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="yyyy/MM/dd"
    Enabled="True" TargetControlID="TextBox1">
</asp:CalendarExtender>

<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
    ControlToValidate="TextBox1" ErrorMessage="Please choose target payment day." 
    ValidationGroup="VenderGroup" Font-Bold="True" ForeColor="Red">*</asp:RequiredFieldValidator>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
    ShowMessageBox="True" ShowSummary="False" ValidationGroup="VenderGroup" />


