<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {

        int eid = Utils.GetEmployeeID(User.Identity.Name);
        String newCriteria = " and department_id in (Select accesslevel_id from m_employee_accesslevel where employee_id = " + eid + " )";
        if (!Utils.isAdmin(eid))
        {
            SqlDataSourceClient.SelectCommand += newCriteria;
            GridView1.DataBind();
            SearchPanel.Visible = false;
        }
        else
        {
            SearchPanel.Visible = true;
            if (ddlAccessLevel.SelectedValue != "-1")
            {
              newCriteria = " and department_id in (Select accesslevel_id from m_employee_accesslevel where accesslevel_id = " + ddlAccessLevel.SelectedValue + " )";
                SqlDataSourceClient.SelectCommand += newCriteria;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataBind();
            }
        }

    }
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {

            String Str = row.Cells[5].Text;
            try
            {
                if (Str == "-1")
                {
                    row.Cells[5].Text = "Not set yet";
                }
                else
                {
                    int aid = int.Parse(Str);
                    row.Cells[5].Text = (from p in wowidb.access_level where p.id == aid select p.name).First();
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
    Client Lists<br>
    <asp:Panel ID="SearchPanel" runat="server">
        <asp:Label ID="lblaccesslevel" runat="server" Text="Access Level :"></asp:Label>
    &nbsp;<asp:DropDownList ID="ddlAccessLevel" runat="server" 
            AppendDataBoundItems="True" DataSourceID="SqlDataSource1" DataTextField="name" 
            DataValueField="id">
            <asp:ListItem Value="-1">- All -</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true'  order by [name]"></asp:SqlDataSource>
        <asp:Button ID="Search" runat="server"  Text="Search" />
    </asp:Panel><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateClient.aspx" />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            SkinID="GridView" Width="100%"
            DataKeyNames="id" DataSourceID="SqlDataSourceClient" AllowPaging="True" PageSize="50" 
            AllowSorting="True" onprerender="GridView1_PreRender">
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="id">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("id","~/Admin/UpdateClient.aspx?id={0}") %>'>Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("id","~/Admin/ClientDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:BoundField DataField="code" HeaderText="公司代碼" SortExpression="code" />--%>
                <asp:BoundField DataField="companyname" HeaderText="Company Name" 
                    SortExpression="companyname" />
                <asp:BoundField DataField="c_companyname" HeaderText="公司名稱" 
                    SortExpression="c_companyname" />
                <asp:BoundField DataField="main_tel" HeaderText="Tel" 
                    SortExpression="main_tel" />
                <asp:BoundField DataField="main_fax" HeaderText="Fax" 
                    SortExpression="main_fax" />
                <asp:BoundField DataField="department_Id" HeaderText="Access Level" 
                    SortExpression="department_Id" />
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
        <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [clientapplicant] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [clientapplicant] ([code], [companyname], [c_companyname], [main_tel], [main_fax], [clientapplicant_type]) VALUES (@code, @companyname, @c_companyname, @main_tel, @main_fax, @type)" 
            SelectCommand="SELECT [id], [code], [companyname], [c_companyname], [main_tel], [main_fax], [clientapplicant_type], [department_id] FROM [clientapplicant] WHERE (([clientapplicant_type] = @type) or ([clientapplicant_type] = @type2))" 
            UpdateCommand="UPDATE [clientapplicant] SET [code] = @code, [companyname] = @companyname, [c_companyname] = @c_companyname, [main_tel] = @main_tel, [main_fax] = @main_fax, [clientapplicant_type] = @type WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="code" Type="String" />
                <asp:Parameter Name="companyname" Type="String" />
                <asp:Parameter Name="c_companyname" Type="String" />
                <asp:Parameter Name="main_tel" Type="String" />
                <asp:Parameter Name="main_fax" Type="String" />
                <asp:Parameter Name="type" Type="Byte" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="type" Type="Byte" />
                <asp:Parameter DefaultValue="3" Name="type2" Type="Byte" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="code" Type="String" />
                <asp:Parameter Name="companyname" Type="String" />
                <asp:Parameter Name="c_companyname" Type="String" />
                <asp:Parameter Name="main_tel" Type="String" />
                <asp:Parameter Name="main_fax" Type="String" />
                <asp:Parameter Name="type" Type="Byte" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

