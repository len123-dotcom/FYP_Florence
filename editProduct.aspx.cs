using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace FYP_Florence
{
    public partial class editProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int product_id = Convert.ToInt16(Request.QueryString["product_id"]);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE Id = @ProductId", con))
                    {
                        cmd.Parameters.AddWithValue("@ProductId", product_id);

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];
                                editProductName.Text = row["product_name"].ToString();
                                editProductPrice.Text = Convert.ToDecimal(row["product_price"]).ToString("F0");
                                editProductDescription.Text = row["product_description"].ToString();
                                editProductQuantity.Text = row["product_quantity"].ToString();
                                productImage.ImageUrl = "~/product/" + row["product_image"].ToString();
                            }
                        }
                    }

                    con.Close();
                }
            }
        }

        protected void ButtonSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(editProductName.Text) ||
                string.IsNullOrEmpty(editProductPrice.Text) ||
                string.IsNullOrEmpty(editProductQuantity.Text) ||
                string.IsNullOrEmpty(editProductDescription.Text))
            {
                LabelError.Text = "All fields are required.";
                return;
            }

            LabelError.Text = "";
            int productId = Convert.ToInt32(Request.QueryString["product_id"]);

            string updatedProductImage = "";
            string updatedProductName = editProductName.Text;
            string updatedProductPrice = editProductPrice.Text;
            string updatedProductQuantity = editProductQuantity.Text;
            string updatedProductDescription = editProductDescription.Text;


            if (FileUpload1.HasFile)
            {
                string fileExtension = Path.GetExtension(FileUpload1.FileName).ToLower();
                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    string folderPath = Server.MapPath("~/product/");
                    string newFileName = Path.GetFileName(FileUpload1.FileName);
                    FileUpload1.SaveAs(folderPath + newFileName);
                    updatedProductImage = newFileName;
                }
                else
                {
                    LabelError.Text = "Invalid file format. Please upload an image file (JPEG or PNG).";
                    return;
                }
            }
            else
            {
                updatedProductImage = Path.GetFileName(productImage.ImageUrl);
            }

            int price;
            if (!int.TryParse(editProductPrice.Text, out price))
            {
                errMsgprice.Text = "Please enter a valid price without commas or dots (e.g., 25000).";
                errMsgprice.Visible = true;
                return;
            }

            SqlConnection con = new
            SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            {
                con.Open();

                // Update the product details in the database

                string query = "UPDATE Products SET product_image = @Productimg, product_name = @ProductName, product_price = @ProductPrice, product_quantity=@ProductQuantity, product_description = @ProductDescription WHERE Id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, con);

                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Productimg", updatedProductImage);
                    cmd.Parameters.AddWithValue("@ProductName", updatedProductName);
                    cmd.Parameters.AddWithValue("@ProductPrice", updatedProductPrice);
                    cmd.Parameters.AddWithValue("@ProductQuantity", updatedProductQuantity);
                    cmd.Parameters.AddWithValue("@ProductDescription", updatedProductDescription);

                    cmd.ExecuteNonQuery();
                }


                // Generate XML file
                string strSQL = "SELECT * FROM Products";
                SqlDataAdapter dt = new SqlDataAdapter(strSQL, con);
                DataSet ds = new DataSet("products");
                dt.Fill(ds, "product");
                ds.WriteXml(Server.MapPath(@".\catalogue.xml"));

                con.Close();
            }

            Response.Redirect("productPage1.aspx");
        }

        protected void ButtonDelete_Click(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(Request.QueryString["product_id"]);

            SqlConnection con = new
            SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

            {
                con.Open();

                string query = "DELETE FROM Products WHERE Id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, con);

                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);

                    cmd.ExecuteNonQuery();
                }

                // Generate XML file
                string strSQL = "SELECT * FROM Products";
                SqlDataAdapter dt = new SqlDataAdapter(strSQL, con);
                DataSet ds = new DataSet("products");
                dt.Fill(ds, "product");
                ds.WriteXml(Server.MapPath(@".\catalogue.xml"));

                con.Close();
            }

            Response.Redirect("adminCatalog.aspx");
        }
    }

}