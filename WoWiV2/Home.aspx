<%@ Page Title="首頁" Language="C#" MasterPageFile="~/SiteMaster.master" AutoEventWireup="true"
  CodeFile="Home.aspx.cs" Inherits="Home" Culture="en-US" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
  <table>
    <tr valign="top">
      <td>
        <asp:Calendar ID="Calendar1" runat="server">
        </asp:Calendar>
        <div class="div-inline">
          <%--<asp:Image ID="imgHoliday" runat="server" ImageUrl="~/Images/merry-christmas.jpg"  Width="500" />--%>
        </div>
      </td>
      <td>
        <div class="div-inline">
          Found in 2009, WoWi’s goal is to go beyond what we already offer to providing approval
          services world-wide.
          <p />
          Product Type:
          <ul>
            <li>Radio/Wireless - Low Power and Short Range Devices</li>
            <li>Radio/Wireless - Unlicensed and Licensed Devices</li>
            <li>Safety - ITE/ Digital Devices</li>
            <li>EMC- ITE / Digital Devices</li>
            <li>Wired Telecommunication Devices</li>
          </ul>
          <p />
          Countries Covered:
          <br />
          <ul>
            <li>North Americas / South America / Asia Pacific / Europe / MIDDLE EAST AFRICA</li>
          </ul>
        </div>
      </td>
    </tr>
  </table>
</asp:Content>
