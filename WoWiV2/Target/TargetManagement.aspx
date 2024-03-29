﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        if (e.Exception!=null)
        {
            Message.Text = e.Exception.Message + " , Please try again!";
            e.ExceptionHandled = true;
            e.KeepInEditMode = true;            
        }
        else
        {
            Message.Text = "Target Update Successful!";
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow )
        {
            Label lbl = (Label)e.Row.FindControl("LabelRate");
            if (lbl!=null)
            {
                if (string.IsNullOrEmpty(lbl.Text))
                {
                    lbl.Text = "N/A";
                }                
            }            
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Target Lists :
        <asp:Button ID="Button1" runat="server" 
            PostBackUrl="~/Target/CreateTargetManagement.aspx" Text="Create Target" />
        <br />
    </p>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataKeyNames="target_id" 
        DataSourceID="SqlDataSourceTarget" onrowupdated="GridView1_RowUpdated" 
        Width="100%" PageSize="20" onrowdatabound="GridView1_RowDataBound">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="target_id" HeaderText="Target Id" 
                InsertVisible="False" ReadOnly="True" />
            <asp:TemplateField HeaderText="Country" SortExpression="country_id">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>                    
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("country_name") %>'></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server"  Visible="false" Text='<%# Bind("country_id") %>'></asp:TextBox>
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
                    <asp:TextBox ID="TextBox2" Visible="false" runat="server" Text='<%# Bind("product_type_id") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Authority" SortExpression="authority_id">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("authority_name") %>'></asp:Label>
                    <asp:TextBox ID="TextBox3" Visible="false" runat="server" Text='<%# Bind("authority_id") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Technology" SortExpression="technology_id">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("wowi_tech_name") %>'></asp:Label>
                    <asp:TextBox ID="TextBox4"  Visible="false" runat="server" Text='<%# Bind("technology_id") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="target_code" HeaderText="Target Code" 
                SortExpression="target_code" Visible="False" />
            <asp:BoundField DataField="target_description" 
                HeaderText="Target Description" />
          
            <asp:TemplateField HeaderText="Target Cost">
                <ItemTemplate>
                     <asp:Label ID="Label7" runat="server" 
                        Text='<%# Bind("target_cost_currency") %>'></asp:Label>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("target_cost") %>'></asp:Label>
                </ItemTemplate>
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
                    <asp:TextBox ID="TextBox5" Width="70" runat="server" Text='<%# Bind("target_cost") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Target Rate">
                <ItemTemplate>
                    <asp:Label ID="LabelRate" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="LabelRate" runat="server" Text='<%# Bind("rate") %>'></asp:Label>
                    <%--<asp:TextBox ID="TextBox6" Width="70" runat="server" Text='<%# Bind("rate") %>' ></asp:TextBox>--%>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [Target] WHERE [target_id] = @target_id" 
        
        InsertCommand="INSERT INTO [Target] ([country_id], [product_type_id], [authority_id], [technology_id], [target_code], [target_description], [target_cost]) VALUES (@country_id, @product_type_id, @authority_id, @technology_id, @target_code, @target_description, @target_cost)" 
        SelectCommand="select [Target].[target_id],[Target].[country_id],[Target].[product_type_id],[Target].[authority_id],
(Select authority_name from Authority where Authority.authority_id = [Target].[authority_id]) as authority_name,
[Target].[technology_id],[target_code],[target_description],[target_cost],[target_cost_currency],
country.country_name, wowi_product_type.wowi_product_type_name, wowi_tech.wowi_tech_name ,Target_Rates.rate
FROM [Target] INNER JOIN country ON [Target].country_id = country.country_id 
INNER JOIN wowi_product_type ON [Target].product_type_id = wowi_product_type.wowi_product_type_id 
INNER JOIN wowi_tech ON [Target].Technology_id = wowi_tech.wowi_tech_id
LEFT JOIN Target_Rates ON [Target].country_id = Target_Rates.country_id 
and [Target].product_type_id = Target_Rates.product_type_id
and [Target].technology_id = Target_Rates.technology_id" 
        
        
        UpdateCommand="UPDATE [Target] SET [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_id] = @authority_id, [technology_id] = @technology_id, [target_code] = @target_code, [target_description] = @target_description, [target_cost] = @target_cost , [target_cost_currency] =@target_cost_currency  WHERE [target_id] = @target_id">
        <DeleteParameters>
            <asp:Parameter Name="target_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="country_id" Type="Int32" />
            <asp:Parameter Name="product_type_id" Type="Int32" />
            <asp:Parameter Name="authority_id" Type="Int32" />
            <asp:Parameter Name="technology_id" Type="Int32" />
            <asp:Parameter Name="target_code" Type="String" />
            <asp:Parameter Name="target_description" Type="String" />
            <asp:Parameter Name="target_cost" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="country_id" Type="Int32" />
            <asp:Parameter Name="product_type_id" Type="Int32" />
            <asp:Parameter Name="authority_id" Type="Int32" />
            <asp:Parameter Name="technology_id" Type="Int32" />
            <asp:Parameter Name="target_code" Type="String" />
            <asp:Parameter Name="target_description" Type="String" />
            <asp:Parameter Name="target_cost" Type="Decimal" />
            <asp:Parameter Name="target_cost_currency" />
            <asp:Parameter Name="target_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        </asp:Content>

