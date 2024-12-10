using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FYP_Florence
{
    public partial class productPage1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string xmlString = File.ReadAllText(Server.MapPath(@".\catalogue.xml"));
            // Define the contents of the XML control
            Xml1.DocumentContent = xmlString;
            // Specify the XSL file to be used for transformation.
            Xml1.TransformSource = Server.MapPath(@".\catalogue.xsl");
        }
    }
}