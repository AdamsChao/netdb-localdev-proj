<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationViewPrint.aspx.cs"
    Inherits="Sales_QuotationViewPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .CCSTextBoxH
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 7pt;
            font-weight: 600;
        }
        .CCSH1
        {
            font-style: normal;
            font-family: Times New Roman;
            color: rgb(0,0,0);
            font-size: 14pt;
            font-weight: 700;
        }
        .CCSTextH
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 500;
        }
        .CCSItemText
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 7pt;
        }
        B
        {
            font-weight: bold;
        }
        .CCSTextBoxRD
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #dddddd;
            font-size: 9pt;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                Page 1 of 2
            </td>
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
                <asp:Label ID="lblQuotationNo" runat="server" Text="I1010031-02"></asp:Label>
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="left" class="ccstextboxh" width="100%">
                Your Account Representative is:
                <asp:Label ID="lblRepresentative" runat="server" Text="Shirley Kang"></asp:Label>
            </td>
            <td rowspan="2">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Tel:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            (02) 2799-8382x200</nobr>
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
                            <asp:Label ID="lblEmail" runat="server" Text="Shirley.Kang@WoWiApproval.com"></asp:Label>
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
            <td align="left" class="ccstexth">
                BILL TO:&nbsp;Samsung Electronics Co., LTD.
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
                Please confirm that the date(s) scheduled and/or services requested are correct
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
            <td class="ccstextboxh" valign="top">
                <u>EUT INFORMATION</u><br />
                Description:
                <asp:Label ID="lblDescription" runat="server" Text="Audio transceiver module"></asp:Label>
                <p>
                    Model Name:
                    <asp:Label ID="lblModelName" runat="server" Text="SWA-5000 / FCC ID: A3LSWA5000"></asp:Label></p>
            </td>
            <td align="right" class="ccstextboxh">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="left" class="ccstextboxh" colspan="2">
                            <nobr>
                            <u>CONTACT INFORMATION</u></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Contact:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblContact" runat="server" Text="ChangSeub Eum"></asp:Label></nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Phone:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblClientPhone" runat="server" Text="Contact"></asp:Label>+82-31-2772635</nobr>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh">
                            Email:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <asp:Label ID="lblClientEmail" runat="server" Text="cseum@samsung.com"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="ccstextboxh" valign="top">
                            Address:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblClientAddress" runat="server" Text="416, Maetan-3 Dong , Yeongtong-Gu, Suwon-City Gyeonggi-Do, 443-742 443-742"></asp:Label>
                            <br />
                            <asp:Label ID="lblCleintCountry" runat="server" Text="South Korea"></asp:Label></nobr>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" class="ccstextboxh" colspan="2" valign="top">
                PO:_____________Limit: $
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
                            TARGET:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <hr color="#003300" noshade size="1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvTestTargetList" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1"
                                Width="100%" CaptionAlign="Top" ShowFooter="True" Style="text-align: left">
                                <Columns>
                                    <asp:TemplateField HeaderText="No.">
                                        <ItemTemplate>
                                            <%#Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Vername" HeaderText="Version" SortExpression="Vername">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="target_description" HeaderText="T. Description" SortExpression="target_description">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status">
                                        <HeaderStyle HorizontalAlign="Left" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="unit" HeaderText="Unit" SortExpression="unit">
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Unit Price" SortExpression="unit_price">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("unit_price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("unit_price") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
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
                                    <asp:TemplateField HeaderText="FinalPrice" SortExpression="FinalPrice">
                                        <ItemTemplate>
                                           <%-- <asp:Label ID="Label1" runat="server" Text='<%# Bind("FinalPrice") %>'></asp:Label>--%>
                                          <%# GetUnitPrice(decimal.Parse(Eval("FinalPrice").ToString())).ToString("N2")%>


                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Right" />
                                        <ItemStyle HorizontalAlign="Right" />
                                        <FooterStyle HorizontalAlign="Right" />
                                        <FooterTemplate>
                                            <asp:Literal ID="Literal1" runat="server" Text="<%# GetNumber()%>"></asp:Literal>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="SELECT Quotation_No, Vername, target_description, unit, unit_price, FinalPrice, Status, Bill, advance1, advance2, balance1, balance2, option1, option2, Quotation_Target_Id FROM vw_Test_Target_List WHERE (Quotation_No = @Quotation_No) ORDER BY Quotation_Version_Id">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidQuotation_No" Name="Quotation_No" PropertyName="Text"
                                        Type="String" />
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
        <tr>
            <td colspan="2">
                &nbsp;
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
                            Test Cost:
                        </td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            &nbsp; &nbsp; &nbsp; $0.00</nobr>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%">
                            &nbsp;
                        </td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            Agency Fees (Advanced by WoWi, payable to WoWi):</nobr>
                        </td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            &nbsp; &nbsp; &nbsp; $8,300.00</nobr>
                        </td>
                    </tr>
                    <!--    <tr><td>&nbsp;</td><td class="ccstexth" align="right"><nobr>Other Fees:</nobr></td><td class="ccstexth" align="right">$0.00</td></tr>  -->
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            Total Cost (payable to WoWi):</nobr>
                        </td>
                        <td align="right" class="ccstexth">
                            <nobr>
                            &nbsp; &nbsp; &nbsp; $8,300.00</nobr>
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
                    Page 2 of 2
                </td>
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
                    QUOTATION# I1010031-02
                </td>
            </tr>
        </table>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td align="left" class="ccstextboxh" width="100%">
                    Your Account Representative is: Shirley Kang
                </td>
                <td rowspan="2">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Tel:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                                (02) 2799-8382x200</nobr>
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
                                Shirley.Kang@WoWiApproval.com
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Date:
                            </td>
                            <td align="left" class="ccstextboxh">
                                6/17/2010
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" class="ccstexth">
                    BILL TO:&nbsp;Samsung Electronics Co., LTD.
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
                    Please confirm that the date(s) scheduled and/or services requested are correct
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
                <td class="ccstexth">
                    <u>EUT INFORMATION</u>
                </td>
                <td class="ccstexth">
                    <nobr>
                    <u>CONTACT INFORMATION</u></nobr>
                </td>
            </tr>
            <tr>
                <td class="ccstextboxh" valign="top" width="100%">
                    Description: Audio transceiver module
                    <p>
                        Model Name: SWA-5000 / FCC ID: A3LSWA5000</p>
                </td>
                <td align="left" class="ccstextboxh">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Contact:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                                ChangSeub Eum</nobr>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Phone:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                                +82-31-2772635</nobr>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh">
                                Email:
                            </td>
                            <td align="left" class="ccstextboxh">
                                cseum@samsung.com
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="ccstextboxh" valign="top">
                                Address:
                            </td>
                            <td align="left" class="ccstextboxh">
                                <nobr>
                                416, Maetan-3 Dong , Yeongtong-Gu, Suwon-City<br />
                                Gyeonggi-Do, 443-742 443-742
                                <br />
                                South Korea</nobr>
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
                <td class="ccstextboxh" colspan="2">
                    Note: Additional Terms and Conditions: The applicant is responsible for providing
                    all documents, sample(s), and any other information required by WoWi for the test
                    and application. WoWi is not responsible for any documents provided by the applicant
                    that contain any errors or omissions or that are delayed in process. The applicant
                    understands that the testing process can damage or destroy the sample(s). The applicant
                    also understands that WoWi may be required to alter the sample(s) in connection
                    with the testing process and that this alteration may damage or destroy the sample(s);
                    the applicant agrees to hold WoWi harmless for any damage or destruction of the
                    sample(s) which may occur as a result of such alteration. In addition, the applicant
                    agrees to hold WoWi harmless for any damage or destruction of the sample(s) due
                    to fire, theft, vandalism, or otherwise unless such damage or destruction was caused
                    by the gross negligence of WoWi. In any event the applicant agrees that WoWi&#39;
                    liability shall not exceed the lesser of; (1) the wholesale value of the sample(S),
                    or (2) five thousand dollars.If the applicant does not request the return of the
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
                    on the above project until: (i) WoWi receives the applicant&#39;s PO and this signed
                    Confirmation Agreement; and (ii) either, an approved line of credit has been established
                    with WoWi and a 50% deposit has been received; a 100% cash prepayment has been received
                    by WoWi; or other payment terms have been indicated above.
                </td>
            </tr>
            <tr>
                <td align="middle" class="ccstexth" colspan="2">
                    <i>Our Customers are welcome at all times to witness testing of their equipment</i>
                </td>
            </tr>
            <tr>
                <td class="ccstexth" colspan="2">
                    <!-- start cost summary service -->
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="ccstextboxh" rowspan="5" width="100%">
                                <u>CANCELLATION POLICY</u><br />
                                greater than 2 Days=No Charge<br />
                                less than 2 Days = 50% Service Charge<br />
                                less than 1 Days = 100% Service Charge
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="ccstexth">
                                Test Cost:
                            </td>
                            <td align="right" class="ccstexth">
                                <nobr>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $0.00</nobr>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="ccstexth">
                                <nobr>
                                Agency Fees (Advanced by WoWi, payable to WoWi):</nobr>
                            </td>
                            <td align="right" class="ccstexth">
                                <nobr>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $8,300.00</nobr>
                            </td>
                        </tr>
                        <!--    <tr><td class="ccstexth" align="right"><nobr>Other Fees:</nobr></td><td class="ccstexth" align="right">$0.00</td></tr>  -->
                        <tr>
                            <td align="right" class="ccstexth">
                                <nobr>
                                Total Cost (payable to WoWi):</nobr>
                            </td>
                            <td align="right" class="ccstexth">
                                <nobr>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $8,300.00</nobr>
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
                    <b>Return Sample:&nbsp; Yes-<input name="C2" type="checkbox" value="ON" />&nbsp;No-<input
                        name="C1" type="checkbox" value="ON" /><nobr>&nbsp;If no entry made, No is 
                    assumed</nobr></b>
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
                            <th class="ccstexth" width="50%">
                                Samsung Electronics Co., LTD.
                            </th>
                            <th class="ccstexth" width="50%">
                                WoWi Approval Services Inc.
                            </th>
                        </tr>
                        <tr>
                            <td class="ccstextboxh">
                                By:
                            </td>
                            <td class="ccstextboxh">
                                By:<img border="0" height="31" src="../Images/Quotation/skang.bmp" width="114" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" height="30">
                                Name:
                            </td>
                            <td class="ccstextboxh" height="30">
                                Name:Shirley Kang
                            </td>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" height="30">
                                Title:
                            </td>
                            <td class="ccstextboxh" height="30">
                                Title:Vice President
                            </td>
                        </tr>
                        <tr>
                            <td class="ccstextboxh" height="30">
                                Date:
                            </td>
                            <td class="ccstextboxh" height="30">
                                Date:6/17/2010
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
                    *This quote is valid for 30 days from the day of issuance. Testing must begin within
                    30 days of the quote being accepted. All projected costs, relating to Product Safety
                    testing, are based on the assumption that all relevant components bear requisite
                    safety approvals, unless otherwise stipulated. Projected costs assume completion
                    of all paperwork within 180 days of inception. Any projects not completed within
                    180 days will be requoted for balance of requirements
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
