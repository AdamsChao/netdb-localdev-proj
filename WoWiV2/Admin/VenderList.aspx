<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        String newCriteria = "";
        if (ddlDeptList.SelectedValue != "-1" && ddlEmpList.SelectedValue != "-1")
        {
            newCriteria = " and department_id = " + ddlDeptList.SelectedValue + " and employee_id = " + ddlEmpList.SelectedValue;
        }
        else if (ddlDeptList.SelectedValue != "-1" )
        {
            newCriteria = " and department_id = " + ddlDeptList.SelectedValue;
        }
        else if (ddlEmpList.SelectedValue != "-1")
        {
            newCriteria = " and employee_id = " + ddlEmpList.SelectedValue;
        }
        if (String.IsNullOrEmpty(tbCName.Text.Trim()) && String.IsNullOrEmpty(tbName.Text.Trim()))
        {
            GridView1.DataSourceID = "SqlDataSource1";
            SqlDataSource1.SelectCommand += newCriteria;
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
                    row.Cells[8].Text = db.departments.First(c => c.id == depid).name;
                }
            }
            catch (Exception)
            {

                //throw;
            }

        }
    }

    protected void ddlDeptList_SelectedIndexChanged(object sender, EventArgs ea)
    {
        DropDownList ddl = sender as DropDownList;
        int depid = int.Parse(ddl.SelectedValue);
        try
        {
            var list = from e in db.employees where e.department_id == depid select new { id = e.id, name = String.IsNullOrEmpty(e.fname) ? e.c_lname + " " + e.c_fname : e.fname + " " + e.lname };
            cleanEmployeeList();
            if (list.Count() == 0) return;
            ddlEmpList.DataSource = list;
            ddlEmpList.DataTextField = "name";
            ddlEmpList.DataValueField = "id";
            ddlEmpList.DataBind();

        }
        catch (Exception)
        {


        }
        
        

    }

    private void cleanEmployeeList()
    {
        try
        {
            ddlEmpList.Items.Clear();
            ListItem item = new ListItem("- All -", "-1");
            ddlEmpList.Items.Add(item);
            ddlEmpList.AppendDataBoundItems = true;
            
        }
        catch (Exception)
        {

            //throw;
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
                &nbsp;Department : &nbsp;<asp:DropDownList ID="ddlDeptList" runat="server" 
                    AppendDataBoundItems="True" AutoPostBack="True" 
                    DataSourceID="SqlDataSource5" DataTextField="name" DataValueField="id" 
                    onselectedindexchanged="ddlDeptList_SelectedIndexChanged">
                    <asp:ListItem Value="-1">- All -</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                    SelectCommand="SELECT [id], [name] FROM [department]"></asp:SqlDataSource>
                &nbsp;Employee :
                <asp:DropDownList ID="ddlEmpList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="-1">- All -</asp:ListItem>
                </asp:DropDownList>
                &nbsp;<asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
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

