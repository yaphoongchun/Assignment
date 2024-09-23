using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class testing123 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            int querySucess;
            TextBox Username = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName");//this is text box username id("UserName")
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                String userId;

                String getUserIDQuery = "SELECT UserID FROM aspnet_Users WHERE UserName = @UserName";
                using (SqlCommand cmd = new SqlCommand(getUserIDQuery, connection))
                {
                    cmd.Parameters.AddWithValue("@UserName", Username.Text);
                    userId = cmd.ExecuteScalar().ToString();
                }

                string dateOfBirthText = "1990-01-01"; // Example hardcoded date

                DateTime dateOfBirth = DateTime.ParseExact(dateOfBirthText, "yyyy-MM-dd", null);

                // Insert baker record into database
                String insertBakerID = "INSERT INTO customer (custID, custName, dateOfBirth) VALUES (@bakerId, @bakerName, @dateOfBirth)";
                using (SqlCommand command = new SqlCommand(insertBakerID, connection))
                {
                    command.Parameters.AddWithValue("@bakerId", userId);
                    command.Parameters.AddWithValue("@bakerName", Username.Text);
                    command.Parameters.AddWithValue("@dateOfBirth", dateOfBirth);
                    querySucess = command.ExecuteNonQuery();
                }
                connection.Close();


            }
            AssignRole(querySucess, Username.Text);
            // Set the user's full name

            // Insert baker record into database


            // Redirect the user to the login page
            Response.Redirect("login.aspx");

        }
        protected void AssignRole(int rowAffected, String username)
        {
            if (rowAffected != 0)
            {
                Roles.AddUserToRole(username, "Admin");
            }
        }
    }


}