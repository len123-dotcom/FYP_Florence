using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class adminAddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void saveProduct_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(product_name.Text) ||
              string.IsNullOrEmpty(product_description.Text) ||
              string.IsNullOrEmpty(product_quantity.Text) ||
              string.IsNullOrEmpty(product_price.Text))
            {
                errMsg.Text = "Please enter all values!";
                errMsg.Visible = true;
                return;
            }


            if (!FileUpload1.HasFile)
            {
                errMsgEmail.Text = "Please select a file to upload.";
                errMsgEmail.Visible = true;
                return;
            }

            int price;
            if (!int.TryParse(product_price.Text, out price))
            {
                errMsgprice.Text = "Please enter a valid price without commas or dots (e.g., 25000).";
                errMsgprice.Visible = true;
                return;
            }


            string folderPath = Server.MapPath("~/product/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string ImgPath = "";

            string fileExtension = Path.GetExtension(FileUpload1.FileName).ToLower();
            if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png")
            {
                errMsg.Text = "Invalid file format. Please upload an image file (JPEG or PNG).";
                errMsg.Visible = true;
                return;
            }

            ImgPath = FileUpload1.FileName;


            try

            {
                FileUpload1.SaveAs(folderPath + Path.GetFileName(FileUpload1.FileName));
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                con.Open();

                string query = "INSERT INTO Products (product_name, product_price, product_description, product_quantity,product_image) VALUES(@product_name, @product_price, @product_description, @product_quantity,'" + ImgPath + "' )";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@product_name", product_name.Text);
                cmd.Parameters.AddWithValue("@product_price", product_price.Text);
                cmd.Parameters.AddWithValue("@product_description", product_description.Text);
                cmd.Parameters.AddWithValue("@product_quantity", product_quantity.Text);

                cmd.ExecuteNonQuery();
                string strSQL = "SELECT * FROM Products";
                SqlDataAdapter dt = new SqlDataAdapter(strSQL, con);

                DataSet ds = new DataSet("products");

                dt.Fill(ds, "product");

                ds.WriteXml(Server.MapPath(@".\catalogue.xml"));

                con.Close();
                Response.Redirect("productPage1.aspx");
            }
            catch (Exception ex)
            {

                Response.Write("Error: " + ex.ToString());
                errMsg.Visible = true;
                errMsg.Text = ex.Message;

            }

        }
    }
}