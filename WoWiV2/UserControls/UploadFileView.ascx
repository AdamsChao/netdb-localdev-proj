<%@ Control Language="C#" ClassName="UploadFileView" %>

<script runat="server">
    
    public bool Enabled { set {  FileGV.Enabled = value; } }

    protected void delBtn_Click(object sender, EventArgs e)
    {

        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        foreach (GridViewRow row in FileGV.Rows)
        {
            if ((row.FindControl("cbDel") as CheckBox).Checked)
            {
                row.Visible = false;
                //delete File
                try
                {
                    String delFileName = (row.FindControl("lblFileName") as Label).Text;
                    System.IO.File.Delete(UpPath + "/" + delFileName);
                }
                catch (Exception)
                {
                    
                    //throw;
                }
               
            }
            else
            {

            }
        }
        System.IO.DirectoryInfo d = new System.IO.DirectoryInfo(UpPath);
        System.IO.FileInfo[] list = d.GetFiles();
        if (list.Count() == 0)
        {
            FileGV.Visible = false;
        }
        else
        {
            FileGV.Visible = true;
            FileGV.DataSource = list;
            FileGV.DataBind();
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Page.IsPostBack) return;
        String UpPath = ConfigurationManager.AppSettings["UploadFolderPath"];
        String prid = Request.QueryString["id"];
        UpPath = UpPath + "/PR/" + prid;
        System.IO.DirectoryInfo d = new System.IO.DirectoryInfo(UpPath);
        System.IO.FileInfo[] list = d.GetFiles();
        if (list.Count() == 0)
        {
            FileGV.Visible = false;
        }
        else
        {
            FileGV.Visible = true;
            FileGV.DataSource = list;
            FileGV.DataBind();
        }
    }

    protected void FileGV_PreRender(object sender, EventArgs e)
    {
        String prid = Request.QueryString["id"];
        foreach (GridViewRow row in FileGV.Rows)
        {

            HyperLink link  = (row.FindControl("fileLink") as HyperLink);
            link.NavigateUrl += "&id="+prid ;
        }
    }
</script>
<asp:GridView ID="FileGV" runat="server" Width="100%" 
    AutoGenerateColumns="False" onprerender="FileGV_PreRender">
                                  <Columns>
                                   <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <HeaderTemplate>
                                    <asp:Button ID="delBtn" runat="server" Text="Delete" onclick="delBtn_Click" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbDel" runat="server" CssClass="cbDel" /><asp:Label ID="lblFileName" runat="server" Text='<%# Eval("Name") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="File Name" SortExpression="Name" />
           <%--                 <asp:BoundField DataField="Extension" HeaderText="副檔名" SortExpression="Extension" />--%>
                            <asp:BoundField DataField="CreationTime"  HeaderText="Upload Time" SortExpression="CreationTime" />
                            <asp:TemplateField>
                                <HeaderTemplate>
                                   File Download
                                </HeaderTemplate>
                                <ItemTemplate>
                                <asp:HyperLink ID="fileLink" runat="server" 
                            NavigateUrl='<%# Bind("Name","~/Accounting/FileListHandler.ashx?fn={0}") %>'>Download</asp:HyperLink>
                                 </ItemTemplate>
                            </asp:TemplateField>
        </Columns>
                                           </asp:GridView>