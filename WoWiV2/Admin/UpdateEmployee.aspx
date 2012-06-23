<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        InitAccessLevel();
    }


    private void InitAccessLevel()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            EmployeeUtils.InitAccessLevel(id, FormView1, EmployeeUtils.Name_CheckBox_AccessLevel);
            
        }
        catch
        {
        }
    }
   
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        EmployeeUtils.StoreDatasInViewState((FormView)sender, EmployeeUtils.Name_CheckBox_AccessLevel, ViewState, EmployeeUtils.Key_ViewState_AccessLevel);
    }

    protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.employee obj = (WoWiModel.employee)e.Entity;
            List<int> asscesslevel = (List<int>)ViewState[EmployeeUtils.Key_ViewState_AccessLevel];
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                var data = db.m_employee_accesslevel;
                try
                {
                    var delList = from c in db.m_employee_accesslevel where c.employee_id == obj.id select c;
                    foreach (WoWiModel.m_employee_accesslevel item in delList)
                    {
                        data.DeleteObject(item);
                    }
                    try
                    {
                        db.SaveChanges();
                    }
                    catch
                    {
                    }
                }
                catch (Exception ex)
                {
                }
                if (asscesslevel.Count != 0)
                {

                    
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
            ViewState.Remove(EmployeeUtils.Key_ViewState_AccessLevel);
            Response.Redirect("~/Admin/EmployeeDetails.aspx?id=" + obj.id,false);
        }
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
    Employee Update&nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Employee List</asp:HyperLink>
    <br />
    <asp:FormView ID="FormView1" runat="server" CellPadding="4" DataKeyNames="id" SkinID="FormView"
    DataSourceID="EntityDataSource1" DefaultMode="Edit" ForeColor="#333333" 
       Width="100%" onitemupdating="FormView1_ItemUpdating">
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
                      <tr>
                            <th align="left" class="style4">
                               &nbsp; User Name:&nbsp;</th>
                            <td class="style7" colspan="3">
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("username") %>' Enabled="false"></asp:TextBox>(For Login)
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
                         &nbsp;</td>
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
                                     <asp:TextBox ID="tbLastName" runat="server" Text='<%# Bind("c_lname") %>' 
                                         ></asp:TextBox>
                                    
                                 </td>
                             </tr>
                             <tr>
                                  <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>LastName:&nbsp;</th>
                                 <td width="40%">
                                     <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("lname") %>' 
                                         ></asp:TextBox>
                                    
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>名:&nbsp;</th>
                                 <td width="40%">
                                     <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("c_fname") %>' 
                                        ></asp:TextBox>
                                    
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
                                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [jobtitle_id], [jobtitle_name] FROM [employee_jobtitle] where [publish] = 'true'">
                                </asp:SqlDataSource>
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Department:&nbsp;</th>
                                 <td width="40%">
                                     <asp:DropDownList ID="dlDepartment" runat="server" 
                                         DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id" 
                                         SelectedValue='<%# Bind("department_id") %>'  AppendDataBoundItems="True">
                                    <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                     </asp:DropDownList>
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
                                     <asp:TextBox ID="tbHireDate" runat="server" Text='<%# Bind("hiredate","{0:yyyy/MM/dd}") %>'></asp:TextBox>
                                     <asp:CalendarExtender ID="tbHireDate_CalendarExtender" runat="server" Format="yyyy/MM/dd"
                                         Enabled="True" TargetControlID="tbHireDate">
                                     </asp:CalendarExtender>
                                     &nbsp;
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Supervisor:&nbsp;</th>
                                 <td width="40%">
                                     <asp:DropDownList ID="dlSupervisor" runat="server" AppendDataBoundItems="True" 
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
                                     <asp:TextBox ID="tbWorkphone" runat="server" Text='<%# Bind("workphone") %>'></asp:TextBox>
                                     &nbsp;&nbsp;Ext:&nbsp;
                                     <asp:TextBox ID="tbExt" runat="server" Height="18px" 
                                         Text='<%# Bind("work_ext") %>' Width="22px"></asp:TextBox>
                                 </td>
                                 <th align="left" class="style4">
                                     <font color="red">*&nbsp;</font>Email:&nbsp;</th>
                                 <td width="40%">
                                     <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("email") %>' Width="250"></asp:TextBox>
                                 </td>
                             </tr>
                            <tr>
                            <th align="left" class="style4">
                                <font color="red">*&nbsp;</font>Quotation Authorize Currency:</th>
                            <td class="style7">
                               <%-- <asp:TextBox ID="tbAuthorizeAmt" runat="server"  Text='<%# Bind("q_authorize_currency") %>'></asp:TextBox>--%>
                               USD
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
                                <%--<asp:TextBox ID="TextBox5" runat="server"  Text='<%# Bind("pr_authorize_currency") %>'></asp:TextBox>--%>
                                USD
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
                 <tr>
                     <td>
                         &nbsp;</td>
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
                                <asp:TextBox ID="tbAddress" runat="server"  Text='<%# Bind("address") %>' Width="360"></asp:TextBox>
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
                                    SelectCommand="SELECT [country_id], [country_name] FROM [country] order by country_name">
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
                     <td align="center">
                         <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                             CommandName="Update" Text="Update" />
                         &nbsp;
                         <asp:LinkButton ID="UpdateDeleteButton" runat="server" Visible="false"
                             CausesValidation="False" CommandName="Delete" Text="Delete" />
                        <%-- &nbsp;
                         <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                             CommandName="Cancel" Text="Cancel" />
                              &nbsp;
                              <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/Admin/EmployeeList.aspx">Back to list</asp:HyperLink>--%>
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
    <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
        ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
        EnableUpdate="True" EntitySetName="employees"  Where="it.id == @id"
        onupdated="EntityDataSource1_Updated">
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
    </asp:EntityDataSource>
    <br />
</asp:Content>

