using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class bakerReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve baker username from cookies
                string username = Request.Cookies["User"]["username"].ToString();

                // Retrieve baker ID using username
                string bakerID = GetCurrentBakerIdFromUsername(username);

                if (!string.IsNullOrEmpty(bakerID))
                {
                    // Bind the table with data for the logged-in baker
                    BindTable(bakerID);
                }
                else
                {
                    // Handle the case where baker ID is not found
                    // You can redirect the user or display an error message
                }
            }
        }

        protected void BindTable(string bakerID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = @"
                SELECT product.productName, product.price, orderDetail.amount, [order].orderDate, category.catName 
FROM [order]
INNER JOIN orderDetail ON [order].orderID = orderDetail.orderID 
INNER JOIN product ON orderDetail.productID = product.productID 
INNER JOIN category ON product.catID = category.catID 
INNER JOIN baker ON product.bakerID = baker.bakerID 
INNER JOIN customer ON [order].custID = customer.custID 
WHERE baker.bakerID = @BakerID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@BakerID", bakerID);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                string tableRows = "";

                while (reader.Read())
                {
                    tableRows += "<tr>";
                    tableRows += "<td>" + reader["productName"] + "</td>";
                    tableRows += "<td>" + reader["price"] + "</td>";
                    tableRows += "<td>" + reader["amount"] + "</td>";
                    tableRows += "<td>" + ((DateTime)reader["orderDate"]).ToString("yyyy/MM/dd") + "</td>";
                    tableRows += "<td>" + reader["catName"] + "</td>";
                    tableRows += "</tr>";
                }
                reader.Close();

                litTableData.Text = tableRows; // Set the dynamically generated HTML to the Literal control
            }
        }

        private string GetCurrentBakerIdFromUsername(string username)
        {
            string query = @"
                SELECT bakerID 
                FROM baker 
                INNER JOIN aspnet_Users ON baker.bakerID = aspnet_Users.UserId 
                WHERE aspnet_Users.UserName = @Username";

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
    }
}