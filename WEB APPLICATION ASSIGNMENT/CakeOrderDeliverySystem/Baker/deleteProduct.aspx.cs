using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class deleteProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the request contains the productId query parameter
            if (!string.IsNullOrEmpty(Request.QueryString["productId"]))
            {
                string productId = Request.QueryString["productId"];

                // Retrieve the product name associated with the product ID
                string productName = GetProductName(productId);

                // Display a confirmation message using JavaScript
                ClientScript.RegisterStartupScript(this.GetType(), "ConfirmDelete", $"confirmDelete('{productId}', '{productName}');", true);
            }
            else
            {
                // If productId query parameter is not provided, redirect back to the product management page
                Response.Redirect("bakerProductManage.aspx");
            }
        }

        private string GetProductName(string productId)
        {
            string productName = "";
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT productName FROM product WHERE productID = @ProductId";
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    try
                    {
                        conn.Open();
                        productName = (string)cmd.ExecuteScalar();
                    }
                    catch (SqlException ex)
                    {
                        // Handle exception
                    }
                }
            }

            return productName;
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            // Retrieve the productId from the query parameter
            string productId = Request.QueryString["productId"];

            // Perform the deletion action
            DeleteProduct(productId);

            // Redirect back to the product management page
            Response.Redirect("bakerProductManage.aspx");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect back to the product management page
            Response.Redirect("bakerProductManage.aspx");
        }



        private void DeleteProduct(string productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;

                    // Check if there are existing reservations for the product
                    cmd.CommandText = "SELECT COUNT(*) FROM orderDetail WHERE productID = @ProductId";
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    try
                    {
                        conn.Open();
                        int reservationCount = (int)cmd.ExecuteScalar();

                        if (reservationCount > 0)
                        {
                            // Product has existing reservations, display error message using Swal.fire
                            string script = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'This product cannot be deleted because it has existing reservations.',
        showConfirmButton: false,
        timer: 1500
    }).then(function() {
        window.location.href = 'bakerOrders.aspx'; // Redirect to orders page
    });
</script>";

                            // Register the script to execute on the client side
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowSwalError", script);

                            return;
                        }
                        else
                        {
                            // No existing reservations, proceed with deletion
                            cmd.CommandText = "DELETE FROM product WHERE productID = @ProductId";
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Product deleted successfully, display success message using Swal.fire
                                string successScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: 'Product deleted successfully!',
        showConfirmButton: false,
        timer: 1500
    }).then(function() {
        window.location.href = 'bakerProducts.aspx'; // Redirect to products page
    });
</script>";
                                // Register the script to execute on the client side
                                ClientScript.RegisterStartupScript(this.GetType(), "ShowSwalSuccess", successScript);
                            }
                            else
                            {
                                // Product deletion failed or product not found, display error message using Swal.fire
                                string errorScript = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Product deletion failed or product not found.',
        showConfirmButton: false,
        timer: 1500
    }).then(function() {
        window.location.href = 'bakerProducts.aspx'; // Redirect to products page
    });
</script>";
                                // Register the script to execute on the client side
                                ClientScript.RegisterStartupScript(this.GetType(), "ShowSwalError", errorScript);
                            }
                        }
                    }
                    catch (SqlException ex)
                    {
                        // Handle exception
                    }
                }
            }
        }



    }
}
