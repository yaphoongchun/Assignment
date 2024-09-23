using Microsoft.Win32;
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
    public partial class register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {

            int querySuccess;
            TextBox Username = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Username");
            TextBox Name = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Name");
            TextBox Mobile = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Mobile");
            TextBox DateBirth = (TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("DateBirth");

            try
            {

                string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {

                    connection.Open();
                    String userId;

                    string updateQuery = "UPDATE aspnet_Users SET MobileAlias = @MobileAlias WHERE UserName = @UserName";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, connection))
                    {
                        cmd.Parameters.AddWithValue("@MobileAlias", Mobile.Text);
                        cmd.Parameters.AddWithValue("@UserName", Username.Text);

                        cmd.ExecuteNonQuery();
                    }

                    String getUserIDQuery = "SELECT UserID FROM aspnet_Users WHERE UserName = @UserName";
                    using (SqlCommand cmd = new SqlCommand(getUserIDQuery, connection))
                    {
                        cmd.Parameters.AddWithValue("@UserName", Username.Text);
                        userId = cmd.ExecuteScalar().ToString();
                    }

                    String createCustomerQuery = "INSERT INTO Customer (custID, custName, dateOfBirth) VALUES(@ID,@Name,@Date)";
                    using (SqlCommand cmd = new SqlCommand(createCustomerQuery, connection))
                    {
                        cmd.Parameters.AddWithValue("@ID", userId);
                        cmd.Parameters.AddWithValue("@Name", Name.Text);
                        cmd.Parameters.AddWithValue("@Date", DateBirth.Text);
                        querySuccess = cmd.ExecuteNonQuery();
                    }

                    connection.Close();
                }

                AssignRole(querySuccess, Username.Text);
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }

        }

        protected void AssignRole(int rowAffected, String username)
        {
            if (rowAffected != 0)
            {
                try
                {
                    // Check if the user is already in the "Customer" role before adding
                    if (!Roles.IsUserInRole(username, "Customer"))
                    {
                        Roles.AddUserToRole(username, "Customer");
                    }
                }
                catch (Exception ex)
                {
                    // Handle role assignment errors
                    Response.Write("<script>alert('Error assigning role: " + ex.Message + "');</script>");
                }
            }

        }

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}