using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class bakerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = GetCurrentUsername();

                if (!string.IsNullOrEmpty(username))
                {
                    string bakerId = GetCurrentBakerIdFromUsername(username);

                    if (!string.IsNullOrEmpty(bakerId))
                    {
                        DisplayOrdersAndTotalSales(bakerId);
                        DisplayTotalOrders(bakerId);
                        DisplayTotalCustomers(bakerId); // Add 
                        GetTotalRevenueByDateJson();
                    }
                    else
                    {
                        // Handle the case where bakerId is null or empty
                        // This could be due to the username not being associated with a baker
                        // You may want to display an error message or redirect the user
                    }
                }
                else
                {
                    // Handle the case where username is null or empty
                    // This could happen if the user is not logged in
                    // You may want to display an error message or redirect the user
                }
            }
        }

        // Implement this method to retrieve the current user's username from the desired source
        private string GetCurrentUsername()
        {
            string username = "";
            HttpCookie userCookie = Request.Cookies["User"];

            if (userCookie != null && !string.IsNullOrEmpty(userCookie["username"]))
            {
                username = userCookie["username"];
            }
            else
            {
                // Log an error or display a message indicating that the username is missing from the cookie
                // This helps in identifying issues with cookie content
                // Example: Log.Error("Username is missing from the 'User' cookie.");
            }

            return username;
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

        private void DisplayOrdersAndTotalSales(string bakerId)
        {
            DisplayOrdersForBaker(bakerId);
            decimal totalSales = CalculateTotalSales(bakerId);
            Label1.Text = totalSales.ToString("c"); // Displaying total sales in Revenue card
        }

        private void DisplayOrdersForBaker(string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
                SELECT o.orderID, o.orderDate, od.amount, p.productName, p.price
                FROM [order] o
                INNER JOIN orderDetail od ON o.orderID = od.orderID
                INNER JOIN product p ON od.productID = p.productID
                WHERE p.bakerID = @BakerId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", bakerId);
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);

                
                }
            }
        }

        private int CalculateTotalOrders(string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            int totalOrders = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT COUNT(*) AS TotalOrders
                    FROM [order] o
                    INNER JOIN orderDetail od ON o.orderID = od.orderID
                    INNER JOIN product p ON od.productID = p.productID
                    WHERE p.bakerID = @BakerId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", bakerId);
                    connection.Open();
                    totalOrders = Convert.ToInt32(command.ExecuteScalar());
                }
            }

            return totalOrders;
        }

        private void DisplayTotalOrders(string bakerId)
        {
            int totalOrders = CalculateTotalOrders(bakerId);
            lblTotalOrders.Text = totalOrders.ToString();
        }

        private int CalculateTotalCustomers(string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            int totalCustomers = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT COUNT(DISTINCT custID) AS TotalCustomers
            FROM [order] o
            INNER JOIN orderDetail od ON o.orderID = od.orderID
            INNER JOIN product p ON od.productID = p.productID
            WHERE p.bakerID = @BakerId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", bakerId);
                    connection.Open();
                    totalCustomers = Convert.ToInt32(command.ExecuteScalar());
                }
            }

            return totalCustomers;
        }

        private void DisplayTotalCustomers(string bakerId)
        {
            int totalCustomers = CalculateTotalCustomers(bakerId);
            lblTotalCustomers.Text = totalCustomers.ToString();
        }

        public string GetTotalRevenueByDateJson()
        {
            Dictionary<string, decimal> revenueData = GetTotalRevenueByDate();
            return new JavaScriptSerializer().Serialize(revenueData);
        }


        public Dictionary<string, decimal> GetTotalRevenueByDate()
        {
            Dictionary<string, decimal> revenueData = new Dictionary<string, decimal>();

            // Retrieve total revenue data from database
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT CONVERT(date, o.orderDate) AS OrderDate, SUM(CAST(od.amount AS decimal(18, 2))) AS TotalRevenue
            FROM [order] o
            INNER JOIN orderDetail od ON o.orderID = od.orderID
            INNER JOIN product p ON od.productID = p.productID
            WHERE p.bakerID = @BakerId
            GROUP BY CONVERT(date, o.orderDate)";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", GetCurrentBakerId());
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        string orderDate = ((DateTime)reader["OrderDate"]).ToString("yyyy-MM-dd");
                        decimal totalRevenue = Convert.ToDecimal(reader["TotalRevenue"]);
                        revenueData.Add(orderDate, totalRevenue);
                    }
                }
            }

            return revenueData;
        }
        private string GetCurrentBakerId()
        {
            string username = GetCurrentUsername();
            string bakerId = "";

            if (!string.IsNullOrEmpty(username))
            {
                bakerId = GetCurrentBakerIdFromUsername(username);
            }

            return bakerId;
        }


        private decimal CalculateTotalSales(string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            decimal totalSales = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT od.amount, p.price
                    FROM [order] o
                    INNER JOIN orderDetail od ON o.orderID = od.orderID
                    INNER JOIN product p ON od.productID = p.productID
                    WHERE p.bakerID = @BakerId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@BakerId", bakerId);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        // Retrieve the quantity and price from the database
                        decimal quantity = Convert.ToDecimal(reader["amount"]);
                        decimal pricePerUnit = Convert.ToDecimal(reader["price"]);

                        // Calculate the total amount for each sale (quantity * price per unit) and add it to the total sales
                        totalSales += quantity * pricePerUnit;
                    }

                    reader.Close();
                }
            }

            return totalSales;
        }
    }
}