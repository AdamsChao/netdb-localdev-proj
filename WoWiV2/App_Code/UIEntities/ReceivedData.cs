using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ReceivedData
/// </summary>
public class ReceivedData
{
	public ReceivedData()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DateTime ReceivedDate { get; set; }
    public String Amount { get; set; }
    public String Balance { get; set; }
    public String IVNo { get; set; }
    public String Note { get; set; }
    public String InvoiceID { get; set; }

}