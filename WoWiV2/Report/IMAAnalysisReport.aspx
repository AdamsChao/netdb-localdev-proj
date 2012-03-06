<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">
    QuotationModel.QuotationEntities db = new QuotationModel.QuotationEntities();
    WoWiModel.WoWiEntities wowidb = new WoWiModel.WoWiEntities();
    protected void Page_Load(object sender, EventArgs e)
    {
        SetGridViewHidden();
        if (Page.IsPostBack == false)
        {
            SetMergedHerderColumnsMonthReport(iGridView1,2);

            SetMergedHerderColumnsSeasionReport(iGridView2,2);

            SetMergedHerderColumnsIntervalReport(iGridView3,2);

            SetMergedHerderColumnsMonthReport(iGridView4, 1);

            SetMergedHerderColumnsSeasionReport(iGridView5, 1);

            SetMergedHerderColumnsIntervalReport(iGridView6, 1);

            SetMergedHerderColumnsMonthReport(iGridView7, 4);

            SetMergedHerderColumnsSeasionReport(iGridView8, 4);

            SetMergedHerderColumnsIntervalReport(iGridView9, 4);
        }
        
        
    }


    protected void SetMergedHerderColumnsMonthReport(iRowSpanGridView iGridView1, int idx)
    {
        iGridView1.AddMergedColumns("Jan", idx, 2);
        iGridView1.AddMergedColumns("Feb", idx+2, 2);
        iGridView1.AddMergedColumns("Mar", idx + 4, 2);
        iGridView1.AddMergedColumns("Apr", idx + 6, 2);
        iGridView1.AddMergedColumns("May", idx + 8, 2);
        iGridView1.AddMergedColumns("Jun", idx + 10, 2);
        iGridView1.AddMergedColumns("Jul", idx + 12, 2);
        iGridView1.AddMergedColumns("Aug", idx + 14, 2);
        iGridView1.AddMergedColumns("Sep", idx + 16, 2);
        iGridView1.AddMergedColumns("Oct", idx + 18, 2);
        iGridView1.AddMergedColumns("Nov", idx + 20, 2);
        iGridView1.AddMergedColumns("Dec", idx + 22, 2);
        iGridView1.AddMergedColumns("Balance Total", idx + 24, 2);
        
    }
    protected void SetMergedHerderColumnsSeasionReport(iRowSpanGridView iGridView1, int idx)
    {
        iGridView1.AddMergedColumns("Jan ~ Mar", idx, 2);
        iGridView1.AddMergedColumns("Apr ~ Jun", idx + 2, 2);
        iGridView1.AddMergedColumns("Jul ~ Sep", idx + 4, 2);
        iGridView1.AddMergedColumns("Oct ~ Dec", idx + 6, 2);
        iGridView1.AddMergedColumns("Balance Total", idx + 8, 2);
    }
    protected void SetMergedHerderColumnsIntervalReport(iRowSpanGridView iGridView1, int idx)
    {
        iGridView1.AddMergedColumns("Ballance Total", idx, 2);
    }
    
    private int i = 0;
    protected void iGridView1_SetCSSClass(GridViewRow row)
    {
        //int count = ((List<IMAReportData>)(Session["IMAReportData"])).Count;
        //if (row.Cells[17].Text == "NTD")
        //{
        //    row.Cells[13].CssClass = "HighLight";
        //}
        //else
        //{
        //    row.Cells[14].CssClass = "HighLight";
        //}
        //row.Cells[17].Visible = false;
        //if (i == count - 1 || i == count - 2)
        //{
        //    for (int k = 12; k <= 14; k++)
        //    {
        //        row.Cells[k].CssClass = "HighLight1";
        //    }
        //}
        
        //i++;
    }

     public override void VerifyRenderingInServerForm(Control control)
    {
        
    }


     protected void btnExport_Click(object sender, EventArgs e)
     {
         String report = ddlReport.SelectedValue;
         String year = ddlYear.SelectedValue;
         String type = ddlType.SelectedValue;
         GridView gv = iGridView9;
         if (report == "1")//認證成員成本分析
         {

             if (type == "1")//月
             {
                 gv = iGridView1;
             }
             else if (type == "2")//季
             {
                 gv = iGridView2;
             }
             else//區間
             {
                 gv = iGridView3;
             }
         }
         else if (report == "2")//<廠商成本案件分析總表
         {

             if (type == "1")//月
             {
                 gv = iGridView4;
             }
             else if (type == "2")//季
             {
                 gv = iGridView5;
             }
             else//區間
             {

                 gv = iGridView6;
             }
         }
         else if (report == "3")//廠商成本案件分析明細
         {

             if (type == "1")//月
             {
                 gv = iGridView7;
             }
             else if (type == "2")//季
             {
                 gv = iGridView8;
             }
             else//區間
             {

                 gv = iGridView9;
             }
         }
         Utils.ExportExcel(gv, "IMAAnalysisReport");
     }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //SetGridViewHidden();
        String report = ddlReport.SelectedValue;
        String year = ddlYear.SelectedValue;
        String type = ddlType.SelectedValue;
     
        if (report == "1")//認證成員成本分析
        {
           
            if (type == "1")//月
            {
                List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>()
                {
                   new IMAVenderCostMonthReportData(){ IMA="Sandy",VenderName="NetDB"},
                   new IMAVenderCostMonthReportData(){ IMA="Sandy",VenderName="Oracle"},
                   new IMAVenderCostMonthReportData(){ IMA="Total : "},
                   new IMAVenderCostMonthReportData(){ IMA="Balance Total : "}
                };
                iGridView1.Visible = true;
                iGridView1.SetHeaderText(26, int.Parse(year)-1911 + "年度 Total Balance");
                iGridView1.DataSource = list;
                iGridView1.DataBind();
            }
            else if (type == "2")//季
            {
                List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>()
                {
                   new IMAVenderCostSeasonReportData(){ IMA="Sandy",VenderName="NetDB"},
                   new IMAVenderCostSeasonReportData(){ IMA="Sandy",VenderName="Oracle"},
                   new IMAVenderCostSeasonReportData(){ IMA="Total : "},
                   new IMAVenderCostSeasonReportData(){ IMA="Balance Total : "}
                };
                iGridView2.Visible = true;
                iGridView2.SetHeaderText(10, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView2.DataSource = list;
                iGridView2.DataBind();
            }
            else//區間
            {
                List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>()
                {
                  new IMAVenderCostIntervalReportData(){ IMA="Sandy",VenderName="NetDB"},
                   new IMAVenderCostIntervalReportData(){ IMA="Sandy",VenderName="Oracle"},
                   new IMAVenderCostIntervalReportData(){ IMA="Total : "},
                   new IMAVenderCostIntervalReportData(){ IMA="Balance Total : "}
                };
                iGridView3.Visible = true;
                iGridView3.SetHeaderText(2, String.Format("{0} To {1}",dcFrom.GetText(),dcTo.GetText()));
                iGridView3.DataSource = list;
                iGridView3.DataBind();
            }
        }
        else if (report == "2")//<廠商成本案件分析總表
        {
           
            if (type == "1")//月
            {
                List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>()
                {
                   new IMAVenderCostMonthReportData(){ VenderName="NetDB"},
                   new IMAVenderCostMonthReportData(){ VenderName="Oracle"},
                   new IMAVenderCostMonthReportData(){ VenderName="Total : "}
                };
                iGridView4.Visible = true;
                iGridView4.SetHeaderText(25, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView4.DataSource = list;
                iGridView4.DataBind();
            }
            else if (type == "2")//季
            {
                 List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>()
                {
                   new IMAVenderCostSeasonReportData(){ VenderName="NetDB"},
                   new IMAVenderCostSeasonReportData(){ VenderName="Oracle"},
                   new IMAVenderCostSeasonReportData(){ VenderName="Total : "}
                };
                iGridView5.Visible = true;
                iGridView5.SetHeaderText(9, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView5.DataSource = list;
                iGridView5.DataBind();
            }
            else//區間
            {
               
                List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>()
                {
                   new IMAVenderCostIntervalReportData(){ VenderName="NetDB"},
                   new IMAVenderCostIntervalReportData(){ VenderName="Oracle"},
                   new IMAVenderCostIntervalReportData(){ VenderName="Total : "}
                };
                iGridView6.Visible = true;
                iGridView6.SetHeaderText(1, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView6.DataSource = list;
                iGridView6.DataBind();
            }
        }
        else if (report == "3")//廠商成本案件分析明細
        {

            if (type == "1")//月
            {
                List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>()
                {
                   new IMAVenderCostMonthReportData(){ VenderName="NetDB", Client="Samgsung"},
                   new IMAVenderCostMonthReportData(){ VenderName="Oracle",Client="Samgsung"},
                   new IMAVenderCostMonthReportData(){ VenderName="Total : "}
                };
                iGridView7.Visible = true;
                iGridView7.SetHeaderText(28, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView7.DataSource = list;
                iGridView7.DataBind();
            }
            else if (type == "2")//季
            {
                List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>()
                {
                   new IMAVenderCostSeasonReportData(){ VenderName="NetDB", Client="Samgsung"},
                   new IMAVenderCostSeasonReportData(){ VenderName="Oracle",Client="Samgsung"},
                   new IMAVenderCostSeasonReportData(){ VenderName="Total : "}
                };
                iGridView8.Visible = true;
                iGridView8.SetHeaderText(12, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView8.DataSource = list;
                iGridView8.DataBind();
            }
            else//區間
            {

                List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>()
                {
                    new IMAVenderCostIntervalReportData(){ VenderName="NetDB", Client="Samgsung"},
                   new IMAVenderCostIntervalReportData(){ VenderName="Oracle",Client="Samgsung"},
                   new IMAVenderCostIntervalReportData(){ VenderName="Total : "}
                };
                iGridView9.Visible = true;
                iGridView9.SetHeaderText(4, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView9.DataSource = list;
                iGridView9.DataBind();
            }
        }
    }


    protected void SetGridViewHidden()
    {
        iGridView1.Visible = false;
        iGridView2.Visible = false;
        iGridView3.Visible = false;
        iGridView4.Visible = false;
        iGridView5.Visible = false;
        iGridView6.Visible = false;
        iGridView7.Visible = false;
        iGridView8.Visible = false;
        iGridView9.Visible = false;
    }


    protected void ddlYear_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        int year = DateTime.Now.Year;
        for (int i = 0; i < 5; i++)
        {
            (sender as DropDownList).Items.Add((year-i).ToString());
        }
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if ((sender as DropDownList).SelectedValue == "3")
        {
            IntervalPanel.Visible = true;
        }
        else
        {
            IntervalPanel.Visible = false;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
      IMA Analysis Report
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                      
                        <tr>
                             <th align="left" width="13%">
                                 Report Type&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlReport" runat="server"   
                                    AppendDataBoundItems="True">
                                    <asp:ListItem Value="1">認證人員成本分析</asp:ListItem>
                                    <asp:ListItem Value="2">廠商成本案件分析總表</asp:ListItem>
                                    <asp:ListItem Value="3">廠商成本案件分析明細</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Year :
                                <asp:DropDownList ID="ddlYear" runat="server" onload="ddlYear_Load">
                                </asp:DropDownList>
                                &nbsp;&nbsp;
                                Type :
                                <asp:DropDownList ID="ddlType" runat="server" style="height: 22px" 
                                    AutoPostBack="True" onselectedindexchanged="ddlType_SelectedIndexChanged">
                                    <asp:ListItem Value="1">月</asp:ListItem>
                                    <asp:ListItem Value="2">季</asp:ListItem>
                                    <asp:ListItem Value="3">指定區間</asp:ListItem>
                                </asp:DropDownList>
                                <asp:Panel ID="IntervalPanel" runat="server" Visible="false" >   
                                Open Project Date : 
                                <uc1:DateChooser ID="dcFrom" runat="server" />
                   &nbsp;&nbsp;
                                 To :
                                <uc1:DateChooser ID="dcTo" runat="server" />
                                </asp:Panel> 

                            </td>
                            <td  align="center">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" onclick="Button1_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnExport" runat="server" Text="Excel" Enabled="False" />
                            </td>
                        </tr>
                    <tr><td colspan="4">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server" Width="100%" isMergedHeader="True" 
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" >

                        <Columns>
                            <asp:BoundField DataField="IMA" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="VenderName" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView2" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                       AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" >
                        <Columns>
                            <asp:BoundField DataField="IMA" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="VenderName" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView3" runat="server" Width="100%"
                           isMergedHeader="False" isHeaderColMerged="true" AutoGenerateColumns="False" 
                           CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass"  >
                        <Columns>
                            <asp:BoundField DataField="IMA" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="VenderName" HeaderText="IMA/Vender" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                                <cc1:iRowSpanGridView ID="iGridView4" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" >
                        <Columns>
                            <asp:BoundField DataField="VenderName" HeaderText="Vender/Month" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    
                    <cc1:iRowSpanGridView ID="iGridView5" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true"
 AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" >
                        <Columns>
                            <asp:BoundField DataField="VenderName" HeaderText="Vender/Month" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView><cc1:iRowSpanGridView ID="iGridView6" runat="server" Width="100%"
                           isMergedHeader="True" isHeaderColMerged="true" 
                           AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" >

                        <Columns>
                            <asp:BoundField DataField="VenderName" HeaderText="Vender/Month" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView7" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                       AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass"  >
                     <Columns>
                             <asp:BoundField DataField="VenderName" HeaderText="Vender" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" />
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView8" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                      AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass"  >
                       <Columns>
                            <asp:BoundField DataField="VenderName" HeaderText="Vender" />
                            <asp:BoundField DataField="Client" HeaderText="Client" />
                            <asp:BoundField DataField="Model" HeaderText="Model" />
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" />
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView9" runat="server" Width="100%"
                           isMergedHeader="True" isHeaderColMerged="True" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass"  >
                    </cc1:iRowSpanGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
      <Triggers>
          <asp:PostBackTrigger ControlID="btnExport" />
      </Triggers>
   </asp:UpdatePanel>
</asp:Content>

