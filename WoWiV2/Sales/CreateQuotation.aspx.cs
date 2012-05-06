using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationModel;

public partial class Sales_CreateQuotation : System.Web.UI.Page, Imaster
{
    public int QuotationID;
    #region Imaster 成員

    public int getQuotationID()
    {
        if (hidQuotation_Version_Id.Text != "")
        {
            QuotationID = Int32.Parse(hidQuotation_Version_Id.Text);
            return this.QuotationID;
        }
        else
        {
            //QuotationID = ucTab1.Save();
            //hidQuotation_Version_Id.Text = QuotationID.ToString();
            return 0;
        }
    }

    public int saveQuotationID()
    {
        QuotationID = ucTab1.Save();
        hidQuotation_Version_Id.Text = QuotationID.ToString();
        return QuotationID;
    }

    #endregion

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucTab1.QuotationIDChanged += new providerEventHandler(ucTab1_QuotationIDChanged);
    }

    void ucTab1_QuotationIDChanged(object sender, int QuotationID)
    {
        this.QuotationID = QuotationID;
        hidQuotation_Version_Id.Text = QuotationID.ToString();
        TabContainer1.Tabs[1].Enabled = true;
        TabContainer1.Tabs[2].Enabled = true;
        TabContainer1.Tabs[3].Enabled = true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string q = Request.QueryString["q"];
            if (q != null && Int32.TryParse(q, out QuotationID))
            {

                hidQuotation_Version_Id.Text = QuotationID.ToString();

                Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);
                if (quotation != null)
                {
                    quoTitleDiv.Visible = true;

                    lblQuotation_No.Text = quotation.Quotation_No;
                    //lblVersion.Text = "V" + quotation.Vername.ToString();

                    ddlVersion.DataSource = Quotation_Target_Controller.GetAllVersions(quotation.Quotation_No);
                    ddlVersion.DataTextField = "Value";
                    ddlVersion.DataValueField = "Key";
                    ddlVersion.DataBind();
                    ddlVersion.SelectedValue = QuotationID.ToString();

                    DropDownListStatus.SelectedValue = quotation.Quotation_Status.ToString();
                    txtQuotation_Statusdate.Text = ((DateTime)quotation.Quotation_Statusdate).ToString("yyyy/MM/dd HH:mm");
                    txtQuotation_Statusby.Text = quotation.Quotation_Statusby;


                    string strJavaScript = string.Empty;
                    strJavaScript = "return printform('" + QuotationID.ToString() + "');";
                    btnViewPrint.OnClientClick = strJavaScript;

                    btnViewPrintChinese.OnClientClick = "return printchineseform('" + QuotationID.ToString() + "');";

                    employee loginUser = CodeTableController.GetEmployee(Page.User.Identity.Name);

                    int Waiting_Approve_UserID = (quotation.Waiting_Approve_UserID != null) ? (int)quotation.Waiting_Approve_UserID : 0;
                    if (loginUser.id == Waiting_Approve_UserID || loginUser.id == quotation.SalesId)
                    {
                        DropDownListStatus.Enabled = true;
                        cmdStatus.Enabled = true;
                    }
                    else
                    {
                        DropDownListStatus.Enabled = false;
                        cmdStatus.Enabled = false;
                    }

                }
                else
                {
                    DropDownListStatus.Enabled = false;
                    cmdStatus.Enabled = false;
                }



                string t = Request.QueryString["t"];
                short tabIndex = 0;
                if (q != null && short.TryParse(t, out tabIndex))
                {
                    TabContainer1.ActiveTabIndex = tabIndex;
                }
            }
        }


        if (getQuotationID() == 0)
        {
            //DropDownListStatus.Enabled = false;
            //cmdStatus.Enabled = false;
        }
        else
        {

            //DropDownListStatus.Enabled = true;
            //cmdStatus.Enabled = true;
            Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);

            if (quotation.Quotation_Status == 3 ||
               quotation.Quotation_Status == 4 ||
               quotation.Quotation_Status == 5)
            {
                if (quotation.Currency == "USD")
                {
                    btnViewPrint.Visible = true;
                    btnViewPrintChinese.Visible = false;

                }
                if (quotation.Currency == "NTD")
                {
                    btnViewPrint.Visible = false;
                    btnViewPrintChinese.Visible = true;
                }
            }
            else
            {
                btnViewPrint.Visible = false;
                btnViewPrintChinese.Visible = false;
            }

            // Mark by Adams 2012/4/23 for Project Requirment Change Requirment
            //Project project = CodeTableController.GetProject(getQuotationID()); 

            // Modify by Adams 2012/4/23 for Project Requirment Change Requirment
            Project project = CodeTableController.GetProject(quotation.Quotation_No); 
            if ((project == null) && (quotation.Quotation_Status == 5))
            {
                cmdCreateProject.Enabled = true;
                cmdCreateProject.Text = "Create Project";
            }
            else
            {
                if (project != null)
                    cmdCreateProject.Text = "Project has been created";
                else
                    cmdCreateProject.Text = "Create Project";
                cmdCreateProject.Enabled = false;
            }
        }

    }
    protected void cmdStatus_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);
            if (quotation != null)
            {

                quotation.Quotation_Statusdate = DateTime.Now;
                quotation.Quotation_Statusby = Page.User.Identity.Name;
                employee emp = CodeTableController.GetEmployee(Page.User.Identity.Name);
                quotation.Quotation_StatusbyID = emp.id;


                txtQuotation_Statusdate.Text = ((DateTime)quotation.Quotation_Statusdate).ToString("yyyy/MM/dd HH:mm:ss");
                txtQuotation_Statusby.Text = quotation.Quotation_Statusby;


                if ((DropDownListStatus.SelectedValue == "2") && (quotation.FinalTotalPrice != null))
                {
                    int status = Quotation_Controller.Status_AwaitingApproval((Decimal)quotation.FinalTotalPrice, quotation.Currency, quotation, (int)emp.supervisor_id);
                    //quotation.Quotation_Status = Int32.Parse(DropDownListStatus.SelectedValue);
                    quotation.Waiting_Approve_UserID = emp.supervisor_id;
                    quotation.Quotation_Status = status;
                    Quotation_Controller.Update_Quotation(Quotation_Controller.ent, quotation);

                }else if ((DropDownListStatus.SelectedValue == "3") && (quotation.FinalTotalPrice != null))
                {
                    //CheckIfUserCanApprove();
                    if (quotation.Waiting_Approve_UserID != emp.id)
                    {
                        string strScript = "<script language='JavaScript'>alert('Only SuperVisor can do it! ')</script>";
                        Page.RegisterStartupScript("PopUp", strScript);
                        return;
                    }

                    bool result = Quotation_Controller.Status_Approved((Decimal)quotation.FinalTotalPrice, quotation.Currency, quotation, emp.id);

                    if (!result)
                    {
                        //quotation.Waiting_Approve_UserID 
                        DropDownListStatus.SelectedValue = "2";
                    }
                    quotation.Quotation_Status = Int32.Parse(DropDownListStatus.SelectedValue);
                    Quotation_Controller.Update_Quotation(Quotation_Controller.ent, quotation);

                }
                else
                {
                    quotation.Quotation_Status = Int32.Parse(DropDownListStatus.SelectedValue);
                    Quotation_Controller.Update_Quotation(Quotation_Controller.ent, quotation);
                }
            }

        }

        Response.Redirect("CreateQuotation.aspx?q=" + QuotationID.ToString());

    }

    private void CheckIfUserCanApprove()
    {
        throw new NotImplementedException();
    }
    protected void cmdAdditional_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            Quotation_Version quotation = Quotation_Controller.Get_Quotation(QuotationID);
            int new_id = Quotation_Controller.Copy_Quotation(QuotationID, false, quotation.Quotation_No);
            Response.Redirect("CreateQuotation.aspx?q=" + new_id.ToString());
         
        }
        
    }
    protected void cmdCopy_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        if (QuotationID != 0)
        {
            if (QuotationID > 0)
            {
                int new_id = Quotation_Controller.Copy_Quotation(QuotationID, true, "");
                Response.Redirect("CreateQuotation.aspx?q=" + new_id.ToString());
            }
        }
    }

    protected void cmdCreateProject_Click(object sender, EventArgs e)
    {
        QuotationID = getQuotationID();
        Quotation_Version quot = Quotation_Controller.Get_Quotation(QuotationID);
        CodeTableController.AddProject(quot);

        cmdCreateProject.Text = "Project has been created";
        cmdCreateProject.Enabled = false;
    }

    protected void ddlVersion_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("CreateQuotation.aspx?q=" + ddlVersion.SelectedValue);
    }

  //Add by Adams 2012/5/6 for 狀態控管
    protected void DropDownListStatus_DataBound(object sender, EventArgs e)
    {
      DropDownList ddl = (DropDownList)sender;
      if (ddl.SelectedValue=="1" || ddl.SelectedValue=="2")
      {
        for (int i = ddl.Items.Count - 1 ; i > 2 ; i--)
        {
          ddl.Items.Remove(ddl.Items[i]);
        }
      }
      else
      {
        ddl.Items.Remove(ddl.Items[1]);
        ddl.Items.Remove(ddl.Items[0]);
      }
    }
}