using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the current customer's username from the cookie
                string username = "";
                HttpCookie userCookie = Request.Cookies["User"];
                if (userCookie != null)
                {
                    username = userCookie["username"];

                    // Get the current customer's ID based on the username
                    string customerId = GetCurrentCustomerIdFromUsername(username);

                    if (!string.IsNullOrEmpty(customerId))
                    {
                        // Display the customer's orders in the cart
                        DisplayCustomerOrders(customerId);
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

            if (IsPostBack)
            {
                // Get the current customer's username from the cookie
                string username = "";
                HttpCookie userCookie = Request.Cookies["User"];
                if (userCookie != null)
                {
                    username = userCookie["username"];

                    // Get the current customer's ID based on the username
                    string customerId = GetCurrentCustomerIdFromUsername(username);

                    if (!string.IsNullOrEmpty(customerId))
                    {
                        // Call AddDeleteButton for each order during postback
                        DisplayCustomerOrders(customerId);
                    }
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
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        customerId = result.ToString();
                    }
                }
            }

            return customerId;
        }

        protected void DeleteProduct_Click(object sender, EventArgs e)
        {
            // Get the clicked button
            Button btnDelete = (Button)sender;

            // Get the product ID and order ID from data attributes
            string productId = btnDelete.Attributes["data-productid"];
            string orderId = btnDelete.Attributes["data-orderid"];

            // Call a method to delete the product from the cart using productId and orderId
            DeleteProductFromCart(productId, orderId);
        }

        protected void DeleteProductFromCart(string productId, string orderId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Delete the order detail record associated with the product and order ID
            string deleteOrderDetailQuery = "DELETE FROM [orderDetail] WHERE [orderID] = @OrderID AND [productID] = @ProductID";

            // Delete the order record if there are no more order details associated with it
            string deleteOrderQuery = "DELETE FROM [order] WHERE [orderID] = @OrderID AND NOT EXISTS (SELECT 1 FROM [orderDetail] WHERE [orderID] = @OrderID)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Delete order detail
                using (SqlCommand command = new SqlCommand(deleteOrderDetailQuery, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderId);
                    command.Parameters.AddWithValue("@ProductID", productId);
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        // If deletion was successful, display a SweetAlert message
                        string script = @"
                    <script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
                    <script>
                        Swal.fire({
                            icon: 'success',
                            title: 'Product Deleted Successfully!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(function () {
                            window.location.href = 'cart.aspx';
                        });
                    </script>";
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteSuccessScript", script, false);
                    }
                }

                // Delete order if no more order details
                using (SqlCommand command = new SqlCommand(deleteOrderQuery, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderId);
                    command.ExecuteNonQuery();
                }
            }

            // Refresh the cart display after deletion
            DisplayCustomerOrders(GetCurrentCustomerIdFromUsername(GetCurrentUsername()));
        }

        private string GetCurrentUsername()
        {
            // Retrieve the username from the user cookie
            HttpCookie userCookie = Request.Cookies["User"];
            return userCookie != null ? userCookie["username"] : null;
        }





        protected void DisplayCustomerOrders(string customerId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL query to retrieve the customer's orders along with product image URLs and payment status
            string query = @"
SELECT p.productID, p.productName, p.price, od.amount AS quantity, p.productImage, o.paymentStatus, o.orderID
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
                        if (reader.HasRows)
                        {
                            decimal subtotal = 0;

                            // Add header row
                            HtmlTableRow headerRow = new HtmlTableRow();
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Preview" }); // Add column for image preview
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Product" });
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Price" });
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Quantity" });
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Payment Status" }); // Add column for payment status
                            headerRow.Cells.Add(new HtmlTableCell { InnerHtml = "Action" }); // Add column for action //new added
                            cartTable.Rows.Add(headerRow);

                            // Loop through each order and add it to the table
                            while (reader.Read())
                            {
                                string productName = reader["productName"].ToString();
                                decimal price = Convert.ToDecimal(reader["price"]);
                                int quantity = Convert.ToInt32(reader["quantity"]);
                                string imageUrl = reader["productImage"].ToString(); // Get the image URL
                                bool paymentStatus = Convert.ToBoolean(reader["paymentStatus"]); // Get the payment status as a boolean
                                string productId = reader["productID"].ToString();
                                string orderId = reader["orderID"].ToString();

                                // Convert payment status to string representation
                                string paymentStatusString = paymentStatus ? "Done" : "Not Done";

                                // Create a new row
                                HtmlTableRow row = new HtmlTableRow();

                                // Add cell for product image preview
                                HtmlTableCell imageCell = new HtmlTableCell();
                                Image imageControl = new Image();
                                imageControl.ImageUrl = imageUrl;
                                imageControl.Width = 100; // Set the width of the image
                                imageCell.Controls.Add(imageControl);
                                row.Cells.Add(imageCell);

                                // Add cell for product name
                                row.Cells.Add(new HtmlTableCell { InnerHtml = productName });

                                // Add cell for price
                                row.Cells.Add(new HtmlTableCell { InnerHtml = price.ToString("C") });

                                // Add cell for quantity
                                row.Cells.Add(new HtmlTableCell { InnerHtml = quantity.ToString() });

                                // Add cell for payment status
                                row.Cells.Add(new HtmlTableCell { InnerHtml = paymentStatusString });

                                // Add cell for delete button
                                AddDeleteButton(row, productId, orderId);

                                // Add the row to the table
                                cartTable.Rows.Add(row);

                                // Calculate subtotal
                                subtotal += price * quantity;
                            }

                            // Display subtotal
                            lblSubtotal.Text = subtotal.ToString("C");

                            // You can add code here to calculate and display discount if applicable

                            // Calculate and display total
                            lblTotal.Text = subtotal.ToString("C");
                        }
                        else
                        {
                            // If no orders found, display a message
                            cartTable.Rows.Add(new HtmlTableRow { Cells = { new HtmlTableCell { InnerHtml = "No items in the cart." } } });
                        }
                    }
                }
            }
        }

        protected void AddDeleteButton(HtmlTableRow row, string productId, string orderId)
        {
            // Create a unique ID for the delete button
            string buttonId = "btnDelete_" + orderId + "_" + productId;

            // Add cell for delete button
            Button btnDelete = new Button();
            btnDelete.ID = buttonId; // Use the unique ID
            btnDelete.Text = "Delete";
            btnDelete.Click += DeleteProduct_Click; // Assign event handler
            btnDelete.CssClass = "btn btn-danger"; // Add CSS class for styling
            btnDelete.Attributes.Add("data-productid", productId); // Add data attribute for product ID
            btnDelete.Attributes.Add("data-orderid", orderId); // Add data attribute for order ID
            HtmlTableCell deleteCell = new HtmlTableCell();
            deleteCell.Controls.Add(btnDelete);
            row.Cells.Add(deleteCell);
        }

    }
}
