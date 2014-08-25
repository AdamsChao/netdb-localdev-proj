using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QuotationModel;
using System.Collections;

public class Quotation_Target_Controller
{
  public Quotation_Target_Controller()
  {

  }

  public static void Delete(int Quotation_Target_Id)
  {
    QuotationEntities entities = new QuotationEntities();
    Quotation_Target target =
        entities.Quotation_Target.First
        (c => c.Quotation_Target_Id == Quotation_Target_Id);
    int quotation_id = 0;
    if (target != null)
    {
      quotation_id = (int)target.quotation_id;
    }
    entities.Quotation_Target.DeleteObject(target);
    entities.SaveChanges();
    Quotation_Controller.TargetChange(quotation_id);
  }

  public static Quotation_Target Select(int Quotation_Target_Id)
  {
    QuotationEntities entities = new QuotationEntities();
    Quotation_Target target =
        entities.Quotation_Target.First
        (c => c.Quotation_Target_Id == Quotation_Target_Id);
    return target;

  }

  //Add Target
  public static void Add(Quotation_Target target)
  {
    QuotationEntities entities = new QuotationEntities();
    entities.Quotation_Target.AddObject(target);
    entities.SaveChanges();
    Quotation_Controller.TargetChange((int)target.quotation_id);

  }

  public static void Copy(int New_Quotation_ID, int Old_Quotation_ID)
  {
    QuotationEntities entities = new QuotationEntities();
    IEnumerable<Quotation_Target> TargetList =
        entities.Quotation_Target.Where
        (c => c.quotation_id == Old_Quotation_ID);

    foreach (Quotation_Target item in TargetList)
    {
      entities.Detach(item);
      item.EntityKey = null;
      item.quotation_id = New_Quotation_ID;
      //Project Target Estimate Date 以下欄位資料不能複製至新Target
      item.Status = "Open";
      item.test_started = null;
      item.test_completed = null;
      item.certification_completed = null;
      item.certification_submit_to_authority = null;
      item.Estimated_Lead_time = string.Empty;
      item.Actual_Lead_time = string.Empty;
      item.Agent = 0;
      item.Country_Manager = 0;
      item.PR_Flag = string.Empty;
      item.Bill1 = null;
      item.Bill2 = null;
      item.Bill3 = null;
      item.BillE = null;

      //adams:2014/8/25
      item.document_ready_to_process = null;
      item.certificate_type = null;
      item.certificate_issue_date = null;
      item.certificate_expiry_date = null;
      item.email_renewal_notice_date = null;
      item.renewal_confirmation_check = "0";
      item.conduct_renewal_action_date = null;
      item.sample_received_from_client_date = null;
      item.customer_request_sample_returned = "0";
      item.sample_returned_to_client_date = null;
      item.sample_shipping_tracking_no = null;
      item.customer_request_original_certificate_returned = "0";
      item.original_certificate_mailed_to_client_date = null;
      item.Certificate_shipping_tracking_no = null;
      item.sample_can_be_returned_from_authority = "0";
      item.sample_is_kept_by_local_agent = false;
      item.request_local_agent_to_destroy_tested_samples = false;
      item.returned_of_tested_sample_date = null;
      item.CMB1 = false;
      item.CMB2 = false;
      item.CMB3 = false;
      item.CMB4 = false;
      item.CMB5 = false;
      item.CMB6 = false;
      item.CMB7 = false;
      item.CMB8 = false;
      item.original_certificate_received_date = null;
      item.Lifetime = false;

      Add(item);
    }
  }

  //Modify Test Target
  public static void Modify(Quotation_Target target)
  {

    QuotationEntities entities = new QuotationEntities();
    //entities.AcceptAllChanges();

    var result = (from n in entities.Quotation_Target
                  where n.Quotation_Target_Id == target.Quotation_Target_Id
                  select n).FirstOrDefault();

    result.target_id = target.target_id;
    result.target_description = target.target_description;
    result.country_id = target.country_id;
    result.product_type_id = target.product_type_id;
    result.authority_id = target.authority_id;
    result.technology_id = target.technology_id;
    result.target_rate = target.target_rate;
    result.unit = target.unit;
    result.unit_price = target.unit_price;
    result.discount_type = target.discount_type;
    result.discValue1 = target.discValue1;
    result.discValue2 = target.discValue2;
    result.discPrice = target.discPrice;
    result.FinalPrice = target.FinalPrice;
    result.PayTo = target.PayTo;
    result.Status = target.Status;
    result.Bill = target.Bill;
    result.option1 = target.option1;
    result.option2 = target.option2;
    result.advance1 = target.advance1;
    result.advance2 = target.advance2;
    result.balance1 = target.balance1;
    result.balance2 = target.balance2;
    result.PR_Flag = target.PR_Flag;
    result.Bill1 = target.Bill1;
    result.Bill2 = target.Bill2;
    result.Bill3 = target.Bill3;
    result.BillE = target.BillE;
    entities.SaveChanges();

    Quotation_Controller.TargetChange((int)result.quotation_id);

  }

  public static IEnumerable<vw_Test_Target_List> SelectView(string Quotation_No)
  {
    QuotationEntities entities = new QuotationEntities();
    IEnumerable<vw_Test_Target_List> TargetList =
        entities.vw_Test_Target_List.Where
        (c => c.Quotation_No == Quotation_No);
    return TargetList;
  }

  //List All Versions
  public static Dictionary<int, string> GetAllVersions(string Quotation_No)
  {
    //modify by Adams 2012/5/6 只有confirmed的報價單才會秀版本
    QuotationEntities entities = new QuotationEntities();
    var result = (from n in entities.Quotation_Version
                  where n.Quotation_No == Quotation_No
                  select new
                  {
                    n.Quotation_Version_Id,
                    n.Vername
                  }).Distinct();

    return result.ToDictionary(n => n.Quotation_Version_Id, n => "V" + n.Vername.ToString());
  }
}