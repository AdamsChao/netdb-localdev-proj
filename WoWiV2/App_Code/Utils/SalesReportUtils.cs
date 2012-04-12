using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IMAReportUtils
/// </summary>
public class SalesUtils
{
    public static List<SalesClientMonthReportData> GetSalesClientByMonth_OpenProjDate(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<SalesClientMonthReportData> list = new List<SalesClientMonthReportData>();
        SalesClientMonthReportData temp;
        try
        {
            //Find all Sales
            var sales = from e in wowidb.employees from dep in wowidb.departments where e.department_id == dep.id && dep.name == "Sales" select e ;

            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date.Year == year select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
            decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, M5D = 0, M5Q = 0, M6D = 0, M6Q = 0, M7D = 0, M7Q = 0, M8D = 0, M8Q = 0, M9D = 0, M9Q = 0, M10D = 0, M10Q = 0, M11D = 0, M11Q = 0, M12D = 0, M12Q = 0, TotD = 0, TotQ = 0;
            foreach (var sale in sales)
            {
                decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaM5D = 0, imaM5Q = 0, imaM6D = 0, imaM6Q = 0, imaM7D = 0, imaM7Q = 0, imaM8D = 0, imaM8Q = 0, imaM9D = 0, imaM9Q = 0, imaM10D = 0, imaM10Q = 0, imaM11D = 0, imaM11Q = 0, imaM12D = 0, imaM12Q = 0, imaTotD = 0, imaTotQ = 0;
                foreach (var client in clients)
                {
                    decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venM5D = 0, venM5Q = 0, venM6D = 0, venM6Q = 0, venM7D = 0, venM7Q = 0, venM8D = 0, venM8Q = 0, venM9D = 0, venM9Q = 0, venM10D = 0, venM10Q = 0, venM11D = 0, venM11Q = 0, venM12D = 0, venM12Q = 0, venTotD = 0, venTotQ = 0;
                    try
                    {
                        var quotas = from quo in wowidb.Quotation_Version where quo.SalesId == sale.id && quo.Client_Id == client select quo;
                        temp = new SalesClientMonthReportData()
                        {
                            Sales = String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname
                        };
                        var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                        temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                        foreach (var p in quotas)
                        {
                            try
                            {
                                int month = (from qs in wowidb.Quotation_Version from proj in wowidb.Projects where qs.Quotation_No == p.Quotation_No && qs.Quotation_Version_Id == proj.Quotation_Id select proj.Create_Date.Month).First();
                                switch (month)
                                {
                                    case 1:
                                        venM1D += (decimal)p.FinalTotalPrice;
                                        //venM1Q += (decimal)pri.quantity;
                                        break;
                                    case 2:
                                        venM2D += (decimal)p.FinalTotalPrice;
                                        //venM2Q += (decimal)pri.quantity;
                                        break;
                                    case 3:
                                        venM3D += (decimal)p.FinalTotalPrice;
                                        //venM3Q += (decimal)pri.quantity;
                                        break;
                                    case 4:
                                        venM4D += (decimal)p.FinalTotalPrice;
                                        //venM4Q += (decimal)pri.quantity;
                                        break;
                                    case 5:
                                        venM5D += (decimal)p.FinalTotalPrice;
                                        //venM5Q += (decimal)pri.quantity;
                                        break;
                                    case 6:
                                        venM6D += (decimal)p.FinalTotalPrice;
                                        //venM6Q += (decimal)pri.quantity;
                                        break;
                                    case 7:
                                        venM7D += (decimal)p.FinalTotalPrice;
                                        //venM7Q += (decimal)pri.quantity;
                                        break;
                                    case 8:
                                        venM8D += (decimal)p.FinalTotalPrice;
                                        //venM8Q += (decimal)pri.quantity;
                                        break;
                                    case 9:
                                        venM9D += (decimal)p.FinalTotalPrice;
                                        //venM9Q += (decimal)pri.quantity;
                                        break;
                                    case 10:
                                        venM10D += (decimal)p.FinalTotalPrice;
                                        //venM10Q += (decimal)pri.quantity;
                                        break;
                                    case 11:
                                        venM11D += (decimal)p.FinalTotalPrice;
                                        //venM11Q += (decimal)pri.quantity;
                                        break;
                                    case 12:
                                        venM12D += (decimal)p.FinalTotalPrice;
                                        //venM12Q += (decimal)pri.quantity;
                                        break;
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                            }

                        }//Single vender ends
                        venTotD = venM1D + venM2D + venM3D + venM4D + venM5D + venM6D + venM7D + venM8D + venM9D + venM10D + venM11D + venM12D;
                        //venTotQ = venM1Q + venM2Q + venM3Q + venM4Q + venM5Q + venM6Q + venM7Q + venM8Q + venM9Q + venM10Q + venM11Q + venM12Q;
                        imaM1D += venM1D;
                        //imaM1Q += venM1Q;
                        imaM2D += venM2D;
                        //imaM2Q += venM2Q;
                        imaM3D += venM3D;
                        //imaM3Q += venM3Q;
                        imaM4D += venM4D;
                        //imaM4Q += venM4Q;
                        imaM5D += venM5D;
                        //imaM5Q += venM5Q;
                        imaM6D += venM6D;
                        //imaM6Q += venM6Q;
                        imaM7D += venM7D;
                        //imaM7Q += venM7Q;
                        imaM8D += venM8D;
                        //imaM8Q += venM8Q;
                        imaM9D += venM9D;
                        //imaM9Q += venM9Q;
                        imaM10D += venM10D;
                        //imaM10Q += venM10Q;
                        imaM11D += venM11D;
                        //imaM11Q += venM11Q;
                        imaM12D += venM12D;
                        //imaM12Q += venM12Q;
                        imaTotD += venTotD;
                        //imaTotQ += venTotQ;
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

                        //temp.Month01QTY = venM1Q.ToString("F0");
                        //temp.Month02QTY = venM2Q.ToString("F0");
                        //temp.Month03QTY = venM3Q.ToString("F0");
                        //temp.Month04QTY = venM4Q.ToString("F0");
                        //temp.Month05QTY = venM5Q.ToString("F0");
                        //temp.Month06QTY = venM6Q.ToString("F0");
                        //temp.Month07QTY = venM7Q.ToString("F0");
                        //temp.Month08QTY = venM8Q.ToString("F0");
                        //temp.Month09QTY = venM9Q.ToString("F0");
                        //temp.Month10QTY = venM10Q.ToString("F0");
                        //temp.Month11QTY = venM11Q.ToString("F0");
                        //temp.Month12QTY = venM12Q.ToString("F0");
                        //temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                }//Vender ends
                if (imaTotD != 0)
                {
                    temp = new SalesClientMonthReportData()
                    {
                        Sales = (String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname) + " Total : "
                    };
                    M1D += imaM1D;
                    //M1Q += imaM1Q;
                    M2D += imaM2D;
                    //M2Q += imaM2Q;
                    M3D += imaM3D;
                    //M3Q += imaM3Q;
                    M4D += imaM4D;
                    //M4Q += imaM4Q;
                    M5D += imaM5D;
                    //M5Q += imaM5Q;
                    M6D += imaM6D;
                    //M6Q += imaM6Q;
                    M7D += imaM7D;
                    //M7Q += imaM7Q;
                    M8D += imaM8D;
                    //M8Q += imaM8Q;
                    M9D += imaM9D;
                    //M9Q += imaM9Q;
                    M10D += imaM10D;
                    //M10Q += imaM10Q;
                    M11D += imaM11D;
                    //M11Q += imaM11Q;
                    M12D += imaM12D;
                    //M12Q += imaM12Q;
                    TotD += imaTotD;
                    //TotQ += imaTotQ;
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

                    //temp.Month01QTY = imaM1Q.ToString("F0");
                    //temp.Month02QTY = imaM2Q.ToString("F0");
                    //temp.Month03QTY = imaM3Q.ToString("F0");
                    //temp.Month04QTY = imaM4Q.ToString("F0");
                    //temp.Month05QTY = imaM5Q.ToString("F0");
                    //temp.Month06QTY = imaM6Q.ToString("F0");
                    //temp.Month07QTY = imaM7Q.ToString("F0");
                    //temp.Month08QTY = imaM8Q.ToString("F0");
                    //temp.Month09QTY = imaM9Q.ToString("F0");
                    //temp.Month10QTY = imaM10Q.ToString("F0");
                    //temp.Month11QTY = imaM11Q.ToString("F0");
                    //temp.Month12QTY = imaM12Q.ToString("F0");
                    //temp.TotalQTY = imaTotQ.ToString("F0");
                    list.Add(temp);
                }
            }//ima ends
            if (TotD != 0)
            {
                temp = new SalesClientMonthReportData()
                {
                    Sales = "Balance Total : "
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

                //temp.Month01QTY = M1Q.ToString("F0");
                //temp.Month02QTY = M2Q.ToString("F0");
                //temp.Month03QTY = M3Q.ToString("F0");
                //temp.Month04QTY = M4Q.ToString("F0");
                //temp.Month05QTY = M5Q.ToString("F0");
                //temp.Month06QTY = M6Q.ToString("F0");
                //temp.Month07QTY = M7Q.ToString("F0");
                //temp.Month08QTY = M8Q.ToString("F0");
                //temp.Month09QTY = M9Q.ToString("F0");
                //temp.Month10QTY = M10Q.ToString("F0");
                //temp.Month11QTY = M11Q.ToString("F0");
                //temp.Month12QTY = M12Q.ToString("F0");
                //temp.TotalQTY = TotQ.ToString("F0");
                list.Add(temp);
            }


        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    public static List<SalesClientSeasonReportData> GetSalesClientBySeason_OpenProjDate(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<SalesClientSeasonReportData> list = new List<SalesClientSeasonReportData>();
        SalesClientSeasonReportData temp;
        try
        {
            //Find all Sales
            var sales = from e in wowidb.employees from dep in wowidb.departments where e.department_id == dep.id && dep.name == "Sales" select e;

            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date.Year == year select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
            
            
            decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, TotD = 0, TotQ = 0;
            foreach (var sale in sales)
            {
                decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaTotD = 0, imaTotQ = 0;
                foreach (var client in clients)
                {
                    decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venTotD = 0, venTotQ = 0;
                    try
                    {
                        var quotas = from quo in wowidb.Quotation_Version where quo.SalesId == sale.id && quo.Client_Id == client select quo;
                        temp = new SalesClientSeasonReportData()
                        {
                            Sales = String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname
                        };
                        var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                        temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                        foreach (var p in quotas)
                        {
                            try
                            {
                                int month = (from qs in wowidb.Quotation_Version from proj in wowidb.Projects where qs.Quotation_No == p.Quotation_No && qs.Quotation_Version_Id == proj.Quotation_Id select proj.Create_Date.Month).First();
                                switch (month)
                                {
                                    case 1:
                                    case 2:
                                    case 3:
                                        venM1D += (decimal)p.FinalTotalPrice;
                                        //venM1Q += (decimal)pri.quantity;
                                        break;
                                    case 4:
                                    case 5:
                                    case 6:
                                        venM2D += (decimal)p.FinalTotalPrice;
                                        //venM2Q += (decimal)pri.quantity;
                                        break;
                                    case 7:
                                    case 8:
                                    case 9:
                                        venM3D += (decimal)p.FinalTotalPrice;
                                        //venM3Q += (decimal)pri.quantity;
                                        break;
                                    case 10:
                                    case 11:
                                    case 12:
                                        venM4D += (decimal)p.FinalTotalPrice;
                                        //venM4Q += (decimal)pri.quantity;
                                        break;
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                            }

                        }//Single vender ends
                        venTotD = venM1D + venM2D + venM3D + venM4D;
                        //venTotQ = venM1Q + venM2Q + venM3Q + venM4Q;
                        imaM1D += venM1D;
                        //imaM1Q += venM1Q;
                        imaM2D += venM2D;
                        //imaM2Q += venM2Q;
                        imaM3D += venM3D;
                        //imaM3Q += venM3Q;
                        imaM4D += venM4D;
                        //imaM4Q += venM4Q;

                        imaTotD += venTotD;
                        //imaTotQ += venTotQ;
                        temp.Season01USD = venM1D.ToString("F2");
                        temp.Season02USD = venM2D.ToString("F2");
                        temp.Season03USD = venM3D.ToString("F2");
                        temp.Season04USD = venM4D.ToString("F2");

                        temp.TotalUSD = venTotD.ToString("F2");

                        //temp.Season01QTY = venM1Q.ToString("F0");
                        //temp.Season02QTY = venM2Q.ToString("F0");
                        //temp.Season03QTY = venM3Q.ToString("F0");
                        //temp.Season04QTY = venM4Q.ToString("F0");

                        //temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                }//Vender ends
                if (imaTotD != 0)
                {
                    temp = new SalesClientSeasonReportData()
                    {
                        Sales = (String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname) + " Total : "
                    };
                    M1D += imaM1D;
                    //M1Q += imaM1Q;
                    M2D += imaM2D;
                    //M2Q += imaM2Q;
                    M3D += imaM3D;
                    //M3Q += imaM3Q;
                    M4D += imaM4D;
                    //M4Q += imaM4Q;

                    TotD += imaTotD;
                    //TotQ += imaTotQ;
                    temp.Season01USD = imaM1D.ToString("F2");
                    temp.Season02USD = imaM2D.ToString("F2");
                    temp.Season03USD = imaM3D.ToString("F2");
                    temp.Season04USD = imaM4D.ToString("F2");

                    temp.TotalUSD = imaTotD.ToString("F2");

                    //temp.Season01QTY = imaM1Q.ToString("F0");
                    //temp.Season02QTY = imaM2Q.ToString("F0");
                    //temp.Season03QTY = imaM3Q.ToString("F0");
                    //temp.Season04QTY = imaM4Q.ToString("F0");

                    //temp.TotalQTY = imaTotQ.ToString("F0");
                    list.Add(temp);
                }
            }//ima ends
            if (TotD != 0)
            {
                temp = new SalesClientSeasonReportData()
                {
                    Sales = "Balance Total : "
                };
                temp.Season01USD = M1D.ToString("F2");
                temp.Season02USD = M2D.ToString("F2");
                temp.Season03USD = M3D.ToString("F2");
                temp.Season04USD = M4D.ToString("F2");

                temp.TotalUSD = TotD.ToString("F2");

                //temp.Season01QTY = M1Q.ToString("F0");
                //temp.Season02QTY = M2Q.ToString("F0");
                //temp.Season03QTY = M3Q.ToString("F0");
                //temp.Season04QTY = M4Q.ToString("F0");
                //temp.TotalQTY = TotQ.ToString("F0");
                list.Add(temp);
            }


        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    public static List<SalesClientIntervalReportData> GetSalesClientByInterval_OpenProjDate(WoWiModel.WoWiEntities wowidb, DateTime f, DateTime t)
    {
        List<SalesClientIntervalReportData> list = new List<SalesClientIntervalReportData>();
        SalesClientIntervalReportData temp;
        try
        {
            //Find all Sales
            var sales = from e in wowidb.employees from dep in wowidb.departments where e.department_id == dep.id && dep.name == "Sales" select e;
            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date >= f && pj.Create_Date <= t select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
            decimal TotD = 0, TotQ = 0;
            foreach (var sale in sales)
            {
                decimal imaTotD = 0, imaTotQ = 0;
                foreach (var client in clients)
                {
                    decimal venTotD = 0, venTotQ = 0;
                    try
                    {
                        var quotas = from quo in wowidb.Quotation_Version where quo.SalesId == sale.id && quo.Client_Id == client select quo;
                        temp = new SalesClientIntervalReportData()
                        {
                            Sales = String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname
                        };
                        var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                        temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                        foreach (var p in quotas)
                        {
                            try
                            {
                                venTotD += (decimal)p.FinalTotalPrice;
                                //venTotQ += (decimal)pri.quantity;

                            }
                            catch (Exception)
                            {

                                //throw;
                            }

                        }//Single vender ends

                        imaTotD += venTotD;
                        //imaTotQ += venTotQ;
                        temp.TotalUSD = venTotD.ToString("F2");
                        //temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }
                }//Vender ends
                if (imaTotD != 0)
                {
                    temp = new SalesClientIntervalReportData()
                    {
                        Sales = (String.IsNullOrEmpty(sale.c_fname) ? sale.fname + " " + sale.lname : sale.c_lname + "" + sale.c_fname) + " Total : "
                    };

                    TotD += imaTotD;
                    //TotQ += imaTotQ;
                    temp.TotalUSD = imaTotD.ToString("F2");
                    //temp.TotalQTY = imaTotQ.ToString("F0");
                    list.Add(temp);
                }
            }//ima ends
            if (TotD != 0)
            {
                temp = new SalesClientIntervalReportData()
                {
                    Sales = "Balance Total : "
                };

                temp.TotalUSD = TotD.ToString("F2");
                //temp.TotalQTY = TotQ.ToString("F0");
                list.Add(temp);
            }


        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    public static List<SalesClientMonthReportData> GetClientByMonth_OpenProjDate(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<SalesClientMonthReportData> list = new List<SalesClientMonthReportData>();
        SalesClientMonthReportData temp;
        try
        {
            
            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date.Year == year select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
          
                decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaM5D = 0, imaM5Q = 0, imaM6D = 0, imaM6Q = 0, imaM7D = 0, imaM7Q = 0, imaM8D = 0, imaM8Q = 0, imaM9D = 0, imaM9Q = 0, imaM10D = 0, imaM10Q = 0, imaM11D = 0, imaM11Q = 0, imaM12D = 0, imaM12Q = 0, imaTotD = 0, imaTotQ = 0;
                foreach (var client in clients)
                {
                    decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venM5D = 0, venM5Q = 0, venM6D = 0, venM6Q = 0, venM7D = 0, venM7Q = 0, venM8D = 0, venM8Q = 0, venM9D = 0, venM9Q = 0, venM10D = 0, venM10Q = 0, venM11D = 0, venM11Q = 0, venM12D = 0, venM12Q = 0, venTotD = 0, venTotQ = 0;
                    try
                    {
                        var quotas = from quo in wowidb.Quotation_Version where quo.Client_Id == client select quo;
                        temp = new SalesClientMonthReportData();
                        var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                        temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                        foreach (var p in quotas)
                        {
                            try
                            {
                                int month = (from qs in wowidb.Quotation_Version from proj in wowidb.Projects where qs.Quotation_No == p.Quotation_No && qs.Quotation_Version_Id == proj.Quotation_Id select proj.Create_Date.Month).First();
                                switch (month)
                                {
                                    case 1:
                                        venM1D += (decimal)p.FinalTotalPrice;
                                        //venM1Q += (decimal)p.quantity;
                                        break;
                                    case 2:
                                        venM2D += (decimal)p.FinalTotalPrice;
                                        //venM2Q += (decimal)pri.quantity;
                                        break;
                                    case 3:
                                        venM3D += (decimal)p.FinalTotalPrice;
                                        //venM3Q += (decimal)pri.quantity;
                                        break;
                                    case 4:
                                        venM4D += (decimal)p.FinalTotalPrice;
                                        //venM4Q += (decimal)pri.quantity;
                                        break;
                                    case 5:
                                        venM5D += (decimal)p.FinalTotalPrice;
                                        //venM5Q += (decimal)pri.quantity;
                                        break;
                                    case 6:
                                        venM6D += (decimal)p.FinalTotalPrice;
                                        //venM6Q += (decimal)pri.quantity;
                                        break;
                                    case 7:
                                        venM7D += (decimal)p.FinalTotalPrice;
                                        //venM7Q += (decimal)pri.quantity;
                                        break;
                                    case 8:
                                        venM8D += (decimal)p.FinalTotalPrice;
                                        //venM8Q += (decimal)pri.quantity;
                                        break;
                                    case 9:
                                        venM9D += (decimal)p.FinalTotalPrice;
                                        //venM9Q += (decimal)pri.quantity;
                                        break;
                                    case 10:
                                        venM10D += (decimal)p.FinalTotalPrice;
                                        //venM10Q += (decimal)pri.quantity;
                                        break;
                                    case 11:
                                        venM11D += (decimal)p.FinalTotalPrice;
                                        //venM11Q += (decimal)pri.quantity;
                                        break;
                                    case 12:
                                        venM12D += (decimal)p.FinalTotalPrice;
                                        //venM12Q += (decimal)pri.quantity;
                                        break;
                                }
                            }
                            catch (Exception)
                            {

                                //throw;
                            }

                        }//Single vender ends
                        venTotD = venM1D + venM2D + venM3D + venM4D + venM5D + venM6D + venM7D + venM8D + venM9D + venM10D + venM11D + venM12D;
                        //venTotQ = venM1Q + venM2Q + venM3Q + venM4Q + venM5Q + venM6Q + venM7Q + venM8Q + venM9Q + venM10Q + venM11Q + venM12Q;
                        imaM1D += venM1D;
                        //imaM1Q += venM1Q;
                        imaM2D += venM2D;
                        //imaM2Q += venM2Q;
                        imaM3D += venM3D;
                        //imaM3Q += venM3Q;
                        imaM4D += venM4D;
                        //imaM4Q += venM4Q;
                        imaM5D += venM5D;
                        //imaM5Q += venM5Q;
                        imaM6D += venM6D;
                        //imaM6Q += venM6Q;
                        imaM7D += venM7D;
                        //imaM7Q += venM7Q;
                        imaM8D += venM8D;
                        //imaM8Q += venM8Q;
                        imaM9D += venM9D;
                        //imaM9Q += venM9Q;
                        imaM10D += venM10D;
                        //imaM10Q += venM10Q;
                        imaM11D += venM11D;
                        //imaM11Q += venM11Q;
                        imaM12D += venM12D;
                        //imaM12Q += venM12Q;
                        imaTotD += venTotD;
                        //imaTotQ += venTotQ;
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

                        //temp.Month01QTY = venM1Q.ToString("F0");
                        //temp.Month02QTY = venM2Q.ToString("F0");
                        //temp.Month03QTY = venM3Q.ToString("F0");
                        //temp.Month04QTY = venM4Q.ToString("F0");
                        //temp.Month05QTY = venM5Q.ToString("F0");
                        //temp.Month06QTY = venM6Q.ToString("F0");
                        //temp.Month07QTY = venM7Q.ToString("F0");
                        //temp.Month08QTY = venM8Q.ToString("F0");
                        //temp.Month09QTY = venM9Q.ToString("F0");
                        //temp.Month10QTY = venM10Q.ToString("F0");
                        //temp.Month11QTY = venM11Q.ToString("F0");
                        //temp.Month12QTY = venM12Q.ToString("F0");
                        //temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }


                }//ima ends
                if (imaTotD != 0)
                {
                    temp = new SalesClientMonthReportData()
                    {
                        Client = "Balance Total : "
                    };

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

                    //temp.Month01QTY = imaM1Q.ToString("F0");
                    //temp.Month02QTY = imaM2Q.ToString("F0");
                    //temp.Month03QTY = imaM3Q.ToString("F0");
                    //temp.Month04QTY = imaM4Q.ToString("F0");
                    //temp.Month05QTY = imaM5Q.ToString("F0");
                    //temp.Month06QTY = imaM6Q.ToString("F0");
                    //temp.Month07QTY = imaM7Q.ToString("F0");
                    //temp.Month08QTY = imaM8Q.ToString("F0");
                    //temp.Month09QTY = imaM9Q.ToString("F0");
                    //temp.Month10QTY = imaM10Q.ToString("F0");
                    //temp.Month11QTY = imaM11Q.ToString("F0");
                    //temp.Month12QTY = imaM12Q.ToString("F0");
                    //temp.TotalQTY = imaTotQ.ToString("F0");
                    list.Add(temp);
                }
        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    public static List<SalesClientSeasonReportData> GetClientBySeason_OpenProjDate(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<SalesClientSeasonReportData> list = new List<SalesClientSeasonReportData>();
        SalesClientSeasonReportData temp;
        try
        {
            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date.Year == year select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
            decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaTotD = 0, imaTotQ = 0;
            foreach (var client in clients)
            {
                decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venTotD = 0, venTotQ = 0;
                try
                {
                    var quotas = from quo in wowidb.Quotation_Version where quo.Client_Id == client select quo;
                    temp = new SalesClientSeasonReportData();
                    var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                    temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                    foreach (var p in quotas)
                    {
                        try
                        {
                            int month = (from qs in wowidb.Quotation_Version from proj in wowidb.Projects where qs.Quotation_No == p.Quotation_No && qs.Quotation_Version_Id == proj.Quotation_Id select proj.Create_Date.Month).First();
                            switch (month)
                            {
                                case 1:
                                case 2:
                                case 3:
                                    venM1D += (decimal)p.FinalTotalPrice;
                                    //venM1Q += (decimal)pri.quantity;
                                    break;
                                case 4:
                                case 5:
                                case 6:
                                    venM2D += (decimal)p.FinalTotalPrice;
                                    //venM2Q += (decimal)pri.quantity;
                                    break;
                                case 7:
                                case 8:
                                case 9:
                                    venM3D += (decimal)p.FinalTotalPrice;
                                    //venM3Q += (decimal)pri.quantity;
                                    break;
                                case 10:
                                case 11:
                                case 12:
                                    venM4D += (decimal)p.FinalTotalPrice;
                                    //venM4Q += (decimal)pri.quantity;
                                    break;
                            }
                        }
                        catch (Exception)
                        {

                            //throw;
                        }

                    }//Single vender ends
                    venTotD = venM1D + venM2D + venM3D + venM4D;
                    //venTotQ = venM1Q + venM2Q + venM3Q + venM4Q;
                    imaM1D += venM1D;
                    //imaM1Q += venM1Q;
                    imaM2D += venM2D;
                    //imaM2Q += venM2Q;
                    imaM3D += venM3D;
                    //imaM3Q += venM3Q;
                    imaM4D += venM4D;
                    //imaM4Q += venM4Q;

                    imaTotD += venTotD;
                    //imaTotQ += venTotQ;
                    temp.Season01USD = venM1D.ToString("F2");
                    temp.Season02USD = venM2D.ToString("F2");
                    temp.Season03USD = venM3D.ToString("F2");
                    temp.Season04USD = venM4D.ToString("F2");

                    temp.TotalUSD = venTotD.ToString("F2");

                    //temp.Season01QTY = venM1Q.ToString("F0");
                    //temp.Season02QTY = venM2Q.ToString("F0");
                    //temp.Season03QTY = venM3Q.ToString("F0");
                    //temp.Season04QTY = venM4Q.ToString("F0");

                    //temp.TotalQTY = venTotQ.ToString("F0");
                    list.Add(temp);
                }
                catch (Exception)
                {

                    //throw;
                }
            }//Vender ends
            if (imaTotD != 0)
            {
                temp = new SalesClientSeasonReportData()
                {
                    Client = "Balance Total : "
                };
                temp.Season01USD = imaM1D.ToString("F2");
                temp.Season02USD = imaM2D.ToString("F2");
                temp.Season03USD = imaM3D.ToString("F2");
                temp.Season04USD = imaM4D.ToString("F2");

                temp.TotalUSD = imaTotD.ToString("F2");

                //temp.Season01QTY = imaM1Q.ToString("F0");
                //temp.Season02QTY = imaM2Q.ToString("F0");
                //temp.Season03QTY = imaM3Q.ToString("F0");
                //temp.Season04QTY = imaM4Q.ToString("F0");

                //temp.TotalQTY = imaTotQ.ToString("F0");
                list.Add(temp);
            }

        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

    public static List<SalesClientIntervalReportData> GetClientByInterval_OpenProjDate(WoWiModel.WoWiEntities wowidb, DateTime f, DateTime t)
    {
        List<SalesClientIntervalReportData> list = new List<SalesClientIntervalReportData>();
        SalesClientIntervalReportData temp;
        try
        {
            var quos = (from quo in wowidb.Quotation_Version from pj in wowidb.Projects where quo.Quotation_Version_Id == pj.Quotation_Id && pj.Create_Date >= f && pj.Create_Date <= t select quo.Quotation_No).Distinct();
            var clients = (from qNo in quos from quo in wowidb.Quotation_Version from cli in wowidb.clientapplicants where quo.Quotation_No == qNo select quo.Client_Id).Distinct();
            decimal imaTotD = 0, imaTotQ = 0;
            foreach (var client in clients)
            {
                decimal venTotD = 0, venTotQ = 0;
                try
                {
                    var quotas = from quo in wowidb.Quotation_Version where quo.Client_Id == client select quo;
                    temp = new SalesClientIntervalReportData();
                    var v = (from i in wowidb.clientapplicants where i.id == client select i).First();
                    temp.Client = String.IsNullOrEmpty(v.c_companyname) ? v.companyname : v.c_companyname;
                    foreach (var p in quotas)
                    {
                        try
                        {
                            venTotD += (decimal)p.FinalTotalPrice;
                            //venTotQ += (decimal)pri.quantity;

                        }
                        catch (Exception)
                        {

                            //throw;
                        }

                    }//Single vender ends

                    imaTotD += venTotD;
                    //imaTotQ += venTotQ;
                    temp.TotalUSD = venTotD.ToString("F2");
                    //temp.TotalQTY = venTotQ.ToString("F0");
                    list.Add(temp);
                }
                catch (Exception)
                {

                    //throw;
                }
            }//Vender ends
            if (imaTotD != 0)
            {
                temp = new SalesClientIntervalReportData()
                {
                    Client = "Balance Total : "
                };

                temp.TotalUSD = imaTotD.ToString("F2");
                //temp.TotalQTY = imaTotQ.ToString("F0");
                list.Add(temp);
            }

        }
        catch (Exception)
        {

            //throw;
        }
        return list;
    }

}