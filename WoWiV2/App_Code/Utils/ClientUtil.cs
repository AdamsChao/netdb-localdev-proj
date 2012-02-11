using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ClientUtil
/// </summary>
public class ClientUtil
{
    public static String GetPaymentTerm(PaymentTerms pt)
    {
        return pt.ToString().Replace('_', ' ');
    }
}

