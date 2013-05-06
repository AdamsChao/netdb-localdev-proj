<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster.master" %>

<%@ Register src="~/UserControls/NPOIExportControl.ascx" tagname="NPOIExportControl" tagprefix="netdb" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
  <netdb:NPOIExportControl ID="NPOIExport" runat="server" 
    SheetName="ProjectReport" TargetGridViewID="gv_project" />
  ( 下列 Project 資料為兩年內 DATA )<asp:GridView ID="gv_project" runat="server" AutoGenerateColumns="False" 
    DataSourceID="SqlDataSource_Project" AllowPaging="True" PageSize="30">
    <Columns>
      <asp:BoundField DataField="Quotation_Target_Id" 
        HeaderText="Quotation_Target_Id" InsertVisible="False" ReadOnly="True" 
        SortExpression="Quotation_Target_Id" Visible="False" />
      <asp:BoundField DataField="country_name" HeaderText="Country" ReadOnly="True" 
        SortExpression="country_name" />
      <asp:BoundField DataField="authority_name" HeaderText="Authority" 
        ReadOnly="True" SortExpression="authority_name" />
      <asp:BoundField DataField="Project No.[Model No.]" 
        HeaderText="Project No.[Model No.]" ReadOnly="True" 
        SortExpression="Project No.[Model No.]" />
      <asp:BoundField DataField="document_ready_to_process" DataFormatString="{0:d}" 
        HeaderText="Document &amp; Sample are ready to be process" 
        SortExpression="document_ready_to_process" />
      <asp:BoundField DataField="certification_completed" DataFormatString="{0:d}" 
        HeaderText="Certification Completed" SortExpression="certification_completed" />
      <asp:BoundField DataField="Actual_Lead_time" 
        HeaderText="Actual Lead Time(Week)" SortExpression="Actual_Lead_time" />
    </Columns>
  </asp:GridView>
  <asp:SqlDataSource ID="SqlDataSource_Project" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>" 
    SelectCommand="SELECT Quotation_Target_Id, 
(SELECT COUNTRY_NAME FROM COUNTRY WHERE COUNTRY_ID=Quotation_Target.country_id) AS country_name,
(SELECT authority_name FROM Authority WHERE Authority.authority_id = Quotation_Target.authority_id ) AS authority_name, 
Project_Id , 
Project_No + ' ['+ (SELECT Model_No FROM Quotation_Version WHERE Quotation_Version.Quotation_Version_Id = PROJECT.Quotation_Id) +']' AS 'Project No.[Model No.]' , 
document_ready_to_process , certification_completed, Actual_Lead_time
FROM PROJECT 
INNER JOIN Quotation_Version ON PROJECT.Quotation_No = Quotation_Version.Quotation_No  AND Quotation_Status=5 
INNER JOIN Quotation_Target ON Quotation_Target.quotation_id = Quotation_Version.Quotation_Version_Id
WHERE PROJECT.Create_Date between DATEADD(year,-2,getdate()) and  DATEADD(year,1,getdate())
Order by country_name , authority_name ">
  </asp:SqlDataSource>
</asp:Content>

