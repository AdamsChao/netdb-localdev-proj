<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CertificateMail.aspx.cs"
  Inherits="Project_CertificateMail" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
</head>
<body>
  <form id="form1" runat="server">
  <div>
    <asp:Panel ID="PanelMail" runat="server">
      <asp:Label ID="lbl_msg" runat="server" Text="這是由系統自動發出的 Certificate Renewal Alert，請相關負責人員注意下列表中 Target 之 Renewal 時間"/>
      <asp:GridView ID="GridViewProjectTarget" runat="server" AutoGenerateColumns="False"
        DataKeyNames="Quotation_Target_Id" DataSourceID="SqlDataSourceTarget" PageSize="20"
        Width="100%" EmptyDataText="No Data!" 
        OnRowDataBound="GridViewProjectTarget_RowDataBound" EnableTheming="False">
        <Columns>
          <asp:TemplateField HeaderText="ID" InsertVisible="False" Visible="False">
            <ItemTemplate>
              <asp:Label ID="LabelTarget" runat="server" Text='<%# Bind("Quotation_Target_Id") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Project No" SortExpression="Project_No">
            <ItemTemplate>
              <asp:Label ID="LabelNo" runat="server" Text='<%# Bind("Project_No") %>'></asp:Label>
              <asp:HiddenField ID="HFCountry" runat="server" Value='<%# Bind("country_id") %>' />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="world_region_name" HeaderText="Region" Visible="False" />
          <asp:BoundField DataField="country_name" HeaderText="Country" SortExpression="country_name" />
          <asp:BoundField DataField="authority_name" HeaderText="Target" SortExpression="authority_name" />
          <asp:BoundField DataField="Client" HeaderText="Client" SortExpression="Client" />
          <asp:BoundField DataField="Model_No" HeaderText="Model No." />
          <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
          <asp:BoundField DataField="target_description" HeaderText="T.Description" Visible="True" />
          <asp:BoundField DataField="test_started" HeaderText="Test Started" SortExpression="test_started"
            Visible="True" DataFormatString="{0:d}" />
          <asp:BoundField DataField="test_completed" HeaderText="Test Completed" SortExpression="test_completed"
            Visible="True" DataFormatString="{0:d}" />
          <asp:BoundField DataField="certification_submit_to_authority" HeaderText="Certification Submit To Authority"
            Visible="True" SortExpression="certification_submit_to_authority" DataFormatString="{0:d}" />
          <asp:BoundField DataField="certification_completed" HeaderText="Certification Completed"
            Visible="True" SortExpression="certification_completed" DataFormatString="{0:d}" />
          <asp:BoundField DataField="Estimated_Lead_time" HeaderText="Estimated Lead Time"
            SortExpression="Estimated_Lead_time" Visible="True" />
          <asp:BoundField DataField="Actual_Lead_time" HeaderText="Actual Lead Time" Visible="True" />
          <asp:TemplateField HeaderText="Agent" SortExpression="Agent" Visible="False">
            <EditItemTemplate>
              <asp:TextBox ID="TextBoxAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelAgent" runat="server" Text='<%# Bind("Agent") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Country Manager" Visible="False">
            <EditItemTemplate>
              <asp:Label ID="LabelCM" runat="server" Text='<%# Eval("CountryManager") %>'></asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
              <asp:Label ID="LabelCM0" runat="server" Text='<%# Bind("CountryManager") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="AE" HeaderText="AE" SortExpression="AE" Visible="False" />
          <asp:BoundField DataField="certificate_type" HeaderText="Certification Type" />
          <asp:TemplateField HeaderText="Certificate Issue Date">
            <ItemTemplate>
              <asp:Label ID="lbl_certificate_issue_date" runat="server" Text='<%# Bind("certificate_issue_date", "{0:d}") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certificate Expiry Date">
            <ItemTemplate>
              <asp:Label ID="lbl_certificate_expiry_date" runat="server" Text='<%# Bind("certificate_expiry_date", "{0:d}") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Certificate Duration">
            <ItemTemplate>
              <asp:Label ID="lbl_certificate_duration" runat="server"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Time until Expiration">
            <ItemTemplate>
              <asp:Label ID="lbl_time_until_expiration" runat="server"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Today's Date">
            <ItemTemplate>
              <asp:Label ID="lbl_today_date" runat="server"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="email_renewal_notice_date" HeaderText="Email Renewal Notice Date"
            DataFormatString="{0:d}" Visible="False" />
          <asp:TemplateField HeaderText="Renewal Confirmation Check">
            <ItemTemplate>
              <asp:Label ID="lbl_renewal_confirmation_check" runat="server" Text='<%# Bind("renewal_confirmation_check") %>'></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:BoundField DataField="conduct_renewal_action_date" HeaderText="Conduct Renewal Action Date"
            DataFormatString="{0:d}" />
        </Columns>
      </asp:GridView>
    </asp:Panel>
    <asp:SqlDataSource ID="SqlDataSourceTarget" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
      
      SelectCommand="SELECT Quotation_Target.Quotation_Target_Id, Quotation_Target.quotation_id, Quotation_Target.target_id, Quotation_Target.target_description, Quotation_Target.country_id, Quotation_Target.product_type_id, Quotation_Target.authority_id, Quotation_Target.technology_id, Quotation_Target.target_rate, Quotation_Target.unit, Quotation_Target.unit_price, Quotation_Target.discount_type, Quotation_Target.discValue1, Quotation_Target.discValue2, Quotation_Target.discPrice, Quotation_Target.FinalPrice, Quotation_Target.PayTo, Quotation_Target.Status, Quotation_Target.Bill, Quotation_Target.option1, Quotation_Target.option2, Quotation_Target.advance1, Quotation_Target.advance2, Quotation_Target.balance1, Quotation_Target.balance2,Country_Manager 
