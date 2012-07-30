<%@ Control Language="C#" ClassName="CreateContact" %>

<script runat="server">
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    public void SetContactList(bool visible)
    {
        HyperLink hl = (HyperLink)MyContactCreateFormView1.FindControl("hlContactList");
        hl.Visible = visible;
    }
   
    protected void MyContactCreateFormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        
    }


    protected void MyContactCreateFormEnttityDataSource1_Inserted(object sender, EntityDataSourceChangedEventArgs e)
    {
        if (e.Exception == null)
        {
            WoWiModel.contact_info obj = (WoWiModel.contact_info)e.Entity;
            if (!obj.department_id.HasValue)
            {
                obj.department_id = -1;
            }
            if (!obj.employee_id.HasValue)
            {
                obj.employee_id = -1;
            }
            if (ViewState["IMA"] != null && ViewState["IMA"] != "-1")
            {
                try
                {
                    WoWiModel.m_ima_contact mcon = new WoWiModel.m_ima_contact()
                            {
                                ima_contact_id = int.Parse(ViewState["IMA"].ToString())
                            };
                    wowidb.m_ima_contact.AddObject(mcon);
                }
                catch (Exception)
                {

                    //throw;
                }
                
            }
            wowidb.SaveChanges();
            List<int> roles = (List<int>)ViewState[ContactUtils.Key_ViewState_Roles];
            if (roles.Count != 0)
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_contact_role;
                    foreach (int i in roles)
                    {
                        var d = new WoWiModel.m_contact_role()
                        {
                            contact_id = obj.id,
                            role_id = i
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
            ViewState.Remove(ContactUtils.Key_ViewState_Roles);
            ViewState[ContactUtils.Key_ViewState_InsertMessage] = ContactUtils.Value_ViewState_InsertMessage;
            int contact_id = obj.id;
            String strId = Request.QueryString["id"];
            if (String.IsNullOrEmpty(strId))
            {
                return;
            }
            int id = int.Parse(strId);
            String type = Request.QueryString["type"];
            String mode = Request.QueryString["mode"];
            bool modeFlag = String.IsNullOrEmpty(mode);
            if (type == "vender")
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_vender_contact;
                    var d = new WoWiModel.m_vender_contact()
                       {
                           vender_id = id,
                           contact_id = contact_id
                       };
                    data.AddObject(d);
                    db.SaveChanges();
                }
                Response.Redirect("~/Admin/VenderDetails.aspx?id=" + id);
            }
            else if (type == "client")
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_clientappliant_contact;
                    var d = new WoWiModel.m_clientappliant_contact()
                    {
                        clientappliant_id = id,
                        contact_id = contact_id
                    };
                    data.AddObject(d);
                    db.SaveChanges();
                }
                Response.Redirect("~/Admin/ClientDetails.aspx?id=" + id);
            }
            else if (type == "applicant")
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                    var data = db.m_clientappliant_contact;
                    var d = new WoWiModel.m_clientappliant_contact()
                    {
                        clientappliant_id = id,
                        contact_id = contact_id
                    };
                    data.AddObject(d);
                    db.SaveChanges();
                }
                Response.Redirect("~/Admin/ApplicantDetails.aspx?id=" + id);
            }
            else
            {
                Response.Redirect("~/Common/CreateContact.aspx");
            }
        }
    }

    protected void MyContactCreateFormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        ContactUtils.StoreRolesInViewState((FormView)sender, ContactUtils.Name_CheckBox_RoleList, ViewState, ContactUtils.Key_ViewState_Roles);
    }

    protected void lbMessage_Load(object sender, EventArgs e)
    {
        Utils.Message_Load((Label)sender, ViewState, ContactUtils.Key_ViewState_InsertMessage);
    }

    protected void MyContactCreateFormEnttityDataSource1_Inserting(object sender, EntityDataSourceChangingEventArgs e)
    {
        WoWiModel.contact_info obj = (WoWiModel.contact_info)e.Entity;
        obj.create_date = DateTime.Now;
        obj.create_user = HttpContext.Current.User.Identity.Name;
    }

    protected void clearAll()
    {
        try
        {
                ViewState["IMA"] = "-1";
                FormView fv = MyContactCreateFormView1;
                Utils.SetTextBoxValue(fv, "tbFirstName", "");
                Utils.SetTextBoxValue(fv, "tbLastName", "");
                Utils.SetTextBoxValue(fv, "tbcLastName", "");
                Utils.SetTextBoxValue(fv, "tbcFirstName", "");
                Utils.SetTextBoxValue(fv, "tbTitle", "");
                Utils.SetTextBoxValue(fv, "tbcTitle", "");
                Utils.SetTextBoxValue(fv, "tbCompany", "");
                Utils.SetTextBoxValue(fv, "tbcCompany", "");
                Utils.SetTextBoxValue(fv, "tbWorkphone", "");
                Utils.SetTextBoxValue(fv, "tbEmail", "");
                Utils.SetTextBoxValue(fv, "tbCellPhone", "");
                Utils.SetTextBoxValue(fv, "tbFax", "");
                Utils.SetTextBoxValue(fv, "tbAddress", "");
                Utils.SetTextBoxValue(fv, "tbcAddress", "");
                try
                {
                    (fv.FindControl("dlCountry") as DropDownList).SelectedIndex = 0;
                }
                catch (Exception)
                {
                    
                    //throw;
                }
                try
                {
                    (fv.FindControl("ddlDeptList") as DropDownList).SelectedValue = "-1";
                    
                }
                catch (Exception)
                {

                    //throw;
                }
                try
                {
                    (fv.FindControl("ddlEmployeeList") as DropDownList).SelectedValue = "-1";
                   
                }
                catch (Exception)
                {

                    //throw;
                } 
                try
                {
                    CheckBoxList list = (CheckBoxList)fv.FindControl(ContactUtils.Name_CheckBox_RoleList);
                    foreach (ListItem item in list.Items)
                    {
                        item.Selected = false;

                    }
                }
                catch (Exception)
                {

                    //throw;
                }
                
        }
        catch (Exception)
        {
            
            //throw;
        }
    }
    
    protected void MyBtnLoad_Click(object sender, EventArgs ea)
    {
        clearAll();
        FormView fv = this.MyContactCreateFormView1;
        DropDownList list = (DropDownList)fv.FindControl(ContactUtils.Name_DropdownList_RoleList);
        int id = int.Parse(list.SelectedValue);
        if (id == -1)
        {
            
            DropDownList list2 = (DropDownList)fv.FindControl(ContactUtils.IMA_Name_DropdownList_RoleList);
            try
            {
                list2.SelectedValue = "-1";
            }
            catch (Exception)
            {

                //throw;
            }
        }
        else
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                FormView FormView1 = MyContactCreateFormView1;
                var data = db.contact_info.Where(c => c.id == id).First();
                Utils.SetTextBoxValue(fv, "tbFirstName", data.fname);
                Utils.SetTextBoxValue(fv, "tbLastName", data.lname);
                Utils.SetTextBoxValue(fv, "tbcLastName", data.c_lname);
                Utils.SetTextBoxValue(fv, "tbcFirstName", data.c_fname);
                Utils.SetTextBoxValue(fv, "tbTitle", data.title);
                Utils.SetTextBoxValue(fv, "tbcTitle", data.c_title);
                Utils.SetTextBoxValue(fv, "tbCompany", data.companyname);
                Utils.SetTextBoxValue(fv, "tbcCompany", data.c_companyname);
                Utils.SetTextBoxValue(fv, "tbWorkphone", data.workphone);
                Utils.SetTextBoxValue(fv, "tbEmail", data.email);
                Utils.SetTextBoxValue(fv, "tbCellPhone", data.cellphone);
                Utils.SetTextBoxValue(fv, "tbFax", data.fax);
                Utils.SetTextBoxValue(fv, "tbAddress", data.address);
                Utils.SetTextBoxValue(fv, "tbcAddress", data.c_address);
                Utils.SetDropDownListValue(fv, "dlCountry", data.country_id + "");
                (FormView1.FindControl("lblDept") as Label).Text = data.department_id.HasValue ? data.department_id + "" : "-1";
                (FormView1.FindControl("lblEmp") as Label).Text = data.employee_id.HasValue ? data.employee_id + "" : "-1";
                int depid = data.department_id.HasValue ? (int)data.department_id : -1;
                try
                {
                    (FormView1.FindControl("ddlDeptList") as DropDownList).SelectedValue = data.department_id.HasValue ? data.department_id + "" : "-1";
                    (FormView1.FindControl("ddlEmployeeList") as DropDownList).SelectedValue = data.employee_id.HasValue ? data.employee_id + "" : "-1";
                    
                }
                catch (Exception)
                {


                }


            }
            ContactUtils.InitRoles(id, MyContactCreateFormView1, ContactUtils.Name_CheckBox_RoleList);
            DropDownList list2 = (DropDownList)fv.FindControl(ContactUtils.IMA_Name_DropdownList_RoleList);
            try
            {
                list2.SelectedValue = "-1";
            }
            catch (Exception)
            {

                //throw;
            }
        }
    }

    protected void MyIMABtnLoad_Click(object sender, EventArgs ea)
    {
        clearAll();
        FormView fv = this.MyContactCreateFormView1;
        try
        {
            (fv.FindControl("ddlDeptList") as DropDownList).SelectedValue =  "-1";
            (fv.FindControl("ddlEmployeeList") as DropDownList).SelectedValue = "-1";
            (MyContactCreateFormView1.FindControl("lblDept") as Label).Text = "-1";
            (MyContactCreateFormView1.FindControl("lblEmp") as Label).Text = "-1";
        }
        catch (Exception)
        {


        }
        DropDownList list = (DropDownList)fv.FindControl(ContactUtils.IMA_Name_DropdownList_RoleList);
        int id = int.Parse(list.SelectedValue);
        if (id != -1)
        {
            ViewState["IMA"] = list.SelectedValue;
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                FormView FormView1 = MyContactCreateFormView1;
                var data = db.Ima_Contact.Where(c => c.ContactID == id).First();
                Utils.SetTextBoxValue(fv, "tbFirstName", data.FirstName);
                Utils.SetTextBoxValue(fv, "tbLastName", data.LastName);
                Utils.SetTextBoxValue(fv, "tbTitle", data.Title);
                Utils.SetTextBoxValue(fv, "tbWorkphone", data.WorkPhone);
                Utils.SetTextBoxValue(fv, "tbEmail", data.Email);
                Utils.SetTextBoxValue(fv, "tbCellPhone", data.CellPhone);
                Utils.SetTextBoxValue(fv, "tbFax", data.Fax);
                Utils.SetTextBoxValue(fv, "tbAddress", data.Adress);
                Utils.SetDropDownListValue(fv, "dlCountry", data.CountryID + "");
            }
        }
       
    }

    protected void dlContactList_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        DropDownList dl = (DropDownList)sender;
        String val = dl.SelectedValue;
        dl.Items.Clear();
        dl.Items.Add(new ListItem("- Select - (Will clear all fields)", "-1"));
        int eid = Utils.GetEmployeeID(HttpContext.Current.User.Identity.Name);
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
            var data = from cc in db.contact_info orderby cc.fname, cc.lname  select cc;
            if (!Utils.isAdmin(eid))
            {
                var data2 = from d in data from a in db.m_employee_accesslevel where a.employee_id == eid && d.department_id == a.accesslevel_id select d;
                foreach (WoWiModel.contact_info contract in data2)
                {
                    dl.Items.Add(new ListItem(String.Format("{0,10} {1,10} ( {2,20} )", contract.fname, contract.lname, contract.companyname), contract.id + ""));
                }
            }
            else
            {
                foreach (WoWiModel.contact_info contract in data)
                {
                    dl.Items.Add(new ListItem(String.Format("{0,10} {1,10} ( {2,20} )", contract.fname, contract.lname, contract.companyname), contract.id + ""));
                }
            }

        }
        //Keep State
        foreach (ListItem item in dl.Items)
        {
            if (item.Value == val)
            {
                item.Selected = true;
                break;
            }
        }
    }

    protected void dlIMAContactList_Load(object sender, EventArgs e)
    {

        DropDownList dl = (DropDownList)sender;
        String val = dl.SelectedValue;
        dl.Items.Clear();
        dl.Items.Add(new ListItem("- Select - (Will clear all fields)", "-1"));
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
            var donelist = from d in db.m_ima_contact select d.ima_contact_id;
            object data = null ;
            if (donelist.Count() == 0)
            {
                data = from c in db.Ima_Contact orderby c.FirstName,c.LastName ascending select c;
            }
            else
            {
                data = from c in db.Ima_Contact where (!donelist.Contains(c.ContactID)) orderby c.FirstName, c.LastName ascending select c;
            }
            foreach (WoWiModel.Ima_Contact contract in (data as IEnumerable))
            {
                dl.Items.Add(new ListItem(String.Format("{0,15} {1,15}", contract.FirstName, contract.LastName), contract.ContactID+ ""));
            }

        }
        //Keep State
        foreach (ListItem item in dl.Items)
        {
            if (item.Value == val)
            {
                item.Selected = true;
                break;
            }
        }
    }
    protected void ddlEmployeeList_Load(object sender, EventArgs ea)
    {

        if (Page.IsPostBack) return;
        var list = EmployeeUtils.GetEmployeeList(wowidb);
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "name";
        (sender as DropDownList).DataValueField = "id";
        //(MyContactCreateFormView1.FindControl("lblDept") as Label).Text = "-1";

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        try
        {
            (MyContactCreateFormView1.FindControl("ddlEmployeeList") as DropDownList).SelectedValue = Utils.GetEmployeeID(HttpContext.Current.User.Identity.Name) + "";
        }
        catch (Exception)
        {

            //throw;
        }
    }

    protected void lblAccessLevel_Load(object sender, EventArgs e)
    {
        String strId = Request.QueryString["id"];
        (sender as Label).Text = "";
        if (String.IsNullOrEmpty(strId))
        {
            return;
        }
        int id = int.Parse(strId);
        String type = Request.QueryString["type"];
        if (type == "vender")
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    int aid = (int)(db.vendors.First(c => c.id == id).department_id);
                    (sender as Label).Text = db.access_level.First(c => c.id == aid).name;
                }
                catch (Exception)
                {

                   
                }
                
            }
           
        }
        else if (type == "client" || type == "applicant")
        {
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                try
                {
                    int aid = (int)(db.clientapplicants.First(c => c.id == id).department_id);
                    (sender as Label).Text = db.access_level.First(c => c.id == aid).name;
                }
                catch (Exception)
                {

                    
                };
            }
            
        }
    }

    protected void ddlDeptList_SelectedIndexChanged(object sender, EventArgs ea)
    {
        try
        {
            DropDownList ddl = sender as DropDownList;
            (MyContactCreateFormView1.FindControl("lblDept") as Label).Text = ddl.SelectedValue;
        }
        catch (Exception)
        {

            (MyContactCreateFormView1.FindControl("lblDept") as Label).Text = "-1";
        }

    }


    protected void ddlEmployeeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DropDownList ddl = sender as DropDownList;
            (MyContactCreateFormView1.FindControl("lblEmp") as Label).Text = ddl.SelectedValue;
        }
        catch (Exception)
        {

            (MyContactCreateFormView1.FindControl("lblEmp") as Label).Text = "-1";
        }
    }
