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
                Quotation_Version obj = Quotation_Controller.Get_Quotation(quotation_id);
                employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);

                if (obj.SalesId == emp.id)
                    btnSubmit.Enabled = true;
                else
                    btnSubmit.Enabled = false;
            }
        }



    }

    private void LoadDropDown()
    {
        ddlCountry_Bind();
        ddlProductType_Bind();
        ddlAuthority_Bind();
        ddlTechnology_Bind();
        ddlTarget_Bind();
        Get_Target_Rate();
        //if (ddlTarget.SelectedValue != "")
        //    btnSubmit.Enabled = true;
        //else
        //    btnSubmit.Enabled = false;

        for (int i = 0; i <= 50; i++)
        {
            ddlTestdisc.Items.Add(new ListItem(i.ToString() + "%", i.ToString()));
        }


    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlProductType_Bind();
        ddlAuthority_Bind();
        ddlTechnology_Bind();
        ddlTarget_Bind();
        Get_Target_Rate();
    }
    protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAuthority_Bind();
        ddlTechnology_Bind();
        ddlTarget_Bind();
        Get_Target_Rate();
    }
    protected void ddlAuthority_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlTarget_Bind();
        Get_Target_Rate();
    }
    protected void ddlTechnology_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlTarget_Bind();
        Get_Target_Rate();
    }

    //Country
    private void ddlCountry_Bind()
    {
        ddlCountry.DataSource = CodeTableController.GetAllCountry();
        ddlCountry.DataTextField = "Value";
        ddlCountry.DataValueField = "Key";
        ddlCountry.DataBind();
    }

    //Product Type
    private void ddlProductType_Bind()
    {
        ddlProductType.DataSource = CodeTableController.GetAll_Product_Type(Int32.Parse(ddlCountry.SelectedValue));
        ddlProductType.DataTextField = "Value";
        ddlProductType.DataValueField = "Key";
        ddlProductType.DataBind();
    }

    //Authority
    private void ddlAuthority_Bind()
    {
        if (ddlCountry.SelectedValue != "" && ddlProductType.SelectedValue != "")
        {
            ddlAuthority.DataSource = CodeTableController.GetAll_Authority(Int32.Parse(ddlCountry.SelectedValue), Int32.Parse(ddlProductType.SelectedValue));
            ddlAuthority.DataTextField = "Value";
            ddlAuthority.DataValueField = "Key";
            ddlAuthority.DataBind();
        }
        else
        {
            ddlAuthority.Items.Clear();
        }
    }

    //Technology
    private void ddlTechnology_Bind()
    {
        if (ddlProductType.SelectedValue != "")
        {
            ddlTechnology.DataSource = CodeTableController.GetAll_wowi_tech(Int32.Parse(ddlProductType.SelectedValue));
            ddlTechnology.DataTextField = "Value";
            ddlTechnology.DataValueField = "Key";
            ddlTechnology.DataBind();
        }
        else
        {
            ddlTechnology.Items.Clear();
        }
    }

    //Target
    private void ddlTarget_Bind()
    {
        if (ddlCountry.SelectedValue != "" && ddlProductType.SelectedValue != "" && ddlAuthority.SelectedValue != "" && ddlTechnology.SelectedValue != "")
        {
            ddlTarget.DataSource = CodeTableController.GetAll_Target(Int32.Parse(ddlCountry.SelectedValue), Int32.Parse(ddlProductType.SelectedValue), Int32.Parse(ddlAuthority.SelectedValue), Int32.Parse(ddlTechnology.SelectedValue));
            ddlTarget.DataTextField = "Value";
            ddlTarget.DataValueField = "Key";
            ddlTarget.DataBind();
        }
        else
        {
            ddlTarget.Items.Clear();

        }
    }

    //Target Rate
    private void Get_Target_Rate()
    {
        if (ddlCountry.SelectedValue != "" && ddlProductType.SelectedValue != "" && ddlAuthority.SelectedValue != "" && ddlTechnology.SelectedValue != "")
        {
            txtRate.Text = CodeTableController.GetAll_Target_Rates(Int32.Parse(ddlCountry.SelectedValue), Int32.Parse(ddlProductType.SelectedValue), ddlAuthority.SelectedItem.Text, Int32.Parse(ddlTechnology.SelectedValue)).ToString();

            txtUnitPrice.Text = txtRate.Text;

            if (ddlTarget.SelectedValue != "")
            {
                txtDespction.Text = ddlTarget.SelectedItem.Text;
                btnSubmit.Enabled = true;
            }
            else
            {
                txtDespction.Text = "";
                btnSubmit.Enabled = false;
            }


        }
        else
        {
            txtRate.Text = "";
            txtUnitPrice.Text = txtRate.Text;
            txtDespction.Text = "";
            btnSubmit.Enabled = false;
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
        target.target_id = (ddlTarget.SelectedValue != "") ? Int32.Parse(ddlTarget.SelectedValue) : 0;
        target.target_description = txtDespction.Text;
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
        target.target_id = (ddlTarget.SelectedValue != "") ? Int32.Parse(ddlTarget.SelectedValue) : 0;
        target.target_description = txtDespction.Text;
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

    protected void ddlTarget_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTarget.SelectedValue != "")
            btnSubmit.Enabled = true;
        else
            btnSubmit.Enabled = false;
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
        ddlCountry.SelectedValue = target.country_id.ToString();
        ddlProductType_Bind();
        ddlProductType.SelectedValue = target.product_type_id.ToString();
        ddlAuthority_Bind();
        ddlAuthority.SelectedValue = target.authority_id.ToString();
        ddlTechnology_Bind();
        ddlTechnology.SelectedValue = target.technology_id.ToString();
        ddlTarget_Bind();
        ddlTarget.SelectedValue = target.target_id.ToString();
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
    }
}