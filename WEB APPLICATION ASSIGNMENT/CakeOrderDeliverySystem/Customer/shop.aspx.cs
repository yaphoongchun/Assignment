using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class shop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Display products without sorting on initial page load
                DisplayProducts();
                DisplayProductCount();
            }
        }

        protected void SortProducts(object sender, EventArgs e)
        {
            // Sort and display products when sorting event is triggered
            SortAndDisplayProducts();
        }

        private void SortAndDisplayProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"SELECT productName, price, productImage, productId
                             FROM product
                             WHERE availableStatus = 1";

            string selectedSortOption = sortSelect.SelectedValue;
            if (selectedSortOption == "nameAZ")
            {
                query += " ORDER BY productName ASC";
            }
            else if (selectedSortOption == "priceLowToHigh")
            {
                query += " ORDER BY price ASC";
            }

            DisplayProductsFromDatabase(connectionString, query);
        }

        private void DisplayProducts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"SELECT productId, productName, price, productImage
                             FROM product
                             WHERE availableStatus = 1";

            DisplayProductsFromDatabase(connectionString, query);
        }

        private void DisplayProductsFromDatabase(string connectionString, string query)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        ProductRepeater.DataSource = reader;
                        ProductRepeater.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions here
                    }
                }
            }
        }

        private void DisplayProductCount()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string countQuery = @"SELECT COUNT(*) AS TotalCount
                                  FROM Product
                                  WHERE AvailableStatus = 1";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(countQuery, connection))
                {
                    try
                    {
                        connection.Open();
                        int totalCount = (int)command.ExecuteScalar();
                        productCountLabel.Text = $"Total available products: {totalCount}";
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions here
                    }
                }
            }
        }

        private void FilterProductsByCategory(string categoryName)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
        SELECT product.productId, category.catName, product.productName, product.price, product.productImage
        FROM category
        INNER JOIN product ON category.catID = product.catID
        WHERE category.catName = @CategoryName";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add the parameter for categoryName
                    command.Parameters.AddWithValue("@CategoryName", categoryName);

                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        // Create a DataTable to store the results
                        DataTable dt = new DataTable();
                        dt.Load(reader);

                        // Bind the DataTable to the ProductRepeater
                        ProductRepeater.DataSource = dt;
                        ProductRepeater.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions here
                    }
                }
            }
        }

        protected void AddToCartButton_Click(object sender, EventArgs e)
        {
            // Get the product ID from the CommandArgument of the clicked button
            Button addToCartButton = (Button)sender;
            string productId = addToCartButton.CommandArgument;

            // Redirect to the product detail page with the product ID in the query string
            Response.Redirect($"productDetails.aspx?ProductId={productId}");
        }

        protected void FilterProducts_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string categoryName = btn.CommandArgument;
            FilterProductsByCategory(categoryName);
        }

    }
}
