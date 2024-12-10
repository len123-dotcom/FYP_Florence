using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class performance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTotalRegisteredChart();
                LoadBuyerGenderChart();
                LoadBuyerAgeChart();
                LoadRevenuePerProductChart();
            }
        }

        protected void LoadTotalRegisteredChart()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                // Query to count users by gender
                string query = @"
            SELECT userGender, COUNT(*) AS Total
            FROM userTable
            GROUP BY userGender";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string gender = dr["userGender"].ToString();
                            int total = Convert.ToInt32(dr["Total"]);

                            // Add data point
                            var dataPoint = new DataPoint();
                            dataPoint.SetValueXY(gender, total);

                            // Set color based on gender
                            if (gender.ToLower() == "female")
                            {
                                dataPoint.Color = System.Drawing.Color.Pink;
                            }
                            else if (gender.ToLower() == "male")
                            {
                                dataPoint.Color = System.Drawing.Color.Blue;
                            }

                            TotalRegisteredChart.Series["TotalRegisteredSeries"].Points.Add(dataPoint);
                        }
                    }
                }
            }
        }



        protected void LoadBuyerGenderChart()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = @"
        SELECT u.userGender, COUNT(DISTINCT u.userId) AS Total
        FROM userTable u
        JOIN CustomerOrder o ON u.userID = o.userID
        WHERE u.userType = 'member'
        GROUP BY u.userGender";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string gender = dr["userGender"].ToString();
                            int total = Convert.ToInt32(dr["Total"]);
                            BuyerGenderChart.Series["BuyerGenderSeries"].Points.AddXY(gender, total);
                        }
                    }
                }
            }
        }
        protected void LoadRevenuePerProductChart()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = @"
            SELECT p.product_name, SUM(o.product_quantity * p.product_price) AS TotalRevenue
            FROM CustomerOrder o
            JOIN Products p ON o.product_id = p.Id
            GROUP BY p.Id, p.product_name
            ORDER BY TotalRevenue DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string productName = dr["product_name"].ToString();
                            decimal totalRevenue = Convert.ToDecimal(dr["TotalRevenue"]);

                            var dataPoint = new DataPoint();
                            dataPoint.AxisLabel = productName;
                            dataPoint.YValues = new double[] { (double)totalRevenue };


                            RevenuePerProductChart.Series["RevenuePerProductSeries"].Points.Add(dataPoint);
                        }
                    }
                }
            }
        }

        protected void LoadBuyerAgeChart()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = @"
            SELECT 
                CASE 
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 19 AND 25 THEN '19-25'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
                    ELSE '50+'
                END AS AgeRange,
                COUNT(DISTINCT u.userID) AS Total
            FROM userTable u
            JOIN CustomerOrder o ON u.userID = o.userID
            WHERE u.userType = 'member'
            GROUP BY 
                CASE 
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 0 AND 18 THEN '0-18'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 19 AND 25 THEN '19-25'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
                    WHEN DATEDIFF(YEAR, u.userBirthDate, GETDATE()) BETWEEN 36 AND 50 THEN '36-50'
                    ELSE '50+'
                END
            ORDER BY AgeRange";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string ageRange = dr["AgeRange"].ToString();
                            int total = Convert.ToInt32(dr["Total"]);

                            // Add data point
                            var dataPoint = new DataPoint();
                            dataPoint.SetValueXY(ageRange, total);

                            // Set color based on age range
                            switch (ageRange)
                            {
                                case "0-18":
                                    dataPoint.Color = System.Drawing.Color.Red;
                                    break;
                                case "19-25":
                                    dataPoint.Color = System.Drawing.Color.Blue;
                                    break;
                                case "26-35":
                                    dataPoint.Color = System.Drawing.Color.Green;
                                    break;
                                case "36-50":
                                    dataPoint.Color = System.Drawing.Color.Purple;
                                    break;
                                case "50+":
                                    dataPoint.Color = System.Drawing.Color.Orange;
                                    break;
                            }

                            BuyerAgeChart.Series["BuyerAgeSeries"].Points.Add(dataPoint);
                        }
                    }
                }
            }
        }
    }
}
