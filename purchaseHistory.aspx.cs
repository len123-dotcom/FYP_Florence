using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;

namespace FYP_Florence
{
    public partial class purchaseHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadHistoryOrders("All");
            }
        }

        protected void OrderTab_Click(object sender, EventArgs e)
        {
            LinkButton lnkButton = (LinkButton)sender;
            string status = lnkButton.CommandArgument;
            LoadHistoryOrders(status);
        }


        protected string FormatDate(object dateObj)
        {
            if (dateObj != DBNull.Value && dateObj != null)
            {
                DateTime date = Convert.ToDateTime(dateObj);
                return date.ToString("dd MMM yyyy, HH:mm") + " WIB";
            }
            else
            {
                return string.Empty;
            }
        }

        protected void LoadHistoryOrders(string status)
        {
            int userId = Convert.ToInt32(Session["userID"]);
            string query = @"SELECT
                o.Id AS OrderID,
                p.product_name AS ProductName, 
                p.product_image AS ProductImage, 
                o.product_quantity AS ProductQuantity, 
                p.product_price AS ProductPrice, 
                o.order_date AS OrderDate, 
                o.arrived_date AS ArrivedDate,
                (p.product_price * o.product_quantity) AS Total,
                CONCAT(o.customer_address, ', ', o.district, ', ', o.city, ', ', o.province) AS FullAddress,
                o.customer_name AS CustomerName,
                o.customer_phone AS CustomerPhone,
                o.customer_payment AS CustomerPayment,
                o.order_status AS OrderStatus,
                o.tracking_number AS TrackingNumber
            FROM 
                CustomerOrder o
            JOIN 
                Products p ON o.product_id = p.Id
            WHERE 
                o.userID = @userID";

            if (status != "All")
            {
                if (status == "Arrived")
                {
                    query += " AND (o.order_status = 'Arrived' OR o.arrived_date IS NOT NULL)";
                }
                else
                {
                    query += " AND o.order_status = @Status";
                }
            }

            query += " ORDER BY o.order_date DESC";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userID", userId);
                    if (status != "All")
                    {
                        cmd.Parameters.AddWithValue("@Status", status);
                    }

                    con.Open();
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        ordersRepeater.DataSource = dt;
                        ordersRepeater.DataBind();
                        Console.WriteLine($"Rows found: {dt.Rows.Count}");
                    }
                }
            }
        }


        protected void btnArrived_Command(object sender, CommandEventArgs e)
        {
            string[] args = e.CommandArgument.ToString().Split('|');
            int orderId = int.Parse(args[0]);
            string newStatus = args[1];
            string clientId = args[2];

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE CustomerOrder SET order_status = @OrderStatus, arrived_date = @ArrivedDate WHERE Id = @OrderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderStatus", newStatus);
                    cmd.Parameters.AddWithValue("@ArrivedDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadHistoryOrders("All");
            //dari sini
            Button btnArrived = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnArrived.NamingContainer;

            btnArrived.Visible = false;

            Button btnReview = (Button)item.FindControl("btnReview");
            if (btnReview != null)
            {
                btnReview.Visible = true;
            }

            Literal litArrivedDate = (Literal)item.FindControl("litArrivedDate");
            if (litArrivedDate != null)
            {
                litArrivedDate.Visible = true;
                litArrivedDate.Text = $"Arrived Date: {DateTime.Now:yyyy-MM-dd HH:mm:ss}";
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateUI", $"updateArrivedStatus('{orderId}');", true);

        }
        protected void btnReview_Command(object sender, CommandEventArgs e)
        {

            int orderId = Convert.ToInt32(e.CommandArgument);
           
            Response.Redirect($"custReview.aspx?orderId={orderId}");
          
        }

        protected void btnCancel_Command(object sender, CommandEventArgs e)
        {
            int orderId = int.Parse(e.CommandArgument.ToString());

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlTransaction transaction = con.BeginTransaction())
                {
                    try
                    {
                        // Get order details
                        string getOrderQuery = @"SELECT product_id, product_quantity 
                                         FROM CustomerOrder 
                                         WHERE Id = @OrderID";
                        int productId = 0;
                        int quantity = 0;

                        using (SqlCommand getOrderCmd = new SqlCommand(getOrderQuery, con, transaction))
                        {
                            getOrderCmd.Parameters.AddWithValue("@OrderID", orderId);
                            using (SqlDataReader reader = getOrderCmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    productId = reader.GetInt32(reader.GetOrdinal("product_id"));
                                    quantity = reader.GetInt32(reader.GetOrdinal("product_quantity"));
                                }
                            }
                        }

                        // Update product quantity
                        string updateProductQuery = @"UPDATE Products 
                                              SET product_quantity = product_quantity + @Quantity 
                                              WHERE Id = @ProductID";
                        using (SqlCommand updateProductCmd = new SqlCommand(updateProductQuery, con, transaction))
                        {
                            updateProductCmd.Parameters.AddWithValue("@Quantity", quantity);
                            updateProductCmd.Parameters.AddWithValue("@ProductID", productId);
                            updateProductCmd.ExecuteNonQuery();
                        }

                        // Delete the order
                        string deleteOrderQuery = "DELETE FROM CustomerOrder WHERE Id = @OrderID";
                        using (SqlCommand deleteOrderCmd = new SqlCommand(deleteOrderQuery, con, transaction))
                        {
                            deleteOrderCmd.Parameters.AddWithValue("@OrderID", orderId);
                            deleteOrderCmd.ExecuteNonQuery();
                        }

                        transaction.Commit();
                        
                        string strSQL = "SELECT * FROM Products";
                        SqlDataAdapter dt = new SqlDataAdapter(strSQL, con);
                        DataSet ds = new DataSet("products");
                        dt.Fill(ds, "product");
                        ds.WriteXml(Server.MapPath(@".\catalogue.xml"));
                        ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccess",
                    "alert('Order has been successfully cancelled.');", true);
                    }
                    catch (Exception ex)
                    {
                        // If an error occurs, roll back the transaction
                        transaction.Rollback();
                        // Log the error or display a message to the user
                        Response.Write("Error: " + ex.Message);
                    }
                }
            }

            // Reload the orders
            LoadHistoryOrders("All");
        }


        public bool ReviewExistsForOrder(int orderId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ProductReviews WHERE orderID = @orderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@orderID", orderId);
                    con.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        int reviewCount = Convert.ToInt32(result);
                        return reviewCount > 0;
                    }
                    else
                    {
                        // Handle case where result is null or DBNull.Value
                        return false; // No review found
                    }
                }
            }
        }
    }
}