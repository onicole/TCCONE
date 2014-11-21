using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TCCONE
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string Welcome()
        {
            string message = "";

            if (System.DateTime.Now.Hour < 18)
            {
                message="Bonjour";
            }
            else
            {
                message="Bonsoir";
            }

            return message;
        }
    }

}