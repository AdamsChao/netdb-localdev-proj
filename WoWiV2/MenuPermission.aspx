<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
  SecurityModel.SecurityEntities sm = new SecurityModel.SecurityEntities();
  
  protected void Page_Load(object sender, EventArgs e)
  {
    
  }
  protected void ButtonSet_Click(object sender, EventArgs e)
  {
    if (ListBoxUsers.SelectedIndex == -1)
    {
      Message.Text = "請先挑選人員，才能繼續設定!";
      return;
    }

    foreach (ListItem item in ListBoxUsers.Items)
    {
      if (item.Selected)
      {
        var deleteMenu = from menu in sm.Access_Menu
                         where menu.Username == item.Text
                         select menu;
        foreach (SecurityModel.Access_Menu menu in deleteMenu)
        {
          sm.Access_Menu.DeleteObject(menu);
        }

        foreach (TreeNode node in TreeViewMenu.CheckedNodes)
        {
          SecurityModel.Access_Menu am = new SecurityModel.Access_Menu();
          am.Username = item.Text;
          am.MenuText = node.Text;
          am.MenuValuePath = node.ValuePath;
          sm.Access_Menu.AddObject(am);
        }
        sm.SaveChanges();      
      }
    }
  }

  protected void ListBoxUsers_SelectedIndexChanged(object sender, EventArgs e)
  {
    TreeViewMenu.DataBind();
    var results = from am in sm.Access_Menu
                  where am.Username == ListBoxUsers.SelectedItem.Text
                  select am;
    foreach (SecurityModel.Access_Menu item in results)
    {
      TreeNode node = TreeViewMenu.FindNode(item.MenuValuePath);
      if (node != null)
      {
        node.Checked = true;
      }
    }
  }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  <style type="text/css">
    .style1
    {
      width: 100%;
    }
    .style2
    {
      width: 300px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <table class="style1">
    <tr valign="top">
      <td class="style2">
        <asp:ListBox ID="ListBoxUsers" runat="server" DataSourceID="SqlDataSourceEmp" 
    DataTextField="username" DataValueField="id" Rows="20" SelectionMode="Multiple" 
          Width="300px" onselectedindexchanged="ListBoxUsers_SelectedIndexChanged" 
          AutoPostBack="True"></asp:ListBox>
        <br />
  <asp:Button ID="ButtonSet" runat="server" onclick="ButtonSet_Click" 
    Text="請挑選人員後設定選單權限" />
        <br />
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
      </td>
      <td>
  <asp:TreeView ID="TreeViewMenu" runat="server" DataSourceID="SiteMapDataSource1" 
    ShowCheckBoxes="All" ShowLines="True">
  </asp:TreeView>
      </td>
    </tr>
    <tr>
      <td class="style2">
        &nbsp;</td>
      <td>
        &nbsp;</td>
    </tr>
  </table>
  <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
  <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
    SelectCommand="SELECT [id], [username] FROM [employee]"></asp:SqlDataSource>
</asp:Content>

