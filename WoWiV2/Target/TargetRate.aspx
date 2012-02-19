<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void GridViewRate_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception != null)
        {
            Message.Text = e.Exception.Message + " , Please try again!";
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;
        }
        else
        {
            Message.Text = "TargetRate Update Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        TargetRate Lists :
        <asp:Button ID="Button1" runat="server" 
            PostBackUrl="~/Target/CreateTargetRate.aspx" Text="Create TargetRate" />
        <br />
        <asp:GridView ID="GridViewRate" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Target_rate_id" 
            DataSourceID="SqlDataSourceRate" onrowupdated="GridViewRate_RowUpdated" 
            PageSize="20" Width="100%">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="Target_rate_id" HeaderText="Target_rate_id" 
                    InsertVisible="False" ReadOnly="True" SortExpression="Target_rate_id" 
                    Visible="False" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox1" Visible="false" runat="server" Text='<%# Bind("country_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Certification Type" 
                    SortExpression="product_type_id">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                     <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("wowi_product_type_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox2"  Visible="false" runat="server" Text='<%# Bind("product_type_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Authority Name" SortExpression="authority_name">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox3"  Visible="false" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Technology" SortExpression="Technology_id">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                     <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox4" Visible="false" runat="server" Text='<%# Bind("Technology_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rate (USD)" SortExpression="rate">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Target_Rates] WHERE [Target_rate_id] = @Target_rate_id" 
            InsertCommand="INSERT INTO [Target_Rates] ([country_id], [product_type_id], [authority_name], [Technology_id], [rate]) VALUES (@country_id, @product_type_id, @authority_name, @Technology_id, @rate)" 
            SelectCommand="SELECT Target_Rates.Target_rate_id, Target_Rates.country_id, Target_Rates.product_type_id, Target_Rates.authority_name, Target_Rates.Technology_id, Target_Rates.rate, country.country_name, wowi_product_type.wowi_product_type_name, wowi_tech.wowi_tech_name FROM Target_Rates INNER JOIN country ON Target_Rates.country_id = country.country_id INNER JOIN wowi_product_type ON Target_Rates.product_type_id = wowi_product_type.wowi_product_type_id INNER JOIN wowi_tech ON Target_Rates.Technology_id = wowi_tech.wowi_tech_id" 
            
            UpdateCommand="UPDATE [Target_Rates] SET [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_name] = @authority_name, [Technology_id] = @Technology_id, [rate] = @rate WHERE [Target_rate_id] = @Target_rate_id">
            <DeleteParameters>
                <asp:Parameter Name="Target_rate_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="product_type_id" Type="Int32" />
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="Technology_id" Type="Int32" />
                <asp:Parameter Name="rate" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="country_id" Type="Int32" />
                <asp:Parameter Name="product_type_id" Type="Int32" />
                <asp:Parameter Name="authority_name" Type="String" />
                <asp:Parameter Name="Technology_id" Type="Int32" />
                <asp:Parameter Name="rate" Type="Decimal" />
                <asp:Parameter Name="Target_rate_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

