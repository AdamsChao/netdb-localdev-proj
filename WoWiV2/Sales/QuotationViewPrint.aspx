<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationViewPrint.aspx.cs"
    Inherits="Sales_QuotationViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .ccstextboxh
        {           
            font-size: 8pt;
            font-weight: 700;
        }
        .ccstextboxh
        {           
            font-size: 8pt;
        }
        .ccsh1
        {
            font-style: normal;
            font-family: Times New Roman;
            color: rgb(0,0,0);
            font-size: 9pt;
            font-weight: 700;
        }
        .ccstexth
        {
            
            font-size: 8pt;
            font-weight: 700;
        }
        .ccsitemtext
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 7pt;
        }
        B
        {
            font-weight: bold;
        }
        .ccstextboxbd
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #dddddd;
            font-size: 9pt;
        }
      
      .style2
      {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        color: rgb(0,0,0);
        font-size: 8pt;
        height: 13px;
      }
      .style3
      {
        text-decoration: underline;
      }
      .style4
      {
       
        font-size: 8pt;
        font-weight: 700;
        text-decoration: underline;
      }
      .style5
      {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        color: rgb(0,0,0);
        font-size: 8pt;
        height: 13px;
        font-weight: bold;
      }
        .style7
        {
            font-size: 8pt;
            font-weight: 600;
            width: 100%;
        }
        .ccstextboxh2
        {
            font-size: xx-small;
            font-family: Arial, Helvetica, sans-serif;
        }
        .style8
        {
            font-size: 7pt;
        }
        .style9
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 700;
            height: 40px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left">
                <img border="0" height="90" src="../Images/Quotation/WoWilogoname.jpg" />
            </td>
            <td align="middle" class="ccsh1">
                <font face="verdana" size="3">WoWi Approval Services Inc.</font><br />
                <font face="verdana" size="1">3F., No.79, Zhouzi St., Neihu Dist.,<br />
                    Taipei City 114, Taiwan (R.O.C.)<br />
                    T: 886-2-2799-8382 &nbsp; F: 886-2-2799-8387<br />
                    Http://www.WoWiApproval.com</font>
            </td>
            <td align="right">
                <img border="0" height="56" src="../Images/Quotation/transparent.gif" width="168" />
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                QUOTATION#
                <asp:Label ID="lblQuotationNo" runat="server" Text=""></asp:Label>
                <br />
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="left" class="ccstextboxh" width="100%">
                Your Account Representative is:
                <asp:Label ID="lblRepresentative" runat="server" Text="lblRepresentative"></asp:Label>
                <br />
                <br />
            </td>
            <td rowspan="2">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Tel:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblTel" runat="server" Text="lblTel"></asp:Label>&nbsp;ext:<asp:Label 
                              ID="lblext" runat="server"></asp:Label>
                            </nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Fax:
                        </td>
                        <td align="left" class="ccstextboxh">
                            (02) 2799-8387
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Email:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblEmail" runat="server" Text="lblEmail"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Date:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblDate" runat="server" Text="6/17/2010"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" class="ccstextboxh">
                CLIENT :
                <asp:Label ID="lblClient" runat="server"></asp:Label>
                <br />
                BILL 
                TO :&nbsp;<asp:Label 
                  ID="lblBillTo" runat="server"></asp:Label><br />
                APPLICANT :&nbsp;
                <asp:Label ID="lblApplicant" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td class="ccstextboxh" colspan="2" width="100%">
                Please confirm that services requested are correct
                and that the above-named applicant agrees with WoWi Approval Services Inc. (&quot;WoWi&quot;),
                to all of the terms and conditions contained in this Confirmation Agreement. If
                so, please sign below and fax this Confirmation Agreement back to WoWi Sales.
             </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr noshade size="1" />
            </td>
        </tr>
        <tr>
            <td class="style7" valign="top">
                <u>EUT INFORMATION</u><br />
                <br />
                Description:
                <asp:Label ID="lblDescription" runat="server" Text="lblDescription"></asp:Label>
                <p>
                    Model Name:
                    <asp:Label ID="lblModelName" runat="server" Text="lblModelName"></asp:Label></p>
                <p>
                    Brand Name:
                    <asp:Label ID="lblBrandName" runat="server" Text="lblBrandName"></asp:Label>
                </p>
            </td>
            <td align="left" class="ccstextboxh">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="left" class="ccstextboxh" colspan="2">
                            <nobr>
                            <u>CLIENT INFORMATION</u></nobr>                          
                        </td>
                    </tr>
                    <tr><td></td></tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Client:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="LabelClient" runat="server" ></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Contact:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblContact" runat="server" Text="lblContact"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Phone:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblClientPhone" runat="server" Text="lblClientPhone"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Email:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblClientEmail" runat="server" Text="lblClientEmail"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh" valign="top">
                            Address:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblClientAddress" runat="server" Text="lblClientAddress"></asp:Label>
                            <br />
                            <asp:Label ID="lblCleintCountry" runat="server" Text="lblCleintCountry"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr noshade size="1" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <!-- start target -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="ccstexth" width="100%">
                            TARGETS:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvTestTargetList" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                                Width="100%" CaptionAlign="Top" ShowFooter="True" Style="text-align: left" 
                              Font-Size="XX-Small" BorderStyle="None" GridLines="Horizontal">
                                <Columns>
                                    <asp:TemplateField HeaderText="No.">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Vername" HeaderText="Version" SortExpression="Vername">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="target_description" HeaderText="T. Description" SortExpression="target_description">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="unit" HeaderText="Unit" SortExpression="unit">
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Unit Price" SortExpression="unit_price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("unit_price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("unit_price") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                                        <FooterStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        Sub Total
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Total Disc Amt
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        Total
                                                    </td>
                                                </tr>
                                            </table>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total" SortExpression="FinalPrice">
                                        <ItemTemplate>
                                            <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("FinalPrice") %>'></asp:Label>--%>
                                            <%# GetUnitPrice(decimal.Parse(Eval("FinalPrice").ToString())).ToString("N2")%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" Width="100px" />
                                        <FooterStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <asp:Literal ID="Literal1" runat="server" Text="<%# GetNumber()%>"></asp:Literal>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                
                              SelectCommand="SELECT Quotation_No, Vername, target_description, unit, unit_price, FinalPrice, Status, Bill, advance1, advance2, balance1, balance2, option1, option2, Quotation_Target_Id FROM vw_Test_Target_List WHERE (Quotation_Version_Id = @Quotation_Version_Id) ORDER BY Quotation_Target_Id">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidQuotationID" Name="Quotation_Version_Id" 
                                      PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <!-- end target -->
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr class="ccstextboxh">
            <td colspan="2" >
                &nbsp;
                Remark for Client :
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="ccstexth" colspan="2">
                <!-- start cost summary service -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" class="ccstexth">
                            &nbsp;</td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            <span class="style3">Total Cost (payable to WoWi):
                            &nbsp; &nbsp;USD</span><asp:Label ID="lblTotalCost" runat="server" 
                              Text="lblTotalCost" CssClass="style3"></asp:Label></nobr>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!-- end cost summary service -->
    </table>
    <p style="page-break-before: always">
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="left">
                    <img border="0" height="90" src="../Images/Quotation/WoWilogoname.jpg" />
                </td>
                <td align="middle" class="ccsh1">
                    <font face="verdana" size="3">WoWi Approval Services Inc.</font><br />
                    <font face="verdana" size="1">3F., No.79, Zhouzi St., Neihu Dist.,<br />
                        Taipei City 114, Taiwan (R.O.C.)<br />
                        T: 886-2-2799-8382&nbsp;&nbsp; F: 886-2-2799-8387<br />
                        Http://www.WoWiApproval.com</font>
                </td>
                <td align="right">
                    <img border="0" height="56" src="../Images/Quotation/transparent.gif" width="168" />
                </td>
            </tr>
            <tr>
                <td align="middle" class="ccsh1" colspan="3" valign="top">
                    QUOTATION#
                    <asp:Label ID="lblQuotationNo0" runat="server" Text=""></asp:Label>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="left" class="ccstextboxh" width="100%">
                    Your Account Representative is:
                    <asp:Label ID="lblRepresentative0" runat="server" Text="lblRepresentative"></asp:Label>
                    &nbsp;
                    <br />
                    <br />
                </td>
                <td rowspan="2">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="left" class="ccstextboxh">
                               Tel:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                            <asp:Label ID="lblTel0" runat="server" Text="lblTel"></asp:Label>&nbsp;ext:</nobr><asp:Label 
                                  ID="lblext0" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Fax:
                             </td>
                            <td align="left" class="ccstextboxh">
                                (02) 2799-8387
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Email:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <asp:Label ID="lblEmail0" runat="server" Text="lblEmail"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Date:
                            </td>
                            <td align="left" class="ccstextboxh">
                               
                            <asp:Label ID="lblDate0" runat="server" Text="6/17/2010"></asp:Label>
                               
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="ccstextboxh">
                    CLIENT :
                    <asp:Label ID="lblClient0" runat="server"></asp:Label>
                    <br />
                   BILL TO :&nbsp;<asp:Label 
                      ID="lblBillTo0" runat="server"></asp:Label><br />
                    APPLICANT :&nbsp;
                    <asp:Label ID="lblApplicant0" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="ccstextboxh" colspan="2" width="100%">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="ccstextboxh" colspan="2" width="100%">
                    Please confirm 
                    that services requested are correct
                    and that the above-named applicant agrees with WoWi Services Inc. (&quot;WoWi&quot;),
                    to all of the terms and conditions contained in this Confirmation Agreement. If
                    so, please sign below and fax this Confirmation Agreement back to WoWi Sales.
                  </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr noshade size="1" />
                </td>
            </tr>
            <tr>
                <td class="ccstextboxh">
                    <u>EUT INFORMATION</u>
                </td>
                <td class="ccstextboxh">
                    <nobr>
                    <u>CLIENT INFORMATION</u></nobr>
                </td>
            </tr>
            <tr>
                <td class="style7" valign="top">
                    <br />
                    Description:
                    <asp:Label ID="lblDescription0" runat="server" Text="lblDescription"></asp:Label>
                    <p>
                        Model Name:
                        <asp:Label ID="lblModelName0" runat="server" Text="lblModelName"></asp:Label></p>
                    <p>
                        Brand Name:
                        <asp:Label ID="lblBrandName0" runat="server" Text="lblBrandName"></asp:Label>
                    </p>
                    <p>
                        &nbsp;</p>
                </td>                
                <td align="Left" class="ccstextboxh">
                    <table border="0" cellpadding="0" cellspacing="0" >
                        <tr>
                          <td align="left" class="ccstextboxh">
                              Client:
                          </td>
                          <td align="left" class="ccstextboxh">
                              <nobr>
                              <asp:Label ID="LabelClient0" runat="server" ></asp:Label></nobr>
                          </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Contact:
                            </td>
                            <td>
                                <asp:Label ID="lblContact0" runat="server" Text="lblContact"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Phone:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                            <asp:Label ID="lblClientPhone0" runat="server" Text="lblClientPhone"></asp:Label></nobr>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Email:
                            </td>
                            <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblClientEmail0" runat="server" Text="lblClientEmail"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh" valign="top">
                                Address:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                               
                                </nobr>
                                <asp:Label ID="lblClientAddress0" runat="server" Text="lblClientAddress"></asp:Label>
                                <br />
                                <asp:Label ID="lblCleintCountry0" runat="server" Text="lblCleintCountry"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr noshade size="1" />
                </td>
            </tr>
            <tr>
                <td class="ccstextboxh2" colspan="2">
                    Note: Additional Terms and Conditions: The client/applicant is responsible for providing
                    all documents, sample(s), and any other information required by WoWi for the application. WoWi is not responsible for any documents provided by the applicant
                    that contain any errors or omissions or that are delayed in process. The client/applicant
                    understands that the testing process can damage or destroy the sample(s). The 
                    client/applicant
                    also understands that WoWi may be required to alter the sample(s) in connection
                    with the testing process and that this alteration may damage or destroy the sample(s);
                    the client/applicant agrees to hold WoWi harmless for any damage or destruction of the
                    sample(s) which may occur as a result of such alteration. In addition, the 
                    client/applicant
                    agrees to hold WoWi harmless for any damage or destruction of the sample(s) due
                    to fire, theft, vandalism, or otherwise unless such damage or destruction was caused
                    by the gross negligence of WoWi. In any event the client/applicant agrees that WoWi&#39;
                    liability shall not exceed the lesser of; (1) the wholesale value of the sample(S),
                    or (2) <span class="style3">five hundreds dollars</span>.If the client/applicant does not request the return of the
                    sample(s) within one (1) month after the sample(s) are certified or verified, then:
                    (i) the sample(s) may be destroyed by WoWi and (ii) WoWi shall not have any liability
                    for such destruction of the sample(s). WoWi has a lien on the sample(s) and other
                    materials for the payment of amounts payable to WoWi hereunder; in the event that
                    any amounts payable to WoWi become past due, then WoWi may retain possession of
                    the sample(s) and other materials and may exercise its rights as a lienholder in
                    accordance to applicable law.<br />
                    <br />
                    Please read the above carefully and confirm by signing below and returning this
                    Confirmation Agreement to WoWi as soon as possible. WoWi will not start to work
                    on the above project until: (i) WoWi receives the applicant&#39;s PO or this signed
                    Confirmation Agreement; and (ii) either, an approved line of credit has been established
                    with WoWi and a <span class="style3">50% deposit</span> has been received; a 
                    <span class="style3">100% cash prepayment has been received
                    by WoWi</span>; or other payment terms have been indicated above.
                </td>
            </tr>
            <tr>
                <td align="middle" class="ccstexth" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="ccstexth" colspan="2">
                    <!-- start cost summary service -->
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="ccstextboxh" rowspan="5" width="100%">
                                <u>CANCELLATION POLICY</u><br />
                                <span class="style8">after applications have been submitted to the countries , the cancellation Fee 
                                80% of quoted price to be billed.</span><br />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="ccstexth">
                                &nbsp;
                            </td>
                            <td align="right" class="ccstexth">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="ccstexth">
                                &nbsp;
                            </td>
                            <td align="right" class="ccstexth">
                                &nbsp;
                            </td>
                        </tr>
                        <!--    <tr><td class="ccstexth" align="right"><nobr>Other Fees:</nobr></td><td class="ccstexth" align="right">$0.00</td></tr>  -->
                        <tr>
                            <td align="right" class="style4">
                                <nobr>
                                Total Cost (payable to WoWi):</nobr>
                            </td>
                            <td align="right" class="ccstexth">
                                <nobr>
                                <span class="style3">&nbsp;&nbsp;&nbsp;USD</span><asp:Label ID="lblTotalCost2" runat="server" Text="lblTotalCost2" 
                                  CssClass="style3"></asp:Label></nobr>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- end cost summary service -->
            <!--
<tr><td colspan="2">
  <table border="0" width="414" cellspacing="0" cellpadding="0" >
    <tr><td class="ccstexth" width="194">PO No.:</td>
    <td width="216">___________________________</td></tr>
    <tr><td class="ccstexth" width="194" ><nobr>PO Not To Exceed:</nobr></td>
    <td width="216">___________________________</td></tr>
  </table>
</td></tr>
-->
            <tr>
                <td class="ccstexth" colspan="2" width="100%">
                    <b><span class="style8">Return Sample:&nbsp; Yes-</span><input name="C2" 
                        type="checkbox" value="ON" class="style8" /><span class="style8">&nbsp;No-</span><input
                        name="C1" type="checkbox" value="ON" class="style8" /><nobr><span 
                        class="style8">&nbsp;If no entry made, No is 
                    assumed</span></nobr></b>
                </td>
            </tr>
            <tr>
                <td colspan="2" width="100%">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <!-- Start Signature Section -->
                    <table border="1" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <th class="style9" width="50%">
                                <asp:Label ID="lblBillTo1" runat="server" 
                                    Text="lblBillTo"></asp:Label>
                            </th>
                            <th class="style9" width="50%">
                                WoWi Approval Services Inc.
                            </th>
                        </tr>
                        <tr>
                            <td class="style9">
                                By:
                            </td>
                            <td class="style9">
                                By:<asp:Image 
                                    ID="imgSign" runat="server" Height="31" Width="114" />
&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style5" height="30">
                                Name:
                            </td>
                            <td class="style2" height="30">
                                <b>Name:
                            <asp:Label ID="lblRepresentative1" runat="server" Text="lblRepresentative"></asp:Label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                                Title:
                            </td>
                            <td class="style2">
                                <b>Title:<asp:Label ID="lblTitle" 
                                    runat="server" Text="lblTitle"></asp:Label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                                Date:
                            </td>
                            <td class="style2">
                                <b>Date:<asp:Label ID="lblDate1" runat="server" 
                                    Text=""></asp:Label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                &nbsp;Reviewed:</td>
                            <td class="style9">
                                Reviewed:
                            </td>
                        </tr>
                        <tr>
                            <td class="style9">
                                &nbsp;Approved:</td>
                            <td class="style9">
                                Approved:
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!-- End Signature Section -->
            <tr>
                <td colspan="2" width="100%">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="ccstextboxh" colspan="2">
                    *This quote is valid for 30 days from the day of issuance.&nbsp;
                </td>
            </tr>
        </table>
        <!-- end body -->
    </p>
    <asp:TextBox ID="hidQuotationID" runat="server" Text="0" Visible="false"></asp:TextBox>
    <asp:TextBox ID="hidQuotation_No" runat="server" Text="0" Visible="false"></asp:TextBox>
    </form>
</body>
</html>
