<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        String name = tbName.Text;
        String comapnyName = tbCompanyName.Text;
        GridView1.AllowSorting = true;
        GridView1.AllowPaging = true;
        SqlDataSource sqlDataSource = SqlDataSource1;
        if (!String.IsNullOrEmpty(name) && !String.IsNullOrEmpty(comapnyName))
        {
            GridView1.DataSourceID = "SqlDataSource2";
            sqlDataSource = SqlDataSource2;
        }
        else if (!String.IsNullOrEmpty(name))
        {
            GridView1.DataSourceID = "SqlDataSource3";
            sqlDataSource = SqlDataSource3;
        }
        else if (!String.IsNullOrEmpty(comapnyName))
        {
            GridView1.DataSourceID = "SqlDataSource4";
            sqlDataSource = SqlDataSource4;
        }
        else
        {
            GridView1.DataSourceID = "SqlDataSource1";
            sqlDataSource = SqlDataSource1;
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

            String depidStr = row.Cells[10].Text;
            try
            {
                int depid = int.Parse(depidStr);
                if (depid == -1)
                {
                    row.Cells[10].Text = "Not set yet";
                }
                else
                {
                    row.Cells[10].Text = (from p in db.access_level where p.id == depid select p.name).First();
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
  
        Contact List&nbsp;

        <br />
        Name :
        <asp:TextBox ID="tbName" runat="server"></asp:TextBox>
&nbsp;CompanyName :
        <asp:TextBox ID="tbCompanyName" runat="server"></asp:TextBox>
        &nbsp;<asp:Label ID="lblaccesslevel" runat="server" Text="Access Level :"></asp:Label>
        &nbsp;<asp:DropDownList ID="ddlAccessLevel" runat="server" 
            AppendDataBoundItems="True" datasourceid="SqlDataSource5" DataTextField="name" 
            DataValueField="id">
            <asp:ListItem Value="-1">- All -</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true'">
        </asp:SqlDataSource>
        &nbsp;<asp:Button ID="Button2" runat="server"  Text="Search" />
        <br />
        &nbsp;<%--<asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Common/CreateContact.aspx">Create</asp:HyperLink>--%><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Common/CreateContact.aspx" />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"  Width="100%"
        AutoGenerateColumns="False" DataKeyNames="id" AllowSorting="True"
        DataSourceID="SqlDataSource1" PageSize="50" onprerender="GridView1_PreRender" >
        <Columns>
            <asp:TemplateField InsertVisible="False" SortExpression="id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" 
                        NavigateUrl='<%# Bind("id","~/Common/UpdateContact.aspx?id={0}") %>'>Edit</asp:HyperLink>

                        &nbsp;

                        <asp:HyperLink ID="HyperLink3" runat="server" 
                        NavigateUrl='<%# Bind("id","~/Common/ContactDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" SortExpression="fname">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("fname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("fname") %>'></asp:Label>&nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Eval("lname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="姓名" SortExpression="lname">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("c_lname") %>'></asp:Label><asp:Label ID="Label4" runat="server" Text='<%# Eval("c_fname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="title" SortExpression="title" HeaderText="Title" />
            <asp:BoundField DataField="companyname" HeaderText="Company Name" 
                SortExpression="companyname" />
            <asp:BoundField DataField="c_companyname" HeaderText="公司名稱" 
                SortExpression="c_companyname" />
            <asp:BoundField DataField="email" HeaderText="Email" 
                SortExpression="email" />
            <asp:BoundField DataField="workphone" HeaderText="Work Phone" 
                SortExpression="workphone" />
            <asp:BoundField DataField="ext" HeaderText="Ext" 
                SortExpression="ext" />
            <asp:BoundField DataField="cellphone" HeaderText="Cellphone" 
                SortExpression="cellphone" />
            <asp:BoundField DataField="department_id" HeaderText="Access Level" 
                SortExpression="department_id" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        
        SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname], [department_id] FROM [contact_info] WHERE 1 = 1">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname], [department_id] FROM [contact_info] WHERE ( (([c_companyname] LIKE '%' + @c_companyname + '%') OR ([companyname] LIKE '%' + @companyname + '%')) AND (([c_fname] LIKE '%' + @c_fname + '%') OR ([c_lname] LIKE '%' + @c_lname + '%') OR ([fname] LIKE '%' + @fname + '%') OR ([lname] LIKE '%' + @lname + '%')))">
        <SelectParameters>
            <asp:ControlParameter ControlID="tbCompanyName" Name="c_companyname" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="tbCompanyName" Name="companyname" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="c_fname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="c_lname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="fname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="lname" PropertyName="Text" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        
        
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname], [department_id] FROM [contact_info] WHERE ( ([c_fname] LIKE '%' + @c_fname + '%') OR ([c_lname] LIKE '%' + @c_lname + '%') OR ([fname] LIKE '%' + @fname + '%') OR ([lname] LIKE '%' + @lname + '%'))">
        <SelectParameters>
           
            <asp:ControlParameter ControlID="tbName" Name="c_fname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="c_lname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="fname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="tbName" Name="lname" PropertyName="Text" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        
        
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname], [department_id] FROM [contact_info] WHERE (([c_companyname] LIKE '%' + @c_companyname + '%') OR ([companyname] LIKE '%' + @companyname + '%') )">
        <SelectParameters>
            <asp:ControlParameter ControlID="tbCompanyName" Name="c_companyname" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="tbCompanyName" Name="companyname" 
                PropertyName="Text" Type="String" />
            
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>

