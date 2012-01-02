<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumns(iGridView1);
        } 
        if (Session["CostAnalysisData"] == null)
        {
            List<CostAnalysisData> list = new List<CostAnalysisData>()
            {
                new CostAnalysisData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="UK",Model="RMC30DM1",Status="Done",
                StatusDate ="2011/02/06", GrossProfitUS="1850.00",Sales="Frank",InvUSD="2600.00",InvDate="2010/12/30",InvNo="W201012003",IMA="Dave",VenderNo="075",VenderName="NetDB",IMACostCurrency="AUE",IMACost="600.00",SubCostUSD="750.00",Prepay="500.00",
                Preunpay = "250.00",TotalPayment="500.00",PaymentDate="2011/01/02",PRNo="PR10206"},
                new CostAnalysisData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="JP",Model="RMC30D",Status="In Pregress",
                StatusDate ="2011/03/06", GrossProfitUS="3000.00",Sales="Frank",InvUSD="5000.00",InvDate="2011/02/04",InvNo="W201012002",IMA="Dave",VenderNo="072",VenderName="III",IMACostCurrency="USD",IMACost="2000.00",SubCostUSD="2000.00",Unpay="2000.00"},
                new CostAnalysisData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="TW",Model="RMC30D",Status="Done",
                StatusDate ="2011/03/06", GrossProfitUS="100.00",Sales="Frank",InvUSD="3100.00",InvDate="2011/02/04",InvNo="W201012002",IMA="Gary",VenderNo="071",VenderName="Sun",IMACostCurrency="USD",IMACost="3000.00",SubCostUSD="3000.00",Payable="3000.00"},
                new CostAnalysisData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="TW",Model="RMC30D",Status="Done",
                StatusDate ="2011/03/06", GrossProfitUS="1450.00",Sales="Frank",InvUSD="3100.00",InvDate="2011/02/04",InvNo="W201012002",IMA="Gary",VenderNo="071",VenderName="Sun",IMACostCurrency="USD",IMACost="1650.00",SubCostUSD="1650.00",Payment="1650.00",TotalPayment="1650.00",PaymentDate="2011/03/12",PRNo="PR10427"},
                new CostAnalysisData(){ SubCostUSD="7400.00", Prepay="500.00",Preunpay="250.00",Unpay="2000.00",Payable="3000.00",Payment="1650.00",TotalPayment="1650.00"}
           };
           Session["CostAnalysisData"] = list;
        }
        iGridView1.DataSource= (List<CostAnalysisData>)Session["CostAnalysisData"];
        iGridView1.DataBind();
        
    }

    private void SetMergedHerderColumns(iGridView iGridView1) {
        iGridView1.AddMergedColumns("Status", 6, 2);
        iGridView1.AddMergedColumns("Vender", 15, 2);
        iGridView1.AddMergedColumns("IMA Cost", 17, 2);
        iGridView1.AddMergedColumns("Prepayment", 20,2);
        iGridView1.AddMergedColumns("Payment", 25, 2);
    }
    
    
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<CostAnalysisData>)(Session["CostAnalysisData"])).Count;
        row.Cells[19].CssClass = "HighLight";
        if (i == count-1)
        {
            for (int k = 19 ; k <= 25; k++)
            {
                row.Cells[k].CssClass = "HighLight1";
            }
        }
        i++;
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
    .HighLight1
    {
        background-color:orange;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  毛利分析
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
                                IMA :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList5" runat="server" 
                                    DataSourceID="SqlDataSource3" DataTextField='fname'  
                                    DataValueField="id" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
                                    SelectCommand="SELECT * FROM [employee] WHERE ([accessprivilege] = @accessprivilege)">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="6" Name="accessprivilege" Type="Byte" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                             <th align="left" width="13%">
                                 Project No. :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Client :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList6" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Open Project Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser4" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser5" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <th align="left" width="13%">
                                Country :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList7" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
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
                                Project Status :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Done</asp:ListItem>
                                    <asp:ListItem>Cancelled</asp:ListItem>
                                    <asp:ListItem>In Progress</asp:ListItem>
                                    <asp:ListItem>Open</asp:ListItem>
                                    <asp:ListItem>Void</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <th align="left" width="13%">
                                Status Date : </th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser3" runat="server" />
                            </td>
                             <th align="left" width="13%">
                                 To :&nbsp;</th>
                            <td width="20%">
                                <uc1:DateChooser ID="DateChooser6" runat="server" />
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
                                
                                <asp:Button ID="Button2" runat="server" Text="Excel" />
                                
                            </td>
                        </tr>
                        
                       
                   <tr><td colspan="6">
                    <cc1:iGridView ID="iGridView1" runat="server" Height="300px" Width="920px" isMergedHeader="True" isHeaderColMerged="true" SkinID="GridView"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Project No">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ProjectNo") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" 
                                        NavigateUrl='<%# Bind("ProjectNo","http://tw.yahoo.com?id={0}") %>' 
                                        Text='<%# Bind("ProjectNo") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:BoundField DataField="GrossProfitUS" HeaderText="Gross Profit US" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="InvUSD" HeaderText="Inv USD" />
                            <asp:BoundField DataField="InvDate" HeaderText="Inv Date" />
                            <asp:BoundField DataField="InvNo" HeaderText="Inv No" />
                            <asp:BoundField DataField="ReceiveDate" HeaderText="Receive Date" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA" />
                            <asp:BoundField DataField="VenderNo" HeaderText="No" />
                            <asp:BoundField DataField="VenderName" HeaderText="Name" />
                            <asp:BoundField DataField="IMACost" HeaderText="IMACost" />
                            <asp:BoundField DataField="IMACostCurrency" HeaderText="幣別" />
                            <asp:BoundField DataField="SubCostUSD" HeaderText="SubCost USD" />
                            <asp:BoundField DataField="Prepay" HeaderText="Prepay" />
                            <asp:BoundField DataField="Preunpay" HeaderText="Preunpay" />
                            <asp:BoundField DataField="Unpay" HeaderText="Unpay" />
                            <asp:BoundField DataField="Payable" HeaderText="Payable" />
                            <asp:BoundField DataField="Payment" HeaderText="Payment" />
                            <asp:BoundField DataField="TotalPayment" HeaderText="$" />
                            <asp:BoundField DataField="PaymentDate" HeaderText="Date" />
                            <asp:BoundField DataField="PRNo" HeaderText="PR No" />
                        </Columns>
                    </cc1:iGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

