using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Win32.SafeHandles;
using System.Net;
using System.Net.Mail;

namespace CakeOrderDeliverySystem
{
    public partial class resetPassword : System.Web.UI.Page
    {
        SqlConnection conn;
        string strCon = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void resetbtn_Click(object sender, EventArgs e)
        {
            using (conn = new SqlConnection(strCon))
            {
                string UserId = Request.QueryString["UserId"].ToString();
                if (txtNewPassword.Text.Trim() == txtConfirmPassword.Text.Trim())
                {
                    conn.Open();
                    string updateUser = "UPDATE [aspnet_Membership] SET Password=@Password WHERE UserId=@UserId";
                    SqlCommand cmdUpdate = new SqlCommand(updateUser, conn);
                    cmdUpdate.Parameters.AddWithValue("@Password", txtNewPassword.Text.Trim());
                    cmdUpdate.Parameters.AddWithValue("@UserId", UserId);
                    int rowsAffected = cmdUpdate.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblErrorMsg.Text = "Password reset successfully";
                        lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblErrorMsg.Text = "Failed to reset password. Please try again.";
                        lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                    }


                    conn.Close();
                }


                else
                {
                    lblErrorMsg.Text = "New password and confirm password is not match!";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                }

            }
        }
    }
}