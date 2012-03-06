using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for IMAReportUtils
/// </summary>
public class IMAReportUtils
{
    public static  List<IMAVenderCostMonthReportData> GetIMACostByMonth(WoWiModel.WoWiEntities wowidb, int year)
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
                decimal imaM1D = 0, imaM1Q = 0, imaM2D = 0, imaM2Q = 0, imaM3D = 0, imaM3Q = 0, imaM4D = 0, imaM4Q = 0, imaM5D = 0, imaM5Q = 0, imaM6D = 0, imaM6Q = 0, imaM7D = 0, imaM7Q = 0, imaM8D = 0, imaM8Q = 0, imaM9D = 0, imaM9Q = 0, imaM10D = 0, imaM10Q = 0, imaM11D = 0, imaM11Q = 0, imaM12D = 0, imaM12Q = 0, imaTotD = 0, imaTotQ = 0;
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
                        imaM3Q += venM3Q;
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
                    M3Q += imaM3Q;
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

    public static List<IMAVenderCostSeasonReportData> GetIMACostBySeason(WoWiModel.WoWiEntities wowidb, int year)
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
                        venTotD = venM1D + venM2D + venM3D + venM4D;
                        venTotQ = venM1Q + venM2Q + venM3Q + venM4Q;
                        imaM1D += venM1D;
                        imaM1Q += venM1Q;
                        imaM2D += venM2D;
                        imaM2Q += venM2Q;
                        imaM3D += venM3D;
                        imaM3Q += venM3Q;
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
                    M3Q += imaM3Q;
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

