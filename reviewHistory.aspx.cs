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
    public partial class reviewHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindReviewHistory();
            }
        }
        private void BindReviewHistory()
        {
            int userId = Convert.ToInt32(Session["userID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT pr.productID, p.product_name, p.product_image, pr.ReviewText, pr.ReviewDate, pr.Rating
                    FROM ProductReviews pr
                    JOIN Products p ON pr.productID = p.Id
                    WHERE pr.userID = @userID
                    ORDER BY pr.ReviewDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userID", userId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Load(reader);
                        rptReviewHistory.DataSource = dt;
                        rptReviewHistory.DataBind();
                    }
                }
            }
        }
        protected string GenerateStarImages(object ratingObj)
        {
            int rating = Convert.ToInt32(ratingObj);
            int filledStars = rating;
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