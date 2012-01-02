using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for UploadUtils
/// </summary>
public class UploadFile
{
    public UploadFile()
	{
	    
	}    

    static public String GetUploadPathGeneral() 
    {
        String path = null;
        path = ConfigurationManager.AppSettings["UploadFolderGeneral"];
        return path;
    }

    static public String GetUploadPathRF()
    {
        String path = null;
        path = ConfigurationManager.AppSettings["UploadFolderRF"];
        return path;
    }

    static public String GetUploadPathEMC()
    {
        String path = null;
        path = ConfigurationManager.AppSettings["UploadFolderEMC"];
        return path;
    }

    static public String GetUploadPathSafety()
    {
        String path = null;
        path = ConfigurationManager.AppSettings["UploadFolderSafety"];
        return path;
    }

    static public String GetUploadPathTelecom()
    {
        String path = null;
        path = ConfigurationManager.AppSettings["UploadFolderTelecom"];
        return path;
    }
}