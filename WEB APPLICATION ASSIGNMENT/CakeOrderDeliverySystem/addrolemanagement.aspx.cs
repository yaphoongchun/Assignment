using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem
{
    public partial class addrolemanagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnInsertRole_Click(object sender, EventArgs e)
        {
            try
            {
                Roles.CreateRole(txtRole.Text);
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

    }
}