using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class adminRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                {
                    return;
                }

                if (string.IsNullOrEmpty(regName.Text) || string.IsNullOrEmpty(regEmail.Text) || string.IsNullOrEmpty(regPass.Value) || string.IsNullOrEmpty(confirmPass.Value))
                {
                    errMsg.Text = "All fields are required!";
                    errMsg.Visible = true;
                }
                else
                {
                    
                    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                    con.Open();
                    string query = "select count(*) from userTable where userName = '" + regName.Text + "'";
                    string query2 = "select count(*) from userTable where userEmail = '" + regEmail.Text + "'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlCommand cmd2 = new SqlCommand(query2, con);
                    int check1 = Convert.ToInt32(cmd.ExecuteScalar().ToString());
                    int check2 = Convert.ToInt32(cmd2.ExecuteScalar().ToString());
                    if (check1 > 0)
                    {
                        errMsg.Text = "The username already exists. Please choose a different username!";
                        errMsg.Visible = true;
                    }
                    else if (check2 > 0)
                    {
                        errMsg.Text = "The email already exists. Please choose a different email!";
                        errMsg.Visible = true;
                    }
                    else
                    {
                        string query1 = "insert into userTable (userName, userEmail, userPassword, userType) values (@name, @email, @password, @usertype) ";
                        SqlCommand cmd1 = new SqlCommand(query1, con);
                        cmd1.Parameters.AddWithValue("@name", regName.Text);
                        cmd1.Parameters.AddWithValue("@email", regEmail.Text);
                        cmd1.Parameters.AddWithValue("@password", regPass.Value);
                        cmd1.Parameters.AddWithValue("@usertype", "admin");
                        cmd1.ExecuteNonQuery();
                        //Response.Redirect("loginPage.aspx");
                    }
                    con.Close();
                }

            }
            catch (Exception ex)
            {
                errMsg.Visible = true;
                errMsg.Text = ex.Message;
            }

        }


        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value.Length < 8)
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