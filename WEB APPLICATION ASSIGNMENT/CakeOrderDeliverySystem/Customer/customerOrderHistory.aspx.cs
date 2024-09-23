using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace CakeOrderDeliverySystem.Customer
{
    public partial class customerOrderHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrderData();
            }
        }

        private void BindOrderData()
        {
            // Fetch order data from the database based on your SQL query
            DataTable ordersTable = GetOrdersFromDatabase();

            // Bind the fetched data to the Repeater control
            RepeaterOrders.DataSource = ordersTable;
            RepeaterOrders.DataBind();
        }

        private DataTable GetOrdersFromDatabase()
        {
            DataTable ordersTable = new DataTable();

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
                       SELECT [order].shippingStatus, [order].isOrderConfirm, [order].paymentStatus, [order].isOrderCompleted, 
       orderDetail.amount, product.productName, product.description, product.price, product.productImage, 
       [order].orderDate, [order].shippedAddress
FROM [order] 
INNER JOIN orderDetail ON [order].orderID = orderDetail.orderID 
INNER JOIN product ON orderDetail.productID = product.productID 
WHERE [order].custID = @CustomerId AND [order].paymentStatus = 1;"; // Modify the WHERE clause as needed
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CustomerId", GetCustomerIdFromUsername(GetUsernameFromCookie()));
                        connection.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(ordersTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
            }

            return ordersTable;
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


        protected string GetShippingStatusText(object shippingStatus)
        {
            if (shippingStatus != null)
            {
                int statusValue;
                if (int.TryParse(shippingStatus.ToString(), out statusValue))
                {
                    if (statusValue == 0)
                    {
                        return "Preparing";
                    }
                    else if (statusValue == 1)
                    {
                        return "Done";
                    }
                }
            }
            return "Invalid Status";
        }

        // Method to get the CSS class for shipping status label
        protected string GetShippingStatusCssClass(object shippingStatus)
        {
            if (shippingStatus != null)
            {
                string status = shippingStatus.ToString().Trim().ToLower(); // Convert to lowercase and trim any extra whitespace
                if (status.Equals("1", StringComparison.OrdinalIgnoreCase))
                {
                    return "text-success";
                }
                else if (status.Equals("0", StringComparison.OrdinalIgnoreCase) || status.Equals("pending", StringComparison.OrdinalIgnoreCase) || status.Equals("processing", StringComparison.OrdinalIgnoreCase))
                {
                    return "text-danger";
                }
                else
                {
                    // Handle any other string values or unexpected cases
                    return "text-secondary";
                }
            }
            return string.Empty;
        }

        // Method to get the text for order completed label
        protected string GetOrderCompletedText(object isOrderCompleted)
        {
            if (isOrderCompleted != null)
            {
                bool completed = Convert.ToBoolean(isOrderCompleted);
                return completed ? "Order is Completed" : "Order is Not Completed";
            }
            return string.Empty;
        }

        // Method to get the CSS class for order completed label
        protected string GetOrderCompletedCssClass(object isOrderCompleted)
        {
            if (isOrderCompleted != null)
            {
                bool completed = Convert.ToBoolean(isOrderCompleted);
                return completed ? "text-success" : "text-danger";
            }
            return string.Empty;
        }
    }
}