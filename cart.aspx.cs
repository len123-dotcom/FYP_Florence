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
    public partial class cartPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadCartItems();

        }

        protected void LoadCartItems()
        {
            if (Session["userID"] == null)
            {
                // User is not logged in
                Button1.Visible = false;
                PlaceHolder1.Controls.Add(new Literal { Text = "<p>You need to login to proceed to checkout.</p>" });
                HyperLink loginLink = new HyperLink();
                loginLink.Text = "Login here";
                loginLink.NavigateUrl = "loginPage.aspx";
                PlaceHolder1.Controls.Add(loginLink);
            }
            else
            {
                int customer_id = Convert.ToInt16(Session["userID"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(
                    "SELECT Products.product_name as p_name, " +
                    "Products.product_price as p_price, " +
                    "Products.product_image as p_img, " +
                    "Cart.product_id as productId, " +
                    "Cart.quantity as q, " +
                    "Cart.user_id as userid " +
                    "FROM Products " +
                    "INNER JOIN Cart ON Products.Id = Cart.product_id " +
                    "INNER JOIN UserTable ON Cart.user_id = UserTable.userID " +
                    "WHERE Cart.user_id = @customer_id " +
                    "AND Cart.status=0", con))

                    {
                        cmd.Parameters.AddWithValue("@customer_id", customer_id);
                        con.Open();
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.Connection = con;
                            sda.SelectCommand = cmd;
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                // The cart has items
                                Button1.Visible = true;
                                Button1.Enabled = true;
                                double totalAmount = 0.0;

                                PlaceHolder1.Controls.Clear();
                                int rowIndex = 0;
                                foreach (DataRow row in dt.Rows)
                                {
                                    var itemDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                                    itemDiv.Attributes["class"] = "cart-item";

                                    var checkBox = new CheckBox();
                                    checkBox.ID = "CheckBox_" + rowIndex + "_" + row["productId"];
                                    checkBox.AutoPostBack = true;
                                    checkBox.CheckedChanged += new EventHandler(CheckBox_CheckedChanged);
                                    checkBox.Attributes["total_price"] = (Convert.ToDouble(row["p_price"]) * Convert.ToDouble(row["q"])).ToString();
                                    itemDiv.Controls.Add(checkBox);


                                    var img = new Image();
                                    img.CssClass = "cart-item-image";
                                    img.ImageUrl = "~/product/" + row["p_img"];
                                    itemDiv.Controls.Add(img);

                                    var detailsDiv = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                                    detailsDiv.Attributes["class"] = "cart-item-details";

                                    var nameLabel = new Label();
                                    nameLabel.CssClass = "cart-item-name";
                                    nameLabel.Text = row["p_name"].ToString();
                                    detailsDiv.Controls.Add(nameLabel);

                                    var priceLabel = new Label();
                                    priceLabel.CssClass = "cart-item-price";
                                    priceLabel.Text = "Rp " + Convert.ToDouble(row["p_price"]).ToString("N2");
                                    detailsDiv.Controls.Add(priceLabel);


                                    var quantityControl = new System.Web.UI.HtmlControls.HtmlGenericControl("div");
                                    quantityControl.Attributes["class"] = "quantity-control";

                                    var quantityTextBox = new TextBox();
                                    quantityTextBox.ID = "QuantityTextBox_" + rowIndex + "_" + row["productId"];
                                    quantityTextBox.CssClass = "quantity-input";
                                    quantityTextBox.Text = row["q"].ToString();
                                    quantityTextBox.TextChanged += new EventHandler(QuantityTextBox_TextChanged);
                                    quantityTextBox.AutoPostBack = true;

                                    quantityControl.Controls.Add(quantityTextBox);
                                    detailsDiv.Controls.Add(quantityControl);

                                    var removeButton = new LinkButton();
                                    removeButton.Text = "Remove";
                                    removeButton.CommandArgument = row["productId"].ToString();
                                    removeButton.Click += new EventHandler(RemoveButton_Click);
                                    detailsDiv.Controls.Add(removeButton);

                                    itemDiv.Controls.Add(detailsDiv);

                                    PlaceHolder1.Controls.Add(itemDiv);

                                    totalAmount += Convert.ToDouble(row["q"]) * Convert.ToDouble(row["p_price"]);
                                    rowIndex++;
                                }
                                lblTotal.Text = "Total: Rp " + totalAmount.ToString("N2");
                            }
                            else
                            {
                                // The cart is empty
                                Button1.Visible = true;
                                Button1.Enabled = false;
                                Button1.CssClass = "checkout checkout-disabled";
                                PlaceHolder1.Controls.Add(new Literal { Text = "<p>Your cart is empty.</p>" });
                            }
                        }
                    }
                }
            }
        }

        protected void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            UpdateTotal();
        }

        private void UpdateTotal()
        {
            double totalAmount = 0.0;
            foreach (Control control in PlaceHolder1.Controls)
            {
                if (control is System.Web.UI.HtmlControls.HtmlGenericControl itemDiv)
                {
                    CheckBox checkBox = itemDiv.Controls.OfType<CheckBox>().FirstOrDefault();
                    if (checkBox != null && checkBox.Checked)
                    {
                        double itemTotalPrice = Convert.ToDouble(checkBox.Attributes["total_price"]);
                        TextBox quantityTextBox = itemDiv.Controls.OfType<TextBox>().FirstOrDefault();
                        if (quantityTextBox != null)
                        {
                            int quantity = int.Parse(quantityTextBox.Text);
                            itemTotalPrice = itemTotalPrice * quantity;
                        }
                        totalAmount += itemTotalPrice;
                    }
                }
            }
            lblTotal.Text = "Total: Rp " + totalAmount.ToString("N2");

        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            List<int> selectedProductIds = new List<int>();
            List<double> selectedProductTotalPrice = new List<double>();

            bool anyChecked = false;

            foreach (Control control in PlaceHolder1.Controls)
            {
                if (control is System.Web.UI.HtmlControls.HtmlGenericControl itemDiv)
                {
                    CheckBox checkBox = itemDiv.Controls.OfType<CheckBox>().FirstOrDefault();
                    if (checkBox != null && checkBox.Checked)
                    {
                        anyChecked = true;
                        int productId = Convert.ToInt32(checkBox.ID.Split('_').Last());
                        selectedProductIds.Add(productId);
                        double total_price = Convert.ToDouble(checkBox.Attributes["total_price"].ToString());
                        selectedProductTotalPrice.Add(total_price);
                    }
                }
            }

            if (!anyChecked)
            {
                foreach (Control control in PlaceHolder1.Controls)
                {
                    if (control is System.Web.UI.HtmlControls.HtmlGenericControl itemDiv)
                    {
                        CheckBox checkBox = itemDiv.Controls.OfType<CheckBox>().FirstOrDefault();
                        if (checkBox != null)
                        {
                            int productId = Convert.ToInt32(checkBox.ID.Split('_').Last());
                            selectedProductIds.Add(productId);
                            double total_price = Convert.ToDouble(checkBox.Attributes["total_price"].ToString());
                            selectedProductTotalPrice.Add(total_price);
                        }
                    }
                }
            }

            Session["SelectedProductIds"] = selectedProductIds;
            Session["TotalAmount"] = selectedProductTotalPrice.Sum();

            Response.Redirect("checkoutForm.aspx");
        }



        protected void QuantityTextBox_TextChanged(object sender, EventArgs e)
        {
            TextBox quantityTextBox = sender as TextBox;
            string[] ids = quantityTextBox.ID.Split('_');
            int productId = Convert.ToInt32(ids[2]);
            int newQuantity;

            if (int.TryParse(quantityTextBox.Text, out newQuantity) && newQuantity > 0)
            {
                int customerId = Convert.ToInt16(Session["userID"]);

                int currentStock = 0;
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT product_quantity FROM Products WHERE Id = @productId", con))
                    {
                        cmd.Parameters.AddWithValue("@productId", productId);
                        con.Open();
                        currentStock = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }

                if (newQuantity > currentStock)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Quantity exceeds available stock.');", true);
                }
                else
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("UPDATE Cart SET quantity = @quantity WHERE product_id = @productId AND user_id = @customerId", con))
                        {
                            cmd.Parameters.AddWithValue("@quantity", newQuantity);
                            cmd.Parameters.AddWithValue("@productId", productId);
                            cmd.Parameters.AddWithValue("@customerId", customerId);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Please enter a valid quantity.');", true);
            }

            LoadCartItems();
        }

        protected void RemoveButton_Click(object sender, EventArgs e)
        {
            LinkButton removeButton = sender as LinkButton;
            int productId = Convert.ToInt32(removeButton.CommandArgument);
            int customerId = Convert.ToInt16(Session["userID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE product_id = @productId AND user_id = @customerId", con))
                {
                    cmd.Parameters.AddWithValue("@productId", productId);
                    cmd.Parameters.AddWithValue("@customerId", customerId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            LoadCartItems();
        }



    }
}