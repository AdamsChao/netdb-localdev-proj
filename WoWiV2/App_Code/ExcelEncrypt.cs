using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Office.Interop.Excel;
using System.Reflection;
using System.IO;

/// <summary>
/// ExcelEncrypt 的摘要描述
/// </summary>
public class ExcelEncrypt
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="UnEncryptFileName">Excel原始檔名</param>
    /// <param name="EncryptFileName">Excel加密後檔名</param>
    /// <param name="OpenExcelPassword">允許開啟密碼</param>
    /// <param name="WriteExcelPassword">允許編寫密碼</param>
    public static void EncryptExcelByPassword(string UnEncryptFileName, string EncryptFileName,
      string OpenExcelPassword, string WriteExcelPassword)
    {
        ApplicationClass xApp = new ApplicationClass();
        try
        {
            Workbook xBook = xApp.Workbooks.Open(UnEncryptFileName,
          Missing.Value, Missing.Value, Missing.Value, Missing.Value,
          Missing.Value, Missing.Value, Missing.Value, Missing.Value,
          Missing.Value, Missing.Value, Missing.Value, Missing.Value);

            if (File.Exists(EncryptFileName)) File.Delete(EncryptFileName);

            xBook.SaveAs(EncryptFileName, XlFileFormat.xlExcel12
                , OpenExcelPassword, WriteExcelPassword, Missing.Value,
              Missing.Value, XlSaveAsAccessMode.xlNoChange, Missing.Value,
              Missing.Value, Missing.Value, Missing.Value, Missing.Value);
            xBook.Save();
            xBook.Close();
            xBook = null;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            xApp.Quit();
            System.Runtime.InteropServices.Marshal.ReleaseComObject(xApp);
            xApp = null;
        }
        GC.Collect();
    }

    /// <summary>
    /// 隨機產生八碼的亂數組合
    /// </summary>
    /// <returns></returns>
    public static string GenerateRandomCode()
    {
        string RandomCode = string.Empty;
        char[] character = { '2', '3', '4', '5', '6', '8', '9',
                         'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'R', 'S', 'T', 'W', 'X', 'Y',
                         'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'm', 'n', 'p', 'r', 's', 't', 'w', 'y'};
        Random rnd = new Random();

        for (int i = 0; i < 8; i++)
        {
            RandomCode += character[rnd.Next(character.Length)];
        }
        return RandomCode;
    }

}