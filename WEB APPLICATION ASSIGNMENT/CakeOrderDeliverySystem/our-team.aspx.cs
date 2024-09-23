using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace CakeOrderDeliverySystem
{
    public partial class out_team : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMenuData();
            }
        }

        private void BindMenuData()
        {
            // Create a list of menu items
            var menuItems = new List<MenuItem>
            {
                new MenuItem { Text = "Home", Url = "index.aspx" },
                new MenuItem { Text = "About Us", Url = "about-us.aspx" },
                new MenuItem { Text = "Our Team", Url = "our-team.aspx" }
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