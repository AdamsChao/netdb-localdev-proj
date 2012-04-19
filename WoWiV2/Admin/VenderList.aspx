<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        GridView1.AllowSorting = true;
        GridView1.AllowPaging = true;
        SqlDataSource sqlDataSource = SqlDataSource1;
        if (String.IsNullOrEmpty(tbCName.Text.Trim()) && String.IsNullOrEmpty(tbName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource1";   
        }
        else if (String.IsNullOrEmpty(tbCName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource3";
            sqlDataSource = SqlDataSource3;
        }
        else if (String.IsNullOrEmpty(tbName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource4";
            sqlDataSource = SqlDataSource4;
        }
        else
        {
            GridView1.DataSourceID = "SqlDataSource2";
            sqlDataSource = SqlDataSource2;
        }
        String newCriteria = "";
        int eid = Utils.GetEmployeeID(User.Identity.Name);
        if (!Utils.isAdmin(eid))
        {
            newCriteria += " and department_id in (Select accesslevel_id from m_employee_accesslevel where employee_id =" + eid + ")";
            lblaccesslevel.Visible = false;
            ddlAccessLevel.Visible = false;
        }
        else
        {
            lblaccesslevel.Visible = true;
            ddlAccessLevel.Visible = true;
            if (ddlAccessLevel.SelectedValue != "-1")
            {
                newCriteria += " and department_id  = " + ddlAccessLevel.SelectedValue;
            }
        }
        sqlDataSource.SelectCommand += newCriteria;
        GridView1.DataBind();
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {

            String depidStr = row.Cells[8].Text;
            try
            {
                int depid = int.Parse(depidStr);
                if (depid == -1)
                {
                    row.Cells[8].Text = "Not set yet";
                }
                else
                {
                    row.Cells[8].Text = (from p in db.access_level where p.id == depid select p.name).First();
                }
            }
            catch (Exception)
            {

                //throw;
            }

        }
    }

   

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
            <ContentTemplate> 
          Vender List&nbsp;<br>
         Name:
         <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
&nbsp;or 名稱 :
         <asp:TextBox ID="tbCName" runat="server"></asp:TextBox>
                <asp:Label ID="lblaccesslevel" runat="server" Text="Access Level :"></asp:Label>
                &nbsp;<asp:DropDownList ID="ddlAccessLevel" runat="server" 
            AppendDataBoundItems="True" datasourceid="SqlDataSource5" DataTextField="name" 
            DataValueField="id">
            <asp:ListItem Value="-1">- All -</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true'">
        </asp:SqlDataSource>
                &nbsp;<asp:Button ID="btnSearch" runat="server" 
             Text="Search" />
     <br>
   <asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateVender.aspx" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  onprerender="GridView1_PreRender"
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
                            <asp:BoundField DataField="department_id" HeaderText="Department" 
                            SortExpression="department_id" />
                            
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
                    SelectCommand="SELECT [id], [name], [c_name], [tel1], [fax1], [address], [c_address], [department_id] FROM [vendor] Where id > 0">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE id > 0 AND (([name] LIKE '%' + @name + '%') OR  ([c_name] LIKE '%' + @c_name + '%')) ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbName" Name="name" PropertyName="Text" 
                            Type="String" />
                        <asp:ControlParameter ControlID="tbCName" Name="c_name" PropertyName="Text" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE  id > 0 AND ([name] LIKE '%' + @name + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbName" Name="name" PropertyName="Text" 
                            Type="String" />
                       
                    </SelectParameters>
                </asp:SqlDataSource>
                 <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    
             SelectCommand="SELECT * FROM [vendor] WHERE  id > 0 AND ([c_name] LIKE '%' + @c_name + '%') ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="tbCName" Name="c_name" PropertyName="Text" 
                            Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p><br />
    </asp:Content>

