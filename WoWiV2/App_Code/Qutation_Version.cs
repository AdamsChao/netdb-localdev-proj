using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Objects.DataClasses;

/// <summary>
/// Summary description for Qutation_Version
/// </summary>
/// 
namespace QuotationModel
{
    public partial class Quotation_Version : EntityObject
    {
        public String VersionStr
        {
            get
            {
                return Vername.ToString();
            }
        }
    }
}