, Quotation_Target.test_started, Quotation_Target.test_completed, Quotation_Target.certification_submit_to_authority, Quotation_Target.certification_completed, Quotation_Target.Estimated_Lead_time, Quotation_Target.Actual_Lead_time, Quotation_Target.Agent 
, country.country_name, Authority.authority_name ,world_region.world_region_name 
, (Select fname + ' ' + lname as cmname from employee where id = Country_Manager ) as CountryManager 
, Project.Project_Id, Project.Project_No, Project.Project_Status , Quotation_Version.Model_No 
, SalesId , Employee.fname + ' ' + lname  as 'AE' 
, Client_Id , clientapplicant.companyname as 'Client' 
, [certificate_type],[certificate_issue_date],[certificate_expiry_date]
, [email_renewal_notice_date],[renewal_confirmation_check],[conduct_renewal_action_date]
FROM Quotation_Target 
INNER JOIN country ON Quotation_Target.country_id = country.country_id 
INNER JOIN world_region ON world_region.world_region_id = country.world_region_id
INNER JOIN Authority ON Quotation_Target.authority_id = Authority.authority_id 
INNER JOIN Quotation_Version ON Quotation_Version.Quotation_Version_Id = Quotation_Target.quotation_id AND Quotation_Status=5
INNER JOIN Project ON Project.Quotation_No = Quotation_Version.Quotation_No
INNER JOIN Employee ON Employee.id = Quotation_Version.SalesId
INNER JOIN clientapplicant ON Quotation_Version.Client_Id = clientapplicant.id 
WHERE  (Quotation_Target.Status = 'Done' OR Quotation_Target.Status = 'Delay')
AND (renewal_confirmation_check = '0')
AND (Quotation_Target.email_renewal_notice_date &lt; getdate()) " 
      onselecting="SqlDataSourceTarget_Selecting">
    </asp:SqlDataSource>
  </div>
  </form>
</body>
</html>
