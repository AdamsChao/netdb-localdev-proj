<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" MaintainScrollPositionOnPostback="true" %>

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
          Message.Text = "Target Rate Update Successful!";
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Target Rate Lists :
        <asp:LinkButton ID="LinkButton1" runat="server" 
          PostBackUrl="~/Target/CreateTargetRateManagement.aspx">Create</asp:LinkButton>
        <br />
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        <br />
        <asp:GridView ID="GridViewRate" runat="server" 
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Target_rate_id" 
            DataSourceID="SqlDataSourceRate" onrowupdated="GridViewRate_RowUpdated" 
            PageSize="20" Width="100%">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="Target_rate_id" HeaderText="ID" 
                    InsertVisible="False" ReadOnly="True" SortExpression="Target_rate_id" 
                    Visible="False" />
                <asp:TemplateField HeaderText="Country" SortExpression="country_name">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox1" Visible="false" runat="server" Text='<%# Bind("country_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Authority" SortExpression="authority_name">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox3"  Visible="false" runat="server" Text='<%# Bind("authority_name") %>'></asp:TextBox>
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
                <asp:TemplateField HeaderText="Technology" SortExpression="Technology_id">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                     <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                        <asp:TextBox ID="TextBox4" Visible="false" runat="server" Text='<%# Bind("Technology_id") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Target_Description" HeaderText="Target Description" 
                  ReadOnly="True" />
                <asp:BoundField DataField="local_agent_name" HeaderText="Local Agent Name" />               
                <asp:TemplateField HeaderText="Rate (USD)">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Target Cost">
                  <EditItemTemplate>
                    <asp:DropDownList ID="DropDownListCurrency" runat="server" 
                        SelectedValue='<%# Bind("target_cost_currency") %>'>
                        <asp:ListItem>USD</asp:ListItem>
                        <asp:ListItem>EUR</asp:ListItem>
                        <asp:ListItem>NTD</asp:ListItem>
                        <asp:ListItem>GNF</asp:ListItem>
                        <asp:ListItem>MAD</asp:ListItem>
                        <asp:ListItem>NIO</asp:ListItem>
                        <asp:ListItem>OMR</asp:ListItem>
                        <asp:ListItem>ZAR</asp:ListItem>
                        <asp:ListItem>THB</asp:ListItem>
                        <asp:ListItem>CFA</asp:ListItem>
                        <asp:ListItem>AED</asp:ListItem>
                        <asp:ListItem>XCD</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="TextBoxCost" Width="70" runat="server" Text='<%# Bind("target_cost") %>'></asp:TextBox>
                  </EditItemTemplate>
                  <ItemTemplate>
                  <asp:Label ID="LabelCostCurrency" runat="server" 
                        Text='<%# Bind("target_cost_currency") %>'></asp:Label>
                    <asp:Label ID="LabelCost" runat="server" Text='<%# Bind("target_cost") %>'></asp:Label>                    
                  </ItemTemplate>
                </asp:TemplateField>
                  <asp:CheckBoxField DataField="publish" HeaderText="Publish" 
              SortExpression="publish" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Target_Rates] WHERE [Target_rate_id] = @Target_rate_id" 
            InsertCommand="INSERT INTO [Target_Rates] ([country_id], [product_type_id], [authority_name], [Technology_id], [rate]) VALUES (@country_id, @product_type_id, @authority_name, @Technology_id, @rate)" 
            SelectCommand="SELECT Target_Rates.Target_rate_id, Target_Rates.country_id, Target_Rates.product_type_id, Target_Rates.authority_name, Target_Rates.Technology_id, Target_Rates.rate, country.country_name, wowi_product_type.wowi_product_type_name, wowi_tech.wowi_tech_name, Target_Rates.target_cost_currency, Target_Rates.target_cost, Target_Rates.local_agent_name, Target_Rates.Publish, Authority.Target_Description 
FROM Target_Rates INNER JOIN country ON Target_Rates.country_id = country.country_id 
LEFT JOIN wowi_product_type ON Target_Rates.product_type_id = wowi_product_type.wowi_product_type_id 
LEFT JOIN wowi_tech ON Target_Rates.Technology_id = wowi_tech.wowi_tech_id 
LEFT JOIN Authority ON Target_Rates.authority_id = Authority.authority_id 
order by  country.country_name" 
            
            
          
          
          
          UpdateCommand="UPDATE [Target_Rates] SET [rate] = @rate,[target_cost_currency]=@target_cost_currency,[target_cost]=@target_cost,[local_agent_name]=@local_agent_name,[Publish]=@Publish WHERE [Target_rate_id] = @Target_rate_id">
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
                <asp:Parameter Name="rate" Type="Decimal" />
                <asp:Parameter Name="target_cost_currency" />
                <asp:Parameter Name="target_cost" />
                <asp:Parameter Name="local_agent_name" />
                <asp:Parameter Name="Publish" />
                <asp:Parameter Name="Target_rate_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

