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
    public partial class adminReview : System.Web.UI.Page
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
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT pr.productID, p.product_name, p.product_image, pr.ReviewDate, pr.ReviewText, pr.Rating, pr.userID, u.userName
                    FROM ProductReviews pr
                    JOIN Products p ON pr.productID = p.Id
                    JOIN userTable u ON pr.userID = u.userID
                    ORDER BY pr.ReviewDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
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