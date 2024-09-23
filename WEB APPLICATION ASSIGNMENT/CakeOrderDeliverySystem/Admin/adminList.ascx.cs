using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CakeOrderDeliverySystem.Admin
{
    public partial class adminList : System.Web.UI.UserControl
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
        static SqlConnection connection = new SqlConnection(connectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                refreshData();
            }
        }

        protected void UserList1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string status;
            string username = "";
            Boolean changeStatus = true;
            String id;

            if (e.CommandName == "ChangeStatus")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = UserList1.Rows[rowIndex];
                Label label1 = row.FindControl("Span").FindControl("Status") as Label;
                username = row.Cells[0].Text;
                status = label1.Text;

                if (status == "Active")
                {
                    changeStatus = false;
                }

            }


            if (username != "")
            {
                connection.Open();

                String idQuery = "Select UserId From aspnet_Users Where Username = @username";
                SqlCommand idcmd = new SqlCommand(idQuery, connection);

                idcmd.Parameters.AddWithValue("@username", username);


                id = idcmd.ExecuteScalar().ToString();

                String StatusUpdateQuery = "Update aspnet_Membership Set IsApproved = @status Where UserId = @Id";
                SqlCommand upcmd = new SqlCommand(StatusUpdateQuery, connection);


                upcmd.Parameters.AddWithValue("@status", changeStatus);
                upcmd.Parameters.AddWithValue("@Id", id);


                upcmd.ExecuteNonQuery();


                connection.Close();
            }

            UserList1.DataSource = SqlDataSource1;
            UserList1.DataBind();
        }

        protected void refreshData()
        {
            String id = null;

            try
            {
                connection.Open();
                String idQuery = "Select RoleId From aspnet_Roles Where RoleName = @role";
                SqlCommand idcmd = new SqlCommand(idQuery, connection);

                idcmd.Parameters.AddWithValue("@role", "Admin");

                id = idcmd.ExecuteScalar().ToString();

                if (id != null)
                {
                    roleId.Text = id;
                }

                connection.Close();


                UserList1.DataSource = SqlDataSource1;
                UserList1.DataBind();

            }
            catch (Exception ex)
            {
                
            }
        }

        protected void UserList1_Sorting(object sender, GridViewSortEventArgs e)
        {
            string currentSortDirection = ViewState["SortDirection"] as string ?? "ASC";

            string newSortDirection = (currentSortDirection == "ASC") ? "DESC" : "ASC";


            ViewState["SortDirection"] = newSortDirection;

            string selectCommand = SqlDataSource1.SelectCommand;
            string orderByClause = string.Format(" ORDER BY {0} {1}", e.SortExpression, newSortDirection);


            SqlDataSource1.SelectCommand = selectCommand + orderByClause;
            UserList1.DataBind();
            SqlDataSource1.SelectCommand = selectCommand;
        }

    }
}