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
            var UserID = Membership.GetUser().ProviderUserKey.ToString();
            vcon = new SqlConnection(ConfigurationManager.AppSettings["SqlServer"]);
            vcon.Open();

            SqlCommand cmd = new SqlCommand("SELECT Firstname, LastName FROM Users WHERE UserId = '" + UserID + "'", vcon);//Advised to use parameterized query
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                dr.Close();
                SqlCommand cmd2 = new SqlCommand("UPDATE Users SET Firstname='" + Firstname_TextBox.Text + "', Lastname='" + Lastname_TextBox.Text + "' WHERE UserId = '" + UserID + "'", vcon);//Advised to use parameterized query
                cmd2.ExecuteNonQuery();
            }
            else
            {
                dr.Close();
                SqlCommand cmd2 = new SqlCommand("INSERT INTO Users (UserId, ApplicationId, Firstname, LastName, UserName, IsAnonymous, LastActivityDate) VALUES ('" + UserID + "',NULL,NULL,NULL,false,NOW())", vcon);//Advised to use parameterized query
                cmd2.ExecuteNonQuery();
                BindData();
            }

            SqlCommand cmd3 = new SqlCommand("SELECT address1, address2, NPA, phonenumber, email FROM tccmembership WHERE fkuser = '" + UserID + "'", vcon);//Advised to use parameterized query
            SqlDataReader dr3 = cmd3.ExecuteReader();
            if (dr3.Read())
            {
                dr3.Close();
                SqlCommand cmd2 = new SqlCommand("UPDATE tccmembership SET address1='" + Address1_TextBox.Text + "', address2='" + Address2_TextBox.Text + "', NPA='" + NPA_TextBox.Text + "', phonenumber='" + Phone_TextBox.Text + "', email='" + Email_TextBox.Text + "', approved='' WHERE fkuser = '" + UserID +"'", vcon);//Advised to use parameterized query
                cmd2.ExecuteNonQuery();
            }
            else
            {
                dr3.Close();
                SqlCommand cmd2 = new SqlCommand("INSERT INTO tccmembership (fkuser, address1, address2, NPA, phonenumber, email, approved) VALUES ('"+UserID+"','','','1000','','','')", vcon);//Advised to use parameterized query
                cmd2.ExecuteNonQuery();
                BindData();
            }
            vcon.Close();

            Ville_TextBox.Text = getCity(NPA_TextBox.Text);
        }

        public void BindData()
        {
            var UserID = Membership.GetUser().ProviderUserKey.ToString();
            vcon = new SqlConnection(ConfigurationManager.AppSettings["SqlServer"]);
            vcon.Open();
            SqlCommand cmd = new SqlCommand("SELECT Firstname, LastName, address1, address2, NPA, phonenumber, email FROM Users INNER JOIN tccmembership ON UserId = fkuser WHERE UserId = '" + UserID + "'", vcon);//Advised to use parameterized query
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Firstname_TextBox.Text = dr.GetValue(0).ToString();
                Lastname_TextBox.Text = dr.GetValue(1).ToString();
                Address1_TextBox.Text = dr.GetValue(2).ToString();
                Address2_TextBox.Text = dr.GetValue(3).ToString();
                NPA_TextBox.Text = dr.GetValue(4).ToString();
                Phone_TextBox.Text = dr.GetValue(5).ToString();
                Email_TextBox.Text = dr.GetValue(6).ToString();
                dr.Close();
            }
            vcon.Close();

            Ville_TextBox.Text = getCity(NPA_TextBox.Text);
        }

        public string getCity(string NPA)
        {
            var ville = "";
            vcon = new SqlConnection(ConfigurationManager.AppSettings["SqlServer"]);
            vcon.Open();
            SqlCommand cmd4 = new SqlCommand("SELECT city FROM NPA WHERE NPAVal = '" + NPA + "'", vcon);//Advised to use parameterized query
            SqlDataReader dr4 = cmd4.ExecuteReader();
            if (dr4.Read())
            {
                ville = dr4.GetValue(0).ToString();
                dr4.Close();
            }
            vcon.Close();

            return ville;
        }
    }
}