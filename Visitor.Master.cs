using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class Visitor : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["IsLoggedIn"] != null && Convert.ToBoolean(Session["IsLoggedIn"]))
                {
                    string userName = Session["userName"].ToString();
                    string userType = Session["userType"].ToString();
                    btnLogin.Visible = false;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SetUsername", $"setUsername('{userName}', '{userType}');", true);
                }
            }
        }



        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("loginPage.aspx");
        }
    }
}