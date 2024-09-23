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
    public partial class forgotPassword : System.Web.UI.Page
    {
        SqlConnection conn;
        string strCon = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void forgotbtn_Click(object sender, EventArgs e)
        {
            using (conn = new SqlConnection(strCon))
            {
                conn.Open();
                string selectUser = "SELECT UserId FROM [aspnet_Membership] WHERE Email=@Email AND IsApproved=1";
                SqlCommand selCmd = new SqlCommand(selectUser, conn);
                selCmd.Parameters.AddWithValue("@Email", email.Text.Trim());
                SqlDataReader read = selCmd.ExecuteReader();

                if (read.Read())
                {
                    string userId = read["UserId"].ToString();

                    MailMessage mail = new MailMessage();
                    mail.To.Add(email.Text.ToString());
                    mail.From = new MailAddress("noreply.cake@gmail.com");
                    mail.Subject = "Reset password link";

                    string emailBody = "";
                    emailBody += "<h3>Hello fellow user,</h3>";
                    emailBody += "Please click the below link to reset your password.<br />";
                    emailBody += "<p><a href='" + "https://localhost:44311/resetPassword.aspx?userId=" + userId + "'>click here to Reset Password</a></p>";
                    emailBody += "Thank you! Have a nice day.";

                    mail.Body = emailBody;
                    mail.IsBodyHtml = true;

                    using (SmtpClient smtp = new SmtpClient())
                    {
                        smtp.Port = 587; //25 465
                        smtp.EnableSsl = true;
                        smtp.UseDefaultCredentials = false;
                        smtp.Host = "smtp.gmail.com";
                        smtp.Credentials = new NetworkCredential()
                        {
                          //  UserName = "deborahj-wm21@student.tarc.edu.my",
                            //Password = "gvqn yago rqrf lfar"
                            UserName = "interestingcakedelivery@gmail.com",
                            Password = "rlzx oqbo fmnp jlxr"

                        };

                        smtp.Send(mail);
                    }

                    lblErrorMsg.Text = "Reset Password link sent successfully.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                    conn.Close();

                }
                else
                {
                    lblErrorMsg.Text = "Your email is not associated with us.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                    conn.Close();
                }

            }

        }
    }
}