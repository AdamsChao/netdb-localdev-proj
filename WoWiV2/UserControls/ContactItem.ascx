<%@ Control Language="C#" ClassName="ContactItem" %>

<script runat="server">

    public String BaseURL { get; set; }
    public String EditURL { get; set; }
    protected void Page_Init(object sender, EventArgs e)
    {
        WoWiModel.contact_info con = (WoWiModel.contact_info)ViewState["WoWiModel.contact_info"];
        if (con != null)
        {
            BaseURL = "~/Common/ContactDetails.aspx";
            HyperLink1.Text = con.fname + " " + con.lname;
            HyperLink1.NavigateUrl = String.Format("{0}?id={1}", BaseURL, con.id);
            Label2.Text = con.workphone + " ext. " + con.ext;
            Label4.Text = con.email;
            
        }
        if (ViewState["ContactItem_Image_Flag"] != null)
        {
            ImageButton1.Visible = true;
        }
        EditURL = "~/Common/UpadteContact.aspx";
        ViewState.Remove("WoWiModel.contact_info");
        ViewState.Remove("ContactItem_Image_Flag");
    }

   

    protected void ImageButton_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(EditURL);
    }

   
</script>
<span>
<asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
<asp:ImageButton ID="ImageButton1" runat="server" 
    ImageUrl="~/Images/note.jpg" Visible="False" 
    onclick="ImageButton_Click" />
<br />
<asp:Label ID="Label1" runat="server" Text="Tel : "></asp:Label>
<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label><br />
<asp:Label ID="Label3" runat="server" Text="Email : "></asp:Label><asp:Label ID="Label4"
    runat="server" Text="Label"></asp:Label>
    </span>



