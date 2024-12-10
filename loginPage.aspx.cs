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
    public partial class loginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                con.Open();

                SqlCommand cmd = new SqlCommand("select count(*) from userTable where userEmail = '" + logEmail.Text + "' and userPassword = '" + logPass.Text + "'", con);
                int count = Convert.ToInt32(cmd.ExecuteScalar().ToString());

                if (count > 0)
                {
                    SqlCommand cmdType = new SqlCommand("select userName, userType, userID from userTable where userEmail = @email", con);
                    cmdType.Parameters.AddWithValue("@email", logEmail.Text);
                    SqlDataReader dr = cmdType.ExecuteReader();
                    string type = "";
                    string userName = "";
                    string userid = "";
                    while (dr.Read())
                    {
                        type = dr["userType"].ToString().Trim();
                        userName = dr["userName"].ToString().Trim();
                        userid = dr["userID"].ToString().Trim();
                    }
                    Session["userType"] = type;
                    Session["userName"] = userName;
                    Session["userID"] = userid;
                    Session["IsLoggedIn"] = true;


                    Session["IsLoggedIn"] = true;
                    if (type == "admin")
                        Response.Redirect("adminDashboard.aspx");
                    else if (type == "member")
                        Response.Redirect("memberDashboard.aspx");
                        ClientScript.RegisterStartupScript(this.GetType(), "SetUsername", $"setUsername('{userName}', '{type}');", true);
                }
                else
                {
                    errMsg.Visible = true;
                }
                con.Close();
            }
            catch (Exception ex)
            {
                errMsg.Visible = true;
                errMsg.Text = ex.Message;
            }
        }
    }
}