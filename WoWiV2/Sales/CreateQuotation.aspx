<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
    CodeFile="CreateQuotation.aspx.cs" Inherits="Sales_CreateQuotation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="uc/ucCreateQuotationTab1.ascx" TagName="ucCreateQuotationTab1"
    TagPrefix="uc1" %>
<%@ Register Src="uc/ucCreateQuotationTab2.ascx" TagName="ucCreateQuotationTab2"
    TagPrefix="uc2" %>
<%@ Register Src="uc/ucCreateQuotationTab4.ascx" TagName="ucCreateQuotationTab4"
    TagPrefix="uc4" %>
<%@ Register Src="uc/ucCreateQuotationTab6.ascx" TagName="ucCreateQuotationTab6"
    TagPrefix="uc6" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server"> 
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="../../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-ui.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
    function btn() {
        $("#dialog").dialog();
    }

    function btnDeny() {
        $("#dialogDeny").dialog();
    }
    
</script>
    <script language="javascript" type="text/javascript">
        function printform(qid) {
            //var printContent = document.getElementById("<%= TabContainer1.ClientID %>");
            var windowUrl = 'QuotationViewPrint.aspx?q=' + qid;
            var uniqueName = new Date();
            var windowName = 'Print' + uniqueName.getTime();
            var printWindow = window.open(windowUrl, windowName);

//            printWindow.document.write(printContent.innerHTML);
//            printWindow.document.close();
            printWindow.focus();
            //printWindow.print();
            //printWindow.close();

            return false;
        }

        function printchineseform(qid) {
            //var printContent = document.getElementById("<%= TabContainer1.ClientID %>");
            var windowUrl = 'QuotationViewPrintChinese.aspx?q=' + qid;
            var uniqueName = new Date();
            var windowName = 'Print' + uniqueName.getTime();
            var printWindow = window.open(windowUrl, windowName);

            //            printWindow.document.write(printContent.innerHTML);
            //            printWindow.document.close();
            printWindow.focus();
            //printWindow.print();
            //printWindow.close();

            return false;
        } 
    </script>
    <style type="text/css">
      .style5
      {
        font-size: small;
      }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="quoTitleDiv" runat="server" visible="false">
       <table align="center" border="1" cellpadding="0" cellspacing="0"  width="100%" style="background-color: #EFF3FB">
            <tr>
                <td style="color: #000099; font-size: large">
                    Quotation:
                    <asp:Label ID="lblQuotation_No" runat="server" Text=""></asp:Label>
                    &nbsp;
                    <asp:DropDownList ID="ddlVersion" runat="server" 
                        onselectedindexchanged="ddlVersion_SelectedIndexChanged" AutoPostBack="true">
                    </asp:DropDownList>
                &nbsp;<span class="style5">(Only Show Confirmed Version)</span></td>
                <td>
                    <asp:Button ID="cmdAdditional" runat="server" Text="Additional Quotation" OnClick="cmdAdditional_Click" />
                </td>
                <td>
                    <asp:Button ID="cmdCopy" runat="server" Text="Copy" OnClick="cmdCopy_Click" />
                    &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnViewPrint" runat="server" Text="View/Print"  />
                        <asp:Button ID="btnViewPrintChinese" runat="server" Text="View/Print" />
                </td>
            </tr>
            <tr>
                <td>
                    Status:
                    <asp:DropDownList ID="DropDownListStatus" runat="server" DataSourceID="SqlDataSourceStatus"
                        DataTextField="Quotation_Status_Name" DataValueField="Quotation_Status_Id" 
                      Enabled="False" ondatabound="DropDownListStatus_DataBound">
                    </asp:DropDownList>
                    <asp:Button ID="cmdStatus" runat="server" Text="Change Status" OnClick="cmdStatus_Click"
                        Enabled="false" />
                &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="cmdCreateProject" runat="server" Text="Create Project" 
                        onclick="cmdCreateProject_Click" />
                </td>
                <td>
                    Status Changed On :
                    <asp:TextBox ID="txtQuotation_Statusdate" runat="server" Width="119px" ReadOnly="true"></asp:TextBox>
                </td>
                <td>
                    Status Changed By :
                    <asp:TextBox ID="txtQuotation_Statusby" runat="server" Width="72px" ReadOnly="true"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSourceStatus" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
        SelectCommand="SELECT [Quotation_Status_Id], [Quotation_Status_Name] FROM [Quotation_Status]">
    </asp:SqlDataSource>
    <script src="../Scripts/jquery.validate.js" type="text/javascript"></script>
    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
        <asp:TabPanel runat="server" HeaderText="EUT" ID="TabPanel1">
            <ContentTemplate>
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <uc1:ucCreateQuotationTab1 ID="ucTab1" runat="server" />











                

                

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            
</ContentTemplate>
            
            
        










</asp:TabPanel>
        <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Test Target">
            <ContentTemplate>
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <uc2:ucCreateQuotationTab2 ID="ucTab2" runat="server" />
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            
</ContentTemplate>
            
            
        










</asp:TabPanel>
        <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="Remark/Payment">
            <ContentTemplate>
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <uc4:ucCreateQuotationTab4 ID="ucTab4" runat="server" />
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            
</ContentTemplate>
            
            
        










</asp:TabPanel>
        <asp:TabPanel ID="TabPanel4" runat="server" HeaderText="Billing">
            <ContentTemplate>
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <uc6:ucCreateQuotationTab6 ID="ucTab6" runat="server" />
                
                
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            
</ContentTemplate>
            
            
        










</asp:TabPanel>
    </asp:TabContainer>
    <asp:TextBox ID="hidQuotation_Version_Id" runat="server" Visible="false"></asp:TextBox>
    <div id="dialogDeny" title="Message" style="display: none;">
    You Can't Approvel the Quotation</div>
</asp:Content>
