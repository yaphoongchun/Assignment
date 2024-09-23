using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using System.IO;
using System.Data;

namespace CakeOrderDeliverySystem
{
    public partial class Payment2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayCustomerOrders();
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

        private decimal CalculateSubtotal()
        {
            string username = GetUsernameFromCookie();
            string customerId = GetCurrentCustomerIdFromUsername(username); // Retrieve customerId here
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
                        // Use customerId instead of orderId
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
            string username = GetUsernameFromCookie();
            if (!string.IsNullOrEmpty(username))
            {
                string customerId = GetCurrentCustomerIdFromUsername(username);

                if (!string.IsNullOrEmpty(customerId))
                {
                    List<string> orderIds = GetOrderIdsByCustomerId(customerId);

                    if (orderIds != null && orderIds.Count > 0)
                    {
                        foreach (string orderId in orderIds)
                        {
                            // Get the subtotal for each order
                            decimal subtotal = CalculateSubtotal();
                            labelSubtotal.Text = subtotal.ToString("C");

                            // Calculate and display total amount
                            decimal totalAmount = CalculateSubtotal();
                            lblTotalAmount.Text = totalAmount.ToString("C");

                            // Other order details display remains unchanged
                        }
                    }
                    else
                    {
                        Response.Redirect("error-page.aspx");
                    }
                }
                else
                {
                    Response.Redirect("error-page.aspx");
                }
            }
            else
            {
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

        private List<string> GetOrderIdsByCustomerId(string custId)
        {
            List<string> orderIds = new List<string>();
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
SELECT o.orderID 
FROM [dbo].[order] o
JOIN [dbo].[Customer] c ON o.custID = c.custID
JOIN [dbo].[orderDetail] od ON o.orderID = od.orderID
WHERE c.custID = @CustomerId
AND o.paymentStatus = 0";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustomerId", custId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string orderId = reader["orderID"].ToString();
                                orderIds.Add(orderId);
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

            return orderIds;
        }



        private bool ValidateInputs()
        {
            // Validate Credit Card
            string creditCardValue = txtCreditCard.Text.Replace(" ", ""); // Remove spaces
            if (creditCardValue.Length != 16 || !creditCardValue.All(char.IsDigit))
            {
                return false;
            }

            // Validate Expiration Date
            string expirationDateValue = txtExpirationDate.Text.Replace("/", ""); // Remove '/'
            if (expirationDateValue.Length != 4 || !expirationDateValue.All(char.IsDigit))
            {
                return false;
            }

            // Validate CVV
            string cvvValue = txtCVV.Text.Trim();
            if (cvvValue.Length != 3 || !cvvValue.All(char.IsDigit))
            {
                return false;
            }

            return true;
        }


        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (ValidateInputs())
            {
                try
                {
                    // Get the username from wherever it is available
                    string username = GetUsernameFromCookie(); // Get the username

                    // Get the customer ID
                    string customerId = GetCurrentCustomerIdFromUsername(username);

                    // Get the order IDs using the customer ID
                    List<string> orderIds = GetOrderIdsByCustomerId(customerId);

                    foreach (string orderId in orderIds)
                    {
                        // Get cake details for each order
                        List<string> cakeDetails = GetCakeDetailsByOrderId(orderId);

                        // Open connection to the database
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString))
                        {
                            conn.Open();

                            // SQL command to update the order status
                            string sql = "UPDATE [dbo].[order] SET orderDate = @orderDate, shippingStatus = @shippingStatus, isOrderConfirm = 1, paymentStatus = 1 WHERE orderID = @orderID AND custID = @custID";

                            // Create and execute the SQL command
                            using (SqlCommand cmd = new SqlCommand(sql, conn))
                            {
                                // Set the parameters for the SQL command
                                cmd.Parameters.AddWithValue("@orderDate", DateTime.Now);
                                cmd.Parameters.AddWithValue("@shippingStatus", "0"); // Assuming 1 represents true for shipping status
                                cmd.Parameters.AddWithValue("@orderID", orderId);
                                cmd.Parameters.AddWithValue("@custID", customerId);
                                cmd.Parameters.AddWithValue("@paymentStatus", true); // Assuming payment is done

                                // Execute the SQL command
                                int rowsAffected = cmd.ExecuteNonQuery();

                                // Check if any rows were affected by the update
                                if (rowsAffected > 0)
                                {
                                    // Order status updated successfully

                                    // Get the user's email
                                    string email = getUserEmail(conn, customerId);

                                    // Send email
                                    SendPaymentConfirmationEmail(email, orderId, cakeDetails);

                                    // Generate a new order ID
                                    string newOrderID = GenerateOrderId();

                                    // SQL command to insert a new order ID for the customer
                                    string sqlInsert = "INSERT INTO [dbo].[order] (orderID, custID, orderDate, shippingStatus, isOrderConfirm, paymentStatus ,isOrderCompleted,address) VALUES (@newOrderID, @custID, @orderDate, @shippingStatus, 0, 0,0,@address)";

                                    // Create and execute the SQL command to insert a new order
                                    using (SqlCommand cmdInsert = new SqlCommand(sqlInsert, conn))
                                    {
                                        // Set the parameters for the SQL command to insert a new order
                                        cmdInsert.Parameters.AddWithValue("@newOrderID", newOrderID);
                                        cmdInsert.Parameters.AddWithValue("@custID", customerId);
                                        cmdInsert.Parameters.AddWithValue("@orderDate", DateTime.Now);
                                        cmdInsert.Parameters.AddWithValue("@shippingStatus", "pending"); // Set initial shipping status to pending
                                        cmdInsert.Parameters.AddWithValue("@address", "abc");

                                        // Execute the SQL command to insert a new order
                                        int rowsInserted = cmdInsert.ExecuteNonQuery();

                                        // Check if the new order was inserted successfully
                                        if (rowsInserted > 0)
                                        {
                                            // New order inserted successfully
                                            // Show success alert and redirect to the customer page
                                            string msg = "alert('Payment successful! An email has been sent to your mailbox.'); window.location.href = 'customerOrderHistory.aspx';";
                                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessScript", msg, true);
                                        }
                                        else
                                        {
                                            // Failed to insert new order
                                            string script = "alert('Failed to insert new order. Please try again.');";
                                            ClientScript.RegisterStartupScript(this.GetType(), "FailureScript", script, true);
                                        }
                                    }
                                }
                                else
                                {
                                    // No rows were affected, possibly due to incorrect order or customer ID
                                    string script = "alert('Failed to update order status. Please try again.');";
                                    ClientScript.RegisterStartupScript(this.GetType(), "FailureScript", script, true);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Show error message
                    string msg = "alert('An error occurred while processing the payment. Error: " + ex.Message + "');";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorScript", msg, true);
                }
            }
            else
            {
                // Validation failed, show error message
                string script = "alert('Payment failed. Please check your input.');";
                ClientScript.RegisterStartupScript(this.GetType(), "FailureScript", script, true);
            }
        }


        private string GenerateOrderId()
        {
            // Generate orderId with a combination of timestamp and random number
            string orderId = "O" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + new Random().Next(1000, 9999);

            // Check if the generated orderId already exists in the database
            while (OrderIdExistsInDatabase(orderId))
            {
                // If the generated orderId already exists, regenerate it
                orderId = "O" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + new Random().Next(1000, 9999);
            }

            return orderId;
        }

        // Method to check if the generated order ID already exists in the database
        private bool OrderIdExistsInDatabase(string orderId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to check if the orderId exists in the order table
            string query = @"SELECT COUNT(*) FROM [order] WHERE orderID = @orderId";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add orderId parameter to the SQL query
                    command.Parameters.AddWithValue("@orderId", orderId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    // If count > 0, orderId exists in the database
                    return count > 0;
                }
            }
        }


        private void SendPaymentConfirmationEmail(string email, string orderId, List<string> cakeDetails)
        {
            try
            {
                // Create a temporary text file to store receipt details
                string textFilePath = Path.GetTempFileName();
                using (StreamWriter sw = new StreamWriter(textFilePath))
                {
                    // Write receipt details to the text file
                    sw.WriteLine("Payment Receipt");
                    sw.WriteLine("Order ID: " + orderId);
                    sw.WriteLine("Items Purchased:");
                    foreach (string cakeDetail in cakeDetails)
                    {
                        sw.WriteLine(cakeDetail);
                    }
                    sw.WriteLine("Thank you for your order!");
                }

                // Send email with text file attachment
                using (SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587))
                {
                    smtpClient.Credentials = new NetworkCredential("interestingcakedelivery@gmail.com", "rlzx oqbo fmnp jlxr");
                    smtpClient.EnableSsl = true;

                    using (MailMessage mail = new MailMessage())
                    {
                        mail.From = new MailAddress("interestingcakedelivery@gmail.com", "InterestingCakeDelivery");
                        mail.To.Add(new MailAddress(email));
                        mail.Subject = "Payment Receipt for Order #" + orderId;
                        mail.IsBodyHtml = true;
                        mail.Body = "<p>Thank you for your order! Please find the attached receipt.</p>";

                        // Attach text file
                        Attachment attachment = new Attachment(textFilePath);
                        mail.Attachments.Add(attachment);

                        smtpClient.Send(mail);
                    }
                }

                // Delete the temporary text file after sending the email
                File.Delete(textFilePath);
            }
            catch (Exception ex)
            {
                throw new Exception("Failed to send payment confirmation email. Error: " + ex.Message);
            }
        }




        private List<string> GetCakeDetailsByOrderId(string orderId)
        {
            List<string> cakeDetails = new List<string>();

            // Retrieve cake details from the database based on the order ID
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
        SELECT p.productName, p.price, od.amount AS quantity
        FROM [orderDetail] od
        INNER JOIN product p ON od.productID = p.productID
        WHERE od.orderID = @OrderId";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@OrderId", orderId);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string productName = reader["productName"].ToString();
                                decimal price = Convert.ToDecimal(reader["price"]);
                                int quantity = Convert.ToInt32(reader["quantity"]);
                                string cakeDetail = productName + " (Price: " + price.ToString("C") + ", Quantity: " + quantity + ")";
                                cakeDetails.Add(cakeDetail);
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

            return cakeDetails;
        }


        private string getUserEmail(SqlConnection conn, string userId)
        {
            String email = "";
            try
            {
                //get the user's phone number
                string strRetrieveEmail = "Select Email from aspnet_Membership where UserId = @custID";
                using (SqlCommand cmdRetrieveEmail = new SqlCommand(strRetrieveEmail, conn))
                {
                    cmdRetrieveEmail.Parameters.AddWithValue("@custID", userId);

                    // ExecuteScalar returns the first column of the first row
                    object result = cmdRetrieveEmail.ExecuteScalar();

                    if (result != null)
                    {
                        email = result.ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Something wrong in retrieving your email. Please relogin and try again...");
            }
            return email;
        }


        private void HandleException(Exception ex)
        {
            // Log the exception and provide appropriate feedback to the user
            // You can implement your custom exception handling logic here
        }
    }
}