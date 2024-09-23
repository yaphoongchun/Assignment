using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMenuData();
                BindProductData();
            }
        }
        private void BindProductData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
            string query = "SELECT * FROM product ORDER BY productName ASC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ProductRepeater.DataSource = dt;
                    ProductRepeater.DataBind();
                    con.Close();
                }
            }
        }

        private void BindMenuData()
        {
            // Create a list of menu items
            var menuItems = new List<MenuItem>
            {
                new MenuItem { Text = "Home", Url = "index.aspx" },
                new MenuItem { Text = "Menu", Url = "menu.aspx" }
            };

            // Bind the list to the repeater control
            MenuRepeater.DataSource = menuItems;
            MenuRepeater.DataBind();
        }

        // Define a class for menu items
        public class MenuItem
        {
            public string Text { get; set; }
            public string Url { get; set; }
        }

    }
}