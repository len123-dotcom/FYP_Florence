using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class paymentdetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["SelectedProductIds"] != null)
                {
                    List<int> selectedProductIds = (List<int>)Session["SelectedProductIds"];
                    DisplaySelectedProducts(selectedProductIds);
                }

                if (Session["CustomerName"] != null)
                {
                    lblCustomerName.Text = Session["CustomerName"].ToString();
                }
                if (Session["CustomerPhone"] != null)
                {
                    lblCustomerPhone.Text = Session["CustomerPhone"].ToString();
                }
                //if (Session["TotalItems"] != null)
                //{
                //    int totalItems = (int)Session["TotalItems"];
                //    lblTotalItems.Text = totalItems.ToString();
                //}


                if (Session["TotalAmount"] != null)
                {
                    lblTotalAmount.Text =  Session["TotalAmount"].ToString();
                }
                //string previousPage = Request.QueryString["prev"];
                //if (previousPage == "checkout")
                //{
                //    backButton.Attributes["href"] = "checkoutForm.aspx";
                //}
                //else if (previousPage == "pickup")
                //{
                //    backButton.Attributes["href"] = "pickupForm.aspx";
                //}

                if (Session["Province"] != null)
                {
                    string province = Session["Province"].ToString();
                    double shippingCost = GetShippingCost(province); 
                    lblShippingCost.Text =  shippingCost.ToString("N3");

                }
            }
        }


        private void DisplaySelectedProducts(List<int> productIds)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT Id, product_name, product_image FROM Products WHERE Id IN (" + string.Join(",", productIds) + ")";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        StringBuilder html = new StringBuilder();
                        html.Append("<div class='selected-products'>");
                        while (reader.Read())
                        {
                            int id = reader.GetInt32(0);
                            string name = reader.GetString(1);
                            string imageName = reader.GetString(2);

                            string fullImagePath = ResolveUrl($"~/product/{imageName}");

                            html.Append("<div class='product-item'>");
                            html.Append($"<img src='{fullImagePath}' alt='{name}' class='product-image' />");
                            html.Append($"<p class='product-name'>{name}</p>");
                            html.Append("</div>");

                            System.Diagnostics.Debug.WriteLine($"Product: {name}, Image Path: {fullImagePath}");
                        }
                        html.Append("</div>");
                        productImagesPlaceholder.Controls.Add(new LiteralControl(html.ToString()));
                    }
                }
            }
        }

        private double GetShippingCost(string province)
        {
            Dictionary<string, double> shippingCosts = new Dictionary<string, double>
        {
            { "Bali", 30.000 },
            { "Bangka Belitung", 29.500 },
            { "Banten", 11.000 },
            { "Bengkulu", 39.000 },
            { "DKI Jakarta", 10.000 },
            { "Jawa Barat", 12.500 },
            { "Jawa Tengah", 21.000 },
            { "Kalimantan Barat", 23.500},
            { "Kalimantan Selatan", 52.500},
            { "Kalimantan Timur", 80.500},
            { "Kalimantan Utara", 132.500},
            { "Kepulauan Riau", 84.000},
            { "Lampung", 49.000},
            { "Sulawesi Barat", 101.000},
            { "Sulawesi Selatan", 71.500}

        };

            if (shippingCosts.ContainsKey(province))
            {
                return shippingCosts[province];
            }
            else
            {
                
                return 0; 
            }
        }

        protected void ConfirmButton_Click(object sender, EventArgs e)
        {
            string paymentMethod = string.Empty;
            if (RadioButton1.Checked)
            {
                paymentMethod = "Debit/Credit Card";
            }
            else if (RadioButton2.Checked)
            {
                paymentMethod = "Bank Transfer";
            }

            if (string.IsNullOrEmpty(paymentMethod))
            {
                errMsg.Text = "Please select a payment method.";
                errMsg.Visible = true;
                return;
            }

            try
            {
                int customer_id = Convert.ToInt32(Session["userID"]);
                List<int> selectedProductIds = (List<int>)Session["SelectedProductIds"];
                string customerName = Session["CustomerName"].ToString();
                string customerPhone = Session["CustomerPhone"].ToString();
                string customerAddress = Session["CustomerAddress"]?.ToString();
                string district = Session["District"]?.ToString();
                string province = Session["Province"]?.ToString();
                string city = Session["City"]?.ToString();

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();
                    SqlTransaction transaction = con.BeginTransaction();



                    try
                    {
                        // Update stock quantities for each product in the user cart
                        string updateStockQuery = @"UPDATE Products 
                                                    SET product_quantity = product_quantity - Cart.quantity
                                                    FROM Products
                                                    INNER JOIN Cart ON Products.Id = Cart.product_id
                                                    WHERE Cart.user_id = @customerId AND Cart.status = 0";

                        SqlCommand updateStockCmd = new SqlCommand(updateStockQuery, con, transaction);
                        updateStockCmd.Parameters.AddWithValue("@customerId", customer_id);
                        updateStockCmd.ExecuteNonQuery();

                        foreach (int productId in selectedProductIds)
                        {
                            string insertOrderQuery = @"
                                INSERT INTO [CustomerOrder] 
                                    (product_id, product_quantity, userID, order_status, customer_name, customer_phone, customer_address, district, province, city, customer_payment, order_date) 
                                VALUES 
                                    (@productId, 
                                     (SELECT quantity FROM Cart WHERE user_id = @customerId AND product_id = @productId AND status = 0), 
                                     @customerId, 'Pending', @customerName, @customerPhoneNumber, @customerAddress, @district, @province, @city, @customerPayment, GETDATE())";

                            SqlCommand insertOrderCmd = new SqlCommand(insertOrderQuery, con, transaction);
                            insertOrderCmd.Parameters.AddWithValue("@productId", productId);
                            insertOrderCmd.Parameters.AddWithValue("@customerId", customer_id);
                            insertOrderCmd.Parameters.AddWithValue("@customerName", customerName);
                            insertOrderCmd.Parameters.AddWithValue("@customerPhoneNumber", customerPhone);
                            insertOrderCmd.Parameters.AddWithValue("@customerAddress", customerAddress ?? (object)DBNull.Value);
                            insertOrderCmd.Parameters.AddWithValue("@district", district ?? (object)DBNull.Value);
                            insertOrderCmd.Parameters.AddWithValue("@province", province ?? (object)DBNull.Value);
                            insertOrderCmd.Parameters.AddWithValue("@city", city ?? (object)DBNull.Value);
                            insertOrderCmd.Parameters.AddWithValue("@customerPayment", paymentMethod);
                            insertOrderCmd.ExecuteNonQuery();


                            string updateCartQuery = "UPDATE Cart SET status = 1 WHERE user_id = @customerId AND product_id = @productId AND status = 0";
                            SqlCommand updateCartCmd = new SqlCommand(updateCartQuery, con, transaction);
                            updateCartCmd.Parameters.AddWithValue("@customerId", customer_id);
                            updateCartCmd.Parameters.AddWithValue("@productId", productId);
                            updateCartCmd.ExecuteNonQuery();
                        }

                        transaction.Commit();

                        string strSQL = "SELECT * FROM Products";
                        SqlDataAdapter dt = new SqlDataAdapter(strSQL, con);
                        DataSet ds = new DataSet("products");
                        dt.Fill(ds, "product");
                        ds.WriteXml(Server.MapPath(@".\catalogue.xml"));


                        Response.Redirect("purchaseHistory.aspx");
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        Response.Write("Error: " + ex.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.ToString());
            }
        }
    }
}