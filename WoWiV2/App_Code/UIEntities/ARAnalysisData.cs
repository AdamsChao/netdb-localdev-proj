using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoiceData
/// </summary>
public class ARAnalysisData
{
    public String Currency { get; set; }
    public String InvoiceNo { get; set; }
    public String InvoiceDate { get; set; }
    public String Client { get; set; }
    public String USD { get; set; }
    public String Day30USD { get; set; }
    public String Day30P { get; set; }
    public String Day60USD { get; set; }
    public String Day60P { get; set; }
    public String Day90USD { get; set; }
    public String Day90P { get; set; }
    public String Day120USD { get; set; }
    public String Day120P { get; set; }
    public String Day150USD { get; set; }
    public String Day150P { get; set; }
    public String Day180USD { get; set; }
    public String Day180P { get; set; }
    public String Day365USD { get; set; }
    public String Day365P { get; set; }
    public String Year1USD { get; set; }
    public String Year1P { get; set; }
    public String Year2USD { get; set; }
    public String Year2P { get; set; }

    public ARAnalysisData()
    {
        Day30USD = "-";
        Day30P = "0.00%";
        Day60USD = "-";
        Day60P = "0.00%";
        Day90USD = "-";
        Day90P = "0.00%";
        Day120USD = "-";
        Day120P = "0.00%";
        Day150USD = "-";
        Day150P = "0.00%";
        Day180USD = "-";
        Day180P = "0.00%";
        Day365USD = "-";
        Day365P = "0.00%";
        Year1USD = "-";
        Year1P = "0.00%";
        Year2USD = "-";
        Year2P = "0.00%";
    }
}