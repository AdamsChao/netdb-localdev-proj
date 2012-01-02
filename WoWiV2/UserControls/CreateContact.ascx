<%@ Control Language="C#" ClassName="CreateContact" %>

<script runat="server">

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

    protected void MyBtnLoad_Click(object sender, EventArgs e)
    {
        FormView fv = this.MyContactCreateFormView1;
        DropDownList list = (DropDownList)fv.FindControl(ContactUtils.Name_DropdownList_RoleList);
        int id = int.Parse(list.SelectedValue);
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
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
            Utils.SetDropDownListValue(fv, "dlCountry", data.country_id+"");
        }
        ContactUtils.InitRoles(id, MyContactCreateFormView1, ContactUtils.Name_CheckBox_RoleList);
    }



    protected void dlContactList_Load(object sender, EventArgs e)
    {

        DropDownList dl = (DropDownList)sender;
        String val = dl.SelectedValue;
        dl.Items.Clear();
        dl.Items.Add(new ListItem("", "0"));
        using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
        {
            var data = db.contact_info;
            foreach (WoWiModel.contact_info contract in data)
            {
                dl.Items.Add(new ListItem(String.Format("{0,10} {1,10} ( {2,20} )", contract.fname, contract.lname, contract.companyname), contract.id + ""));
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
</script>

<asp:FormView ID="MyContactCreateFormView1" runat="server" DataKeyNames="id" SkinID="FormView"
    DataSourceID="MyContactCreateFormEnttityDataSource1" DefaultMode="Insert" 
    oniteminserted="MyContactCreateFormView1_ItemInserted" 
    oniteminserting="MyContactCreateFormView1_ItemInserting" Width="900px">
    <InsertItemTemplate>
        <table align="left" border="0" cellpadding="2" cellspacing="0" 
            style="width:95%">
            <tr>
                <th align="left">
                    <font size="+1">Contact Information Creation&nbsp; </font>
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
                                <asp:TextBox ID="tbTitle" runat="server" Text='<%# Bind("title") %>'></asp:TextBox>
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
                                <asp:TextBox ID="tbCompany" runat="server" Text='<%# Bind("companyname") %>'></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 公司:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcCompany" runat="server" Text='<%# Bind("c_companyname") %>'></asp:TextBox>
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
                                <asp:TextBox ID="tbEmail" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
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
                                    Width="211px"></asp:TextBox>
                            </td>
                            <th align="left" class="style7">
                                &nbsp; 地址:&nbsp;</th>
                            <td width="35%">
                                <asp:TextBox ID="tbcAddress" runat="server" Text='<%# Bind("c_address") %>' 
                                    Width="211px"></asp:TextBox>
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
                                    SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                                </asp:SqlDataSource></td>
                          
                        </tr>
                        <tr>
                            <td align="left" colspan="4">
                                <b>&nbsp; Role: </b>
                            <br />
                            
                                        <asp:CheckBoxList ID="clRoleList" runat="server" AutoPostBack="False" 
                                    DataSourceID="EntityDataSource2" DataTextField="contact_name" DataValueField="contact_id" 
                                    RepeatColumns="4" RepeatDirection="Horizontal">
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

