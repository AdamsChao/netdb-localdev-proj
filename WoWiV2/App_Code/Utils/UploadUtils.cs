using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for UploadUtils
/// </summary>
public class UploadUtils
{
    private static String UploadPathKey = "UploadFolderPath";
	public UploadUtils()
	{
	    
	}

    static public String GetUploadPath()
    {
        String path = null;
        path = ConfigurationManager.AppSettings[UploadPathKey];
        return path;
    }
}