using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;

public partial class Sales_uc_ucCreateQuotationTab2 : System.Web.UI.UserControl
{
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      LoadDropDown();

      int quotation_id = ((Imaster)this.Page).getQuotationID();

      hidQuotationID.Text = quotation_id.ToString();
      gvData.DataBind();

      if (quotation_id != 0)
      {
        //Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
        //employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);

        //if (obj.SalesId == emp.id)
        //    btnSubmit.Enabled = true;
        //else
        //    btnSubmit.Enabled = false;

        Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
        if (obj.Quotation_Status >= 3)
        {
          btnSubmit.Enabled = false;

          ddlTechnology.Enabled = false;
          ddlCountry.Enabled = false;
          ddlProductType.Enabled = false;
          ddlAuthority.Enabled = false;
          txtDespction.Enabled = false;
          txtUnit.Enabled = false;
          txtUnitPrice.Enabled = false;
          rblDisCount.Enabled = false;
          txtRate.Enabled = false;
          ddlTestdisc.Enabled = false;
          txtDiscAmt.Enabled = false;
          txtDiscPrice.Enabled = false;
          txtFprice.Enabled = false;
          txtPayTo.Enabled = false;

        }
        else
        {
          btnSubmit.Enabled = true;
        }


      }
    }



  }

  private void LoadDropDown()
  {
    ddlTechnology_Bind();
    ddlCountry_Bind();
    ddlProductType_Bind();
    ddlAuthority_Bind();
    Get_Target_Rate();

    for (int i = 0; i <= 50; i++)
    {
      ddlTestdisc.Items.Add(new ListItem(i.ToString() + "%", i.ToString()));
    }
  }

  protected void ddlTechnology_SelectedIndexChanged(object sender, EventArgs e)
  {
    ddlCountry_Bind();
    ddlProductType_Bind();
    ddlAuthority_Bind();
    Get_Target_Rate();
  }

  protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
  {
    ddlProductType_Bind();
    ddlAuthority_Bind();
    Get_Target_Rate();
  }
  protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
  {
    ddlAuthority_Bind();
    Get_Target_Rate();
  }
  protected void ddlAuthority_SelectedIndexChanged(object sender, EventArgs e)
  {
    Get_Target_Rate();
  }


  //Technology
  private void ddlTechnology_Bind()
  {
    var Techs = CodeTableController.GetAll_wowi_tech().OrderBy(n => n.Value);
    ddlTechnology.DataSource = Techs;
    ddlTechnology.DataTextField = "Value";
    ddlTechnology.DataValueField = "Key";
    ddlTechnology.DataBind();

  }

  //Country
  private void ddlCountry_Bind()
  {
    int TechnologyID = Int32.Parse(ddlTechnology.SelectedValue);
    ddlCountry.DataSource = CodeTableController.GetAllCountry(TechnologyID);
    ddlCountry.DataTextField = "Value";
    ddlCountry.DataValueField = "Key";
    ddlCountry.DataBind();
  }

  //Product Type
  private void ddlProductType_Bind()
  {
    int TechnologyID = Int32.Parse(ddlTechnology.SelectedValue);
    int CountryID = Int32.Parse(ddlCountry.SelectedValue);
    ddlProductType.DataSource = CodeTableController.GetAll_Product_Type(TechnologyID, CountryID);
    ddlProductType.DataTextField = "Value";
    ddlProductType.DataValueField = "Key";
    ddlProductType.DataBind();
  }

  //Authority
  private void ddlAuthority_Bind()
  {
    int TechnologyID = Int32.Parse(ddlTechnology.SelectedValue);
    int CountryID = Int32.Parse(ddlCountry.SelectedValue);
    int ProductTypeID = Int32.Parse(ddlProductType.SelectedValue);

    ddlAuthority.DataSource = CodeTableController.GetAll_Authority(TechnologyID, CountryID, ProductTypeID);
    ddlAuthority.DataTextField = "Value";
    ddlAuthority.DataValueField = "Key";
    ddlAuthority.DataBind();
  }


  //Target Rate
  private void Get_Target_Rate()
  {

    int TechnologyID = Int32.Parse(ddlTechnology.SelectedValue);
    int CountryID = Int32.Parse(ddlCountry.SelectedValue);
    int ProductTypeID = Int32.Parse(ddlProductType.SelectedValue);
    int AuthorityID = Int32.Parse(ddlAuthority.SelectedValue);

    Dictionary<int, decimal> result = new Dictionary<int, decimal>();
    result = CodeTableController.GetAll_Target_Rates(TechnologyID, CountryID, ProductTypeID, AuthorityID);
    if (result.Count > 0)
    {
      txtRate.Text = result.First().Value.ToString();
      txtUnitPrice.Text = txtRate.Text;
      hidTarget_Rates_ID.Value = result.First().Key.ToString();
      //txtDespction.Text = ddlAuthority.SelectedItem.Text;
      //Modify by Adams Target Description 來自 Authority
      txtDespction.Text = CodeTableController.GetTargetDescription(AuthorityID);

      int quotation_id = ((Imaster)this.Page).getQuotationID();
      if (quotation_id != 0)
      {
        Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
        if (obj.Quotation_Status >= 3)
        {
          btnSubmit.Enabled = false;
        }
        else
        {
          btnSubmit.Enabled = true;
        }
      }
    }
    else
    {
      txtRate.Text = "0";
      txtUnit.Text = "0";
      txtUnitPrice.Text = "0";
      hidTarget_Rates_ID.Value = "0";
      txtDespction.Text = "";
      btnSubmit.Enabled = false;
      Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Show", "alert('請確認您所選取的Target Rate為有效的或已經Publish的項目!')", true);
      LabelMessage.Text = "請確認您所選取的Target Rate為有效的或已經Publish的項目!";
    }
  }

  //save
  protected void btnSubmit_Click(object sender, EventArgs e)
  {
    if (hidTargetID.Text == "0")
      Save();
    else
      Update();
  }

  private void Save()
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

    if (isUpdate)
    {
      Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
      obj.revise_date = DateTime.Now;
      obj.modify_user = Page.User.Identity.Name;
      employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
      obj.modify_user_ID = emp.id;
      obj.modify_date = DateTime.Now;
      Quotation_Controller.Update_Quotation(Quotation_Controller.ent, obj);
    }


    Quotation_Target target = new Quotation_Target();
    target.quotation_id = quotation_id;
    target.target_id = int.Parse(hidTarget_Rates_ID.Value);
    target.target_description = txtDespction.Text.Trim();
    //target.target_code = target.target_code;
    target.country_id = Int32.Parse(ddlCountry.SelectedValue);
    target.product_type_id = Int32.Parse(ddlProductType.SelectedValue);
    target.authority_id = Int32.Parse(ddlAuthority.SelectedValue);
    target.technology_id = Int32.Parse(ddlTechnology.SelectedValue);
    target.target_rate = Decimal.Parse(txtRate.Text);
    target.unit = Double.Parse(txtUnit.Text);
    target.unit_price = Decimal.Parse(txtUnitPrice.Text);
    target.discount_type = rblDisCount.SelectedIndex.ToString();
    target.discValue1 = Int32.Parse(ddlTestdisc.SelectedValue);
    target.discValue2 = Decimal.Parse(txtDiscAmt.Text);
    target.discPrice = Decimal.Parse(hidDiscPrice.Value);
    target.FinalPrice = Decimal.Parse(hidFprice.Value);
    target.PayTo = txtPayTo.Text;
    target.Agent = 0;
    target.Country_Manager = 0; //Add By Adams 2012/4/23
    target.Status = "Open"; // Add by Adams 2012/4/30

    //Add by Adams 2014/1/5
    target.renewal_confirmation_check = "0";
    target.customer_request_sample_returned = "0";
    target.customer_request_original_certificate_returned = "0";
    target.sample_can_be_returned_from_authority = "0";
    target.sample_is_kept_by_local_agent = false;
    target.request_local_agent_to_destroy_tested_samples = false;
    target.CMB1 = false;
    target.CMB2 = false;
    target.CMB3 = false;
    target.CMB4 = false;
    target.CMB5 = false;
    target.CMB6 = false;
    target.CMB7 = false;
    target.CMB8 = false;
    target.Lifetime = false;
    Quotation_Target_Controller.Add(target);

    Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=1");


  }

  private void Update()
  {
    int quotation_id = ((Imaster)this.Page).getQuotationID();
    if (quotation_id == 0)
    {
      quotation_id = ((Imaster)this.Page).saveQuotationID();
    }

    Quotation_Target target = Quotation_Target_Controller.Select(Int32.Parse(hidTargetID.Text));
    target.quotation_id = quotation_id;
    target.target_id = int.Parse(hidTarget_Rates_ID.Value);
    target.target_description = txtDespction.Text.Trim();
    //target.target_code = target.target_code;
    target.country_id = Int32.Parse(ddlCountry.SelectedValue);
    target.product_type_id = Int32.Parse(ddlProductType.SelectedValue);
    target.authority_id = Int32.Parse(ddlAuthority.SelectedValue);
    target.technology_id = Int32.Parse(ddlTechnology.SelectedValue);
    target.target_rate = Decimal.Parse(txtRate.Text);
    target.unit = Double.Parse(txtUnit.Text);
    target.unit_price = Decimal.Parse(txtUnitPrice.Text);
    target.discount_type = rblDisCount.SelectedIndex.ToString();
    target.discValue1 = Int32.Parse(ddlTestdisc.SelectedValue);
    target.discValue2 = Decimal.Parse(txtDiscAmt.Text);
    target.discPrice = Decimal.Parse(hidDiscPrice.Value);
    target.FinalPrice = Decimal.Parse(hidFprice.Value);
    target.PayTo = txtPayTo.Text;
    Quotation_Target_Controller.Modify(target);

    Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=1");


  }


  protected void rblDisCount_SelectedIndexChanged(object sender, EventArgs e)
  {
    if (rblDisCount.SelectedIndex == 0)
    {
      ddlTestdisc.Visible = true;
      txtDiscAmt.Visible = false;
      txtDiscAmt.Text = "0";

    }
    else
    {
      ddlTestdisc.Visible = false;
      txtDiscAmt.Visible = true;
      ddlTestdisc.SelectedIndex = 0;
    }
  }


  protected void gvData_RowCommand(object sender, GridViewCommandEventArgs e)
  {
    int targetID = 0;
    switch (e.CommandName)
    {
      case "tEdit":
        targetID = Int32.Parse(e.CommandArgument.ToString());
        hidTargetID.Text = targetID.ToString();
        LoadTarget(targetID);
        btnSubmit.Enabled = true;
        break;

      case "tDelete":
        targetID = Int32.Parse(e.CommandArgument.ToString());
        if (targetID != 0)
        {
          Quotation_Target_Controller.Delete(targetID);
        }
        //gvData.DataBind();
        int quotation_id = ((Imaster)this.Page).getQuotationID();
        Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=1");
        break;
      default:
        break;
    }


  }

  private void LoadTarget(int TargetID)
  {
    Quotation_Target target = Quotation_Target_Controller.Select(TargetID);
    Dictionary<int, decimal> result =
      CodeTableController.GetAll_Target_Rates((int)target.technology_id,
      (int)target.country_id,
      (int)target.product_type_id,
      (int)target.authority_id);
    if (result.Count <= 0)
    {
      LabelMessage.Text = "此筆Target中的某些資訊可能已經設定為不啟用，因此無法編輯!!請檢核此筆Target之Technology或Certification Type或對應Target Rate Managements中之設定!!";
      return;
    }
    ddlTechnology_Bind();
    ddlTechnology.SelectedValue = target.technology_id.ToString();
    ddlCountry_Bind();
    ddlCountry.SelectedValue = target.country_id.ToString();
    ddlProductType_Bind();
    ddlProductType.SelectedValue = target.product_type_id.ToString();
    ddlAuthority_Bind();
    ddlAuthority.SelectedValue = target.authority_id.ToString();


    txtDespction.Text = target.target_description;
    txtRate.Text = target.target_rate.ToString();
    txtUnit.Text = target.unit.ToString();
    txtUnitPrice.Text = target.unit_price.ToString();
    rblDisCount.SelectedIndex = Int32.Parse(target.discount_type);
    ddlTestdisc.SelectedValue = target.discValue1.ToString();
    txtDiscAmt.Text = target.discValue2.ToString();
    txtDiscPrice.Text = target.discPrice.ToString();
    hidDiscPrice.Value = target.discPrice.ToString();
    hidFprice.Value = target.FinalPrice.ToString();
    txtFprice.Text = target.FinalPrice.ToString();
    txtPayTo.Text = target.PayTo;
    hidTargetID.Text = TargetID.ToString();

    if (rblDisCount.SelectedIndex == 0)
    {
      ddlTestdisc.Visible = true;
      txtDiscAmt.Visible = false;
      //txtDiscAmt.Text = "0";

    }
    else
    {
      ddlTestdisc.Visible = false;
      txtDiscAmt.Visible = true;
      //ddlTestdisc.SelectedIndex = 0;
    }
  }
}