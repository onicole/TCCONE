using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace TCCONE
{
    public partial class Courts : System.Web.UI.Page
    {
        string[] days = { "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche" };

        protected string path_file = System.Web.Hosting.HostingEnvironment.MapPath("~/Content/res.txt");

        protected string[,] schedule = { 
                                {"","Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"},
                                {"08:00","","","","","","",""},
                                {"09:00","","","","","","",""},
                                {"10:00","","","","","","",""},
                                {"11:00","","","","","","",""},
                                {"12:00","","","","","","",""},
                                {"13:00","","","","","","",""},
                                {"14:00","","","","","","",""},
                                {"15:00","","","","","","",""},
                                {"16:00","","","","","","",""},
                                {"17:00","","","","","","",""},
                                {"18:00","","","","","","",""},
                                {"19:00","","","","","","",""},
                                {"20:00","","","","","","",""},
                                {"21:00","","","","","","",""}
                            };

        protected void Page_Load(object sender, EventArgs e)
        {
            File_Load();
            RefreshTable();
        }

        protected void File_Load()
        {
            var reader = new StreamReader(path_file);
            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();
                var values = line.Split('\t');

                Edit_Schedule(values[1],values[0],values[2]);
            }
        }

        protected string Get_Schedule(string hour, string day)
        {
            int index1 = Convert.ToInt32(hour);
            int index2 = Array.IndexOf(days, day);

            return schedule[index1 - 7, index2 + 1];
        }

        protected void Edit_Schedule(string hour, string day, string name)
        {
            int index1 = Convert.ToInt32(hour);
            int index2 = Array.IndexOf(days, day);

            schedule[index1 - 7, index2 + 1] = name;
        }

        protected void RefreshTable()
        {
            int i, j;

            tblLanguages.Rows.Clear();

            for (i = 0; i < 15; i++)
            {
                TableRow row = new TableRow();

                for (j = 0; j < 8; j++)
                {
                    TableCell cell = new TableCell();
                    cell.Text = schedule[i, j];
                    row.Cells.Add(cell);
                }

                tblLanguages.Rows.Add(row);
            }
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            if (Hour.Text == "" || Day.Text == "" || Name.Text == "")
            {
                messageText.InnerText = "Un des champs semble vide ! veuillez tout remplir avant d'ajouter";
            }
            else
            {
                if(Get_Schedule(Hour.Text, Day.Text) != "")
                {
                    messageText.InnerText = "Désolé, le court est déjà réservé ce jour à cette heure";
                }
                else
                {
                    Edit_Schedule(Hour.Text, Day.Text, Name.Text);
                    Hour.Text = "";
                    Day.Text = "";
                    Name.Text = "";
                    RefreshTable();
                }
            }
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            if (Hour.Text == "" || Day.Text == "" || Name.Text == "")
            {
                messageText.InnerText = "Un des champs semble vide ! veuillez tout remplir avant d'ajouter";
            }
            else
            {
                if (Get_Schedule(Hour.Text, Day.Text) != Name.Text)
                {
                    messageText.InnerText = "Le nom ne correspond pas à la réservation !";
                } 
                else 
                {
                    Edit_Schedule(Hour.Text, Day.Text, "");
                    Hour.Text = "";
                    Day.Text = "";
                    Name.Text = "";
                    RefreshTable();
                }
            }
        }
    }
}