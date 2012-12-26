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