<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ARInvoiceDataList"] == null)
        {
            List<ARInvoiceData> list = new List<ARInvoiceData>()
            {
                new ARInvoiceData(){ InvoiceNo="W201107003", InvoiceDate = "2011/06/30",Client="Apple",USD=241.30,NTD = 7000,Sales="賽德克",Model="MIB2000",Country="TW",QutationNo="I1110085",PaymentTerms="60"},
                new ARInvoiceData(){ InvoiceNo="W201107002", InvoiceDate = "2011/06/25",Client="三爽",USD=7500,NTD = 21000,Sales="賽德克",Model="MHU300",Country="JP",QutationNo="I1110086",PaymentTerms="100"},
                new ARInvoiceData(){ InvoiceNo="W201107001", InvoiceDate = "2011/06/12",Client="三爽",USD=9000,NTD = 7400,Sales="沈佳宜",Model="光梭21",Country="US",QutationNo="I1110083",PaymentTerms="20"},
                new ARInvoiceData(){ InvoiceNo="W201106002", InvoiceDate = "2011/06/21",Client="亞訊",USD=2500,NTD = 3300,Sales="七把劍",Model="翻滾250",Country="China",QutationNo="I1110076",PaymentTerms="80"},
                new ARInvoiceData(){ Client="Total : ",USD=19241.30,NTD = 38700},
                new ARInvoiceData(){ Client="Issue Invoice Total : ",USD=19000,NTD = 31700}
            };
            Session["ARInvoiceDataList"] = list;
        }
        iGridView1.DataSource = (List<ARInvoiceData>)(Session["ARInvoiceDataList"]);
        iGridView1.DataBind();
    }
    
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<ARInvoiceData>)(Session["ARInvoiceDataList"])).Count;
        if (i == 0)
        {
            row.Cells[6].CssClass = "HighLight";
        }
        if( i != 0){
            row.Cells[5].CssClass = "HighLight";
        }
        if (i == count-1 || i==(count-2))
        {
            row.Cells[3].CssClass = "HighLight";
            row.Cells[4].CssClass = "HighLight";
            row.Cells[6].CssClass = "HighLight";
            row.Cells[17].Controls[0].Visible = false;
        }
        i++;
    }

    private int i2 = 0;
    protected void iGridView2_SetCSSClass(GridViewRow row)
    {
       
        if (i2 == 4)
        {
            row.Cells[7].CssClass = "Total";
        }
        if (i2 == 6)
        {
            row.Cells[7].CssClass = "AmountDue";
        }
        if (i2 == 7 || i2 == 8)
        {
            row.Cells[7].CssClass = "Total1";
        }
        i2++;
    }

    int currentRow;
    protected void iGridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MyUpdate")
        {
            int idx = int.Parse(e.CommandArgument.ToString());
            ViewState["CurrentRow"] = idx;
            Panel1.Visible = true;
            List<ARInvoiceData> list = (List<ARInvoiceData>)(Session["ARInvoiceDataList"]);
            ARInvoiceData data = list[idx];
            //Set Properties
            tbIncvoiceNo.Text = data.InvoiceNo;
            tbInvoiceDate.Text = data.InvoiceDate;
            tbClient.Text = data.Client;
            tbAttn.Text = data.Attn;
            tbProjectNo.Text = data.ProjectNo;
            tbQutationNo.Text = data.QutationNo;
            tbModel.Text = data.Model;
            tbCountry.Text = data.Country;
            tbSales.Text = data.Sales;
            tbInvUSD.Text = data.USD+"";
            tbInvNTD.Text = data.NTD+"";
            int bal = int.Parse(tbInvNTD.Text);
            int cal = bal;
            //Show History Data
            if (Session["ReceivedHistory"] == null)
            {
                List<ReceivedData> hlist = new List<ReceivedData>()
                {
                    new ReceivedData(){ReceivedDate="2011/07/30",Amount="3150", IVNo="UK12345678"}
                };
                //Calculate Balance
                CalculateBalance(hlist, bal);

                Session["ReceivedHistory"] = hlist;
            }
            else
            {
                List<ReceivedData> hlist = (List<ReceivedData>)(Session["ReceivedHistory"]);
                hlist.RemoveAt(hlist.Count - 1);
                CalculateBalance(hlist, bal);
            }
            iGridView2.DataSource = (List<ReceivedData>)(Session["ReceivedHistory"]);
            iGridView2.DataBind();
        }
    }
    
    protected void CalculateBalance(List<ReceivedData> hlist, int bal)
    {
        int cal = bal;
        foreach (ReceivedData rd in hlist)
        {
            cal = bal - int.Parse(rd.Amount);
            rd.Balance = cal.ToString();
        }
        hlist.Add(new ReceivedData() { ReceivedDate = "Total :　", Amount = bal - cal + "", Balance = cal.ToString() });
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        List<ReceivedData> hlist = (List<ReceivedData>)(Session["ReceivedHistory"]);
        hlist.RemoveAt(hlist.Count - 1);
        ReceivedData last = hlist[hlist.Count - 1];
        int bal, cal ,amt;
        bal = int.Parse(tbInvNTD.Text);
        cal = int.Parse(last.Balance);
        amt = int.Parse(tbAmount.Text);
        cal -= amt;
        hlist.Add(new ReceivedData() { ReceivedDate = tbReceivedDate.GetText(), Amount = tbAmount.Text, Balance = (cal).ToString() });
        hlist.Add(new ReceivedData() { ReceivedDate = "Total :　", Amount = bal - cal + "", Balance = cal.ToString() });
        iGridView2.DataSource = hlist;
        iGridView2.DataBind();
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        List<ReceivedData> hlist = (List<ReceivedData>)(Session["ReceivedHistory"]);
        ReceivedData last = hlist[hlist.Count - 1];
        List<ARInvoiceData> list = (List<ARInvoiceData>)(Session["ARInvoiceDataList"]);
        ARInvoiceData data = list[ (int)ViewState["CurrentRow"]];
        //Set Properties
        data.ARBalance = last.Balance;
        iGridView1.DataSource = list;
        iGridView1.DataBind();
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
  Received Management
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="920">
                        <tr>
                            <th align="left" width="13%">
                                Sales :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList1" runat="server" 
                                    DataSourceID="SqlDataSource1" DataTextField='fname'  
                                    DataValueField="id" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT * FROM [employee] WHERE ([accessprivilege] = @accessprivilege)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="4" Name="accessprivilege" Type="Byte" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
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
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                AR Balance :&nbsp;</th>
                            <td width="20%">
                                <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" Text="等於0" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Keyword Search :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox5" runat="server" Text="" 
                                    ></asp:TextBox>
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="Button3" runat="server" Text="Search" />
                                
                            </td>
                            <td align="right" colspan="2">
                                
                                <asp:Button ID="Button7" runat="server" Text="Excel" />
                            </td>
                        </tr>
                       
                    </table>
                    <cc1:iGridView ID="iGridView1" runat="server" SkinID="GridView"
          Height="150px" Width="920px" 
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" 
                        onsetcssclass="iGridView1_SetCSSClass" 
          onrowcommand="iGridView1_RowCommand" >
<%--<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>--%>
                        <Columns>
                            <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" />
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Attn" HeaderText="Attn" />
                            <asp:BoundField DataField="USD" HeaderText="Inv USD$" 
                                ControlStyle-CssClass="Currency">
                            <ControlStyle CssClass="Currency" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NTD" HeaderText="Inv NT$" 
                                ControlStyle-CssClass="Currency" >
                            <ControlStyle CssClass="Currency" />
                            </asp:BoundField>
                            <asp:BoundField DataField="IVDate" HeaderText="I/V Date"  />
                            <asp:BoundField DataField="IVNo" HeaderText="I/V No" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="PaymentTerms" HeaderText="收款天數" />
                            <asp:BoundField DataField="PlanDueDate" HeaderText="預計收款日" />
                            <asp:BoundField DataField="OverDueDays" HeaderText="逾期天數" />
                            <asp:BoundField DataField="OverDueInterval" HeaderText="逾期區間" />
                            <asp:ButtonField CommandName="MyUpdate" Text="Update" ButtonType="Button" />
                            <asp:BoundField DataField="ARBalance" HeaderText="AR Balance" />
                        </Columns>
                    </cc1:iGridView>
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Received Add" 
          Visible="False" CssClass="HiddenPanel">
                     <table align="center" border="1" cellpadding="0" cellspacing="0">
                        <tr>
                            <th align="left" width="13%">
                                Invoice No.:&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbIncvoiceNo" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Invoice Date : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbInvoiceDate" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                             <th align="left" width="13%">
                                 Sales :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbSales" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbProjectNo" runat="server"></asp:TextBox>
                            </td>
                           <th align="left" width="13%">
                                 Client :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbClient" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                             <th align="left" width="13%">
                                 Inv US$ :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbInvUSD" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Qutation No. : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbQutationNo" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Attn : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbAttn" runat="server" ReadOnly="True"></asp:TextBox>
                             </td>
                             <th align="left" width="13%">
                                 Inv NT$ :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbInvNTD" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Model
                                 : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbModel" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Country : </th>
                            <td width="20%">
                                <asp:TextBox ID="tbCountry" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <td colspan="2">
                                
                            </td>
                        </tr>
                        <tr>
                        <td colspan="6">
                         <table align="center" border="1" cellpadding="0" cellspacing="0">
                             <tr>
                                 <th align="center" width="20%">
                                     Received Date</th>
                                 <th align="center" width="20%">
                                     Amount
                                 </th>
                                 <th align="center" width="20%">
                                     I/N No</th>
                                 <th align="center" width="40%">
                                     Note</th>
                             </tr>
                             <tr>
                                 <td align="center" width="20%">
                                     </th>
                                     <uc1:DateChooser ID="tbReceivedDate" runat="server" />
                                     <td align="center" width="20%">
                                         <asp:TextBox ID="tbAmount" runat="server"></asp:TextBox>
                                     </td>
                                     <td align="center" width="20%">
                                         <asp:TextBox ID="tbIVNo" runat="server"></asp:TextBox>
                                     </td>
                                     <td align="center" width="40%">
                                         <asp:TextBox ID="tbNote" runat="server"></asp:TextBox>
                                         &nbsp;
                                         <asp:Button ID="Button6" runat="server" Text="Add" onclick="Button6_Click" />
                                     </td>
                                 </td>
                             </tr>
                         </table>
                         </td>
                         </tr>
                          <tr >
                            <td colspan="6"  >
                                <cc1:iRowSpanGridView ID="iGridView2" runat="server" Width="100%" 
                        DefaultColumnWidth="96px" AutoGenerateColumns="false" CssClass="Gridview"    >
                        <Columns>
                            <asp:BoundField DataField="ReceivedDate" HeaderText="Received Date" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" />
                            <asp:BoundField DataField="Balance" HeaderText="Balance" />
                            <asp:BoundField DataField="IVNo" HeaderText="I/V No." />
                            <asp:BoundField DataField="Note" HeaderText="Note" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                             </td>
                        </tr>
                        <tr align="center">
                            <td align="center"colspan="6"  >

                                <asp:Button ID="Button5" runat="server" Text="Save" onclick="Button5_Click" />
                                
                             </td>
                        </tr>

                      
                              </table>
                    </asp:Panel>
                   
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

