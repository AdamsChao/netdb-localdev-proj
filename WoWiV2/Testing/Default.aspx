<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        for (int i = 0; i < 10000; i++)
        {
            TreeNode tn = new TreeNode("xxx");
            TreeView1.Nodes.Add(tn);
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:TreeView ID="TreeView1" runat="server">
    </asp:TreeView>
</asp:Content>

