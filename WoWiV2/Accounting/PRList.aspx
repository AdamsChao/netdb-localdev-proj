<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<script runat="server">
  QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
  WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

  protected void GridView1_PreRender(object sender, EventArgs e)
  {
    foreach (GridViewRow row in GridView1.Rows)
    {

      String projIDStr = row.Cells[2].Text;
      try
      {
        int pid = int.Parse(projIDStr);
        row.Cells[2].Text = (from p in db.Project where p.Project_Id == pid select p.Project_No).First();
      }
      catch (Exception)
      {

        //throw;
      }
      String venderIDStr = row.Cells[5].Text;
      if (venderIDStr == "-1")
      {
        row.Cells[5].Text = "Not set yet";
      }
      else
      {
        try
        {
          int vid = int.Parse(venderIDStr);
          var vender = (from v in wowidb.vendors where v.id == vid select v).First();
          row.Cells[5].Text = String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name;
        }
        catch (Exception)
        {

          //throw;
        }
      }
      if (row.Cells[6].Text.Trim() != "&nbsp;")
      {
        row.Cells[6].Text = row.Cells[6].Text + "$";
      }
      String quoIDStr = row.Cells[3].Text;
      try
      {

        if (quoIDStr == "-1")
        {
          row.Cells[3].Text = "Not set yet";
        }
        else
        {
          int qid = int.Parse(quoIDStr);
          row.Cells[3].Text = (from q in db.Quotation_Version where q.Quotation_Version_Id == qid select q.Quotation_No).First();
        }
      }
      catch (Exception)
      {


      }

      String Str = row.Cells[10].Text;
      try
      {
        byte status = byte.Parse(Str);
        row.Cells[10].Text = PRUtils.statusByteToString(status);

      }
      catch (Exception)
      {

        //throw;
      }

      Str = row.Cells[12].Text;
      try
      {
        if (Str == "-1")
        {
          row.Cells[12].Text = "Not set yet";
        }
        else
        {
          int aid = int.Parse(Str);
          row.Cells[12].Text = (from p in wowidb.access_level where p.id == aid select p.name).First();
        }
      }
      catch (Exception)
      {

        //throw;
      }

      Str = row.Cells[13].Text;
      try
      {
        if (Str == "-1")
        {
          row.Cells[13].Text = "Not set yet";
        }
        else
        {
          int aid = int.Parse(Str);
          var emp = (from p in wowidb.employees where p.id == aid select p).First();
          row.Cells[13].Text = emp.fname + " " + emp.lname;
        }
      }
      catch (Exception)
      {

        //throw;
      }
    }
  }

  protected void DropDownList1_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    Utils.ProjectDropDownList_Load(sender, e);
  }

  protected void ddlVenderList_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    PRUtils.ddlVenderList_Load(sender, e, "- All -");
    (sender as DropDownList).DataBind();
  }



  protected void Page_Load(object sender, EventArgs e)
  {
    String newCriteria = "";
    int eid = Utils.GetEmployeeID(User.Identity.Name);
    if (!Utils.isAdmin(eid))
    {
      newCriteria += " and P.department_id in (Select accesslevel_id from m_employee_accesslevel where employee_id =" + eid + ")";
      lblaccesslevel.Visible = false;
      ddlAccessLevel.Visible = false;
    }
    else
    {
      lblaccesslevel.Visible = true;
      ddlAccessLevel.Visible = true;
      if (ddlAccessLevel.SelectedValue != "-1")
      {
        newCriteria += " and P.department_id  = " + ddlAccessLevel.SelectedValue;

      }
    }
    if (ddlProjectNo.SelectedValue != "-1")
    {

      try
      {
        int id = wowidb.Projects.First(c => c.Project_No == ddlProjectNo.SelectedValue).Project_Id;
        newCriteria += " and P.project_id = " + id;
      }
      catch (Exception)
      {

        //throw;
      }
    }

    if (ddlVenderList.SelectedValue != "-1")
    {
      newCriteria += " and P.vendor_id = " + ddlVenderList.SelectedValue;
    }

    if (ddlStatus.SelectedValue != "-1")
    {
      newCriteria += " and R.status = " + ddlStatus.SelectedValue;
    }

    SqlDataSourceClient.SelectCommand += newCriteria + " Order by P.pr_id desc";
    GridView1.DataBind();
    if (GridView1.Rows.Count == 0)
    {

      lblMsg.Visible = true;

    }
    else
    {

      lblMsg.Visible = false;
    }
  }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  PR Lists<br>
  Project :
  <asp:DropDownList ID="ddlProjectNo" runat="server" AppendDataBoundItems="True" OnLoad="DropDownList1_Load">
    <asp:ListItem Value="-1">- All -</asp:ListItem>
  </asp:DropDownList>
  &nbsp;<br>
  Vender :
  <asp:DropDownList ID="ddlVenderList" runat="server" AppendDataBoundItems="True" OnLoad="ddlVenderList_Load">
    <asp:ListItem Value="-1">- All -</asp:ListItem>
  </asp:DropDownList>
  &nbsp;<br>
  Status :
  <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="True">
    <asp:ListItem Value="-1">- All -</asp:ListItem>
    <asp:ListItem Value="0">Init</asp:ListItem>
    <asp:ListItem Value="1">Requisitioner</asp:ListItem>
    <asp:ListItem Value="2">Supervisor</asp:ListItem>
    <asp:ListItem Value="3">VicePresident</asp:ListItem>
    <asp:ListItem Value="4">President</asp:ListItem>
    <asp:ListItem Value="5">Cancel</asp:ListItem>
    <asp:ListItem Value="6">PR Approved</asp:ListItem>
  </asp:DropDownList>
  <asp:Label ID="lblaccesslevel" runat="server" Text="Access Level :"></asp:Label>
  &nbsp;<asp:DropDownList ID="ddlAccessLevel" runat="server" AppendDataBoundItems="True"
    DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id">
    <asp:ListItem Value="-1">- All -</asp:ListItem>
  </asp:DropDownList>
  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT [id], [name] FROM [access_level] WHERE [publish] = 'true' order by [name] ">
  </asp:SqlDataSource>
  &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" /><br>
  <asp:Button ID="Button1" runat="server" Text="Create" PostBackUrl="~/Accounting/CreatePR.aspx" /><br>
  <asp:Label ID="lblMsg" runat="server" Text="No match data found."></asp:Label>
  <p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" SkinID="GridView"
      Width="100%" PageSize="50" DataKeyNames="pr_id" DataSourceID="SqlDataSourceClient"
      AllowPaging="True" AllowSorting="True" OnPreRender="GridView1_PreRender">
      <Columns>
        <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
          <EditItemTemplate>
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
          </EditItemTemplate>
          <ItemTemplate>
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Bind("pr_id","~/Accounting/UpdatePR.aspx?id={0}") %>'>Edit</asp:HyperLink>
            &nbsp;
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Bind("pr_id","~/Accounting/PRDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="pr_id" HeaderText="PR No" SortExpression="pr_id" ReadOnly="True" />
        <asp:BoundField DataField="project_id" HeaderText="Project Id" SortExpression="project_id"
          ReadOnly="True" />
        <asp:BoundField DataField="quotaion_id" HeaderText="Quotation No" SortExpression="quotaion_id" />
        <asp:BoundField DataField="model" HeaderText="Model No." SortExpression="model" />
        <asp:BoundField DataField="vendor_id" HeaderText="Vender" SortExpression="vendor_id" />
        <asp:BoundField DataField="currency" HeaderText="Currency" ItemStyle-HorizontalAlign="Right"
          SortExpression="currency" />
        <asp:BoundField DataField="total_cost" HeaderText="Total Cost" ItemStyle-HorizontalAlign="Right"
          SortExpression="total_cost" DataFormatString="{0:F2}" />
        <asp:BoundField DataField="create_date" HeaderText="Creation Date" SortExpression="create_date"
          DataFormatString="{0:yyyy/MM/dd}" />
        <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date"
          SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
        <asp:BoundField DataField="pr_auth_id" HeaderText="Status" SortExpression="pr_auth_id" />
        <asp:BoundField DataField="status_date" HeaderText="Status Date" SortExpression="status_date"
          DataFormatString="{0:yyyy/MM/dd}" />
        <asp:BoundField DataField="department_Id" HeaderText="Access Level" SortExpression="department_Id" />
        <asp:BoundField DataField="employee_Id" HeaderText="Created By" SortExpression="employee_Id" />
      </Columns>
    </asp:GridView>
  </p>
  <p>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      SelectCommand="
SELECT P.currency, P.pr_id, P.project_id, P.quotaion_id,
(select model_no from quotation_version where quotation_version.Quotation_Version_Id = quotaion_id) as model ,
P.vendor_id, P.total_cost,P.create_date,P.target_payment_date,R.status AS pr_auth_id , (CASE R.status WHEN 0 THEN R.create_date WHEN 1 THEN  R.requisitioner_date WHEN 2 THEN supervisor_date WHEN 3 THEN  R.vp_date WHEN 4 THEN  R.president_date WHEN 5 THEN R.modify_date  WHEN 6 THEN R.modify_date END) as status_date, P.department_id,P.employee_id 
FROM PR AS P , PR_authority_history AS R 
WHERE P.pr_auth_id = R.pr_auth_id "></asp:SqlDataSource>
  </p>
</asp:Content>
