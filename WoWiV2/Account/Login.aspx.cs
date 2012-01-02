using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
    }
    protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e)
    {
        using (SqlConnection cn =
            new SqlConnection(ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString))
        {
            cn.Open();
            SqlCommand cmd =
                new SqlCommand("Select username from employee Where username=@username and password=@password", cn);
            cmd.Parameters.AddWithValue("@username", LoginUser.UserName);
            cmd.Parameters.AddWithValue("@password", LoginUser.Password);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string username = dr["username"].ToString();
                    FormsAuthentication.RedirectFromLoginPage(username, false);
                }
            }
        }
    }
}
