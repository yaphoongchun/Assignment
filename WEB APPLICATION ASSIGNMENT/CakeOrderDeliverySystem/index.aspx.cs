using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubscribeButton_Click(object sender, EventArgs e)
        {
            string email = EmailTextBox.Text.Trim();

            if (!string.IsNullOrEmpty(email))
            {
                if (IsValidEmail(email))
                {
                    if (IsEmailSubscribed(email))
                    {
                        ErrorMessageLabel.Text = "You are already subscribed with this email address.";
                        SuccessMessageLabel.Text = "";
                        ClientScript.RegisterStartupScript(this.GetType(), "showError", "showError('You are already subscribed with this email address.');", true);
                    }
                    else
                    {
                        bool success = InsertSubscriber(email);

                        if (success)
                        {
                            SuccessMessageLabel.Text = "Subscription successful! Thank you for subscribing.";
                            ErrorMessageLabel.Text = "";
                            ClientScript.RegisterStartupScript(this.GetType(), "showSuccess", "showSuccess('Subscription successful! Thank you for subscribing.');", true);
                        }
                        else
                        {
                            ErrorMessageLabel.Text = "An error occurred while subscribing. Please try again later.";
                            SuccessMessageLabel.Text = "";
                            ClientScript.RegisterStartupScript(this.GetType(), "showError", "showError('An error occurred while subscribing. Please try again later.');", true);
                        }
                    }
                }
                else
                {
                    ErrorMessageLabel.Text = "Please enter a valid email address.";
                    SuccessMessageLabel.Text = "";
                    ClientScript.RegisterStartupScript(this.GetType(), "showError", "showError('Please enter a valid email address.');", true);
                }
            }
            else
            {
                ErrorMessageLabel.Text = "Please enter your email address.";
                SuccessMessageLabel.Text = "";
                ClientScript.RegisterStartupScript(this.GetType(), "showError", "showError('Please enter your email address.');", true);
            }
        }


        private bool IsValidEmail(string email)
        {
            // Regular expression pattern for validating email addresses
            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

            // Check if the email matches the pattern
            return Regex.IsMatch(email, pattern);
        }

        private bool InsertSubscriber(string email)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    if (!IsValidEmail(email))
                    {
                        return false;
                    }

                    if (IsEmailSubscribed(email))
                    {
                        return false;
                    }

                    string query = "INSERT INTO subscriber (email) VALUES (@Email)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        con.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            return true;
                        }
                        else
                        {
                            return false;
                        }

                        con.Close();
                    }
                }
                catch (SqlException ex)
                {
                    return false;
                }
                catch (Exception ex)
                {
                    return false;
                }
            }
        }

        private bool IsEmailSubscribed(string email)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            string query = "SELECT COUNT(*) FROM subscriber WHERE email = @Email";

            int count = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    con.Open();

                    count = (int)cmd.ExecuteScalar();
                }
                catch (SqlException ex)
                {
                    return false;
                }
            }

            return count > 0;
        }
    }
}