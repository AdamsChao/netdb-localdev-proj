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
            hidQuotation_No.Text = Quotation_Controller.Get_Quotation(QuotationID).Quotation_No.ToString();
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

        return sb.ToString();
    }

    decimal SubTotal;
    public decimal GetUnitPrice(decimal Price)
    {
        SubTotal += Price;
        return Price;
    }
}