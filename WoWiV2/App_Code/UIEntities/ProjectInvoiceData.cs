using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoiceData
/// </summary>
public class ProjectInvoiceData
{
    public ProjectInvoiceData()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public String No { get; set; }
    public String Version { get { return No + "-" + VersionNo; }  }
    public int VersionNo { get; set; }
    public String Status { get; set; }
    public DateTime Date { get; set; }
    public String TDescription { get; set; }
    public double Qty { get; set; }
    public String UOM { get; set; }
    public decimal UnitPrice { get; set; }
    public decimal FPrice { get; set; }
    public String Bill { get; set; }
    public String PayType { get; set; }
    public String PayAmount { get; set; }
    public int Qutation_Target_Id { get; set; }
 
}