using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Data;

namespace TestWeb_Homee
{
    public partial class Rumah : System.Web.UI.Page
    {
        #region MySqlConnection Connection and Page Lode
        MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        #endregion

        protected string[] kota;

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
            kota = new string[10] { "Ambon", "Bandung", "Bogor","Bekasi", "Cianjur", "Denpasar", "Garut","Jayapura","Kupang","Liwa"};
            tipe.Items.Add("36");
            tipe.Items.Add("45");
            tipe.Items.Add("72");
            try
            {
                if (!Page.IsPostBack)
                {
                    BindGrid();

                }
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }
        }
        
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
                cmd.Parameters.AddWithValue("@Tipe", tipe.SelectedValue);
                cmd.Parameters.AddWithValue("@Alamat", alamat.Text);
                cmd.Parameters.AddWithValue("@Longitude", longitude.Text);
                cmd.Parameters.AddWithValue("@Latitude", latitude.Text);
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                ShowMessage("Data berhasil disimpan !");
                clear();
                BindGrid();
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

        #region bind data to GridListRumah
        private void BindGrid()
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                }
                MySqlCommand cmd = new MySqlCommand("SELECT * FROM rumah ORDER BY id ASC;",
conn);
                MySqlDataAdapter adp = new MySqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adp.Fill(ds);
                GridListRumah.DataSource = ds;
                GridListRumah.DataBind();
            }
            catch (MySqlException ex)
            {
                ShowMessage(ex.Message);
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
        #region show message
        /// <summary>
        /// This function is used for show message.
        /// </summary>
        /// <param name="msg"></param>
        void ShowMessage(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('"+ msg +"')", true);
        }
        #endregion

        #region clear method
        void clear()
        {
            tipe.SelectedIndex = 0;
            alamat.Text = string.Empty;
            longitude.Text = string.Empty;
            latitude.Text = string.Empty;
        }
        #endregion
    }
}