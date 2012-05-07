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
            employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
            txtCurrentEmployee_id.Text = emp.id.ToString();
            int QuotationID = ((Imaster)this.Page).getQuotationID();
            if (QuotationID != 0)
            {

                LoadData(QuotationID);
            }
            else
            {                
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

        int ContactID;
        if (Int32.TryParse(DropDownListContact.SelectedValue, out ContactID))
            obj.Client_Contact = ContactID;
        else
            obj.Client_Contact = null;
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
        //obj.Payment_Days = txtPayment_Days.Text;
        obj.Payment_Days = ddlPaymentDays.Text;
        obj.Payment_Term = ddlPayment_Term.Text;
        obj.Client_Status = txtClient_Status.Text;
        obj.DHL_Acct = txtDHL.Text;
        int AccessLevelID;
        if (Int32.TryParse(ddlAccessLevel.SelectedValue, out AccessLevelID))
            obj.Access_Level_ID = AccessLevelID;
        else
            obj.Access_Level_ID = null;


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
        int ContactID;
        if (Int32.TryParse(DropDownListContact.SelectedValue, out ContactID))
            obj.Client_Contact = ContactID;
        else
            obj.Client_Contact = null;
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
        //obj.Payment_Days = txtPayment_Days.Text;
        obj.Payment_Days = ddlPaymentDays.Text;
        obj.Payment_Term = ddlPayment_Term.Text;
        obj.Client_Status = txtClient_Status.Text;
        obj.DHL_Acct = txtDHL.Text;
        int AccessLevelID;
        if (Int32.TryParse(ddlAccessLevel.SelectedValue, out AccessLevelID))
            obj.Access_Level_ID = AccessLevelID;
        else
            obj.Access_Level_ID = null;

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
        //DropDownListClient.DataBind();
        //DropDownListClient.SelectedValue = obj.Client_Id.ToString();
        //DropDownListContact.SelectedValue = obj.con
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
        ddlPaymentDays.Text = obj.Payment_Days;
        ddlPayment_Term.Text = obj.Payment_Term;
        txtClient_Status.Text = obj.Client_Status;
        txtDHL.Text = obj.DHL_Acct;

        employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);

        //if (obj.SalesId == emp.id)
        //    btnSubmit.Enabled = true;
        //else
        //    btnSubmit.Enabled = false;
    }
    protected void DropDownListClient_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownListContact.Items.Clear();
        //DropDownListContact.Items.Add("--select--");
      
           SelectBillInfomation();
    }

    protected void rblSame_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectBillInfomation();

    }
    protected void DropDownListClient2_SelectedIndexChanged(object sender, EventArgs e)
    {
        //int cID = Int32.Parse(DropDownListClient2.SelectedValue);
        //clientapplicant obj = CodeTableController.GetClientApplicant(cID);

        //Bill_Data(obj);
        //SelectBillInfomation();
        SelectBillInfomation();
    }

    protected void Bill_Data(clientapplicant obj)
    {

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
        //txtPayment_Days.Text = obj.paymentdays.ToString();
        ddlPaymentDays.SelectedValue = obj.paymentdays.ToString();
        ddlPayment_Term.SelectedValue = obj.paymentterm.ToString();
        //txtClient_Status.Text = obj.clientstatus;
        txtDHL.Text = obj.dhl_acct;
    }
    protected void Bill_Data(clientapplicant clinet,contact_info obj)
    {

        txtBill_Name.Text = obj.fname + " " + obj.lname;
        txtBill_Title.Text = obj.title;
        txtBillCompanyname.Text = obj.companyname;
        txtBill_CName.Text = obj.c_fname + obj.c_lname;
        txtBill_CTitle.Text = obj.c_title;
        txtBill_CCompanyname.Text = obj.c_companyname;
        txtBill_Phone.Text = obj.workphone + " ext " + obj.ext;
        txtBill_Email.Text = obj.email;
        txtBill_Country.Text = CodeTableController.GetCountryName((int)obj.country_id);
        txtBill_Address.Text = obj.address;
        txtBill_CAddress.Text = obj.c_address;
        ddlPaymentDays.SelectedValue = clinet.paymentdays.ToString();
        ddlPayment_Term.SelectedValue = clinet.paymentterm.ToString();
        txtDHL.Text = clinet.dhl_acct;
    }
    protected void Bill_Data()
    {

        txtBill_Name.Text = "";
        txtBill_Title.Text = "";
        txtBillCompanyname.Text = "";
        txtBill_CName.Text = "";
        txtBill_CTitle.Text = "";
        txtBill_CCompanyname.Text = "";
        txtBill_Phone.Text = "";
        txtBill_Email.Text = "";
        txtBill_Country.Text = "";
        txtBill_Address.Text = "";
        txtBill_CAddress.Text = "";
        //txtPayment_Days.Text = obj.paymentdays.ToString();
        ddlPaymentDays.SelectedValue = "-1";
        ddlPayment_Term.SelectedValue = "-1";
        //txtClient_Status.Text = obj.clientstatus;
        txtDHL.Text = "";
    }
    protected void DropDownListClient_DataBound(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            int QuotationID = ((Imaster)this.Page).getQuotationID();
            if ((QuotationID == 0) && (rblSame.SelectedIndex == 1))
            {               
                SelectBillInfomation();
            }
            //else
            //{
            //    Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
            //    DropDownListClient.SelectedValue = obj.Client_Id.ToString();
            //}
             if (QuotationID != 0)
             {
                     Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
                     DropDownListClient.SelectedValue = obj.Client_Id.ToString(); 
             }
            
        }
    }
    protected void DropDownListContact_SelectedIndexChanged(object sender, EventArgs e)
    {
        SelectBillInfomation();
    }

    protected void SelectBillInfomation()
    {
     
    
        int ClientID;
        int ContactID;
        clientapplicant client;
        contact_info contact;

        switch (rblSame.SelectedIndex)
        {
            case 0: //Empty
                Bill_Data();
                break;

            case 1: //Same as Client
                DropDownListClient2.Enabled = false;
                DropDownListContact2.Enabled = false; 

                ClientID = Int32.Parse(DropDownListClient.SelectedValue);
                Int32.TryParse(DropDownListContact.SelectedValue, out ContactID);

                client = CodeTableController.GetClientApplicant(ClientID);

                if (DropDownListContact.SelectedIndex == 0)
                {
                    Bill_Data(client);
                }
                else
                {
                    contact = CodeTableController.Getcontact_info(ContactID);
                    Bill_Data(client, contact);
                }
                break;

            case 2: //Not Same as Client
                DropDownListClient2.Enabled = true;
                DropDownListContact2.Enabled = true;

                ClientID = Int32.Parse(DropDownListClient2.SelectedValue);
                //ContactID = Int32.Parse(DropDownListContact2.SelectedValue);
                client = CodeTableController.GetClientApplicant(ClientID);

                Bill_Data(client);
                break;

            default:
                Bill_Data();
                break;
        }
    }
    protected void DropDownListContact_DataBound(object sender, EventArgs e)
    {
        DropDownListContact.Items.Insert(0, "--select--");
        if (!IsPostBack)
        {
            int QuotationID = ((Imaster)this.Page).getQuotationID();
            if ((QuotationID != 0) & (DropDownListContact.Items.Count >1))
            {               
                Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
                if(obj.Client_Contact != null)
                    DropDownListContact.SelectedValue  =  obj.Client_Contact.ToString();
            }
        }
    }
    protected void DropDownListContact2_DataBound(object sender, EventArgs e)
    {
        DropDownListContact2.Items.Insert(0, "--select--");
    }
    protected void ddlAccessLevel_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int QuotationID = ((Imaster)this.Page).getQuotationID();
            if ((QuotationID != 0) & (ddlAccessLevel.Items.Count > 1))
            {
                Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
                if (obj.Access_Level_ID != null)
                    ddlAccessLevel.SelectedValue = obj.Access_Level_ID.ToString();
            }
        }
    }
    protected void DropDownListApp_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int QuotationID = ((Imaster)this.Page).getQuotationID();
                
            if (QuotationID != 0)
            {
                Quotation_Version obj = Quotation_Controller.Get_Quotation(QuotationID);
                DropDownListApp.SelectedValue = obj.Applicant_Id.ToString();
            }

        }
    }
}