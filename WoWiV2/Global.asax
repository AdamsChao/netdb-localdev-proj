<%@ Application Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // 應用程式啟動時執行的程式碼

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  應用程式關閉時執行的程式碼

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // 發生未處理錯誤時執行的程式碼

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // 啟動新工作階段時執行的程式碼

    }

    void Session_End(object sender, EventArgs e) 
    {
        // 工作階段結束時執行的程式碼。 
        // 注意: 只有在 Web.config 檔將 sessionstate 模式設定為 InProc 時，
        // 才會引發 Session_End 事件。如果將工作階段模式設定為 StateServer 
        // 或 SQLServer，就不會引發這個事件。

    }

    protected string GetUserGroup()
    {
        string role = string.Empty;
        SqlConnection cn =
                  new SqlConnection((ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString));
        try
        {
            SqlCommand cmd = new SqlCommand("Select name from department inner join employee on department.id=employee.department_id where employee.username = @UserName", cn);
            cmd.Parameters.AddWithValue("@UserName", User.Identity.Name);
            cn.Open();
            role = (string)cmd.ExecuteScalar();
            cn.Close();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            if (cn.State == System.Data.ConnectionState.Open)
            {
                cn.Close();
            }
        }

        return role;

    }

    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {
        if (User == null)
        {
            return;
        }

        //string[] roles = new string[] { GetUserGroup() };
        //string[] roles = new string[] { User.Identity.Name };
        //System.Security.Principal.GenericPrincipal gp =
        //  new System.Security.Principal.GenericPrincipal(User.Identity, roles);
        //Context.User = gp;
    }
       
</script>
