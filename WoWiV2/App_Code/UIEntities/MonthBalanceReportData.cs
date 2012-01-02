using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>
public class MonthBalanceReportData:AmountMonthBalanceReportData
{

    public String Month01QTY { get; set; }
    public String Month02QTY { get; set; }
    public String Month03QTY { get; set; }
    public String Month04QTY { get; set; }
    public String Month05QTY { get; set; }
    public String Month06QTY { get; set; }
    public String Month07QTY { get; set; }
    public String Month08QTY { get; set; }
    public String Month09QTY { get; set; }
    public String Month10QTY { get; set; }
    public String Month11QTY { get; set; }
    public String Month12QTY { get; set; }
   
}

public class AmountMonthBalanceReportData : BalanceReportData
{
    public String Month01USD { get; set; }
    public String Month02USD { get; set; }
    public String Month03USD { get; set; }
    public String Month04USD { get; set; }
    public String Month05USD { get; set; }
    public String Month06USD { get; set; }
    public String Month07USD { get; set; }
    public String Month08USD { get; set; }
    public String Month09USD { get; set; }
    public String Month10USD { get; set; }
    public String Month11USD { get; set; }
    public String Month12USD { get; set; }

}