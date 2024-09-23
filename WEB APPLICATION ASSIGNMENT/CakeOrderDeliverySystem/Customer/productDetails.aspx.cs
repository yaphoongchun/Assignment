using CakeOrderDeliverySystem.Customer;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace CakeOrderDeliverySystem
{
    public partial class productDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string username = "";
                HttpCookie userCookie = Request.Cookies["User"];
                if (userCookie != null)
                {
                    username = userCookie["username"];
                }

                // Get the current customer's ID based on the username
                string customerId = GetCurrentCustomerIdFromUsername(username);

                // Check if the productId query string parameter is provided
                string productId = Request.QueryString["productId"];
                if (!string.IsNullOrEmpty(productId))
                {
                    // Populate product details based on the productId
                    PopulateProductDetails(productId);
                }
                else
                {
                    // Redirect to an error page or handle the scenario accordingly
                    Response.Redirect("error-page.aspx");
                }
            }
        }

        private string GetCurrentCustomerIdFromUsername(string username)
        {
            string customerId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

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
                    customerId = command.ExecuteScalar()?.ToString();
                }
            }

            return customerId;
        }


        private void PopulateProductDetails(string productId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to fetch product details based on the provided productId
            string query = @"
                SELECT category.catName, product.productName, product.description, product.productSize, product.price, product.ingredient, product.allegrens, product.productImage
                FROM category
                INNER JOIN product ON category.catID = product.catID
                WHERE product.productId = @ProductId";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add productId parameter to the SQL query
                    command.Parameters.AddWithValue("@ProductId", productId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Check if any rows are returned
                    if (reader.Read())
                    {
                        // Retrieve product details from the data reader
                        string categoryName = reader["catName"].ToString();
                        string productName = reader["productName"].ToString();
                        string description = reader["description"].ToString();
                        string productSize = reader["productSize"].ToString();
                        decimal price = Convert.ToDecimal(reader["price"]);
                        string ingredient = reader["ingredient"].ToString();
                        string allergens = reader["allegrens"].ToString();
                        string imageUrl = reader["productImage"].ToString();

                        // Set the product details to the corresponding UI elements
                        categoryNameLabel.Text = categoryName;
                        productNameLabel.Text = productName;
                        descriptionLabel.Text = description;
                        productSizeLabel.Text = productSize;
                        priceLabel.Text = "$" + price.ToString();
                        ingredientLabel.Text = ingredient;
                        allergensLabel.Text = allergens;
                        productImage.ImageUrl = imageUrl; // Set the ImageUrl property
                    }
                    else
                    {
                        // Handle the scenario where no product is found with the provided productId
                        Response.Redirect("error-page.aspx");
                    }
                }
            }
        }


        private string GetOrderIdByProductId(string productId)
        {
            string orderId = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            string query = @"
        SELECT orderID
        FROM orderDetail
        WHERE productID = @ProductId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        orderId = result.ToString();
                    }
                }
            }

            return orderId;
        }



        protected void AddToCartButton_Click(object sender, EventArgs e)
        {
            // Check if the quantityTextBox.Text is not empty
            if (!string.IsNullOrEmpty(quantityTextBox.Text))
            {
                // Attempt to parse the quantity value
                if (int.TryParse(quantityTextBox.Text, out int quantity))
                {
                    // Check if the quantity is non-negative
                    if (quantity >= 0)
                    {
                        // Check if the quantity exceeds the limit
                        if (quantity > 10)
                        {
                            // If quantity exceeds the limit, display a message using the built-in alert
                            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please contact the baker via email if you wish to order more than 10 products.');", true);
                        }
                        else
                        {
                            // If quantity is within the limit, proceed with adding to cart
                            AddToCart(quantity);


                        }
                    }
                    else
                    {
                        // Handle the case where the quantity is negative using the built-in alert
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter a non-negative quantity.');", true);
                    }
                }
                else
                {
                    // Handle the case where the input is not a valid integer using the built-in alert
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter a valid quantity.');", true);
                }
            }
            else
            {
                // Handle the case where the quantity field is empty using the built-in alert
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter a quantity.');", true);
            }
        }





        private string InsertNewOrderAndGetOrderId(string customerId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Generate order ID
            string orderId = GenerateOrderId();

            // Get the current date and time for orderDate
            DateTime orderDate = DateTime.Now;

            // Placeholder for address and shippedAddress
            string address = ""; // Get the customer's address
            string shippedAddress = ""; // Placeholder for shipped address

            // Insert the order into the database
            string orderQuery = @"
INSERT INTO [order] (orderID, custID, orderDate, shippingStatus, isOrderConfirm, paymentStatus, isOrderCompleted, address, discount, shippedAddress)
VALUES (@orderId, @customerId, @orderDate, @shippingStatus, @isOrderConfirm, @paymentStatus, @isOrderCompleted, @address, @discount, @shippedAddress)";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Begin a transaction
                    SqlTransaction transaction = connection.BeginTransaction();

                    try
                    {
                        // Insert the order
                        using (SqlCommand command = new SqlCommand(orderQuery, connection, transaction))
                        {
                            command.Parameters.AddWithValue("@orderId", orderId);
                            command.Parameters.AddWithValue("@customerId", customerId);
                            command.Parameters.AddWithValue("@orderDate", orderDate);
                            command.Parameters.AddWithValue("@address", address);
                            command.Parameters.AddWithValue("@shippingStatus", ""); // Provide shipping status
                            command.Parameters.AddWithValue("@isOrderConfirm", ""); // Provide order confirmation status
                            command.Parameters.AddWithValue("@paymentStatus", ""); // Provide payment status
                            command.Parameters.AddWithValue("@isOrderCompleted", ""); // Provide order completion status
                            command.Parameters.AddWithValue("@discount", DBNull.Value); // Pass null for discount
                            command.Parameters.AddWithValue("@shippedAddress", shippedAddress);
                            // Execute the order insertion command
                            command.ExecuteNonQuery();
                        }

                        // Commit the transaction
                        transaction.Commit();

                        return orderId; // Return the generated order ID
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction if an error occurs
                        transaction.Rollback();
                        // Handle the exception or log it
                        throw ex;
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception or log it
                throw ex;
            }
        }


        private void AddToCart(int quantity)
        {
            // Retrieve the username from the cookie
            HttpCookie userCookie = Request.Cookies["User"];
            if (userCookie == null)
            {
                // Handle case where user cookie is not found
                Response.Redirect("error-page.aspx");
                return;
            }

            string username = userCookie["username"];

            // Use the username to query the database and retrieve the custID
            string custId = GetCurrentCustomerIdFromUsername(username);

            if (string.IsNullOrEmpty(custId))
            {
                // Handle case where custID is not found for the given username
                Response.Redirect("error-page.aspx");
                return;
            }

            // Retrieve productId from query string
            string productId = Request.QueryString["productId"];

            string originalOrderId = GetCurrentOrderIdForCustomer(custId);

            // Check if adding this product will exceed the limit of 10 units
            if (IsTotalQuantityExceeded(originalOrderId, productId, quantity, custId))
            {
                // If quantity exceeds the limit, display a message
                ScriptManager.RegisterStartupScript(this, GetType(), "maxQuantityExceeded", "alert('You can only add up to 10 units of this product to your cart.');", true);
                return; // Exit the method
            }

            // Check if the product belongs to the same baker as products already in the cart
            string bakerId = GetBakerIdForProduct(productId);
            if (!string.IsNullOrEmpty(originalOrderId) && !IsSameBakerAsExistingProducts(originalOrderId, bakerId))
            {
                // If the product belongs to a different baker, generate a new order ID
                originalOrderId = InsertNewOrderAndGetOrderId(custId);
            }
            else if (string.IsNullOrEmpty(originalOrderId))
            {
                // If the cart is empty, generate a new order ID
                originalOrderId = InsertNewOrderAndGetOrderId(custId);
            }

            // Insert or update the order detail associated with the current order ID
            if (CheckProductExistsInCart(originalOrderId, productId))
            {
                UpdateOrderQuantity(originalOrderId, productId, quantity);
            }
            else
            {
                // Pass the originalOrderId parameter to InsertOrderDetail method
                InsertOrderDetail(originalOrderId, productId, quantity);
            }
        }







        // Method to check if the product exists in the cart with the same baker
        private bool CheckProductExistsInCartWithSameBaker(string orderId, string productId)
        {
            // Check if orderId is null or empty
            if (string.IsNullOrEmpty(orderId))
            {
                // If orderId is not provided, return null
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
SELECT COUNT(*) 
FROM orderDetail od 
INNER JOIN product p ON od.productID = p.productID
INNER JOIN [order] o ON od.orderID = o.orderID
WHERE od.orderID = @orderId 
AND p.bakerID = (SELECT p2.bakerID FROM product p2 WHERE p2.productID = @productId)
AND od.productID = @productId
AND o.paymentStatus = 0"; // Only consider orders with paymentStatus = 0

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@productId", productId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    // If count > 0, product exists in the cart with the same baker
                    return count > 0;
                }
            }
        }

        // Method to retrieve the baker ID for a given product ID
        private string GetBakerIdForProduct(string productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = "SELECT bakerID FROM product WHERE productID = @productId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);

                    connection.Open();
                    object result = command.ExecuteScalar();
                    return result != null ? result.ToString() : null;
                }
            }
        }

        // Method to check if the product belongs to the same baker as existing products in the cart
        private bool IsSameBakerAsExistingProducts(string orderId, string bakerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
SELECT COUNT(*) 
FROM orderDetail od 
INNER JOIN product p ON od.productID = p.productID
INNER JOIN [order] o ON od.orderID = o.orderID
WHERE od.orderID = @orderId 
AND p.bakerID = @bakerId
AND o.paymentStatus = 0"; // Only consider orders with paymentStatus = 0

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@bakerId", bakerId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    // If count > 0, products in the cart belong to the same baker
                    return count > 0;
                }
            }
        }








        private string GetCurrentOrderIdForCustomer(string custId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to retrieve the current customer's orderID
            string query = @"
        SELECT orderID
        FROM [order]
        WHERE custID = @custId
        AND paymentStatus = 0;";

            // Variable to store the orderId
            string orderId = null;

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL query
                    command.Parameters.AddWithValue("@custId", custId);

                    connection.Open();
                    // Execute the query to retrieve orderId
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        orderId = result.ToString();
                    }
                }
            }

            return orderId;
        }


        // Method to check if the total quantity for a product in the cart exceeds the limit
        private bool IsTotalQuantityExceeded(string newOrderId, string productId, int quantity, string customerId)
        {
            // Check if newOrderId is null or empty
            if (string.IsNullOrEmpty(newOrderId))
            {
                // If newOrderId is not provided, return false
                return false;
            }

            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to fetch the total quantity of the specified product in the cart for the customer's new order
            string query = @"
SELECT ISNULL(SUM(CAST(ISNULL(od.amount, 0) AS INT)), 0) AS totalQuantity
FROM [orderDetail] od
INNER JOIN [order] o ON od.orderID = o.orderID
WHERE od.productID = @productId AND od.orderID = @newOrderId AND o.custID = @customerId";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL query
                    command.Parameters.AddWithValue("@newOrderId", newOrderId);
                    command.Parameters.AddWithValue("@productId", productId);
                    command.Parameters.AddWithValue("@customerId", customerId);

                    connection.Open();
                    int totalQuantity = (int)command.ExecuteScalar();

                    // If the total quantity plus the quantity being added exceeds 10
                    if (totalQuantity + quantity > 10)
                    {
                        // Return true to indicate that the quantity limit is exceeded
                        return true;
                    }
                }
            }

            // Return false to indicate that the quantity limit is not exceeded
            return false;
        }


        // Method to check if the product already exists in the cart
        private bool CheckProductExistsInCart(string orderId, string productId)
        {
            // Check if orderId is null or empty
            if (string.IsNullOrEmpty(orderId))
            {
                // If orderId is not provided, return null
                return false;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
        SELECT COUNT(*) 
        FROM orderDetail 
        WHERE orderID = @orderId 
        AND productID = @productId
        AND orderID NOT IN (SELECT orderID FROM [dbo].[order] WHERE paymentStatus = 1)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@productId", productId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    // If count > 0, product exists in the cart
                    return count > 0;
                }
            }
        }

        // Method to insert a new order detail
        private void InsertOrderDetail(string orderId, string productId, int quantity)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to insert new order detail
            string query = @"
