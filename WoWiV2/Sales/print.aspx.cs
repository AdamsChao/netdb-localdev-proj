using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Word;
using QuotationModel;
using System.Text;

public partial class Sales_print : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int QuotationID;
        string q = Request.QueryString["q"];
        //string q = "1";
        if (q != null && Int32.TryParse(q, out QuotationID))
        {
            vw_Quotation_Print_Chinese quo = Quotation_Controller.GetQuotationPrintChinese(QuotationID);

            if (quo != null)
            {

                ApplicationClass wordApp = new ApplicationClass();
                object missing = System.Reflection.Missing.Value;
                object tempName = @"C:\Quotation.doc";//word範本檔案
                object docName = @"C:\a.doc";//要儲存的檔案名稱
                Document MyDoc = wordApp.Documents.Add(ref tempName, ref missing, ref missing, ref missing);
                wordApp.Visible = true;
                MyDoc.Activate();

                //找書籤，取代為簽名圖片


                object format = WdSaveFormat.wdFormatDocument;
                object Nothing = System.Reflection.Missing.Value;
                object objt = true;
                if (MyDoc.Bookmarks.Count >= 1)
                {
                    int i = MyDoc.Bookmarks.Count;
                    Bookmark bmk;
                    object item;
                    object start;
                    object end;

                    while (i > 0)
                    {
                        item = i;
                        bmk = MyDoc.Bookmarks.get_Item(ref item);
                        start = bmk.Start;
                        end = bmk.End;
                        MyDoc.Range(ref start, ref end).InlineShapes.AddPicture("D:\\Rose.ke.bmp", ref missing, ref missing, ref missing);
                        i--;
                    }
                }

               
                Replacement(MyDoc, "#Quotation_No#", quo.Quotation_No);
                Replacement(MyDoc, "#Sales_Name#", quo.c_fname + " " + quo.c_lname);
                Replacement(MyDoc, "#Sales_Phone#", quo.workphone);
                Replacement(MyDoc, "#Date#", DateTime.Now.ToString("MM/dd/yyyy"));
                Replacement(MyDoc, "#Sales_Email#", quo.email);
                Replacement(MyDoc, "#Payment_Days#", quo.Payment_Days);
                Replacement(MyDoc, "#CProduct_Name#", quo.CProduct_Name);
                Replacement(MyDoc, "#CBrand_Name#", quo.CBrand_Name);
                Replacement(MyDoc, "#CModel_No#", quo.CModel_No);
                Replacement(MyDoc, "#Bill_Companyname#", quo.Bill_Companyname);
                Replacement(MyDoc, "#Bill_CName#", quo.Bill_CName);
                Replacement(MyDoc, "#Bill_Phone#", quo.Bill_Phone);
                Replacement(MyDoc, "#Bill_Country#", quo.Bill_Country);
                Replacement(MyDoc, "#Bill_Address#", quo.Bill_Address);
                Replacement(MyDoc, "#Bill_Email#", quo.Bill_Email);
                Replacement(MyDoc, "#Sales_Phone#", quo.workphone);
                Replacement(MyDoc, "Payment_days", quo.Payment_Term);

                IEnumerable<vw_Test_Target_List> TargetList = Quotation_Target_Controller.SelectView(quo.Quotation_No);

                StringBuilder xmlTargetList = new StringBuilder();
                int targetI = 1;


                Decimal Total = 0;
                foreach (vw_Test_Target_List item in TargetList)
                {
                    targetI++;
                    MyDoc.Tables[4].Rows.Add();
                    MyDoc.Tables[4].Cell(targetI, 1).Range.InsertAfter((targetI-1).ToString());
                    MyDoc.Tables[4].Cell(targetI, 2).Range.InsertAfter(item.country_name);
                    MyDoc.Tables[4].Cell(targetI, 3).Range.InsertAfter(item.authority_name);
                    Total += (Decimal)item.FinalPrice;
                    MyDoc.Tables[4].Cell(targetI, 4).Range.InsertAfter(item.FinalPrice.ToString());
                    MyDoc.Tables[4].Cell(targetI, 5).Range.InsertAfter(item.target_description);   
                }
                Replacement(MyDoc, "#target#", xmlTargetList.ToString());
                Replacement(MyDoc, "#sub_total#", Total.ToString());
                Replacement(MyDoc, "#discount#", quo.Total_disc_amt.ToString());
                Replacement(MyDoc, "#total#", (Total-quo.Total_disc_amt).ToString());
                Replacement(MyDoc, "#5persert#", ((double)(Total - quo.Total_disc_amt) *0.05).ToString());
                Replacement(MyDoc, "#sum#", ((double)(Total - quo.Total_disc_amt) * 1.05).ToString());
                
                //另存新檔
                MyDoc.SaveAs(ref docName, ref missing, ref missing, ref missing,
                ref missing, ref missing, ref missing, ref missing,
                ref missing, ref missing, ref missing, ref missing,
                ref missing, ref missing, ref missing, ref missing);
                //另存新檔結束
                MyDoc.Close(ref missing, ref missing, ref missing);//關閉
                wordApp.Quit(ref missing, ref missing, ref missing);//結束word程式
                MyDoc = null;
                wordApp = null;
                Response.Redirect("DownloadWord.aspx?id=" + "a.doc");//將檔案名稱傳送到另一個頁面

            }
        }

    }

    private void Replacement(Document MyDoc, string orgString, string repString)
    {
        object replaceAll = WdReplace.wdReplaceAll;
        object missing = System.Reflection.Missing.Value;


        MyDoc.ActiveWindow.Selection.Find.Text = orgString;
        MyDoc.ActiveWindow.Selection.Find.Replacement.Text = repString;
        MyDoc.ActiveWindow.Selection.Find.Execute(ref missing, ref missing, ref missing,
                                                ref missing, ref missing, ref missing,
                                                ref missing, ref missing, ref missing,
                                                ref missing, ref replaceAll,
                                                ref missing, ref missing, ref missing,
                                                ref missing);
    }
}