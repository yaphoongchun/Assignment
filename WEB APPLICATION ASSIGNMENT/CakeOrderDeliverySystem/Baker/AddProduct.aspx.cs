using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCategoriesDropDown();
                // Generate and display the product ID when the page loads for the first time
                string productId = GenerateProductId();
                txtProductID.Text = productId;
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Retrieve input values
            string productId = txtProductID.Text;
            string productName = txtProductName.Text;
            string description = txtDesc.Text;
            decimal price = decimal.Parse(txtProdPrice.Text);
            int availableStatus = int.Parse(ddlProdStatus.SelectedValue);
            string productImage = SaveProductImage(fileProductImage); // Get the saved image path
            string selectedCategoryId = ddlCategory.SelectedValue; // Get the selected category ID
            string productSize = ddlProductSize.Text;
            string ingredient = txtIngredient.Text;
            string allegrens = txtAllegrens.Text;
            decimal avgRate = decimal.Parse(txtAvgRate.Text);

            // Retrieve the username from the cookie
            string username = Request.Cookies["User"]["username"].ToString();

            // Retrieve the current user's baker ID using the username
            string bakerId = GetCurrentBakerIdFromUsername(username);

            // Fetch the category name based on the selected category ID
            string categoryName = GetCategoryName(selectedCategoryId);

            // Display the category name
            lblCategoryName.Text = categoryName;
            // Insert statement
            string insertQuery = @"
        INSERT INTO [dbo].[product] 
            ([productID], [productName], [description], [price], [productImage], [bakerID], [catID], [productSize], [ingredient], [allegrens], [avgRate], [availableStatus]) 
        VALUES 
            (@ProductID, @ProductName, @Description, @Price, @ProductImage, @BakerID, @CatID, @ProductSize, @Ingredient, @Allegrens, @AvgRate, @AvailableStatus)";

            // Connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Establish connection and execute insert statement
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    // Add parameters to the command
                    command.Parameters.AddWithValue("@ProductID", productId);
                    command.Parameters.AddWithValue("@ProductName", productName);
                    command.Parameters.AddWithValue("@Description", description);
                    command.Parameters.AddWithValue("@Price", price);
                    command.Parameters.AddWithValue("@AvailableStatus", availableStatus);
                    command.Parameters.AddWithValue("@ProductImage", productImage);
                    command.Parameters.AddWithValue("@BakerID", bakerId);
                    command.Parameters.AddWithValue("@CatID", selectedCategoryId); // Add category ID parameter
                    command.Parameters.AddWithValue("@ProductSize", productSize);
                    command.Parameters.AddWithValue("@Ingredient", ingredient);
                    command.Parameters.AddWithValue("@Allegrens", allegrens);
                    command.Parameters.AddWithValue("@AvgRate", avgRate);

                    // Open connection and execute the command
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }

            string script = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Product Added Successfully!',
        showConfirmButton: false,
        timer: 1500
    }).then(function () {
        window.location.href = 'bakerProductManage.aspx';
    });
</script>";
            ClientScript.RegisterStartupScript(this.GetType(), "AddProductSuccess", script);
        }
        private string GetCurrentBakerIdFromUsername(string username)
        {
            string query = @"
        SELECT b.bakerID 
        FROM [dbo].[baker] b 
        INNER JOIN [dbo].[aspnet_Users] u ON b.bakerID = u.UserId 
        WHERE u.UserName = @Username";

            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            string bakerId = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);

                    connection.Open();
                    bakerId = command.ExecuteScalar()?.ToString();
                }
            }

            return bakerId;
        }


        private string GenerateProductId()
        {
            // Generate a GUID and concatenate it with the prefix "P" to create the product ID
            string productId = "P" + Guid.NewGuid().ToString("N");
            return productId;
        }

        private string GetCategoryName(string categoryId)
        {
            string categoryName = "";

            // Write your SQL query to fetch the category name
            string query = "SELECT [catName] FROM [dbo].[category] WHERE [catID] = @CatID";

            // Retrieve the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Establish connection and execute the query
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameter to the command
                    command.Parameters.AddWithValue("@CatID", categoryId);

                    // Open connection and execute the command
                    connection.Open();
                    categoryName = command.ExecuteScalar()?.ToString();
                }
            }

            return categoryName;
        }

        private void PopulateCategoriesDropDown()
        {
            // Retrieve the connection string from web.config
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // Write your SQL query to fetch categories
            string query = "SELECT [catID], [catName] FROM [dbo].[category]";

            // Create a SqlConnection and a SqlCommand
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Open the connection
                    connection.Open();

                    // Execute the command and retrieve the data
                    SqlDataReader reader = command.ExecuteReader();

                    // Bind the data to the DropDownList
                    ddlCategory.DataSource = reader;
                    ddlCategory.DataTextField = "catName"; // Displayed text
                    ddlCategory.DataValueField = "catID"; // Value associated with the displayed text
                    ddlCategory.DataBind();

                    // Close the reader and the connection
                    reader.Close();
                    connection.Close();
                }
            }

            // Add a default option if needed
            ddlCategory.Items.Insert(0, new ListItem("Select Category", "-1"));
        }

        private string SaveProductImage(FileUpload fileUpload)
        {
            // Check if a file was uploaded
            if (fileUpload.HasFile)
            {
                try
                {
                    // Save the uploaded file to a folder in your application
                    string fileName = Path.GetFileName(fileUpload.FileName);
                    string folderPath = Server.MapPath("~/img/product/");
                    string filePath = Path.Combine(folderPath, fileName);
                    fileUpload.SaveAs(filePath);

                    // Return the relative path of the saved image
                    return "~/img/product/" + fileName;
                }
                catch (Exception ex)
                {
                    // Handle any potential errors when saving the file
                    // You may want to log the error or display a message to the user
                    throw new Exception("Error saving product image: " + ex.Message);
                }
            }
            else
            {
                // If no file was uploaded, return an empty string
                return string.Empty;
            }
        }
    }
}