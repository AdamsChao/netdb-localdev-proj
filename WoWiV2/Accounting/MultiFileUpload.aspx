﻿<%@ Page Language="C#"%>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
    String UpPath;
    String prid;
    bool closeWin;
    protected void Page_Load(object sender, EventArgs e)
    {
        UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        if (!Page.IsPostBack)
        {
            if (!Directory.Exists(UpPath))
            {
                Directory.CreateDirectory(UpPath);
            }
        }
        PlaceHolder1.Controls.Clear();
        if (System.IO.Directory.Exists(UpPath))
        {
            String[] list = Directory.GetFiles(UpPath);
            foreach (String item in list)
            {
                HyperLink link = new HyperLink();
                int idx = item.LastIndexOf("\\");
                String fileName = item.Substring(idx + 1);
                link.NavigateUrl = "~/Accounting/FileListHandler.ashx?id=" + prid + "&fn=" + fileName;
                link.Text = fileName;
                PlaceHolder1.Controls.Add(link);
                Label lb = new Label();
                lb.Text = "<br>";
                PlaceHolder1.Controls.Add(lb);
            }
            PlaceHolder1.Visible = true;
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        PlaceHolder1.Controls.Clear();
        HttpFileCollection uploads = HttpContext.Current.Request.Files;
        for (int i = 0; i < uploads.Count; i++)
        {
            HttpPostedFile upload = uploads[i];

            if (upload.ContentLength == 0)
                continue;

            string c = System.IO.Path.GetFileName(upload.FileName); // We don't need the path, just the name.

            try
            {
                upload.SaveAs(UpPath + "/" + c);
                Span1.InnerHtml = "Upload(s) Successful.";
                closeWin = true;
            }
            catch (Exception Exp)
            {
                Span1.InnerHtml = "Upload(s) failed.";
            }
        }
        if (System.IO.Directory.Exists(UpPath))
        {
            String[] list = Directory.GetFiles(UpPath);
            foreach (String item in list)
            {
                HyperLink link = new HyperLink();
                int idx = item.LastIndexOf("\\");
                String fileName = item.Substring(idx + 1);
                link.NavigateUrl = "~/Accounting/FileListHandler.ashx?id=" + prid + "&fn=" + fileName;
                link.Text = fileName;
                PlaceHolder1.Controls.Add(link);
                Label lb = new Label();
                lb.Text = "<br>";
                PlaceHolder1.Controls.Add(lb);
            }
            PlaceHolder1.Visible = true;
        }
    }

    protected void PlaceHolder1_Load(object sender, EventArgs e)
    {
        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        if (System.IO.Directory.Exists(UpPath))
        {
            try
            {
                PlaceHolder1.Controls.Clear();
                Control con = Page.LoadControl("~/UserControls/UploadFileView.ascx");
                PlaceHolder1.Controls.Add(con);
                PlaceHolder1.Visible = true;
            }
            catch (Exception)
            {

                //throw;
            }


        }
    }
 
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Multi Files Upload</title>
    <script type="text/javascript">
        function addFileUploadBox() {
            if (!document.getElementById || !document.createElement)
                return false;

            var uploadArea = document.getElementById("upload-area");

            if (!uploadArea)
                return;

            var newLine = document.createElement("br");
            uploadArea.appendChild(newLine);

            var newUploadBox = document.createElement("input");

            // Set up the new input for file uploads
            newUploadBox.type = "file";
            newUploadBox.size = "60";

            // The new box needs a name and an ID
            if (!addFileUploadBox.lastAssignedId)
                addFileUploadBox.lastAssignedId = 100;

            newUploadBox.setAttribute("id", "dynamic" + addFileUploadBox.lastAssignedId);
            newUploadBox.setAttribute("name", "dynamic:" + addFileUploadBox.lastAssignedId);
            uploadArea.appendChild(newUploadBox);
            addFileUploadBox.lastAssignedId++;
        }
         var flag;
        function closeAndReLoad()
        {
            if (flag) {
                alert("Upload(s) Successful!");
                self.close();
                //opener.window.location = opener.window.location;
                opener.postBack();
            }
        }
</script>
</head>
<body>
<form id="form1" runat="server" enctype="multipart/form-data">
<input id="AddFile" type="button" value="Add file" onclick="addFileUploadBox()" /><asp:Button ID="btnSubmit" runat="server" Text="Upload Now" OnClick="btnSubmit_Click" /><asp:Button ID="Button1" runat="server" onclientclick="self.close();" 
    Text="Close this Window" />
<span id="Span1" runat="server" />
<div id="upload-area">
   <input id="File1" type="file" runat="server" size="60" />  
</div>
File List:<br>
<asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
<%--<asp:PlaceHolder ID="PlaceHolder1" runat="server" OnLoad="PlaceHolder1_Load"></asp:PlaceHolder>--%>

</form>
</body>
</html>

<script type="text/javascript">
    var flag = <%= closeWin.ToString().ToLower() %>;
    closeAndReLoad();
</script>