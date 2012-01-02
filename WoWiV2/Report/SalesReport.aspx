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
        if (ViewState["SalesReportData"] == null)
        {
            List<SalesReportData> list = new List<SalesReportData>()
            {
                new SalesReportData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="UK",Model="RMC30DM1",Status="Done",StatusDate ="2011/02/06",Sales="Helen",InvNTD="203000.00",InvUSD="7000.00",Currency="USD",InvoiceDate="2010/12/30", InvNo="21750.00",ReceivedDate="W201012003"},
                new SalesReportData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Country="UK",Model="RMC30DM1",Status="Done",StatusDate ="2011/02/06",Sales="Shirley",InvNTD="89900.00",InvUSD="3100.00",Currency="USD",InvoiceDate="2011/02/24", InvNo="21750.00",ReceivedDate="W201012002"},
                new SalesReportData(){ Sales="Total : ",InvNTD="292900.00",InvUSD="10100.00"},
                new SalesReportData(){ Sales="Subcontract Total : ",InvNTD="0.00",InvUSD="10100.00"}
           };
            ViewState["SalesReportData"] = list;
        }
        iGridView1.DataSource = (List<SalesReportData>)ViewState["SalesReportData"];
        iGridView1.DataBind();
        
    }

    private void SetMergedHerderColumns(iGridView iGridView1) {
        iGridView1.AddMergedColumns("Status", 6, 2);
        iGridView1.AddMergedColumns("WoWi", 9, 5);
    }
    
    
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<SalesReportData>)(ViewState["SalesReportData"])).Count;
        if (row.Cells[14].Text == "NTD")
        {
            row.Cells[9].CssClass = "HighLight";
        }
        else
        {
            row.Cells[10].CssClass = "HighLight";
        }
        row.Cells[14].Visible = false;
        if ( i == count - 2)
        {
            for (int k = 8; k <= 10; k++)
            {
                row.Cells[k].CssClass = "HighLight1";
            }
        }

        if (i == count - 1 )
        {
            for (int k = 8; k <= 10; k++)
            {
                row.Cells[k].CssClass = "HighLight";
            }
        }
        
        i++;
    }




    protected void iGridView1_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.SetRenderMethodDelegate(RenderRowData);

    }

    private void RenderRowData(HtmlTextWriter output, Control container)
    {
        int cols = container.Controls.Count;

        for (int i = 0; i < cols - 1; i++)
        {
            TableCell cell = (TableCell)container.Controls[i];
            cell.RenderControl(output);

        }
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
      Sales Report
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
                                Project No. :&nbsp;</th>
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
                                Client : </th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList8" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                             <th align="left" width="13%">
                                 Country :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList9" runat="server" AppendDataBoundItems="True">
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            
                            <th align="left" width="13%">
                                Keyword Search :&nbsp;&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox5" runat="server" Text=""></asp:TextBox>
                                <td colspan="4"  align="right">
                                <asp:Button ID="Button3" runat="server" Text="Search" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button2" runat="server" Text="Excel" />
                            </td>
                        </tr>
                       
                       
                   <tr><td colspan="6">
                    <cc1:iGridView ID="iGridView1" runat="server" Height="300px" Width="920px" 
                           isMergedHeader="True" 
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass" onrowcreated="iGridView1_RowCreated"  
                            >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:TemplateField HeaderText="Project No">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" 
                                        NavigateUrl='<%# Bind("ProjectNo","http://tw.yahoo.com?id={0}") %>' 
                                        Text='<%# Bind("ProjectNo") %>'></asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="OpenDate" HeaderText="Open Date" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:BoundField DataField="Sales" HeaderText="Sales" />
                            <asp:BoundField DataField="InvNTD" HeaderText="Inv NT$" />
                            <asp:BoundField DataField="InvUSD" HeaderText="Inv US$" />
                            <asp:BoundField DataField="InvoiceDate" HeaderText="Invoice Date" />     
                            <asp:BoundField DataField="InvNo" HeaderText="Inv #" />
                            <asp:BoundField DataField="ReceivedDate" HeaderText="Received Date" />
                            <asp:BoundField DataField="Currency" HeaderText="幣別" Visible="true" />
                        </Columns>
                    </cc1:iGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

