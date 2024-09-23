using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class login_testing_ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

     
        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string Username = Login1.UserName;
            HttpCookie user = new HttpCookie("User");


            user["username"] = Username;
            user["LastVisited"] = DateTime.Now.ToString();

            user.Expires = DateTime.Now.AddDays(5);
            Response.Cookies.Add(user);

            String userId;
            String rolename;


            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                String idQuery = "Select UserId From aspnet_Users Where UserName = @username";
                using (SqlCommand sqlcmd = new SqlCommand(idQuery, connection))
                {
                    sqlcmd.Parameters.AddWithValue("@username", Username);

                    userId = sqlcmd.ExecuteScalar().ToString();
                    Session["userId"] = userId;
                }

                String roleQuery = "Select aspnet_Roles.RoleName FROM aspnet_UsersInRoles" +
                    " INNER JOIN aspnet_Roles ON aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId " +
                    "WHERE aspnet_UsersInRoles.UserId = @id";
                using (SqlCommand sqlcmd = new SqlCommand(roleQuery, connection))
                {
                    sqlcmd.Parameters.AddWithValue("@id", userId);

                    rolename = sqlcmd.ExecuteScalar().ToString();
                }
                connection.Close();

            }

            if (rolename == "Customer")
            {
                Response.Redirect("Customer/shop.aspx");

            }
            else if (rolename == "Baker")
            {
                Response.Redirect("Baker/bakerDashboard.aspx");
            }
            else
            {
                Response.Redirect("Admin/admin.aspx");
            }
        }
    }
}