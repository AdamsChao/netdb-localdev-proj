<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCreateQuotationTab1.ascx.cs"
    Inherits="Sales_uc_ucCreateQuotationTab1" %>
<%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
<style type="text/css">
    .CCSBotton
    {
        font-style: normal;
        width: 80px;
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;
        font-weight: 800;
    }
    .style4
    {
        width: 150px;
        text-align: left;
    }
    .quoEdit tr
    {
        height: 30px;
    }
</style>
<table align="center" class="quoEdit" border="1" cellpadding="0" cellspacing="0"
    width="100%" style="background-color: #EFF3FB">
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF;">
        <th colspan="2">
            EUT
        </th>
    </tr>
    <tr>
        <th class="style4">
            AE Name
        </th>
        <td>
            <asp:DropDownList ID="DropDownListEmp" runat="server" DataSourceID="SqlDataSourceEmp"
                DataTextField="fname" DataValueField="id">
            </asp:DropDownList>
            &nbsp;&nbsp;&nbsp; Access Level:<asp:DropDownList ID="ddlAccessLevel" 
                runat="server" DataSourceID="SqlDataSourceAccessLevel" 
                DataTextField="name" DataValueField="id" AppendDataBoundItems="True" 
                ondatabound="ddlAccessLevel_DataBound">
                <asp:ListItem Text="--select--" Value=""></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceAccessLevel" runat="server" 
                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                SelectCommand="SELECT access_level.id, access_level.name FROM access_level INNER JOIN m_employee_accesslevel ON access_level.id = m_employee_accesslevel.accesslevel_id WHERE (m_employee_accesslevel.employee_id = @employee_id) AND (access_level.publish = '1')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtCurrentEmployee_id" Name="employee_id" 
                        PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:TextBox ID="txtCurrentEmployee_id" runat="server" Visible="false"></asp:TextBox>
          
            <asp:SqlDataSource ID="SqlDataSourceEmp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT id, fname FROM employee WHERE (status = 'Active')"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Currency
        </th>
        <td>
            <asp:RadioButtonList ID="RadioButtonListCurrency" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem>NTD</asp:ListItem>
                <asp:ListItem Selected="True">USD</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Product Name
        </th>
        <td>
            <asp:TextBox ID="txtProductName" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            產品名稱
        </th>
        <td>
            <asp:TextBox ID="txtCProductName" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Model No.
        </th>
        <td>
            <asp:TextBox ID="txtModelNo" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            型號
        </th>
        <td>
            <asp:TextBox ID="txtCModelNo" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Brand Name
        </th>
        <td>
            <asp:TextBox ID="txtBrandName" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            廠牌
        </th>
        <td>
            <asp:TextBox ID="txtCBrandName" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Model Difference
        </th>
        <td>
            <asp:TextBox ID="txtModelDifference" runat="server" Width="500px" 
                MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            型號差異說明
        </th>
        <td>
            <asp:TextBox ID="txtCModelDifferencev" runat="server" Width="500px" 
                MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
        <th colspan="2">
            Client & Applicant
        </th>
    </tr>
    <tr>
        <th class="style4">
            Client
        </th>
        <td>
            <asp:DropDownList ID="DropDownListClient" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceClient"
                DataTextField="companyname" DataValueField="Id" OnSelectedIndexChanged="DropDownListClient_SelectedIndexChanged"
                OnDataBound="DropDownListClient_DataBound">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownListContact" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceContact"
                DataTextField="fullname" DataValueField="id" 
                OnSelectedIndexChanged="DropDownListContact_SelectedIndexChanged" 
                ondatabound="DropDownListContact_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT m_employee_accesslevel.employee_id, m_employee_accesslevel.accesslevel_id, clientapplicant.id, clientapplicant.companyname FROM m_employee_accesslevel INNER JOIN clientapplicant ON m_employee_accesslevel.accesslevel_id = clientapplicant.department_id WHERE (clientapplicant.clientapplicant_type = 1 OR clientapplicant.clientapplicant_type = 3) AND (m_employee_accesslevel.employee_id = @employee_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListEmp" Name="employee_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceContact" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                
                
                SelectCommand="SELECT contact_info.fname + ' ' + contact_info.lname AS fullname, contact_info.id FROM m_clientappliant_contact INNER JOIN clientapplicant ON m_clientappliant_contact.clientappliant_id = clientapplicant.id INNER JOIN contact_info ON m_clientappliant_contact.contact_id = contact_info.id INNER JOIN m_employee_accesslevel ON contact_info.department_id = m_employee_accesslevel.accesslevel_id LEFT OUTER JOIN country ON contact_info.country_id = country.country_id WHERE (clientapplicant.clientapplicant_type = 1 OR clientapplicant.clientapplicant_type = 3) AND (m_employee_accesslevel.employee_id = @employee_id) AND (clientapplicant.id = @client_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListEmp" Name="employee_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListClient" Name="client_id" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewClient" runat="server" AutoGenerateRows="False" Caption="Client Details"
                DataSourceID="SqlDataSourceClientAddress" Height="50px" CellPadding="4" ForeColor="#333333"
                GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                <EditRowStyle BackColor="#2461BF" />
                <FieldHeaderStyle BackColor="#DEE8F5" />
                <Fields>
                    <asp:BoundField DataField="country_name" HeaderText="Country" />
                    <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
                    <asp:BoundField DataField="c_address" HeaderText="地址" SortExpression="c_address" />
                    <asp:BoundField DataField="main_tel" HeaderText="Tel" SortExpression="main_tel" />
                    <asp:BoundField DataField="main_fax" HeaderText="Fax" SortExpression="main_fax" />
                </Fields>
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceClientAddress" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT clientapplicant.address, clientapplicant.c_address, clientapplicant.main_tel, clientapplicant.main_fax, country.country_name FROM clientapplicant LEFT OUTER JOIN country ON clientapplicant.country_id = country.country_id WHERE (clientapplicant.id = @id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListClient" Name="id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Applicant
        </th>
        <td>
            <asp:DropDownList ID="DropDownListApp" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceApp"
                DataTextField="companyname" DataValueField="Id" 
                ondatabound="DropDownListApp_DataBound">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceApp" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT m_employee_accesslevel.employee_id, m_employee_accesslevel.accesslevel_id, clientapplicant.id, clientapplicant.companyname FROM m_employee_accesslevel INNER JOIN clientapplicant ON m_employee_accesslevel.accesslevel_id = clientapplicant.department_id WHERE (clientapplicant.clientapplicant_type = 2 OR clientapplicant.clientapplicant_type = 3) AND (m_employee_accesslevel.employee_id = @employee_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListEmp" Name="employee_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:DetailsView ID="DetailsViewApp" runat="server" AutoGenerateRows="False" Caption="Applicant Details"
                DataSourceID="SqlDataSourceAppAddress" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                <EditRowStyle BackColor="#2461BF" />
                <FieldHeaderStyle BackColor="#DEE8F5" />
                <Fields>
                    <asp:BoundField DataField="country_name" HeaderText="Country" />
                    <asp:BoundField DataField="address" HeaderText="Address" SortExpression="address" />
                    <asp:BoundField DataField="c_address" HeaderText="地址" SortExpression="c_address" />
                    <asp:BoundField DataField="main_tel" HeaderText="Tel" SortExpression="main_tel" />
                    <asp:BoundField DataField="main_fax" HeaderText="Fax" SortExpression="main_fax" />
                </Fields>
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
            </asp:DetailsView>
            <asp:SqlDataSource ID="SqlDataSourceAppAddress" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT clientapplicant.address, clientapplicant.c_address, clientapplicant.main_tel, clientapplicant.main_fax, country.country_name FROM clientapplicant LEFT OUTER JOIN country ON clientapplicant.country_id = country.country_id WHERE (clientapplicant.id = @id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListApp" Name="id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
        <th colspan="2">
            Billing
        </th>
    </tr>
    <tr>
        <th colspan="2" style="text-align: left;">
            <asp:RadioButtonList ID="rblSame" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                AutoPostBack="True" OnSelectedIndexChanged="rblSame_SelectedIndexChanged">
                <asp:ListItem Selected="True">Build New</asp:ListItem>
                <asp:ListItem>Same as Client</asp:ListItem>
                <asp:ListItem>Not Same As Clinet</asp:ListItem>
            </asp:RadioButtonList>
            <asp:DropDownList ID="DropDownListClient2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceClient2"
                DataTextField="companyname" DataValueField="Id" Enabled="False" OnSelectedIndexChanged="DropDownListClient2_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownListContact2" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceContact2"
                DataTextField="fullname" DataValueField="id" 
                OnSelectedIndexChanged="DropDownListContact_SelectedIndexChanged" 
                Enabled="False" ondatabound="DropDownListContact2_DataBound">
                <asp:ListItem Value="0">--select--</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSourceClient2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                SelectCommand="SELECT m_employee_accesslevel.employee_id, m_employee_accesslevel.accesslevel_id, clientapplicant.id, clientapplicant.companyname FROM m_employee_accesslevel INNER JOIN clientapplicant ON m_employee_accesslevel.accesslevel_id = clientapplicant.department_id WHERE (clientapplicant.clientapplicant_type = 1 OR clientapplicant.clientapplicant_type = 3) AND (m_employee_accesslevel.employee_id = @employee_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListEmp" Name="employee_id" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceContact2" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                
                SelectCommand="SELECT contact_info.fname + ' ' + contact_info.lname AS fullname, contact_info.title, contact_info.companyname, contact_info.c_lname + contact_info.c_fname AS c_fullname, contact_info.c_title, contact_info.c_companyname, contact_info.workphone + '  ext ' + contact_info.ext AS phone, contact_info.fax, contact_info.email, country.country_name AS country, contact_info.address, contact_info.c_address, contact_info.id FROM m_clientappliant_contact INNER JOIN clientapplicant ON m_clientappliant_contact.clientappliant_id = clientapplicant.id INNER JOIN contact_info ON m_clientappliant_contact.contact_id = contact_info.id INNER JOIN m_employee_accesslevel ON contact_info.department_id = m_employee_accesslevel.accesslevel_id LEFT OUTER JOIN country ON contact_info.country_id = country.country_id WHERE (clientapplicant.clientapplicant_type = 1 OR clientapplicant.clientapplicant_type = 3) AND (m_employee_accesslevel.employee_id = @employee_id) AND (clientapplicant.id = @client_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListEmp" Name="employee_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListClient2" Name="client_id" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </th>
    </tr>
    <tr>
        <th class="style4">
            Bill Name
        </th>
        <td>
            <asp:TextBox ID="txtBill_Name" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Title
        </th>
        <td>
            <asp:TextBox ID="txtBill_Title" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Company Name
        </th>
        <td>
            <asp:TextBox ID="txtBillCompanyname" runat="server" Width="500px" 
                MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款連絡人
        </th>
        <td>
            <asp:TextBox ID="txtBill_CName" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款連絡人職稱
        </th>
        <td>
            <asp:TextBox ID="txtBill_CTitle" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款公司
        </th>
        <td>
            <asp:TextBox ID="txtBill_CCompanyname" runat="server" Width="500px" 
                MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Phone
        </th>
        <td>
            <asp:TextBox ID="txtBill_Phone" runat="server" Width="500px" MaxLength="50"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Email
        </th>
        <td>
            <asp:TextBox ID="txtBill_Email" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Country
        </th>
        <td>
            <asp:TextBox ID="txtBill_Country" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Bill Address
        </th>
        <td>
            <asp:TextBox ID="txtBill_Address" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            付款公司地址
        </th>
        <td>
            <asp:TextBox ID="txtBill_CAddress" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Payment days
        </th>
        <td>
         <asp:DropDownList ID="ddlPaymentDays" runat="server" 
                                                 SelectedValue='<%# Bind("paymentdays") %>'>
                                                 <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                                 <asp:ListItem Value="0">ASAP</asp:ListItem>
                                                 <asp:ListItem Value="7">  7 days</asp:ListItem>
                                                 <asp:ListItem Value="15"> 15 days</asp:ListItem>
                                                 <asp:ListItem Value="30"> 30 days</asp:ListItem>
                                                 <asp:ListItem Value="45"> 45 days</asp:ListItem>
                                                 <asp:ListItem Value="60"> 60 days</asp:ListItem>
                                                 <asp:ListItem Value="90"> 90 days</asp:ListItem>
                                                 <asp:ListItem Value="120">120 days</asp:ListItem>
                                             </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <th class="style4">
            Payment Term
        </th>
        <td>
            <asp:DropDownList ID="ddlPayment_Term" runat="server" >
                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                <asp:ListItem Value="0">支票 Check</asp:ListItem>
                <asp:ListItem Value="1">國內匯款 Domestic Wire Transfer</asp:ListItem>
                <asp:ListItem Value="6">國外匯款 Foreign Wire Transfer</asp:ListItem>
                <asp:ListItem Value="2">匯票 Cashier Check</asp:ListItem>
                <asp:ListItem Value="3">信用卡 Credit Card</asp:ListItem>
                <asp:ListItem Value="4">現金 Cash</asp:ListItem>
                <asp:ListItem Value="5">西聯匯款 Westerm Union</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr style="display: none" >
        <th class="style4">
            Client Status
        </th>
        <td >
            <asp:TextBox ID="txtClient_Status" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
    <tr style="display: none"cc>
        <th class="style4">
            DHL Acct.
        </th>
        <td>
            <asp:TextBox ID="txtDHL" runat="server" Width="500px" MaxLength="100"></asp:TextBox>
        </td>
    </tr>
</table>
<p style="text-align: center">
    <asp:Button ID="btnSubmit" CssClass="CCSBotton" runat="server" Text="Save" OnClick="btnSubmit_Click"
        OnClientClick="btn();" />
</p>
<%--    </ContentTemplate>
</asp:UpdatePanel>--%>
<asp:Literal ID="ltlMessage" runat="server"></asp:Literal>
<div id="dialog" title="Message" style="display: none;">
    Saved Succeed</div>
