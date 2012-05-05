<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumns(iGridView1, 4);
            SetMergedHerderColumns(iGridView2, 2);
        } 
    }

    private void SetMergedHerderColumns(iRowSpanGridView iGridView1,int idx) {
        iGridView1.AddMergedColumns("0 ~ 30 天", idx, 2);
        iGridView1.AddMergedColumns("30 ~ 60 天", idx + 2, 2);
        iGridView1.AddMergedColumns("60 ~ 90 天", idx + 4, 2);
        iGridView1.AddMergedColumns("90 ~ 120 天", idx + 6, 2);
        iGridView1.AddMergedColumns("120 ~ 150 天", idx + 8, 2);
        iGridView1.AddMergedColumns("150 ~ 180 天", idx + 10, 2);
        iGridView1.AddMergedColumns("180 ~ 365 天", idx + 12, 2);
        iGridView1.AddMergedColumns("1年", idx+14, 2);
        iGridView1.AddMergedColumns("2年以上", idx+16, 2);
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
    protected String Currency = "";
    protected void Button1_Click(object sender, EventArgs e)
    {

        if (DropDownList2.SelectedValue == "NT$")
        {
            Currency = "NT$";
        }else{
            Currency = "";
        }
        List<ARAnalysisData> list;
        if (DropDownList1.SelectedValue == "InvoiceNo")
        {
           
            iGridView1.Visible = true;
            iGridView2.Visible = false;
            list = GetInvoiceList();
            iGridView1.DataSource = list;
            iGridView1.DataBind();
        }
        else
        {
            iGridView1.Visible = false;
            iGridView2.Visible = true;
            list = GetClientList();
            iGridView2.DataSource = list;
            iGridView2.DataBind();
        }
        if (list.Count == 0)
        {
            Button7.Enabled = false;
            lblMsg.Visible = true;
        }
        else
        {
            Button7.Enabled = true;
            lblMsg.Visible = false;
        }
    }
    
    protected List<ARAnalysisData> GetInvoiceList()
    {
        if (DropDownList2.SelectedValue == "NT$")
        {
            Currency = "NT$";
        }
        else
        {
            Currency = "";
        }
        List<ARAnalysisData> list = new List<ARAnalysisData>();
        ARAnalysisData temp;
        try
        {
            var data = from i in wowidb.invoices where (int)(decimal)i.ar_balance > 0 select i;
            try
            {
                DateTime fromDate = dcFrom.GetDate();
                data = data.Where(d => ((DateTime)d.invoice_date) >= fromDate);
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                DateTime toDate = dcTo.GetDate();
                data = data.Where(d => ((DateTime)d.invoice_date) <= toDate);
            }
            catch (Exception)
            {
                //throw;
            }
            decimal tot=0,d30 = 0 ,d60  = 0 ,d90 = 0, d120  = 0, d150  = 0, d180  = 0, d365  = 0, y1  = 0, y2 = 0;
            foreach (var item in data)
            {
                temp = new ARAnalysisData()
                {
                    InvoiceNo = item.issue_invoice_no,
                    InvoiceDate = ((DateTime)item.issue_invoice_date).ToString("yyyy/MM/dd")
                };

                QuotationModel.Quotation_Version quo = (from q in db.Quotation_Version where q.Quotation_No == item.quotaion_no select q).First();

                int cid = (int)quo.Client_Id;

                var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();

                temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;


                if (item.due_date.HasValue)
                {
                    double days = (DateTime.Now - (DateTime)item.due_date).TotalDays;
                    decimal ar_balance = (decimal)item.ar_balance;
                    if (DropDownList2.SelectedValue == "NT$")
                    {
                        if (item.currency == "USD")
                        {
                            ar_balance /= (decimal)item.exchange_rate;
                        }
                    }
                    else
                    {
                        if (item.currency == "NTD")
                        {
                            ar_balance *= (decimal)item.exchange_rate;
                        }
                    }
                    if (days < 0)
                    {
                        continue;//期限未到
                    }
                    else if (days <= 30)
                    {
                        d30 += ar_balance;
                        temp.Day30USD = (ar_balance).ToString("F2");
                        temp.Day30P = "100%";
                    }
                    else if (days <= 60)
                    {
                        d60 += ar_balance;
                        temp.Day60USD = (ar_balance).ToString("F2");
                        temp.Day60P = "100%";
                    }
                    else if (days <= 90)
                    {
                        d90 += ar_balance;
                        temp.Day90USD = (ar_balance).ToString("F2");
                        temp.Day90P = "100%";
                    }
                    else if (days <= 120)
                    {
                        d120 += ar_balance;
                        temp.Day120USD = (ar_balance).ToString("F2");
                        temp.Day120P = "100%";
                    }
                    else if (days <= 150)
                    {
                        d150 += ar_balance;
                        temp.Day150USD = (ar_balance).ToString("F2");
                        temp.Day150P = "100%";
                    }
                    else if (days <= 180)
                    {
                        d180 += ar_balance;
                        temp.Day180USD = (ar_balance).ToString("F2");
                        temp.Day180P = "100%";
                    }
                    else if (days <= 365)
                    {
                        d365 += ar_balance;
                        temp.Day365USD = (ar_balance).ToString("F2");
                        temp.Day365P = "100%";
                    }
                    else if (days <= 730)
                    {
                        y1 += ar_balance;
                        temp.Year1USD = (ar_balance).ToString("F2");
                        temp.Year1P = "100%";
                    }
                    else
                    {
                        y2 += ar_balance;
                        temp.Year2USD = (ar_balance).ToString("F2");
                        temp.Year2P = "100%";
                    }
                    temp.USD = (ar_balance).ToString("F2");
                    tot += ar_balance;
                }
                list.Add(temp);
            }
            if (list.Count != 0 && tot!=0)
            {
                temp = new ARAnalysisData()
                {
                    InvoiceNo ="Total : ",
                    USD = tot.ToString("F2"),
                };
                if (d30 != 0)
                {
                    temp.Day30USD = d30.ToString("F2");
                    temp.Day30P = ((d30 / tot)*100).ToString("F0")+"%";
                }
                if (d60 != 0)
                {
                    temp.Day60USD = d60.ToString("F2");
                    temp.Day60P = ((d60 / tot) * 100).ToString("F0") + "%";
                }
                if (d90 != 0)
                {
                    temp.Day90USD = d90.ToString("F2");
                    temp.Day90P = ((d90 / tot) * 100).ToString("F0") + "%";
                }
                if (d120 != 0)
                {
                    temp.Day120USD = d120.ToString("F2");
                    temp.Day120P = ((d120 / tot) * 100).ToString("F0") + "%";
                }
                if (d150 != 0)
                {
                    temp.Day150USD = d150.ToString("F2");
                    temp.Day150P = ((d150 / tot) * 100).ToString("F0") + "%";
                }
                if (d180 != 0)
                {
                    temp.Day180USD = d180.ToString("F2");
                    temp.Day180P = ((d180 / tot) * 100).ToString("F0") + "%";
                }
                if (d365 != 0)
                {
                    temp.Day365USD = d365.ToString("F2");
                    temp.Day365P = ((d365 / tot) * 100).ToString("F0") + "%";
                }
                if (y1 != 0)
                {
                    temp.Year1USD = y1.ToString("F2");
                    temp.Year1USD = ((y1 / tot) * 100).ToString("F0") + "%";
                }
                if (y2 != 0)
                {
                    temp.Year2USD = y2.ToString("F2");
                    temp.Year2P = ((y2 / tot) * 100).ToString("F0") + "%";
                }
                list.Add(temp);
            }
        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    protected List<ARAnalysisData> GetClientList()
    {
        if (DropDownList2.SelectedValue == "NT$")
        {
            Currency = "NT$";
        }
        else
        {
            Currency = "";
        }
        List<ARAnalysisData> list = new List<ARAnalysisData>();
        ARAnalysisData temp;
        try
        {
            var datas = from i in wowidb.invoices where (int)(decimal)i.ar_balance > 0 select new { pNo = i.project_no, invoice_id = i.invoice_id, qNo = i.quotaion_no, invoice_date = i.invoice_date };
            try
            {
                DateTime fromDate = dcFrom.GetDate();
                datas = datas.Where(d => ((DateTime)d.invoice_date) >= fromDate);
            }
            catch (Exception)
            {

                //throw;
            }

            try
            {
                DateTime toDate = dcTo.GetDate();
                datas = datas.Where(d => ((DateTime)d.invoice_date) <= toDate);
            }
            catch (Exception)
            {
                //throw;
            }

            var clientList = from i in datas from quo in wowidb.Quotation_Version from pro in wowidb.Projects where i.qNo == quo.Quotation_No  && i.pNo == pro.Project_No && pro.Quotation_Id == quo.Quotation_Version_Id select new { clientID = (int)quo.Client_Id, invoiceID = i.invoice_id };
            Dictionary<int, List<int>> clients = new Dictionary<int, List<int>>();
            foreach (var ii in clientList)
            {
                if (!clients.ContainsKey(ii.clientID))
                {
                    clients.Add(ii.clientID, new List<int>() { ii.invoiceID });
                }
                else
                {
                    clients[ii.clientID].Add(ii.invoiceID);
                }
            }
            decimal atot = 0, ad30 = 0, ad60 = 0, ad90 = 0, ad120 = 0, ad150 = 0, ad180 = 0, ad365 = 0, ay1 = 0, ay2 = 0;
            foreach (var iii in clients)
            {
                int cid = iii.Key;
                var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
                temp = new ARAnalysisData()
                {
                    Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname
                };
                decimal tot = 0, d30 = 0, d60 = 0, d90 = 0, d120 = 0, d150 = 0, d180 = 0, d365 = 0, y1 = 0, y2 = 0;
                foreach (var iid in iii.Value)
                {
                    var item = (from i in wowidb.invoices where  i.invoice_id == iid select i ).First();
                    if (item.due_date.HasValue)
                    {
                        double days = (DateTime.Now - (DateTime)item.due_date).TotalDays;
                        decimal ar_balance = (decimal)item.ar_balance;
                        if (DropDownList2.SelectedValue == "NT$")
                        {
                            if (item.currency == "USD")
                            {
                                ar_balance /= (decimal)item.exchange_rate;
                            }
                        }
                        else
                        {
                            if (item.currency == "NTD")
                            {
                                ar_balance *= (decimal)item.exchange_rate;
                            }
                        }
                        if (days < 0)
                        {
                            continue;//期限未到
                        }
                        else if (days <= 30)
                        {
                            d30 += ar_balance;
                        }
                        else if (days <= 60)
                        {
                            d60 += ar_balance;
                        }
                        else if (days <= 90)
                        {
                            d90 += ar_balance;
                        }
                        else if (days <= 120)
                        {
                            d120 += ar_balance;
                        }
                        else if (days <= 150)
                        {
                            d150 += ar_balance;
                        }
                        else if (days <= 180)
                        {
                            d180 += ar_balance;
                        }
                        else if (days <= 365)
                        {
                            d365 += ar_balance;
                        }
                        else if (days <= 730)
                        {
                            y1 += ar_balance;;
                        }
                        else
                        {
                            y2 += ar_balance;
                        }
                        tot += ar_balance;
                    }
                }
                if (d30 != 0)
                {
                    ad30 += d30;
                    temp.Day30USD = d30.ToString("F2");
                    temp.Day30P = ((d30 / tot) * 100).ToString("F0") + "%";
                }
                if (d60 != 0)
                {
                    ad60 += d60;
                    temp.Day60USD = d60.ToString("F2");
                    temp.Day60P = ((d60 / tot) * 100).ToString("F0") + "%";
                }
                if (d90 != 0)
                {
                    ad90 += d90;
                    temp.Day90USD = d90.ToString("F2");
                    temp.Day90P = ((d90 / tot) * 100).ToString("F0") + "%";
                }
                if (d120 != 0)
                {
                    ad120 += d120;
                    temp.Day120USD = d120.ToString("F2");
                    temp.Day120P = ((d120 / tot) * 100).ToString("F0") + "%";
                }
                if (d150 != 0)
                {
                    ad150 += d150;
                    temp.Day150USD = d150.ToString("F2");
                    temp.Day150P = ((d150 / tot) * 100).ToString("F0") + "%";
                }
                if (d180 != 0)
                {
                    ad180 += d180;
                    temp.Day180USD = d180.ToString("F2");
                    temp.Day180P = ((d180 / tot) * 100).ToString("F0") + "%";
                }
                if (d365 != 0)
                {
                    ad365 += d365;
                    temp.Day365USD = d365.ToString("F2");
                    temp.Day365P = ((d365 / tot) * 100).ToString("F0") + "%";
                }
                if (y1 != 0)
                {
                    ay1 += y1;
                    temp.Year1USD = y1.ToString("F2");
                    temp.Year1USD = ((y1 / tot) * 100).ToString("F0") + "%";
                }
                if (y2 != 0)
                {
                    ay2 += y2;
                    temp.Year2USD = y2.ToString("F2");
                    temp.Year2P = ((y2 / tot) * 100).ToString("F0") + "%";
                }
                temp.USD = tot.ToString("F2");
                atot += tot;
                list.Add(temp);
            }
            
            
           
            if (list.Count != 0 && atot != 0)
            {
                temp = new ARAnalysisData()
                {
                    Client = "Total : ",
                    USD = atot.ToString("F2"),
                };
                if (ad30 != 0)
                {
                    temp.Day30USD = ad30.ToString("F2");
                    temp.Day30P = ((ad30 / atot) * 100).ToString("F0") + "%";
                }
                if (ad60 != 0)
                {
                    temp.Day60USD = ad60.ToString("F2");
                    temp.Day60P = ((ad60 / atot) * 100).ToString("F0") + "%";
                }
                if (ad90 != 0)
                {
                    temp.Day90USD = ad90.ToString("F2");
                    temp.Day90P = ((ad90 / atot) * 100).ToString("F0") + "%";
                }
                if (ad120 != 0)
                {
                    temp.Day120USD = ad120.ToString("F2");
                    temp.Day120P = ((ad120 / atot) * 100).ToString("F0") + "%";
                }
                if (ad150 != 0)
                {
                    temp.Day150USD = ad150.ToString("F2");
                    temp.Day150P = ((ad150 / atot) * 100).ToString("F0") + "%";
                }
                if (ad180 != 0)
                {
                    temp.Day180USD = ad180.ToString("F2");
                    temp.Day180P = ((ad180 / atot) * 100).ToString("F0") + "%";
                }
                if (ad365 != 0)
                {
                    temp.Day365USD = ad365.ToString("F2");
                    temp.Day365P = ((ad365 / atot) * 100).ToString("F0") + "%";
                }
                if (ay1 != 0)
                {
                    temp.Year1USD = ay1.ToString("F2");
                    temp.Year1USD = ((ay1 / atot) * 100).ToString("F0") + "%";
                }
                if (ay2 != 0)
                {
                    temp.Year2USD = ay2.ToString("F2");
                    temp.Year2P = ((ay2 / atot) * 100).ToString("F0") + "%";
                }
                list.Add(temp);
            }
        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }
    protected void iGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Currency == "NT$")
            {
                foreach (TableCell tc in e.Row.Cells)
                {
                    if (tc.Text.IndexOf("US$")!=-1)
                    {
                        tc.Text = tc.Text.Replace("US$", "NT$");
                    }
                }
            }
        }
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        GridView current;
        String fileName = "ARAnalysisBy";
        if (DropDownList1.SelectedValue == "InvoiceNo")
        {
            current = iGridView1;
        }
        else
        {
            current = iGridView2;
        }
        fileName += current == iGridView1 ? "Invoice" : "Client";
        Utils.ExportExcel(current,fileName);
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  Accounts Receivable Aging Schedule
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%" class="style1">
                                <uc1:DateChooser ID="dcFrom" runat="server" />
                            </td>
                             <th align="left" width="13%" >
                                 To :&nbsp;</th>
                            <td width="20%" class="style1">
                                <uc1:DateChooser ID="dcTo" runat="server" />
                            </td>
                             <th align="left" width="13%" >
                                 Date :&nbsp;</th>
                            <td width="20%" class="style1">
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                               分析基準 :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList1" runat="server">
                                    <asp:ListItem>未選擇</asp:ListItem>
                                    <asp:ListItem>InvoiceNo</asp:ListItem>
                                    <asp:ListItem>Client</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                    ControlToValidate="DropDownList1" ErrorMessage="*" ForeColor="Red" 
                                    InitialValue="未選擇"></asp:RequiredFieldValidator>
                            </td>
                            <th align="left" width="13%">
                                幣別 :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList2" runat="server">
                                    <asp:ListItem>未選擇</asp:ListItem>
                                    <asp:ListItem>US$</asp:ListItem>
                                    <asp:ListItem>NT$</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="DropDownList2" ErrorMessage="*" ForeColor="Red" 
                                    InitialValue="未選擇"></asp:RequiredFieldValidator>
                            </td>
                             <td width="33%" colspan="2" align="center">
                               
                                 <asp:Button ID="Button1" runat="server" Text="Search" onclick="Button1_Click" />
                               
                                 &nbsp;&nbsp;
                                 <asp:Button ID="Button7" runat="server" Text="Excel" onclick="Button7_Click" 
                                     Enabled="False" />
                               
                            </td>
                        </tr>
                        
                       
                   <tr><td colspan="6"><asp:Label ID="lblMsg" runat="server" Text="No match data found." ></asp:Label>
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server" Height="300px" Width="100%" isMergedHeader="true" SkinID="GridView"
                        AutoGenerateColumns="false" CssClass="Gridview" Visible="false"
                           onrowdatabound="iGridView1_RowDataBound" >
                        <Columns>
                            <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" />
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="USD" HeaderText="期末AR US$" />
                            <asp:BoundField DataField="Day30USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day30P" HeaderText="%" />
                            <asp:BoundField DataField="Day60USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day60P" HeaderText="%" />
                            <asp:BoundField DataField="Day90USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day90P" HeaderText="%" />
                            <asp:BoundField DataField="Day120USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day120P" HeaderText="%" />
                            <asp:BoundField DataField="Day150USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day150P" HeaderText="%" />
                            <asp:BoundField DataField="Day180USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day180P" HeaderText="%" />
                            <asp:BoundField DataField="Day365USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day365P" HeaderText="%" />
                            <asp:BoundField DataField="Year1USD" HeaderText="US$" />
                            <asp:BoundField DataField="Year1P" HeaderText="%" />
                            <asp:BoundField DataField="Year2USD" HeaderText="US$" />
                            <asp:BoundField DataField="Year2P" HeaderText="%" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView2" runat="server" Height="300px" Width="100%" isMergedHeader="true"
                        AutoGenerateColumns="false" CssClass="Gridview" Visible="false"
                           onrowdatabound="iGridView1_RowDataBound" >
                        <Columns>
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="USD" HeaderText="期末AR US$" />
                            <asp:BoundField DataField="Day30USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day30P" HeaderText="%" />
                            <asp:BoundField DataField="Day60USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day60P" HeaderText="%" />
                            <asp:BoundField DataField="Day90USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day90P" HeaderText="%" />
                            <asp:BoundField DataField="Day120USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day120P" HeaderText="%" />
                            <asp:BoundField DataField="Day150USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day150P" HeaderText="%" />
                            <asp:BoundField DataField="Day180USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day180P" HeaderText="%" />
                            <asp:BoundField DataField="Day365USD" HeaderText="US$" />
                            <asp:BoundField DataField="Day365P" HeaderText="%" />
                            <asp:BoundField DataField="Year1USD" HeaderText="US$" />
                            <asp:BoundField DataField="Year1P" HeaderText="%" />
                            <asp:BoundField DataField="Year2USD" HeaderText="US$" />
                            <asp:BoundField DataField="Year2P" HeaderText="%" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
      <Triggers>
          <asp:PostBackTrigger ControlID="Button7" />
      </Triggers>
   </asp:UpdatePanel>
</asp:Content>

