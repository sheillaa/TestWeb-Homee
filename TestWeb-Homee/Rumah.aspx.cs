using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;

namespace TestWeb_Homee
{
    public partial class Rumah : System.Web.UI.Page
    {
        #region MySqlConnection Connection and Page Lode
        MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #endregion
        #region Insert Rumah
        /// <summary>
        /// SHEILLA : Add New rumah Action
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                MySqlCommand cmd = new MySqlCommand("INSERT INTO rumah (tipe,alamat,longitude,latitude ) VALUES (@Tipe, @Alamat, @Longitude, @Latitude)", conn);
                cmd.Parameters.AddWithValue("@Tipe", tipe.Text);
                cmd.Parameters.AddWithValue("@Alamat", alamat.Text);
                cmd.Parameters.AddWithValue("@Longitude", longitude.Text);
                cmd.Parameters.AddWithValue("@Latitude", latitude.Text);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                ShowMessage("Registered successfully......!");
            }
            catch (MySqlException ex)
            {
                ShowMessage(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
        #endregion
        
        #region show message
        /// <summary>
        /// This function is used for show message.
        /// </summary>
        /// <param name="msg"></param>
        void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language = 'javascript' > alert('" + msg + "');</ script > ");
        }
        #endregion
    }
}