<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImaContactDetail.aspx.cs"
    Inherits="Ima_ImaContactDetail" StylesheetTheme="IMA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/DenyPageCopy.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" width="800px" align="center" class="tbEditItem" align="center">
        <tr>
            <td colspan="2" class="tdHeader" align="center">
                Contact Detail
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                First Name：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblFirstName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Last Name：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblLastName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Title：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblTitle" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Work Phone：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblWorkPhone" runat="server"></asp:Label>
                &nbsp;&nbsp;&nbsp; EXT：<asp:Label ID="lblExt" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Fax：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblFax" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Cell Phone：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblCellPhone" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Email：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Adress：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblAdress" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Country：
            </td>
            <td class="tdRowValue">
                <asp:DropDownList ID="ddlCountry" runat="server" DataSourceID="sdsCountry" DataTextField="country_name"
                    DataValueField="country_id" Enabled="false">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCountry" runat="server" ConnectionString="<%$ ConnectionStrings:WoWiConnectionString %>"
                    SelectCommand="SELECT DISTINCT [country_name], [country_id] FROM [country]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Lead Time：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblLeadTime" runat="server"></asp:Label>&nbsp;Weeks
            </td>
        </tr>
        <tr>
            <td class="tdRowName">
                Remark：
            </td>
            <td class="tdRowValue">
                <asp:Label ID="lblRemark" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
