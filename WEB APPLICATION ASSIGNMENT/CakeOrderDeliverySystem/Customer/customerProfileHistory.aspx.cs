using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.Security;

namespace CakeOrderDeliverySystem.Customer
{
    public partial class customerProfileHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomerInformation();
            }
        }

        protected void LoadCustomerInformation()
        {
            string username = GetUsernameFromCookie();
            string custId = GetCustomerIdFromUsername(username);

            if (!string.IsNullOrEmpty(custId))
            {
                string query = @"
                    SELECT aspnet_Membership.LoweredEmail, 
                           aspnet_Users.MobileAlias, 
                           customer.custName, 
                           aspnet_Membership.LastLoginDate 
                    FROM aspnet_Membership 
                    INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId 
                    INNER JOIN customer ON aspnet_Membership.UserId = customer.custID
                    WHERE customer.custID = @CustID";

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustID", custId);
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            lblEmail.Text = reader["LoweredEmail"].ToString();
                            lblMobileAlias.Text = reader["MobileAlias"].ToString();
                            lblCustomerName.Text = reader["custName"].ToString();
                            lblSecondCustomerName.Text = reader["custName"].ToString();
                            lblLastLoginDate.Text = reader["LastLoginDate"].ToString();
                        }
                        reader.Close();
                    }
                }
            }
            else
            {
                // Handle case where custID is not found for the username
            }
        }

        protected void SaveChangesButton_Click(object sender, EventArgs e)
        {
            string fullName = fullNameTextBox.Text;
            string phone = phoneTextBox.Text;
            string email = emailTextBox.Text;

            string username = GetUsernameFromCookie();
            string custId = GetCustomerIdFromUsername(username);

            if (!string.IsNullOrEmpty(custId))
            {
                UpdateUserProfile(fullName, phone, email, custId);
            }
            else
            {
                // Handle case where custID is not found for the username
            }
        }


        private void UpdateUserProfile(string newCustName, string newMobileAlias, string newEmail, string custId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Update customer table
            string updateCustomerQuery = @"
UPDATE customer
SET custName = @NewCustName
WHERE custID = @CustID";

            // Update aspnet_Users table
            string updateUsersQuery = @"
UPDATE aspnet_Users
SET MobileAlias = @NewMobileAlias
FROM aspnet_Users
INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId
WHERE aspnet_Membership.UserId = @CustID";

            // Update aspnet_Membership table
            string updateMembershipQuery = @"
UPDATE aspnet_Membership
SET LoweredEmail = @NewEmail
WHERE UserId = @CustID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Update customer table
                using (SqlCommand command = new SqlCommand(updateCustomerQuery, connection))
                {
                    command.Parameters.AddWithValue("@NewCustName", newCustName);
                    command.Parameters.AddWithValue("@CustID", custId);
                    command.ExecuteNonQuery();
                }

                // Update aspnet_Users table
                using (SqlCommand command = new SqlCommand(updateUsersQuery, connection))
                {
                    command.Parameters.AddWithValue("@NewMobileAlias", newMobileAlias);
                    command.Parameters.AddWithValue("@CustID", custId);
                    command.ExecuteNonQuery();
                }

                // Update aspnet_Membership table
                using (SqlCommand command = new SqlCommand(updateMembershipQuery, connection))
                {
                    command.Parameters.AddWithValue("@NewEmail", newEmail);
                    command.Parameters.AddWithValue("@CustID", custId);
                    command.ExecuteNonQuery();
                }
            }

            string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Profile updated successfully',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(function () {
                        window.location.href = 'customerProfileHistory.aspx';
                    });
                </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "ProfileUpdatedSuccess", script);

        }

        protected void ChangePasswordButton_Click(object sender, EventArgs e)
        {
            string currentPassword = currentPasswordTextBox.Text;
            string newPassword = newPasswordTextBox.Text;
            string confirmPassword = confirmPasswordTextBox.Text;

            // Check if the current password is the same as the new password
            if (currentPassword == newPassword)
            {
                // Display error message if current password is the same as the new password
                string samePasswordScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'New password must be different from the current password.'
    });
</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "samePasswordScript", samePasswordScript);
                return;
            }

            // Verify the current password
            if (!Membership.ValidateUser(User.Identity.Name, currentPassword))
            {
                // Display error message if current password is incorrect
                string invalidPasswordScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Current password is incorrect.'
    });
</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "invalidPasswordScript", invalidPasswordScript);
                return;
            }

            // Check if new password matches the confirm password
            if (newPassword != confirmPassword)
            {
                // Display error message if passwords do not match
                string passwordMismatchScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'New password and confirm password do not match.'
    });
</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "passwordMismatchScript", passwordMismatchScript);
                return;
            }

            // Change password using Membership API
            MembershipUser user = Membership.GetUser();
            if (user != null && user.ChangePassword(currentPassword, newPassword))
            {
                // Password changed successfully
                string passwordChangedScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: 'Password changed successfully!',
        showConfirmButton: false,
        timer: 1500
    }).then(function () {
        window.location.href = 'customerProfileHistory.aspx';
    });
</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "passwordChangedScript", passwordChangedScript);
            }
            else
            {
                // Display error message if password change fails
                string passwordChangeFailedScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Failed to change password. Please try again later.'
    });
</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "passwordChangeFailedScript", passwordChangeFailedScript);
            }
        }


        private string GetCustomerIdFromUsername(string username)
        {
            string custId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT c.custID 
                    FROM [dbo].[customer] c 
                    INNER JOIN [dbo].[aspnet_Users] u ON c.custID = u.UserId 
                    WHERE u.UserName = @Username";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    connection.Open();
                    custId = command.ExecuteScalar()?.ToString();
                }
            }

            return custId;
        }

        protected string GetUsernameFromCookie()
        {
            string username = "";
            HttpCookie userCookie = Request.Cookies["User"];
            if (userCookie != null)
            {
                username = userCookie["username"];
            }
            return username;
        }
    }
}