INSERT INTO [orderDetail] (orderID, productID, amount)
VALUES (@orderId, @productId, @amount)";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL query
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@productId", productId);
                    command.Parameters.AddWithValue("@amount", quantity);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Display success message using Swal.fire
                        string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Item added to cart successfully!',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(function () {
                        window.location = 'shop.aspx';
                    });
                </script>";
                        ScriptManager.RegisterStartupScript(this, GetType(), "insertSuccess", script, false);
                    }
                    else
                    {
                        // Display failure message using Swal.fire
                        string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Failed to add item to cart.',
                        showConfirmButton: false,
                        timer: 1500
                    });
                </script>";
                        ScriptManager.RegisterStartupScript(this, GetType(), "insertFailed", script, false);
                    }
                }
            }
        }


        private string GetOrderIdForCustomer(string customerId)
        {
            string orderId = "";

            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to fetch the order ID for the given customer ID
            string query = @"SELECT orderID FROM [order] WHERE custID = @customerId AND isOrderCompleted = 0";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add customerId parameter to the SQL query
                    command.Parameters.AddWithValue("@customerId", customerId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Check if any rows are returned
                    if (reader.Read())
                    {
                        // Retrieve order ID from the data reader
                        orderId = reader["orderID"].ToString();
                    }
                }
            }

            return orderId;
        }


        private bool IsSameBaker(string productId, string orderId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to check if the product belongs to the same baker as the products already in the cart
            string query = @"
SELECT TOP 1 p.bakerID
FROM product p
INNER JOIN orderDetail od ON p.productID = od.productID
WHERE od.orderID = @orderId
AND p.productID = @productId";

            // Variable to store the baker ID of the current product
            string currentBakerId = "";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL query
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@productId", productId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Check if any rows are returned
                    if (reader.Read())
                    {
                        // Retrieve baker ID from the data reader
                        currentBakerId = reader["bakerID"].ToString();
                    }
                }
            }

            // Retrieve the baker ID of the products already in the cart
            string previousBakerId = GetBakerIdFromOrder(orderId);

            // Check if the current product belongs to the same baker as the products already in the cart
            return currentBakerId == previousBakerId;
        }


        private string GetBakerIdFromOrder(string orderId)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to fetch the baker ID from the order
            string query = @"
