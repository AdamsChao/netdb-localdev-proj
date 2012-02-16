<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(tbCName.Text.Trim()) && String.IsNullOrEmpty(tbName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource1";
            GridView1.DataBind();
        }
        else if (String.IsNullOrEmpty(tbCName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource3";
            GridView1.DataBind();
        }
        else if (String.IsNullOrEmpty(tbName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource4";
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSourceID = "SqlDataSource2";
            GridView1.DataBind();
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate> 
               <p>
         Name:
         <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
&nbsp;or 名稱 :
         <asp:TextBox ID="tbCName" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
             Text="Search" />
     <p>
    Vender List&nbsp;<asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateVender.aspx" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    SkinID="GridView" Width="100%" PageSize="50" 
                    DataKeyNames="id" DataSourceID="SqlDataSource1" AllowPaging="True" 
                    AllowSorting="True">
                    <Columns>
                        <asp:TemplateField InsertVisible="False" SortExpression="id" Visible="true">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Bind("id","~/Admin/UpdateVender.aspx?id={0}") %>' >Edit</asp:HyperLink>
                                &nbsp;<asp:HyperLink ID="HyperLink3" NavigateUrl='<%# Bind("id","~/Admin/VenderDetails.aspx?id={0}") %>' runat="server">Details</asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="id" HeaderText="Vender#" SortExpression="id" />
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="c_name" HeaderText="名稱" SortExpression="c_name" />
                        <asp:BoundField DataField="tel1" HeaderText="Tel" SortExpression="tel1" />
                        <asp:BoundField DataField="fax1" HeaderText="Fax" SortExpression="fax1" />
                        <asp:BoundField DataField="address" HeaderText="Address" 
                            SortExpression="address" />
                             <asp:BoundField DataField="c_address" HeaderText="地址" 
                            SortExpression="c_address" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
                    SelectCommand="SELECT [id], [name], [c_name], [tel1], [fax1], [address], [c_address] FROM [vendor] Where id > 0">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE ([name] LIKE '%' + @name + '%') OR  ([c_name] LIKE '%' + @c_name + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbName" Name="name" PropertyName="Text" 
                            Type="String" />
                        <asp:ControlParameter ControlID="tbCName" Name="c_name" PropertyName="Text" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE ([name] LIKE '%' + @name + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbName" Name="name" PropertyName="Text" 
                            Type="String" />
                       
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE  ([c_name] LIKE '%' + @c_name + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbCName" Name="c_name" PropertyName="Text" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p><br />
    </asp:Content>

