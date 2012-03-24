<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void Button2_Click(object sender, EventArgs e)
    {
        String name = tbName.Text;
        String comapnyName = tbCompanyName.Text;
        GridView1.AllowSorting = true;
        GridView1.AllowPaging = true;
        if (!String.IsNullOrEmpty(name) && !String.IsNullOrEmpty(comapnyName))
        {
            //GridView1.DataSourceID = null;
            //GridView1.DataSource = from c in db.contact_info where c.c_fname.Contains(name) || c.c_lname.Contains(name) || c.lname.Contains(name) || c.fname.Contains(name) || c.c_companyname.Contains(comapnyName) || c.companyname.Contains(comapnyName) select c;
            GridView1.DataSourceID = "SqlDataSource2";
           
        }
        else if (!String.IsNullOrEmpty(name))
        {
            //GridView1.DataSourceID = null;
            //GridView1.DataSource = from c in db.contact_info where c.c_fname.Contains(name) || c.c_lname.Contains(name) || c.lname.Contains(name) || c.fname.Contains(name)  select c;
            GridView1.DataSourceID = "SqlDataSource3";
        }
        else if (!String.IsNullOrEmpty(comapnyName))
        {
            //GridView1.DataSourceID = null;
            //GridView1.DataSource = from c in db.contact_info where c.c_companyname.Contains(comapnyName) || c.companyname.Contains(comapnyName) select c;
            GridView1.DataSourceID = "SqlDataSource4";
        }
        else
        {
            GridView1.DataSourceID = "SqlDataSource1";
        }
        GridView1.DataBind();

        
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
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Search" />
        <br />
        &nbsp;<%--<asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Common/CreateContact.aspx">Create</asp:HyperLink>--%><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Common/CreateContact.aspx" />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView"  Width="100%"
        AutoGenerateColumns="False" DataKeyNames="id" AllowSorting="True"
        DataSourceID="SqlDataSource1" PageSize="50" >
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
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        
        SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname] FROM [contact_info]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname] FROM [contact_info] WHERE ( (([c_companyname] LIKE '%' + @c_companyname + '%') OR ([companyname] LIKE '%' + @companyname + '%')) AND (([c_fname] LIKE '%' + @c_fname + '%') OR ([c_lname] LIKE '%' + @c_lname + '%') OR ([fname] LIKE '%' + @fname + '%') OR ([lname] LIKE '%' + @lname + '%')))">
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
        
        
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname] FROM [contact_info] WHERE ( ([c_fname] LIKE '%' + @c_fname + '%') OR ([c_lname] LIKE '%' + @c_lname + '%') OR ([fname] LIKE '%' + @fname + '%') OR ([lname] LIKE '%' + @lname + '%'))">
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
        
        
            SelectCommand="SELECT [id], [fname], [lname], [title], [companyname], [c_companyname], [workphone], [ext], [cellphone], [email], [c_fname], [c_lname] FROM [contact_info] WHERE (([c_companyname] LIKE '%' + @c_companyname + '%') OR ([companyname] LIKE '%' + @companyname + '%') )">
        <SelectParameters>
            <asp:ControlParameter ControlID="tbCompanyName" Name="c_companyname" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="tbCompanyName" Name="companyname" 
                PropertyName="Text" Type="String" />
            
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>

