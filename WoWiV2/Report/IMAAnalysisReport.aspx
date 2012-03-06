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
        //btnExport.Enabled = false;
        
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
        iGridView1.AddMergedColumns("Balance Total", idx, 2);
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
         gv.Visible = true;
         Utils.ExportExcel(gv, "IMAAnalysisReport");
     }
     private List<IMAVenderCostMonthReportData> GetIMACostByMonth(int year)
     {
         List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>();
         IMAVenderCostMonthReportData temp;
         try
         {
             //Find all IMAs
             var imas = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.create_user).Distinct();

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
             decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, M5D = 0, M5Q = 0, M6D = 0, M6Q = 0, M7D = 0, M7Q = 0, M8D = 0, M8Q = 0, M9D = 0, M9Q = 0, M10D = 0, M10Q = 0, M11D = 0, M11Q = 0, M12D = 0, M12Q = 0, TotD = 0, TotQ = 0;          
             foreach (var ima in imas)
             {
                 decimal imaM1D = 0,imaM1Q = 0,imaM2D = 0,imaM2Q = 0,imaM3D = 0,imaM3Q = 0,imaM4D = 0,imaM4Q = 0,imaM5D = 0,imaM5Q = 0,imaM6D = 0,imaM6Q = 0,imaM7D = 0, imaM7Q = 0, imaM8D = 0, imaM8Q = 0, imaM9D = 0, imaM9Q = 0, imaM10D = 0, imaM10Q = 0, imaM11D = 0, imaM11Q = 0, imaM12D = 0, imaM12Q = 0, imaTotD = 0, imaTotQ = 0;
                 foreach (var ven in venders)
                 {
                     decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venM5D = 0, venM5Q = 0, venM6D = 0, venM6Q = 0, venM7D = 0, venM7Q = 0, venM8D = 0, venM8Q = 0, venM9D = 0, venM9Q = 0, venM10D = 0, venM10Q = 0, venM11D = 0, venM11Q = 0, venM12D = 0, venM12Q = 0, venTotD = 0, venTotQ = 0;
                     try
                     {
                         var prs = from pr in wowidb.PRs where pr.create_user == ima && pr.vendor_id == ven select pr;
                         temp = new IMAVenderCostMonthReportData()
                         {
                             IMA = ima
                         };
                         var v = (from i in wowidb.vendors where i.id == ven select i).First();
                         temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                         foreach (var p in prs)
                         {
                             try
                             {
                                int month = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj.Create_Date.Month).First();
                                var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                                switch (month)
                                {
                                    case 1:
                                        venM1D += (decimal)pri.amount;
                                        venM1Q += (decimal)pri.quantity;
                                        break;
                                    case 2:
                                        venM2D += (decimal)pri.amount;
                                        venM2Q += (decimal)pri.quantity;
                                        break;
                                    case 3:
                                        venM3D += (decimal)pri.amount;
                                        venM3Q += (decimal)pri.quantity;
                                        break;
                                    case 4:
                                        venM4D += (decimal)pri.amount;
                                        venM4Q += (decimal)pri.quantity;
                                        break;
                                    case 5:
                                        venM5D += (decimal)pri.amount;
                                        venM5Q += (decimal)pri.quantity;
                                        break;
                                    case 6:
                                        venM6D += (decimal)pri.amount;
                                        venM6Q += (decimal)pri.quantity;
                                        break;
                                    case 7:
                                        venM7D += (decimal)pri.amount;
                                        venM7Q += (decimal)pri.quantity;
                                        break;
                                    case 8:
                                        venM8D += (decimal)pri.amount;
                                        venM8Q += (decimal)pri.quantity;
                                        break;
                                    case 9:
                                        venM9D += (decimal)pri.amount;
                                        venM9Q += (decimal)pri.quantity;
                                        break;
                                    case 10:
                                        venM10D += (decimal)pri.amount;
                                        venM10Q += (decimal)pri.quantity;
                                        break;
                                    case 11:
                                        venM11D += (decimal)pri.amount;
                                        venM11Q += (decimal)pri.quantity;
                                        break;
                                    case 12:
                                        venM12D += (decimal)pri.amount;
                                        venM12Q += (decimal)pri.quantity;
                                        break;
                                }
                             }
                             catch (Exception)
                             {

                                 //throw;
                             }

                         }//Single vender ends
                         venTotD = venM1D + venM2D + venM3D + venM4D + venM5D + venM6D + venM7D + venM8D + venM9D + venM10D + venM11D + venM12D;
                         venTotQ = venM1Q + venM2Q + venM3Q + venM4Q + venM5Q + venM6Q + venM7Q + venM8Q + venM9Q + venM10Q + venM11Q + venM12Q;
                         imaM1D += venM1D;
                         imaM1Q += venM1Q;
                         imaM2D += venM2D;
                         imaM2Q += venM2Q;
                         imaM3D += venM3D;
                         imaM4Q += venM3Q;
                         imaM4D += venM4D;
                         imaM4Q += venM4Q;
                         imaM5D += venM5D;
                         imaM5Q += venM5Q;
                         imaM6D += venM6D;
                         imaM6Q += venM6Q;
                         imaM7D += venM7D;
                         imaM7Q += venM7Q;
                         imaM8D += venM8D;
                         imaM8Q += venM8Q;
                         imaM9D += venM9D;
                         imaM9Q += venM9Q;
                         imaM10D += venM10D;
                         imaM10Q += venM10Q;
                         imaM11D += venM11D;
                         imaM11Q += venM11Q;
                         imaM12D += venM12D;
                         imaM12Q += venM12Q;
                         imaTotD += venTotD;
                         imaTotQ += venTotQ;
                         temp.Month01USD = venM1D.ToString("F2");
                         temp.Month02USD = venM2D.ToString("F2");
                         temp.Month03USD = venM3D.ToString("F2");
                         temp.Month04USD = venM4D.ToString("F2");
                         temp.Month05USD = venM5D.ToString("F2");
                         temp.Month06USD = venM6D.ToString("F2");
                         temp.Month07USD = venM7D.ToString("F2");
                         temp.Month08USD = venM8D.ToString("F2");
                         temp.Month09USD = venM9D.ToString("F2");
                         temp.Month10USD = venM10D.ToString("F2");
                         temp.Month11USD = venM11D.ToString("F2");
                         temp.Month12USD = venM12D.ToString("F2");
                         temp.TotalUSD = venTotD.ToString("F2");
                         
                         temp.Month01QTY = venM1Q.ToString("F0");
                         temp.Month02QTY = venM2Q.ToString("F0");
                         temp.Month03QTY = venM3Q.ToString("F0");
                         temp.Month04QTY = venM4Q.ToString("F0");
                         temp.Month05QTY = venM5Q.ToString("F0");
                         temp.Month06QTY = venM6Q.ToString("F0");
                         temp.Month07QTY = venM7Q.ToString("F0");
                         temp.Month08QTY = venM8Q.ToString("F0");
                         temp.Month09QTY = venM9Q.ToString("F0");
                         temp.Month10QTY = venM10Q.ToString("F0");
                         temp.Month11QTY = venM11Q.ToString("F0");
                         temp.Month12QTY = venM12Q.ToString("F0");
                         temp.TotalQTY = venTotQ.ToString("F0");
                         list.Add(temp);
                     }
                     catch (Exception)
                     {
                         
                         //throw;
                     }
                 }//Vender ends
                 if (imaTotD != 0)
                 {
                     temp = new IMAVenderCostMonthReportData()
                     {
                         IMA = ima + " Total : "
                     };
                     M1D += imaM1D;
                     M1Q += imaM1Q;
                     M2D += imaM2D;
                     M2Q += imaM2Q;
                     M3D += imaM3D;
                     M4Q += imaM3Q;
                     M4D += imaM4D;
                     M4Q += imaM4Q;
                     M5D += imaM5D;
                     M5Q += imaM5Q;
                     M6D += imaM6D;
                     M6Q += imaM6Q;
                     M7D += imaM7D;
                     M7Q += imaM7Q;
                     M8D += imaM8D;
                     M8Q += imaM8Q;
                     M9D += imaM9D;
                     M9Q += imaM9Q;
                     M10D += imaM10D;
                     M10Q += imaM10Q;
                     M11D += imaM11D;
                     M11Q += imaM11Q;
                     M12D += imaM12D;
                     M12Q += imaM12Q;
                     TotD += imaTotD;
                     TotQ += imaTotQ;
                     temp.Month01USD = imaM1D.ToString("F2");
                     temp.Month02USD = imaM2D.ToString("F2");
                     temp.Month03USD = imaM3D.ToString("F2");
                     temp.Month04USD = imaM4D.ToString("F2");
                     temp.Month05USD = imaM5D.ToString("F2");
                     temp.Month06USD = imaM6D.ToString("F2");
                     temp.Month07USD = imaM7D.ToString("F2");
                     temp.Month08USD = imaM8D.ToString("F2");
                     temp.Month09USD = imaM9D.ToString("F2");
                     temp.Month10USD = imaM10D.ToString("F2");
                     temp.Month11USD = imaM11D.ToString("F2");
                     temp.Month12USD = imaM12D.ToString("F2");
                     temp.TotalUSD = imaTotD.ToString("F2");

                     temp.Month01QTY = imaM1Q.ToString("F0");
                     temp.Month02QTY = imaM2Q.ToString("F0");
                     temp.Month03QTY = imaM3Q.ToString("F0");
                     temp.Month04QTY = imaM4Q.ToString("F0");
                     temp.Month05QTY = imaM5Q.ToString("F0");
                     temp.Month06QTY = imaM6Q.ToString("F0");
                     temp.Month07QTY = imaM7Q.ToString("F0");
                     temp.Month08QTY = imaM8Q.ToString("F0");
                     temp.Month09QTY = imaM9Q.ToString("F0");
                     temp.Month10QTY = imaM10Q.ToString("F0");
                     temp.Month11QTY = imaM11Q.ToString("F0");
                     temp.Month12QTY = imaM12Q.ToString("F0");
                     temp.TotalQTY = imaTotQ.ToString("F0");
                     list.Add(temp);
                 }
             }//ima ends
             if (TotD != 0)
             {
                 temp = new IMAVenderCostMonthReportData()
                 {
                     IMA = "Balance Total : "
                 };
                 temp.Month01USD = M1D.ToString("F2");
                 temp.Month02USD = M2D.ToString("F2");
                 temp.Month03USD = M3D.ToString("F2");
                 temp.Month04USD = M4D.ToString("F2");
                 temp.Month05USD = M5D.ToString("F2");
                 temp.Month06USD = M6D.ToString("F2");
                 temp.Month07USD = M7D.ToString("F2");
                 temp.Month08USD = M8D.ToString("F2");
                 temp.Month09USD = M9D.ToString("F2");
                 temp.Month10USD = M10D.ToString("F2");
                 temp.Month11USD = M11D.ToString("F2");
                 temp.Month12USD = M12D.ToString("F2");
                 temp.TotalUSD = TotD.ToString("F2");

                 temp.Month01QTY = M1Q.ToString("F0");
                 temp.Month02QTY = M2Q.ToString("F0");
                 temp.Month03QTY = M3Q.ToString("F0");
                 temp.Month04QTY = M4Q.ToString("F0");
                 temp.Month05QTY = M5Q.ToString("F0");
                 temp.Month06QTY = M6Q.ToString("F0");
                 temp.Month07QTY = M7Q.ToString("F0");
                 temp.Month08QTY = M8Q.ToString("F0");
                 temp.Month09QTY = M9Q.ToString("F0");
                 temp.Month10QTY = M10Q.ToString("F0");
                 temp.Month11QTY = M11Q.ToString("F0");
                 temp.Month12QTY = M12Q.ToString("F0");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }
             
                
         }
         catch (Exception)
         {
             
             //throw;
         }
         return list;
     }


     private List<IMAVenderCostSeasonReportData> GetIMACostBySeason(int year)
     {
         List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>();
         IMAVenderCostSeasonReportData temp;
         try
         {
             //Find all IMAs
             var imas = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.create_user).Distinct();

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
             decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, TotD = 0, TotQ = 0;
             foreach (var ima in imas)
             {
                 decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaTotD = 0, imaTotQ = 0;
                 foreach (var ven in venders)
                 {
                     decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venTotD = 0, venTotQ = 0;
                     try
                     {
                         var prs = from pr in wowidb.PRs where pr.create_user == ima && pr.vendor_id == ven select pr;
                         temp = new IMAVenderCostSeasonReportData()
                         {
                             IMA = ima
                         };
                         var v = (from i in wowidb.vendors where i.id == ven select i).First();
                         temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                         foreach (var p in prs)
                         {
                             try
                             {
                                 int month = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj.Create_Date.Month).First();
                                 var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                                 switch (month)
                                 {
                                     case 1:
                                     case 2:
                                     case 3:
                                         venM1D += (decimal)pri.amount;
                                         venM1Q += (decimal)pri.quantity;
                                         break;
                                     case 4:
                                     case 5:
                                     case 6:
                                         venM2D += (decimal)pri.amount;
                                         venM2Q += (decimal)pri.quantity;
                                         break;
                                     case 7:
                                     case 8:
                                     case 9:
                                         venM3D += (decimal)pri.amount;
                                         venM3Q += (decimal)pri.quantity;
                                         break;
                                     case 10:
                                     case 11:
                                     case 12:
                                         venM4D += (decimal)pri.amount;
                                         venM4Q += (decimal)pri.quantity;
                                         break;
                                 }
                             }
                             catch (Exception)
                             {

                                 //throw;
                             }

                         }//Single vender ends
                         venTotD = venM1D + venM2D + venM3D + venM4D ;
                         venTotQ = venM1Q + venM2Q + venM3Q + venM4Q ;
                         imaM1D += venM1D;
                         imaM1Q += venM1Q;
                         imaM2D += venM2D;
                         imaM2Q += venM2Q;
                         imaM3D += venM3D;
                         imaM4Q += venM3Q;
                         imaM4D += venM4D;
                         imaM4Q += venM4Q;
                         
                         imaTotD += venTotD;
                         imaTotQ += venTotQ;
                         temp.Season01USD = venM1D.ToString("F2");
                         temp.Season02USD = venM2D.ToString("F2");
                         temp.Season03USD = venM3D.ToString("F2");
                         temp.Season04USD = venM4D.ToString("F2");
                        
                         temp.TotalUSD = venTotD.ToString("F2");

                         temp.Season01QTY = venM1Q.ToString("F0");
                         temp.Season02QTY = venM2Q.ToString("F0");
                         temp.Season03QTY = venM3Q.ToString("F0");
                         temp.Season04QTY = venM4Q.ToString("F0");
                        
                         temp.TotalQTY = venTotQ.ToString("F0");
                         list.Add(temp);
                     }
                     catch (Exception)
                     {

                         //throw;
                     }
                 }//Vender ends
                 if (imaTotD != 0)
                 {
                     temp = new IMAVenderCostSeasonReportData()
                     {
                         IMA = ima + " Total : "
                     };
                     M1D += imaM1D;
                     M1Q += imaM1Q;
                     M2D += imaM2D;
                     M2Q += imaM2Q;
                     M3D += imaM3D;
                     M4Q += imaM3Q;
                     M4D += imaM4D;
                     M4Q += imaM4Q;
                     
                     TotD += imaTotD;
                     TotQ += imaTotQ;
                     temp.Season01USD = imaM1D.ToString("F2");
                     temp.Season02USD = imaM2D.ToString("F2");
                     temp.Season03USD = imaM3D.ToString("F2");
                     temp.Season04USD = imaM4D.ToString("F2");
                   
                     temp.TotalUSD = imaTotD.ToString("F2");

                     temp.Season01QTY = imaM1Q.ToString("F0");
                     temp.Season02QTY = imaM2Q.ToString("F0");
                     temp.Season03QTY = imaM3Q.ToString("F0");
                     temp.Season04QTY = imaM4Q.ToString("F0");

                     temp.TotalQTY = imaTotQ.ToString("F0");
                     list.Add(temp);
                 }
             }//ima ends
             if (TotD != 0)
             {
                 temp = new IMAVenderCostSeasonReportData()
                 {
                     IMA = "Balance Total : "
                 };
                 temp.Season01USD = M1D.ToString("F2");
                 temp.Season02USD = M2D.ToString("F2");
                 temp.Season03USD = M3D.ToString("F2");
                 temp.Season04USD = M4D.ToString("F2");

                 temp.TotalUSD = TotD.ToString("F2");

                 temp.Season01QTY = M1Q.ToString("F0");
                 temp.Season02QTY = M2Q.ToString("F0");
                 temp.Season03QTY = M3Q.ToString("F0");
                 temp.Season04QTY = M4Q.ToString("F0");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }


         }
         catch (Exception)
         {

             //throw;
         }
         return list;
     }

     private List<IMAVenderCostIntervalReportData> GetIMACostByInterval(DateTime f, DateTime t)
     {
         List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>();
         IMAVenderCostIntervalReportData temp;
         try
         {
             //Find all IMAs
             var imas = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date >= f && pj.Create_Date<=t select pr.create_user).Distinct();

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date >= f && pj.Create_Date <= t select pr.vendor_id).Distinct();
             decimal TotD = 0, TotQ = 0;
             foreach (var ima in imas)
             {
                 decimal imaTotD = 0, imaTotQ = 0;
                 foreach (var ven in venders)
                 {
                     decimal venTotD = 0, venTotQ = 0;
                     try
                     {
                         var prs = from pr in wowidb.PRs where pr.create_user == ima && pr.vendor_id == ven select pr;
                         temp = new IMAVenderCostIntervalReportData()
                         {
                             IMA = ima
                         };
                         var v = (from i in wowidb.vendors where i.id == ven select i).First();
                         temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                         foreach (var p in prs)
                         {
                             try
                             {
                                 var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();

                                 venTotD += (decimal)pri.amount;
                                 venTotQ += (decimal)pri.quantity;

                             }
                             catch (Exception)
                             {

                                 //throw;
                             }

                         }//Single vender ends
                         
                         imaTotD += venTotD;
                         imaTotQ += venTotQ;
                         temp.TotalUSD = venTotD.ToString("F2");
                         temp.TotalQTY = venTotQ.ToString("F0");
                         list.Add(temp);
                     }
                     catch (Exception)
                     {

                         //throw;
                     }
                 }//Vender ends
                 if (imaTotD != 0)
                 {
                     temp = new IMAVenderCostIntervalReportData()
                     {
                         IMA = ima + " Total : "
                     };
                     
                     TotD += imaTotD;
                     TotQ += imaTotQ;
                     temp.TotalUSD = imaTotD.ToString("F2");
                     temp.TotalQTY = imaTotQ.ToString("F0");
                     list.Add(temp);
                 }
             }//ima ends
             if (TotD != 0)
             {
                 temp = new IMAVenderCostIntervalReportData()
                 {
                     IMA = "Balance Total : "
                 };
                 
                 temp.TotalUSD = TotD.ToString("F2");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }


         }
         catch (Exception)
         {

             //throw;
         }
         return list;
     }

     private List<IMAVenderCostMonthReportData> GetVenderCostByMonth(int year)
     {
         List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>();
         IMAVenderCostMonthReportData temp;
         try
         {

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
             decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, M5D = 0, M5Q = 0, M6D = 0, M6Q = 0, M7D = 0, M7Q = 0, M8D = 0, M8Q = 0, M9D = 0, M9Q = 0, M10D = 0, M10Q = 0, M11D = 0, M11Q = 0, M12D = 0, M12Q = 0, TotD = 0, TotQ = 0;

             foreach (var ven in venders)
             {
                 decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venM5D = 0, venM5Q = 0, venM6D = 0, venM6Q = 0, venM7D = 0, venM7Q = 0, venM8D = 0, venM8Q = 0, venM9D = 0, venM9Q = 0, venM10D = 0, venM10Q = 0, venM11D = 0, venM11Q = 0, venM12D = 0, venM12Q = 0, venTotD = 0, venTotQ = 0;
                 try
                 {
                     var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                     temp = new IMAVenderCostMonthReportData();
                     var v = (from i in wowidb.vendors where i.id == ven select i).First();
                     temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                     foreach (var p in prs)
                     {
                         try
                         {
                             int month = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj.Create_Date.Month).First();
                             var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                             switch (month)
                             {
                                 case 1:
                                     venM1D += (decimal)pri.amount;
                                     venM1Q += (decimal)pri.quantity;
                                     break;
                                 case 2:
                                     venM2D += (decimal)pri.amount;
                                     venM2Q += (decimal)pri.quantity;
                                     break;
                                 case 3:
                                     venM3D += (decimal)pri.amount;
                                     venM3Q += (decimal)pri.quantity;
                                     break;
                                 case 4:
                                     venM4D += (decimal)pri.amount;
                                     venM4Q += (decimal)pri.quantity;
                                     break;
                                 case 5:
                                     venM5D += (decimal)pri.amount;
                                     venM5Q += (decimal)pri.quantity;
                                     break;
                                 case 6:
                                     venM6D += (decimal)pri.amount;
                                     venM6Q += (decimal)pri.quantity;
                                     break;
                                 case 7:
                                     venM7D += (decimal)pri.amount;
                                     venM7Q += (decimal)pri.quantity;
                                     break;
                                 case 8:
                                     venM8D += (decimal)pri.amount;
                                     venM8Q += (decimal)pri.quantity;
                                     break;
                                 case 9:
                                     venM9D += (decimal)pri.amount;
                                     venM9Q += (decimal)pri.quantity;
                                     break;
                                 case 10:
                                     venM10D += (decimal)pri.amount;
                                     venM10Q += (decimal)pri.quantity;
                                     break;
                                 case 11:
                                     venM11D += (decimal)pri.amount;
                                     venM11Q += (decimal)pri.quantity;
                                     break;
                                 case 12:
                                     venM12D += (decimal)pri.amount;
                                     venM12Q += (decimal)pri.quantity;
                                     break;
                             }
                         }
                         catch (Exception)
                         {

                             //throw;
                         }

                     }//Single vender ends
                     venTotD = venM1D + venM2D + venM3D + venM4D + venM5D + venM6D + venM7D + venM8D + venM9D + venM10D + venM11D + venM12D;
                     venTotQ = venM1Q + venM2Q + venM3Q + venM4Q + venM5Q + venM6Q + venM7Q + venM8Q + venM9Q + venM10Q + venM11Q + venM12Q;
                     TotD += venTotD;
                     TotQ += venTotQ;
                     temp.Month01USD = venM1D.ToString("F2");
                     temp.Month02USD = venM2D.ToString("F2");
                     temp.Month03USD = venM3D.ToString("F2");
                     temp.Month04USD = venM4D.ToString("F2");
                     temp.Month05USD = venM5D.ToString("F2");
                     temp.Month06USD = venM6D.ToString("F2");
                     temp.Month07USD = venM7D.ToString("F2");
                     temp.Month08USD = venM8D.ToString("F2");
                     temp.Month09USD = venM9D.ToString("F2");
                     temp.Month10USD = venM10D.ToString("F2");
                     temp.Month11USD = venM11D.ToString("F2");
                     temp.Month12USD = venM12D.ToString("F2");
                     temp.TotalUSD = venTotD.ToString("F2");

                     temp.Month01QTY = venM1Q.ToString("F0");
                     temp.Month02QTY = venM2Q.ToString("F0");
                     temp.Month03QTY = venM3Q.ToString("F0");
                     temp.Month04QTY = venM4Q.ToString("F0");
                     temp.Month05QTY = venM5Q.ToString("F0");
                     temp.Month06QTY = venM6Q.ToString("F0");
                     temp.Month07QTY = venM7Q.ToString("F0");
                     temp.Month08QTY = venM8Q.ToString("F0");
                     temp.Month09QTY = venM9Q.ToString("F0");
                     temp.Month10QTY = venM10Q.ToString("F0");
                     temp.Month11QTY = venM11Q.ToString("F0");
                     temp.Month12QTY = venM12Q.ToString("F0");
                     temp.TotalQTY = venTotQ.ToString("F0");
                     list.Add(temp);
                 }
                 catch (Exception)
                 {

                     //throw;
                 }
             }//Vender ends

             if (TotD != 0)
             {
                 temp = new IMAVenderCostMonthReportData()
                 {
                     VenderName = "Balance Total : "
                 };
                 temp.Month01USD = M1D.ToString("F2");
                 temp.Month02USD = M2D.ToString("F2");
                 temp.Month03USD = M3D.ToString("F2");
                 temp.Month04USD = M4D.ToString("F2");
                 temp.Month05USD = M5D.ToString("F2");
                 temp.Month06USD = M6D.ToString("F2");
                 temp.Month07USD = M7D.ToString("F2");
                 temp.Month08USD = M8D.ToString("F2");
                 temp.Month09USD = M9D.ToString("F2");
                 temp.Month10USD = M10D.ToString("F2");
                 temp.Month11USD = M11D.ToString("F2");
                 temp.Month12USD = M12D.ToString("F2");
                 temp.TotalUSD = TotD.ToString("F2");

                 temp.Month01QTY = M1Q.ToString("F0");
                 temp.Month02QTY = M2Q.ToString("F0");
                 temp.Month03QTY = M3Q.ToString("F0");
                 temp.Month04QTY = M4Q.ToString("F0");
                 temp.Month05QTY = M5Q.ToString("F0");
                 temp.Month06QTY = M6Q.ToString("F0");
                 temp.Month07QTY = M7Q.ToString("F0");
                 temp.Month08QTY = M8Q.ToString("F0");
                 temp.Month09QTY = M9Q.ToString("F0");
                 temp.Month10QTY = M10Q.ToString("F0");
                 temp.Month11QTY = M11Q.ToString("F0");
                 temp.Month12QTY = M12Q.ToString("F0");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }


         }
         catch (Exception)
         {

             //throw;
         }
         return list;
     }

     private List<IMAVenderCostSeasonReportData> GetVenderCostBySeason(int year)
     {
         List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>();
         IMAVenderCostSeasonReportData temp;
         try
         {

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
             decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, TotD = 0, TotQ = 0;

             foreach (var ven in venders)
             {
                 decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venTotD = 0, venTotQ = 0;
                 try
                 {
                     var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                     temp = new IMAVenderCostSeasonReportData();
                     var v = (from i in wowidb.vendors where i.id == ven select i).First();
                     temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                     foreach (var p in prs)
                     {
                         try
                         {
                             int month = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj.Create_Date.Month).First();
                             var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                             switch (month)
                             {
                                 case 1:
                                 case 2:
                                 case 3:
                                     venM1D += (decimal)pri.amount;
                                     venM1Q += (decimal)pri.quantity;
                                     break;
                                 case 4:
                                 case 5:
                                 case 6:
                                     venM2D += (decimal)pri.amount;
                                     venM2Q += (decimal)pri.quantity;
                                     break;
                                 case 7:
                                 case 8:
                                 case 9:
                                     venM3D += (decimal)pri.amount;
                                     venM3Q += (decimal)pri.quantity;
                                     break;
                                 case 10:
                                 case 11:
                                 case 12:
                                     venM4D += (decimal)pri.amount;
                                     venM4Q += (decimal)pri.quantity;
                                     break;
                                 
                             }
                         }
                         catch (Exception)
                         {

                             //throw;
                         }

                     }//Single vender ends
                     venTotD = venM1D + venM2D + venM3D + venM4D;
                     venTotQ = venM1Q + venM2Q + venM3Q + venM4Q;
                     TotD += venTotD;
                     TotQ += venTotQ;
                     temp.Season01USD = venM1D.ToString("F2");
                     temp.Season02USD = venM2D.ToString("F2");
                     temp.Season03USD = venM3D.ToString("F2");
                     temp.Season04USD = venM4D.ToString("F2");
                     temp.TotalUSD = venTotD.ToString("F2");

                     temp.Season01QTY = venM1Q.ToString("F0");
                     temp.Season02QTY = venM2Q.ToString("F0");
                     temp.Season03QTY = venM3Q.ToString("F0");
                     temp.Season04QTY = venM4Q.ToString("F0");
                     temp.TotalQTY = venTotQ.ToString("F0");
                     list.Add(temp);
                 }
                 catch (Exception)
                 {

                     //throw;
                 }
             }//Vender ends

             if (TotD != 0)
             {
                 temp = new IMAVenderCostSeasonReportData()
                 {
                     VenderName = "Balance Total : "
                 };
                 temp.Season01USD = M1D.ToString("F2");
                 temp.Season02USD = M2D.ToString("F2");
                 temp.Season03USD = M3D.ToString("F2");
                 temp.Season04USD = M4D.ToString("F2");
                 temp.TotalUSD = TotD.ToString("F2");

                 temp.Season01QTY = M1Q.ToString("F0");
                 temp.Season02QTY = M2Q.ToString("F0");
                 temp.Season03QTY = M3Q.ToString("F0");
                 temp.Season04QTY = M4Q.ToString("F0");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }


         }
         catch (Exception)
         {

             //throw;
         }
         return list;
     }

     private List<IMAVenderCostIntervalReportData> GetVenderCostByInterval(DateTime f, DateTime t)
     {
         List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>();
         IMAVenderCostIntervalReportData temp;
         try
         {

             var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date >= f && pj.Create_Date <= t select pr.vendor_id).Distinct();
             decimal TotD = 0, TotQ = 0;

             foreach (var ven in venders)
             {
                 decimal venTotD = 0, venTotQ = 0;
                 try
                 {
                     var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                     temp = new IMAVenderCostIntervalReportData();
                     var v = (from i in wowidb.vendors where i.id == ven select i).First();
                     temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                     foreach (var p in prs)
                     {
                         try
                         {
                             int month = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj.Create_Date.Month).First();
                             var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();

                             venTotD += (decimal)pri.amount;
                             venTotD += (decimal)pri.quantity;
                                  
                         }
                         catch (Exception)
                         {

                             //throw;
                         }

                     }//Single vender ends
                     
                     TotD += venTotD;
                     TotQ += venTotQ;
                     temp.TotalUSD = venTotD.ToString("F2");
                     temp.TotalQTY = venTotQ.ToString("F0");
                     list.Add(temp);
                 }
                 catch (Exception)
                 {

                     //throw;
                 }
             }//Vender ends

             if (TotD != 0)
             {
                 temp = new IMAVenderCostIntervalReportData()
                 {
                     VenderName = "Balance Total : "
                 };
                 temp.TotalUSD = TotD.ToString("F2");
                 temp.TotalQTY = TotQ.ToString("F0");
                 list.Add(temp);
             }


         }
         catch (Exception)
         {

             //throw;
         }
         return list;
     }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //SetGridViewHidden();
        String report = ddlReport.SelectedValue;
        String year = ddlYear.SelectedValue;
        String type = ddlType.SelectedValue;
        bool isEnable = false;
        
        if (report == "1")//認證人員成本分析
        {
           
            if (type == "1")//月
            {
                List<IMAVenderCostMonthReportData> list = GetIMACostByMonth(int.Parse(year));
                iGridView1.Visible = true;
                iGridView1.SetHeaderText(26, int.Parse(year)-1911 + "年度 Total Balance");
                iGridView1.DataSource = list;
                iGridView1.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
            }
            else if (type == "2")//季
            {
                List<IMAVenderCostSeasonReportData> list = GetIMACostBySeason(int.Parse(year));
                iGridView2.Visible = true;
                iGridView2.SetHeaderText(10, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView2.DataSource = list;
                iGridView2.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                
                
                List<IMAVenderCostIntervalReportData> list =  GetIMACostByInterval(from ,to);
                iGridView3.Visible = true;
                iGridView3.SetHeaderText(2, String.Format("{0} To {1}",dcFrom.GetText(),dcTo.GetText()));
                iGridView3.DataSource = list;
                iGridView3.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
            }
        }
        else if (report == "2")//<廠商成本案件分析總表
        {
           
            if (type == "1")//月
            {
                List<IMAVenderCostMonthReportData> list = GetVenderCostByMonth(int.Parse(year));
                iGridView4.Visible = true;
                iGridView4.SetHeaderText(25, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView4.DataSource = list;
                iGridView4.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
            }
            else if (type == "2")//季
            {
                List<IMAVenderCostSeasonReportData> list = GetVenderCostBySeason(int.Parse(year));
                iGridView5.Visible = true;
                iGridView5.SetHeaderText(9, int.Parse(year) - 1911 + "年度 Total Balance");
                iGridView5.DataSource = list;
                iGridView5.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                List<IMAVenderCostIntervalReportData> list = GetVenderCostByInterval(from ,to);
                iGridView6.Visible = true;
                iGridView6.SetHeaderText(1, String.Format("{0} ~ {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView6.DataSource = list;
                iGridView6.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
                iGridView9.SetHeaderText(4, String.Format("{0} ~ {1}", dcFrom.GetText(), dcTo.GetText()));
                iGridView9.DataSource = list;
                iGridView9.DataBind();
                if (list.Count != 0)
                {
                    isEnable = true;
                }
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
        btnExport.Enabled = false;
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
                                <asp:Button ID="btnExport" runat="server" Text="Excel" Enabled="False" 
                                    onclick="btnExport_Click" />
                            </td>
                        </tr>
                    <tr><td colspan="4">
                    <cc1:iRowSpanGridView ID="iGridView1" runat="server" Width="100%" isMergedHeader="True" isHeaderColMerged="true" 
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
                           isMergedHeader="true" isHeaderColMerged="true" AutoGenerateColumns="False" 
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

