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

    protected void SetMergedHerderColumnsReport(iRowSpanGridView iGridView1, int idx)
    {
        iGridView1.AddMergedColumns("Samsung", idx, 2);
        iGridView1.AddMergedColumns("亞旭", idx + 2, 2);
        iGridView1.AddMergedColumns("凱碩", idx + 4, 2);
        iGridView1.AddMergedColumns("奇美", idx + 6, 2);
        iGridView1.AddMergedColumns("Balance Total", idx + 8, 2);
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
    protected void SetMergedHerderColumnsSeasonReport(iRowSpanGridView iGridView1, int idx)
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



    protected void Button1_Click(object sender, EventArgs e)
    {

        String report = ddlReport.SelectedValue;
        String reportType = ddlReportType.SelectedValue;
        String year = ddlYear.SelectedValue;
        String type = ddlType.SelectedValue;
        bool isEnable = false;  
        if (report == "1")//業務銷售分析
        {                   
                            
            if (type == "1")//月
            {

                List<SalesClientMonthReportData> list = null ;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetSalesClientByMonth_OpenProjDate(wowidb, int.Parse(year));
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetSalesClientByMonth_OpenProjDate(wowidb, int.Parse(year));
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView1.Visible = true;
                iGridView1.DataSource = list;
                iGridView1.DataBind();
            }
            else if (type == "2")//季
            {
                List<SalesClientSeasonReportData> list = null ;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetSalesClientBySeason_OpenProjDate(wowidb, int.Parse(year));
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetSalesClientBySeason_OpenProjDate(wowidb, int.Parse(year));
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView2.Visible = true;
                iGridView2.DataSource = list;
                iGridView2.DataBind();
            }
            else//區間
            {

                DateTime from = DateTime.MinValue;
                try
                {
                    from = dcFrom.GetDate();

                }
                catch (Exception)
                {

                    //throw;
                }
                DateTime to = DateTime.MaxValue;
                try
                {
                    to = dcTo.GetDate();

                }
                catch (Exception)
                {

                    //throw;
                }
                List<SalesClientIntervalReportData> list = null;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetSalesClientByInterval_OpenProjDate(wowidb, from, to);
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetSalesClientByInterval_OpenProjDate(wowidb, from, to);
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView3.Visible = true;
                iGridView3.SetHeaderText(2, String.Format("{0} To {1}",dcFrom.GetText(),dcTo.GetText()));
                iGridView3.DataSource = list;
                iGridView3.DataBind();
            }
        }
        else if (report == "2")//客戶期間分析
        {                        
                                 
            if (type == "1")//月 
            {
                
                List<SalesClientMonthReportData> list = null;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetClientByMonth_OpenProjDate(wowidb, int.Parse(year));
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetClientByMonth_OpenProjDate(wowidb, int.Parse(year));
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView4.Visible = true;
                iGridView4.DataSource = list;
                iGridView4.DataBind();
            }
            else if (type == "2")//季
            {
                List<SalesClientSeasonReportData> list = null;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetClientBySeason_OpenProjDate(wowidb, int.Parse(year));
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetClientBySeason_OpenProjDate(wowidb, int.Parse(year));
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView5.Visible = true;
                iGridView5.DataSource = list;
                iGridView5.DataBind();
            }
            else//區間
            {
                DateTime from = DateTime.MinValue;
                try
                {
                    from = dcFrom.GetDate();

                }
                catch (Exception)
                {

                    //throw;
                }
                DateTime to = DateTime.MaxValue;
                try
                {
                    to = dcTo.GetDate();

                }
                catch (Exception)
                {

                    //throw;
                }
                List<SalesClientIntervalReportData> list = null;
                if (reportType == "1")//Open Project Date
                {
                    list = SalesUtils.GetClientByInterval_OpenProjDate(wowidb, from, to);
                }
                else
                {
                    //Need to modify
                    list = SalesUtils.GetClientByInterval_OpenProjDate(wowidb, from, to);
                }
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
                iGridView18.Visible = true;
                iGridView18.SetHeaderText(10, String.Format("{0} To {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView18.DataSource = list;
                iGridView18.DataBind();
            }
        }

        if (isEnable)
        {
            btnExport.Enabled = true;
        }
        else
        {
            btnExport.Enabled = false;
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        
    }
 
    
    protected void ddlYear_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        int year = DateTime.Now.Year;
        for (int i = 0; i < 5; i++)
        {
            (sender as DropDownList).Items.Add((year - i).ToString());
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

    protected void btnExport_Click1(object sender, EventArgs e)
    {
        String report = ddlReport.SelectedValue;
        String year = ddlYear.SelectedValue;
        String type = ddlType.SelectedValue;
        GridView gv = iGridView9;
        if (report == "1")//業務銷售分析
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
        else if (report == "2")//客戶期間分析
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
        else if (report == "3")//案件期間分析總表
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
        else if (report == "4")//案件期間分析明細
        {

            if (type == "1")//月
            {
                gv = iGridView10;
            }
            else if (type == "2")//季
            {
                gv = iGridView11;
            }
            else//區間
            {

                gv = iGridView12;
            }
        }
        else if (report == "5")//客戶期間分析總表
        {

            if (type == "1")//月
            {
                gv = iGridView13;
            }
            else if (type == "2")//季
            {
                gv = iGridView14;
            }
            else//區間
            {

                gv = iGridView15;
            }
        }
        else if (report == "6")//客戶期間分析明細
        {

            if (type == "1")//月
            {
                gv = iGridView16;
            }
            else if (type == "2")//季
            {
                gv = iGridView17;
            }
            else//區間
            {
                gv = iGridView18;
            }
        }
        gv.Visible = true;
        Utils.ExportExcel(gv, String.Format("SalesAnalysisReport",ddlReport.SelectedItem.Text,ddlReportType.SelectedItem.Text));
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <asp:UpdatePanel runat="server">
  <ContentTemplate>
      Sales Analysis Report
                    <table align="center" border="1" cellpadding="0" cellspacing="0" width="100%">
                      
                        <tr>
                             <th align="left" width="13%">
                                 Report&nbsp; Type :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlReport" runat="server" AppendDataBoundItems="True" AutoPostBack="True" 
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
                                
                            </td>
                            <td  align="center" colspan="2">
                                   <asp:Button ID="btnSearch" runat="server" Text="Search" onclick="Button1_Click" />
                                &nbsp;&nbsp;
                                <asp:Button ID="btnExport" runat="server" Text="Excel" Enabled="False" 
                                       onclick="btnExport_Click1" />
                            </td>
                        </tr>
                        <tr>
                        <th align="left" width="13%">
                                 Report&nbsp; :&nbsp;</th>
                            <td width="20%">
                                <asp:DropDownList ID="ddlReportType" runat="server" DataTextField='fname'  
                                    DataValueField="id" AppendDataBoundItems="True">
                                    <asp:ListItem Value="1">Open Project Date</asp:ListItem>
                                    <asp:ListItem Value="2">Issued Invoce Date</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td colspan="2">
                                <asp:Panel ID="IntervalPanel" runat="server" Visible="false" >   
                                 From : 
                                <uc1:DateChooser ID="dcFrom" runat="server" />
                   &nbsp;&nbsp;
                                 To :
                                <uc1:DateChooser ID="dcTo" runat="server" />
                                </asp:Panel> 
                            </td>
                             <td colspan="2" >
                                
                            </td>
                            
                        </tr>
                        
                       
                       
                   <tr><td colspan="6">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server"  Width="100%" 
                         AutoGenerateColumns="False" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true" isHeaderColMerged="true"
                           onrowdatabound="iGridView1_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Month01USD" HeaderText="Jan" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="Feb" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="Mar" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month04USD" HeaderText="Apr" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month05USD" HeaderText="May" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month06USD" HeaderText="Jun" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month07USD" HeaderText="Jul" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month08USD" HeaderText="Aug" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month09USD" HeaderText="Sep" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month10USD" HeaderText="Oct" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month11USD" HeaderText="Nov" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month12USD" HeaderText="Dec" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/> 
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView2" runat="server"  Width="100%"
                         AutoGenerateColumns="False" CssClass="Gridview" 
                           useCustomCelloutput="true"   isHeaderColMerged="true"
                           onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView2_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput" 
                          >

                        <Columns>
                             <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Season01USD" HeaderText="Jan ~ Mar" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="Season02USD" HeaderText="Apr ~ Jun" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="Jul ~ Sep" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="Oct ~ Dec" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView3" runat="server"  Width="100%" 
                          useCustomCelloutput="true"   isHeaderColMerged="true"
                           onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView3_RowDataBound" oncustomcelloutput="iGridView1_CustomCellOutput"  AutoGenerateColumns="False" 
                           CssClass="Gridview"  >

                        <Columns>
                            <asp:BoundField DataField="Sales" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                                <cc1:iRowSpanGridView ID="iGridView4" runat="server" 
                           Width="100%" 
                         AutoGenerateColumns="False" CssClass="Gridview" 
                           onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView4_RowDataBound" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Month01USD" HeaderText="Jan" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="Feb" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="Mar" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month04USD" HeaderText="Apr" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month05USD" HeaderText="May" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month06USD" HeaderText="Jun" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month07USD" HeaderText="Jul" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month08USD" HeaderText="Aug" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month09USD" HeaderText="Sep" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month10USD" HeaderText="Oct" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month11USD" HeaderText="Nov" ItemStyle-HorizontalAlign="Right"/> 
                            <asp:BoundField DataField="Month12USD" HeaderText="Dec" ItemStyle-HorizontalAlign="Right" /> 
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/> 
                       </Columns>
                    </cc1:iRowSpanGridView>
                    
                    <cc1:iRowSpanGridView ID="iGridView5" runat="server"  Width="100%"  onsetcssclass="iGridView1_SetCSSClass" 
                           onrowdatabound="iGridView5_RowDataBound" 
                         AutoGenerateColumns="False" CssClass="Gridview" 
                          >

                        <Columns>
                        
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="Season01USD" HeaderText="Jan ~ Mar" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="Season02USD" HeaderText="Apr ~ Jun" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="Jul ~ Sep" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="Oct ~ Dec" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
   
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView6" runat="server"
                           Width="100%"   onrowdatabound="iGridView6_RowDataBound" 
                           AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Client" HeaderText="Sales/Client" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView7" runat="server"  Width="100%" isMergedHeader="True" 
                         AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView8" runat="server"  Width="100%" isMergedHeader="True"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView9" runat="server"  Width="100%" 
                           isMergedHeader="True" CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  >

 <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" />
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" />
                        </Columns>
                    </cc1:iRowSpanGridView>
                      <cc1:iRowSpanGridView ID="iGridView10" runat="server"  Width="100%" isMergedHeader="True"  isHeaderColMerged="true"
                         AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                         useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView11" runat="server"  Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView12" runat="server"  Width="100%" isMergedHeader="True"  isHeaderColMerged="true"
                           CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                    <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView13" runat="server"  Width="100%" isMergedHeader="True" 
                         AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView14" runat="server"  Width="100%" isMergedHeader="true"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                          >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView15" runat="server"  Width="100%" 
                           isMergedHeader="True" CssClass="Gridview"  AutoGenerateColumns="False" 
                           onsetcssclass="iGridView1_SetCSSClass"  >

 <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                           <cc1:iRowSpanGridView ID="iGridView16" runat="server"  Width="100%" isMergedHeader="True"  isHeaderColMerged="true"
                         AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" 
                         useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Month01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month05QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month06QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month07QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month08QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month09QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month10QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month11QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Month12QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                     <cc1:iRowSpanGridView ID="iGridView17" runat="server"  Width="100%" isMergedHeader="True" isHeaderColMerged="true"
                        AutoGenerateColumns="False" CssClass="Gridview" onsetcssclass="iGridView1_SetCSSClass" isFirstRowSpan="true"
                          useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                        <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </cc1:iRowSpanGridView>
                    <cc1:iRowSpanGridView ID="iGridView18" runat="server"  Width="100%" isMergedHeader="True"  isHeaderColMerged="true"
                           CssClass="Gridview"  AutoGenerateColumns="False" isFirstRowSpan="true"
                           onsetcssclass="iGridView1_SetCSSClass"  useCustomCelloutput="true"   oncustomcelloutput="iGridView1_CustomCellOutput" >

                    <Columns>
                            <asp:BoundField DataField="Country" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Client" HeaderText="T Description./Month" />
                            <asp:BoundField DataField="Season01USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season01QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season02QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season03QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04USD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="Season04QTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalUSD" HeaderText="US$" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField DataField="TotalQTY" HeaderText="Qty" ItemStyle-HorizontalAlign="Right"/>
                        </Columns>
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

