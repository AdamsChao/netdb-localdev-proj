using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoiceData
/// </summary>
public class PaymentData
{
	public PaymentData()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public String PRNo { get; set; }
    public String PRDate { get; set; }
    public String ProjectNo { get; set; }
    public String VenderNo { get; set; }
    public String Vender { get; set; }
    public String Status { get; set; }
    public String StatusDate { get; set; }
    public String IMA { get; set; }
    public String Model { get; set; }
    public String Country { get; set; }
    public String IMACost { get; set; }
    public String IMACostUSD { get; set; }
    public String QutationNo { get; set; }
    public String PaymentTerms { get; set; }
    public String PlanDueDate { get; set; }
    public String OverDueDays { get; set; }
    public String OverDueInterval { get; set; }
    public String PRCurrency { get; set; }
    public String PRUSD { get; set; }
    public String PRNTD { get; set; }
}