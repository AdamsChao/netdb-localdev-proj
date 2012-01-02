using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// SQLUtil 的摘要描述
/// </summary>
public class SQLUtil
{
	public SQLUtil()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

        //資料庫連接字符串(web.config)
    public static readonly string CS = ConfigurationManager.ConnectionStrings["WoWiConnectionString"].ConnectionString;

    /// <summary>
    /// 執行SQL語句，回傳影響的資料筆數
    /// </summary>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>影響的資料筆數</returns>
    public static int ExecuteSql(SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(CS))
        {
            cmd.Connection = cn;
            cn.Open();
            int intRows = cmd.ExecuteNonQuery();
            cn.Close();
            return intRows;
        }
    }

    /// <summary>
    /// 執行SQL語句，回傳影響的資料筆數
    /// </summary>
    /// <param name="strConn">連線字串</param>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>影響的資料筆數</returns>
    public static int ExecuteSql(string strConn, SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(strConn))
        {
            cmd.Connection = cn;
            cn.Open();
            int intRows = cmd.ExecuteNonQuery();
            cn.Close();
            return intRows;
        }
    }

    /// <summary>
    /// 執行SQL語句，回傳結果
    /// </summary>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>影響的資料筆數</returns>
    public static object ExecuteScalar(SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(CS))
        {
            cmd.Connection = cn;
            cn.Open();
            object obj = cmd.ExecuteScalar();
            cn.Close();
            return obj;
        }
    }

    /// <summary>
    /// 執行SQL語句，回傳結果
    /// </summary>
    /// <param name="strConn">連線字串</param>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>影響的資料筆數</returns>
    public static object ExecuteScalar(string strConn, SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(strConn))
        {
            cmd.Connection = cn;
            cn.Open();
            object obj = cmd.ExecuteScalar();
            cn.Close();
            return obj;
        }
    }

    /// <summary>
    /// 執行查詢語句，回傳DataSet
    /// </summary>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>DataSet</returns>
    public static DataSet QueryDS(SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(CS))
        {
            cmd.Connection = cn;
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }
    }

    /// <summary>
    /// 執行查詢語句，回傳DataSet
    /// </summary>
    /// <param name="strConn">連線字串</param>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>DataSet</returns>
    public static DataSet QueryDS(string strConn, SqlCommand cmd)
    {
        using (SqlConnection cn = new SqlConnection(strConn))
        {
            cmd.Connection = cn;
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();
                try
                {
                    da.Fill(ds);
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                return ds;
            }
        }
    }

    /// <summary>
    /// 執行查詢語句，回傳SqlDataReader
    /// </summary>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader QueryDR(SqlCommand cmd)
    {
        SqlConnection cn = new SqlConnection(CS);
        SqlDataReader dr;
        try
        {
            cmd.Connection = cn;
            cn.Open();
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            throw new Exception(ex.Message);
        }
        return dr;
    }

    /// <summary>
    /// 執行查詢語句，回傳SqlDataReader
    /// </summary>
    /// <param name="strConn">連線字串</param>
    /// <param name="cmd">SqlCommand</param>
    /// <returns>SqlDataReader</returns>
    public static SqlDataReader QueryDR(string strConn, SqlCommand cmd)
    {
        SqlConnection cn = new SqlConnection(strConn);
        SqlDataReader dr;
        try
        {
            cmd.Connection = cn;
            cn.Open();
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        }
        catch (System.Data.SqlClient.SqlException ex)
        {
            throw new Exception(ex.Message);
        }
        return dr;
    }


}