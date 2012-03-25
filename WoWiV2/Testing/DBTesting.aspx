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

        db.SaveChanges();

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="Set Department / Employee ID = -1" />
</asp:Content>

