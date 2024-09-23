using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class ChangingStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the order ID is passed in the query string
                if (Request.QueryString["orderID"] != null)
                {
                    // Get the order ID from the query string
                    string orderID = Request.QueryString["orderID"].ToString();

                    // Populate the Order ID label
                    lblOrderID.Text = orderID;
                }
            }
        }

        protected void btnSaveStatus_Click(object sender, EventArgs e)
        {
            // Get the selected order ID
            string orderID = lblOrderID.Text;

            // Get the selected shipping status and order completed values
            string shippingStatus = ddlShippingStatus.SelectedValue;
            string orderCompleted = ddlOrderCompleted.SelectedValue;

            // Update the order status in the database
            UpdateOrderStatus(orderID, shippingStatus, orderCompleted);
            string script = @"
<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>
<script>
    Swal.fire({
        icon: 'success',
        title: 'Status Changed Successfully!',
        showConfirmButton: false,
        timer: 1500
    }).then(function () {
        window.location.href = 'bakerOrders.aspx';
    });
</script>";

            ClientScript.RegisterStartupScript(this.GetType(), "StatusChangedSuccess", script);
        }

        private void UpdateOrderStatus(string orderID, string shippingStatus, string orderCompleted)
        {
            // Connection string
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;

            // SQL update statement
            string updateQuery = "UPDATE [dbo].[order] " +
                                 "SET [shippingStatus] = @ShippingStatus, [isOrderCompleted] = @OrderCompleted " +
                                 "WHERE [orderID] = @OrderID";

            // Create and open connection
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Create command
                SqlCommand command = new SqlCommand(updateQuery, connection);

                // Add parameters
                command.Parameters.AddWithValue("@ShippingStatus", shippingStatus);
                command.Parameters.AddWithValue("@OrderCompleted", orderCompleted);
                command.Parameters.AddWithValue("@OrderID", orderID);

                // Execute the update
                command.ExecuteNonQuery();
            }
        }
    }
}