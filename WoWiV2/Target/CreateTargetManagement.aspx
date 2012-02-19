<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void LinkButtonInsert_Click(object sender, EventArgs e)
    {
        SqlDataSourceTarget.InsertParameters["country_id"].DefaultValue = DropDownListCountry.SelectedValue;
        SqlDataSourceTarget.InsertParameters["product_type_id"].DefaultValue = DropDownListPT.SelectedValue;
        SqlDataSourceTarget.InsertParameters["authority_id"].DefaultValue = DropDownListAuthority.SelectedValue;
        SqlDataSourceTarget.InsertParameters["Technology_id"].DefaultValue = DropDownListTL.SelectedValue;
        SqlDataSourceTarget.InsertParameters["target_code"].DefaultValue = TextBoxCode.Text;
        SqlDataSourceTarget.InsertParameters["target_description"].DefaultValue = TextBoxDes.Text;
        SqlDataSourceTarget.InsertParameters["target_cost"].DefaultValue = TextBoxCost.Text;
        SqlDataSourceTarget.InsertParameters["target_cost_currency"].DefaultValue = DropDownListCurrency.SelectedItem.Text;        
        SqlDataSourceTarget.Insert();
    }

    protected void SqlDataSourceTarget_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            LabelMessage.Text = e.Exception.Message;
            e.ExceptionHandled = true;
        }
        else
        {
            LabelMessage.Text = "Target Creation Successful";
        }
    }

    protected void LinkButtonCancel_Click(object sender, EventArgs e)
    {
        TextBoxCode.Text = "";
        TextBoxDes.Text = "";
        TextBoxCost.Text = "";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Target Creation :
    <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/TargetManagement.aspx">Target Lists</asp:HyperLink>
    <br />
    <table border="1" >
        <tr>
            <td>
                    Country</td>
            <td>
                <asp:DropDownList ID="DropDownListCountry" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" 
                            AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                    Certification Type</td>
            <td>
                <asp:DropDownList ID="DropDownListPT" runat="server" 
                            DataSourceID="SqlDataSourcePT" DataTextField="wowi_product_type_name" 
                            DataValueField="wowi_product_type_id" 
                            AutoPostBack="True">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="DropDownListPT" Display="Dynamic" 
                        ErrorMessage="Can't be Empty"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSourcePT" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT wowi_product_type.wowi_product_type_id, wowi_product_type.wowi_product_type_name, Authority.authority_name, Authority.country_id FROM wowi_product_type INNER JOIN Authority ON wowi_product_type.wowi_product_type_id = Authority.wowi_product_type_id WHERE (wowi_product_type.publish = @publish) AND (Authority.country_id = @country_id)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Y" Name="publish" Type="String" />
                        <asp:ControlParameter ControlID="DropDownListCountry" DefaultValue="" 
                                Name="country_id" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                    Authority Name</td>
            <td>
                <asp:Label ID="LabelAuthority" runat="server"></asp:Label>
                <asp:DropDownList ID="DropDownListAuthority" runat="server" 
                        DataSourceID="SqlDataSourceAuthority" DataTextField="authority_name" 
                        DataValueField="authority_id" Enabled="False">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSourceAuthority" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        
                    SelectCommand="SELECT authority_id, authority_name FROM Authority WHERE (country_id = @country_id) AND (wowi_product_type_id = @wowi_product_type_id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownListCountry" Name="country_id" 
                                PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownListPT" Name="wowi_product_type_id" 
                                PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                    Technology</td>
            <td>
                <asp:DropDownList ID="DropDownListTL" runat="server" 
                        DataSourceID="SqlDataSourceTech" DataTextField="wowi_tech_name" 
                        DataValueField="wowi_tech_id">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownListTL" Display="Dynamic" 
                        ErrorMessage="Can't be Empty"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSourceTech" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT [wowi_tech_id], [wowi_tech_name] FROM [wowi_tech] WHERE (([publish] = @publish) AND ([wowi_product_type_id] = @wowi_product_type_id))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="Y" Name="publish" Type="String" />
                        <asp:ControlParameter ControlID="DropDownListPT" Name="wowi_product_type_id" 
                                PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>        
        <tr>
            <td>
                Target Description</td>
            <td>
                <asp:TextBox ID="TextBoxCode" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="TextBoxDes" runat="server" Rows="3" TextMode="MultiLine" 
                    Width="100%"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Target Cost </td>
            <td>
                <asp:DropDownList ID="DropDownListCurrency" runat="server">
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
                <asp:TextBox ID="TextBoxCost" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="TextBoxCost" Display="Dynamic" 
                    ErrorMessage="Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                        ControlToValidate="TextBoxCost" Display="Dynamic" 
                        ErrorMessage="Please Input Currency" Operator="GreaterThanEqual" 
                        Type="Currency" ValueToCompare="0" ForeColor="Red"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:LinkButton ID="LinkButtonInsert" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="Insert" onclick="LinkButtonInsert_Click"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButtonCancel" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel" onclick="LinkButtonCancel_Click"></asp:LinkButton>
            </td>
        </tr>
    </table>
    <asp:Label ID="LabelMessage" runat="server" ForeColor="Red"></asp:Label>
    <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
        DeleteCommand="DELETE FROM [Target] WHERE [target_id] = @target_id" 
        InsertCommand="INSERT INTO [Target] ([country_id], [product_type_id], [authority_id], [technology_id], [target_code], [target_description], [target_cost], [target_cost_currency]) VALUES (@country_id, @product_type_id, @authority_id, @technology_id, @target_code, @target_description, @target_cost, @target_cost_currency)" 
        SelectCommand="SELECT * FROM [Target]" 
        
        UpdateCommand="UPDATE [Target] SET [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_id] = @authority_id, [technology_id] = @technology_id, [target_code] = @target_code, [target_description] = @target_description, [target_cost] = @target_cost, [target_cost_currency] = @target_cost_currency WHERE [target_id] = @target_id" 
        oninserted="SqlDataSourceTarget_Inserted">
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
            <asp:Parameter Name="target_cost_currency" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="country_id" Type="Int32" />
            <asp:Parameter Name="product_type_id" Type="Int32" />
            <asp:Parameter Name="authority_id" Type="Int32" />
            <asp:Parameter Name="technology_id" Type="Int32" />
            <asp:Parameter Name="target_code" Type="String" />
            <asp:Parameter Name="target_description" Type="String" />
            <asp:Parameter Name="target_cost" Type="Decimal" />
            <asp:Parameter Name="target_cost_currency" Type="String" />
            <asp:Parameter Name="target_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [country_id], [country_name] FROM [country]">
        </asp:SqlDataSource>
        </asp:Content>

