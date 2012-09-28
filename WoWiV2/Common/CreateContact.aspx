<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/CreateContact.ascx" tagname="CreateContact" tagprefix="uc1" %>

<script runat="server">


</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
     <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
       
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
             <uc1:CreateContact ID="CreateContact1" runat="server" />
        </ContentTemplate>
        </asp:UpdatePanel>
<script type="text/javascript" language="javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    var targetElem;
    var found = false;
    function BeginRequestHandler(sender, args) {
        var elem = args.get_postBackElement();
        if (elem.id.indexOf("InsertButton") != -1) {
            elem.disabled = true;
            targetElem = elem;
            found = true;
        }
    }
    function EndRequestHandler(sender, args) {
        if (found) {
            found = false;
            elem.disabled = false;
        }
    }
    
</script>
</asp:Content>

