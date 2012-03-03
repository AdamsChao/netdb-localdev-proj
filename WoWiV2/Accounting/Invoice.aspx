<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" EnableEventValidation="false" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["InvoiceDataList"] == null)
        //{
        //    List<InvoiceData> list = new List<InvoiceData>()
        //    {
        //        new InvoiceData(){ id = "1",InvoiceNo="W201107003", InvoiceDate = "2011/06/30",Client="Apple",USD=241.30,NTD = 7000,Sales="賽德克",Model="MIB2000",Country="TW",QutationNo="I1110085"},
        //        new InvoiceData(){ id = "1",InvoiceNo="W201107002", InvoiceDate = "2011/06/25",Client="三爽",USD=7500,NTD = 21000,Sales="賽德克",Model="MHU300",Country="JP",QutationNo="I1110086"},
        //        new InvoiceData(){ id = "1",InvoiceNo="W201107001", InvoiceDate = "2011/06/12",Client="三爽",USD=9000,NTD = 7400,Sales="沈佳宜",Model="光梭21",Country="US",QutationNo="I1110083"},
        //        new InvoiceData(){ id = "1",InvoiceNo="W201106002", InvoiceDate = "2011/06/21",Client="亞訊",USD=2500,NTD = 3300,Sales="七把劍",Model="翻滾250",Country="China",QutationNo="I1110076"},
        //        new InvoiceData(){ id = "1",Client="Total : ",USD=19241.30,NTD = 38700},
        //        new InvoiceData(){ id = "1",Client="Issue Invoice Total : ",USD=19000,NTD = 31700}
        //    };
        //    Session["InvoiceDataList"] = list;
        //}
        //iGridView1.DataSource = (List<InvoiceData>)(Session["InvoiceDataList"]);
        //iGridView1.DataBind();

        if (Page.IsPostBack) return;
        var data = from i in wowidb.invoices select i;
        List<InvoiceData> list = new List<InvoiceData>();
        InvoiceData temp;
        foreach (var item in data)
        {
            temp = new InvoiceData();
            temp.id = item.invoice_id+"";
            temp.InvoiceNo = item.issue_invoice_no;
            if (item.issue_invoice_date.HasValue)
            {
                temp.InvoiceDate = ((DateTime)item.issue_invoice_date).ToString("yyyy/MM/dd");
            }
            temp.ProjectNo = item.project_no;
            try
            {
                QuotationModel.Quotation_Version quo = (from q in db.Quotation_Version where q.Quotation_No == item.quotaion_no select q).First();
                temp.Model = quo.Model_No;
                
                int cid = (int)quo.Client_Id;
                try
                {
                    var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
                    temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;

                    int countryid = (int)client.country_id;
                    var country = (from con in wowidb.countries where con.country_id == countryid select con).First();
                    temp.Country = country.country_name;
                    WoWiModel.contact_info contact;
                    int contactid;
                    if (quo.Client_Contact != null)
                    {
                        contactid = (int)quo.Client_Contact;
                    }
                    else
                    {
                        contactid = (from c in wowidb.m_clientappliant_contact where c.clientappliant_id == quo.Client_Id select c.contact_id).First();
                    }
                    contact = (from c in wowidb.contact_info where c.id == contactid select c).First();
                    temp.Attn = String.IsNullOrEmpty(contact.fname) ? contact.c_lname + " " + contact.c_fname : contact.fname + " " + contact.lname;
           
                }

                catch (Exception)
                {

                    //throw;
                }
                int salesid = (int)quo.SalesId;
                //temp.Sales
                var sales = (from emp in wowidb.employees where emp.id == salesid select emp).First();
                temp.Sales = sales.fname + " " + sales.lname; 
            }
            catch (Exception)
            {
                
                //throw;
            }
            
            temp.Currency = item.currency;
            if (temp.Currency == "USD")
            {
                temp.USD = ((double)item.final_total);
                temp.NTD = temp.USD / (double)item.exchange_rate;
            }
            else
            {
                temp.NTD = ((double)item.final_total);
                temp.USD = temp.NTD * (double)item.exchange_rate;
            }

            if (item.due_date.HasValue)
            {
                temp.IVDate = ((DateTime)item.due_date).ToString("yyyy/MM/dd");
            }
            temp.IVNo = item.invoice_no;
            
            temp.QutationNo = item.quotaion_no;
            list.Add(temp);
        }
        iGridView1.DataSource = list;
        iGridView1.DataBind();
        
       
        
        
    }
   
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<InvoiceData>)(Session["InvoiceDataList"])).Count;
        if (i == 0)
        {
            row.Cells[6].CssClass = "HighLight";
        }
        if( i != 0){
            row.Cells[5].CssClass = "HighLight";
        }
        if (i == count || i==(count+1))
        {
            row.Cells[3].CssClass = "HighLight";
            row.Cells[4].CssClass = "HighLight";
            row.Cells[6].CssClass = "HighLight";
        }
        i++;
    }

    

    protected void Button1_Click(object sender, EventArgs e)
    {
       
        Response.Redirect("~/Accounting/CreateInvoice.aspx");
    }

    protected void DropDownList1_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var sales = from s in wowidb.employees from d in wowidb.departments where d.name == "Sales" && s.department_id == d.id select new { Id = s.id, Name = s.fname + " " + s.lname };
        (sender as DropDownList).DataSource = sales;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void DropDownList2_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        (sender as DropDownList).DataSource = db.Project;
        (sender as DropDownList).DataTextField = "Project_No";
        (sender as DropDownList).DataValueField = "Quotation_Id";
        (sender as DropDownList).DataBind();
    }

    protected void DropDownList3_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return; 
        var clients = from c in wowidb.clientapplicants where c.clientapplicant_type == 1 || c.clientapplicant_type == 3 select new { Id = c.id, Name = String.IsNullOrEmpty(c.c_companyname) ? c.companyname : c.c_companyname };
        (sender as DropDownList).DataSource = clients;
        (sender as DropDownList).DataTextField = "Name";
        (sender as DropDownList).DataValueField = "Id";
        (sender as DropDownList).DataBind();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        
        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=InvoiceList_"+DateTime.Now.ToString("yyyyMMddHH")+".xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        iGridView1.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //base.VerifyRenderingInServerForm(control);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<style type="text/css">
    th
    {
         font-size : 12px;
    }
    .Gridview
    {
        text-align : right;
        font-size : 12px;
    }
    .Currency
    {
        color:blue;
    }
    .HighLight
    {
        background-color:yellow;
    }
    .HiddenPanel
    {
        padding: 0 0 0 0 ;
   
    }
    .Total
    {
         font-weight:bold;
         font-style:italic;
         background-color:yellow;   
    }
    .Total1
    {
         font-weight:bold;
         font-style:italic;
    }
    .AmountDue
    {
         font-weight:bold;
         font-style:italic;
         background-color:orange;   
   
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  Invoice Management
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th align="left" width="13%">
                                Sales :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                                    AppendDataBoundItems="True" 
                                    onload="DropDownList1_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser1" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser2" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" 
                                    onload="DropDownList2_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Open Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser3" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" 
                                    onload="DropDownList3_Load">
                                    <asp:ListItem Value="-1">All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                               <%-- Keyword Search :&nbsp;--%></th>
                            <td width="20%">
                              <%--  <asp:TextBox ID="TextBox5" runat="server" Text="" Enabled="False" 
                                    ></asp:TextBox>--%>
                            </td>
                            <td align="right" colspan="2">
                                
                               
                                
                            </td>
                            <td align="right" colspan="2">
                                 <asp:Button ID="Button3" runat="server" Text="Search" Enabled="False" />&nbsp;&nbsp;
                                <asp:Button ID="Button1" runat="server" Text="New" onclick="Button1_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button2" runat="server" Text="Print List" 
                                     onclick="Button2_Click" />
                                
                            </td>
                        </tr>
                       
                    </table>
                    <asp:GridView ID="iGridView1" runat="server" Height="150px" 
          Width="100%" SkinID="GridView"
                         AutoGenerateColumns="False" 
                       >
                        <Columns>
                            <asp:TemplateField HeaderText="Invoice No">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("InvoiceNo") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" 
                                        NavigateUrl='<%# Bind("id","~/Accounting/UpdateInvoice.aspx?id={0}") %>' Text='<%# Bind("InvoiceNo") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Attn" HeaderText="Attn" />
                            <asp:BoundField DataField="USD" HeaderText="Inv USD$" 
                                ControlStyle-CssClass="Currency" DataFormatString="{0:F2}">
                            <ControlStyle CssClass="Currency" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NTD" HeaderText="Inv NT$" 
                                ControlStyle-CssClass="Currency" DataFormatString="{0:F2}">
                            <ControlStyle CssClass="Currency" />
                            </asp:BoundField>
                            <asp:BoundField DataField="IVDate" HeaderText="I/V Date"  />
                            <asp:BoundField DataField="IVNo" HeaderText="I/V No" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                        </Columns>
                    </asp:GridView>
              
      </ContentTemplate>
      <Triggers>
          <asp:PostBackTrigger ControlID="Button2" />
      </Triggers>
   </asp:UpdatePanel>
</asp:Content>

