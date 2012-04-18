<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Applicant Lists :
    <%--<asp:HyperLink ID="HyperLink1" runat="server" 
        NavigateUrl="~/Admin/CreateApplicant.aspx">Create</asp:HyperLink>--%><asp:Button ID="Button1"
            runat="server" Text="Create" PostBackUrl="~/Admin/CreateApplicant.aspx" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" SkinID="GridView" PageSize="50" 
            DataKeyNames="id" DataSourceID="SqlDataSourceClient" AllowPaging="True"  Width="100%"
            AllowSorting="True">
            <Columns>
                <asp:TemplateField InsertVisible="False" SortExpression="id">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink2" runat="server" 
                            NavigateUrl='<%# Bind("id","~/Admin/UpdateApplicant.aspx?id={0}") %>'>Edit</asp:HyperLink>
                        &nbsp;
                        <asp:HyperLink ID="HyperLink3" runat="server" 
                            NavigateUrl='<%# Bind("id","~/Admin/ApplicantDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
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
            </Columns>
        </asp:GridView>
    </p>
    <p>
        <br />
       <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [clientapplicant] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [clientapplicant] ([code], [companyname], [c_companyname], [main_tel], [main_fax], [clientapplicant_type]) VALUES (@code, @companyname, @c_companyname, @main_tel, @main_fax, @type)" 
            SelectCommand="SELECT [id], [code], [companyname], [c_companyname], [main_tel], [main_fax], [clientapplicant_type] FROM [clientapplicant] WHERE (([clientapplicant_type] = @type) or ([clientapplicant_type] = @type2))" 
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
                <asp:Parameter DefaultValue="2" Name="type" Type="Byte" />
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

