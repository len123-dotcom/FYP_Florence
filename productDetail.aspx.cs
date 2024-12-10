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
    public partial class productDetail : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductDetails();
                BindReviews();
            }
        }

        private void LoadProductDetails()
        {
            int productId = Convert.ToInt32(Request.QueryString["product_id"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE Id = @ProductId", con))
                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            product_name.Text = reader["product_name"].ToString();
                            product_price.Text = Convert.ToDecimal(reader["product_price"]).ToString("N2");
                            product_quantity.Text = reader["product_quantity"].ToString();
                            product_description.Text = reader["product_description"].ToString();
                            productImage.ImageUrl = "~/product/" + reader["product_image"].ToString();

                            double avgRating = GetAverageRating(productId);
                            lblAverageRating.Text = avgRating.ToString("F1") + " ";
                            lblAverageRating.Text += GenerateStarImages(avgRating);

                            int totalReviews = GetTotalReviews(productId);
                            hlTotalReviews.NavigateUrl = "#reviews";
                            hlTotalReviews.Text = "| " + "(" + totalReviews.ToString() + " reviews)";

                            int totalSoldProd = GetTotalProd(productId);
                            lblTotalProd.Text = "| " + "Sold " + totalSoldProd.ToString() + " ";

                            int availableQuantity = Convert.ToInt32(reader["product_quantity"]);
                            if (availableQuantity <= 0)
                            {
                                Button1.Enabled = false;
                                Button1.CssClass = "cart-button button-disabled";
                            }
                        }
                    }
                }
            }
        }


        private int GetTotalProd(int productId)
        {
            int totalProd = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(product_id) AS TotalProd FROM CustomerOrder WHERE product_id = @productID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@productID", productId);
                    con.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != DBNull.Value)
                    {
                        totalProd = Convert.ToInt16(result);
                    }
                }
            }

            return totalProd;
        }
    

        private void BindReviews()
        {
            int productId = Convert.ToInt32(Request.QueryString["product_id"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))

            {
                string query = @"
                    SELECT pr.ReviewText, pr.Rating, pr.ReviewDate, u.userName
                    FROM ProductReviews pr
                    JOIN userTable u ON pr.userID = u.userID
                    WHERE pr.productID = @productID
                    ORDER BY pr.ReviewDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@productID", productId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptReviews.DataSource = dt;
                        rptReviews.DataBind();
                    }
                }
            }
        }

        private int GetTotalReviews(int productId)
        {
            int totalReviews = 0;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM ProductReviews WHERE productID = @productID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@productID", productId);
                    con.Open();
                    totalReviews = (int)cmd.ExecuteScalar();
                }
            }

            return totalReviews;
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            int product_id = Convert.ToInt16(Request.QueryString["product_id"]);
            int customer_id = Convert.ToInt16(Session["userID"]);

            if (string.IsNullOrWhiteSpace(quantity.Text))
            {
                // Display an error message
                ErrorMessage.InnerText = "Please enter the quantity.";
                ErrorMessage.Visible = true;
                return;
            }


            int enteredQuantity;
            if (!int.TryParse(quantity.Text, out enteredQuantity) || enteredQuantity <= 0)
            {
                // Display an error message for invalid quantity
                ErrorMessage.InnerText = "Please enter a valid quantity.";
                ErrorMessage.Visible = true;
                return;
            }



            SqlConnection con = new
            SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            try
            {
                con.Open();

                int availableQuantity = GetAvailableProductQuantity(product_id, con);

                if (availableQuantity < enteredQuantity)
                {
                    // Display an error message for insufficient stock
                    ErrorMessage.InnerText = "Insufficient stock. Only " + availableQuantity + " items available.";
                    ErrorMessage.Visible = true;
                    return;
                }

                //check 
                string checkQuery = "SELECT quantity FROM Cart WHERE product_id = @product_id AND user_id = @user_id AND status = 0";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@product_id", product_id);
                    checkCmd.Parameters.AddWithValue("@user_id", customer_id);

                    int currentQuantity = 0;
                    using (SqlDataReader reader = checkCmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            currentQuantity = Convert.ToInt32(reader["quantity"]);
                        }
                    }

                    if (currentQuantity > 0)
                    {
                        // Product exists in cart, update quantity
                        string updateQuery = "UPDATE Cart SET quantity = @quantity WHERE product_id = @product_id AND user_id = @user_id AND status = 0";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                        {
                            updateCmd.Parameters.AddWithValue("@quantity", currentQuantity + enteredQuantity);
                            updateCmd.Parameters.AddWithValue("@product_id", product_id);
                            updateCmd.Parameters.AddWithValue("@user_id", customer_id);
                            updateCmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        // Product does not exist in cart, insert new
                        string insertQuery = "INSERT INTO Cart (product_id, quantity, user_id, status) VALUES(@product_id, @quantity, @user_id, 0)";
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                        {
                            insertCmd.Parameters.AddWithValue("@quantity", enteredQuantity);
                            insertCmd.Parameters.AddWithValue("@product_id", product_id);
                            insertCmd.Parameters.AddWithValue("@user_id", customer_id);
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }

                Response.Redirect("cart.aspx");
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.ToString());
            }
        }


        private int GetAvailableProductQuantity(int productId, SqlConnection connection)
        {
            string query = "SELECT product_quantity FROM Products WHERE Id = @productId";
            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@productId", productId);

            int availableQuantity = 0;
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                if (reader.HasRows)
                {
                    reader.Read();
                    availableQuantity = Convert.ToInt32(reader["product_quantity"]);
                }
            }

            return availableQuantity;
        }

        protected void btnminus_Click(object sender, EventArgs e)
        {
            int currentQuantity = int.Parse(quantity.Text);
            if (currentQuantity > 0)
            {
                currentQuantity--;
                quantity.Text = currentQuantity.ToString();
            }

        }

        protected void btnplus_Click(object sender, EventArgs e)
        {
            int currentQuantity = int.Parse(quantity.Text);
            currentQuantity++;
            quantity.Text = currentQuantity.ToString();
        }

        private double GetAverageRating(int productId)
        {
            double averageRating = 0.0;
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT AVG(Rating) AS AvgRating FROM ProductReviews WHERE productID = @productID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@productID", productId);
                    con.Open();
                    var result = cmd.ExecuteScalar();

                    if (result != DBNull.Value)
                    {
                        averageRating = Convert.ToDouble(result);
                    }
                }
            }

            return averageRating;
        }
        
        protected string GenerateStarImages(double averageRating)
        {
            int filledStars = (int)Math.Floor(averageRating);
            int emptyStars = 5 - filledStars;
            string starsHtml = "";

            for (int i = 0; i < filledStars; i++)
            {
                starsHtml += "<div class='filled'></div>";
            }
            for (int i = 0; i < emptyStars; i++)
            {
                starsHtml += "<div class='empty'></div>";
            }

            return starsHtml;
        }
    }
}