    public static List<IMAVenderCostIntervalReportData> GetIMACostByInterval(WoWiModel.WoWiEntities wowidb, DateTime f, DateTime t)
    {
        List<IMAVenderCostIntervalReportData> list = new List<IMAVenderCostIntervalReportData>();
        IMAVenderCostIntervalReportData temp;
        try
        {
            //Find all IMAs
            var imas = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date >= f && pj.Create_Date <= t select pr.create_user).Distinct();

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

    public static List<IMAVenderCostMonthReportData> GetVenderCostByMonth(WoWiModel.WoWiEntities wowidb, int year)
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
                    M1D += venM1D;
                    M1Q += venM1Q;
                    M2D += venM2D;
                    M2Q += venM2Q;
                    M3D += venM3D;
                    M3Q += venM3Q;
                    M4D += venM4D;
                    M4Q += venM4Q;
                    M5D += venM5D;
                    M5Q += venM5Q;
                    M6D += venM6D;
                    M6Q += venM6Q;
                    M7D += venM7D;
                    M7Q += venM7Q;
                    M8D += venM8D;
                    M8Q += venM8Q;
                    M9D += venM9D;
                    M9Q += venM9Q;
                    M10D += venM10D;
                    M10Q += venM10Q;
                    M11D += venM11D;
                    M11Q += venM11Q;
                    M12D += venM12D;
                    M12Q += venM12Q;
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

    public static List<IMAVenderCostSeasonReportData> GetVenderCostBySeason(WoWiModel.WoWiEntities wowidb,int year)
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
                    M1D += venM1D;
                    M1Q += venM1Q;
                    M2D += venM2D;
                    M2Q += venM2Q;
                    M3D += venM3D;
                    M3Q += venM3Q;
                    M4D += venM4D;
                    M4Q += venM4Q;
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

    public static List<IMAVenderCostIntervalReportData> GetVenderCostByInterval(WoWiModel.WoWiEntities wowidb, DateTime f, DateTime t)
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

    public static List<IMAVenderCostMonthReportData> GetVenderClientCostByMonth(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<IMAVenderCostMonthReportData> list = new List<IMAVenderCostMonthReportData>();
        IMAVenderCostMonthReportData temp;
        try
        {

            var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
            decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, M5D = 0, M5Q = 0, M6D = 0, M6Q = 0, M7D = 0, M7Q = 0, M8D = 0, M8Q = 0, M9D = 0, M9Q = 0, M10D = 0, M10Q = 0, M11D = 0, M11Q = 0, M12D = 0, M12Q = 0, TotD = 0, TotQ = 0;

            foreach (var ven in venders)
            {
                
                try
                {
                    String vName = "";
                    var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                    decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venM5D = 0, venM5Q = 0, venM6D = 0, venM6Q = 0, venM7D = 0, venM7Q = 0, venM8D = 0, venM8Q = 0, venM9D = 0, venM9Q = 0, venM10D = 0, venM10Q = 0, venM11D = 0, venM11Q = 0, venM12D = 0, venM12Q = 0, venTotD = 0, venTotQ = 0;
                    foreach (var p in prs)
                    {
                        try
                        {
                            temp = new IMAVenderCostMonthReportData();
                            var v = (from i in wowidb.vendors where i.id == ven select i).First();
                            temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                            vName = temp.VenderName;
                            var pj = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj).First();
                            int month = pj.Create_Date.Month;
                            var quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == pj.Quotation_Id select q).First();
                            temp.Model = quo.Model_No;
                            int cid = (int)quo.Client_Id;
                            try
                            {
                                var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
                                temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;
                            }
                            catch
                            {
                            }


                            var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                            try
                            {
                                var tDesc = ( from kk in wowidb.Quotation_Target from kkk in wowidb.Targets where pri.quotation_target_id == kk.Quotation_Target_Id && kk.target_id == kkk.target_id select kkk.target_description).First();
                                temp.Country = tDesc;

                            }
                            catch (Exception)
                            {
                            }
                            decimal avenM1D = 0, avenM1Q = 0, avenM2D = 0, avenM2Q = 0, avenM3D = 0, avenM3Q = 0, avenM4D = 0, avenM4Q = 0, avenM5D = 0, avenM5Q = 0, avenM6D = 0, avenM6Q = 0, avenM7D = 0, avenM7Q = 0, avenM8D = 0, avenM8Q = 0, avenM9D = 0, avenM9Q = 0, avenM10D = 0, avenM10Q = 0, avenM11D = 0, avenM11Q = 0, avenM12D = 0, avenM12Q = 0, avenTotD = 0, avenTotQ = 0;
                            switch (month)
                            {
                                case 1:
                                    avenM1D = (decimal)pri.amount;
                                    avenM1Q = (decimal)pri.quantity;
                                    break;
                                case 2:
                                    avenM2D = (decimal)pri.amount;
                                    avenM2Q = (decimal)pri.quantity;
                                    break;
                                case 3:
                                    avenM3D = (decimal)pri.amount;
                                    avenM3Q = (decimal)pri.quantity;
                                    break;
                                case 4:
                                    avenM4D = (decimal)pri.amount;
                                    avenM4Q = (decimal)pri.quantity;
                                    break;
                                case 5:
                                    avenM5D = (decimal)pri.amount;
                                    avenM5Q = (decimal)pri.quantity;
                                    break;
                                case 6:
                                    avenM4D = (decimal)pri.amount;
                                    avenM4Q = (decimal)pri.quantity;
                                    break;
                                case 7:
                                    avenM4D = (decimal)pri.amount;
                                    avenM4Q = (decimal)pri.quantity;
                                    break;
                                case 8:
                                    avenM8D = (decimal)pri.amount;
                                    avenM8Q = (decimal)pri.quantity;
                                    break;
                                case 9:
                                    avenM9D = (decimal)pri.amount;
                                    avenM9Q = (decimal)pri.quantity;
                                    break;
                                case 10:
                                    avenM10D = (decimal)pri.amount;
                                    avenM10Q = (decimal)pri.quantity;
                                    break;
                                case 11:
                                    avenM11D = (decimal)pri.amount;
                                    avenM11Q = (decimal)pri.quantity;
                                    break;
                                case 12:
                                    avenM12D = (decimal)pri.amount;
                                    avenM12Q = (decimal)pri.quantity;
                                    break;
                            }
                            
                            avenTotD = avenM1D + avenM2D + avenM3D + avenM4D + avenM5D + avenM6D + avenM7D + avenM8D + avenM9D + avenM10D + avenM11D + avenM12D;
                            avenTotQ = avenM1Q + avenM2Q + avenM3Q + avenM4Q + avenM5Q + avenM6Q + avenM7Q + avenM8Q + avenM9Q + avenM10Q + avenM11Q + avenM12Q;
                            venM1D += avenM1D;
                            venM1Q += avenM1Q;
                            venM2D += avenM2D;
                            venM2Q += avenM2Q;
                            venM3D += avenM3D;
                            venM3Q += avenM3Q;
                            venM4D += avenM4D;
                            venM4Q += avenM4Q;
                            venM5D += avenM5D;
                            venM5Q += avenM5Q;
                            venM6D += avenM6D;
                            venM6Q += avenM6Q;
                            venM7D += avenM7D;
                            venM7Q += avenM7Q;
                            venM8D += avenM8D;
                            venM8Q += avenM8Q;
                            venM9D += avenM9D;
                            venM9Q += avenM9Q;
                            venM10D += avenM10D;
                            venM10Q += avenM10Q;
                            venM11D += avenM11D;
                            venM11Q += avenM11Q;
                            venM12D += avenM12D;
                            venM12Q += avenM12Q;
                            venTotD += avenTotD;
                            venTotQ += avenTotQ;
                            temp.Month01USD = avenM1D.ToString("F2");
                            temp.Month02USD = avenM2D.ToString("F2");
                            temp.Month03USD = avenM3D.ToString("F2");
                            temp.Month04USD = avenM4D.ToString("F2");
                            temp.Month05USD = avenM5D.ToString("F2");
                            temp.Month06USD = avenM6D.ToString("F2");
                            temp.Month07USD = avenM7D.ToString("F2");
                            temp.Month08USD = avenM8D.ToString("F2");
                            temp.Month09USD = avenM9D.ToString("F2");
                            temp.Month10USD = avenM10D.ToString("F2");
                            temp.Month11USD = avenM11D.ToString("F2");
                            temp.Month12USD = avenM12D.ToString("F2");
                            temp.TotalUSD = avenTotD.ToString("F2");

                            temp.Month01QTY = avenM1Q.ToString("F0");
                            temp.Month02QTY = avenM2Q.ToString("F0");
                            temp.Month03QTY = avenM3Q.ToString("F0");
                            temp.Month04QTY = avenM4Q.ToString("F0");
                            temp.Month05QTY = avenM5Q.ToString("F0");
                            temp.Month06QTY = avenM6Q.ToString("F0");
                            temp.Month07QTY = avenM7Q.ToString("F0");
                            temp.Month08QTY = avenM8Q.ToString("F0");
                            temp.Month09QTY = avenM9Q.ToString("F0");
                            temp.Month10QTY = avenM10Q.ToString("F0");
                            temp.Month11QTY = avenM11Q.ToString("F0");
                            temp.Month12QTY = avenM12Q.ToString("F0");
                            temp.TotalQTY = avenTotQ.ToString("F0");
                            list.Add(temp);
                            
                        }
                        catch (Exception)
                        {

                            //throw;
                        }
                   
                    }//Single vender ends
                    M1D += venM1D;
                    M1Q += venM1Q;
                    M2D += venM2D;
                    M2Q += venM2Q;
                    M3D += venM3D;
                    M3Q += venM3Q;
                    M4D += venM4D;
                    M4Q += venM4Q;
                    M5D += venM5D;
                    M5Q += venM5Q;
                    M6D += venM6D;
                    M6Q += venM6Q;
                    M7D += venM7D;
                    M7Q += venM7Q;
                    M8D += venM8D;
                    M8Q += venM8Q;
                    M9D += venM9D;
                    M9Q += venM9Q;
                    M10D += venM10D;
                    M10Q += venM10Q;
                    M11D += venM11D;
                    M11Q += venM11Q;
                    M12D += venM12D;
                    M12Q += venM12Q;
                    TotD += venTotD;
                    TotQ += venTotQ;
                    if (venTotD != 0)
                    {
                        temp = new IMAVenderCostMonthReportData()
                        {
                            VenderName = " Total : "
                        };
                        
                        
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

    public static List<IMAVenderCostSeasonReportData> GetVenderClientCostBySeason(WoWiModel.WoWiEntities wowidb, int year)
    {
        List<IMAVenderCostSeasonReportData> list = new List<IMAVenderCostSeasonReportData>();
        IMAVenderCostSeasonReportData temp;
        try
        {

            var venders = (from pr in wowidb.PRs from pj in wowidb.Projects where pr.project_id == pj.Project_Id && pj.Create_Date.Year == year select pr.vendor_id).Distinct();
            decimal M1D = 0, M1Q = 0, M2D = 0, M2Q = 0, M3D = 0, M3Q = 0, M4D = 0, M4Q = 0, TotD = 0, TotQ = 0;

            foreach (var ven in venders)
            {
                try
                {
                    String vName = "";
                    var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                    temp = new IMAVenderCostSeasonReportData();
                    var v = (from i in wowidb.vendors where i.id == ven select i).First();
                    temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                    vName = temp.VenderName;
                    decimal venM1D = 0, venM1Q = 0, venM2D = 0, venM2Q = 0, venM3D = 0, venM3Q = 0, venM4D = 0, venM4Q = 0, venTotD = 0, venTotQ = 0;
                    foreach (var p in prs)
                    {
                        try
                        {
                            var pj = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj).First();
                            int month = pj.Create_Date.Month;
                            var quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == pj.Quotation_Id select q).First();
                            temp.Model = quo.Model_No;
                            int cid = (int)quo.Client_Id;
                            try
                            {
                                var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
                                temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;
                            }
                            catch
                            {
                            }


                            var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                            try
                            {
                                var tDesc = (from kk in wowidb.Quotation_Target from kkk in wowidb.Targets where pri.quotation_target_id == kk.Quotation_Target_Id && kk.target_id == kkk.target_id select kkk.target_description).First();
                                temp.Country = tDesc;

                            }
                            catch (Exception)
                            {
                            }
                            decimal avenM1D = 0, avenM1Q = 0, avenM2D = 0, avenM2Q = 0, avenM3D = 0, avenM3Q = 0, avenM4D = 0, avenM4Q = 0,  avenTotD = 0, avenTotQ = 0;
                              
                            switch (month)
                            {
                                case 1:
                                case 2:
                                case 3:
                                    avenM1D = (decimal)pri.amount;
                                    avenM1Q = (decimal)pri.quantity;
                                    break;
                                case 4:
                                case 5:
                                case 6:
                                    avenM2D = (decimal)pri.amount;
                                    avenM2Q = (decimal)pri.quantity;
                                    break;
                                case 7:
                                case 8:
                                case 9:
                                    avenM3D = (decimal)pri.amount;
                                    avenM3Q = (decimal)pri.quantity;
                                    break;
                                case 10:
                                case 11:
                                case 12:
                                    avenM4D = (decimal)pri.amount;
                                    avenM4Q = (decimal)pri.quantity;
                                    break;

                            }
                            avenTotD = avenM1D + avenM2D + avenM3D + avenM4D ;
                            avenTotQ = avenM1Q + avenM2Q + avenM3Q + avenM4Q ;

                            venM1D += avenM1D;
                            venM1Q += avenM1Q;
                            venM2D += avenM2D;
                            venM2Q += avenM2Q;
                            venM3D += avenM3D;
                            venM3Q += avenM3Q;
                            venM4D += avenM4D;
                            venM4Q += avenM4Q;
                            venTotD += avenTotD;
                            venTotQ += avenTotQ;
                            temp.Season01USD = M1D.ToString("F2");
                            temp.Season02USD = M2D.ToString("F2");
                            temp.Season03USD = M3D.ToString("F2");
                            temp.Season04USD = M4D.ToString("F2");
                            temp.TotalUSD = avenTotD.ToString("F2");

                            temp.Season01QTY = M1Q.ToString("F0");
                            temp.Season02QTY = M2Q.ToString("F0");
                            temp.Season03QTY = M3Q.ToString("F0");
                            temp.Season04QTY = M4Q.ToString("F0");
                            temp.TotalQTY = avenTotQ.ToString("F0");
                            list.Add(temp);
                        }
                        catch (Exception)
                        {

                            //throw;
                        }

                    }//Single vender ends
                    M1D += venM1D;
                    M1Q += venM1Q;
                    M2D += venM2D;
                    M2Q += venM2Q;
                    M3D += venM3D;
                    M3Q += venM3Q;
                    M4D += venM4D;
                    M4Q += venM4Q;
                    TotD += venTotD;
                    TotQ += venTotQ;
                    if (venTotD != 0)
                    {
                        temp = new IMAVenderCostSeasonReportData()
                        {
                            VenderName = " Total : "
                        };
                        temp.Season01USD = M1D.ToString("F2");
                        temp.Season02USD = M2D.ToString("F2");
                        temp.Season03USD = M3D.ToString("F2");
                        temp.Season04USD = M4D.ToString("F2");
                        temp.TotalUSD = venTotD.ToString("F2");

                        temp.Season01QTY = M1Q.ToString("F0");
                        temp.Season02QTY = M2Q.ToString("F0");
                        temp.Season03QTY = M3Q.ToString("F0");
                        temp.Season04QTY = M4Q.ToString("F0");
                        temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }
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

    public static List<IMAVenderCostIntervalReportData> GetVenderClientCostByInterval(WoWiModel.WoWiEntities wowidb, DateTime f, DateTime t)
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
                    String vName = "";
                    var prs = from pr in wowidb.PRs where pr.vendor_id == ven select pr;
                    temp = new IMAVenderCostIntervalReportData();
                    var v = (from i in wowidb.vendors where i.id == ven select i).First();
                    temp.VenderName = String.IsNullOrEmpty(v.c_name) ? v.name : v.c_name;
                    vName = temp.VenderName;
                    foreach (var p in prs)
                    {
                        try
                        {
                            var pj = (from proj in wowidb.Projects where proj.Project_Id == p.project_id select proj).First();
                            int month = pj.Create_Date.Month;
                            var quo = (from q in wowidb.Quotation_Version where q.Quotation_Version_Id == pj.Quotation_Id select q).First();
                            temp.Model = quo.Model_No;
                            int cid = (int)quo.Client_Id;
                            try
                            {
                                var client = (from cli in wowidb.clientapplicants where cli.id == cid select cli).First();
                                temp.Client = String.IsNullOrEmpty(client.c_companyname) ? client.companyname : client.c_companyname;
                            }
                            catch
                            {
                            }


                            var pri = (from pi in wowidb.PR_item where pi.pr_id == p.pr_id select pi).First();
                            try
                            {
                                var tDesc = (from kk in wowidb.Quotation_Target from kkk in wowidb.Targets where pri.quotation_target_id == kk.Quotation_Target_Id && kk.target_id == kkk.target_id select kkk.target_description).First();
                                temp.Country = tDesc;

                            }
                            catch (Exception)
                            {
                            }
                            temp.TotalUSD = ((decimal)pri.amount).ToString("F2");
                            temp.TotalQTY = ((decimal)pri.quantity).ToString("F0");
                            list.Add(temp);
                            venTotD += (decimal)pri.amount;
                            venTotQ += (decimal)pri.quantity;
                        }
                        catch (Exception)
                        {

                            //throw;
                        }

                    }//Single vender ends

                    TotD += venTotD;
                    TotQ += venTotQ;
                    if (venTotD!=0)
                    {
                        temp = new IMAVenderCostIntervalReportData()
                        {
                            VenderName = " Total : "
                        };
                        temp.TotalUSD = venTotD.ToString("F2");
                        temp.TotalQTY = venTotQ.ToString("F0");
                        list.Add(temp);
                    }

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
}