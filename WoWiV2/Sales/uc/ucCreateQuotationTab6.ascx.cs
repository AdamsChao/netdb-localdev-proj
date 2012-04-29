using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;
using System.Web.UI.HtmlControls;
using System.Data;

public partial class Sales_uc_ucCreateQuotationTab6 : System.Web.UI.UserControl
{



    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int quotation_id = ((Imaster)this.Page).getQuotationID();
            if (quotation_id > 0)
            {
                hidQuotationID.Text = quotation_id.ToString();
                hidQuotation_No.Text = Quotation_Controller.Get_Quotation(quotation_id).Quotation_No.ToString();
                LoadData(quotation_id);
            }


        }
    }

    private void LoadData(int quotation_id)
    {
        Quotation_Version quo = Quotation_Controller.Get_Quotation(quotation_id);

        //Add by Adams 2012/4/30 for One Quotation only for one version
        lblService.Text = Quotation_Controller.GetTotalUnitPrice(quo.Quotation_Version_Id).ToString();
        lblDiscount.Text = Quotation_Controller.GetTotalTargetDiscount(quo.Quotation_Version_Id).ToString();
        //Mark by Adams 2012/4/30 for One Quotation only for one version
        //lblService.Text = Quotation_Controller.GetTotalVersionUnitPrice(quo.Quotation_No);
        //lblDiscount.Text = Quotation_Controller.GetTotalVersionDiscount(quo.Quotation_No);

        lblSubTotal.Text = (Decimal.Parse(lblService.Text) - Decimal.Parse(lblDiscount.Text)).ToString();
        //txtFinalTotalPrice.Text = Quotation_Controller.GetTotalPrice(quotation_id);
        //txtTotal_Disc_Amt.Text = quo.Total_disc_amt.ToString();
        //txtRemark.Text = quo.Remark;
       

        if (quotation_id != 0)
        {
            employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
            if (quo.SalesId == emp.id)
                btnSubmit.Enabled = true;
            else
                btnSubmit.Enabled = false;
        }
    }

    //public string myFunc(string val)
    //{

    //    if (val == "")

    //        return null;

    //    else

    //        return val;

    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Row in gvTestTargetList.Rows)
        {
            Label lblQuotation_Target_Id = (Label)Row.FindControl("lblQuotation_Target_Id");
            TextBox txtBill1 = (TextBox)Row.FindControl("txtBill1");
            TextBox txtBill2 = (TextBox)Row.FindControl("txtBill2");
            TextBox txtBill3 = (TextBox)Row.FindControl("txtBill3");
            TextBox txtBillE = (TextBox)Row.FindControl("txtBillE");
            HtmlInputHidden hidBill1 = (HtmlInputHidden)Row.FindControl("hidBill1");
            HtmlInputHidden hidBill2 = (HtmlInputHidden)Row.FindControl("hidBill2");
            HtmlInputHidden hidBill3 = (HtmlInputHidden)Row.FindControl("hidBill3");
            HtmlInputHidden hidBillE = (HtmlInputHidden)Row.FindControl("hidBillE");


            int id = Int32.Parse(lblQuotation_Target_Id.Text);
            Quotation_Target target = Quotation_Target_Controller.Select(id);
            try
            {
                DropDownList ddlPR_Flag = (DropDownList)Row.FindControl("ddlPR_Flag");
                target.PR_Flag = ddlPR_Flag.SelectedValue;
            }
            catch (Exception)
            {
                //throw;
            }
            Decimal Bill1 = 0;
            Decimal Bill2 = 0;
            Decimal Bill3 = 0;
            Decimal BillE = 0;
            if (Decimal.TryParse(hidBill1.Value, out Bill1))
                target.Bill1 = Bill1;
            if (Decimal.TryParse(hidBill2.Value, out Bill2))
                target.Bill2 = Bill2;
            if (Decimal.TryParse(hidBill3.Value, out Bill3))
                target.Bill3 = Bill3;
            if (Decimal.TryParse(hidBillE.Value, out BillE))
                target.BillE = BillE;

            Quotation_Target_Controller.Modify(target);
        }
        int quotation_id = ((Imaster)this.Page).getQuotationID();
        Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=3");
    }

    decimal TotalBilled = 0;
    protected void gvTestTargetList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtBill1 = (TextBox)e.Row.FindControl("txtBill1");
            TextBox txtBill2 = (TextBox)e.Row.FindControl("txtBill2");
            TextBox txtBill3 = (TextBox)e.Row.FindControl("txtBill3");
            TextBox txtBillE = (TextBox)e.Row.FindControl("txtBillE");
            
            HtmlInputHidden hidBill1 = (HtmlInputHidden)e.Row.FindControl("hidBill1");
            HtmlInputHidden hidBill2 = (HtmlInputHidden)e.Row.FindControl("hidBill2");
            HtmlInputHidden hidBill3 = (HtmlInputHidden)e.Row.FindControl("hidBill3");
            HtmlInputHidden hidBillE = (HtmlInputHidden)e.Row.FindControl("hidBillE");

            if (txtBill1.Text != "")
            {
                TotalBilled += decimal.Parse(txtBill1.Text);
                //txtBill1.Text = "0";
                //hidBill1.Value = "0";
            }
            if (txtBill2.Text != "")
            {
                TotalBilled += decimal.Parse(txtBill2.Text);
                //txtBill2.Text = "0";
                //hidBill2.Value = "0";
            }
            if (txtBill3.Text != "")
            {
                TotalBilled += decimal.Parse(txtBill3.Text);
                //txtBill3.Text = "0";
                //hidBill3.Value = "0";
            }
            if (txtBillE.Text != "")
            {
                TotalBilled += decimal.Parse(txtBillE.Text);
                //txtBillE.Text = "0";
                //hidBillE.Value = "0";
            }
            lblTotalBilled.Text = TotalBilled.ToString();
            lblBlance.Text = (Decimal.Parse(lblSubTotal.Text) - TotalBilled).ToString();
            
            Label lblFPrice = (Label)e.Row.FindControl("lblFPrice");
            Label lblQuotation_Target_Id = (Label)e.Row.FindControl("lblQuotation_Target_Id");
            Literal lblInvoiceNo1 = (Literal)e.Row.FindControl("lblInvoiceNo1");
            Literal lblInvoiceNo2 = (Literal)e.Row.FindControl("lblInvoiceNo2");
            Literal lblInvoiceNo3 = (Literal)e.Row.FindControl("lblInvoiceNo3");
            Literal lblInvoiceNoE = (Literal)e.Row.FindControl("lblInvoiceNoE");
            Literal lblInvoiceDate1 = (Literal)e.Row.FindControl("lblInvoiceDate1");
            Literal lblInvoiceDate2 = (Literal)e.Row.FindControl("lblInvoiceDate2");
            Literal lblInvoiceDate3 = (Literal)e.Row.FindControl("lblInvoiceDate3");
            Literal lblInvoiceDateE = (Literal)e.Row.FindControl("lblInvoiceDateE");


            DropDownList ddlPR_Flag = (DropDownList)e.Row.FindControl("ddlPR_Flag");
            ddlPR_Flag.SelectedValue = ddlPR_Flag.ToolTip;
            ddlPR_Flag.ToolTip = "";

            int quotation_Id = Int32.Parse(hidQuotationID.Text);
            int target_Id = Int32.Parse(lblQuotation_Target_Id.Text);
            //lblInvoice0.Text = Quotation_Controller.GetInvoice(quotation_Id,target_Id, 0);
            //lblInvoice3.Text = Quotation_Controller.GetInvoice(quotation_Id,target_Id, 3);
            lblInvoiceNo1.Text = Quotation_Controller.GetInvoiceNo(quotation_Id, target_Id, 0);
            lblInvoiceNo2.Text = Quotation_Controller.GetInvoiceNo(quotation_Id, target_Id, 1);
            lblInvoiceNo3.Text = Quotation_Controller.GetInvoiceNo(quotation_Id, target_Id, 2);
            lblInvoiceNoE.Text = Quotation_Controller.GetInvoiceNo(quotation_Id, target_Id, 3);
            lblInvoiceDate1.Text = Quotation_Controller.GetInvoiceDate(quotation_Id, target_Id, 0);
            lblInvoiceDate2.Text = Quotation_Controller.GetInvoiceDate(quotation_Id, target_Id, 1);
            lblInvoiceDate3.Text = Quotation_Controller.GetInvoiceDate(quotation_Id, target_Id, 2);
            lblInvoiceDateE.Text = Quotation_Controller.GetInvoiceDate(quotation_Id, target_Id, 3);



            //txtAdv2.Attributes.Add("onkeyup", "cmdText('" +
            // ddlAdv.ClientID + "','" + txtAdv2.ClientID + "','" +
            // txtB1.ClientID + "','" + txtB2.ClientID + "','" +
            //    hidA1.ClientID + "','" + hidA2.ClientID + "','" +
            // hidB1.ClientID + "','" + hidB2.ClientID + "','" +
            // lblFPrice.Text + "');");

            //txtBill1, txtBill2, txtBill3, txtBillE, hidBill1, hidBill2, hidBill3, hidBillE, fPrice
            txtBill1.Attributes.Add("onkeyup", "cmdText('" +
                txtBill1.ClientID + "','" + txtBill2.ClientID + "','" +
                txtBill3.ClientID + "','" + txtBillE.ClientID + "','" +
                hidBill1.ClientID + "','" + hidBill2.ClientID + "','" +
                hidBill3.ClientID + "','" + hidBillE.ClientID + "','" +
                lblFPrice.Text + "');");

            txtBill2.Attributes.Add("onkeyup", "cmdText('" +
              txtBill1.ClientID + "','" + txtBill2.ClientID + "','" +
              txtBill3.ClientID + "','" + txtBillE.ClientID + "','" +
              hidBill1.ClientID + "','" + hidBill2.ClientID + "','" +
              hidBill3.ClientID + "','" + hidBillE.ClientID + "','" +
              lblFPrice.Text + "');");

            txtBill3.Attributes.Add("onkeyup", "cmdText('" +
              txtBill1.ClientID + "','" + txtBill2.ClientID + "','" +
              txtBill3.ClientID + "','" + txtBillE.ClientID + "','" +
              hidBill1.ClientID + "','" + hidBill2.ClientID + "','" +
              hidBill3.ClientID + "','" + hidBillE.ClientID + "','" +
              lblFPrice.Text + "');");

            txtBillE.Attributes.Add("onkeyup", "changeHiddenValue('" +
              txtBillE.ClientID + "','" + hidBillE.ClientID +  "');");


        }
    }


}