using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web;
using System.Configuration;
using System.Linq;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class bakerOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the current baker's username from the cookie
                string username = "";
                HttpCookie userCookie = Request.Cookies["User"];
                if (userCookie != null)
                {
                    username = userCookie["username"];
                }

                // Get the baker's ID from the username
                string bakerId = GetCurrentBakerIdFromUsername(username);

                // Display orders for the current baker
                DisplayOrdersForBaker(bakerId);
            }
        }

        protected string GetShippingStatusText(object shippingStatus)
        {
            if (shippingStatus != null)
            {
                string status = shippingStatus.ToString().Trim().ToLower(); // Convert to lowercase and trim any extra whitespace
                if (status.Equals("1", StringComparison.OrdinalIgnoreCase ))
                {
                    return "Shipping Status Done";
                }
                else if (status.Equals("0", StringComparison.OrdinalIgnoreCase) || status.Equals("pending", StringComparison.OrdinalIgnoreCase))
                {
                    return "Shipping Status Not Done";
                }
                else
                {
                    return "Invalid Shipping Status Format";
                }
            }
            return string.Empty;
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

        private string GetCurrentBakerIdFromUsername(string username)
        {
            string bakerId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT b.bakerID 
            FROM [dbo].[baker] b 
            INNER JOIN [dbo].[aspnet_Users] u ON b.bakerID = u.UserId 
            WHERE u.UserName = @Username";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    connection.Open();
                    bakerId = command.ExecuteScalar()?.ToString();
                }
            }

            return bakerId;
        }

        private void DisplayOrdersForBaker(string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
        SELECT c.custName,
               o.orderID,
               o.orderDate, 
               o.shippingStatus, 
               o.shippedAddress, 
               o.isOrderCompleted, 
               od.amount, 
               p.productName, 
               p.productImage 
        FROM customer c
        INNER JOIN [order] o ON c.custID = o.custID 
        INNER JOIN orderDetail od ON o.orderID = od.orderID 
        INNER JOIN product p ON od.productID = p.productID 
        WHERE p.bakerID = @BakerId
        AND o.paymentStatus = 1
        ORDER BY o.orderID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", bakerId);
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    // Group orders by orderID
                    var groupedOrders = dataTable.AsEnumerable()
                        .GroupBy(row => row.Field<string>("orderID"))
                        .Select(group => new
                        {
                            OrderID = group.Key,
                            Orders = group.CopyToDataTable()
                        });

                    RepeaterOrders.DataSource = groupedOrders;
                    RepeaterOrders.DataBind();
                }
            }
        }
        protected void ChangeStatusButton_Click(object sender, EventArgs e)
        {
            // Get the order ID from the command argument
            Button button = (Button)sender;
            string orderID = button.CommandArgument;

            // Redirect to another page for changing the status
            Response.Redirect("ChangingStatus.aspx?orderID=" + orderID);
        }
    }
}