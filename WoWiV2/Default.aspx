<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
  protected void Page_Load(object sender, EventArgs e)
  {
    if (!Page.IsPostBack)
    {
      try
      {
        Response.Redirect("~/Home.aspx");
      }
      catch (Exception)
      {

      }
    }
  }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title>WoWi Approval System</title>
</head>
<body>
  <div class="wrapper">
  </div>
</body>
</html>
