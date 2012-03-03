using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoiceData
/// </summary>
public class InvoiceData
{
	public InvoiceData()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public String id { get; set; }
    public String InvoiceNo { get; set; }
    public String InvoiceDate { get; set; }
    public String ProjectNo { get; set; }
    public String Client { get; set; }
    //客戶聯絡窗口
    public String Attn { get; set; }
    public double USD { get; set; }
    public double NTD { get; set; }
    public String IVDate { get; set; }
    public String IVNo { get; set; }
    public String Sales { get; set; }
    public String Model { get; set; }
    public String Country { get; set; }
    public String QutationNo { get; set; }
    public String Currency { get; set; }
}