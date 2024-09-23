using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class bakerProductManage : System.Web.UI.Page
    {
        protected HtmlGenericControl editFormOverlay;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is authenticated
                if (User.Identity.IsAuthenticated)
                {
                    // Retrieve baker username from cookies
                    string username = Request.Cookies["User"]["username"].ToString();

                    // Retrieve baker ID using username
                    string bakerID = GetCurrentBakerIdFromUsername(username);

                    if (!string.IsNullOrEmpty(bakerID))
                    {
                        // Bind product data for the logged-in baker
                        BindProductData(bakerID);
                    }
                    else
                    {
                        // Handle the case where baker ID is not found
                        // You can redirect the user or display an error message
                    }
                }
                else
                {
                    // Handle the case where the user is not authenticated
                    // Redirect the user to the login page or display an error message
                }
            }
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
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        bakerId = result.ToString();
                    }
                }
            }

            return bakerId;
        }

        private void BindProductData(string bakerID)
        {
            // Implement code to fetch product data from your database
            // For example:
            DataTable dt = GetProductDataFromDatabase(bakerID);
            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }

        private DataTable GetProductDataFromDatabase(string bakerID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT baker.bakerName, category.catName, product.productID, product.productName, product.description, product.productSize, product.price, product.ingredient, product.allegrens, product.productImage, product.avgRate, product.availableStatus FROM baker INNER JOIN product ON baker.bakerID = product.bakerID INNER JOIN category ON product.catID = category.catID WHERE product.bakerID = @BakerID";
                    cmd.Parameters.AddWithValue("@BakerID", bakerID);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        dt.Load(reader);
                    }
                    catch (SqlException ex)
                    {
                        // Handle exception
                        // For example, log the error or display a message to the user
                    }
                }
            }

            return dt;
        }
        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // This method can be left empty if you don't need to handle any specific actions.
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            // Handle the logic for adding a new product here
            // For example, you can redirect the user to a page for adding a new product
            Response.Redirect("AddProduct.aspx");
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            // Redirect to EditProduct.aspx page with the product ID as query parameter
            Button btnEdit = (Button)sender;
            string productId = btnEdit.CommandArgument;
            Response.Redirect("EditProduct.aspx?productId=" + productId);
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            string productId = btnDelete.CommandArgument;

            // Redirect to deleteProduct.aspx with product ID as query parameter
            Response.Redirect($"deleteProduct.aspx?productId={productId}");
        }
    }
}