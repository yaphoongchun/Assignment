using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Admin
{
    public partial class adminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string id = Session["userId"].ToString();
                    userid.Value = id;
                }
                catch (SystemException ex)
                {
                    Response.Write("<script type='text/javascript'> " +
                        "alert('Session expire , Please login again.');" +
                        "window.location.href = '../login.aspx'; </script>");
                }

                FormViewAdminProfile.DataSource = userProfile;
                FormViewAdminProfile.DataBind();

            }
        }

        protected void btnUpdated_Click(object sender, EventArgs e)
        {
            TextBox Username = (TextBox)FormViewAdminProfile.FindControl("username");
            TextBox Email = (TextBox)FormViewAdminProfile.FindControl("email");

            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string update1Query = "UPDATE aspnet_Users SET UserName = @username , LoweredUserName = @lowerusername WHERE UserId = @id";
                using (SqlCommand cmd = new SqlCommand(update1Query, connection))
                {
                    cmd.Parameters.AddWithValue("@username", Username.Text);
                    cmd.Parameters.AddWithValue("@lowerusername", Username.Text.ToString().ToLower());
                    cmd.Parameters.AddWithValue("@id", Session["userId"].ToString());

                    cmd.ExecuteNonQuery();
                }


                string update2Query = "UPDATE aspnet_Membership SET Email = @email WHERE UserId = @id";
                using (SqlCommand cmd = new SqlCommand(update2Query, connection))
                {
                    cmd.Parameters.AddWithValue("@email", Email.Text);
                    cmd.Parameters.AddWithValue("@id", Session["userId"].ToString());

                    cmd.ExecuteNonQuery();
                }

                connection.Close();
            }

            FormViewAdminProfile.DataSource = userProfile;
            FormViewAdminProfile.DataBind();

        }
    }
}