<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    
    WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();
    protected void Pag_Completed(object sender, EventArgs e)
    {

        InitRoles();

    }


    private void InitRoles()
    {
        try
        {
            String str = Request.QueryString["id"];
            int id = int.Parse(str);
            ContactUtils.InitRoles(id, FormView1, ContactUtils.Name_CheckBox_RoleList);
        }
        catch
        {
        }
    }
    

    protected void clRoleList_DataBound(object sender, EventArgs e)
    {
        InitRoles();
    }

    protected void ddlEmployeeList_Load(object sender, EventArgs ea)
    {
        var list = EmployeeUtils.GetEmployeeList(db);
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataSource = list;
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataTextField = "name";
        (FormView1.FindControl("ddlEmployeeList") as DropDownList).DataValueField = "id";
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 174px;
            height: 18px;
        }
        .style3
        {
            height: 18px;
        }
        .style7
        {
            width: 15%;
        }
        .style8
        {
            height: 18px;
            width: 67px;
        }
        .style9
        {
            width: 15%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
   <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        </asp:ScriptManagerProxy>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" SkinID="FormView"
            DataSourceID="EntityDataSource1" Width="100%" >
            <ItemTemplate>
                <table align="left" border="0" cellpadding="2" cellspacing="0" 
                    style="width:95%">
                    <tr>
                        <th align="left">
                            <font size="+1">Contact Information&nbsp; </font>
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                NavigateUrl="~/Admin/ContactList.aspx">Contact List</asp:HyperLink>
                            &nbsp;</th>
                    </tr>
                    <tr>
                        <td>
                            <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                            <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                           <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" Enabled="false"
                                                DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id"  AppendDataBoundItems="True" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" 
                                                Enabled="false" AppendDataBoundItems="True" onload="ddlEmployeeList_Load" SelectedValue='<%# Bind("employee_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                        </td></tr>

                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp;&nbsp; First Name:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbFirstName" runat="server" Text='<%# Bind("fname") %>'></asp:Label>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 姓:</th>
                                    <td width="35%">
                                        <asp:Label ID="tbcLastName" runat="server" Text='<%# Bind("c_lname") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp;&nbsp; Last Name:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbLastName" runat="server" Text='<%# Bind("lname") %>'></asp:Label>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 名:&nbsp;&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbcFirstName" runat="server" Text='<%# Bind("c_fname") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style2">
                                        &nbsp; Title:&nbsp;</th>
                                    <td class="style3" width="35%">
                                        <asp:Label ID="tbTitle" runat="server" Text='<%# Bind("title") %>'></asp:Label>
                                    </td>
                                    <th align="left" class="style8">
                                        &nbsp; 職稱:</th>
                                    <td class="style3" width="35%">
                                        <asp:Label ID="tbcTitle" runat="server" Text='<%# Bind("c_title") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp;&nbsp; Company:&nbsp;&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="Company" runat="server" Text='<%# Bind("companyname") %>'></asp:Label>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 公司:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp;&nbsp; Work Phone:</th>
                                    <td width="35%">
                                        <asp:Label ID="tbWorkphone" runat="server" Text='<%# Bind("workphone") %>'></asp:Label>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Ext</strong>:&nbsp;&nbsp;<asp:Label ID="tbExt" runat="server" 
                                            Text='<%# Bind("ext") %>' Width="44px"></asp:Label>
                                        &nbsp;</td>
                                    <th align="left" class="style7">
                                        &nbsp;&nbsp; Email:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp; Cell Phone:</th>
                                    <td width="35%">
                                        <asp:Label ID="tbCellPhone" runat="server" Text='<%# Bind("cellphone") %>'></asp:Label>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; Fax:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbFax" runat="server" Text='<%# Bind("fax") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp;&nbsp; Address:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbAddress" runat="server" Text='<%# Bind("address") %>' 
                                            Width="211px"></asp:Label>
                                    </td>
                                    <th align="left" class="style7">
                                        &nbsp; 地址:&nbsp;</th>
                                    <td width="35%">
                                        <asp:Label ID="tbcAddresss" runat="server" Text='<%# Bind("c_address") %>' 
                                            Width="211px"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <th align="left" class="style9">
                                        &nbsp; Country:&nbsp;</th>
                                    <td colspan="3">
                              <asp:DropDownList ID="dlCountry" runat="server" Enabled="False"
                                  DataSourceID="SqlDataSource1" DataTextField="country_name" 
                                  DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                              </asp:DropDownList>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                  ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                  SelectCommand="SELECT [country_id], [country_name] FROM [country] order by [country_name]">
                              </asp:SqlDataSource>
                          </td>
                                </tr>
                                <tr>
                                <td colspan = "4" align="left">
                           
                          
                                     <b>&nbsp; Title: </b>
                            <br />
                                        <asp:CheckBoxList ID="clRoleList" runat="server" Enabled="False"
                                            DataSourceID="EntityDataSource2" DataTextField="contact_name" DataValueField="contact_id" 
                                            RepeatColumns="5" RepeatDirection="Horizontal" 
                                            ondatabound="clRoleList_DataBound">
                                        </asp:CheckBoxList>
                                        <asp:EntityDataSource ID="EntityDataSource2" runat="server" 
                                            ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
                                            EnableFlattening="False" EntitySetName="contact_role" 
                                            Select="it.[contact_id], it.[contact_name]">
                                        </asp:EntityDataSource>
                                    
                        </td>
                        </tr>
                            </table>
                        </td>
                   
                        
                    </tr>
                 
                     <tr>
            <td>
                <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                    <tr align="center">
                        <th width="25%">
                            Create Date</th>
                        <th width="25%">
                            Create User</th>
                        <th width="25%">
                            Last Modified Date</th>
                        <th width="25%">
                            Modify User</th>
                    </tr>
                    <tr align="center">
                        <td>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("create_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("create_user") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("modify_date") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("modify_user") %>'></asp:Label>
                        </td>
                    </tr>
                       
                            </table>
                        </td>
                    </tr>
                   
                </table>
            </td>
        </tr>
                </table>
                <br />
                &nbsp;
            </ItemTemplate>
           
        </asp:FormView>
  
        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ConnectionString="name=WoWiEntities" 
        DefaultContainerName="WoWiEntities" EnableFlattening="False" 
            EnableUpdate="False" EntitySetName="contact_info" 
            EntityTypeFilter="contact_info" Where="it.id == @id" >
        <WhereParameters>
         <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </WhereParameters>
        </asp:EntityDataSource>
          </ContentTemplate>
        </asp:UpdatePanel>
    </p>
   
</asp:Content>

