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
            hidQuotationID.Text = QuotationID.ToString();
            vw_Quotation_Print_Chinese quo = Quotation_Controller.GetQuotationPrintChinese(QuotationID);
            if (quo != null)
            {

                hidQuotation_No.Text = quo.Quotation_No;
                lblQuotationNo.Text = quo.Quotation_No;
                lblRepresentative.Text = quo.c_lname + quo.c_fname;
                lblRepresentative1.Text = quo.c_lname + quo.c_fname;
                lblTel.Text = quo.workphone;
                lblEmail.Text = quo.email;
                lblDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
                lblDate1.Text = DateTime.Now.ToString("MM/dd/yyyy");
                lblBill_Phone.Text = quo.Bill_Phone;
                lblClientAddress.Text = quo.Bill_Address;
                lblCleintCountry.Text = quo.Bill_Country;
                lblBill_Email.Text = quo.Bill_Email;

                //Replacement(MyDoc, "Payment_days", quo.Payment_Term);
                //IEnumerable<vw_Test_Target_List> TargetList = Quotation_Target_Controller.SelectView(quo.Quotation_No);
                //foreach (vw_Test_Target_List item in TargetList)
                //{
                //    targetI++;
                //    MyDoc.Tables[4].Rows.Add();
                //    MyDoc.Tables[4].Cell(targetI, 1).Range.InsertAfter((targetI - 1).ToString());
                //    MyDoc.Tables[4].Cell(targetI, 2).Range.InsertAfter(item.country_name);
                //    MyDoc.Tables[4].Cell(targetI, 3).Range.InsertAfter(item.authority_name);
                //    Total += (Decimal)item.FinalPrice;
                //    MyDoc.Tables[4].Cell(targetI, 4).Range.InsertAfter(item.FinalPrice.ToString());
                //    MyDoc.Tables[4].Cell(targetI, 5).Range.InsertAfter(item.target_description);
                //}
                Decimal Total = 0;
                //todo 計算Total
               
                foreach (GridViewRow row in gvTestTargetList.Rows)
                {
                    Decimal c = 0;
                    Decimal.TryParse(row.Cells[3].Text, out c);
                    Total = Total + c;
                }

                ltlsub_total.Text = Total.ToString();

                //Replacement(MyDoc, "#sub_total#", Total.ToString());
                ltldiscount.Text = quo.Total_disc_amt.ToString();
                ltltotal.Text = (Total - quo.Total_disc_amt).ToString();
                ltl5persert.Text = ((double)(Total - quo.Total_disc_amt) * 0.05).ToString();
                ltlsum.Text = ((double)(Total - quo.Total_disc_amt) * 1.05).ToString();

                lblCProduct_Name.Text = quo.CProduct_Name;
                lblCBrand_Name.Text = quo.CBrand_Name;
                lblCModel_No.Text = quo.CModel_No;
                lblBill_Companyname.Text = quo.c_companyname;
                lblbusiness_registration_number.Text = quo.business_registration_number;
                lblBill_CName.Text = quo.Bill_CName;
                lblClientAddress.Text = quo.Bill_Address;
                lblCleintCountry.Text = quo.Bill_Country;
                imgSign.ImageUrl = "../Images/sign/" + quo.fname + "." + quo.lname + ".bmp";
                lblTitle.Text = quo.title;



            }
        }

    }

    private List<string> LoadData(int quotation_id)
    {
        Quotation_Version quo = Quotation_Controller.Get_Quotation(quotation_id);
        string Discount = Quotation_Controller.GetTotalVersionTotal_disc_amt(quo.Quotation_No);
        string Total = (SubTotal - Decimal.Parse(Discount)).ToString();

        List<string> list = new List<string>();
        list.Add(SubTotal.ToString("N2"));
        list.Add(Discount);
        list.Add(Total);
        return list;
    }

    public string GetNumber()
    {
        int QuotationID = Int32.Parse(hidQuotationID.Text);
        List<string> list = LoadData(QuotationID);
        StringBuilder sb = new StringBuilder();
        sb.Append("<table><tr><td>SubTotal</td></tr><tr><td>Discount</td></tr><tr><td>Total</td></tr></table>");

        sb.Replace("SubTotal", list[0]);
        sb.Replace("Discount", list[1]);
        sb.Replace("Total", list[2]);

        //lblTotalCost.Text = list[2];
        //lblTotalCost2.Text = list[2];
        return sb.ToString();
    }

    decimal SubTotal;
    public decimal GetUnitPrice(decimal Price)
    {
        SubTotal += Price;
        return Price;
    }
}