<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register Src="../UserControls/DateChooser.ascx" TagName="DateChooser" TagPrefix="uc1" %>
<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();

    protected void Page_Load(object sender, EventArgs e)
    {
      if (IsPostBack)
      {
        String newCriteria = "";
        int eid = Utils.GetEmployeeID(User.Identity.Name);
        newCriteria += " and P.department_id in (Select accesslevel_id from m_employee_accesslevel where employee_id =" + eid + ")";

        //Add by Adams 2013/2/6 for 加入PR NO為條件
        if (!string.IsNullOrEmpty(txtPR.Text))
        {
          char[] delimiterChars = { ',', ';' };
          string[] words = txtPR.Text.Split(delimiterChars);
          string key = string.Empty;
          foreach (string s in words)
          {
            if (!string.IsNullOrEmpty(s))
              key += "," + s;
          }
          newCriteria += " and P.pr_id in (" + key.Substring(1) + ") ";
        }

        if (ddlVenderList.SelectedValue != "-1")
        {
          newCriteria += " and P.vendor_id = " + ddlVenderList.SelectedValue;
        }
        try
        {
          DateTime fromDate = dcFrom.GetDate();
          newCriteria += " and P.target_payment_date >= '" + dcFrom.GetText() + "' ";
        }
        catch (Exception)
        {


        }

        try
        {
          DateTime toDate = dcTo.GetDate();
          newCriteria += " and P.target_payment_date <= '" + dcTo.GetText() + "' ";
        }
        catch (Exception)
        {
          //throw;
        }

        bool append = false;
        try
        {
          DateTime fromDate = dcPFrom.GetDate();
          append = true;
          newCriteria = "select * from (" + SqlDataSource1.SelectCommand + newCriteria + ") AS u where u.pay_date >= '" + dcPFrom.GetText() + "' ";
        }
        catch (Exception)
        {


        }

        try
        {

          DateTime toDate = dcPTo.GetDate();
          if (append)
          {
            newCriteria += " and u.pay_date <= '" + dcPTo.GetText() + "' ";
          }
          else
          {
            append = true;
            newCriteria = " select * from ( " + SqlDataSource1.SelectCommand + newCriteria + " ) AS u where u.pay_date <= '" + dcPTo.GetText() + "' ";
          }
        }
        catch (Exception)
        {
          //throw;
        }

        if (cbNotPay.Checked)
        {

        }

        if (append)
        {
          if (cbNotPay.Checked)
          {
            newCriteria += " and u.pay_date IS NULL Order by u.pr_id desc ";
          }
          SqlDataSource1.SelectCommand = newCriteria;
        }
        else
        {
          if (cbNotPay.Checked)
          {
            newCriteria = "select * from (" + SqlDataSource1.SelectCommand + newCriteria + ") AS u where u.pay_date IS NULL Order by u.pr_id desc ";
            SqlDataSource1.SelectCommand = newCriteria;
          }
          else
          {
            SqlDataSource1.SelectCommand += newCriteria + " Order by P.pr_id desc ";
          }
        }

        try
        {
          GVPayment.DataBind();
          if (GVPayment.Rows.Count == 0)
          {
            lblMsg.Text = "No match data found.";
          }
        }
        catch (Exception ex)
        {
          SqlDataSource1.SelectCommand = "";
          GVPayment.DataBind();
          lblMsg.Text = "請確認查詢條件設定正確! PR No.只能使用逗號和分號分隔!";
        }        
      }
    }

   

    protected void ddlVenderList_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var list = (from c in wowidb.vendors from country in wowidb.countries where c.country == country.country_id orderby c.name, c.c_name select new { Id = c.id, Text = String.IsNullOrEmpty(c.name) ? c.c_name + " - [ " + country.country_name + " ]" : c.name + " - [ " + country.country_name + " ]" });
        (sender as DropDownList).DataSource = list;
        (sender as DropDownList).DataTextField = "Text";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void HyperLink2_Load(object sender, EventArgs e)
    {
        if (!Utils.isSysAdmin(Utils.GetEmployeeID()))
        {
            (sender as HyperLink).Visible = false;
        }
    }

    protected void ButtonExcel_Click(object sender, EventArgs e)
    {
      if (GVPayment.Rows.Count > 0)
      {
        GVPayment.Columns[0].Visible = false;
        GVPayment.AllowPaging = false;
        GVPayment.AllowSorting = false;
        GVPayment.DataBind();
        ExportUtil.ExportWebControlToExcel(DateTime.Now.ToString("yyyyMMdd-hhmmss-Payment4Vender"), GVPayment);
      }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void GVPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e.Row.RowType==DataControlRowType.DataRow)
      {
        String projIDStr = e.Row.Cells[2].Text;
        try
        {
          int pid = int.Parse(projIDStr);
          e.Row.Cells[2].Text = (from p in db.Project where p.Project_Id == pid select p.Project_No).First();
        }
        catch (Exception)
        {

          //throw;
        }
        String venderIDStr = e.Row.Cells[5].Text;
        if (venderIDStr == "-1")
        {
          e.Row.Cells[5].Text = "Not set yet";
        }
        else
        {
          try
          {
            int vid = int.Parse(venderIDStr);
            var vender = (from v in wowidb.vendors where v.id == vid select v).First();
            e.Row.Cells[5].Text = String.IsNullOrEmpty(vender.c_name) ? vender.name : vender.c_name;
          }
          catch (Exception)
          {

            //throw;
          }
        }
        if (e.Row.Cells[6].Text.Trim() != "&nbsp;")
        {
          e.Row.Cells[6].Text = e.Row.Cells[6].Text + "$";
        }
        String quoIDStr = e.Row.Cells[3].Text;
        try
        {
          int qid = int.Parse(quoIDStr);
          e.Row.Cells[3].Text = (from q in db.Quotation_Version where q.Quotation_Version_Id == qid select q.Quotation_No).First();
        }
        catch (Exception)
        {

          //throw;
        }        
      }
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    PR Payment Lists
    <br />
    PR No. :
    <asp:TextBox ID="txtPR" runat="server" Width="80%"></asp:TextBox>
    <br />
    Vender :
    <asp:DropDownList ID="ddlVenderList" runat="server" AppendDataBoundItems="True" OnLoad="ddlVenderList_Load">
        <asp:ListItem Value="-1">- All -</asp:ListItem>
    </asp:DropDownList>
    <br>
    Target Payment Date From :
    <uc1:DateChooser ID="dcFrom" runat="server" />
    &nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcTo" runat="server" />
    &nbsp;<br>
    Paid Date From :
    <uc1:DateChooser ID="dcPFrom" runat="server" />
    &nbsp; To:&nbsp;
    <uc1:DateChooser ID="dcPTo" runat="server" />
    <asp:CheckBox ID="cbNotPay" runat="server" Text="未付" />
    &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" />
  <asp:Button ID="ButtonExcel" runat="server" Text="Export To Excel" 
      OnClick="ButtonExcel_Click" Visible="False" />
    <br>
    <asp:Label ID="lblMsg" runat="server" EnableViewState="False"></asp:Label>
    <asp:GridView ID="GVPayment" runat="server" AutoGenerateColumns="False" SkinID="GridView"
        Width="100%" DataKeyNames="pr_id" PageSize="20" AllowSorting="True"
        DataSourceID="SqlDataSource1" AllowPaging="True" 
      onrowdatabound="GVPayment_RowDataBound">
        <Columns>
            <asp:TemplateField InsertVisible="False" SortExpression="pr_no">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("pr_no") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Bind("pr_id","~/Accounting/PRPayment.aspx?id={0}&type=payment") %>'
                        OnLoad="HyperLink2_Load">Edit</asp:HyperLink>
                    &nbsp;
                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Bind("pr_id","~/Accounting/PRPaymentDetails.aspx?id={0}") %>'>Details</asp:HyperLink>
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
                SortExpression="total_cost" />
            <asp:BoundField DataField="target_payment_date" HeaderText="Target Payment Date"
                SortExpression="target_payment_date" DataFormatString="{0:yyyy/MM/dd}" />
            <asp:BoundField DataField="pay_date" HeaderText="Paid Date" SortExpression="pay_date"
                DataFormatString="{0:yyyy/MM/dd}" />
            <asp:BoundField DataField="target_status" HeaderText="Target Status" SortExpression="target_status" />
            <asp:BoundField DataField="payment_term" HeaderText="Payment Term" SortExpression="payment_term" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT P.total_cost,P.currency,P.pr_id, P.project_id, P.vendor_id, P.quotaion_id,(select model_no from quotation_version where quotation_version.Quotation_Version_Id = quotaion_id) as model , P.target_payment_date,(CASE P.payment_term WHEN 0 THEN 'Prepayment 1' WHEN 1 THEN 'Prepayment 2' WHEN 2 THEN 'Prepayment 3' ELSE 'Final Prepayment' END) AS payment_term,(select Status from Quotation_Target where Quotation_Target_Id = (Select Quotation_Target_Id from PR_item where pr_id=P.pr_id)) As target_status, (SELECT Top 1 PP.pay_date FROM PR AS P1, PR_Payment AS PP WHERE P1.pr_id = PP.pr_id and PP.pr_id = P.pr_id and PP.Status = 10) AS pay_date FROM PR AS P, PR_authority_history AS AU  where P.pr_auth_id = AU.pr_auth_id and AU.status = 6 ">
    </asp:SqlDataSource>
    </p>
</asp:Content>