SELECT TOP 1 p.bakerID
FROM product p
INNER JOIN orderDetail od ON p.productID = od.productID
WHERE od.orderID = @orderId";

            // Variable to store the baker ID
            string bakerId = "";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add orderId parameter to the SQL query
                    command.Parameters.AddWithValue("@orderId", orderId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    // Check if any rows are returned
                    if (reader.Read())
                    {
                        // Retrieve baker ID from the data reader
                        bakerId = reader["bakerID"].ToString();
                    }
                }
            }

            return bakerId;
        }


        private void UpdateOrderQuantity(string orderId, string productId, int quantity)
        {
            // Retrieve connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to update the quantity of an existing order detail
            string query = @"
UPDATE orderDetail 
SET amount = amount + @quantity
WHERE orderID = @orderId 
AND productID = @productId";

            // Create a SqlConnection object and SqlCommand object
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters to the SQL query
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@productId", productId);
                    command.Parameters.AddWithValue("@quantity", quantity);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Display success message using Swal.fire
                        string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'success',
                        title: 'Item quantity updated in cart successfully!',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(function () {
                        window.location = 'shop.aspx';
                    });
                </script>";
                        ScriptManager.RegisterStartupScript(this, GetType(), "updateSuccess", script, false);
                    }
                    else
                    {
                        // Display failure message using Swal.fire
                        string script = @"
                <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                <script>
                    Swal.fire({
                        icon: 'error',
                        title: 'Failed to update item quantity in cart.',
                        showConfirmButton: false,
                        timer: 1500
                    });
                </script>";
                        ScriptManager.RegisterStartupScript(this, GetType(), "updateFailed", script, false);
                    }
                }
            }
        }


        private string GenerateOrderId()
        {
            Random rand = new Random();
            int randomNumber = rand.Next(1000, 10000); // Generates a number between 1000 and 9999 inclusive

            // Concatenate the random number with "ORD" and the current timestamp
            return "ORD" + DateTime.Now.ToString("yyyyMMddHHmmss") + randomNumber.ToString();
        }
    }
}
