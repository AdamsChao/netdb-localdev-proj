﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Project_ProjectWorkingStatusReportExternal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridViewProject_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        PanelReport.Visible = true;
        LabelProject.Text =  GridViewProject.Rows[e.NewSelectedIndex].Cells[2].Text;
        LabelClient.Text = GridViewProject.Rows[e.NewSelectedIndex].Cells[4].Text;
        LabelModel.Text = GridViewProject.Rows[e.NewSelectedIndex].Cells[5].Text;
        LabelProduct.Text = GridViewProject.Rows[e.NewSelectedIndex].Cells[6].Text;

    }
    protected void GridViewReport_PreRender(object sender, EventArgs e)
    {
        int i = 1;
        foreach (GridViewRow wkItem in GridViewReport.Rows)
        {
            if (wkItem.RowIndex != 0)
            {
                GridViewReport.Rows[(wkItem.RowIndex - i)].Cells[12].RowSpan += 1;
                wkItem.Cells[12].Visible = false;
                i = i + 1;
            }
            else
            {
                wkItem.Cells[12].RowSpan = 1;
            }
        }
    }
    protected void TreeViewMenu_SelectedNodeChanged(object sender, EventArgs e)
    {
        PanelReport.Visible = false;
    }
    protected void DropDownListAE_SelectedIndexChanged(object sender, EventArgs e)
    {
        PanelReport.Visible = false;
    }
    protected void ButtonExcel_Click(object sender, EventArgs e)
    {
        ButtonExcel.Visible = false;
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>"); 
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename="
            + HttpContext.Current.Server.UrlEncode(LabelProject.Text) + "WorkingStatus.xls");
        HttpContext.Current.Response.Charset = "utf-8";
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        PanelReport.RenderControl(hw);
        HttpContext.Current.Response.Write(sw.ToString());
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();
        ButtonExcel.Visible = true;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void GridViewReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      if (e.Row.RowType == DataControlRowType.DataRow)
      {
        Label lblTest = (Label)e.Row.FindControl("LabelTestDate");
        if (string.IsNullOrEmpty(lblTest.Text))
        {
          lblTest.Text = "N/A";
        }
        Label lblEst = (Label)e.Row.FindControl("LabelEstDate");
        if (string.IsNullOrEmpty(lblEst.Text))
        {
          lblEst.Text = "N/A";
        }
      }
    }
}