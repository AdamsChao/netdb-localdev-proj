using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoiceData
/// </summary>
public class ARInvoiceData : InvoiceData
{
	
    public String PaymentTerms { get; set; }
    public String PlanDueDate { get; set; }
    public String OverDueDays { get; set; }
    public String OverDueInterval { get; set; }
    public String ARBalance { get; set; }
    public String OCurrency { get; set; }
}