using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace CakeOrderDeliverySystem
{
    public partial class checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayCustomerInformation();
                DisplayCustomerOrders();
            }
        }

        private void DisplayCustomerInformation()
        {
            // Retrieve username from cookie
            string username = GetUsernameFromCookie();
            if (!string.IsNullOrEmpty(username))
            {
                string customerId = GetCurrentCustomerIdFromUsername(username);

                if (!string.IsNullOrEmpty(customerId))
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
                    string query = @"
                        SELECT c.custName, m.LoweredEmail
                        FROM [Customer] c 
                        INNER JOIN [aspnet_Membership] m ON c.custID = m.UserId 
                        INNER JOIN [aspnet_Users] u ON c.custID = u.UserId 
                        WHERE u.UserName = @Username";

                    try
                    {
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                command.Parameters.AddWithValue("@Username", username);
                                connection.Open();
                                SqlDataReader reader = command.ExecuteReader();
                                if (reader.Read())
                                {
                                    string customerName = reader["custName"].ToString();
                                    string email = reader["LoweredEmail"].ToString();
                                    first.Text = customerName;
                                    emailField.Text = email;
                                }
                                reader.Close();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the exception and provide appropriate feedback to the user
                        HandleException(ex);
                    }
                }
                else
                {
                    Response.Redirect("error-page.aspx");
                }
            }
        }

        private string GetUsernameFromCookie()
        {
            string username = "";
            HttpCookie userCookie = Request.Cookies["User"];
            if (userCookie != null)
            {
                username = userCookie["username"];
            }
            return username;
        }

        private decimal CalculateSubtotal(string customerId)
        {
            decimal subtotal = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            string query = @"
        SELECT p.price, od.amount AS quantity
        FROM [orderDetail] od
        INNER JOIN product p ON od.productID = p.productID
        INNER JOIN [order] o ON od.orderID = o.orderID
        WHERE o.custID = @CustomerId AND o.paymentStatus = 0";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustomerId", customerId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                decimal price = Convert.ToDecimal(reader["price"]);
                                int quantity = Convert.ToInt32(reader["quantity"]);
                                subtotal += price * quantity;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }

            return subtotal;
        }


        private void DisplayCustomerOrders()
        {
            // Retrieve username from cookie
            string username = "";
            HttpCookie userCookie = Request.Cookies["User"];
            if (userCookie != null)
            {
                username = userCookie["username"];

                // Get current customer's ID based on the username
                string customerId = GetCurrentCustomerIdFromUsername(username);

                if (!string.IsNullOrEmpty(customerId))
                {
                    // Calculate subtotal for orders with paymentStatus = 0
                    decimal subtotal = CalculateSubtotal(customerId);

                    // Display subtotal
                    lblSubtotal.Text = subtotal.ToString("C");

                    // Calculate number of products and their names for orders with paymentStatus = 0
                    int productCount = 0;
                    string productNames = "";

                    // Get product details
                    string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

                    string query = @"
                SELECT p.productName
                FROM [orderDetail] od
                INNER JOIN product p ON od.productID = p.productID
                INNER JOIN [order] o ON od.orderID = o.orderID
                WHERE o.custID = @CustomerId AND o.paymentStatus = 0";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@CustomerId", customerId);
                            connection.Open();

                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                while (reader.Read())
                                {
                                    // Increment product count
                                    productCount++;

                                    // Get product name and append to the list
                                    string productName = reader["productName"].ToString();
                                    productNames += productName + ", ";
                                }
                            }
                        }
                    }

                    // Remove the trailing comma and space
                    productNames = productNames.TrimEnd(',', ' ');

                    // Display product count and names
                    lblProductName.Text = " (" + productCount + "):";
                    lblProductDetails.Text = productNames;

                    // Display grand total
                    lblGrandTotal.Text = (subtotal).ToString("C");
                }
                else
                {
                    // Handle case where customer ID is not found
                    Response.Redirect("error-page.aspx");
                }
            }
            else
            {
                // Handle case where user cookie is not found
                Response.Redirect("error-page.aspx");
            }
        }

        private string GetCurrentCustomerIdFromUsername(string username)
        {
            string customerId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT c.custID 
                        FROM [dbo].[Customer] c 
                        INNER JOIN [dbo].[aspnet_Users] u ON c.custID = u.UserId 
                        WHERE u.UserName = @Username";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Username", username);
                        connection.Open();
                        object result = command.ExecuteScalar();
                        if (result != null)
                        {
                            customerId = result.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }

            return customerId;
        }

        private string GetOrderIdByCustomerId(string customerId)
        {
            string orderId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
                        SELECT orderID 
                        FROM [dbo].[order] 
                        WHERE custID = @CustomerId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustomerId", customerId);
                        connection.Open();
                        object result = command.ExecuteScalar();
                        if (result != null)
                        {
                            orderId = result.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }

            return orderId;
        }

        private void HandleException(Exception ex)
        {
            // Log the exception and provide appropriate feedback to the user
            // For simplicity, you can write exception details to a log file or display a generic error message to the user
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Retrieve username from cookie
            string username = GetUsernameFromCookie();

            if (!string.IsNullOrEmpty(username))
            {
                // Get current customer's ID based on the username
                string customerId = GetCurrentCustomerIdFromUsername(username);

                if (!string.IsNullOrEmpty(customerId))
                {
                    // Get the customer's name, address, and shipped address from the TextBoxes
                    string custName = first.Text.Trim(); // Assuming "first" is the TextBox for customer name
                    string address = txtAddress.Text.Trim(); // Assuming "txtAddress" is the TextBox for address
                    string shippedAddress = txtAddress.Text.Trim(); // Assuming "txtShippedAddress" is the TextBox for shipped address
                    string phoneNumber = txtPhone.Text.Trim();
                    string email = emailField.Text.Trim();

                    // Update the customer name in the customer table
                    UpdateCustomerName(customerId, custName);

                    // Update the address and shipped address in the order table
                    UpdateOrderAddresses(customerId, address, shippedAddress);

                    // Additional logic for placing the order goes here
                    UpdatePhoneNumber(username, phoneNumber);
                    UpdateEmail(username, email);

                    Response.Redirect("Payment2.aspx");
                }
                else
                {
                    // Handle case where customer ID is not found
                    Response.Redirect("error-page.aspx");
                }
            }
            else
            {
                // Handle case where username is not found
                Response.Redirect("error-page.aspx");
            }
        }

        // Method to update the customer's name in the customer table
        private void UpdateCustomerName(string customerId, string custName)
        {
            // Connection string to your database
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to update the customer's name in the customer table based on custID
            string query = "UPDATE [dbo].[customer] SET [custName] = @custName WHERE [custID] = @custID";

            // Execute the SQL query
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@custID", customerId);
                        command.Parameters.AddWithValue("@custName", custName);

                        // Open the connection and execute the query
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }
        }

        // Method to update the address and shipped address in the order table
        private void UpdateOrderAddresses(string customerId, string address, string shippedAddress)
        {
            // Connection string to your database
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to update the address and shipped address in the order table based on custID
            string query = "UPDATE [dbo].[order] SET [address] = @address, [shippedAddress] = @shippedAddress WHERE [custID] = @custID";

            // Execute the SQL query
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@custID", customerId);
                        command.Parameters.AddWithValue("@address", address);
                        command.Parameters.AddWithValue("@shippedAddress", shippedAddress);

                        // Open the connection and execute the query
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }
        }

        private void UpdatePhoneNumber(string username, string phoneNumber)
        {
            // Connection string to your database
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to update the phone number (MobileAlias) in the aspnet_Users table based on username
            string query = "UPDATE [dbo].[aspnet_Users] SET [MobileAlias] = @phoneNumber WHERE [UserName] = @username";

            // Execute the SQL query
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@username", username);
                        command.Parameters.AddWithValue("@phoneNumber", phoneNumber);

                        // Open the connection and execute the query
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }
        }

        private void UpdateEmail(string username, string email)
        {
            // Connection string to your database
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to update the email in the aspnet_Membership table based on username
            string query = "UPDATE [dbo].[aspnet_Membership] SET [Email] = @email, [LoweredEmail] = LOWER(@email) WHERE [UserId] = (SELECT UserId FROM [dbo].[aspnet_Users] WHERE [UserName] = @username)";

            // Execute the SQL query
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the command
                        command.Parameters.AddWithValue("@username", username);
                        command.Parameters.AddWithValue("@email", email);

                        // Open the connection and execute the query
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and provide appropriate feedback to the user
                HandleException(ex);
            }
        }



    }

}
