<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="../UserControls/DateChooser.ascx" tagname="DateChooser" tagprefix="uc1" %>

<%@ Register assembly="iServerControls" namespace="iControls.Web" tagprefix="cc1" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        SetGridViewHidden();
        if (Page.IsPostBack == false)
        {
            

            SetMergedHerderColumnsMonthReport(iGridView7, 1);

            SetMergedHerderColumnsSeasonReport(iGridView8, 1);

            SetMergedHerderColumnsIntervalReport(iGridView9, 1);
            
            SetMergedHerderColumnsMonthReport(iGridView10, 2);

            SetMergedHerderColumnsSeasonReport(iGridView11, 2);

            SetMergedHerderColumnsIntervalReport(iGridView12, 2);

            //SetMergedHerderColumnsReport(iGridView13, 2);

            SetMergedHerderColumnsReport(iGridView14, 1);

            SetMergedHerderColumnsReport(iGridView15, 1);
            
            //SetMergedHerderColumnsMonthReport(iGridView16, 1);

            SetMergedHerderColumnsReport(iGridView17, 2);

            SetMergedHerderColumnsReport(iGridView18, 2);
        }
        
        
    }

    protected void SetMergedHerderColumnsReport(iGridView iGridView1, int idx)
    {
        iGridView1.AddMergedColumns("Samsung", idx, 2);
        iGridView1.AddMergedColumns("亞旭", idx + 2, 2);
        iGridView1.AddMergedColumns("凱碩", idx + 4, 2);
        iGridView1.AddMergedColumns("奇美", idx + 6, 2);
        iGridView1.AddMergedColumns("Balance Total", idx + 8, 2);
    }
    
    protected void SetMergedHerderColumnsMonthReport(iGridView iGridView1, int idx)
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
    protected void SetMergedHerderColumnsSeasonReport(iGridView iGridView1,int idx)
    {
        iGridView1.AddMergedColumns("Jan ~ Mar", idx, 2);
        iGridView1.AddMergedColumns("Apr ~ Jun", idx + 2, 2);
        iGridView1.AddMergedColumns("Jul ~ Sep", idx + 4, 2);
        iGridView1.AddMergedColumns("Oct ~ Dec", idx + 6, 2);
        iGridView1.AddMergedColumns("Balance Total", idx + 8, 2);
    }
    protected void SetMergedHerderColumnsIntervalReport(iGridView iGridView1,int idx)
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



    protected void Button1_Click(object sender, EventArgs e)
    {

        String report = ddlReport.SelectedValue;
        String year = ddlYear.SelectedValue;
        String type = ddlType.SelectedValue;
     
        if (report == "1")//業務銷售分析
        {                   
                            
            if (type == "1")//月
            {
                List<SalesClientMothReportData> list = new List<SalesClientMothReportData>()
                {
                   new SalesClientMothReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientMothReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientMothReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientMothReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView1.Visible = true;
                iGridView1.DataSource = list;
                iGridView1.DataBind();
            }
            else if (type == "2")//季
            {
                List<SalesClientSeasonReportData> list = new List<SalesClientSeasonReportData>()
                {
                   new SalesClientSeasonReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientSeasonReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientSeasonReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientSeasonReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView2.Visible = true;
                iGridView2.DataSource = list;
                iGridView2.DataBind();
            }
            else//區間
            {
                List<SalesClientIntervalReportData> list = new List<SalesClientIntervalReportData>()
                {
                   new SalesClientIntervalReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientIntervalReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientIntervalReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientIntervalReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView3.Visible = true;
                //iGridView3.SetHeaderText(2, String.Format("{0} To {1}",dcFrom.GetText(),dcTo.GetText()));
                iGridView3.DataSource = list;
                iGridView3.DataBind();
            }
        }
        else if (report == "2")//客戶期間分析
        {                        
                                 
            if (type == "1")//月 
            {
                List<SalesClientMothReportData> list = new List<SalesClientMothReportData>()
                {
                   new SalesClientMothReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientMothReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientMothReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientMothReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView4.Visible = true;
                iGridView4.DataSource = list;
                iGridView4.DataBind();
            }
            else if (type == "2")//季
            {
                List<SalesClientSeasonReportData> list = new List<SalesClientSeasonReportData>()
                {
                   new SalesClientSeasonReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientSeasonReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientSeasonReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientSeasonReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView5.Visible = true;
                iGridView5.DataSource = list;
                iGridView5.DataBind();
            }
            else//區間
            {

                List<SalesClientIntervalReportData> list = new List<SalesClientIntervalReportData>()
                {
                   new SalesClientIntervalReportData(){ Sales="Sandy",Client="NetDB"},
                   new SalesClientIntervalReportData(){ Sales="Sandy",Client="Oracle"},
                   new SalesClientIntervalReportData(){ Sales="Total : ",Client="Total : "},
                   new SalesClientIntervalReportData(){ Sales="Balance Total : ",Client="Balance Total : "}
                };
                iGridView6.Visible = true;
                iGridView6.DataSource = list;
                iGridView6.DataBind();
            }
        }
        else if (report == "3")//案件期間分析總表
        {                        
                                 
            if (type == "1")//月 
            {
                List<CountryVenderCostMonthReportData> list = new List<CountryVenderCostMonthReportData>()
                {
                   new CountryVenderCostMonthReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostMonthReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostMonthReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostMonthReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView7.Visible = true;
                iGridView7.SetHeaderText(25, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView7.DataSource = list;
                iGridView7.DataBind();
            }
            else if (type == "2")//季
            {
                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView8.Visible = true;
                iGridView8.SetHeaderText(9, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView8.DataSource = list;
                iGridView8.DataBind();
            }
            else//區間
            {

                List<CountryVenderCostIntervalReportData> list = new List<CountryVenderCostIntervalReportData>()
                {
                   new CountryVenderCostIntervalReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostIntervalReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostIntervalReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostIntervalReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView9.Visible = true;
                iGridView9.SetHeaderText(1, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView9.DataSource = list;
                iGridView9.DataBind();
            }
        }
        else if (report == "4")//案件期間分析明細
        {

            if (type == "1")//月 
            {
                List<CountryVenderCostMonthReportData> list = new List<CountryVenderCostMonthReportData>()
                {
                   new CountryVenderCostMonthReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostMonthReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostMonthReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostMonthReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView10.Visible = true;
                iGridView10.SetHeaderText(26, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView10.DataSource = list;
                iGridView10.DataBind();
            }
            else if (type == "2")//季
            {
                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView11.Visible = true;
                iGridView11.SetHeaderText(10, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView11.DataSource = list;
                iGridView11.DataBind();
            }
            else//區間
            {

                List<CountryVenderCostIntervalReportData> list = new List<CountryVenderCostIntervalReportData>()
                {
                   new CountryVenderCostIntervalReportData(){ Country="Jorden",Client="NetDB"},
                   new CountryVenderCostIntervalReportData(){ Country="Jorden",Client="Oracle"},
                   new CountryVenderCostIntervalReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostIntervalReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView12.Visible = true;
                iGridView12.SetHeaderText(2, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView12.DataSource = list;
                iGridView12.DataBind();
            }
        }
        else if (report == "5")//客戶期間分析總表
        {

            if (String.IsNullOrEmpty(dcFrom.GetText()))//月 
            {
            //    List<CountryVenderCostMonthReportData> list = new List<CountryVenderCostMonthReportData>()
            //    {
            //       new CountryVenderCostMonthReportData(){ Country="Jorden",Client="NetDB"},
            //       new CountryVenderCostMonthReportData(){ Country="Jorden",Client="Oracle"},
            //       new CountryVenderCostMonthReportData(){ Country="Total : ",Client="Total : "},
            //       new CountryVenderCostMonthReportData(){ Country="Balance Total : ",Client="Balance Total : "}
            //    };
            //    iGridView13.Visible = true;
            //    iGridView13.SetHeaderText(25, int.Parse(year) - 1911 + "年度 Total Balance");
            //    iGridView13.DataSource = list;
            //    iGridView13.DataBind();
            //}
            //else if (type == "2")//季
            //{
                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden TRC",Client="NetDB"},
                   new CountryVenderCostSeasonReportData(){ Country="Togo",Client="Oracle"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView14.Visible = true;
                iGridView14.SetHeaderText(9, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView14.DataSource = list;
                iGridView14.DataBind();
            }
            else//區間
            {

                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden TRC",Client="NetDB"},
                   new CountryVenderCostSeasonReportData(){ Country="Togo",Client="Oracle"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView15.Visible = true;
                iGridView15.SetHeaderText(9, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView15.DataSource = list;
                iGridView15.DataBind();
            }
        }
        else if (report == "6")//客戶期間分析明細
        {

            if (String.IsNullOrEmpty(dcFrom.GetText()))//月 
            {
            //    List<CountryVenderCostMonthReportData> list = new List<CountryVenderCostMonthReportData>()
            //    {
            //       new CountryVenderCostMonthReportData(){ Country="Jorden",Client="NetDB"},
            //       new CountryVenderCostMonthReportData(){ Country="Jorden",Client="Oracle"},
            //       new CountryVenderCostMonthReportData(){ Country="Total : ",Client="Total : "},
            //       new CountryVenderCostMonthReportData(){ Country="Balance Total : ",Client="Balance Total : "}
            //    };
            //    iGridView10.Visible = true;
            //    iGridView10.SetHeaderText(26, int.Parse(year) - 1911 + "年度 Total Balance");
            //    iGridView10.DataSource = list;
            //    iGridView10.DataBind();
            //}
            //else if (type == "2")//季
            //{
                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="WIDT120"},
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="SSG-3700"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView17.Visible = true;
                iGridView17.SetHeaderText(10, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView17.DataSource = list;
                iGridView17.DataBind();
            }
            else//區間
            {

                List<CountryVenderCostSeasonReportData> list = new List<CountryVenderCostSeasonReportData>()
                {
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="WIDT120"},
                   new CountryVenderCostSeasonReportData(){ Country="Jorden",Client="SSG-3700"},
                   new CountryVenderCostSeasonReportData(){ Country="Total : ",Client="Total : "},
                   new CountryVenderCostSeasonReportData(){ Country="Balance Total : ",Client="Balance Total : "}
                };
                iGridView18.Visible = true;
                iGridView18.SetHeaderText(10, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView18.DataSource = list;
                iGridView18.DataBind();
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
        iGridView10.Visible = false;
        iGridView11.Visible = false;
        iGridView12.Visible = false;
        iGridView13.Visible = false;
        iGridView14.Visible = false;
        iGridView15.Visible = false;
        iGridView16.Visible = false;
        iGridView17.Visible = false;
        iGridView18.Visible = false;
    }


    protected void ddlReport_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        if (ddl.SelectedIndex == 4 || ddl.SelectedIndex == 5)
        {
            ddlType.Visible = false;
        }
        else
        {
            ddlType.Visible = true;
        }
    }

    

    protected void SetHeaderText(GridViewRowEventArgs e,int idx)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            TableCell cell = (TableCell)e.Row.Controls[idx];
            cell.Text = int.Parse(ddlYear.SelectedValue) - 1911 + "年度 Total Balance";
        }
    }

    protected void SetHeaderText(GridViewRowEventArgs e, int idx,String prefix)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            TableCell cell = (TableCell)e.Row.Controls[idx];
            cell.Text = prefix+ "<br>Total Balance";
        }
    }
    //Merge First and Second Column
    TableCell firstcell;
    protected void iGridView1_CustomCellOutput(int i, HtmlTextWriter output, Control container)
    {
        TableCell cell = (TableCell)container.Controls[i];
        if (i == 0)
        {
            firstcell = cell;
        }else if( i == 1){
            if (firstcell.Text == cell.Text)
            {
                cell.ColumnSpan = 2;
                cell.RenderControl(output);
            }
            else
            {
                firstcell.RenderControl(output);
                cell.RenderControl(output);
            }
        }  
        else
        {
            
            cell.RenderControl(output);
        }
    }

    //Set Header
    protected void iGridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 14);
    }
    
    protected void iGridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 6);
    }
    protected void iGridView3_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 2, dcFrom.GetText() + " ~ "+dcFrom.GetText());
    }

    protected void iGridView4_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 13);
    }
    protected void iGridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 5);
    }
    protected void iGridView6_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        SetHeaderText(e, 1, dcFrom.GetText() + " ~ " + dcFrom.GetText());
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

    .style1
    {
        height: 53px;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
      Sales Analysis Report
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="920">
                      
                        <tr>
                             <th align="left" width="13%">
                                 Report&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlReport" runat="server" DataTextField='fname'  
                                    DataValueField="id" AppendDataBoundItems="True" AutoPostBack="True" 
                                    onselectedindexchanged="ddlReport_SelectedIndexChanged">
                                    <asp:ListItem Value="1">業務銷售分析</asp:ListItem>
                                    <asp:ListItem Value="2">客戶期間分析</asp:ListItem>
                                    <asp:ListItem Value="3">案件期間分析總表</asp:ListItem>
                                    <asp:ListItem Value="4">案件期間分析明細</asp:ListItem>
                                    <asp:ListItem Value="5">客戶期間分析總表</asp:ListItem>
                                    <asp:ListItem Value="6">客戶期間分析明細</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left" colspan="2">
                                Year :
                                <asp:DropDownList ID="ddlYear" runat="server">
                                    <asp:ListItem>2011</asp:ListItem>
                                    <asp:ListItem>2010</asp:ListItem>
                                    <asp:ListItem>2009</asp:ListItem>
                                </asp:DropDownList>
                           
                                 Type :
                                <asp:DropDownList ID="ddlType" runat="server" style="height: 22px">
                                    <asp:ListItem Value=" ">      </asp:ListItem>
                                    <asp:ListItem Value="1">月</asp:ListItem>
                                    <asp:ListItem Value="2">季</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td  align="center" colspan="2">
                                <asp:Button ID="Button1" runat="server" Text="Search" onclick="Button1_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="Button4" runat="server" Text="Excel" />
                            </td>
                        </tr>
                        <tr>
                        <th align="left" width="13%">
                                 Report&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="DropDownList1" runat="server" DataTextField='fname'  
                                    DataValueField="id" AppendDataBoundItems="True">
                                    <asp:ListItem Value="1">Open Project Date</asp:ListItem>
                                    <asp:ListItem Value="2">Issued Invoce Date</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td colspan="2">
                                From : 
                                <uc1:DateChooser ID="dcFrom" runat="server" />
                            
                            <br>
                                &nbsp;&nbsp;&nbsp; To :
                                <uc1:DateChooser ID="dcTo" runat="server" />
                            </td>
                             <td colspan="2" >
                                
                            </td>
                            
                        </tr>
                        
                       
                       
                   <tr><td colspan="6">
                    <cc1:iGridView ID="iGridView1" runat="server" Height="300px" Width="920px" 
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true" isHeaderColMerged="true"
                           onrowdatabound="iGridView1_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Month01USD" HeaderText="Jan" />
                            <asp:BoundField DataField="Month02USD" HeaderText="Feb" />
                            <asp:BoundField DataField="Month03USD" HeaderText="Mar" /> 
                            <asp:BoundField DataField="Month04USD" HeaderText="Apr" /> 
                            <asp:BoundField DataField="Month05USD" HeaderText="May" /> 
                            <asp:BoundField DataField="Month06USD" HeaderText="Jun" /> 
                            <asp:BoundField DataField="Month07USD" HeaderText="Jul" /> 
                            <asp:BoundField DataField="Month08USD" HeaderText="Aug" /> 
                            <asp:BoundField DataField="Month09USD" HeaderText="Sep" /> 
                            <asp:BoundField DataField="Month10USD" HeaderText="Oct" /> 
                            <asp:BoundField DataField="Month11USD" HeaderText="Nov" /> 
                            <asp:BoundField DataField="Month12USD" HeaderText="Dec" /> 
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" /> 
                        </Columns>
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView2" runat="server" Height="300px" Width="920px"
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" 
                           useCustomCelloutput="true"   isHeaderColMerged="true"
                           onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView2_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                             <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Season01USD" HeaderText="Jan ~ Mar" />
                            <asp:BoundField DataField="Season02USD" HeaderText="Apr ~ Jun" />
                            <asp:BoundField DataField="Season03USD" HeaderText="Jul ~ Sep" />
                            <asp:BoundField DataField="Season04USD" HeaderText="Oct ~ Dec" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                        </Columns>
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView3" runat="server" Height="300px" Width="920px" 
                          useCustomCelloutput="true"   isHeaderColMerged="true"
                           onsetcssclass="iGridView1_SetCSSClass"  DefaultColumnWidth="240"
                           onrowdatabound="iGridView3_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput"  AutoGenerateColumns="False" 
                           CssClass="Gridview"  >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                        </Columns>
                    </cc1:iGridView>
                                <cc1:iGridView ID="iGridView4" runat="server" Height="300px" 
                           Width="920px" 
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView4_RowDataBound" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Month01USD" HeaderText="Jan" />
                            <asp:BoundField DataField="Month02USD" HeaderText="Feb" />
                            <asp:BoundField DataField="Month03USD" HeaderText="Mar" /> 
                            <asp:BoundField DataField="Month04USD" HeaderText="Apr" /> 
                            <asp:BoundField DataField="Month05USD" HeaderText="May" /> 
                            <asp:BoundField DataField="Month06USD" HeaderText="Jun" /> 
                            <asp:BoundField DataField="Month07USD" HeaderText="Jul" /> 
                            <asp:BoundField DataField="Month08USD" HeaderText="Aug" /> 
                            <asp:BoundField DataField="Month09USD" HeaderText="Sep" /> 
                            <asp:BoundField DataField="Month10USD" HeaderText="Oct" /> 
                            <asp:BoundField DataField="Month11USD" HeaderText="Nov" /> 
                            <asp:BoundField DataField="Month12USD" HeaderText="Dec" /> 
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" /> 
                       </Columns>
                    </cc1:iGridView>
                    
                    <cc1:iGridView ID="iGridView5" runat="server" Height="300px" Width="920px"  onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView5_RowDataBound" 
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                        
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Season01USD" HeaderText="Jan ~ Mar" />
                            <asp:BoundField DataField="Season02USD" HeaderText="Apr ~ Jun" />
                            <asp:BoundField DataField="Season03USD" HeaderText="Jul ~ Sep" />
                            <asp:BoundField DataField="Season04USD" HeaderText="Oct ~ Dec" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
   
                        </Columns>
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView6" runat="server" Height="300px" 
                           Width="920px"   onrowdatabound="iGridView6_RowDataBound" 
                           AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                        </Columns>
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView7" runat="server" Height="300px" Width="920px" isMergedHeader="True" 
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
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
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView8" runat="server" Height="300px" Width="920px" isMergedHeader="True"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
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
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView9" runat="server" Height="300px" Width="920px" 
                           isMergedHeader="True" CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
 <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iGridView>
                      <cc1:iGridView ID="iGridView10" runat="server" Height="300px" Width="920px" isMergedHeader="True"  isHeaderColMerged="true"
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                         useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
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
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView11" runat="server" Height="300px" Width="920px" isMergedHeader="True" isHeaderColMerged="true"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
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
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView12" runat="server" Height="300px" Width="920px" isMergedHeader="True"  isHeaderColMerged="true"
                           CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                    <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView13" runat="server" Height="300px" Width="920px" isMergedHeader="True" 
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
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
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView14" runat="server" Height="300px" Width="920px" isMergedHeader="true"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
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
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView15" runat="server" Height="300px" Width="920px" 
                           isMergedHeader="True" CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
 <Columns>
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
                    </cc1:iGridView>
                           <cc1:iGridView ID="iGridView16" runat="server" Height="300px" Width="920px" isMergedHeader="True"  isHeaderColMerged="true"
                        DefaultColumnWidth="120px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                         useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
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
                    </cc1:iGridView>
                     <cc1:iGridView ID="iGridView17" runat="server" Height="300px" Width="920px" isMergedHeader="True" isHeaderColMerged="true"
                        DefaultColumnWidth="80px" AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" isFirstRowSpan="true"
                          useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
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
                    </cc1:iGridView>
                    <cc1:iGridView ID="iGridView18" runat="server" Height="300px" Width="920px" isMergedHeader="True"  isHeaderColMerged="true"
                           CssClass="Gridview"  AutoGenerateColumns="False" isFirstRowSpan="true"
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >
<BoundaryStyle BorderColor="Gray" BorderWidth="1px" BorderStyle="Solid"></BoundaryStyle>
                    <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
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
                    </cc1:iGridView>
                    </td>
                  </tr>
                    </table>
      </ContentTemplate>
   </asp:UpdatePanel>
</asp:Content>

