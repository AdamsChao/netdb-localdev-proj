using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;
using System.Text;

public partial class Sales_QuotationViewPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int QuotationID;
        string q = Request.QueryString["q"];
        if (q != null && Int32.TryParse(q, out QuotationID))
        {
            hidQuotationID.Text = QuotationID.ToString();
            vw_Quotation_Print quo = Quotation_Controller.GetQuotationPrint(QuotationID);
            if (quo != null)
            {

                hidQuotation_No.Text = quo.Quotation_No.ToString();                
                lblQuotationNo.Text = quo.Quotation_No.ToString();
                lblQuotationNo0.Text = quo.Quotation_No.ToString();
                lblRepresentative.Text = quo.fname + " " + quo.lname;
                lblRepresentative0.Text = quo.fname + " " + quo.lname;
                lblRepresentative1.Text = quo.fname + " " + quo.lname;
                lblBillTo.Text = quo.Bill_Companyname;
                lblBillTo0.Text = quo.Bill_Companyname;
                lblBillTo1.Text = quo.Bill_Companyname;
                lblApplicant.Text = quo.Applicant;
                lblApplicant0.Text = quo.Applicant;
                lblTel.Text = quo.workphone;
                lblTel0.Text = quo.workphone;
                lblEmail.Text = quo.email;
                lblEmail0.Text = quo.email;
                lblDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
                lblDate0.Text = DateTime.Now.ToString("MM/dd/yyyy");
                lblDate1.Text = DateTime.Now.ToString("MM/dd/yyyy");
                lblDescription.Text = quo.Product_Name;
                lblDescription0.Text = quo.Product_Name;
                lblModelName.Text = quo.Model_No;
                lblModelName0.Text = quo.Model_No;
                lblBrandName.Text = quo.Brand_Name;
                lblBrandName0.Text = quo.Brand_Name;
                lblContact.Text = quo.Bill_Name;
                lblContact0.Text = quo.Bill_Name;
                lblClientPhone.Text = quo.Bill_Phone;
                lblClientPhone0.Text = quo.Bill_Phone;
                lblClientEmail.Text = quo.Bill_Email;
                lblClientEmail0.Text = quo.Bill_Email;
                lblClientAddress.Text = quo.Bill_Address;
                lblClientAddress0.Text = quo.Bill_Address;
                lblCleintCountry.Text = quo.Bill_Country;
                lblCleintCountry0.Text = quo.Bill_Country;
                imgSign.ImageUrl = "../Images/sign/" + quo.fname + "." + quo.lname + ".bmp";
                lblTitle.Text = quo.title;

                //Add by Adams 2012/5/1
                lblext.Text = quo.work_ext;
                lblext0.Text = quo.work_ext;
                lblClient.Text = quo.Client;
                lblClient0.Text = quo.Client;
                LabelClient.Text = quo.Client;
                LabelClient0.Text = quo.Client;
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

        lblTotalCost.Text = list[2];
        lblTotalCost2.Text = list[2];
        return sb.ToString();
    }

    decimal SubTotal;
    public decimal GetUnitPrice(decimal Price)
    {
        SubTotal += Price;
        return Price;
    }
}