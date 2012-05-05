<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationViewPrintChinese.aspx.cs"
    Inherits="Sales_QuotationViewPrintChinese" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .ccstextboxh
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 600;
        }
        .ccsh1
        {
            font-style: normal;
            font-family: Times New Roman;
            color: rgb(0,0,0);
            font-size: 12pt;
            font-weight: 700;
        }
        .ccstexth
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 500;
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
        .csstextboxrd
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #dddddd;
            font-size: 9pt;
        }
        .ccstexth
        {
            text-align: left;
        }
        .style1
        {
            text-decoration: underline;
        }
        .style2
        {
            font-style: normal;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            color: rgb(0,0,0);
            font-size: 8pt;
            font-weight: 500;
            text-align: left;
            width: 300px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <%--<tr>
            <td align="right" class="ccstextboxh" colspan="3" height="15" valign="top">
                Page 1 of 2
            </td>
        </tr>--%>
        <tr>
            <td align="left">
                <img border="0" height="90" src="../Images/Quotation/WoWilogoname.jpg" />
            </td>
            <td align="middle" class="ccsh1">
                <font face="verdana" size="3">康來士科技顧問股份有限公司</font><br />
                <font face="verdana" size="1">
                <br />
                114台北市內湖區洲子街79號3 樓<br />
                    電話: 886-2-2799-8382
                    <br />
                    傳真: 886-2-2799-8387<br />
                    網站: www.WoWiApproval.com</font>
            </td>
            <td align="right">
                <img border="0" height="56" src="../Images/Quotation/transparent.gif" width="168" />
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccsh1" colspan="3" valign="top">
                報價單號
                <asp:Label ID="lblQuotationNo" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="left" class="ccstextboxh" width="60%">
                報價人員:
                <asp:Label ID="lblRepresentative" runat="server" Text="lblRepresentative"></asp:Label>
            </td>
            <td rowspan="2">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="left" class="ccstextboxh">
                            連絡電話:
                        </td>
                        <td align="left" class="ccstextboxh">
                            <nobr>
                            <asp:Label ID="lblTel" runat="server" Text="lblTel"></asp:Label></nobr>
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
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" class="ccstextboxh">
                報價日期:&nbsp;<asp:Label ID="lblDate" runat="server" Text="lblDate"></asp:Label>
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
                關於 貴公司詢問之產品服務提供報價如下，謹請指教，請確認服務的項目及產品資訊是否正確，確認無誤後,於客戶確認欄上簽名(含日期)用印,並回傳至本公司，即視為完成此確認程序。<br />
                *此報價單為報價日7天內為有效期.
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <hr noshade size="1" />
            </td>
        </tr>
        <tr>
            <td class="style2" valign="top">
                <u>產品資訊</u><br />
                <br />
                產品名稱:
                <asp:Label ID="lblCProduct_Name" runat="server" Text="lblCProduct_Name"></asp:Label>
                <br />
                Product Name :
                <asp:Label ID="lblProduct_Name" runat="server"></asp:Label>
                 <br />
                產品商標:
                    <asp:Label ID="lblCBrand_Name" runat="server" Text="lblCBrand_Name"></asp:Label>
                    <br />
                    Brand Name :
                    <asp:Label ID="lblBrand_Name" runat="server"></asp:Label>
                     <br />
                     產品型號:
                        <asp:Label ID="lblCModel_No" runat="server" Text="lblCModel_No"></asp:Label>
                        <br />
                        Model No :
                        <asp:Label ID="lblModelNo" runat="server"></asp:Label>
            </td>
            <td class="ccstexth" align="right">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" colspan="2">
                            <nobr>
                            <u>申請者資訊</u>
                            </nobr>
                        </td>
                    </tr>
                    <tr><td></td></tr>
                    <tr>
                        <td align="left">
                            申請公司:
                        </td>
                        <td align="left" >
                            <nobr>
                            <asp:Label ID="lblBill_Companyname" runat="server"></asp:Label></nobr>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td align="left" >
                            申請公司統一編號:
                        </td>
                        <td align="left" >
                            <nobr>
                            <asp:Label ID="lblbusiness_registration_number" runat="server" Text="lblbusiness_registration_number"></asp:Label></nobr>
                        </td>
                    </tr>--%>
                    <tr>
                        <td align="left">
                            申請人:
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblBill_CName" runat="server" Text="lblBill_CName"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left"  valign="top">
                            連絡電話:
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblBill_Phone" runat="server" Text="lblBill_Phone"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" valign="top">
                            連絡地址:
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblClientAddress" runat="server" Text="lblClientAddress"></asp:Label>
                            <br />
                            <asp:Label ID="lblCleintCountry" runat="server" Text="lblCleintCountry"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left"  valign="top">
                            Email:
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblBill_Email" runat="server" Text="lblBill_Email"></asp:Label>
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
                            服務項目:
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
                                Width="100%" CaptionAlign="Top" ShowFooter="True" Style="text-align: left" 
                              Font-Size="Smaller">
                                <Columns>
                                    <asp:TemplateField HeaderText="項次">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1 %>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="country_name" HeaderText="申請國家" SortExpression="country_name">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="authority_name" HeaderText="認證標準" SortExpression="authority_name">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FinalPrice" HeaderText="價格(未稅)" SortExpression="FinalPrice">
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="說明" SortExpression="target_description">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" 
                                                Text='<%# Bind("target_description") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("target_description") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                                SelectCommand="SELECT [country_name], [authority_name], [FinalPrice], [target_description] FROM [vw_Test_Target_List] WHERE ([Quotation_Version_Id] = @Quotation_Version_Id)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hidQuotationID" Name="Quotation_Version_Id" PropertyName="Text"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                    <td class="ccstextboxh">
                      小計費用: NT$<asp:Literal ID="ltlsub_total" runat="server" Text=""></asp:Literal>(未稅)
                        <br />
                      折扣費用: NT$<asp:Literal ID="ltldiscount" runat="server" Text=""></asp:Literal>(未稅)
                        <br />
                      合計費用: NT$<asp:Literal ID="ltltotal" 
                            runat="server" Text=""></asp:Literal>(未稅)
                        <br />
                      5%營業稅:NT$ <asp:Literal ID="ltl5persert" 
                            runat="server" Text=""></asp:Literal>
                        <br />
                      總計費用: NT$<asp:Literal ID="ltlsum" runat="server" Text=""></asp:Literal>(含稅)
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
            <td class="ccstexth" colspan="2">
                <!-- start cost summary service -->
            </td>
        </tr>
        <!-- end cost summary service -->
    </table>
    
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td class="ccstexth" colspan="2">
                備 註：
                <br />
                1. 本報價單視為合作契約，故請簽回報價時確認其產品之資訊/申請項目/標準/價格之正確性，有任何修改請事先更正作業。
                <br />
                2. 服務企劃書簽立且與認證單位開案後，委任人因故取消委任時，委任人同意支付受任人代付之規費和相關費用；若服務企劃書簽立且受任人已完成認證後，委任人因故取消委任時， 則委任人同意支付受任人全額費用。
                <br />
                3. 上列委託項目，本公司得就已完工結案部分之認證國家別分別開立發票收取服務費用。
                <br />
                4. 工作天數以收到完整樣品及所需文件時開始計算。
            </td>
        </tr>
        <tr>
            <td align="middle" class="ccstexth" colspan="2">
                <br />
            </td>
        </tr>
        <tr>
            <td class="ccstexth" colspan="2">
                <!-- start cost summary service -->
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td class="ccstextboxh" rowspan="5" width="100%">
                            <u><strong>付款條件:</strong></u><br />
                            依發票開立日起之 Payment_days 天內，以 （電匯/即期支票/現金） 付清款項。
                            <br />
                            倘若未依上列付款條件支付款項時，康來士科技顧問股份有限公司將保留暫停提供服務的權利，直到逾期欠款清償為止。
                            <br />
                            <br />
                            <strong>樣品處理方式:
                                <br />
                            </strong>□申請者自行取回 □快遞寄送(運費由客戶負擔) □依本公司流程處理
                            <br />
                            *因樣品會有搬運或拆裝之動作發生，如有特殊要求請事先於特別聲明註明，否則本公司無法保證樣品之完整性。
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <!-- end cost summary service -->
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
                        <th class="ccstextboxh" width="50%">
                            委任人:
                        </th>
                        <th class="ccstextboxh" width="50%">
                            受任人: 康來士科技顧問股份有限公司
                        </th>
                    </tr>
                    <tr>
                        <td class="style1">
                            <br />
                            <asp:Label ID="lblClient" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
                            <br />
                            
                        </td>
                        <td class="ccstextboxh">
                            <asp:Image ID="imgSign" runat="server" Height="31" Width="114" />
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td class="ccstextboxh" height="30">
                            簽署人:
                        </td>
                        <td class="ccstextboxh" height="30">
                            簽署人:
                            <asp:Label ID="lblRepresentative1" runat="server" Text="lblRepresentative"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ccstextboxh" height="30">
                            職稱:
                        </td>
                        <td class="ccstextboxh" height="30">
                            職稱:<asp:Label ID="lblTitle" runat="server" Text="lblTitle"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ccstextboxh" height="30">
                            簽署日期:
                        </td>
                        <td class="ccstextboxh" height="30">
                            簽署日期:<asp:Label ID="lblDate1" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="ccstextboxh" height="30">
                            &lt;&lt;大小章/公司發票章/均可&gt;&gt;
                        </td>
                        <td class="ccstextboxh" height="30">
                            審核:
                        </td>
                    </tr>
                    <tr>
                        <td class="ccstextboxh" height="30">
                            &nbsp;
                        </td>
                        <td class="ccstextboxh" height="30">
                            核准:
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
    </table>
    <!-- end body -->
    
    <asp:TextBox ID="hidQuotationID" runat="server" Text="0" Visible="false"></asp:TextBox>
    <asp:TextBox ID="hidQuotation_No" runat="server" Text="0" Visible="false"></asp:TextBox>
    </form>
</body>
</html>
