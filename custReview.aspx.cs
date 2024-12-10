using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class custReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrderDetails();
                CheckIfReviewExists();
            }
        }

        private void LoadOrderDetails()
        {
            int orderId = Convert.ToInt32(Request.QueryString["orderId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    o.Id AS OrderID,
                    p.product_name AS ProductName, 
                    p.product_image AS ProductImage, 
                    o.product_quantity AS ProductQuantity, 
                    p.product_price AS ProductPrice, 
                    o.order_date AS OrderDate, 
                    (p.product_price * o.product_quantity) AS Total
                FROM 
                    CustomerOrder o
                JOIN 
                    Products p ON o.product_id = p.Id
                WHERE 
                    o.Id = @OrderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        imgProduct.ImageUrl = "~/product/" + reader["ProductImage"].ToString();
                        lblProductName.Text = reader["ProductName"].ToString();
                        lblOrderDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("yyyy-MM-dd HH:mm:ss");
                        lblProductPrice.Text = Convert.ToDouble(reader["ProductPrice"]).ToString("N2");
                        lblProductQuantity.Text = reader["ProductQuantity"].ToString();
                        lblTotal.Text = Convert.ToDouble(reader["Total"]).ToString("N2");
                    }
                }
            }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtReview.Text) && (lblRate.Text == "0" || string.IsNullOrWhiteSpace(lblRate.Text)))
                {
                    lblErrorMessage.Text = "Please provide either a rating or a review text.";
                    lblErrorMessage.Visible = true;
                    return; 
                }

                int orderId = Convert.ToInt32(Request.QueryString["orderId"]);
                int productId = GetProductIDFromOrder(orderId);
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                con.Open();

                string query = "INSERT INTO ProductReviews (orderID, userID, Rating, ReviewText, ReviewDate, productID) VALUES (@orderID, @userID, @rating, @reviewText, @reviewDate, @productID)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@orderID", orderId);
                cmd.Parameters.AddWithValue("@userID", Convert.ToInt32(Session["userID"].ToString()));
                cmd.Parameters.AddWithValue("@rating", Convert.ToInt32(lblRate.Text));
                cmd.Parameters.AddWithValue("@reviewText", txtReview.Text);
                cmd.Parameters.AddWithValue("@reviewDate", DateTime.Today.ToString("yyyy/MM/dd"));
                cmd.Parameters.AddWithValue("@productID", productId);
                cmd.ExecuteNonQuery();

                Response.Redirect("memberDashboard.aspx");

                con.Close();
            }
            catch (Exception Ex)
            {
                lblErrorMessage.Text = "An error occurred while submitting the review: " + Ex.Message;
                lblErrorMessage.Visible = true;
            }
        }



        private void CheckIfReviewExists()
        {
            int orderId = Convert.ToInt32(Request.QueryString["orderId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ProductReviews WHERE orderID = @orderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@orderID", orderId);
                    con.Open();
                    int reviewCount = (int)cmd.ExecuteScalar();

                    if (reviewCount > 0)
                    {
                        btnSubmitReview.Enabled = false;
                        btnSubmitReview.CssClass += " disabled-button"; 
                        btnSubmitReview.Text = "Review Submitted";

                    }
                }
            }
        }
        private bool ReviewExistsForOrder(int orderId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ProductReviews WHERE orderID = @orderID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@orderID", orderId);
                    con.Open();
                    int reviewCount = (int)cmd.ExecuteScalar();
                    return reviewCount > 0;
                }
            }
        }

        private int GetProductIDFromOrder(int orderId)
        {
            int productId = 0;
            string query = "SELECT product_id FROM CustomerOrder WHERE Id = @OrderID";

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    con.Open();
                    productId = (int)cmd.ExecuteScalar();
                }
            }

            return productId;
        }
    
        protected void Decide(object sender, CommandEventArgs e)
        {
            string option = e.CommandArgument.ToString();
            if (option.Equals("1"))
            {
                Rating1.CssClass = "filled";
                Rating2.CssClass = "empty";
                Rating3.CssClass = "empty";
                Rating4.CssClass = "empty";
                Rating5.CssClass = "empty";


                lblRate.Text = "1";
            }
            if (option.Equals("2"))
            {
                Rating1.CssClass = "filled";
                Rating2.CssClass = "filled";
                Rating3.CssClass = "empty";
                Rating4.CssClass = "empty";
                Rating5.CssClass = "empty";


                lblRate.Text = "2";
            }
            if (option.Equals("3"))
            {
                Rating1.CssClass = "filled";
                Rating2.CssClass = "filled";
                Rating3.CssClass = "filled";
                Rating4.CssClass = "empty";
                Rating5.CssClass = "empty";
                lblRate.Text = "3";
            }
            if (option.Equals("4"))
            {
                Rating1.CssClass = "filled";
                Rating2.CssClass = "filled";
                Rating3.CssClass = "filled";
                Rating4.CssClass = "filled";
                Rating5.CssClass = "empty";
                lblRate.Text = "4";
            }
            if (option.Equals("5"))
            {
                Rating1.CssClass = "filled";
                Rating2.CssClass = "filled";
                Rating3.CssClass = "filled";
                Rating4.CssClass = "filled";
                Rating5.CssClass = "filled";
                lblRate.Text = "5";
            }
        }

        protected void DecideHover1(object sender, CommandEventArgs e)
        {
            Rating1.CssClass = "filled";
            Rating2.CssClass = "empty";
            Rating3.CssClass = "empty";
            Rating4.CssClass = "empty";
            Rating5.CssClass = "empty";


            lblRate.Text = "1";

        }
        protected void DecideHover2(object sender, CommandEventArgs e)
        {
            Rating1.CssClass = "filled";
            Rating2.CssClass = "filled";
            Rating3.CssClass = "empty";
            Rating4.CssClass = "empty";
            Rating5.CssClass = "empty";


            lblRate.Text = "2";

        }

        protected void DecideHover3(object sender, CommandEventArgs e)
        {
            Rating1.CssClass = "filled";
            Rating2.CssClass = "filled";
            Rating3.CssClass = "filled";
            Rating4.CssClass = "empty";
            Rating5.CssClass = "empty";


            lblRate.Text = "3";

        }
        protected void DecideHover4(object sender, CommandEventArgs e)
        {
            Rating1.CssClass = "filled";
            Rating2.CssClass = "filled";
            Rating3.CssClass = "filled";
            Rating4.CssClass = "filled";
            Rating5.CssClass = "empty";


            lblRate.Text = "4";

        }
        protected void DecideHover5(object sender, CommandEventArgs e)
        {
            Rating1.CssClass = "filled";
            Rating2.CssClass = "filled";
            Rating3.CssClass = "filled";
            Rating4.CssClass = "filled";
            Rating5.CssClass = "filled";


            lblRate.Text = "5";

        }

    }
}
   