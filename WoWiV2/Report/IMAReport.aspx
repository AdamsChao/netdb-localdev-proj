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
        if (Session["IMAReportData"] == null)
        {
            List<IMAReportData> list = new List<IMAReportData>()
            {
                new IMAReportData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Version="Main",Country="UK",Model="RMC30DM1",Status="Done",StatusDate ="2011/02/06",IMA="Frank",VenderNo="075",VenderName="NetDB",IMACostCurrency="USD",IMACost="750.00", SubCostNTD="21750.00",SubCostUSD="750.00",PaymentDate="2011/01/02",PRNo="PR10206"},
                new IMAReportData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Version="A01",Country="UK",Model="RMC30DM1",Status="Done",StatusDate ="2011/02/06",IMA="Gary",VenderNo="060",VenderName="Sun",IMACostCurrency="NTD",IMACost="30000.00", SubCostNTD="30000.00",SubCostUSD="1034.48",PaymentDate="2011/01/02",PRNo="PR10472"},
                new IMAReportData(){ ProjectNo="10I0055", QutationNo = "I1010068",OpenDate="2010/11/24",Client="Apple",Version="A02",Country="UK",Model="RMC30DM1",Status="Done",StatusDate ="2011/02/06",IMA="Gary",VenderNo="063",VenderName="Microsoft",IMACostCurrency="ADE",IMACost="600.00", SubCostNTD="4738.00",SubCostUSD="163.38",PaymentDate="2011/01/02",PRNo="PR10472"},
                new IMAReportData(){ IMACost="Total : ",SubCostNTD="56488.02",SubCostUSD="1974.86"},
                new IMAReportData(){ IMACost="Subcontract Total : ",SubCostNTD="30000.00",SubCostUSD="913.86"},
           };
            Session["IMAReportData"] = list;
        }
        iGridView1.DataSource = (List<IMAReportData>)Session["IMAReportData"];
        iGridView1.DataBind();
        
    }

    private void SetMergedHerderColumns(iGridView iGridView1) {
        iGridView1.AddMergedColumns("Status", 7, 2);
        iGridView1.AddMergedColumns("WoWi Sub Contract", 13, 2);
    }
    
    
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<IMAReportData>)(Session["IMAReportData"])).Count;
        if (row.Cells[17].Text == "NTD")
        {
            row.Cells[13].CssClass = "HighLight";
        }
        else
        {
            row.Cells[14].CssClass = "HighLight";
        }
        row.Cells[17].Visible = false;
        if ( i == count - 2)
        {
            for (int k = 12; k <= 14; k++)
            {
                row.Cells[k].CssClass = "HighLight1";
            }
        }

        if (i == count - 1 )
        {
            for (int k = 12; k <= 14; k++)
            {
                row.Cells[k].CssClass = "HighLight";
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
  IMA Report(認證人員下單總表)
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="920">
                      
                        <tr>
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
                                PR Date : </th>
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
                                Vender Name : </th>
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
                                Keyword Search :&nbsp;&nbsp;</th>
                            <td width="20%">
                                <asp:TextBox ID="TextBox5" runat="server" Text=""></asp:TextBox>
                            </td>
                          
                            <td colspan="2" align="center">
                                <asp:Button ID="Button3" runat="server" Text="Search" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button2" runat="server" Text="Excel" />
                            </td>
                        </tr>
                       
                       
                   <tr><td colspan="6">
                    <cc1:iGridView ID="iGridView1" runat="server" Height="300px" Width="920px" isMergedHeader="True" isHeaderColMerged="true"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
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
                            <asp:BoundField DataField="Version" HeaderText="Version" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="StatusDate" HeaderText="Status Date" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA" />
                            <asp:BoundField DataField="VenderNo" HeaderText="No" />
                            <asp:BoundField DataField="VenderName" HeaderText="Name" />
                            <asp:BoundField DataField="IMACost" HeaderText="IMACost" />     
                            <asp:BoundField DataField="SubCostNTD" HeaderText="Cost NTD" />
                            <asp:BoundField DataField="SubCostUSD" HeaderText="Cost USD" />
                            <asp:BoundField DataField="PaymentDate" HeaderText="Payment Date" />
                            <asp:BoundField DataField="PRNo" HeaderText="PR No" />
                            <asp:BoundField DataField="IMACostCurrency" HeaderText="幣別" Visible="true" />
                        </Columns>
                    </cc1:iGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

