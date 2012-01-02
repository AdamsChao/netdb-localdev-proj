<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["InvoiceARAnalysisData"] == null)
        {
            List<ARAnalysisData> list = new List<ARAnalysisData>()
            {
                new ARAnalysisData(){ InvoiceNo="W201107003", InvoiceDate = "2011/06/30",Client="Apple",USD="241.30",Day30P="0.00%",Day60P="100.00%",Day90P="0.00%",Day120P="0.00%",Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day30USD="241.30"},
                new ARAnalysisData(){ InvoiceNo="W201107002", InvoiceDate = "2011/06/21",Client="三爽",USD="2100.00",Day30P="0.00%",Day60P="0.00%",Day90P="0.00%",Day120P="100.00%",Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day120USD="2100.00"},
                new ARAnalysisData(){ InvoiceNo="Total : ",USD="2341.30",Day30P=(241.3/2341.30*100).ToString("F2%"),Day60P="0.00%",Day90P="0.00%",Day120P=(2100/2341.30*100).ToString("F2%"),Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day120USD="2100.00",Day30USD="241.30"}
            };
            Session["InvoiceARAnalysisData"] = list;
        }
        if (Session["ClientARAnalysisData"] == null)
        {
            List<ARAnalysisData> list = new List<ARAnalysisData>()
            {
                new ARAnalysisData(){ Client="Apple",USD="241.30",Day30P="0.00%",Day60P="100.00%",Day90P="0.00%",Day120P="0.00%",Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day30USD="241.30"},
                new ARAnalysisData(){ Client="三爽",USD="2100.00",Day30P="0.00%",Day60P="0.00%",Day90P="0.00%",Day120P="100.00%",Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day120USD="2100.00"},
                new ARAnalysisData(){ Client="Total : ",USD="2341.30",Day30P=(241.3/2341.30*100).ToString("F2%"),Day60P="0.00%",Day90P="0.00%",Day120P=(2100/2341.30*100).ToString("F2%"),Day150P="0.00%",Day180P="0.00%",Day365P="0.00%",Year1P="0.00%",Year2P="0.00%",Day120USD="2100.00",Day30USD="241.30"}
            };
            Session["ClientARAnalysisData"] = list;
        }
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumns(iGridView1, 4);
            SetMergedHerderColumns(iGridView2, 2);
        } 
    }

    private void SetMergedHerderColumns(iGridView iGridView1,int idx) {
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
            list = (List<ARAnalysisData>)(Session["InvoiceARAnalysisData"]);
            iGridView1.DataSource = list;
            iGridView1.DataBind();
        }
        else
        {
            iGridView1.Visible = false;
            iGridView2.Visible = true;
            list = (List<ARAnalysisData>)(Session["ClientARAnalysisData"]);
            iGridView2.DataSource = list;
            iGridView2.DataBind();
        }
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
    .style1
    {
        height: 57px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  Accounts Receivable Aging Schedule
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="920">
                        <tr>
                            
                            <th align="left" width="13%" class="style1">
                                Issue Invoice Date : </th>
                            <td width="20%" class="style1">
                                <uc1:DateChooser ID="DateChooser1" runat="server" />
                            </td>
                             <th align="left" width="13%" class="style1">
                                 To :&nbsp;</th>
                            <td width="20%" class="style1">
                                <uc1:DateChooser ID="DateChooser2" runat="server" />
                            </td>
                            <td width="33%" colspan="2" class="style1">
                               
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
                                 <asp:Button ID="Button7" runat="server" Text="Excel" />
                               
                            </td>
                        </tr>
                        
                       
                   <tr><td colspan="6">
                    <cc1:iGridView ID="iGridView1" runat="server" Height="300px" Width="920px" isMergedHeader="true" SkinID="GridView"
                        DefaultColumnWidth="80px" AutoGenerateColumns="false" CssClass="Gridview" Visible="false"
                           onrowdatabound="iGridView1_RowDataBound" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
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
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView2" runat="server" Height="300px" Width="920px" isMergedHeader="true"
                        DefaultColumnWidth="80px" AutoGenerateColumns="false" CssClass="Gridview" Visible="false"
                           onrowdatabound="iGridView1_RowDataBound" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
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
                    </cc1:iGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

