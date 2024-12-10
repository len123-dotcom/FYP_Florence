using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class orderPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //LoadOrders();
                LoadOrders("All");
            }
        }
        protected void OrderTab_Click(object sender, EventArgs e)
        {
            LinkButton lnkButton = (LinkButton)sender;
            string status = lnkButton.CommandArgument;
            LoadOrders(status);
        }

        protected void LoadOrders(string status)
        {
            string query = @"SELECT o.Id AS OrderID, p.product_name AS ProductName, 
            p.product_image AS ProductImage, o.product_quantity AS ProductQuantity, 
            p.product_price AS ProductPrice, o.order_date AS OrderDate, 
            o.arrived_date AS ArrivedDate, (p.product_price * o.product_quantity) AS Total, 
            CONCAT(o.customer_address, ', ', o.district, ', ', o.city, ', ', o.province) AS FullAddress, 
            o.customer_name AS CustomerName,
            o.customer_phone AS CustomerPhone, 
            o.customer_payment AS CustomerPayment, o.order_status AS OrderStatus, 
            o.tracking_number as TrackingNumber 
            FROM CustomerOrder o 
            JOIN Products p ON o.product_id = p.Id";

            if (status != "All")
            {
                if (status == "Delivered")
                {
                    query += " WHERE o.order_status = @Status";
                }
                else
                {
                    query += " WHERE o.order_status = @Status";
                }
            }

            query += " ORDER BY o.order_date DESC";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
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
                    }
                }
            }
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
      


        protected void UpdateStatus_Command(object sender, CommandEventArgs e)
        {
            string[] args = e.CommandArgument.ToString().Split('|');
            int orderId = int.Parse(args[0]);
            string newStatus = args[1];

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE CustomerOrder SET order_status = @OrderStatus WHERE Id = @OrderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderStatus", newStatus);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadOrders("All");
        }

        protected void SaveTrackingNumber_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtTrackingNumber = (TextBox)item.FindControl("txtTrackingNumber");
            Label lblTrackingError = (Label)item.FindControl("lblTrackingError");

            if (string.IsNullOrWhiteSpace(txtTrackingNumber.Text))
            {
                lblTrackingError.Text = "Please enter a tracking number.";
                lblTrackingError.Visible = true;
                return;
            }

            int orderId = Convert.ToInt32(btn.CommandArgument);
            string trackingNumber = txtTrackingNumber.Text.Trim();


            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE [CustomerOrder] SET tracking_number = @TrackingNumber, order_status = 'Delivered' WHERE Id = @OrderID", con))
                {
                    cmd.Parameters.AddWithValue("@TrackingNumber", txtTrackingNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            string currentStatus = GetCurrentOrderStatus(); 
            LoadOrders(currentStatus);
        }

        protected void CancelTracking_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtTrackingNumber = (TextBox)item.FindControl("txtTrackingNumber");
            Label lblTrackingError = (Label)item.FindControl("lblTrackingError");

            txtTrackingNumber.Text = "";
            lblTrackingError.Visible = false;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "hideTrackingInput", $"document.getElementById('trackingInput_{btn.CommandArgument}').style.display = 'none';", true);
        }

        private string GetCurrentOrderStatus()
        {
            
            if (ViewState["CurrentOrderStatus"] != null)
            {
                return ViewState["CurrentOrderStatus"].ToString();
            }
            return "All"; 
        }


        protected void ShowTrackingInput_Command(object sender, CommandEventArgs e)
        {
            string orderId = e.CommandArgument.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showTrackingInput", $"showTrackingInput({orderId});", true);
        }
    }
}




    

