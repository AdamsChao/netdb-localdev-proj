<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<script runat="server">

    protected void EntityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.employee obj = (WoWiModel.employee)e.Entity;


            List<int> asscesslevel = (List<int>)ViewState[EmployeeUtils.Key_ViewState_AccessLevel];
            if (asscesslevel.Count != 0)
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_employee_accesslevel;
                    foreach (int id in asscesslevel)
                    {
                        var d = new WoWiModel.m_employee_accesslevel()
                        {
                            employee_id = obj.id,
                            accesslevel_id = id
                        };
                        data.AddObject(d);
                    }
                    try
                    {
                        db.SaveChanges();
                    }
                    catch
                    {
                    }
                }
            }
        }
    }

    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        EmployeeUtils.StoreDatasInViewState((FormView)sender, EmployeeUtils.Name_CheckBox_AccessLevel, ViewState, EmployeeUtils.Key_ViewState_AccessLevel);
    }

    protected void EntityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.employee obj = (WoWiModel.employee)e.Entity;
        obj.create_date = DateTime.Now;
        obj.create_user = User.Identity.Name;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Employee Creation&nbsp;
<asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Employee List</asp:HyperLink>
<br />
   
<asp:FormView ID="FormView1" runat="server" CellPadding="4" DataKeyNames="id" SkinID="FormView"
    DataSourceID="EntityDataSource1" DefaultMode="Insert" ForeColor="#333333" 
       Width="100%" oniteminserting="FormView1_ItemInserting">
   
    <EditRowStyle />
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <InsertItemTemplate>
        <table align="left" border="0" cellpadding="2" cellspacing="0" 
            style="width: 100%">
            <tr>
                <td>
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr align="center" style="color: #FFFFFF; background-color: #0066FF">
                            <th colspan="4">
                                Employee Permission Information</th>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                &nbsp; Password:&nbsp;</th>
                            <td class="style7">
                                <asp:TextBox ID="tbPassword" runat="server" Text='<%# Bind("password") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Status:&nbsp;</th>
                            <td width="40%">
                                <asp:DropDownList ID="dlStatus" runat="server" 
                                    SelectedValue='<%# Bind("status") %>'>
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>In-Active</asp:ListItem>
                                    <asp:ListItem>Retired</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <%--<tr>
                            <th align="left" class="style4">
                                &nbsp; Confirm Password:&nbsp;</th>
                            <td class="style7">
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Access Level:&nbsp;</th>
                            <td width="38%">
                                <asp:DropDownList ID="dlAccessLevel" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id" 
                                    SelectedValue='<%# Bind("accessprivilege") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT DISTINCT [id], [name] FROM [department]">
                                </asp:SqlDataSource>
                              &nbsp;<b>Do Testing </b>
                                &nbsp;<asp:CheckBox ID="CheckBox1" runat="server" 
                                    Text='<%# Bind("dotesting") %>' Checked='<%# Bind("dotesting") %>' />
                            </td>
                        </tr>--%>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>User Name:&nbsp;</th>
                            <td class="style7" colspan="3">
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("username") %>'></asp:TextBox>(For Login)
                            </td>                        
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Access Level:&nbsp;</th>
                            <td class="style7" colspan="3">
                                <asp:CheckBoxList 
                               ID="clAccessLevel" runat="server" 
                               DataSourceID="SqlDataSource55" DataTextField="name" DataValueField="id" 
                               RepeatColumns="4" RepeatDirection="Horizontal"></asp:CheckBoxList>
                              <asp:SqlDataSource ID="SqlDataSource55" runat="server" 
                                                     ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                     SelectCommand="SELECT * FROM [access_level] where [publish] = 'true'"></asp:SqlDataSource>
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
                                <asp:TextBox ID="tbFirstName" runat="server" Text='<%# Bind("fname") %>' 
                                    ></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>姓:&nbsp;</th>
                            <td width="40%">
                                <asp:TextBox ID="tbcLastName" runat="server" Text='<%# Bind("c_lname") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>LastName:&nbsp;</th>
                            <td width="40%">
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>名:&nbsp;</th>
                            <td width="40%">
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("c_fname") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Title:&nbsp;</th>
                            <td class="style7">
                                <asp:DropDownList ID="DropDownList2" runat="server" 
                                    DataSourceID="SqlDataSource4" DataTextField="jobtitle_name" 
                                    DataValueField="jobtitle_id" SelectedValue='<%# Bind("jobtitle_id") %>' 
                                     AppendDataBoundItems="True">
                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                </asp:DropDownList>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                    ShowMessageBox="True" ShowSummary="False" />
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [jobtitle_id], [jobtitle_name] FROM [employee_jobtitle] where [publish] = 'true'">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="DropDownList2" ErrorMessage="Please select title." 
                                    Font-Bold="True" ForeColor="Red" InitialValue="-1">*</asp:RequiredFieldValidator>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Department:&nbsp;</th>
                            <td width="40%">
                                <asp:DropDownList ID="dlDepartment" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id"  
                                    SelectedValue='<%# Bind("department_id") %>' AppendDataBoundItems="True">
                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="dlDepartment" ErrorMessage="Please select department." 
                                    Font-Bold="True" ForeColor="Red" InitialValue="-1">*</asp:RequiredFieldValidator>
                                 <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [id], [name] FROM [department] WHERE [publish] = 'true'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Hire Date:&nbsp;</th>
                            <td class="style7">
                                <asp:TextBox ID="tbHireDate" runat="server"  Text='<%# Bind("hiredate","{0:yyyy/MM/dd}") %>'></asp:TextBox>
                                <asp:CalendarExtender ID="tbHireDate_CalendarExtender" runat="server" 
                                    Enabled="True" TargetControlID="tbHireDate" Format="yyyy/MM/dd">
                                </asp:CalendarExtender>
                                &nbsp;
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Supervisor:&nbsp;</th>
                            <td width="40%">
                                <asp:DropDownList ID="dlSupervisor" runat="server" 
                                    DataSourceID="SqlDataSource2" DataTextField="un" DataValueField="id" 
                                    SelectedValue='<%# Bind("supervisor_id") %>' AppendDataBoundItems="True">
                                    <asp:ListItem Value="-1">None</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [id], [fname]+[lname] As [un]  FROM [employee]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Work Phone:</th>
                            <td class="style7">
                                <asp:TextBox ID="tbWorkphone" runat="server"  Text='<%# Bind("workphone") %>'></asp:TextBox>
                                &nbsp;&nbsp;Ext:&nbsp;
                                <asp:TextBox ID="tbExt" runat="server" Height="18px" Width="22px" Text='<%# Bind("work_ext") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Email:&nbsp;</th>
                            <td width="40%">
                                <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Quotation Authorize Currency:</th>
                            <td class="style7">
                                <asp:TextBox ID="tbAuthorizeAmt" runat="server"  Text='<%# Bind("q_authorize_currency") %>'></asp:TextBox>
                             </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Quotation Authorize Amount:</th>
                            <td class="style7">
                                <asp:TextBox ID="TextBox4" runat="server"  Text='<%# Bind("q_authorize_amt") %>'></asp:TextBox>
                             </td>
                        </tr>
                        <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>PR Authorize Currency:</th>
                            <td class="style7">
                                <asp:TextBox ID="TextBox5" runat="server"  Text='<%# Bind("pr_authorize_currency") %>'></asp:TextBox>
                             </td>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>PR Authorize Amount:</th>
                            <td class="style7">
                                <asp:TextBox ID="TextBox6" runat="server"  Text='<%# Bind("pr_authorize_amt") %>'></asp:TextBox>
                             </td>
                        </tr>
                    </table>
                </td>
            </tr>
           <%-- <tr>
                <td>
                    &nbsp;</td>
            </tr>--%>
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
                                <asp:TextBox ID="tbAddress" runat="server"  Text='<%# Bind("address") %>'></asp:TextBox>
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
                                <asp:TextBox ID="tbHomephone" runat="server" Text='<%# Bind("homephone") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style4">
                                &nbsp; Cellphone:&nbsp;</th>
                            <td width="40%">
                                <asp:TextBox ID="tbCellPhone" runat="server" Text='<%# Bind("cellphone") %>'></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                        CommandName="Insert" Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                        CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                         &nbsp;
                       <%-- <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Back to list</asp:HyperLink>--%>
                </td>
            </tr>
        </table>
    </InsertItemTemplate>
   
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#EFF3FB" />
</asp:FormView>
    <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
        ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
        EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
        EntitySetName="employees" oninserted="EntityDataSource1_Inserted" 
        oninserting="EntityDataSource1_Inserting">
    </asp:EntityDataSource>
<br />
</asp:Content>

