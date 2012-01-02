using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>
public class BalanceReportData : AmountBalanceReportData
{
    public String TotalQTY { get; set; }
}

public class AmountBalanceReportData
{
   
    public String TotalUSD { get; set; }

}