using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PRStatus
/// </summary>
public enum PRStatus:byte
{
    Init, Requisitioner, Supervisor,VicePresident, President, Cancel, Done, History
}