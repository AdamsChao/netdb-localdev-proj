using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>
public class AmountSeasonBalanceReportData:BalanceReportData
{
   
    public String Season01USD { get; set; }
    public String Season02USD { get; set; }
    public String Season03USD { get; set; }
    public String Season04USD { get; set; }
   
}

public class SeasonBalanceReportData : AmountSeasonBalanceReportData
{


    public String Season01QTY { get; set; }
    public String Season02QTY { get; set; }
    public String Season03QTY { get; set; }
    public String Season04QTY { get; set; }

}