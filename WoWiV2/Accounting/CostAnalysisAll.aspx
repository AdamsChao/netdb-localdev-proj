<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControls/DateChooser.ascx" TagName="DateChooser" TagPrefix="uc1" %>
<%@ Register Assembly="iServerControls" Namespace="iControls.Web" TagPrefix="cc1" %>
<script runat="server">

  QuotationModel.QuotationEntities db = null;
  WoWiModel.WoWiEntities wowidb = null;

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!Page.IsPostBack)
    {
      db = new QuotationModel.QuotationEntities();
      wowidb = new WoWiModel.WoWiEntities();
      SetMergedHerderColumns(iGridViewCost);      
    }
  }
  private void SetMergedHerderColumns(iRowSpanGridView iGridView1)
  {
    iGridViewCost.AddMergedColumns("Status", 8, 2);
    iGridViewCost.AddMergedColumns("Invoice", 15, 3);
    iGridViewCost.AddMergedColumns("PR", 20, 6);
  }

  protected void btnExport_Click(object sender, EventArgs e)
  {
    Utils.ExportExcel(iGridViewCost, "CostAnalysis");
  }

  public override void VerifyRenderingInServerForm(Control control)
  {

  }

  protected void ddlSales_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    var sales = (from p in wowidb.Projects                
                from q in wowidb.Quotation_Version
                from s in wowidb.employees                
                where p.Quotation_No == q.Quotation_No && s.id == q.SalesId
                orderby s.fname, s.c_fname
                select new { Id = s.id, Name = s.fname + " " + s.lname }).Distinct();
    (sender as DropDownList).DataSource = sales;
    (sender as DropDownList).DataTextField = "Name";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }

  protected void ddlCM_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    var sales = (from s in wowidb.employees
                from d in wowidb.Quotation_Target
                where d.Country_Manager == s.id
                orderby s.fname, s.c_fname
                select new { Id = s.id, Name = s.fname + " " + s.lname }).Distinct();
    (sender as DropDownList).DataSource = sales;
    (sender as DropDownList).DataTextField = "Name";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }

  protected void ddlProj_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    Utils.CostAnalysisProjectDDL_Load(sender, e);
  }


  protected void ddlClient_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    var clients = (from p in wowidb.Projects                
                  from q in wowidb.Quotation_Version
                  from c in wowidb.clientapplicants
                  where p.Quotation_No == q.Quotation_No && c.id == q.Client_Id
                  orderby c.companyname, c.c_companyname 
                  select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname })
                  .Distinct().OrderBy(c=>c.Name);
    (sender as DropDownList).DataSource = clients;
    (sender as DropDownList).DataTextField = "Name";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }

  protected void ddlCountry_Load(object sender, EventArgs e)
  {
    if (Page.IsPostBack) return;
    (sender as DropDownList).DataSource = GetTargetList();
    (sender as DropDownList).DataTextField = "Text";
    (sender as DropDownList).DataValueField = "Id";
    (sender as DropDownList).DataBind();
  }

  public List<Display> GetTargetList()
  {
    List<Display> list = new List<Display>();
    var tlist = (from c in wowidb.Quotation_Target select c.target_description).Distinct().OrderBy(c => c);
    foreach (var t in tlist)
    {
      Display dis = new Display();
      try
      {
        var country_id = wowidb.Quotation_Target.First(c => c.target_description == t).country_id;
        var cName = wowidb.countries.First(c => c.country_id == country_id).country_name;
        dis.Text = t + " - [ " + cName + " ]";
        dis.Id = t;
        list.Add(dis);
      }
      catch (Exception)
      {

        throw;
      }

    }
    return list;
  }


  protected void iGridViewCost_PreRender(object sender, EventArgs e)
  {
    RowSpanHandeler(0);
  }


  private void RowSpanHandeler(int idx)
  {
    int i = 1;
    int AlternatingRowStyle_i = 0;
    int AlternatingRowStyle_j = 0;
    int[] indexs = { 0 , 2, 4, 5 };
    //Get all rows
    foreach (GridViewRow wkItem in iGridViewCost.Rows)
    {

      AlternatingRowStyle_j += 1;
      if (idx > -1)
      {

        if (wkItem.RowIndex == 0)
        {
          wkItem.Cells[idx].RowSpan = 1;
          foreach (var j in indexs)
          {
            wkItem.Cells[j].RowSpan = 1;
          }

        }
        else
        {
          TableCell t1 = (wkItem.Cells[idx]);
          TableCell t2 = iGridViewCost.Rows[wkItem.RowIndex - i].Cells[idx];
          bool flag = false;
          if (t1.Controls.Count == 0)//Label
          {
            flag = t1.Text.Trim() == t2.Text.Trim();

          }


          if (flag)
          {
            //rowspan
            foreach (var j in indexs)
            {
              iGridViewCost.Rows[wkItem.RowIndex - i].Cells[j].RowSpan += 1;
              wkItem.Cells[j].Visible = false;
            }
            i = i + 1;

          }
          else
          {

            AlternatingRowStyle_i += 1;

            foreach (var j in indexs)
            {
              iGridViewCost.Rows[wkItem.RowIndex].Cells[j].RowSpan = 1;
            }

            i = 1;

          }
        }
      }
    }
  }

  protected void iGridViewCost_RowDataBound(object sender, GridViewRowEventArgs e)
  {
    if (e.Row.RowType == DataControlRowType.DataRow)
    {
      if (((Label)e.Row.FindControl("LabelTargetID")).Text == "-1"
        || e.Row.Cells[0].Text == "PROJECT TOTAL")
      {
        e.Row.BackColor = System.Drawing.Color.LightSteelBlue;
        e.Row.Cells[10].BackColor = System.Drawing.Color.Orange;
        e.Row.Cells[13].BackColor = System.Drawing.Color.Orange;
        e.Row.Cells[14].BackColor = System.Drawing.Color.Yellow;
        e.Row.Cells[15].BackColor = System.Drawing.Color.Orange;
        e.Row.Cells[23].BackColor = System.Drawing.Color.Orange;
      }
      if (((Label)e.Row.FindControl("LabelTargetID")).Text == "-1")
      {
        e.Row.BackColor = System.Drawing.Color.LightBlue;
        e.Row.Cells[0].Text = "SUB TOTAL";
        e.Row.Visible = false;
      }
    }
  }


  protected void btnSearch_Click(object sender, EventArgs e)
  {

  }


  protected void SqlDataSourceSP_Selected(object sender, SqlDataSourceStatusEventArgs e)
  {
    if (e.Exception != null)
    {
      lblMsg.Text = e.Exception.Message;
      e.ExceptionHandled = true;    
    }
    else
    {
      if (e.AffectedRows > 0)
      {
        btnExport.Enabled = true;
      }
      else
      {
        btnExport.Enabled = false;
        lblMsg.Text = "No matched data found.";
      }
    }   
  }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
  <p>
    Project Cost Analysis</p>
  <p>
    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%" style="background-color:White;"  >
      <tr>
        <th align="left">
          AE :&nbsp;
        </th>
        <td>
          <asp:DropDownList ID="ddlSales" runat="server" AppendDataBoundItems="True" OnLoad="ddlSales_Load">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
        </td>
        <th align="left">
          Country Manager
        </th>
        <td>
          <asp:DropDownList ID="ddlCM" runat="server" AppendDataBoundItems="True" OnLoad="ddlCM_Load">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <th align="left" >
          Project No. :&nbsp;
        </th>
        <td colspan="3">
          <asp:DropDownList ID="ddlProj" runat="server" AppendDataBoundItems="True" OnLoad="ddlProj_Load">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <th align="left">
          Client :&nbsp;
        </th>
        <td colspan="3">
          <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" OnLoad="ddlClient_Load">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <th align="left" >
          Open Project Date From :
        </th>
        <td>
          <asp:TextBox ID="dcProjFrom" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcProjFrom_CalendarExtender" runat="server" Format="yyyy/MM/dd"
            Enabled="True" TargetControlID="dcProjFrom">
          </asp:CalendarExtender>
        </td>
        <th align="left" >
          To :&nbsp;
        </th>
        <td>
          <asp:TextBox ID="dcProjTo" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcProjTo_CalendarExtender" runat="server" Format="yyyy/MM/dd"
            Enabled="True" TargetControlID="dcProjTo">
          </asp:CalendarExtender>
        </td>
      </tr>
      <tr>
        <th align="left" >
          Target :&nbsp;
        </th>
        <td colspan="3">
          <asp:DropDownList ID="ddlCountry" runat="server" AppendDataBoundItems="True" OnLoad="ddlCountry_Load">
            <asp:ListItem Value="%">- All -</asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <%--<tr>
        <th align="left" width="13%">
          Issue Invoice Date From :
        </th>
        <td width="20%">          
          <asp:TextBox ID="dcInvoiceFrom" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcInvoiceFrom_CalendarExtender" runat="server" Format="yyyy/MM/dd"
              Enabled="True" TargetControlID="dcInvoiceFrom">
          </asp:CalendarExtender>
        </td>
        <th align="left" width="13%">
          To :&nbsp;
        </th>
        <td width="20%">
          <asp:TextBox ID="dcInvoiceTo" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcInvoiceTo_CalendarExtender" runat="server" Format="yyyy/MM/dd"
              Enabled="True" TargetControlID="dcInvoiceTo">
          </asp:CalendarExtender>
        </td>
      </tr>--%>
      <tr>
        <th align="left" >
          Status :&nbsp;
        </th>
        <td colspan="3">
          <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True">
            <asp:ListItem Value="%">- All -</asp:ListItem>
            <asp:ListItem Value="Open">新開案的案子(Open)</asp:ListItem>
            <asp:ListItem Value="In-Progress">申請中的案子(In-Progress)</asp:ListItem>
            <asp:ListItem Value="On-Hold">暫停的案子(On-Hold)</asp:ListItem>
            <asp:ListItem Value="Done">完成的案子(Done)</asp:ListItem>
            <asp:ListItem Value="Cancelled">取消的案子(Cancelled)</asp:ListItem>
            <asp:ListItem Value="Delay">逾時案件(Delay)</asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <th align="left" >
          Status Date From :
        </th>
        <td >
          <asp:TextBox ID="dcStatusFromDate" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcStatusFromDate_CalendarExtender" runat="server" Format="yyyy/MM/dd"
            Enabled="True" TargetControlID="dcStatusFromDate">
          </asp:CalendarExtender>
        </td>
        <th align="left" >
          To :&nbsp;
        </th>
        <td >
          <asp:TextBox ID="dcStatusToDate" runat="server"></asp:TextBox>
          <asp:CalendarExtender ID="dcStatusToDate_CalendarExtender" runat="server" Format="yyyy/MM/dd"
            Enabled="True" TargetControlID="dcStatusToDate">
          </asp:CalendarExtender>
        </td>
      </tr>
      <tr>
        <th align="left" >
          <%-- <asp:TextBox ID="tbkey" runat="server" Text="" 
                                    ></asp:TextBox>--%>
        </th>
        <td align="right" >
          <%-- <asp:TextBox ID="tbkey" runat="server" Text="" 
                                    ></asp:TextBox>--%>
          <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" />
        </td>
        <td align="right" colspan="2">
          <asp:Button ID="btnExport" runat="server" Enabled="False" OnClick="btnExport_Click"
            Text="Excel" />
        </td>
      </tr>
      <tr>
        <td colspan="4">
        <asp:Label ID="lblMsg" runat="server" EnableViewState="false"></asp:Label>
          <cc1:iRowSpanGridView ID="iGridViewCost" runat="server" isMergedHeader="True" Width="100%"
            CssClass="Gridview" AutoGenerateColumns="False" DataSourceID="SqlDataSourceSP"
            SkipColNum="0" OnPreRender="iGridViewCost_PreRender" OnRowDataBound="iGridViewCost_RowDataBound">
            <Columns>
              <asp:BoundField DataField="ProjectNo" HeaderText="Project No" ReadOnly="True" SortExpression="ProjectNo" />
              <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" ReadOnly="True" SortExpression="QutationNo" />
              <asp:BoundField DataField="OpenDate" HeaderText="Open Date" DataFormatString="{0:d}" />
              <asp:BoundField DataField="ClientID" HeaderText="ClientID" SortExpression="ClientID"
                Visible="False" />
              <asp:BoundField DataField="Client" HeaderText="Client" ReadOnly="True" SortExpression="Client" />
              <asp:BoundField DataField="Model" HeaderText="Model" SortExpression="Model" />
              <asp:TemplateField HeaderText="TargetID" SortExpression="TargetID" Visible="False">
                <ItemTemplate>
                  <asp:Label ID="LabelTargetID" runat="server" Text='<%# Bind("TargetID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                  <asp:Label ID="LabelTargetID" runat="server" Text='<%# Eval("TargetID") %>'></asp:Label>
                </EditItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="Target" HeaderText="Target" SortExpression="Target" />
              <asp:BoundField DataField="Status" HeaderText="Status" />
              <asp:BoundField DataField="StatusDate" HeaderText="Status Date" DataFormatString="{0:d}" />
              <asp:BoundField DataField="GrossProfitUS" HeaderText="Gross Profit US" ReadOnly="True" />
              <asp:BoundField DataField="AE_ID" HeaderText="AE_ID" SortExpression="AE_ID" Visible="False" />
              <asp:BoundField DataField="AE" HeaderText="AE" ReadOnly="True" SortExpression="AE" />
              <asp:BoundField DataField="Quote" HeaderText="Quote" />
              <asp:BoundField DataField="Discount" HeaderText="Discount" />
              <asp:BoundField DataField="InvUSD" HeaderText="Inv USD" />
              <asp:BoundField DataField="InvDate" HeaderText="Inv Date" 
                DataFormatString="{0:d}" HtmlEncode="False" />
              <asp:BoundField DataField="InvNo" HeaderText="Inv No" HtmlEncode="False" />
              <asp:BoundField DataField="IMAID" HeaderText="IMAID" ReadOnly="True" SortExpression="IMAID"
                Visible="False" />
              <asp:BoundField DataField="CM" HeaderText="CM" />
              <asp:BoundField DataField="IMA" HeaderText="IMA" ReadOnly="True" SortExpression="IMA"
                HtmlEncode="False" Visible="False" />
              <asp:BoundField DataField="VenderName" HeaderText="Vender Name" ReadOnly="True" HtmlEncode="False" />
              <asp:BoundField DataField="IMACostCurrency" HeaderText="Currency" ReadOnly="True"
                HtmlEncode="False" />
              <asp:BoundField DataField="IMACost" HeaderText="Cost$" />
              <asp:BoundField DataField="PaymentDate" HeaderText="Pay Date" ReadOnly="True" DataFormatString="{0:d}"
                HtmlEncode="False" />
              <asp:BoundField DataField="PRNO" HeaderText="PR" ReadOnly="True" HtmlEncode="False" />
            </Columns>
          </cc1:iRowSpanGridView>
        </td>
      </tr>
    </table>
  </p>
  
  <asp:SqlDataSource ID="SqlDataSourceCost" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="SELECT * FROM [vw_CostAnalysis]" SelectCommandType="StoredProcedure">
  </asp:SqlDataSource>
  <asp:SqlDataSource ID="SqlDataSourceSP" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
    SelectCommand="sp_CostAnalysis_All" SelectCommandType="StoredProcedure" OnSelected="SqlDataSourceSP_Selected">
    <SelectParameters>
      <asp:ControlParameter ControlID="ddlProj" DefaultValue="%" Name="ProjectNo" PropertyName="SelectedValue"
        Type="String" />
      <asp:ControlParameter ControlID="ddlCountry" DefaultValue="%" Name="target_description"
        PropertyName="SelectedValue" Type="String" />
      <asp:ControlParameter ControlID="ddlClient" DefaultValue="%" Name="Client_Id" PropertyName="SelectedValue"
        Type="String" />
      <asp:ControlParameter ControlID="DropDownList3" DefaultValue="%" Name="Status" PropertyName="SelectedValue"
        Type="String" />
      <asp:ControlParameter ControlID="ddlSales" DefaultValue="%" Name="AE" PropertyName="SelectedValue"
        Type="String" />
      <asp:ControlParameter ControlID="ddlCM" DefaultValue="%" Name="CM" 
        PropertyName="SelectedValue" Type="String" />
      <asp:ControlParameter ControlID="dcProjFrom" DefaultValue="2010/1/1" Name="ProjectDateFrom"
        PropertyName="Text" Type="String" />
      <asp:ControlParameter ControlID="dcProjTo" DefaultValue="2020/1/1" Name="ProjectDateTo"
        PropertyName="Text" Type="String" />
      <asp:ControlParameter ControlID="dcStatusFromDate" DefaultValue="2010/1/1" Name="StatusFromDate"
        PropertyName="Text" Type="String" />
      <asp:ControlParameter ControlID="dcStatusToDate" DefaultValue="2020/1/1" Name="StatusToDate"
        PropertyName="Text" Type="String" />
    </SelectParameters>
  </asp:SqlDataSource>
</asp:Content>
