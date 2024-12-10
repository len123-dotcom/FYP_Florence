using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class forgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string userEmail = txtEmail.Text;
            string newPassword = txtNewPassword.Text;

            if (string.IsNullOrEmpty(userEmail) || string.IsNullOrEmpty(newPassword))
            {
                errMsg.Text = "Both email and new password are required.";
                errMsg.Visible = true;
                return;
            }

            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = "SELECT COUNT(*) FROM userTable WHERE userEmail = @Email";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", userEmail);
                    int count = (int)cmd.ExecuteScalar();

                    if (count > 0)
                    {
                        if (ResetPassword(userEmail, newPassword))
                        {
                            lblPasswordSuccess.Text = "Password successfully reset.";
                            lblPasswordSuccess.Visible = true;
                            lblEmailError.Visible = false;
                        }
                        else
                        {
                            errMsg.Text = "Failed to reset password.";
                            errMsg.Visible = true;
                            //lblEmailError.Visible = false;
                            //lblPasswordSuccess.Visible = false;
                        }
                    }
                    else
                    {
                        lblEmailError.Text = "Email is not registered.";
                        lblEmailError.Visible = true;
                        lblEmailError.ForeColor =System.Drawing.Color.Red;
                    }
                }
            }
        }

        private bool ResetPassword(string email, string newPassword)
        {
            if (string.IsNullOrEmpty(newPassword))
            {
                return false; 
            }

            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = "UPDATE userTable SET userPassword = @NewPassword WHERE userEmail = @Email";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NewPassword", newPassword);
                    cmd.Parameters.AddWithValue("@Email", email);
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string password = args.Value;
            if (password.Length < 8)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}