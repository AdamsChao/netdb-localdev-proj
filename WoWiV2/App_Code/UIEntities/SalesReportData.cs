using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>

[Serializable]
public class SalesReportData
{
    public String ProjectNo { get; set; }
    public String OpenDate { get; set; }
    public String QutationNo { get; set; }
    public String Client { get; set; }
    public String Country { get; set; }
    public String Model { get; set; }
    public String Status { get; set; }
    public String StatusDate { get; set; }
    public String Sales { get; set; }
    public String Currency { get; set; }
    public String InvNTD { get; set; }
    public String InvUSD { get; set; }
    public String InvoiceDate { get; set; }
    public String InvNo { get; set; }
    public String ReceivedDate { get; set; }

}