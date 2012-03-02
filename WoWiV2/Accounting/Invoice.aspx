<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["InvoiceDataList"] == null)
        {
            List<InvoiceData> list = new List<InvoiceData>()
            {
                new InvoiceData(){ InvoiceNo="W201107003", InvoiceDate = "2011/06/30",Client="Apple",USD=241.30,NTD = 7000,Sales="賽德克",Model="MIB2000",Country="TW",QutationNo="I1110085"},
                new InvoiceData(){ InvoiceNo="W201107002", InvoiceDate = "2011/06/25",Client="三爽",USD=7500,NTD = 21000,Sales="賽德克",Model="MHU300",Country="JP",QutationNo="I1110086"},
                new InvoiceData(){ InvoiceNo="W201107001", InvoiceDate = "2011/06/12",Client="三爽",USD=9000,NTD = 7400,Sales="沈佳宜",Model="光梭21",Country="US",QutationNo="I1110083"},
                new InvoiceData(){ InvoiceNo="W201106002", InvoiceDate = "2011/06/21",Client="亞訊",USD=2500,NTD = 3300,Sales="七把劍",Model="翻滾250",Country="China",QutationNo="I1110076"},
                new InvoiceData(){ Client="Total : ",USD=19241.30,NTD = 38700},
                new InvoiceData(){ Client="Issue Invoice Total : ",USD=19000,NTD = 31700}
            };
            Session["InvoiceDataList"] = list;
        }
        iGridView1.DataSource = (List<InvoiceData>)(Session["InvoiceDataList"]);
        iGridView1.DataBind();
        //Panel1.Visible = true;
        //Panel2.Visible = true;
        
        
    }
    private int GetSerialNum()
    {
        if (ViewState["SerialNum"] == null)
        {
            ViewState["SerialNum"] = 1;
        }
        int num = (int)(ViewState["SerialNum"]);
        ViewState["SerialNum"] = num + 1;
        return num;
        
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

    protected void Button1_Click(object sender, EventArgs e)
    {
       
        //Panel1.Visible = true;
        //tbIssueInvoice.Text = String.Format("W{0}{1}", DateTime.Now.ToString("yyyyMMdd"), GetSerialNum());
        Response.Redirect("~/Accounting/CreateInvoice.aspx");
    }
    
    protected void Button2_Click(object sender, EventArgs e)
    {
          List<InvoiceData> list =(List<InvoiceData>)(Session["InvoiceDataList"]);
          list.Insert(list.Count-2,new InvoiceData(){ InvoiceNo=tbIssueInvoice.Text, InvoiceDate = DateTime.Now.ToString("yyyy/MM/dd"),Client="亞訊",USD=2500,NTD = 3300,Sales="七把劍",Model="翻滾250",Country="China",QutationNo="I1110076"}) ;    
        iGridView1.DataSource =list;
        iGridView1.DataBind();
        Panel1.Visible = false;
    }

    protected void DropDownList5_SelectedIndexChanged(object sender, EventArgs e)
    {
        //List<ProjectInvoiceData> list = new List<ProjectInvoiceData>()
        //{
        //    new ProjectInvoiceData(){ Version="I11100085-Main", Status = "Done",Date="2011/06/20",TDescription="TW",Qty="1",UOM="EA",UnitPrice="2000",FPrice="2000",Bill="CB"},
        //    new ProjectInvoiceData(){ Version="I11100085-A01", Status = "Done",Date="2011/06/10",TDescription="TW1",Qty="2",UOM="EA",UnitPrice="3000",FPrice="3000",Bill="預收 60% 尾款 40%"},
        //    new ProjectInvoiceData(){ Version="I11100085-A02", Status = "Cancel",Date="2011/06/12",TDescription="TW2",Qty="1",UOM="EA",UnitPrice="4000",FPrice="4000",Bill="CB"},
        //    new ProjectInvoiceData(){ Version="I11100085-A03", Status = "Done",Date="2011/06/15",TDescription="TW3",Qty="1",UOM="EA",UnitPrice="5000",FPrice="5000",Bill="預收 20% 尾款 80%"},
        //    new ProjectInvoiceData(){ UnitPrice="Total : ", FPrice="US$14000"},
        //    new ProjectInvoiceData(){ UnitPrice="Tax : ", FPrice="0"},
        //    new ProjectInvoiceData(){ UnitPrice="Amount Due : ", FPrice="US$14000"},
        //    new ProjectInvoiceData(){ UnitPrice="Exchange Rate : ", FPrice="29"},
        //    new ProjectInvoiceData(){ UnitPrice="Total : ", FPrice="NT$406000"}
            
        //};
        //iGridView2.DataSource = list;
        //iGridView2.DataBind();
        //Panel2.Visible = true;
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
                                Open Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser3" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
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
                                
                                <asp:Button ID="Button1" runat="server" Text="New" onclick="Button1_Click" />
                                
                                <asp:Button ID="Button2" runat="server" Text="Print List" />
                                
                            </td>
                        </tr>
                       
                    </table>
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server" Height="150px" Width="920px" SkinID="GridView"
                        DefaultColumnWidth="80px" AutoGenerateColumns="false" CssClass="Gridview" 
                        onsetcssclass="iGridView1_SetCSSClass" >
<%--<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>--%>
                        <Columns>
                            <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" />
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Attn" HeaderText="Attn" />
                            <asp:BoundField DataField="USD" HeaderText="Inv USD$" ControlStyle-CssClass="Currency"/>
                            <asp:BoundField DataField="NTD" HeaderText="Inv NT$" ControlStyle-CssClass="Currency" />
                            <asp:BoundField DataField="IVDate" HeaderText="I/V Date"  />
                            <asp:BoundField DataField="IVNo" HeaderText="I/V No" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Issued New" Visible="False" CssClass="HiddenPanel">
                     <table align="center" border="1" cellpadding="0" cellspacing="0">
                        <tr>
                            <th align="left" width="13%">
                                Issue Invoice :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="tbIssueInvoice" runat="server"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Issue Invoice Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser4" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 I/V No. :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList5" runat="server" AppendDataBoundItems="True" 
                                    onselectedindexchanged="DropDownList5_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Proj1234567</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                           <th align="left" width="13%">
                                 Exchange Rate :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </td>
                             <th align="left" width="13%">
                                 Total $ :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Qutation No. : </th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox9" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Model : </th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox10" runat="server" ReadOnly="True"></asp:TextBox>
                             </td>
                             <th align="left" width="13%">
                                 Attn&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox11" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <th align="left" width="13%">
                                Client : </th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True"></asp:TextBox>
                            </td>
                            <th align="left" width="13%">
                                Address : </th>
                            <td colspan="3">
                                <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True" Width="400"></asp:TextBox>
                             </td>
                        </tr>
                   
                       
                  <asp:Panel ID="Panel2" runat="server" Visible="false" CssClass="HiddenPanel">
                          <tr >
                            <td colspan="6"  >
                                <cc1:iRowSpanGridView ID="iGridView2" runat="server" Height="150px" Width="900px" 
                        DefaultColumnWidth="96px" AutoGenerateColumns="false" CssClass="Gridview"  onsetcssclass="iGridView2_SetCSSClass"  >
<%--<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>--%>
                        <Columns>
                            <asp:BoundField DataField="Version" HeaderText="Version" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="Date" HeaderText="Date" />
                            <asp:BoundField DataField="TDescription" HeaderText="TDescription" />
                            <asp:BoundField DataField="Qty" HeaderText="Qty" />
                            <asp:BoundField DataField="UOM" HeaderText="UOM" />
                            <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" />
                            <asp:BoundField DataField="FPrice" HeaderText="F. Price" />
                            <asp:BoundField DataField="Bill" HeaderText="Bill" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                             </td>
                        </tr>
                        <tr align="center">
                            <td align="center"colspan="6"  >
                                
                                <asp:Button ID="Button4" runat="server" Text="Preview" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="Button5" runat="server" Text="Add" onclick="Button2_Click" />
                                
                             </td>
                        </tr>

                        </asp:Panel>
                              </table>
                    </asp:Panel>
                   
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

