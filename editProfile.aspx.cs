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
    public partial class editProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userName"] != null)
                {
                    int userId = GetUserIdFromSession();

                    SqlConnection con = new
                    SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                    {
                        con.Open();

                        string query = "SELECT userName, userEmail, userBirthDate, userPassword, userGender FROM userTable WHERE userID = @userId";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@userId", userId);

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                DataRow row = dt.Rows[0];
                                editName.Text = row["userName"].ToString();
                                editEmail.Text = row["userEmail"].ToString();
                                DateTime birthDate = Convert.ToDateTime(row["userBirthDate"]);
                                editBirthDate.Text = birthDate.ToString("yyyy-MM-dd");
                                editPass.Text = row["userPassword"].ToString();

                                string gender = row["userGender"].ToString();
                                if (gender == "MALE")
                                {
                                    editGender.SelectedValue = "MALE";
                                }
                                else if (gender == "FEMALE")
                                {
                                    editGender.SelectedValue = "FEMALE";
                                }

                            }
                        }
                    }
                }
                else
                {
                    Response.Redirect("loginPage.aspx");
                }
            }
        }
        protected void BirthDateValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (string.IsNullOrEmpty(args.Value))
            {
                args.IsValid = false;
                return;
            }

            DateTime birthDate;
            if (DateTime.TryParse(args.Value, out birthDate))
            {
                int age = DateTime.Now.Year - birthDate.Year;
                if (birthDate > DateTime.Now.AddYears(-age))
                {
                    age--;
                }
                args.IsValid = (age >= 17);
            }
            else
            {
                args.IsValid = false;
            }
        }

        private int GetUserIdFromSession()
        {
            if (Session["UserId"] != null)
            {
                return Convert.ToInt32(Session["UserId"]);
            }
            else
            {
                Response.Redirect("loginPage.aspx");
                return -1; //indicate that the user ID could not be retrieved
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                int userId = GetUserIdFromSession();
                string updatedUserName = editName.Text;
                string updatedUserEmail = editEmail.Text;
                string updatedUserBirthDate = editBirthDate.Text;
                string updatedUserPass = editPass.Text;
                string updatedUserGender = editGender.SelectedValue;

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                {
                    con.Open();
                    string query = "UPDATE UserTable SET userName = @UserName, userEmail = @UserEmail, userBirthDate = @UserBirthDate, userPassword = @UserPass, userGender = @UserGender WHERE userID = @UserId";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@UserName", updatedUserName);
                    cmd.Parameters.AddWithValue("@UserEmail", updatedUserEmail);
                    cmd.Parameters.AddWithValue("@UserBirthDate", updatedUserBirthDate);
                    cmd.Parameters.AddWithValue("@UserPass", updatedUserPass);
                    cmd.Parameters.AddWithValue("@UserGender", updatedUserGender);
                    cmd.ExecuteNonQuery();
                }
                Response.Redirect("memberDashboard.aspx");
            }
            else
            {
                return;
            }
        }
        protected void PasswordValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = (args.Value.Length >= 8);
        }
    }
}