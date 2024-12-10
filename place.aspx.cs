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
    public partial class place : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    if (Session["SelectedProductIds"] == null)
            //    {
            //        Response.Redirect("cartPage.aspx");
            //    }
            //}
        }

        //protected void LinkButton1_Click(object sender, EventArgs e)
        //{
        //    UpdateOrderPlace("Pick Up");
        //    Response.Redirect("pickupForm.aspx");
        //}

        //protected void LinkButton2_Click(object sender, EventArgs e)
        //{
        //    UpdateOrderPlace("Delivery");
        //    Response.Redirect("checkoutForm.aspx");
        //}

        //private void UpdateOrderPlace(string place)
        //{

        //    Session["OrderPlace"] = place;

        //}
    }
}
        