<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>
<%@ Import Namespace="System.Data"  %>
<%@ Import Namespace="System.Data.SqlClient"  %>
<%@ Import Namespace="System.Configuration"  %>

<script runat="server">
    protected void DropDownListPT_SelectedIndexChanged(object sender, EventArgs e)
    {
        var results = SqlDataSourcePT.Select(DataSourceSelectArguments.Empty);
        //LabelAuthority.Text= ((System.Data.DataView)results)[DropDownListPT.SelectedIndex]["authority_name"].ToString();
    }

    protected void LinkButtonCancel_Click(object sender, EventArgs e)
    {
        TextBoxRate.Text = "";
    }

    //    <InsertParameters>
    //    <asp:Parameter Name="country_id" Type="Int32" />
    //    <asp:Parameter Name="product_type_id" Type="Int32" />
    //    <asp:Parameter Name="authority_name" Type="String" />
    //    <asp:Parameter Name="Technology_id" Type="Int32" />
    //    <asp:Parameter Name="rate" Type="Decimal" />
    //</InsertParameters>

    bool CheckTargetRate(string country_id, string product_type_id, string Technology_id)
    {
        int counter = 0;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString))
        {
            cn.Open();
            SqlCommand cmd =
                new SqlCommand("Select count(*) from Target_Rates where country_id=@country_id and product_type_id=@product_type_id and Technology_id=@Technology_id", cn);
            cmd.Parameters.AddWithValue("@country_id", country_id);
            cmd.Parameters.AddWithValue("@product_type_id", product_type_id);
            cmd.Parameters.AddWithValue("@Technology_id", Technology_id);
            counter = int.Parse(cmd.ExecuteScalar().ToString());
        }
        if (counter > 0)
        {
            return true;            
        }
        else
        {
            return false;
        }
    }
    
    protected void LinkButtonInsert_Click(object sender, EventArgs e)
    {
        if (CheckTargetRate(DropDownListCountry.SelectedValue, DropDownListPT.SelectedValue, DropDownListTL.SelectedValue))
        {
            LabelMessage.Text = "This TargetRate is already Exist , Please Insert the other one!";
            return;
        }
        
        SqlDataSourceRate.InsertParameters["country_id"].DefaultValue =DropDownListCountry.SelectedValue;
        SqlDataSourceRate.InsertParameters["product_type_id"].DefaultValue = DropDownListPT.SelectedValue;
        SqlDataSourceRate.InsertParameters["authority_name"].DefaultValue = DropDownListAuthority.SelectedValue;
        SqlDataSourceRate.InsertParameters["Technology_id"].DefaultValue = DropDownListTL.SelectedValue;
        SqlDataSourceRate.InsertParameters["rate"].DefaultValue = TextBoxRate.Text;        
        SqlDataSourceRate.Insert();       
    }

    protected void SqlDataSourceRate_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        if (e.Exception != null)
        {
            LabelMessage.Text = e.Exception.Message;
            e.ExceptionHandled = true;       
        }
        else
        {
            LabelMessage.Text = "TargetRate Creation Successful";          
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        TargetRate Creation :
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Target/TargetRate.aspx">TargetRate Lists</asp:HyperLink>
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
                            AutoPostBack="True" 
                        onselectedindexchanged="DropDownListPT_SelectedIndexChanged">
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
                        DataValueField="authority_name" Enabled="False">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceAuthority" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                        SelectCommand="SELECT [authority_name] FROM [Authority] WHERE (([country_id] = @country_id) AND ([wowi_product_type_id] = @wowi_product_type_id))">
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
                    Rate(USD)</td>
                <td>
                    <asp:TextBox ID="TextBoxRate" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBoxRate" Display="Dynamic" 
                        ErrorMessage="Can't be Empty" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                        ControlToValidate="TextBoxRate" Display="Dynamic" 
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
        <br />
        <asp:SqlDataSource ID="SqlDataSourceRate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            DeleteCommand="DELETE FROM [Target_Rates] WHERE [Target_rate_id] = @Target_rate_id" 
            InsertCommand="INSERT INTO [Target_Rates] ([country_id], [product_type_id], [authority_name], [Technology_id], [rate]) VALUES (@country_id, @product_type_id, @authority_name, @Technology_id, @rate)" 
            SelectCommand="SELECT * FROM [Target_Rates]" 
            
            UpdateCommand="UPDATE [Target_Rates] SET [country_id] = @country_id, [product_type_id] = @product_type_id, [authority_name] = @authority_name, [Technology_id] = @Technology_id, [rate] = @rate WHERE [Target_rate_id] = @Target_rate_id" 
            oninserted="SqlDataSourceRate_Inserted">
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
        <asp:SqlDataSource ID="SqlDataSourceCountry" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
            SelectCommand="SELECT [country_id], [country_name] FROM [country]">
        </asp:SqlDataSource>
        </p>
</asp:Content>

