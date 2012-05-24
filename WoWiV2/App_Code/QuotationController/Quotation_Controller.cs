using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QuotationModel;
using System.Web.UI.WebControls;


public class Quotation_Controller
{
    public Quotation_Controller()
    {
    }


    //List All Target
    public static IEnumerable<Quotation_Target> Get_All_Target()
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Quotation_Target
                     select n;
        return result.ToList();
    }


    //List Quotation
    public static IEnumerable<Quotation_Version> Get_Quotation_List(int Quotation_Version_Id)
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Quotation_Version
                     where n.Quotation_Version_Id == Quotation_Version_Id
                     select n;
        return result.ToList();
    }

    public static int Add_Quotation(Quotation_Version obj)
    {
        QuotationEntities entities = new QuotationEntities();
        entities.Quotation_Version.AddObject(obj);
        entities.SaveChanges();

        return obj.Quotation_Version_Id;

    }

    public static void Update_Quotation(QuotationEntities entity, Quotation_Version quotation)
    {
        entity.SaveChanges();
    }

    public static QuotationEntities ent;
    public static Quotation_Version Get_Quotation(int Quotation_ID)
    {
        ent = new QuotationEntities();
        var result = from n in ent.Quotation_Version
                     where n.Quotation_Version_Id == Quotation_ID
                     select n;

        return result.SingleOrDefault();
    }

    public static int Copy_Quotation(int Quotation_ID, bool isNewQuotationID, string Quotation_No)
    {
        Quotation_Version obj = Get_Quotation(Quotation_ID);
        ent.Detach(obj);
        obj.EntityKey = null;
        if (isNewQuotationID)
        {
            obj.Quotation_No = DateTime.Now.ToString("yyyyMMdd-HHmmss");
            obj.Vername = 1;
        }
        else
        {
            obj.Vername = GetLastVersionNumber(Quotation_No) + 1;
        }
        obj.Quotation_Status = 1;
        obj.Quotation_Statusdate = DateTime.Now;
        obj.Quotation_OpenDate = DateTime.Now;
        obj.revise_date = null;
        obj.create_date = DateTime.Now;
        obj.modify_date = null;
        obj.Approve = null;
        obj.Approved_Date = null;
        obj.ApprovedBy = null;
        obj.Sent_date = null;
        obj.Confirmed_date = null;
        obj.Lost_date = null;
        obj.Cancelled_date = null;
        obj.On_hold_date = null;
        obj.Done_date = null;
        obj.Total_disc_amt = 0;
        obj.Max_Q_Authorize_Amt = 0;
        int NewQuotationID = Add_Quotation(obj);
        if (isNewQuotationID)
        {
            Quotation_Target_Controller.Copy(NewQuotationID, Quotation_ID);         
            obj.FinalTotalPrice =   obj.TargetTotalPrice -obj.Discount ;
        }
        else
        {
            obj.TargetTotalPrice = 0;
            obj.Discount = 0;
            obj.FinalTotalPrice = 0;
        }
        return NewQuotationID;
    }

    public static int GetLastVersionNumber(string Quotation_No)
    {
        QuotationEntities entities = new QuotationEntities();
        return (int)entities.Quotation_Version.
                  Where(p => p.Quotation_No == Quotation_No).
                  Max(p => p.Vername);

    }

    public static void TargetChange(int Quotation_ID)
    {
        Quotation_Version q = Get_Quotation(Quotation_ID);
        q.TargetTotalPrice = GetTotalUnitPrice(Quotation_ID);
        q.Discount = GetTotalTargetDiscount(Quotation_ID);
        q.FinalTotalPrice = q.TargetTotalPrice - q.Discount - q.Total_disc_amt;
        ent.SaveChanges();
    }


    public static Decimal GetTotalPrice(int Quotation_ID)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from a in entities.Quotation_Target
                     where a.quotation_id == Quotation_ID
                     select a.FinalPrice;
        if (result.ToList().Count > 0)
        {
            Quotation_Version q = Get_Quotation(Quotation_ID);
            if (q != null && q.Total_disc_amt != null)
                return (Decimal)(result.Sum() - (decimal)q.Total_disc_amt);
            else
                return (Decimal)result.Sum();
        }
        else
            return 0;
    }

    public static Decimal GetTotalTargetDiscount(int Quotation_ID)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from n in ent.Quotation_Target
                     where n.quotation_id == Quotation_ID
                     select n.discPrice;
        if (result.ToList().Count > 0)
            return (Decimal)result.Sum();
        else
            return 0;
    }



    public static Decimal GetTotalUnitPrice(int Quotation_ID)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Quotation_Target
                     where n.quotation_id == Quotation_ID
                     select n;

        decimal sum = 0;
        foreach (Quotation_Target item in result.ToList())
        {
            sum += (decimal)item.unit * (decimal)item.unit_price;
        }
        return sum;
    }

    public static string GetTotalVersionDiscount(string Quotation_No)
    {
        Decimal TargetDiscount;
        Decimal Total_disc_amt;
        QuotationEntities entities = new QuotationEntities();
        var result = from target in entities.Quotation_Target
                     join quo in entities.Quotation_Version on target.quotation_id equals quo.Quotation_Version_Id
                     where quo.Quotation_No == Quotation_No
                     select target.discPrice;
        if (result.ToList().Count > 0)
            TargetDiscount = (decimal)result.Sum();
        else
            TargetDiscount = 0;


        var result2 = from n in ent.Quotation_Version
                      where n.Quotation_No == Quotation_No
                      select n.Total_disc_amt;
        if (result2.ToList().Count > 0)
            Total_disc_amt = (decimal)result2.Sum();
        else
            Total_disc_amt = 0;

        return (TargetDiscount + Total_disc_amt).ToString();
    }

    public static string GetTotalVersionTotal_disc_amt(string Quotation_No)
    {
        //Decimal TargetDiscount;
        Decimal Total_disc_amt;
        QuotationEntities entities = new QuotationEntities();
  
        var result2 = from n in ent.Quotation_Version
                      where n.Quotation_No == Quotation_No
                      select n.Total_disc_amt;
        if (result2.ToList().Count > 0)
            Total_disc_amt = (decimal)result2.Sum();
        else
            Total_disc_amt = 0;

        return Total_disc_amt.ToString("N2");
    }

    public static string GetTotalVersionUnitPrice(string Quotation_No)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from target in entities.Quotation_Target
                     join quo in entities.Quotation_Version on target.quotation_id equals quo.Quotation_Version_Id
                     where quo.Quotation_No == Quotation_No
                     select target;

        decimal sum = 0;
        foreach (Quotation_Target item in result.ToList())
        {
            sum += (decimal)item.unit * (decimal)item.unit_price;
        }
        return sum.ToString();
    }

    //Add by Adams 2012/5/9
    public static string GetConfirmedVersionDiscount(string Quotation_No)
    {
        Decimal TargetDiscount;
        Decimal Total_disc_amt;
        QuotationEntities entities = new QuotationEntities();
        var result = from target in entities.Quotation_Target
                     join quo in entities.Quotation_Version on target.quotation_id equals quo.Quotation_Version_Id
                     where quo.Quotation_No == Quotation_No && quo.Quotation_Status==5
                     select target.discPrice;
        if (result.ToList().Count > 0)
            TargetDiscount = (decimal)result.Sum();
        else
            TargetDiscount = 0;


        var result2 = from n in ent.Quotation_Version
                      where n.Quotation_No == Quotation_No && n.Quotation_Status==5
                      select n.Total_disc_amt;
        if (result2.ToList().Count > 0)
            Total_disc_amt = (decimal)result2.Sum();
        else
            Total_disc_amt = 0;

        return (TargetDiscount + Total_disc_amt).ToString("F2");
    }
    public static string GetConfirmedVersionUnitPrice(string Quotation_No)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from target in entities.Quotation_Target
                     join quo in entities.Quotation_Version on target.quotation_id equals quo.Quotation_Version_Id
                     where quo.Quotation_No == Quotation_No && quo.Quotation_Status==5
                     select target;

        decimal sum = 0;
        foreach (Quotation_Target item in result.ToList())
        {
            sum += (decimal)item.unit * (decimal)item.unit_price;
        }
        return sum.ToString();
    }

    public static int Status_AwaitingApproval(decimal FinalTotalPrice, string Currency, Quotation_Version quotation, int SupervisorID, out string msgError)
    {
        msgError = "";
        employee emp;
        QuotationEntities entities = new QuotationEntities();
        //todo
        string mailSubject = "Quotation #" + quotation.Quotation_No + " / " + GetClientName((int)quotation.Client_Id) + " / " +  quotation.Model_No + ".  is request for approval";
        string mailContent = mailSubject + " by " + quotation.modify_user + "<br /> http://wowiv2.wowiapproval.com/WoWiV2/Sales/CreateQuotation.aspx?q=2" + quotation.Quotation_Version_Id ;

        var result = from n in entities.employee
                     where n.q_authorize_currency == Currency && n.id == SupervisorID                     
                     select n;
        if (result.Count() > 0)
        {
            emp = result.First();
            if (!String.IsNullOrEmpty(emp.email))
            {
                try
                {
                    Mail(emp.email, mailSubject, mailContent);
                }
                catch (Exception ex)
                {
                    msgError = "Mail郵件通知失敗，請洽系統管理員! 錯誤訊息: " + ex.Message;
                }
                
            }
            return 2;
        }
        else
        {
            return 3;
        }
       
        
    }

    public static bool Status_Approved(decimal FinalTotalPrice, string Currency, Quotation_Version quotation, int EmpID, out string msgError )
    {
        msgError = "";
       QuotationEntities entities = new QuotationEntities();


       var emp = (from n in entities.employee
                                  where n.id == EmpID
                                  select n).First();

       quotation.Max_Q_Authorize_Amt = emp.q_authorize_amt;
       Quotation_Controller.Update_Quotation(ent, quotation);
       if (quotation.Max_Q_Authorize_Amt >= FinalTotalPrice)
           return true;
       else
       {
           var result = from n in entities.employee
                        where n.q_authorize_currency == Currency && n.id == emp.supervisor_id
                        select n;
           if (result.Count() > 0)
           {
               employee supervisor = result.First();
               if (!String.IsNullOrEmpty(supervisor.email))
               {
                   string mailSubject = "Quotation #" + quotation.Quotation_No + " / " + GetClientName((int)quotation.Client_Id) + " / Model No.  is request for approval ";
                   string mailContent = mailSubject + " by " + quotation.modify_user + "<br /> http://wowiv2.wowiapproval.com/WoWiV2/Sales/CreateQuotation.aspx?q=2" + quotation.Quotation_Version_Id;
                   try
                   {
                       Mail(supervisor.email, mailSubject, mailContent);
                   }
                   catch (Exception ex)
                   {

                       msgError = "Mail郵件通知失敗，請洽系統管理員! /n 錯誤訊息:" + ex.Message;
                   }
                   
               }
               quotation.Waiting_Approve_UserID = supervisor.id;
               return false;
           }
           else
           {
               return true;
           }
       }
    }

    public static void Mail(string mailto, string mailSubject, string mailContent)
    {
        string mailfrom = "dbService@wowiapproval.com";        
        Panel panel = new Panel();
        Literal ltlMail = new Literal();
        ltlMail.Text = mailContent;
        panel.Controls.Add(ltlMail);
        MailUtil.SendHTMLMail(mailfrom, mailto, mailSubject, panel);
    }

    public static string GetClientName(int ClientID)
    {
       QuotationEntities entity = new QuotationEntities();
       var result = from n in entity.clientapplicant
                    where n.id == ClientID
                     select n;

        return result.SingleOrDefault().companyname;
    }

    public static vw_Quotation_Print GetQuotationPrint(int Quotation_ID)
    {
        QuotationEntities entity = new QuotationEntities();
        entity = new QuotationEntities();
        var result = from n in entity.vw_Quotation_Print
                     where n.Quotation_Version_Id == Quotation_ID
                     select n;
        return result.SingleOrDefault();
    
    }

    public static vw_Quotation_Print_Chinese GetQuotationPrintChinese(int Quotation_ID)
    {
        QuotationEntities entity = new QuotationEntities();
        entity = new QuotationEntities();
        var result = from n in entity.vw_Quotation_Print_Chinese
                     where n.Quotation_Version_Id == Quotation_ID
                     select n;
        return result.SingleOrDefault();

    }


    public static string GetInvoiceNo(int Quotation_ID, int Quotation_Target_Id, int bill_status)
    {
        QuotationEntities entity = new QuotationEntities();
        entity = new QuotationEntities();
        var result = from n in entity.invoice_target
                     where n.quotation_id == Quotation_ID   &&
                        n.quotation_target_id == Quotation_Target_Id  &&
                        n.bill_status == bill_status 
                     select n;
        if ((result.ToList()).Count > 0)
        {
            String invoice_id = result.First().invoice_id.ToString();
            String invoice_no = result.First().invoice_no;
            String hLink = string.Format("<a href='../Accounting/InvoiceDetails.aspx?id={0}' target='_blank'>{1}</a>", invoice_id, invoice_no);
            return hLink;
            //return result.First().invoice_no;
        }
        else
            return "";

    }

    public static string GetInvoiceDate(int Quotation_ID, int Quotation_Target_Id, int bill_status)
    {
        QuotationEntities entity = new QuotationEntities();
        entity = new QuotationEntities();
        var result = from n in entity.invoice_target
                     where n.quotation_id == Quotation_ID &&
                        n.quotation_target_id == Quotation_Target_Id &&
                        n.bill_status == bill_status
                     select n;
        if ((result.ToList()).Count > 0)
        {
        
            return result.First().modify_date.ToString("yyyy/MM/dd");
        }
        else
            return "";

    }
}