using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Data.SqlClient;
using System.Data;
using QuotationModel;

public partial class Sales_uc_ucCreateQuotationTab1 : System.Web.UI.UserControl, Iprovider
{
    #region Iprovider 成員

    public event providerEventHandler QuotationIDChanged;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //int QuotationID = ((Imaster)this.Page).getQuotationID();
            int QuotationID = ((Imaster)this.Page).getQuotationID();
            if (QuotationID != 0)
            {
                LoadData(QuotationID);
            }
            else
            {
                employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
                DropDownListEmp.SelectedValue = emp.id.ToString();
            }
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int QuotationID = ((Imaster)this.Page).getQuotationID();
        if (QuotationID != 0)
        {
            Update(QuotationID);
        }
        else
        {
            QuotationID = Save();
        }
        //ltlMessage.Text = "<Script language='JavaScript'>alert('Saved Succeed');</Script>";
        //Response.Redirect("CreateQuotation.aspx?q=" + QuotationID.ToString());


        //String url = "CreateQuotation.aspx?q=" + QuotationID.ToString();
        //Response.Write("<script src='../Scripts/jquery-1.4.1.min.js' type='text/javascript'></script><Script language='JavaScript'>$(document).ready(function () {alert('Saved Succeed!');window.location='" + url + "';})</Script>");
        //Response.End();

