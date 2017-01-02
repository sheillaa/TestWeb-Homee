using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using MySql.Data.MySqlClient;
using System.Data;
using System.Web.Script.Serialization;

namespace TestWeb_Homee
{
    public partial class Detail : System.Web.UI.Page
    {

        
        #region MySqlConnection Connection and Page Lode
        MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        #endregion
        protected string[] pinLat;
        protected string[] pinLong;

        public static class JavaScript
        {
            public static string Serialize(object o)
            {
                JavaScriptSerializer js = new JavaScriptSerializer();
                return js.Serialize(o);
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            getLongLat();
        }
        

        #region get all data long lat
        private void getLongLat()
        {
            try{
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                MySqlCommand cmd = new MySqlCommand("SELECT longitude, latitude FROM rumah;",conn);
                MySqlDataReader mdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

                // create a list to hold the results in
                List<string> longi = new List<string>();
                List < string > lat = new List<string>();
                while (mdr.Read())
                {
                    // for each row read a string and add it in
                    longi.Add(mdr.GetString(0));
                    lat.Add(mdr.GetString(1));
                }
                pinLong = longi.ToArray();
                pinLat = lat.ToArray();
                
            }
            catch (MySqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            finally
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }
        #endregion
    }
}