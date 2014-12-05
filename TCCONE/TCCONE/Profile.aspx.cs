using System;
using System.Linq;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

namespace TCCONE
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlDataAdapter da;
        DataSet ds = new DataSet();
        SqlCommand cmd = new SqlCommand();
        SqlConnection vcon;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            
        }

        public void BindData()
        {
            vcon = new SqlConnection(ConfigurationManager.AppSettings["SqlServer"]);
            vcon.Open();
            SqlCommand cmd = new SqlCommand("Select Users.UserId, Firstname, LastName, Username, Password from Users, Memberships", vcon);//Advised to use parameterized query
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                TextBox1.Text = dr.GetValue(0).ToString();
                TextBox2.Text = dr.GetValue(1).ToString();
                TextBox3.Text = dr.GetValue(2).ToString();
                TextBox4.Text = dr.GetValue(3).ToString();
                TextBox5.Text = dr.GetValue(4).ToString();
                dr.Close();
            }
             vcon.Close();
        }
    }
}