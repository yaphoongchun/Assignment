using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Admin
{
    public partial class userManage : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
        static SqlConnection connection = new SqlConnection(connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        //go button
        protected void LinkButton4_Click(object sender, EventArgs e) 
        {
            getUsername();
        }

        //user defined function 
        protected void getUsername() 
        {
            try
            {
                connection.Open();

                SqlCommand usernamecmd = new SqlCommand("SELECT * FROM aspnet_Membership WHERE UserId = (SELECT UserId FROM aspnet_Users WHERE UserName = @Username)", connection);
                usernamecmd.Parameters.AddWithValue("@Username", TextBox1.Text.Trim());
                SqlDataReader dr = usernamecmd.ExecuteReader();

                if (dr.HasRows) 
                {
                    while(dr.Read()) 
                    {
                        //retrieve account status
                        bool isApproved = Convert.ToBoolean(dr["IsApproved"]);

                        string status = isApproved ? "Active" : "Inactive";
                    }
                }
                else 
                {
                    Response.Write("<script>alert('Invalid');</script>");
                }




                connection.Close();


            }
            catch (Exception ex)
            {

            }
        }
    }
}