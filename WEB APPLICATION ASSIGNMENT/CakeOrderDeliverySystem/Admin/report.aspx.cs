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
    public partial class report : System.Web.UI.Page
    {
        SqlConnection conn;
        string strCon = ConfigurationManager.ConnectionStrings["OnlineCakeDeliverySystem"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnViewReport_Click(object sender, EventArgs e)
        {
            

            try
            {
                string year = RadioButtonList1.SelectedValue;
                string month = RadioButtonList2.SelectedValue;
                int selectedYear = Convert.ToInt16(year);
                int selectedMonth = Convert.ToInt16(month);

                conn = new SqlConnection(strCon);
                conn.Open();
                double totalSales = 0.0;


                //display total sales for each product


                string strRetrieveProdTotal = "SELECT p.productID, p.productName, SUM(CONVERT(numeric(10),od.amount)) AS totalQuantity, SUM(CONVERT(numeric(5, 2), p.price)) AS totalAmount FROM [dbo].[Order] o INNER JOIN [dbo].[OrderDetail] od ON o.orderID = od.orderID INNER JOIN [dbo].[Product] p ON od.productID = p.productID WHERE YEAR(o.orderDate) = @year AND MONTH(o.orderDate) = @month AND o.paymentStatus = 1 GROUP BY p.productID, p.productName";

                using (SqlCommand cmdRetrieveProdTotal = new SqlCommand(strRetrieveProdTotal, conn))
                {
                    cmdRetrieveProdTotal.Parameters.AddWithValue("@year", selectedYear);
                    cmdRetrieveProdTotal.Parameters.AddWithValue("@month", selectedMonth);

                    using (SqlDataReader dtrProTotal = cmdRetrieveProdTotal.ExecuteReader())
                    {
                        if (dtrProTotal.HasRows)
                        {
                            result.DataSource = dtrProTotal;
                            result.DataBind();

                            // Resetting the data reader position
                            dtrProTotal.Close();
                            SqlDataReader dtrProTotal2 = cmdRetrieveProdTotal.ExecuteReader();

                            // Calculate the total sales amount
                            while (dtrProTotal2.Read())
                            {
                                double thisTotalAmount = Convert.ToDouble(dtrProTotal2["totalAmount"]);
                                totalSales += thisTotalAmount;
                            }
                            dtrProTotal2.Close();

                        }
                    }
                }

                //calculate the total discount
                string strRetrieveOrder = "SELECT * FROM [Order] WHERE YEAR(orderDate) = " + selectedYear + " AND MONTH(orderDate) = " + selectedMonth + " AND paymentStatus = 1";
                SqlCommand cmdRetrieve;
                cmdRetrieve = new SqlCommand(strRetrieveOrder, conn);

                SqlDataReader dtrOrder = cmdRetrieve.ExecuteReader();

                double totalDiscount = 0.0;

                if (dtrOrder.HasRows)
                {
                    while (dtrOrder.Read())
                    {
                        if (dtrOrder["discount"]!=DBNull.Value) 
                        {
                            //calculate the amount of total discount
                            double thisDiscount = Convert.ToDouble(dtrOrder["discount"]);
                            totalDiscount += thisDiscount;
                        }
                        //calculate the amount of total discount
                       else
                        {
                            totalDiscount += 0.0;
                        }
                    }
                }
                dtrOrder.Close();

                string yearMonth = selectedMonth.ToString() + "/" + selectedYear.ToString();
                lblTitle.Text = "\t\t\t<b>Sales Report for " + yearMonth + "</b>";
                lblProdInvolved.Text = "Product Involved";
                lblTotalDiscount.Text = "Total discount amount : <b>" + totalDiscount.ToString("C2") + "</b>";
                lblTotalSales.Text = "Total sales amount : <b>" + totalSales.ToString("C2") + "</b>";

                double grandTotalSalesAmount = totalSales - totalDiscount;
                lblGrandTotalSalesAmount.Text = "Grand total sales amount : <b>" + grandTotalSalesAmount.ToString("C2") + "</b>";
                lblReportDateTime.Text = "Date generated : <b>" + DateTime.Now.ToShortDateString() + " " + DateTime.Now.ToShortTimeString();

            }
            catch (FormatException ex)
            {
                lblErrorMessage.Text = "Please select exactly a year and a month to proceed!";
            }
        }

        void Page_Error()
        {
            Response.Write("Opps.. There is an error...");
            Response.Write(Server.GetLastError().Message);
            Server.ClearError();
        }

        protected void rblOrderYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Clear the result and labels when the year is changed
            result.DataSource = null;
            result.DataBind();
            lblTitle.Text = "";
            lblTotalDiscount.Text = "";
            lblTotalSales.Text = "";
            lblGrandTotalSalesAmount.Text = "";
            lblErrorMessage.Text = "";
            lblReportDateTime.Text = "";
            lblProdInvolved.Text = "";
        }

        protected void print_Click(object sender, EventArgs e)
        {

        }
    }
}