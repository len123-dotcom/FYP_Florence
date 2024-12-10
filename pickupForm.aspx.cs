using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace FYP_Florence
{
    public partial class pickupForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillUserDetails();
                DisplayCartProducts();
            }
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(TextBox3.Text) || string.IsNullOrEmpty(TextBoxDate.Text) || string.IsNullOrEmpty(DropDownListTime.Text))
            {
                errMsg.Text = "Please fill in all required fields.";
                errMsg.Visible = true;
                return;
            }

            DateTime selectedDate;
            if (!DateTime.TryParse(TextBoxDate.Text, out selectedDate) || selectedDate < DateTime.Today)
            {
                errMsg.Text = "Please select a valid pick up date.";
                errMsg.Visible = true;
                return;
            }


            // Store user details in session
            Session["CustomerName"] = TextBox1.Text;
            Session["CustomerPhone"] = TextBox3.Text;
            Session["PickUpDate"] = TextBoxDate.Text;
            Session["PickUpTime"]= DropDownListTime.Text;
            //Session["OrderPlace"] = "Pick Up";

            //Response.Redirect("paymentdetails.aspx");
            Response.Redirect("paymentdetails.aspx?prev=pickup");
        }


        protected void FillUserDetails()
        {
            int customer_id = Convert.ToInt32(Session["userID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = "SELECT customer_name, customer_phone FROM CustomerOrder WHERE userID = @customerId ORDER BY Id DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@customerId", customer_id);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        TextBox1.Text = reader["customer_name"].ToString();
                        TextBox3.Text = reader["customer_phone"].ToString();
                    }
                }
            }
        }
        protected void DisplayCartProducts()
        {
            try
            {
                if (Session["SelectedProductIds"] == null) return;

                List<int> selectedProductIds = (List<int>)Session["SelectedProductIds"];
                if (selectedProductIds.Count == 0) return;

                int customer_id = Convert.ToInt32(Session["userID"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    string query = @"SELECT Products.product_name as p_name, Products.product_price as p_price, Products.product_image as p_img, Cart.quantity as q 
                             FROM Products 
                             INNER JOIN Cart ON Products.Id = Cart.product_id 
                             WHERE Cart.user_id = @customerId AND Cart.product_id IN (@productIds) AND Cart.status = 0";

                    string productIds = string.Join(",", selectedProductIds);
                    query = query.Replace("@productIds", productIds);

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@customerId", customer_id);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string productName = reader["p_name"].ToString();
                            string productPrice = reader["p_price"].ToString();
                            string productImage = reader["p_img"].ToString();
                            string quantity = reader["q"].ToString();

                            string productHtml = "<div class=\"cart-item\">";
                            productHtml += $"<img src='{ResolveUrl("~/product/" + productImage)}' class='cart-item-image' />";
                            productHtml += $"<div class=\"cart-item-details\">";
                            productHtml += $"<h3 class=\"cart-item-name\">{productName}</h3>";
                            productHtml += $"<p class=\"cart-item-price\">RM {productPrice}</p>";
                            productHtml += $"<p class=\"cart-item-quantity\">Quantity: {quantity}</p>";
                            productHtml += $"</div></div>";

                            //PlaceHolder1.Controls.Add(new Literal { Text = productHtml });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error retrieving cart products: " + ex.ToString());
            }

        }
    }
}