        Response.Redirect("CreateQuotation.aspx?q=" + QuotationID.ToString());


    }

    public int Save()
    {
        Quotation_Version obj = new Quotation_Version();

        obj.Quotation_No = DateTime.Now.ToString("yyyyMMdd-HHmmss");
        obj.Vername = 1;
        obj.Quotation_OpenDate = DateTime.Now;
        //obj.revise_date-
        obj.create_user = Page.User.Identity.Name;
        employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
        obj.create_user_ID = emp.id;
        obj.create_date = DateTime.Now;
        //obj.modify_user=Page.User.Identity.Name;
        //obj.modify_user_ID
        //obj.modify_date
        obj.Quotation_Status = 1;
        obj.Quotation_Statusdate = DateTime.Now;
        ////obj.Quotation_Statusby
        //obj.Quotation_StatusbyID
        //obj.Payment_Method_Id = Int32.Parse(ddlPaymentMethod.SelectedValue);
        //obj.pocheckno
        //obj.paymentlimit
        obj.SalesId = Int32.Parse(DropDownListEmp.SelectedValue);
        obj.Currency = RadioButtonListCurrency.Text;
        obj.Product_Name = txtProductName.Text;
        obj.CProduct_Name = txtCProductName.Text;
        obj.Model_No = txtModelNo.Text;
        obj.CModel_No = txtCModelNo.Text;
        obj.Brand_Name = txtBrandName.Text;
        obj.CBrand_Name = txtCBrandName.Text;
        obj.Model_Difference = txtModelDifference.Text;
        obj.CModel_Difference = txtCModelDifferencev.Text;
        obj.Client_Id = Int32.Parse(DropDownListClient.SelectedValue);
        //obj.Client_Contact = 
        obj.Applicant_Id = Int32.Parse(DropDownListApp.SelectedValue);
        //obj.Applicant_Contact
        obj.Bill_Name = txtBill_Name.Text;
        obj.Bill_Title = txtBill_Title.Text;
        obj.Bill_Companyname = txtBillCompanyname.Text;
        obj.Bill_CName = txtBill_CName.Text;
        obj.Bill_CTitle = txtBill_CTitle.Text;
        obj.Bill_CCompanyname = txtBill_CCompanyname.Text;
        obj.Bill_Phone = txtBill_Phone.Text;
        obj.Bill_Email = txtBill_Email.Text;
        obj.Bill_Country = txtBill_Country.Text;
        obj.Bill_Address = txtBill_Address.Text;
        obj.Bill_CAddress = txtBill_CAddress.Text;
        obj.Total_disc_amt = 0;
        obj.Max_Q_Authorize_Amt = 0;
        obj.Waiting_Approve_UserID = -1;
        //obj.Approve
        //obj.Approved_Date
        //obj.ApprovedBy
        //obj.Remark
        //obj.Request_approval_date
        //obj.Sent_date
        //obj.Confirmed_date
        //obj.Lost_date
        //obj.Cancelled_date
        //obj.On_hold_date
        //obj.Done_date
        //obj.Total_disc_amt
        obj.Payment_Days = txtPayment_Days.Text;
        obj.Payment_Term = ddlPayment_Term.Text;
        obj.Client_Status = txtClient_Status.Text;
        obj.DHL_Acct = txtDHL.Text;
        

        int QuotationID = Quotation_Controller.Add_Quotation(obj);

        if (QuotationIDChanged != null)
        {
            QuotationIDChanged(this, QuotationID);
        }
        return QuotationID;

    }

    private void Update(int QuotationID)
    {
        Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
        //obj.Quotation_No = DateTime.Now.ToString("yyyyMMddHHmmss");
        //obj.Vername = "001";
        //obj.Quotation_OpenDate
        //obj.revise_date
        obj.modify_user = Page.User.Identity.Name;
        employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
        obj.modify_user_ID = emp.id;
        obj.modify_date = DateTime.Now;
        //obj.Quotation_Status = Int32.Parse(DropDownListStatus.SelectedValue);
        //obj.Quotation_Statusdate = DateTime.Now;
        //obj.Quotation_Statusby
        //obj.Payment_Method_Id = Int32.Parse(ddlPaymentMethod.SelectedValue);
        //obj.pocheckno
        //obj.paymentlimit
        obj.SalesId = Int32.Parse(DropDownListEmp.SelectedValue);
        obj.Currency = RadioButtonListCurrency.Text;
        obj.Product_Name = txtProductName.Text;
        obj.CProduct_Name = txtCProductName.Text;
        obj.Model_No = txtModelNo.Text;
        obj.CModel_No = txtCModelNo.Text;
        obj.Brand_Name = txtBrandName.Text;
        obj.CBrand_Name = txtCBrandName.Text;
        obj.Model_Difference = txtModelDifference.Text;
        obj.CModel_Difference = txtCModelDifferencev.Text;
        obj.Client_Id = Int32.Parse(DropDownListClient.SelectedValue);
        //obj.Client_Contact = 
        obj.Applicant_Id = Int32.Parse(DropDownListApp.SelectedValue);
        //obj.Applicant_Contact
        obj.Bill_Name = txtBill_Name.Text;
        obj.Bill_Title = txtBill_Title.Text;
        obj.Bill_Companyname = txtBillCompanyname.Text;
        obj.Bill_CName = txtBill_CName.Text;
        obj.Bill_CTitle = txtBill_CTitle.Text;
        obj.Bill_CCompanyname = txtBill_CCompanyname.Text;
        obj.Bill_Phone = txtBill_Phone.Text;
        obj.Bill_Email = txtBill_Email.Text;
        obj.Bill_Country = txtBill_Country.Text;
        obj.Bill_Address = txtBill_Address.Text;
        obj.Bill_CAddress = txtBill_CAddress.Text;
        //obj.Approve
        //obj.Approved_Date
        //obj.ApprovedBy
        //obj.Remark
        //obj.Request_approval_date
        //obj.Sent_date
        //obj.Confirmed_date
        //obj.Lost_date
        //obj.Cancelled_date
        //obj.On_hold_date
        //obj.Done_date
        //obj.Total_disc_amt
        obj.Payment_Days = txtPayment_Days.Text;
        obj.Payment_Term = ddlPayment_Term.Text;
        obj.Client_Status = txtClient_Status.Text;
        obj.DHL_Acct = txtDHL.Text;

        Quotation_Controller.Update_Quotation(Quotation_Controller.ent, obj);
        if (QuotationIDChanged != null)
        {
            QuotationIDChanged(this, QuotationID);
        }
    }

    private void LoadData(int QuotationID)
    {
        Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
        //DropDownListStatus.SelectedValue = obj.Quotation_Status.ToString();
        //ddlPaymentMethod.SelectedValue = obj.Payment_Method_Id.ToString();
        DropDownListEmp.SelectedValue = obj.SalesId.ToString();
        RadioButtonListCurrency.Text = obj.Currency;

        txtProductName.Text = obj.Product_Name;
        txtCProductName.Text = obj.CProduct_Name;
        txtModelNo.Text = obj.Model_No;
        txtCModelNo.Text = obj.CModel_No;
        txtBrandName.Text = obj.Brand_Name;
        txtCBrandName.Text = obj.CBrand_Name;
        txtModelDifference.Text = obj.Model_Difference;
        txtCModelDifferencev.Text = obj.CModel_Difference;
        DropDownListClient.SelectedValue = obj.Client_Id.ToString();
        DropDownListApp.SelectedValue = obj.Applicant_Id.ToString();
        txtBill_Name.Text = obj.Bill_Name;
        txtBill_Title.Text = obj.Bill_Title;
        txtBillCompanyname.Text = obj.Bill_Companyname;
        txtBill_CName.Text = obj.Bill_CName;
        txtBill_CTitle.Text = obj.Bill_CTitle;
        txtBill_CCompanyname.Text = obj.Bill_CCompanyname;
        txtBill_Phone.Text = obj.Bill_Phone;
        txtBill_Email.Text = obj.Bill_Email;
        txtBill_Country.Text = obj.Bill_Country;
        txtBill_Address.Text = obj.Bill_Address;
        txtBill_CAddress.Text = obj.Bill_CAddress;
        txtPayment_Days.Text = obj.Payment_Days;
        ddlPayment_Term.Text = obj.Payment_Term;
        txtClient_Status.Text = obj.Client_Status;
        txtDHL.Text = obj.DHL_Acct;
    }
    protected void DropDownListClient_SelectedIndexChanged(object sender, EventArgs e)
    {

        int cID = Int32.Parse(DropDownListClient.SelectedValue);
        clientapplicant obj = CodeTableController.GetClientApplicant(cID);
        

        txtBill_Name.Text = obj.bill_firstname + " " + obj.bill_lastname;
        txtBill_Title.Text = obj.bill_title;
        txtBillCompanyname.Text = obj.bill_companyname;
        txtBill_CName.Text = obj.c_bill_firstname + obj.c_bill_lastname;
        txtBill_CTitle.Text = obj.bill_title;
        txtBill_CCompanyname.Text = obj.bill_companyname;
        txtBill_Phone.Text = obj.bill_workphone;
        txtBill_Email.Text = obj.bill_email;
        txtBill_Country.Text = CodeTableController.GetCountryName((int)obj.country_id);
        txtBill_Address.Text = obj.bill_address;
        txtBill_CAddress.Text = obj.bill_caddress;
        txtPayment_Days.Text = obj.paymentdays.ToString();
        //ddlPayment_Term.SelectedValue= obj.paymentterm;
        //txtClient_Status.Text = obj.clientstatus;
        txtDHL.Text = obj.dhl_acct;
    }
}