<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>


<script runat="server">

  
    protected void lbSystemContacts_Load(object sender, EventArgs e)
    {
        
    }

    protected void lbSelectedContacts_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnSelect_Click(object sender, EventArgs e)
    {
        Utils.MoveItems(lbSystemContacts, lbSelectedContacts);
    }

    protected void btnDeselect_Click(object sender, EventArgs e)
    {
        Utils.MoveItems(lbSelectedContacts, lbSystemContacts);
    }


    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        String strId = Request.QueryString["id"];
        String type = Request.QueryString["type"];
        SaveContactsToDB();
        String mode = Request.QueryString["mode"];
        String modeStr = "";
        if (!String.IsNullOrEmpty(mode))
        {
            modeStr = "&mode="+mode;
        }
        Response.Redirect("~/Common/CreateContact.aspx?id=" + strId + "&type=" + type + modeStr);
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        SaveContactsToDB();
        String strId = Request.QueryString["id"];
        String type = Request.QueryString["type"];
        String FinishURL = "~/Admin/ContactDetails.aspx?id=" + strId;
        if (type == "vender")
        {
            FinishURL = "~/Admin/VenderDetails.aspx?id=" + strId;
        }
        else if (type == "client")
        {
            FinishURL = "~/Admin/ClientDetails.aspx?id=" + strId;
        }
        else if (type == "applicant")
        {
            FinishURL = "~/Admin/ApplicantDetails.aspx?id=" + strId;
        }
        Response.Redirect(FinishURL);
    }
    private void SaveContactsToDB()
    {
        if (lbSelectedContacts.Items.Count != 0)
        {
            String strId = Request.QueryString["id"];
            int id = int.Parse(strId);
            String type = Request.QueryString["type"];
            if (type == "vender")
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {
                   
                    var data = db.m_vender_contact;
                    var delList = from d in data where d.vender_id == id select d;
                    foreach (var di in delList)
                    {
                        data.DeleteObject(di);
                    }
                    foreach (ListItem li in lbSelectedContacts.Items)
                    {
                        var d = new WoWiModel.m_vender_contact()
                        {
                            vender_id = id,
                            contact_id = int.Parse(li.Value)
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
            else if (type == "client" || type == "applicant")
            {
                using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                {

                    var data = db.m_clientappliant_contact;
                    var delList = from d in data where d.clientappliant_id == id select d;
                    foreach (var di in delList)
                    {
                        data.DeleteObject(di);
                    }
                    foreach (ListItem li in lbSelectedContacts.Items)
                    {
                        var d = new WoWiModel.m_clientappliant_contact()
                        {
                            clientappliant_id = id,
                            contact_id = int.Parse(li.Value)
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


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            ListBox lb = lbSystemContacts;
            String strId = Request.QueryString["id"];
            int id = int.Parse(strId);
            String type = Request.QueryString["type"];
            String mode = Request.QueryString["mode"];
            using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
            {
                dynamic list  = null;
                if (type != null && type == "vender")
                {
                    try
                    {
                        int vaid = (int)db.vendors.First(c => c.id == id).department_id;
                        int eid = Utils.GetEmployeeID();
                        var data = from a in db.m_employee_accesslevel where a.employee_id == eid && a.accesslevel_id == vaid select a;
                        if (data.Count() != 0)
                        {
                            list = db.contact_info.Where(c => c.department_id == vaid);
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }


                }
                else if (type != null && (type == "client" || type == "applicant"))
                {
                    try
                    {
                        int vaid = (int)db.clientapplicants.First(c => c.id == id).department_id;
                        int eid = Utils.GetEmployeeID();
                        var data = from a in db.m_employee_accesslevel where a.employee_id == eid && a.accesslevel_id == vaid select a;
                        if (data.Count() != 0)
                        {
                            list = db.contact_info.Where(c => c.department_id == vaid);
                        }
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                }
                else
                {
                    list = db.contact_info;
                }
                if (list != null)
                {
                    foreach (WoWiModel.contact_info con in list)
                    {
                        String fname = con.c_fname;
                        String lname = con.c_lname;
                        bool flag = true;
                        if (String.IsNullOrEmpty(fname))
                        {
                            fname = con.fname;
                            flag = false;
                        }
                        if (String.IsNullOrEmpty(lname))
                        {
                            lname = con.lname;
                        }
                        String fullname;
                        if (flag)
                        {
                            fullname = lname + " " + fname;
                        }
                        else
                        {
                            fullname = fname + " " + lname;
                        }

                        String companyName = con.companyname;
                        if (String.IsNullOrEmpty(companyName))
                        {
                            fullname += " - " + con.c_companyname;
                        }
                        else
                        {
                            fullname += " - " + companyName;
                        }

                        try
                        {
                            int aid = (int)con.department_id;
                            fullname += "( Access Level = " + db.access_level.First(c => c.id == aid).name + ") ";
                        }
                        catch (Exception)
                        {

                            //throw;
                        }
                        var item = new ListItem(String.Format("{0}", fullname), con.id + "");
                        if (lbSelectedContacts.Items.Contains(item) == false)
                        {
                            lb.Items.Add(item);
                        }
                    }
                }

            }
           

            if (type != null && type == "vender")
            {
                if (mode != null && mode == "update")
                {
                    using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                    {
                        var data = db.m_vender_contact;
                        var list = from c in data where c.vender_id == id select c.contact_id;
                        foreach (var i in list)
                        {
                            var con = (from k in db.contact_info where k.id == i select k).First();
                            String fname = con.c_fname;
                            String lname = con.c_lname;
                            bool flag = true;
                            if (String.IsNullOrEmpty(fname))
                            {
                                fname = con.fname;
                                flag = false;
                            }
                            if (String.IsNullOrEmpty(lname))
                            {
                                lname = con.lname;
                            }
                            String fullname;
                            if (flag)
                            {
                                fullname = lname + " " + fname;
                            }
                            else
                            {
                                fullname = fname + " " + lname;
                            }
                            String companyName = con.companyname;
                            if (String.IsNullOrEmpty(companyName))
                            {
                                fullname += " - " + con.c_companyname;
                            }
                            else
                            {
                                fullname += " - " + companyName;
                            }
                            try
                            {
                                int aid = (int)con.department_id;
                                fullname += "( Access Level = " + db.access_level.First(c => c.id == aid).name + ")";
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                            var item = new ListItem(String.Format("{0}", fullname), con.id + "");
                            try
                            {
                                lbSelectedContacts.Items.Add(item);
                                //lbSystemContacts.Items.Remove(item);
                                removeItem(item.Value);
                            }
                            catch (Exception)
                            {
                                
                                //throw;
                            }
                           
                        }
                    }
                }
            }
            else if (type != null && (type == "client" || type == "applicant"))
            {
                if (mode != null && mode == "update")
                {
                    using (WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities())
                    {
                        var data = db.m_clientappliant_contact;
                        var list = from c in data where c.clientappliant_id == id select c.contact_id;
                        foreach (var i in list)
                        {
                            var con = (from k in db.contact_info where k.id == i select k).First();
                            String fname = con.c_fname;
                            String lname = con.c_lname;
                            bool flag = true;
                            if (String.IsNullOrEmpty(fname))
                            {
                                fname = con.fname;
                                flag = false;
                            }
                            if (String.IsNullOrEmpty(lname))
                            {
                                lname = con.lname;
                            }
                            String fullname;
                            if (flag)
                            {
                                fullname = lname + " " + fname;
                            }
                            else
                            {
                                fullname = fname + " " + lname;
                            }
                            String companyName = con.companyname;
                            if (String.IsNullOrEmpty(companyName))
                            {
                                fullname += " - " + con.c_companyname;
                            }
                            else
                            {
                                fullname += " - " + companyName;
                            }
                            try
                            {
                                int aid = (int)con.department_id;
                                fullname += "( Access Level = " + db.access_level.First(c => c.id == aid).name + " )";
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                            var item = new ListItem(String.Format("{0}", fullname), con.id + "");
                            try
                            {
                                lbSelectedContacts.Items.Add(item);
                                //lbSystemContacts.Items.Remove(item);
                                removeItem(item.Value);
                            }
                            catch (Exception)
                            {

                                //throw;
                            }
                        }
                    }
                }
            }
        }
    }

    private void removeItem(String id)
    {
        try
        {
            for (int i = lbSystemContacts.Items.Count -1; i >=0; i--)
            {
                if (lbSystemContacts.Items[i].Value == id)
                {
                    lbSystemContacts.Items.RemoveAt(i);
                }
            }
        }
        catch (Exception)
        {
            
            //sthrow;
        }
    }
    protected void Label1_Load(object sender, EventArgs e)
    {
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
                try
                {
                    int aid = (int)(db.vendors.First(c => c.id == id).department_id);
                    (sender as Label).Text = db.access_level.First(c => c.id == aid).name;
                }
                catch (Exception)
                {

                    (sender as Label).Text = "Not set yet.";
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

                    (sender as Label).Text = "Not set yet.";
                };
            }

        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">

        
        .style15
        {
            width: 25%;
        }
        .style17
        {
            width: 5%;
        }
        .style18
        {
            width: 25%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table align="left" border="0" cellpadding="2" cellspacing="0"  style="width:100%;hight:400px">
                    <tr>
                        <td class="style15">
                            Selected : ( Access Level =
                            <asp:Label ID="Label1" runat="server" onload="Label1_Load" Text="Label"></asp:Label>
                            &nbsp;)</td>
                        <td class="style17">
                            </td>
                        <td class="style83">
                            Existing : </td>
                    </tr>
                    <tr>
                        <td class="style15">
                            <asp:ListBox ID="lbSelectedContacts" runat="server" Height="202px" 
                                Width="100%" SelectionMode="Multiple" onload="lbSelectedContacts_Load" ></asp:ListBox>
                        </td>
                        <td align="center" class="style17">
                            <br />
                            <asp:Button ID="btnSelect" runat="server" Text=" &lt; &lt; " 
                                onclick="btnSelect_Click" />
                            <br />
                            <br />
                            <asp:Button ID="btnDeselect" runat="server" Text=" &gt; &gt; " 
                                onclick="btnDeselect_Click" />
                        </td>
                        <td class="style18">
                            &nbsp;&nbsp;<asp:ListBox ID="lbSystemContacts" runat="server" Height="202px" 
                                Width="100%" onload="lbSystemContacts_Load" SelectionMode="Multiple"></asp:ListBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td align="center"  colspan="3">
                           
                            <asp:Button ID="btnFinish" runat="server" Text="Finish" 
                                onclick="btnFinish_Click" />
&nbsp;
                            <asp:Button ID="btnAddNew" runat="server" onclick="btnAddNew_Click" 
                                Text="Add New Contact" />
                           
                            </td>
                    </tr>
                </table>
                 </ContentTemplate>
        </asp:UpdatePanel>

</asp:Content>

