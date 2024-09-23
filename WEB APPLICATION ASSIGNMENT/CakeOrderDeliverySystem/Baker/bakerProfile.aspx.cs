using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Baker
{
    public partial class bakerProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string id = Session["userId"].ToString();
                    userid.Value = id;
                }
                catch (SystemException ex)
                {
                    Response.Write("<script type='text/javascript'> " +
                        "alert('Session expired, please login again.');" +
                        "window.location.href = '../login.aspx'; </script>");
                }

                // Bind FormView to the user data retrieved from Membership API
                MembershipUser user = Membership.GetUser(User.Identity.Name);
                FormViewBakerProfile.DataSource = new[] { user };
                FormViewBakerProfile.DataBind();
            }
        }

        protected void btnUpdateBaker_Click(object sender, EventArgs e)
        {
            TextBox Username = (TextBox)FormViewBakerProfile.FindControl("username");
            TextBox Email = (TextBox)FormViewBakerProfile.FindControl("email");
            TextBox Password = (TextBox)FormViewBakerProfile.FindControl("password");

            string newPassword = Password.Text;

            // Update email using Membership API
            MembershipUser user = Membership.GetUser(User.Identity.Name);
            user.Email = Email.Text;
            Membership.UpdateUser(user);

            // Check if password is provided
            if (!string.IsNullOrEmpty(newPassword))
            {
                // Reset password for the user using Membership API
                user.ChangePassword(user.ResetPassword(), newPassword);
            }

            // Redirect to profile page or display success message
            Response.Redirect("bakerProfile.aspx");
        }
    }
}
    

