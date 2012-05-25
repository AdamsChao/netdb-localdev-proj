<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">

    protected void Button1_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.vendors)
        {
            if (!e.department_id.HasValue)
            {
                e.department_id = -1;
            }
            if (!e.employee_id.HasValue)
            {
                e.employee_id = -1;
            }
        }

        foreach (var e in db.clientapplicants)
        {
            if (!e.department_id.HasValue)
            {
                e.department_id = -1;
            }
            if (!e.employee_id.HasValue)
            {
                e.employee_id = -1;
            }
        }

        foreach (var e in db.contact_info)
        {
            if (!e.department_id.HasValue)
            {
                e.department_id = -1;
            }
            if (!e.employee_id.HasValue)
            {
                e.employee_id = -1;
            }
        }

        foreach (var e in db.PRs)
        {
            if (!e.department_id.HasValue)
            {
                e.department_id = -1;
            }
            if (!e.employee_id.HasValue)
            {
                e.employee_id = -1;
            }
        }

        db.SaveChanges();

    }

    protected void Button2_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.vendors)
        {
            e.contract_type = "-1";   
        }
        db.SaveChanges();
    }

    protected void Button3_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.venderbankings)
        {
            if (String.IsNullOrEmpty(e.payment_type))
            {
                e.payment_type = "-1";
            }
        }
        db.SaveChanges();
    }


    protected void Button4_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.vendors)
        {
            e.paymentdays = "-1";
        }
        db.SaveChanges();
    }

    protected void Button5_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.PRs)
        {
            e.payment_term = 0;
        }
        db.SaveChanges();
        foreach (var e in db.PR_Payment)
        {
            e.payment_term = 0;
        }
        db.SaveChanges();
    }

    protected void Button6_Click(object sender, EventArgs ea)
    {
        WoWiModel.WoWiEntities db = new WoWiModel.WoWiEntities();

        foreach (var e in db.clientapplicants)
        {
            e.paymentdays = 0;
            e.clientstatus = (byte)0;
        }
        db.SaveChanges();
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        PRUtils.Mail(new String[]{"ken@netdb.com.tw"}, null, "test", "TEST");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Set Department / Employee ID = -1" />
    <br />
    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
        Text="Vender Authority" />
    <br />
    <asp:Button ID="Button3" runat="server" 
        Text="Bank Payment Type" onclick="Button3_Click" />
    <br />

    <asp:Button ID="Button4" runat="server" 
        Text="Vender Payment Term" onclick="Button4_Click"  />
    <br />

    <asp:Button ID="Button5" runat="server" 
        Text="PR Payment Term" onclick="Button5_Click" />
    <br />
   
   <asp:Button ID="Button6" runat="server" 
        Text="Client Payment days/Status" onclick="Button6_Click"  />
    <br />
    <asp:Button ID="Button7" runat="server" onclick="Button7_Click" 
        Text="Send Email" />
    <br />
    <br />
</asp:Content>

