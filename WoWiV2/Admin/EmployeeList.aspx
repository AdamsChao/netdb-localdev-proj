<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                int id = int.Parse(e.Row.Cells[9].Text);
                if (id == -1)
                {
                    e.Row.Cells[9].Text = "None";
                }
                else
                {
                    var data = db.employees.Where(c => c.id == id).First();
                    e.Row.Cells[9].Text = data.fname + " " + data.lname;
                }
            }
            catch (Exception)
            {

            }
            
            
        }

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
    Employee List&nbsp;
    <%--<asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateEmployee.aspx">Create</asp:HyperLink>--%><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateEmployee.aspx" />
 <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" SkinID="GridView" Width="100%"
        AutoGenerateColumns="False" DataKeyNames="id" 
        DataSourceID="SqlDataSource1" 
        AllowSorting="True" onrowdatabound="GridView1_RowDataBound" >
        <Columns>
            <asp:TemplateField InsertVisible="False" SortExpression="id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Bind("id","~/Admin/UpdateEmployee.aspx?id={0}") %>'>Edit</asp:HyperLink>
                    &nbsp;<asp:HyperLink ID="HyperLink3" NavigateUrl='<%# Bind("id","~/Admin/EmployeeDetails.aspx?id={0}") %>' runat="server">Details</asp:HyperLink>&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" OnClientClick="return confirm('Delete Employee？');">Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="username" HeaderText="Username" 
                SortExpression="username" Visible="False" />
            <asp:BoundField DataField="fname" HeaderText="FirstName" SortExpression="fname" />
            <asp:BoundField DataField="lname" HeaderText="LastName" SortExpression="lname" />
            <asp:BoundField DataField="c_lname" HeaderText="姓" SortExpression="c_lname" />
            <asp:BoundField DataField="c_fname" HeaderText="名" SortExpression="c_fname" />
            <asp:BoundField DataField="work_ext" HeaderText="Ext" 
                SortExpression="work_ext" />
            <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
            <asp:BoundField DataField="cellphone" HeaderText="Cellphone" 
                SortExpression="cellphone" />
            <asp:BoundField DataField="supervisor_id" HeaderText="Report To" SortExpression="supervisor_id" />
            <%--<asp:TemplateField HeaderText="Report To" SortExpression="supervisor_id">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='< %# Bind("supervisor_id") % >'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='< %# Bind("supervisor_id") % >'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:BoundField DataField="status" HeaderText="Status" 
                SortExpression="status" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [employee] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [employee] ([username], [fname], [lname], [work_ext], [email], [cellphone], [supervisor_id], [status]) VALUES (@username, @fname, @lname, @work_ext, @email, @cellphone, @supervisorid, @status)" 
        SelectCommand="SELECT [id], [username], [fname], [lname], [c_fname], [c_lname],[work_ext], [email], [cellphone], [supervisor_id], [status] FROM [employee]" 
        
        UpdateCommand="UPDATE [employee] SET [username] = @username, [fname] = @fname, [lname] = @lname, [work_ext] = @work_ext, [email] = @email, [cellphone] = @cellphone, [supervisor_id] = @supervisorid, [status] = @status WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="fname" Type="String" />
            <asp:Parameter Name="lname" Type="String" />
            <asp:Parameter Name="work_ext" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="cellphone" Type="String" />
            <asp:Parameter Name="supervisorid" Type="Int32" />
            <asp:Parameter Name="status" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="fname" Type="String" />
            <asp:Parameter Name="lname" Type="String" />
            <asp:Parameter Name="work_ext" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="cellphone" Type="String" />
            <asp:Parameter Name="supervisorid" Type="Int32" />
            <asp:Parameter Name="status" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
     </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>

