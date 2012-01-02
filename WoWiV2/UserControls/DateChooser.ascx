<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateChooser.ascx.cs" Inherits="UserControls_DateChooser" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
<asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" Format="yyyy/MM/dd"
    Enabled="True" TargetControlID="TextBox1">
</asp:CalendarExtender>