</script>

<asp:FormView ID="MyContactCreateFormView1" runat="server" DataKeyNames="id" SkinID="FormView"
    DataSourceID="MyContactCreateFormEnttityDataSource1" DefaultMode="Insert" 
    oniteminserted="MyContactCreateFormView1_ItemInserted" 
    oniteminserting="MyContactCreateFormView1_ItemInserting" Width="100%" >
    <InsertItemTemplate>
        <table align="left" border="0" cellpadding="2" cellspacing="0" 
            style="width:95%">
            <tr>
                <th align="left">
                    <font size="+1">Contact Information Creation&nbsp;(Access Level = <asp:Label 
                        ID="lblAccessLevel" runat="server"
                        Text="Label" onload="lblAccessLevel_Load"></asp:Label>) </font>
                    <asp:HyperLink ID="hlContactList" runat="server" 
                        NavigateUrl="~/Admin/ContactList.aspx">Contact List</asp:HyperLink>
                    &nbsp;<asp:Label ID="lbMessage" runat="server" ForeColor="Red" 
                        onload="lbMessage_Load"></asp:Label>
                </th>
            </tr>
            <tr>
                <td>
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="left" colspan="4">
                                Load from :
                                <asp:DropDownList ID="dlContactList" runat="server" 
                                    AppendDataBoundItems="False" AutoPostBack="True" onload="dlContactList_Load">
                                </asp:DropDownList>
                                <asp:Button ID="MyBtnLoad" runat="server" onclick="MyBtnLoad_Click" Text="Load" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4">
                                Load from IMA :
                                <asp:DropDownList ID="dlIMAContactList" runat="server" 
                                    AppendDataBoundItems="False" AutoPostBack="True" onload="dlIMAContactList_Load">
                                </asp:DropDownList>
                                <asp:Button ID="Button1" runat="server" onclick="MyIMABtnLoad_Click" Text="Load" />
                            </td>
                        </tr>
                         <tr><th 
                                   align="left" class="style9"><font color="red">*&#160;</font>Access Level:</th><td 
                                   width="30%">
                                            <%--<asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSource2" DataTextField="name" DataValueField="id" 
                                                AppendDataBoundItems="True" SelectedValue='<%# Bind("department_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT * FROM [access_level] where [publish] = 'true'  order by [name]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" onload="ddlEmployeeList_Load" AppendDataBoundItems="true"
                SelectedValue='<%# Bind("employee_id") %>'>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEmp" runat="server" Text=''  CssClass="hidden"></asp:Label>--%>
                                             <asp:DropDownList ID="ddlDeptList" runat="server" AutoPostBack="True" 
                                                DataSourceID="SqlDataSource4" DataTextField="name" DataValueField="id" 
                                                onselectedindexchanged="ddlDeptList_SelectedIndexChanged" AppendDataBoundItems="True"><%--SelectedValue='<%# Bind("department_id") %>'>--%>
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                                ControlToValidate="ddlDeptList" ErrorMessage="Please select access level." 
                                                Font-Bold="True" ForeColor="Red" InitialValue="-1" >*</asp:RequiredFieldValidator><asp:ValidationSummary
                                                  ShowMessageBox="True" ShowSummary="False"  ID="ValidationSummary1" runat="server" />
                                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                                SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name]"></asp:SqlDataSource>
                                            <asp:Label ID="lblDept" runat="server" Text='<%# Bind("department_id") %>' CssClass="hidden"></asp:Label>
                                        </td><th align="left" 
                                   class="style7"><font color="red">*&#160;</font>Created by:</th><td width="30%">
                                            <asp:DropDownList ID="ddlEmployeeList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlEmployeeList_SelectedIndexChanged"
                                                onload="ddlEmployeeList_Load" AppendDataBoundItems="True" > 
                                                <asp:ListItem Value="-1">- Select -</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Label ID="lblEmp" runat="server" Text='<%# Bind("employee_id") %>'  CssClass="hidden"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                                ControlToValidate="ddlEmployeeList" 
                                                ErrorMessage="Please select created by which user." Font-Bold="True" 
                                                ForeColor="Red" InitialValue="-1">*</asp:RequiredFieldValidator>
                                        </td>
                                        </td></tr>
                        <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>First Name:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbFirstName" runat="server" Text='<%# Bind("fname") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 姓:</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcLastName" runat="server" Text='<%# Bind("c_lname") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>Last Name:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbLastName" runat="server" Text='<%# Bind("lname") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 名:&nbsp;&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcFirstName" runat="server" Text='<%# Bind("c_fname") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style2">
                                <font color="red">*&nbsp;</font>Title:&nbsp;</th>
                            <td class="style3" width="35%">
                                <asp:TextBox ID="tbTitle" runat="server" Text='<%# Bind("title") %>' 
                                    MaxLength="50"></asp:TextBox>
                                <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="(Max Length : 50)"></asp:Label>
                            </td>
                            <th align="left" class="style8">
                                &nbsp; 職稱:</th>
                            <td class="style3" width="35%">
                                <asp:TextBox ID="tbcTitle" runat="server" Text='<%# Bind("c_title") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>Company:&nbsp;&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbCompany" runat="server" Text='<%# Bind("companyname") %>' Width="300"></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 公司:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>' Width="300"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>Work Phone:</th>
                            <td width="35%">
                                <asp:TextBox ID="tbWorkphone" runat="server" Text='<%# Bind("workphone") %>'></asp:TextBox>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Ext</strong>:&nbsp;&nbsp;<asp:TextBox ID="tbExt" runat="server" 
                                    Text='<%# Bind("ext") %>' Width="44px"></asp:TextBox>
                                &nbsp;</td>
                            <th align="left" class="style7">
                                <font color="red">*&nbsp;</font>Email:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("email") %>' Width="250"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style9">
                                &nbsp; Cell Phone:</th>
                            <td width="35%">
                                <asp:TextBox ID="tbCellPhone" runat="server" Text='<%# Bind("cellphone") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; Fax:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbFax" runat="server" Text='<%# Bind("fax") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>Address:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbAddress" runat="server" Text='<%# Bind("address") %>' 
                                    Width="360px"></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 地址:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' 
                                    Width="360px"></asp:TextBox>
                            </td>
                        </tr>
                       <%-- <tr>
                            <th align="left" class="style9">
                                <font color="red">*&nbsp;</font>Zip:</th>
                            <td width="35%">
                                <asp:TextBox ID="tbZip" runat="server" Text='<%# Bind("zip") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 郵遞區號:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcZip" runat="server" Text='<%# Bind("c_zip") %>'></asp:TextBox>
                            </td>
                        </tr> --%>
                        <tr> 
                            <th align="left" class="style9">
                                &nbsp; Country:&nbsp;</th>
                            <td  colspan="3">
                                <asp:DropDownList ID="dlCountry" runat="server" 
                                    DataSourceID="SqlDataSource3" DataTextField="country_name" 
                                    DataValueField="country_id" SelectedValue='<%# Bind("country_id") %>'>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [country_id], [country_name] FROM [country] order by country_name">
                                </asp:SqlDataSource></td>
                          
                        </tr>
                        <tr>
                            <td align="left" colspan="4">
                                <b>&nbsp; Title: </b>
                            <br />
                            
                                        <asp:CheckBoxList ID="clRoleList" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField="contact_name" DataValueField="contact_id" 
                                    RepeatColumns="5" RepeatDirection="Horizontal">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT [contact_id], [contact_name] FROM [contact_role] where [publish] = 'true'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="style4">
                    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr align="center">
                            <td>
                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                                    CommandName="Insert" Text="Create" />
                                &nbsp;
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                                    CommandName="Cancel" Text="Cancel" />
                                &nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                <br />
        &nbsp;
    </InsertItemTemplate>
</asp:FormView>
<asp:EntityDataSource ID="MyContactCreateFormEnttityDataSource1" runat="server" 
    ConnectionString="name=WoWiEntities" DefaultContainerName="WoWiEntities" 
    EnableDelete="True" EnableFlattening="False" EnableInsert="True" 
    EnableUpdate="True" EntitySetName="contact_info" 
    EntityTypeFilter="contact_info" oninserted="MyContactCreateFormEnttityDataSource1_Inserted" 
    oninserting="MyContactCreateFormEnttityDataSource1_Inserting">
</asp:EntityDataSource>

