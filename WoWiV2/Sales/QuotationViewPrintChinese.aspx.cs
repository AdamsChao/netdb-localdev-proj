using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using QuotationModel;

public partial class Sales_QuotationViewPrintChinese : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        int QuotationID;
        string q = Request.QueryString["q"];
        if (q != null && Int32.TryParse(q, out QuotationID))
        {
            vw_Quotation_Print_Chinese quo = Quotation_Controller.GetQuotationPrintChinese(QuotationID);

            if (quo != null)
            {
                using (MemoryStream stream = new MemoryStream())
                {
                    StreamReader sr = new StreamReader("c:/ch_Quotation.xml");
                    string xml = sr.ReadToEnd();
                    sr.Close();

                    StreamReader sr2 = new StreamReader("c:/target.xml");
                    string xmlTarget = sr2.ReadToEnd();
                    sr2.Close();

                    xml = xml.Replace("#Quotation_No#", quo.Quotation_No);
                    xml = xml.Replace("#Sales_Name#", quo.c_fname + " " + quo.c_lname);
                    xml = xml.Replace("#Sales_Phone#", quo.workphone);
                    xml = xml.Replace("#Date#", DateTime.Now.ToString("MM/dd/yyyy"));
                    xml = xml.Replace("#Sales_Email#", quo.email);
                    xml = xml.Replace("#Payment_Days#", quo.Payment_Days);
                    //string Payment_Term = "";
                    //if (quo.Payment_Term == "Net 30")
                    //    Payment_Term = "電匯";
                    ////else if (quo.Payment_Term == "Cache")
                    ////    Payment_Term = "即期支票";
                    //else
                    //    Payment_Term = quo.Payment_Term;

                    xml = xml.Replace("#CProduct_Name#", quo.CProduct_Name);
                    xml = xml.Replace("#CBrand_Name#", quo.CBrand_Name);
                    xml = xml.Replace("#CModel_No#", quo.CModel_No);
                    xml = xml.Replace("#Bill_Companyname#", quo.Bill_Companyname);
                    xml = xml.Replace("#Bill_CName#", quo.Bill_CName);
                    xml = xml.Replace("#Bill_Phone#", quo.Bill_Phone);
                    xml = xml.Replace("#Bill_Country#", quo.Bill_Country);
                    xml = xml.Replace("#Bill_Address#", quo.Bill_Address);
                    xml = xml.Replace("#Bill_Email#", quo.Bill_Email);


                    //xml = xml.Replace("#Payment_Term#", Payment_Term);
                    xml = xml.Replace("#Sales_Phone#", quo.workphone);

                    IEnumerable<vw_Test_Target_List> TargetList = Quotation_Target_Controller.SelectView(quo.Quotation_No);

                    StringBuilder xmlTargetList = new StringBuilder();
                    int i = 1;

                    foreach (vw_Test_Target_List item in TargetList)
                    {
                        string tempXml = xmlTarget;
                        tempXml = tempXml.Replace("#no#", i.ToString());
                        i++;
                        tempXml = tempXml.Replace("#app_country#", item.country_name);
                        tempXml = tempXml.Replace("#Authority#", item.authority_name);

                        tempXml = tempXml.Replace("#target_sub_total#", item.FinalPrice.ToString());
                        tempXml = tempXml.Replace("#target_description#", item.target_description);
                        xmlTargetList.Append(tempXml);
                    }
                    xml = xml.Replace("#target#", xmlTargetList.ToString());

                    byte[] Img_byte = ReadFile(Server.MapPath("../") + "\\Images\\sign\\Rose.ke.bmp");
                    //將圖檔轉成Base64Code後置換
                    //object ImgObj = Img_byte;
                    //string picBase64 =     Convert.ToBase64String(ms.GetBuffer(), Base64FormattingOptions.InsertLineBreaks);
                    string Base64Str = Convert.ToBase64String(Img_byte, Base64FormattingOptions.InsertLineBreaks);
                    //xml = xml.Replace("#sign#", xmlTargetList.ToString());

               

                    StreamWriter sw = new StreamWriter(stream);
                    sw.Write(xml);
                    sw.Flush();
                    sw.Close();

                    // Convert the memory stream to an array of bytes.
                    byte[] byteArray = stream.ToArray();

                    // Send the  file to the web browser for download.
                    Response.Clear();
                    Response.AppendHeader("Content-Disposition", "attachment; filename=ExportedFile.doc");
                    Response.AppendHeader("Content-Length", byteArray.Length.ToString());
                    Response.ContentType = "application/octet-stream";
                    Response.BinaryWrite(byteArray);

                }

            }
        }

    }

    private byte[] ReadFile(string filename)
    {
        FileStream fs = new FileStream(filename, FileMode.Open);
        byte[] buffer = new byte[fs.Length];
        fs.Read(buffer, 0, buffer.Length);
        fs.Close();
        return buffer;
    }
}