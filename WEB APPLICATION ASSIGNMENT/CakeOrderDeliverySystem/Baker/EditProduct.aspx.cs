using System;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class EditProduct : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if productId is provided in query string
                if (!string.IsNullOrEmpty(Request.QueryString["productId"]))
                {
                    string productId = Request.QueryString["productId"];

                    // Fetch product details using productId
                    DataTable dtProduct = GetProductDetails(productId);

                    // Check if product details are retrieved successfully
                    if (dtProduct != null && dtProduct.Rows.Count > 0)
                    {
                        // Populate the form fields with product details
                        DataRow row = dtProduct.Rows[0];
                        txtProductID.Text = row["productID"].ToString();
                        txtProductName.Text = row["productName"].ToString();
                        txtDesc.Text = row["description"].ToString();
                        txtProdPrice.Text = row["price"].ToString();
                        ddlProdStatus.SelectedValue = row["availableStatus"].ToString();
                        string imageUrl = row["productImage"].ToString();
                        imgProductImage.ImageUrl = imageUrl;
                        // Populate other fields as needed
                    }
                    else
                    {
                        // Handle case where product details are not found
                        // (e.g., display error message or redirect to another page)
                    }
                }
                else
                {
                    // Handle case where productId is not provided
                    // (e.g., display error message or redirect to another page)
                }
            }
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            // Get the edited product details from the form
            string productId = txtProductID.Text;
            string productName = txtProductName.Text;
            string description = txtDesc.Text;
            decimal price = decimal.Parse(txtProdPrice.Text); // You may need validation here
            bool status = ddlProdStatus.SelectedValue == "1"; // Assuming "1" means available

            // Handle file upload
            if (fileProductImage.HasFile)
            {
                // Save the file to the server
                HttpPostedFile uploadedFile = fileProductImage.PostedFile;
                UpdateProductWithImage(productId, productName, description, price, status, uploadedFile);
            }
            else
            {
                // If no file is uploaded, update product without changing the image
                UpdateProduct(productId, productName, description, price, status);
            }

            // Redirect to a confirmation page or back to the product list page
            string script = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Product Edited Successfully!',
        showConfirmButton: false,
        timer: 1500
    }).then(function () {
        window.location.href = 'bakerProductManage.aspx';
    });
</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "EditProductSuccess", script);
        }

        private void UpdateProduct(string productId, string productName, string description, decimal price, bool status)
        {
            // Construct the SQL update statement
            string sql = @"UPDATE [dbo].[product]
                   SET [productName] = @productName,
                       [description] = @description,
                       [price] = @price,
                       [availableStatus] = @status
                   WHERE [productID] = @productId";

            // Execute the SQL command
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@productName", productName);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@productId", productId);
                cmd.ExecuteNonQuery();
            }
        }

        private void UpdateProductWithImage(string productId, string productName, string description, decimal price, bool status, HttpPostedFile prodImage)
        {
            // Handle file upload
            if (prodImage != null && prodImage.ContentLength > 0)
            {
                // Get file name
                string filename = Path.GetFileName(prodImage.FileName);
                // Specify the folder where you want to save the file
                string uploadFolderPath = Server.MapPath("~/img/product/sale-product/");
                // Combine folder path with the file name to get the full path
                string filePath = Path.Combine(uploadFolderPath, filename);
                // Save the file to the server
                prodImage.SaveAs(filePath);

                // Save the relative path to the database
                string linkPath = "~/img/product/sale-product/" + filename;

                // Construct the SQL update statement
                string sql = @"UPDATE [dbo].[product]
                       SET [productName] = @productName,
                           [description] = @description,
                           [price] = @price,
                           [availableStatus] = @status,
                           [productImage] = @productImage
                       WHERE [productID] = @productId";

                // Execute the SQL command
                string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@productName", productName);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@price", price);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@productId", productId);
                    cmd.Parameters.AddWithValue("@productImage", linkPath);
                    cmd.ExecuteNonQuery();
                }
            }
            else
            {
                // If no file is uploaded, update product without changing the image
                UpdateProduct(productId, productName, description, price, status);
            }
        }
        private DataTable GetProductDetails(string productId)
        {
            DataTable dtProduct = new DataTable();
            string sql = "SELECT baker.bakerName, category.catName, product.productID, product.productName, product.description, product.productSize, product.price, product.ingredient, product.allegrens, product.productImage, product.avgRate, product.availableStatus " +
                         "FROM baker " +
                         "INNER JOIN product ON baker.bakerID = product.bakerID " +
                         "INNER JOIN category ON product.catID = category.catID " +
                         "WHERE product.productID = @productId";

            // Execute SQL query
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@productId", productId);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dtProduct);
            }

            return dtProduct;
        }
    }
}