using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>
public class SalesClientMonthReportData : AmountMonthBalanceReportData
{
    public String Sales { get; set; }
    public String Client { get; set; }
    public String Country { get; set; }
    public String Model { get; set; }
}