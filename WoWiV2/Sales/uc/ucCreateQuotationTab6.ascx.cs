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

        lblService.Text = Quotation_Controller.GetTotalVersionUnitPrice(quo.Quotation_No);
        lblDiscount.Text = Quotation_Controller.GetTotalVersionDiscount(quo.Quotation_No);
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

    public string myFunc(string val)
    {

        if (val == "")

            return null;

        else

            return val;

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Row in gvTestTargetList.Rows)
        {
            Label lblQuotation_Target_Id = (Label)Row.FindControl("lblQuotation_Target_Id");
            HtmlInputHidden hidA1 = (HtmlInputHidden)Row.FindControl("hidA1");
            HtmlInputHidden hidA2 = (HtmlInputHidden)Row.FindControl("hidA2");
            HtmlInputHidden hidB1 = (HtmlInputHidden)Row.FindControl("hidB1");
            HtmlInputHidden hidB2 = (HtmlInputHidden)Row.FindControl("hidB2");
            HtmlInputRadioButton Radio1 = (HtmlInputRadioButton)Row.FindControl("Radio1");
            HtmlInputRadioButton Radio2 = (HtmlInputRadioButton)Row.FindControl("Radio2");
            DropDownList ddlAdv = (DropDownList)Row.FindControl("ddlAdv");
            //DropDownList ddlBill = (DropDownList)Row.FindControl("ddlBill");
            //CheckBox chkPR_Flag = (CheckBox)Row.FindControl("chkPR_Flag");
            

            TextBox txtAdv2 = (TextBox)Row.FindControl("txtAdv2");

            int id = Int32.Parse(lblQuotation_Target_Id.Text);
            Quotation_Target target = Quotation_Target_Controller.Select(id);
            //target.Bill = ddlBill.Text;
            target.option1 = Radio1.Checked;
            target.option2 = Radio2.Checked;
            target.advance1 = hidA1.Value;
            try
            {
                DropDownList ddlPR_Flag = (DropDownList)Row.FindControl("ddlPR_Flag");
                target.PR_Flag = ddlPR_Flag.SelectedValue;
            }
            catch (Exception)
            {
                //throw;
            }
            Decimal advance2;
            if (Decimal.TryParse(hidA2.Value, out advance2))
                target.advance2 = advance2;
            target.balance1 = hidB1.Value;
            Decimal balance2;
            if (Decimal.TryParse(hidB2.Value, out balance2))
                target.balance2 = balance2;
            Quotation_Target_Controller.Modify(target);
        }
        int quotation_id = ((Imaster)this.Page).getQuotationID();
        Response.Redirect("CreateQuotation.aspx?q=" + quotation_id.ToString() + "&t=3");
    }

    protected void gvTestTargetList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HtmlInputRadioButton Radio1 = (HtmlInputRadioButton)e.Row.FindControl("Radio1");
            HtmlInputRadioButton Radio2 = (HtmlInputRadioButton)e.Row.FindControl("Radio2");
            DropDownList ddlAdv = (DropDownList)e.Row.FindControl("ddlAdv");
            TextBox txtAdv2 = (TextBox)e.Row.FindControl("txtAdv2");
            TextBox txtB1 = (TextBox)e.Row.FindControl("txtB1");
            TextBox txtB2 = (TextBox)e.Row.FindControl("txtB2");
            HtmlInputHidden hidA1 = (HtmlInputHidden)e.Row.FindControl("hidA1");
            HtmlInputHidden hidA2 = (HtmlInputHidden)e.Row.FindControl("hidA2");
            HtmlInputHidden hidB1 = (HtmlInputHidden)e.Row.FindControl("hidB1");
            HtmlInputHidden hidB2 = (HtmlInputHidden)e.Row.FindControl("hidB2");

            Label lblFPrice = (Label)e.Row.FindControl("lblFPrice");
            Label lblOption1 = (Label)e.Row.FindControl("lblOption1");
            Label lblOption2 = (Label)e.Row.FindControl("lblOption2");


            Label lblQuotation_Target_Id = (Label)e.Row.FindControl("lblQuotation_Target_Id");
            Literal lblInvoice0 = (Literal)e.Row.FindControl("lblInvoice0");
            Label lblInvoice3 = (Label)e.Row.FindControl("lblInvoice3");

            DropDownList ddlPR_Flag = (DropDownList)e.Row.FindControl("ddlPR_Flag");
            int PR_Flag;
            int.TryParse(ddlPR_Flag.ToolTip, out PR_Flag);
            ddlPR_Flag.SelectedIndex = PR_Flag;
            ddlPR_Flag.ToolTip = "";

            int quotation_Id =  Int32.Parse( hidQuotationID.Text);
            int target_Id = Int32.Parse(lblQuotation_Target_Id.Text);
            lblInvoice0.Text = Quotation_Controller.GetInvoice(quotation_Id,target_Id, 0);
            lblInvoice3.Text = Quotation_Controller.GetInvoice(quotation_Id,target_Id, 3);

            if (!String.IsNullOrEmpty(lblOption1.Text))
                Radio1.Checked = Boolean.Parse(lblOption1.Text);
            if (!String.IsNullOrEmpty(lblOption2.Text))
                Radio2.Checked = Boolean.Parse(lblOption2.Text);

            if (Radio1.Checked)
            {
                ddlAdv.Enabled = true;
                ddlAdv.CssClass = "";
                txtAdv2.Enabled = false;
                txtAdv2.CssClass = "CCSTextBoxRD";

            }
            else
            {
                ddlAdv.Enabled = false;
                ddlAdv.CssClass = "CCSTextBoxRD";
                txtAdv2.Enabled = true;
                txtAdv2.CssClass = "";
            }

            Radio1.Attributes.Add("OnClick", "cmdRBL('" +
                ddlAdv.ClientID + "','" + txtAdv2.ClientID + "','" +
                txtB1.ClientID + "','" + txtB2.ClientID + "','" +
                hidA1.ClientID + "','" + hidA2.ClientID + "','" +
                hidB1.ClientID + "','" + hidB2.ClientID + "','" +
                lblFPrice.Text + "','1');");
            Radio2.Attributes.Add("OnClick", "cmdRBL('" +
                 ddlAdv.ClientID + "','" + txtAdv2.ClientID + "','" +
                txtB1.ClientID + "','" + txtB2.ClientID + "','" +
                hidA1.ClientID + "','" + hidA2.ClientID + "','" +
                hidB1.ClientID + "','" + hidB2.ClientID + "','" +
                lblFPrice.Text + "','2');");

            for (int i = 0; i <= 100; i++)
            {
                ddlAdv.Items.Add(new ListItem(i.ToString() + "%", i.ToString()));
            }
            ddlAdv.Items.Insert(0, new ListItem("--select--", ""));
            ddlAdv.Text = hidA1.Value.Replace("%", "");

            

            ddlAdv.Attributes.Add("OnClick", "cmdDDL('" +
                ddlAdv.ClientID + "','" + txtAdv2.ClientID + "','" +
                txtB1.ClientID + "','" + txtB2.ClientID + "','" +
                hidA1.ClientID + "','" + hidA2.ClientID + "','" +
                hidB1.ClientID + "','" + hidB2.ClientID + "','" +
                lblFPrice.Text + "');");
            txtAdv2.Attributes.Add("onkeyup", "cmdText('" +
             ddlAdv.ClientID + "','" + txtAdv2.ClientID + "','" +
             txtB1.ClientID + "','" + txtB2.ClientID + "','" +
                hidA1.ClientID + "','" + hidA2.ClientID + "','" +
             hidB1.ClientID + "','" + hidB2.ClientID + "','" +
             lblFPrice.Text + "');");


        } 
    }

    //public int CheckPR_Flag(object PR_Flag, int ID)
    //{
    //    int boolPR_Flag;
    //    try
    //    {
    //        int.TryParse(PR_Flag.ToString(), out boolPR_Flag);
    //        return boolPR_Flag;
    //    }
    //    catch (Exception)
    //    {
    //        return 0;
    //    }
    //}
}