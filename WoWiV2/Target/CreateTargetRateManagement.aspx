<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

  protected void LinkButtonInsert_Click(object sender, EventArgs e)
  {
    try
    {
      SqlDataSourceRate.InsertParameters["country_id"].DefaultValue = DropDownListCountry.SelectedValue;
      SqlDataSourceRate.InsertParameters["product_type_id"].DefaultValue = DropDownListPT.SelectedValue;
      SqlDataSourceRate.InsertParameters["authority_id"].DefaultValue = DropDownListAuthority.SelectedValue;
      SqlDataSourceRate.InsertParameters["Technology_id"].DefaultValue = DropDownListTL.SelectedValue;
      SqlDataSourceRate.InsertParameters["authority_name"].DefaultValue = DropDownListAuthority.SelectedItem.Text;
      SqlDataSourceRate.InsertParameters["target_cost"].DefaultValue = TextBoxCost.Text;
      SqlDataSourceRate.InsertParameters["target_cost_currency"].DefaultValue = DropDownListCurrency.SelectedItem.Text;
      SqlDataSourceRate.InsertParameters["rate"].DefaultValue = TextBoxRate.Text;
      SqlDataSourceRate.InsertParameters["local_agent_name"].DefaultValue = TextBoxAgent.Text;
      SqlDataSourceRate.InsertParameters["Publish"].DefaultValue = CheckBoxPublish.Checked.ToString();
      SqlDataSourceRate.Insert();
      Message.Text = "Target Rate Creation Successful!";
    }
    catch (Exception ex)
    {
      Message.Text = ex.Message;
    }
  }

  protected void LinkButtonCancel_Click(object sender, EventArgs e)
  {
    TextBoxRate.Text = "";
    TextBoxAgent.Text = "";
    TextBoxCost.Text = "";
  }

  protected void DropDownListPT_DataBound(object sender, EventArgs e)
  {
    DropDownListPT.Items.Insert(0, new ListItem()
    {
      Text = "-- Please select a Certification Type --",
      Value = "0"
    });
  }

  protected void DropDownListCountry_DataBound(object sender, EventArgs e)
  {
    DropDownListCountry.Items.Insert(0, new ListItem()
    {
      Text = "-- Please select a Country --",
      Value = "0"
    });
  }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Target Rate Creation :
  <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/TargetRate.aspx">Target Rate Lists</asp:HyperLink>
    <br />
    <table border="1" >
        <tr>
            <td>
                    Country</td>
            <td>
                <asp:DropDownList ID="DropDownListCountry" runat="server" 
                            DataSourceID="SqlDataSourceCountry" DataTextField="country_name" 
                            DataValueField="country_id" 
                            AutoPostBack="True" ondatabound="DropDownListCountry_DataBound">
                </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            
                  
                  SelectCommand="SELECT DISTINCT country.country_id, country.country_name FROM country INNER JOIN Authority ON country.country_id = Authority.country_id and Authority.Publish=1 Order by country.country_id">
        </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                    Authority Name</td>
            <td>
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
                    Certification Type</td>
            <td>
                <asp:DropDownList ID="DropDownListPT" runat="server" 
                            DataSourceID="SqlDataSourcePT" DataTextField="wowi_product_type_name" 
                            DataValueField="wowi_product_type_id" 
                            AutoPostBack="True" ondatabound="DropDownListPT_DataBound">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="DropDownListPT" Display="Dynamic" 
                        ErrorMessage="至少選擇一個Certification Type" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSourcePT" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT wowi_product_type.wowi_product_type_id, wowi_product_type.wowi_product_type_name, Authority.authority_name, Authority.country_id FROM wowi_product_type INNER JOIN Authority ON wowi_product_type.wowi_product_type_id = Authority.wowi_product_type_id WHERE (wowi_product_type.publish = 1) AND (Authority.country_id = @country_id)">
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
                    Technology</td>
            <td>
                <asp:DropDownList ID="DropDownListTL" runat="server" 
                        DataSourceID="SqlDataSourceTech" DataTextField="wowi_tech_name" 
                        DataValueField="wowi_tech_id">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="DropDownListTL" Display="Dynamic" 
                        ErrorMessage="至少選擇一個Technology" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDataSourceTech" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT [wowi_tech_id], [wowi_tech_name] FROM [wowi_tech] WHERE (([publish] = 1) AND ([wowi_product_type_id] = @wowi_product_type_id))">
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
        
        <tr><td>Target Rate</td><td>
          <asp:TextBox ID="TextBoxRate" runat="server"></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="TextBoxRate" Display="Dynamic" 
                    ErrorMessage="Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator4" runat="server" 
                        ControlToValidate="TextBoxRate" Display="Dynamic" 
                        ErrorMessage="Please Input Currency" Operator="GreaterThanEqual" 
                        Type="Currency" ValueToCompare="0" ForeColor="Red"></asp:CompareValidator>
          </td></tr>
        <tr><td>Local Agent name</td><td>
          <asp:TextBox ID="TextBoxAgent" runat="server"></asp:TextBox>
          </td></tr>
        <tr><td>Publish</td><td>
          <asp:CheckBox ID="CheckBoxPublish" runat="server" Checked="True" /></td></tr>
          <tr>
            <td colspan="2">
                <asp:LinkButton ID="LinkButtonInsert" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="Insert" onclick="LinkButtonInsert_Click"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButtonCancel" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel" onclick="LinkButtonCancel_Click"></asp:LinkButton>
            </td>
        </tr>
    </table>
  
  <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
    DeleteCommand="DELETE FROM [Target_Rates] WHERE [Target_rate_id] = @Target_rate_id" 
    InsertCommand="INSERT INTO [Target_Rates] ([country_id], [product_type_id], [Technology_id], [authority_id], [authority_name], [rate], [target_cost_currency], [target_cost], [local_agent_name], [Publish]) VALUES (@country_id, @product_type_id, @Technology_id, @authority_id, @authority_name, @rate, @target_cost_currency, @target_cost, @local_agent_name, @Publish)" 
    SelectCommand="SELECT * FROM [Target_Rates]" 
    UpdateCommand="UPDATE [Target_Rates] SET [country_id] = @country_id, [product_type_id] = @product_type_id, [Technology_id] = @Technology_id, [authority_id] = @authority_id, [authority_name] = @authority_name, [rate] = @rate, [target_cost_currency] = @target_cost_currency, [target_cost] = @target_cost, [local_agent_name] = @local_agent_name, [Publish] = @Publish WHERE [Target_rate_id] = @Target_rate_id">
    <DeleteParameters>
      <asp:Parameter Name="Target_rate_id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
      <asp:Parameter Name="country_id" Type="Int32" />
      <asp:Parameter Name="product_type_id" Type="Int32" />
      <asp:Parameter Name="Technology_id" Type="Int32" />
      <asp:Parameter Name="authority_id" Type="Int32" />
      <asp:Parameter Name="authority_name" Type="String" />
      <asp:Parameter Name="rate" Type="Decimal" />
      <asp:Parameter Name="target_cost_currency" Type="String" />
      <asp:Parameter Name="target_cost" Type="Decimal" />
      <asp:Parameter Name="local_agent_name" Type="String" />
      <asp:Parameter Name="Publish" Type="Boolean" />
    </InsertParameters>
    <UpdateParameters>
      <asp:Parameter Name="country_id" Type="Int32" />
      <asp:Parameter Name="product_type_id" Type="Int32" />
      <asp:Parameter Name="Technology_id" Type="Int32" />
      <asp:Parameter Name="authority_id" Type="Int32" />
      <asp:Parameter Name="authority_name" Type="String" />
      <asp:Parameter Name="rate" Type="Decimal" />
      <asp:Parameter Name="target_cost_currency" Type="String" />
      <asp:Parameter Name="target_cost" Type="Decimal" />
      <asp:Parameter Name="local_agent_name" Type="String" />
      <asp:Parameter Name="Publish" Type="Boolean" />
      <asp:Parameter Name="Target_rate_id" Type="Int32" />
    </UpdateParameters>
  </asp:SqlDataSource>
        <asp:Label ID="Message" runat="server" EnableViewState="False" ForeColor="Red"></asp:Label>
        </asp:Content>

