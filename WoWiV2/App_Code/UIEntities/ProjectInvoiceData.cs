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

    public String Version { get; set; }
    public String Status { get; set; }
    public String Date { get; set; }
    public String TDescription { get; set; }
    public String Qty { get; set; }
    public String UOM { get; set; }
    public String UnitPrice { get; set; }
    public String FPrice { get; set; }
    public String Bill { get; set; }
}