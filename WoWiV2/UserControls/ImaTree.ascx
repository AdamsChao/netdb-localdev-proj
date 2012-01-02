<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ImaTree.ascx.cs" Inherits="UserControls_ImaTree" %>
<asp:TreeView ID="tvCatalog" runat="server" ExpandDepth="0" ImageSet="Simple" NodeWrap="True"
    ShowLines="True">
    <ParentNodeStyle Font-Bold="False" />
    <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
    <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
        VerticalPadding="0px" />
    <NodeStyle Font-Names="Tahoma" Font-Size="10pt" ForeColor="Black" HorizontalPadding="0px"
        NodeSpacing="0px" VerticalPadding="0px" />
</asp:TreeView>
