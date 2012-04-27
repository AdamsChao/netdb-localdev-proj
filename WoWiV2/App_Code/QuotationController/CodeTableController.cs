using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QuotationModel;


public class CodeTableController
{
    public CodeTableController()
    {

    }

    //List All Countries
    public static Dictionary<int, string> GetAllCountry()
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.country
                     select n;
        return result.ToDictionary(n => n.country_id, n => n.country_name);
    }

    public static string GetCountryName(int Country_ID)
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.country
                     where n.country_id == Country_ID
                     select n;
        if (result.Count() > 0)
            return result.First().country_name;
        else
            return "";
    }

    public static Dictionary<int, string> GetAll_Product_Type(int country_id)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.vw_Product_Type
                     where n.country_id == country_id
                     select n;
        return result.ToDictionary(n => n.wowi_product_type_id, n => n.wowi_product_type_name);

    }

    public static Dictionary<int, string> GetAll_Authority(int country_id, int wowi_product_type_id)
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Authority
                     where n.country_id == country_id && n.wowi_product_type_id == wowi_product_type_id
                     select n;
        //return result.ToDictionary(n => n.country_id + "," + n.wowi_product_type_id, n => n.authority_name);
        return result.ToDictionary(n => n.authority_id, n => n.authority_name);
    }

    public static Dictionary<int, string> GetAll_wowi_tech(int wowi_product_type_id)
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.wowi_tech
                     where n.wowi_product_type_id == wowi_product_type_id
                     select n;
        return result.ToDictionary(n => n.wowi_tech_id, n => n.wowi_tech_name);
    }


    public static Dictionary<int, string> GetAll_Quotation_Status()
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Quotation_Status
                     select n;
        return result.ToDictionary(n => (Int32)n.Quotation_Status_Id, n => n.Quotation_Status_Name);
    }

    public static decimal GetAll_Target_Rates(int country_id, int product_type_id, string authority_name, int wowi_tech_id)
    {

        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Target_Rates
                     where n.country_id == country_id && n.product_type_id == product_type_id && n.authority_name == authority_name && n.Technology_id == wowi_tech_id
                     select n;
        if (result.Count() > 0)
            return (decimal)result.First().rate;
        else
            return 0;
    }

    public static Dictionary<int, string> GetAll_Target(int country_id, int product_type_id, int authority_id, int wowi_tech_id)
    {
        //Modify by Adams 2012/4/28 for New Requirment use Target Rate
        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.Target_Rates
                     where n.country_id == country_id && n.product_type_id == product_type_id && n.authority_id == authority_id && n.Technology_id == wowi_tech_id
                     select n;
        return result.ToDictionary(n => n.Target_rate_id, n => n.authority_name);
    }

    public static clientapplicant GetClientApplicant(int ClientID)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.clientapplicant
                     //join c in entities.country on n.country_id equals c.country_id
                     where n.id == ClientID
                     select n;
                     //select new { n, c.country_name };
        return result.First();

    }

    public static employee GetEmployee(string username)
    {
        QuotationEntities entities = new QuotationEntities();
        var result = from n in entities.employee
                     where n.username == username
                     orderby n.q_authorize_amt
                     select n;
        return result.First();
    }

    //Mark by Adams 2012/4/23 for Project Requirment Change Requirment
    //public static Project GetProject(int QuotationID)
    //{
    //    QuotationEntities entities = new QuotationEntities();
    //    var result = from n in entities.Project
    //                 where n.Quotation_Id == QuotationID
    //                 select n;
    //    return result.FirstOrDefault();
    //}

    //Add by Adams 2012/4/23 for Project Requirment Change Requirment
    public static Project GetProject(string QuotationNO)
    {
      QuotationEntities entities = new QuotationEntities();
      var result = from n in entities.Project
                   where n.Quotation_No == QuotationNO
                   select n;
      return result.FirstOrDefault();
    }

    //Add Project
    public static void AddProject(Quotation_Version quot)
    {
        Project project = new Project();
        project.Project_No = DateTime.Now.ToString("yyyyMMdd-HHmmss");
        project.Quotation_Id = quot.Quotation_Version_Id;

        //Add by Adams 2012/4/23 for Project Requirment Change Requirment
        project.Quotation_No = quot.Quotation_No; 

        project.Create_Date = DateTime.Now;
        project.Project_Status = "Open";

        QuotationEntities entities = new QuotationEntities();
        entities.Project.AddObject(project);
        entities.SaveChanges();        
    }
}