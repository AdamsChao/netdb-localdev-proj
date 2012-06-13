using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;

public partial class Sales_uc_ucCreateQuotationTab4 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
            LoadDropDown();

            int quotation_id = ((Imaster)this.Page).getQuotationID();
            if (quotation_id > 0)
            {
                hidQuotationID.Text = quotation_id.ToString();
                LoadData(quotation_id);
            }
            else
            {
                Load_Lable(DateTime.Now.Month, DateTime.Now.Year);
            }
        }
    }

    private void Load_Lable(int NowMonth, int NowYear)
    {
        List<Label> LabelList = new List<Label>() { lbl00, lbl01, lbl02, lbl03, lbl04, lbl05, lbl06, lbl07, lbl08, lbl09, lbl10, lbl11 };

        List<string> lblMonthText = new List<string>() { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };

        List<TextBox> TextBoxList = new List<TextBox>() { rolling_forecast_dollar0, rolling_forecast_dollar1, rolling_forecast_dollar2, rolling_forecast_dollar3, rolling_forecast_dollar4, rolling_forecast_dollar5, rolling_forecast_dollar6, rolling_forecast_dollar7, rolling_forecast_dollar8, rolling_forecast_dollar9, rolling_forecast_dollar10, rolling_forecast_dollar11 };

        int i = NowMonth;
        foreach (Label item in LabelList)
        {

            if (i > 12)
            {
                i = i - 12;
                NowYear = NowYear + 1;
            }
            item.Text = lblMonthText[i - 1] + "/" +  NowYear.ToString().Substring(2, 2);
            i++;
        }
    }

    private void LoadData(int quotation_id)
    {
        Quotation_Version quo = Quotation_Controller.Get_Quotation(quotation_id);
        txtOpenDate.Text =(quo.Quotation_OpenDate==null)?"":((DateTime)quo.Quotation_OpenDate).ToString("yyyy/MM/dd HH:mm");
        txtOpenBy.Text = quo.create_user;
        txtRevisedDate.Text = (quo.revise_date==null)?"":((DateTime)quo.revise_date).ToString("yyyy/MM/dd HH:mm");
        txtRevisedBy.Text = quo.modify_user;
        //txtTargetTotalPrice.Text = Quotation_Controller.GetTotalUnitPrice(quotation_id).ToString();
        //txtDiscount.Text = Quotation_Controller.GetTotalTargetDiscount(quotation_id).ToString();
        //txtFinalTotalPrice.Text = Quotation_Controller.GetTotalPrice(quotation_id).ToString();

        txtTargetTotalPrice.Text =  (quo.TargetTotalPrice == null)?"0.00": ((Decimal)quo.TargetTotalPrice).ToString("F2");
        txtDiscount.Text = (quo.Discount == null) ? "0.00" : ((Decimal)quo.Discount).ToString("F2");
        txtFinalTotalPrice.Text = (quo.FinalTotalPrice == null) ? "0.00" : ((Decimal)quo.FinalTotalPrice).ToString("F2");
        txtTotal_Disc_Amt.Text = (quo.Total_disc_amt == null) ? "0.00" : ((Decimal)quo.Total_disc_amt).ToString("F2");
        txtRemark.Text = quo.Remark;

        txtPocheckno.Text = quo.pocheckno;
        txtPOLimit.Text = quo.POLimit;
        txtDeposit_Check_No.Text= quo.Deposit_Check_No;
        txtPO_Amount.Text = quo.PO_Amount;
        ddlProbability.SelectedValue = quo.Probability;
        rolling_forecast_dollar0.Text = quo.rolling_forecast_dollar0;
        rolling_forecast_dollar1.Text = quo.rolling_forecast_dollar1;
        rolling_forecast_dollar2.Text = quo.rolling_forecast_dollar2;
        rolling_forecast_dollar3.Text = quo.rolling_forecast_dollar3;
        rolling_forecast_dollar4.Text = quo.rolling_forecast_dollar4;
        rolling_forecast_dollar5.Text = quo.rolling_forecast_dollar5;
        rolling_forecast_dollar6.Text = quo.rolling_forecast_dollar6;
        rolling_forecast_dollar7.Text = quo.rolling_forecast_dollar7;
        rolling_forecast_dollar8.Text = quo.rolling_forecast_dollar8;
        rolling_forecast_dollar9.Text = quo.rolling_forecast_dollar9;
        rolling_forecast_dollar10.Text = quo.rolling_forecast_dollar10;
        rolling_forecast_dollar11.Text = quo.rolling_forecast_dollar11;
        int NowMon = ((DateTime)quo.Quotation_OpenDate).Month;
        int NowYear = ((DateTime)quo.Quotation_OpenDate).Year;
        Load_Lable(NowMon, NowYear);


        //if (quotation_id != 0)
        //{
        //    employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name); 
        //    if (quo.SalesId == emp.id)
        //        btnSubmitType2.Enabled = true;
        //    else
        //        btnSubmitType2.Enabled = false;
        //}
        if (quo.Quotation_Status >= 3)
        {
            btnSubmitType2.Enabled = false;
            txtTotal_Disc_Amt.Enabled = false;
            txtRemark.Enabled = false;
            ddlProbability.Enabled = false;
            rolling_forecast_dollar0.Enabled = false;
            rolling_forecast_dollar1.Enabled = false;
            rolling_forecast_dollar2.Enabled = false;
            rolling_forecast_dollar3.Enabled = false;
            rolling_forecast_dollar4.Enabled = false;
            rolling_forecast_dollar5.Enabled = false;
            rolling_forecast_dollar6.Enabled = false;
            rolling_forecast_dollar7.Enabled = false;
            rolling_forecast_dollar8.Enabled = false;
            rolling_forecast_dollar9.Enabled = false;
            rolling_forecast_dollar10.Enabled = false;
            rolling_forecast_dollar11.Enabled = false;
            dollar_balance.Enabled = false;
            txtPocheckno.Enabled = false;
            txtPOLimit.Enabled = false;
            txtDeposit_Check_No.Enabled = false;
            txtPO_Amount.Enabled = false;
        }
    }

    private void LoadDropDown()
    {
        //ddlQuotstatus.DataSource = CodeTableController.GetAll_Quotation_Status();
        //ddlQuotstatus.DataTextField = "Value";
        //ddlQuotstatus.DataValueField = "Key";
        //ddlQuotstatus.DataBind();
    }

    protected void btnSubmitType2_Click(object sender, EventArgs e)
    {
        Update();
        int quotation_id = ((Imaster)this.Page).getQuotationID();
        if (quotation_id == 0)
        {
            quotation_id = ((Imaster)this.Page).saveQuotationID();
        }

        Quotation_Version quo = Quotation_Controller.Get_Quotation(quotation_id);
        //obj.revise_date
        //obj.modify_user
        //obj.modify_user_ID
        quo.modify_date = DateTime.Now;
        quo.pocheckno=txtPocheckno.Text;
        quo.POLimit = txtPOLimit.Text;
        quo.Deposit_Check_No = txtDeposit_Check_No.Text;
        quo.PO_Amount=txtPO_Amount.Text;


        quo.Probability = ddlProbability.SelectedValue;
        quo.rolling_forecast_dollar0 = rolling_forecast_dollar0.Text;
        quo.rolling_forecast_dollar1 = rolling_forecast_dollar1.Text;
        quo.rolling_forecast_dollar2 = rolling_forecast_dollar2.Text;
        quo.rolling_forecast_dollar3 = rolling_forecast_dollar3.Text;
        quo.rolling_forecast_dollar4 = rolling_forecast_dollar4.Text;
        quo.rolling_forecast_dollar5 = rolling_forecast_dollar5.Text;
        quo.rolling_forecast_dollar6 = rolling_forecast_dollar6.Text;
        quo.rolling_forecast_dollar7 = rolling_forecast_dollar7.Text;
        quo.rolling_forecast_dollar8 = rolling_forecast_dollar8.Text;
        quo.rolling_forecast_dollar9 = rolling_forecast_dollar9.Text;
        quo.rolling_forecast_dollar10 = rolling_forecast_dollar10.Text;
        quo.rolling_forecast_dollar11 = rolling_forecast_dollar11.Text;
        Quotation_Controller.Update_Quotation(Quotation_Controller.ent, quo);

        //LoadData(quotation_id);
        Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=2");

    }
    protected void btnSubmitType1_Click(object sender, EventArgs e)
    {
       

    }


    private void Update()
    {
        bool isUpdate = false;
        int quotation_id = ((Imaster)this.Page).getQuotationID();
        if (quotation_id == 0)
        {
            quotation_id = ((Imaster)this.Page).saveQuotationID();
            isUpdate = false;
        }
        else
        {
            isUpdate = true;
        }

        //if (isUpdate)
        //{
        //    Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
        //    obj.revise_date = DateTime.Now;
        //    obj.modify_user = Page.User.Identity.Name;
        //    employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
        //    obj.modify_user_ID = emp.id;
        //    obj.modify_date = DateTime.Now;
        //    Quotation_Controller.Update_Quotation(Quotation_Controller.ent, obj);
        //}

        Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
        obj.revise_date = DateTime.Now;
        obj.modify_user = Page.User.Identity.Name;
        employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
        obj.modify_user_ID = emp.id;
        obj.modify_date = DateTime.Now;
        //obj.Payment_Method_Id = Int32.Parse(ddlPaymentMethod.SelectedValue);
        obj.Remark = txtRemark.Text;
        obj.Total_disc_amt = Decimal.Parse(txtTotal_Disc_Amt.Text);

        Quotation_Controller.Update_Quotation(Quotation_Controller.ent, obj);
      
    }
}