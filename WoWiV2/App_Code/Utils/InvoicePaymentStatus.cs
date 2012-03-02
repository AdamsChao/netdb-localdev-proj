using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InvoicePaymentStatus
/// </summary>

public enum InvoicePaymentStatus : byte
{
    PrePaid1, PrePaid2, PrePaid3, FinalPaid,Received,WithDraw,Init
}