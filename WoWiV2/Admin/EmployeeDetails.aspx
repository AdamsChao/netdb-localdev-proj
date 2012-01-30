<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<script runat="server">

    protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">

        .style4
        {
            width: 15%;
        }
        .style7
        {
            width: 35%;
        }
        .style8
        {
            height: 19px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Employee Details&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Employee List</asp:HyperLink>
    <br />
    <asp:FormView ID="FormView1" runat="server" CellPadding="4" DataKeyNames="id" SkinID="FormView"
    DataSourceID="SqlDataSource1" DefaultMode="Edit" ForeColor="#333333" 
        Width="100%">
        <EditItemTemplate>

           
           <table align="left" border="0" cellpadding="2" cellspacing="0" 
            style="width: 100%">
            <tr>
                <td>
                 <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                     <tr>
                         <td colspan="4" class="style8">
                             ID :
                             <asp:Label ID="idLabel1" runat="server" Text='<%# Bind("id") %>' />
                         </td>
                     </tr>
                     <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                         <th colspan="4">
                             Employee Permission Information</th>
                     </tr>
                     <tr>
                         <th align="left" class="style4">
                             &nbsp; Password:&nbsp;</th>
                         <td class="style7">
                             <asp:Label ID="tbPassword" runat="server" Text='<%# Bind("password") %>'></asp:Label>
                         </td>
                         <th align="left" class="style4">
                             <font color="red">*&nbsp;</font>Status:&nbsp;</th>
                         <td width="40%">
                             <asp:DropDownList ID="dlStatus" runat="server" Enabled="false"
                                 SelectedValue='<%# Bind("status") %>'>
                                 <asp:ListItem>Active</asp:ListItem>
                                 <asp:ListItem>In-Active</asp:ListItem>
                                 <asp:ListItem>Retired</asp:ListItem>
                             </asp:DropDownList>
                         </td>
                     </tr>
                     <tr>
                         <th align="left" class="style4">
                             &nbsp; Confirm Password:&nbsp;</th>
                         <td class="style7">
                             <asp:Label ID="Label2" runat="server"></asp:Label>
                         </td>
                         <th align="left" class="style4">
                             <font color="red">*&nbsp;</font>Access Level:&nbsp;</th>
                         <td width="38%">
                             <asp:DropDownList ID="dlAccessLevel" runat="server"  Enabled="false"
                                 DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id" 
                                 SelectedValue='<%# Bind("accessprivilege") %>'>
                             </asp:DropDownList>
                             <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                 ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                 SelectCommand="SELECT DISTINCT [id], [name] FROM [department]">
                             </asp:SqlDataSource>
                            <%-- &nbsp;&nbsp;<asp:CheckBox ID="CheckBox1" runat="server" Enabled="false"
                                 Checked='<%# Bind("dotesting") %>' Text="Do Testing" />--%>
                         </td>
                     </tr>
                       <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>User Name:&nbsp;</th>
                            <td class="style7">
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("username") %>'></asp:Label>                                
                            </td>                        
                        </tr>
                 </table>
                 </td>
                 </tr>
                 <tr>
                     <td>
                         <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                             <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                 <th colspan="4">
                                     Employee Information</th>
                             </tr>
                             <tr>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>FirstName:&nbsp;</th>
                                 <td class="style7">
                                     <asp:Label ID="tbFirstName" runat="server" Text='<%# Bind("fname") %>' 
                                        ></asp:Label>
                                    
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>姓:&nbsp;</th>
                                 <td width="40%">
                                     <asp:Label ID="tbLastName" runat="server" Text='<%# Bind("c_lname") %>' 
                                         ></asp:Label>
                                    
                                 </td>
                             </tr>
                             <tr>
                                  <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>LastName:&nbsp;</th>
                                 <td width="40%">
                                     <asp:Label ID="Label1" runat="server" Text='<%# Bind("lname") %>' 
                                         ></asp:Label>
                                    
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>名:&nbsp;</th>
                                 <td width="40%">
                                     <asp:Label ID="Label3" runat="server" Text='<%# Bind("c_fname") %>' 
                                        ></asp:Label>
                                    
                                 </td>
                             </tr>
                             <tr>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Title:&nbsp;</th>
                                 <td class="style7">
                                     <asp:DropDownList ID="DropDownList2" runat="server" 
                                    DataSourceID="SqlDataSource4" DataTextField="jobtitle_name" Enabled="false"
                                    DataValueField="jobtitle_id" SelectedValue='<%# Bind("jobtitle_id") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [jobtitle_id], [jobtitle_name] FROM [employee_jobtitle]">
                                </asp:SqlDataSource>
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Department:&nbsp;</th>
                                 <td width="40%">
                                     <asp:DropDownList ID="dlDepartment" runat="server" Enabled="false"
                                         DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id" 
                                         SelectedValue='<%# Bind("department_id") %>'>
                                     </asp:DropDownList>
                                 </td>
                             </tr>
                             <tr>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Hire Date:&nbsp;</th>
                                 <td class="style7">
                                     <asp:Label ID="tbHireDate" runat="server" Text='<%# Bind("hiredate","{0:yyyy/MM/dd}") %>'></asp:Label>
                                     
                                     &nbsp;
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Supervisor:&nbsp;</th>
                                 <td width="40%">
                                     <asp:DropDownList ID="dlSupervisor" runat="server" AppendDataBoundItems="True" Enabled="false"
                                         DataSourceID="SqlDataSource2" DataTextField="un" DataValueField="id" SelectedValue='<%# Bind("supervisor_id") %>' 
                                       >
                                         <asp:ListItem Value="-1">None</asp:ListItem>
                                     </asp:DropDownList>
                                     <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                         ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                         SelectCommand="SELECT [id], [fname]+[lname] As [un]  FROM [employee]"></asp:SqlDataSource>
                                 </td>
                             </tr>
                             <tr>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Work Phone:</th>
                                 <td class="style7">
                                     <asp:Label ID="tbWorkphone" runat="server" Text='<%# Bind("workphone") %>'></asp:Label>
                                     &nbsp;&nbsp;Ext:&nbsp;
                                     <asp:Label ID="tbExt" runat="server" Height="18px" 
                                         Text='<%# Bind("work_ext") %>' Width="22px"></asp:Label>
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Email:&nbsp;</th>
                                 <td width="40%">
                                     <asp:Label ID="tbEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                 </td>
                             </tr>
                            <tr>
                            <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Quotation Authorize Currency:</th>
                            <td class="style7">
                                <asp:Label ID="tbAuthorizeAmt" runat="server"  Text='<%# Bind("q_authorize_currency") %>'></asp:Label>
                             </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Quotation Authorize Amount:</th>
                            <td class="style7">
                                <asp:Label ID="TextBox4" runat="server"  Text='<%# Bind("q_authorize_amt") %>'></asp:Label>
                             </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>PR Authorize Currency:</th>
                            <td class="style7">
                                <asp:Label ID="TextBox5" runat="server"  Text='<%# Bind("pr_authorize_currency") %>'></asp:Label>
                             </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>PR Authorize Amount:</th>
                            <td class="style7">
                                <asp:Label ID="TextBox6" runat="server"  Text='<%# Bind("pr_authorize_amt") %>'></asp:Label>
                             </td>
                        </tr>
                         </table>
                     </td>
                 </tr>
                 <tr>
                     <td>
                         <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                             <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                                 <th colspan="4">
                                     Employee Personal Information</th>
                             </tr>
                              <tr>
                            <th align="left" class="style4">
                                &nbsp; Address:&nbsp;</th>
                            <td  class="style7" >
                                <asp:Label ID="tbAddress" runat="server"  Text='<%# Bind("address") %>'></asp:Label>
                            </td>
                            <th align="left" class="style4">
                                &nbsp; Country:&nbsp;</th>
                            <td width="40%">
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                                    DataSourceID="SqlDataSource3" DataTextField="country_name" 
                                    DataValueField="country_id" SelectedValue='<%# Bind("country") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                             <tr>
                                 <th align="left" class="style4">
                                     &nbsp; Home Phone:</th>
                                 <td class="style7">
                                     <asp:Label ID="tbHomephone" runat="server" Text='<%# Bind("homephone") %>'></asp:Label>
                                 </td>
                                 <th align="left" class="style4">
                                     &nbsp; Cellphone:&nbsp;</th>
                                 <td width="40%">
                                     <asp:Label ID="tbCellPhone" runat="server" Text='<%# Bind("cellphone") %>'></asp:Label>
                                 </td>
                             </tr>
                         </table>
                     </td>
                 </tr>
                 <tr>
                     <td>
                              <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Back to list</asp:HyperLink>
                     </td>
                 </tr>
                 </table>
                 &nbsp;
        </EditItemTemplate>
        <EditRowStyle />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:FormView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
    DeleteCommand="DELETE FROM [employee] WHERE [id] = @id" 
    InsertCommand="INSERT INTO [employee] ([username], [password], [fname], [lname],[c_fname], [c_lname], [title], [hiredate], [terminationdate], [workphone], [homephone], [cellphone], [email], [address], [zip], [city], [state], [country], [status], [department_id], [accessprivilege], [supervisor_id], [create_date], [create_user], [modify_date], [modify_user], [work_ext], [signature], [dotesting]) VALUES (@username, @password, @fname, @lname, @title, @hiredate, @terminationdate, @workphone, @homephone, @cellphone, @email, @address, @zip, @city, @state, @country, @status, @department_id, @accessprivilege, @supervisorid, @create_date, @create_user, @modify_date, @modify_user, @work_ext, @signature, @dotesting)" 
    SelectCommand="SELECT * FROM [employee] WHERE ([id] = @id)" 
    
        UpdateCommand="UPDATE [employee] SET [username] = @username, [password] = @password, [fname] = @fname, [lname] = @lname, [c_fname] = @c_fname, [c_lname] = @lname, [title] = @title, [hiredate] = @hiredate, [terminationdate] = @terminationdate, [workphone] = @workphone, [homephone] = @homephone, [cellphone] = @cellphone, [email] = @email, [address] = @address, [zip] = @zip, [city] = @city, [state] = @state, [country] = @country, [status] = @status, [department_id] = @department_id, [accessprivilege] = @accessprivilege, [supervisor_id] = @supervisor_id, [create_date] = @create_date, [create_user] = @create_user, [modify_date] = @modify_date, [modify_user] = @modify_user, [work_ext] = @work_ext, [signature] = @signature WHERE [id] = @id" 
        oninserting="SqlDataSource1_Inserting">
    <DeleteParameters>
        <asp:Parameter Name="id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="username" Type="String" />
        <asp:Parameter Name="password" Type="String" />
        <asp:Parameter Name="fname" Type="String" />
        <asp:Parameter Name="lname" Type="String" />
        <asp:Parameter Name="title" Type="String" />
        <asp:Parameter Name="hiredate" Type="DateTime" />
        <asp:Parameter Name="terminationdate" Type="DateTime" />
        <asp:Parameter Name="workphone" Type="String" />
        <asp:Parameter Name="homephone" Type="String" />
        <asp:Parameter Name="cellphone" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="address" Type="String" />
        <asp:Parameter Name="zip" Type="String" />
        <asp:Parameter Name="city" Type="String" />
        <asp:Parameter Name="state" Type="String" />
        <asp:Parameter Name="country" Type="String" />
        <asp:Parameter Name="status" Type="String" />
        <asp:Parameter Name="department_id" Type="Byte" />
        <asp:Parameter Name="accessprivilege" Type="String" />
        <asp:Parameter Name="supervisorid" Type="Int32" />
        <asp:Parameter Name="create_date" Type="DateTime" />
        <asp:Parameter Name="create_user" Type="String" />
        <asp:Parameter Name="modify_date" Type="DateTime" />
        <asp:Parameter Name="modify_user" Type="String" />
        <asp:Parameter Name="work_ext" Type="String" />
        <asp:Parameter Name="signature" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="username" Type="String" />
        <asp:Parameter Name="password" Type="String" />
        <asp:Parameter Name="fname" Type="String" />
        <asp:Parameter Name="lname" Type="String" />
         <asp:Parameter Name="c_fname" Type="String" />
        <asp:Parameter Name="c_lname" Type="String" />
        <asp:Parameter Name="title" Type="String" />
        <asp:Parameter Name="hiredate" Type="DateTime" />
        <asp:Parameter Name="terminationdate" Type="DateTime" />
        <asp:Parameter Name="workphone" Type="String" />
        <asp:Parameter Name="homephone" Type="String" />
        <asp:Parameter Name="cellphone" Type="String" />
        <asp:Parameter Name="email" Type="String" />
        <asp:Parameter Name="address" Type="String" />
        <asp:Parameter Name="zip" Type="String" />
        <asp:Parameter Name="city" Type="String" />
        <asp:Parameter Name="state" Type="String" />
        <asp:Parameter Name="country" Type="String" />
        <asp:Parameter Name="status" Type="String" />
        <asp:Parameter Name="department_id" Type="Byte" />
        <asp:Parameter Name="accessprivilege" Type="String" />
        <asp:Parameter Name="supervisor_id" Type="Int32" />
        <asp:Parameter Name="create_date" Type="DateTime" />
        <asp:Parameter Name="create_user" Type="String" />
        <asp:Parameter Name="modify_date" Type="DateTime" />
        <asp:Parameter Name="modify_user" Type="String" />
        <asp:Parameter Name="work_ext" Type="String" />
        <asp:Parameter Name="signature" Type="String" />
        <asp:Parameter Name="id" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
            <asp:QueryStringParameter DefaultValue="3" Name="id" QueryStringField="id" 
                Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
    <br />
</asp:Content>

