using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ARUtils
/// </summary>
public class ARUtils
{
    public static String GetARInterval(int days)
    {
        String ret = "2年以上";
        if (days < 0)
        {
            ret = "未逾期";
        }
        else if (days <= 30)
        {
            ret = "0 ~ 30 天";
        }
        else if (days <= 60)
        {
            ret = "31 ~ 60 天";
        }
        else if (days <= 90)
        {
            ret = "61 ~ 90 天";
        }
        else if (days <= 120)
        {
            ret = "91 ~ 120 天";
        }
        else if (days <= 150)
        {
            ret = "121 ~ 150 天";
        }
        else if (days <= 180)
        {
            ret = "151 ~ 180 天";
        }
        else if (days <= 365)
        {
            ret = "181 ~ 365 天";
        }
        else if (days <= 730)
        {
            ret = "1年";
        }
        

        return ret;
    }
}