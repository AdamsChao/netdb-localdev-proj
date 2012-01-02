<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PaymentDataList"] == null)
        {
            List<PaymentData> list = new List<PaymentData>()
            {
               new PaymentData(){ PRNo="PR10501", PRDate = "2011/06/30",VenderNo="021",Vender="Banana",Status="Done",IMA="八來",Model="MIB2000",Country="TW",IMACost="US$600", IMACostUSD="US$600",QutationNo="I1110085",PaymentTerms="60",PRCurrency="US$",PRUSD="600.00",PRNTD="17400.00"},
               new PaymentData(){ PRNo="PR10500", PRDate = "2011/06/15",VenderNo="020",Vender="Guava",Status="Done",IMA="阿信",Model="MIDT10B",Country="Iraq",IMACost="NT$31500", IMACostUSD="US$1086.21",QutationNo="I1110081",PaymentTerms="100",PRCurrency="NT$",PRUSD="1086.21",PRNTD="31500.00"},
               new PaymentData(){ PRNo="PR10599", PRDate = "2011/06/11",VenderNo="021",Vender="Banana",Status="Done",IMA="和尚",Model="ABS168",Country="JP",IMACost="NT$31500", IMACostUSD="US$1086.21",QutationNo="I1110077",PaymentTerms="20",PRCurrency="NT$",PRUSD="1086.21",PRNTD="31500.00"},
               new PaymentData(){ PRCurrency="Total:",PRUSD="2772.42",PRNTD="80400.00"},
               new PaymentData(){ PRCurrency="Issue Invoice Total:",PRUSD="2172.42.1",PRNTD="63000.00"}
            };
            
            Session["PaymentDataList"] = list;
        }
        iGridView1.DataSource = (List<PaymentData>)(Session["PaymentDataList"]);
        iGridView1.DataBind();
    }
    private int listsize;
    private int i = 1;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        int count = ((List<PaymentData>)(Session["PaymentDataList"])).Count;

        if ( i == (count - 1))
        {
            row.Cells[16].Controls[0].Visible = false;
            row.Cells[17].CssClass = "HighLight";
            row.Cells[18].CssClass = "HighLight";
            row.Cells[19].CssClass = "HighLight";
        }else if(i == count){
            row.Cells[16].Controls[0].Visible = false;
            row.Cells[17].CssClass = "HighLight1";
            row.Cells[18].CssClass = "HighLight1";
            row.Cells[19].CssClass = "HighLight1";
        }
        else
        {
            if (row.Cells[17].Text == "US$")
            {
                row.Cells[18].CssClass = "HighLight";
            }
            else
            {
                row.Cells[19].CssClass = "HighLight";
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
        font-weight:bold;
    }
    .HighLight
    {
        background-color:yellow;
    }
    .HighLight1
    {
        background-color:orange;
    }
    .Total
    {
         font-weight:bold;
         font-style:italic;
         background-color:yellow;   
    }
    .Disable
    {
        
    }
  
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
  Payment Management
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
          Height="300px" Width="920px" 
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" 
                        onsetcssclass="iGridView1_SetCSSClass"  >
<%--<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>--%>
                        <Columns>
                            <asp:BoundField DataField="PRNo" HeaderText="PR No" />
                            <asp:BoundField DataField="PRDate" HeaderText="PR Date" />
                            <asp:BoundField DataField="ProjectNo" HeaderText="Project No" />
                            <asp:BoundField DataField="VenderNo" HeaderText="Vender No" />
                            <asp:BoundField DataField="Vender" HeaderText="Vender" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:BoundField DataField="IMA" HeaderText="IMA"  />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="Country" />
                            <asp:BoundField DataField="IMACost" HeaderText="IMA Cost $" />
                            <asp:BoundField DataField="IMACostUSD" HeaderText="IMA Cost US$" />
                            <asp:BoundField DataField="QutationNo" HeaderText="Qutation No" />
                            <asp:BoundField DataField="PaymentTerms" HeaderText="收款天數" />
                            <asp:BoundField DataField="PlanDueDate" HeaderText="預計收款日" />
                            <asp:BoundField DataField="OverDueDays" HeaderText="逾期天數" />
                            <asp:BoundField DataField="OverDueInterval" HeaderText="逾期區間" />
                            <asp:ButtonField CommandName="MyUpdate" Text="Update" ButtonType="Button" />
                            <asp:BoundField DataField="PRCurrency" HeaderText="PR Balance" />
                            <asp:BoundField DataField="PRUSD" HeaderText="PR US$" />
                            <asp:BoundField DataField="PRNTD" HeaderText="PR NT$" />
                            
                        </Columns>
                    </cc1:iGridView>
                   
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

